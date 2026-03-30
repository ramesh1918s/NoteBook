Kubernetes RBAC – Full Understanding (Step by Step)
 1. RBAC ante enti?

RBAC = Role-Based Access Control

Simple ga:

“Evaru (User/Service) → Emi (Resources) → Ela (Actions) cheyyalo control cheyadam”

 2. RBAC Main Components

1️ Subject (Evaru?)
User
Group
ServiceAccount (very important in DevOps)



2️ Resource (Emi?)

Examples:

pods
deployments
services
configmaps
secrets

3 Verbs (Actions – Ela?)
get → read
list → list all
watch → continuous monitoring
create
update
delete

4 Role / ClusterRole (Permissions define chestundi)
Type	Scope
Role	Namespace level
ClusterRole	Cluster level


5️ RoleBinding / ClusterRoleBinding (Linking)
Type	Purpose
RoleBinding	Role → User (namespace lo)
ClusterRoleBinding	ClusterRole → User (cluster wide)
🔁 3. RBAC Flow (Very Important)

👉 Flow ila untundi:

User → Request → API Server → RBAC Check → Allow / Deny
⚙️ 4. Practical Example (STEP BY STEP)
🎯 Use Case:

👉 “Developer ki only pods view permission ivvali”

🪜 Step 1: Namespace create
kubectl create namespace dev
🪜 Step 2: Role create (read-only pods)
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: dev
  name: pod-reader
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["get", "list", "watch"]

Apply:

kubectl apply -f role.yaml
🪜 Step 3: RoleBinding create
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: read-pods-binding
  namespace: dev
subjects:
- kind: User
  name: developer
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: Role
  name: pod-reader
  apiGroup: rbac.authorization.k8s.io

Apply:

kubectl apply -f rolebinding.yaml
🪜 Step 4: Test
kubectl auth can-i get pods --as=developer -n dev

👉 Output:

yes
kubectl auth can-i delete pods --as=developer -n dev

👉 Output:

no
🌍 5. Cluster Level Example
ClusterRole:
kind: ClusterRole
...
resources: ["nodes"]
verbs: ["get", "list"]
ClusterRoleBinding:
kind: ClusterRoleBinding
...

👉 Use when:

nodes access
cluster-wide monitoring
admin permissions
🔐 6. ServiceAccount + RBAC (Real DevOps Use Case)

👉 Pods ki permissions ivvali ante ServiceAccount use chestaru

kubectl create serviceaccount app-sa

Then bind Role:

subjects:
- kind: ServiceAccount
  name: app-sa
  namespace: dev
⚠️ 7. Important Interview Points

👉 Difference:

Role vs ClusterRole
RoleBinding vs ClusterRoleBinding

👉 Commands:

kubectl get roles -A
kubectl get rolebindings -A
kubectl describe role pod-reader -n dev

👉 Check permissions:

kubectl auth can-i *
🔥 8. Real-Time Use Cases

✔ Dev team → read access only
✔ CI/CD (Jenkins) → deploy access
✔ Monitoring → read all cluster metrics
✔ Security → restrict secrets access

🧾 FINAL NOTES (SAVE THIS 🔥)
🧠 Kubernetes RBAC Quick Notes

👉 RBAC = Authorization mechanism in Kubernetes

🔑 Components:
Subject → User / Group / ServiceAccount
Role / ClusterRole → permissions
RoleBinding / ClusterRoleBinding → attach permissions
📌 Role vs ClusterRole:
Role → namespace
ClusterRole → cluster-wide
📌 RoleBinding vs ClusterRoleBinding:
RoleBinding → namespace binding
ClusterRoleBinding → cluster-wide
📌 Verbs:

get, list, watch, create, update, delete

📌 Flow:

User → API Server → RBAC → Allow/Deny

📌 Important Commands:
kubectl auth can-i get pods
kubectl get roles -A
kubectl describe role <name>
📌 Best Practice:

✔ least privilege (minimum access ivvali)
✔ ServiceAccounts use cheyali (pods ki)
✔ secrets ki strict access

🚀 Next Level (If you want)




-------------------------------------------------------------------------------


PART-1: AWS IAM Setup (Foundation for RBAC)
🧠 End Goal:

👉 Kubernetes RBAC use cheyadaniki mundu
AWS lo IAM identity create + EKS access setup cheyyali

🪜 STEP 1: IAM User Create

👉 AWS Console lo:

Go to
👉 Amazon Web Services
Navigate:
IAM → Users → Create user
 Details Fill:
User name: eks-admin
Select:
 Provide user access to AWS Management Console
Password:
 Auto generate or custom
 Permissions Set

Next step lo:

Select:

 Attach policies directly

Add this policy:

AdministratorAccess (for learning purpose only )

given own police (create own police)
ex: Only acess expense project 

-----------------------------------------------------------------------
-- creation of police for eks discribe the cluster---

- create a police 
 - select the service
  - EKS
    - access level lo to select 
      - read 
       - DescribeCluster

