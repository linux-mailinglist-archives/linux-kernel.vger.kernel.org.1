Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B89032A5E1D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 07:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbgKDG05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 01:26:57 -0500
Received: from mail-mw2nam10on2045.outbound.protection.outlook.com ([40.107.94.45]:59296
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727323AbgKDG04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 01:26:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DyPt07O6cNY4KA9Cs2OFP1zEn/97iI7u1AEhqcuT134unv691pP34EdOX+QAIxsq2o2Sj5VkNP1Qg6zLyEeFHOW0K2BKNor4p7Ojte+QFHFsAmKmEfprpxwuqy9k7sfUVNOq6BynrJjbaKrmP6DDAkFyT0GCoP4CtwuE0Ja/Bi/JG2ECUZtnhTRFtHKzmNzcFtlQaC9FpnFvaUx3abw05SXblGE8/i8LIIMD5G3yIQU9NuW6HCpWAHJ2MsIV5cpijBtur55WlwCmTFFQfO+9WEcKsI/jHeSYdxdo9t/oEgWOoKKGlsWA1X2oYOe7RY1CDXAOG6rX2CTRCOotEMVfKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZtasJdq1y15GVV6VJaMZ2GAvJKMvKjDkyK8lkZDFH0U=;
 b=gU+n72B4SpzfrC4VxVOVgajq4vH6RlYNohw+tV2GrlY0TYIBYr9BvOuANoUdz/wnWJTos3jEUuQFz1iWKQeqp8qabN4PmvFQwsfRjl0ngePi8xATsfbv+urB+NcBxQAzwmTaQJcdhlkH++2Eth1xkbLXWIfeNr7lxFpTPpgzge1jwwjYq/0DFCLSi4/pB/+gDeMsITcaAOIMUi1+aK3dyn0YcXXAmxAI/lFi4iI/ONiM/PYatoqPkG1+dzW2vmREKipp82bYOTCQVMlzMcHlhrSkHqdIzjpw77z37xn7woE7VbROu7tc+cToBe8ei6QqXEDB40EE36C7CppPpCSdlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZtasJdq1y15GVV6VJaMZ2GAvJKMvKjDkyK8lkZDFH0U=;
 b=hCkyq4UdasNnTSaUO4ILrBDhTq2D/kE8dDh+X7a3Qo1fDUfs1+o83KnRj/GvmUeEj9a/piLcnEhC29QbP78J+PQ7PPSqGAe9h3U+CycPoBA7i6+XaREsinJgD92tu3tpSTIpF63zxBq+Uq/zRZWtoWS0/9cQpUHCe/9hh9JyIlU=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4719.namprd12.prod.outlook.com (2603:10b6:805:e9::25)
 by SN1PR12MB2398.namprd12.prod.outlook.com (2603:10b6:802:26::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19; Wed, 4 Nov
 2020 06:26:52 +0000
Received: from SN6PR12MB4719.namprd12.prod.outlook.com
 ([fe80::7cc5:ed9c:dece:6d74]) by SN6PR12MB4719.namprd12.prod.outlook.com
 ([fe80::7cc5:ed9c:dece:6d74%7]) with mapi id 15.20.3499.030; Wed, 4 Nov 2020
 06:26:52 +0000
From:   Rijo Thomas <Rijo-john.Thomas@amd.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Rijo Thomas <Rijo-john.Thomas@amd.com>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] tee: amdtee: synchronize access to shm list
Date:   Wed,  4 Nov 2020 11:56:10 +0530
Message-Id: <ae6cf5eaf0552746bd2733d0caf06c6a0425010b.1604470183.git.Rijo-john.Thomas@amd.com>
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
Received: from andbang6.amd.com (165.204.156.251) by MAXPR01CA0081.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:49::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Wed, 4 Nov 2020 06:26:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3e5335c9-6e25-4457-dbbf-08d8808a9e76
X-MS-TrafficTypeDiagnostic: SN1PR12MB2398:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB23983DB128B433A0FA10880ACFEF0@SN1PR12MB2398.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:341;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EqpuWvQG6YoyN4iYzF51X9fGt49MGrgDm275su55OyXcpMot6dgX1H76MmMqGAPnx3CJXwRPL22S2Lz6O/H64wCO1UJ+z86OmB0Dl3r52Z7hZn8KrDVkupaWsAtnFpGXnNAFpHJorwJVNzLBpJlmedaTzNxHGkNokThx960ywJZMPCOtBgm9Tt8NkLsyMSCCkUgTzdKKuXO1dPajLx7xqc/cTQOd0stYTBH/emEdMSNj+ddyJYIiJMd0T9eQHyoAxYtA/haQ64vVGu7PnodkyRqdQPKjTZ0G3i7hlLZy7Cptb7xziScSAq+wwFL8z0u9NZYs3cVX0pWtcbm9z0GR0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4719.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(346002)(376002)(39860400002)(6916009)(478600001)(86362001)(52116002)(2906002)(7696005)(4326008)(5660300002)(316002)(54906003)(36756003)(186003)(6486002)(8936002)(66476007)(66946007)(66556008)(83380400001)(8676002)(2616005)(956004)(26005)(16526019)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: GBSaliC9i72sOTBcWkzgMmqGNHx/dijKAJBRWrPRgA7dqu+DDWpG6ASugvmHLpENoIsfxDaVoafdgDX5PaKR5SIbhBK5IgyLM9P4tKfzq9aInmcylhzSEnniWs8DxbWbZJiTh/U7/0nSpRvSHj6VQgInBbktKupaMWONxuNrAu+nxKW+DYNFJb+LbGQVCVKHKRzdx8QNWNDucurTpHWuOyIqv2Bb/NXdEGr5TdcvxAcCS8zroTLiZWP1DirnPaum/MJhhXVcawuWhBXP8qieuUq72hZvdEH0KuvVcD082Iaqq24iumNyPM5nDD3tCxQajTJfoL0lBHyEiFhJwMz6MoLf7i/+altkKypcdyHV3/vzhF+5gUtiIcbh3CwsaEPN1jx0tPmPW5+ZL8khK3ynaU5YhjpOzKIGWIWOzIIdkT8SE4B5N26e/U6w8/dl6ntRmXdcylWdznX/U2wnaG5mUsMTDPOdYwL28zS1AdPQ2oUzSkWaH6z3XFtpeC095ynAxES584PSoRTS0fEvkz40gIk/2a5fpzSijF6dquQMgfkcNup+89bddWGNW02AIKSLtUUhbHJ1MPw3woX+WLgocm0yYhax48yteq87jGC7j6+OzlXwelEq48jNHa3pI6m3Wr6zzZOs69m89Mr6Y1Xp5w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e5335c9-6e25-4457-dbbf-08d8808a9e76
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4719.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2020 06:26:52.6799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dd2iokXDV4eoHJif4IAERYaHtI1IG7wJHiJTBNhQyzeCBD3CBXtpEVQLervbAKrrFhFbBQjTqjoj7i8EQsKGZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2398
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Synchronize access to shm or shared memory buffer list to prevent
race conditions due to concurrent updates to shared shm list by
multiple threads.

Fixes: 757cc3e9ff1d ("tee: add AMD-TEE driver")
Reviewed-by: Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>
Signed-off-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
---
 drivers/tee/amdtee/amdtee_private.h | 1 +
 drivers/tee/amdtee/core.c           | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/tee/amdtee/amdtee_private.h b/drivers/tee/amdtee/amdtee_private.h
index 97df16a17285..337c8d82f74e 100644
--- a/drivers/tee/amdtee/amdtee_private.h
+++ b/drivers/tee/amdtee/amdtee_private.h
@@ -70,6 +70,7 @@ struct amdtee_session {
 struct amdtee_context_data {
 	struct list_head sess_list;
 	struct list_head shm_list;
+	struct mutex shm_mutex;   /* synchronizes access to @shm_list */
 };
 
 struct amdtee_driver_data {
diff --git a/drivers/tee/amdtee/core.c b/drivers/tee/amdtee/core.c
index ce61c68ec58c..8a6a8f30bb42 100644
--- a/drivers/tee/amdtee/core.c
+++ b/drivers/tee/amdtee/core.c
@@ -42,6 +42,7 @@ static int amdtee_open(struct tee_context *ctx)
 
 	INIT_LIST_HEAD(&ctxdata->sess_list);
 	INIT_LIST_HEAD(&ctxdata->shm_list);
+	mutex_init(&ctxdata->shm_mutex);
 
 	ctx->data = ctxdata;
 	return 0;
@@ -85,6 +86,7 @@ static void amdtee_release(struct tee_context *ctx)
 		list_del(&sess->list_node);
 		release_session(sess);
 	}
+	mutex_destroy(&ctxdata->shm_mutex);
 	kfree(ctxdata);
 
 	ctx->data = NULL;
@@ -155,11 +157,13 @@ u32 get_buffer_id(struct tee_shm *shm)
 	struct amdtee_shm_data *shmdata;
 	u32 buf_id = 0;
 
+	mutex_lock(&ctxdata->shm_mutex);
 	list_for_each_entry(shmdata, &ctxdata->shm_list, shm_node)
 		if (shmdata->kaddr == shm->kaddr) {
 			buf_id = shmdata->buf_id;
 			break;
 		}
+	mutex_unlock(&ctxdata->shm_mutex);
 
 	return buf_id;
 }
@@ -364,7 +368,9 @@ int amdtee_map_shmem(struct tee_shm *shm)
 	shmnode->kaddr = shm->kaddr;
 	shmnode->buf_id = buf_id;
 	ctxdata = shm->ctx->data;
+	mutex_lock(&ctxdata->shm_mutex);
 	list_add(&shmnode->shm_node, &ctxdata->shm_list);
+	mutex_unlock(&ctxdata->shm_mutex);
 
 	pr_debug("buf_id :[%x] kaddr[%p]\n", shmnode->buf_id, shmnode->kaddr);
 
@@ -385,12 +391,14 @@ void amdtee_unmap_shmem(struct tee_shm *shm)
 	handle_unmap_shmem(buf_id);
 
 	ctxdata = shm->ctx->data;
+	mutex_lock(&ctxdata->shm_mutex);
 	list_for_each_entry(shmnode, &ctxdata->shm_list, shm_node)
 		if (buf_id == shmnode->buf_id) {
 			list_del(&shmnode->shm_node);
 			kfree(shmnode);
 			break;
 		}
+	mutex_unlock(&ctxdata->shm_mutex);
 }
 
 int amdtee_invoke_func(struct tee_context *ctx,
-- 
2.17.1

