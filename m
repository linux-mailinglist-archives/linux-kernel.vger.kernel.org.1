Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF992A5E1C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 07:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbgKDG0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 01:26:54 -0500
Received: from mail-mw2nam10on2045.outbound.protection.outlook.com ([40.107.94.45]:59296
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728415AbgKDG0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 01:26:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eP1rYlrf1d20I+bSX7TyN56nst7CKN/dQEBsq5NeRQ+Fhl42WOc9+3cO40F/GCNHj2kx1/36sfubmFXqo+cOqbUTtQKIfl0Wgl7NxPakfTs7LLc3uE/FB0yVRfc7m4ngqZcEL2zKDnyYlxrLx9Ls/JC42z/F25tXFoGcef7bA5JQf7fycwlDtVbzYIbpGkDAO3bTD2gU9hnkO1UTn91gQg6Wzo1afcADAoqe5B5VxPrKxb6OlPhV0cxp6E3VkjqXbbr0WzhdfC2KTzEu3q2fFtTDzi1SBPiTlFULnBBdGAtqqpptNvKMBD2fJkvF1TKNV4opOl4tGv93qsy+OqLiiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jo8CUzQa+cyUSXEMT3ymnBUbi66MoU8cjNNe5lxtYwM=;
 b=Us7+kYGpky5V6+z3MhIuEZtDMFIwXoi0aqrgCryplalN9v6hcU7/+bfCGt9Y9K8UoK3WnRMnu0UD1yughKFY9EM6nyZKBY0yA6ZeM2XsNROF/H1PRrTyJvcO6sL77KxDOhR4eQLi+fVSy2l+YSU4qevoV5T3RMQivqrBaWwEmq4UDQGmWDGlYPE4EiiCPedOLcUpBUiwV/TSHFdbE1UJlinBcKZ4r4ME2JOqJqJuOiHK+/xYpvDciFP/svxb18MM0CcpzcLKDtJpxc0Wp/xRW6vDE0+rMI1sbQwYUvPmzDJURPpaZUyQYALg7jxgERR3Z0bM6MamxdHVVyJMhipcnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jo8CUzQa+cyUSXEMT3ymnBUbi66MoU8cjNNe5lxtYwM=;
 b=MyRIdZvOEXnVE5iuoOIf/LNRFffFsfHNj/fJMhqJr62cstWFP8j0Or7se57AoQZblVOV0oCwiCj9oroxvP6iPbOgVJHrLURTuAw1VWNq4o1A9esYGue1wHFFN1Sv9CrpGa1suXwkNLDiOSevBvMtH/QCAqy7j7m/REwwMJt2tH8=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4719.namprd12.prod.outlook.com (2603:10b6:805:e9::25)
 by SN1PR12MB2398.namprd12.prod.outlook.com (2603:10b6:802:26::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19; Wed, 4 Nov
 2020 06:26:50 +0000
Received: from SN6PR12MB4719.namprd12.prod.outlook.com
 ([fe80::7cc5:ed9c:dece:6d74]) by SN6PR12MB4719.namprd12.prod.outlook.com
 ([fe80::7cc5:ed9c:dece:6d74%7]) with mapi id 15.20.3499.030; Wed, 4 Nov 2020
 06:26:50 +0000
From:   Rijo Thomas <Rijo-john.Thomas@amd.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Rijo Thomas <Rijo-john.Thomas@amd.com>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] tee: amdtee: fix memory leak due to reset of global shm list
Date:   Wed,  4 Nov 2020 11:56:09 +0530
Message-Id: <86891b29257dbf36aae3b9cfdec75dca3b5273f0.1604470183.git.Rijo-john.Thomas@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1604470183.git.Rijo-john.Thomas@amd.com>
References: <cover.1604470183.git.Rijo-john.Thomas@amd.com>
Content-Type: text/plain
X-Originating-IP: [165.204.156.251]
X-ClientProxiedBy: MAXPR01CA0081.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:49::23) To SN6PR12MB4719.namprd12.prod.outlook.com
 (2603:10b6:805:e9::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from andbang6.amd.com (165.204.156.251) by MAXPR01CA0081.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:49::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Wed, 4 Nov 2020 06:26:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0b2343b6-c7fe-4154-b556-08d8808a9d36
X-MS-TrafficTypeDiagnostic: SN1PR12MB2398:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB23982823E1BFA4EDD8DFB96ECFEF0@SN1PR12MB2398.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rqoQJ4T7zEy65VUm6WoXA/ssdUcj+EWKytT9saJyY5gm1icTIKzJ8pribxEQsxmc1SA1EEyzMIuY5xutB1/ClvkQ3VhrMAuvFzij8eMGSHzaNHS0SJ9T4IMrazgNSxqudnUbi+jhh4OkllyK3AVybiZcaXBaB6exOoD05JEJCsVzDnazk5QuRBxnGdxuiP/Zuw5lQGxl2MGqfkoxbjzZQFaMWxdDWqb3xGJfATZ2vwZfH3/qzJm3fPiIO9Oj8+27bS4U2Ki+uHcuHf5ZozNFRFNF9GiW2YcS8hvTJCjhE1h1F+d+Z/m7bwrjydNsEBQs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4719.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(346002)(376002)(39860400002)(6916009)(478600001)(86362001)(52116002)(2906002)(7696005)(4326008)(5660300002)(316002)(54906003)(36756003)(186003)(6486002)(8936002)(66476007)(66946007)(66556008)(83380400001)(8676002)(2616005)(956004)(26005)(16526019)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: RE6KR5iocOxkAOBgR1gU0L7aeY3Shk4MYh+eUqriQhljOFrUpKyXLYAq6zmfG78jxM6kYmHib4MXSNJ0H++WCbTV4yhDJuDj7fJJWLhtpOfVbqaQs8fVaVNr1XJ55GvEwFZFGfH8ex6yq4iBfnpXY7k4Q2p1jqr+4/OqgtkTL2yg1j8/nx87NlCyNurK6YJX6rANI2F8asROCEZdaWnDCJwcrwBV/3c3r5HVeWIRE+RY8t4W0oWe8VL3gjpUVojxROepAFM7shGsv/uhrInAT9EVMg/sXAyk9Sa1vynVtRug1fFw2E3Xytz7u8t1Eaq9mnbDZcYbFrGDBEERfQZqULAr06WWG4Fejdrg9OBfvKYWvOxN4UYuumfOxbCgkrlWcvL3aRPcBgx+IruBHMg+mR4E28LsEkvjwe2AHLbQC/ACCn/CQGksHXOdd+qz19OqJDOpsOAIxKals6oV2XZO5auHt3ixcycHb3ZMliRbpYEv+c0Gw8982wMgGkTpeiMIytBhKN/yYp/3afZBcanFK+CLp8SjDkDtSt8fwKlYLUV/JFfgWzYlsOeXXojCUQRP98J9AvpEl2M5DGrLr8HRnHTEJ8eyffunRyfqsgaymhS+Dq7Vy3PTpsCPpBFEryqKfPuWGL2lsG2/jZ8Zzg5WJQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b2343b6-c7fe-4154-b556-08d8808a9d36
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4719.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2020 06:26:50.5832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gAprJaOD97aWEhUFpBiYJ6WfBlgUGDyjn069g/ZCYj+uun2xIlgkuIfsF89U5wr24d5pHV8DK0RCPz8tJ6CzjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2398
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver maintains a list of shared memory buffers along with their
mapped buffer id's in a global linked list. These buffers need to be
unmapped after use by the user-space client.

The global shared memory list is initialized to zero entries in the
function amdtee_open(). This clearing of list entries can be a source
for memory leak on secure side if the global linked list previously
held some mapped buffer entries allocated from another TEE context.

Fix potential memory leak issue by moving global shared memory list
to AMD-TEE driver context data structure.

Fixes: 757cc3e9ff1d ("tee: add AMD-TEE driver")
Reviewed-by: Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>
Signed-off-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
---
 drivers/tee/amdtee/amdtee_private.h |  7 +++----
 drivers/tee/amdtee/core.c           | 18 +++++++++++-------
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/tee/amdtee/amdtee_private.h b/drivers/tee/amdtee/amdtee_private.h
index d7f798c3394b..97df16a17285 100644
--- a/drivers/tee/amdtee/amdtee_private.h
+++ b/drivers/tee/amdtee/amdtee_private.h
@@ -64,9 +64,12 @@ struct amdtee_session {
 /**
  * struct amdtee_context_data - AMD-TEE driver context data
  * @sess_list:    Keeps track of sessions opened in current TEE context
+ * @shm_list:     Keeps track of buffers allocated and mapped in current TEE
+ *                context
  */
 struct amdtee_context_data {
 	struct list_head sess_list;
+	struct list_head shm_list;
 };
 
 struct amdtee_driver_data {
@@ -89,10 +92,6 @@ struct amdtee_shm_data {
 	u32     buf_id;
 };
 
-struct amdtee_shm_context {
-	struct list_head shmdata_list;
-};
-
 #define LOWER_TWO_BYTE_MASK	0x0000FFFF
 
 /**
diff --git a/drivers/tee/amdtee/core.c b/drivers/tee/amdtee/core.c
index 27b4cd77d0db..ce61c68ec58c 100644
--- a/drivers/tee/amdtee/core.c
+++ b/drivers/tee/amdtee/core.c
@@ -20,7 +20,6 @@
 
 static struct amdtee_driver_data *drv_data;
 static DEFINE_MUTEX(session_list_mutex);
-static struct amdtee_shm_context shmctx;
 
 static void amdtee_get_version(struct tee_device *teedev,
 			       struct tee_ioctl_version_data *vers)
@@ -42,7 +41,7 @@ static int amdtee_open(struct tee_context *ctx)
 		return -ENOMEM;
 
 	INIT_LIST_HEAD(&ctxdata->sess_list);
-	INIT_LIST_HEAD(&shmctx.shmdata_list);
+	INIT_LIST_HEAD(&ctxdata->shm_list);
 
 	ctx->data = ctxdata;
 	return 0;
@@ -152,10 +151,11 @@ static struct amdtee_session *find_session(struct amdtee_context_data *ctxdata,
 
 u32 get_buffer_id(struct tee_shm *shm)
 {
-	u32 buf_id = 0;
+	struct amdtee_context_data *ctxdata = shm->ctx->data;
 	struct amdtee_shm_data *shmdata;
+	u32 buf_id = 0;
 
-	list_for_each_entry(shmdata, &shmctx.shmdata_list, shm_node)
+	list_for_each_entry(shmdata, &ctxdata->shm_list, shm_node)
 		if (shmdata->kaddr == shm->kaddr) {
 			buf_id = shmdata->buf_id;
 			break;
@@ -333,8 +333,9 @@ int amdtee_close_session(struct tee_context *ctx, u32 session)
 
 int amdtee_map_shmem(struct tee_shm *shm)
 {
-	struct shmem_desc shmem;
+	struct amdtee_context_data *ctxdata;
 	struct amdtee_shm_data *shmnode;
+	struct shmem_desc shmem;
 	int rc, count;
 	u32 buf_id;
 
@@ -362,7 +363,8 @@ int amdtee_map_shmem(struct tee_shm *shm)
 
 	shmnode->kaddr = shm->kaddr;
 	shmnode->buf_id = buf_id;
-	list_add(&shmnode->shm_node, &shmctx.shmdata_list);
+	ctxdata = shm->ctx->data;
+	list_add(&shmnode->shm_node, &ctxdata->shm_list);
 
 	pr_debug("buf_id :[%x] kaddr[%p]\n", shmnode->buf_id, shmnode->kaddr);
 
@@ -371,6 +373,7 @@ int amdtee_map_shmem(struct tee_shm *shm)
 
 void amdtee_unmap_shmem(struct tee_shm *shm)
 {
+	struct amdtee_context_data *ctxdata;
 	struct amdtee_shm_data *shmnode;
 	u32 buf_id;
 
@@ -381,7 +384,8 @@ void amdtee_unmap_shmem(struct tee_shm *shm)
 	/* Unmap the shared memory from TEE */
 	handle_unmap_shmem(buf_id);
 
-	list_for_each_entry(shmnode, &shmctx.shmdata_list, shm_node)
+	ctxdata = shm->ctx->data;
+	list_for_each_entry(shmnode, &ctxdata->shm_list, shm_node)
 		if (buf_id == shmnode->buf_id) {
 			list_del(&shmnode->shm_node);
 			kfree(shmnode);
-- 
2.17.1