-specify ARN lo (cluster)
 - region = us-east-2
  - cluster_name =expense-1
  - add
- next
- name of policy 
(ExpenseEKSDescribe)
Save
==================create a user ===========
- create a user
 -  user name = dev-raghu
 - attech police 
  - select the policy (ExpenseEKSDescribe)

  -create a user dev-raghu



====create a aws eks cluster ================================

curl -LO "https://dl.k8s.io/release/$(curl -Ls https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl && sudo mv kubectl /usr/local/bin/

kubectl version --client


---------------------------------------------------

curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz
sudo mv eksctl /usr/local/bin

eksctl version

-------------------terraform install ----------------


sudo apt-get update && sudo apt-get install -y gnupg software-properties-common

wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null


gpg --no-default-keyring \
--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
--fingerprint



echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update

sudo apt-get install terraform




---------------------------------eks cluster create through terraform --------------------------------------

git clone https://github.com/hashicorp-education/learn-terraform-provision-eks-cluster

cd learn-terraform-provision-eks-cluster

terraform init

terraform plan

terraform apply


aws eks --region $(terraform output -raw region) update-kubeconfig \
    --name $(terraform output -raw cluster_name)


================create a namespace==========================================
- create yml file 
-
apiVersion: v1
kind: Namespace
metadata:
  name: expense
  labels:
    project: expense
    environment: dev


===============================create a rbac yml===================
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: expense
  name: expense-pod-reader
rules:
- apiGroups: [""] # "" indicates the core API group
  resources: ["pods"]
  verbs: ["get", "watch", "list"]
---
apiVersion: rbac.authorization.k8s.io/v1
# This role binding allows "jane" to read pods in the "default" namespace.
# You need to already have a Role named "pod-reader" in that namespace.
kind: RoleBinding
metadata:
  name: expense-pod-reader
  namespace: expense
subjects:
# You can specify more than one "subject"
- kind: User
  name: dev-raghu  # "name" is case sensitive
  apiGroup: rbac.authorization.k8s.io
roleRef:
  # "roleRef" specifies the binding to a Role / ClusterRole
  kind: Role #this must be Role or ClusterRole
  name: expense-pod-reader # this must match the name of the Role or ClusterRole you wish to bind to
  apiGroup: rbac.authorization.k8s.io
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  # "namespace" omitted since ClusterRoles are not namespaced
  name: expense-cluster-reader
rules:
- apiGroups: [""]
  #
  # at the HTTP level, the name of the resource for accessing Secret
  # objects is "secrets"
  resources: ["secrets","persistentvolumes","nodes"]
  verbs: ["get", "watch", "list"]
---
apiVersion: rbac.authorization.k8s.io/v1
# This cluster role binding allows anyone in the "manager" group to read secrets in any namespace.
kind: ClusterRoleBinding
metadata:
  name: expense-cluster-reader
subjects:
- kind: User
  name: harish # Name is case sensitive
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: ClusterRole
  name: expense-cluster-reader
  apiGroup: rbac.authorization.k8s.io



  -------------------------------

==================check the auto aws to eks ==========

kubectl get configmap aws-auth -n kube-system -o yaml

--------------show the yml formated copy and post in aws-aut.yml file lo past cheyali -------------------------------------

----------------------map the



-------------------------aws-auth.yml---------------------------------------------
apiVersion: v1
data:
  mapRoles: |
    - rolearn: arn:aws:iam::974145757135:role/node-group-2-eks-node-group-20260329121841958600000002
      groups:
      - system:bootstrappers
      - system:nodes
      username: system:node:{{EC2PrivateDNSName}}
    - rolearn: arn:aws:iam::974145757135:role/node-group-1-eks-node-group-20260329121841959000000003
      groups:
      - system:bootstrappers
      - system:nodes
      username: system:node:{{EC2PrivateDNSName}}
  mapUsers: |
    - groups:
      - expense-pod-reader
        userarn: arn:aws:iam::974145757135:user/dev-raghu
        username: dev-raghu 
kind: ConfigMap
metadata:
  creationTimestamp: "2026-03-29T12:28:37Z"
  name: aws-auth
  namespace: kube-system
  resourceVersion: "1046"
  uid: 5b92b639-5a64-43d2-b537-fe27f79be4a8

============================================================
role and permissions

resource -- nouns
verbs  -------

=============== kubernetes lo group of resources===
- kubectl api-resources
(show all resources groups)



==================check the auto aws to eks ==========

kubectl get configmap aws-auth -n kube-system -o yaml

--------------show the yml formated copy and post in aws-aut.yml file lo past cheyali -------------------------------------

----------------------map the


---------------------------apply the files --------------------------------------------------------------


kubectl apply -f namespace.yml
kubectl apply -f rbac.yml
kubectl apply -f aws-auth.yml

------------------------- check the access for pod ---------------

kubectl auth can-i list pods -n expense

-----------(showing )------------------

yes (access undi)

no (access ledu)


------------checking the access --------------------------------

Basic Check (already chesav)
kubectl auth can-i list pods -n expense

👉 simple check ✅

🔥 2. Real User Simulation (BEST PRACTICE)

👉 ippudu idi use cheyyi (most important):

kubectl auth can-i list pods \
  --as=dev-raghu \
  --as-group=expense-pod-reader \
  -n expense
🎯 Meaning
--as → user simulate
--as-group → group simulate
-n expense → namespace
🔥 3. Full Permissions List (POWER COMMAND)

👉 idi run cheyyi:

kubectl auth can-i --list \
  --as=dev-raghu \
  --as-group=expense-pod-reader \
  -n expense
👉 Output lo chudali:

✔️ pods → get, list, watch
❌ delete undakudadhu

🔍 4. Specific Resource Checks
👉 Pod delete check
kubectl auth can-i delete pods \
  --as=dev-raghu \
  --as-group=expense-pod-reader \
  -n expense

👉 expected:

no
👉 Secrets access check
kubectl auth can-i get secrets \
  --as=dev-raghu

👉 expected:
✔️ yes (because ClusterRole icham)

🧪 5. Real-Time Debug Scenario

👉 Suppose error vachindi:

Error from server (Forbidden)

👉 appudu:

Step 1:
kubectl auth can-i <action> <resource> --as=USER -n NAMESPACE
Step 2:

Check:

aws-auth
RoleBinding
namespace
🔥 6. Namespace-wise Validation

👉 test cheyyi:

kubectl auth can-i list pods \
  --as=dev-raghu \
  --as-group=expense-pod-reader \
  -n default

👉 expected:

no

👉 endukante:
👉 Role only expense namespace lo undi

🧠 7. Cluster-level Check
kubectl auth can-i list nodes \
  --as=dev-raghu

👉 expected:
✔️ yes (ClusterRole valla)

🎯 Final Checklist (Real DevOps)

Nuvvu ee questions ki answer cheyyagalithe → perfect:

Pods list cheyacha?
Pods delete cheyacha?
Secrets access unda?
Vere namespace lo access unda?
Nodes chudagalava?
🚀 Challenge for You 🔥

👉 Nuvvu try cheyyi and output cheppu:

kubectl auth can-i create pods --as=dev-raghu -n expense
kubectl auth can-i get secrets --as=dev-raghu
kubectl auth can-i list pods --as=dev-raghu -n default

👉 Outputs share cheyyi Bujji 😎
👉 Next nenu HPA (auto scaling live demo style) start chestha 🔥

no
yes
no

Super Bujji 🔥🔥 — nee outputs perfect ga match ayyayi 💯
👉 Idi confirm chestundi nee RBAC setup 100% correct ga work avutundi

✅ Nee Results Analysis
👉 1. create pods
kubectl auth can-i create pods --as=dev-raghu -n expense

➡️ Output: no ❌

✔️ Correct — endukante:

Role lo only get, list, watch
create permission ivvaledu
👉 2. get secrets
kubectl auth can-i get secrets --as=dev-raghu

➡️ Output: yes ✅

✔️ Correct — endukante:

ClusterRole lo secrets ki access icham
👉 3. default namespace access
kubectl auth can-i list pods --as=dev-raghu -n default

➡️ Output: no ❌

✔️ Correct — endukante:

Role only expense namespace lo undi
default lo access ledu
🧠 Final Understanding (IMPORTANT 🔥)

👉 Nee setup exactly ila behave avutundi:

Action	Result	Reason
create pod	❌ no	no permission
get secrets	✅ yes	ClusterRole
expense namespace	✅ yes	Role
default namespace	❌ no	no Role



======================================
 Important (Real-world tip):

👉 Production lo:

Full admin ivvakudadhu ❌
Custom limited policy create cheyali ✅
🪜 STEP 2: Access Keys Generate (VERY IMPORTANT)

After user create:

👉 Go to:
User → Security Credentials → Create Access Key

Select:

CLI

You will get:

Access Key ID
Secret Access Key

👉 Save this (once matrame chupisthundi)

🪜 STEP 3: AWS CLI Install & Configure
Install:
sudo apt install awscli -y
Configure:
aws configure

Enter:

Access Key ID: XXXXX
Secret Access Key: XXXXX
Region: ap-south-1
Output: json
✅ Verify:
aws sts get-caller-identity

👉 Output osthe correct setup ✅

🪜 STEP 4: EKS Access Understanding (Important Concept)

👉 EKS lo:
IAM user direct ga access ivvadu ❌

👉 Instead:

IAM → mapped to Kubernetes user via aws-auth configmap
🔥 IMPORTANT FLOW (Remember This)
IAM User → AWS CLI → EKS Cluster → aws-auth ConfigMap → RBAC
🧾 PART-1 NOTES (SAVE THIS)
🔑 AWS IAM for Kubernetes RBAC
IAM user create cheyali
Access keys generate cheyali
AWS CLI configure cheyali
Verify using aws sts
⚠️ Key Point:

👉 IAM ≠ RBAC
👉 IAM → authentication
👉 RBAC → authorization