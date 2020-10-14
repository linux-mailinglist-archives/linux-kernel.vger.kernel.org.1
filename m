Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D717728DB1A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 10:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbgJNIUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 04:20:54 -0400
Received: from mail-mw2nam10on2058.outbound.protection.outlook.com ([40.107.94.58]:35537
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726884AbgJNIUw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 04:20:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DYFd0zVjMP7CHEPqoPw930m6fLW4aB+SzJmCdTI/NIwM37BfNzLVWD4FBL6kDsxzI5OVFWpyHA3dRurlJhqwibLaOFACa5LfPq8NJCtwLUQ6ovCjLthJBD+3T+Rv/e7WnpXrfcjjwlmAqReQ6s0WxXM9eqpd7seXHSgKl/oaN1cRR5SzLRlmNMxMA2Xx7k/dC+hDB3GAVPM9OovrKsuXi+y2TlcevfMFgK4PaW+VyH9+LxCecW8arat0qletrLbhLvcpoZkpy0Kp+JR6MHMTj5Hffaeg1LnJH/Us6jzHlhjLW3rpOBod20LsTwkwG4wjH2yRxLbZ3N56j8TlSAhjvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yyktmCOir3e8MUYgaNuI3yki6+L1iUjVNP6kTXrrlx4=;
 b=AVcA79ClYsC34SMw55CVYOe2GThX2RLp/eZ+B5VALMZ345kTS0pyPHx1IbDFLI3cEuQ5SiPlQIvFn6cHr0Mc1yb3Otkzdwl1daQU6IfuEs4zxICoUOkVN5pri2kFLihyCuO3zhK0QCMABZVQwbl2WHhpDRYPwNFIxZXfNK2p65T0wZzoFJ/anIz+KmORMvi5JD2eNJLmRndJ4lxZVwzQDxn2HpwzUKrnyGzacVpYZV9dJW6WdjD3aZNhOSmpQ/tJf94zvBZMIWlWy6rrSba7xhQ1PsiuRPdlBkBCudvoNIqkx9L54vpMkmXXFLiXb/mKrvcDs2CmnGHun/OGXwPb1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yyktmCOir3e8MUYgaNuI3yki6+L1iUjVNP6kTXrrlx4=;
 b=asAlv5kWLhJiRCRigxozBDtOcL6HTHr8TyB6qvsyTyyeDG9A6s8lKFO54CW6Y/KY42HM4OlxK1a9VdEJkXvstxD4KHbfm+ktIy+W/T/0Wy2fmME2i6+jNFNt5XdEDohqrkKt80UCElcCg56+QaPe023Rc461/ABPCuuiDW9oN/Q=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by SJ0PR11MB5085.namprd11.prod.outlook.com (2603:10b6:a03:2db::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.30; Wed, 14 Oct
 2020 08:20:52 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::80e9:e002:eeff:4d05]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::80e9:e002:eeff:4d05%3]) with mapi id 15.20.3455.030; Wed, 14 Oct 2020
 08:20:52 +0000
From:   Zqiang <qiang.zhang@windriver.com>
To:     tj@kernel.org, jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] workqueue: replace call_rcu with kfree_rcu
Date:   Wed, 14 Oct 2020 16:20:39 +0800
Message-Id: <20201014082039.16583-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK0PR01CA0068.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::32) To BYAPR11MB2632.namprd11.prod.outlook.com
 (2603:10b6:a02:c4::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-qzhang2-d1.wrs.com (60.247.85.82) by HK0PR01CA0068.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21 via Frontend Transport; Wed, 14 Oct 2020 08:20:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 040059d7-e222-463c-dd75-08d8701a106e
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5085:
X-Microsoft-Antispam-PRVS: <SJ0PR11MB508507461365D9AC32E3F3A8FF050@SJ0PR11MB5085.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:480;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7j5OkhkN3GWVEF+ip2laxUWB2jDULVs/b1yR3kQwks5nEhBBlpWrJ7hBO2w4PUSb795f2hjatIcPyVHcVMNioggpyxO8+Z73T5eNcK2CZPwNbMj4XHx+Q17iyEkxTYuLygYh8Q+wb8jEzWUuWo8aOyOy99ZGaj/rR41G4T5S3eeqhGoYQlP4PLHu8yWbv5CG4TacxcACHcehAtxPwOTMZLDUNw2guXq5Hxsylrjn57WEuHXqY+iMnrgmJ/0AdDXBKdcUad8gq588sLKT32GMGcCDp+wKL9bK/d3vJHyIpGdIWax4Mm9wkK93MmBNxxy3LuouAwx5PdlSvthNMBsHZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(366004)(39850400004)(396003)(83380400001)(956004)(5660300002)(1076003)(8936002)(26005)(2906002)(316002)(2616005)(6506007)(8676002)(36756003)(186003)(6486002)(4744005)(16526019)(52116002)(66476007)(4326008)(6666004)(6512007)(478600001)(66946007)(86362001)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: nhX9tm+hlYLuRYvwGl8XvV+60/LoOvjdDIRsQo7IPsY5ZxVA+8cclEYSk9RmwrB/KRQmlxtvTHsehVAD9bbr5xe2pQPAwU+BpT/oUoLdnnWAhAYv3yp1eaWHLSw7DGW9TVU+m0tL6ls/JUfMCEEvLVq9cxH6WTkYXceiQrl48dNyWM73UezSzqtl0dj+j4GSX1Lx9vKuwyzMugNNe4RSfU/yotYVOaE45mVZZEzhDQJJ9cN+TtKqrRgM0L3bY+Ja+eMOO9HqRcfjjOLi1I/xFfHA1YT2nqiaBrhrfNbojoekPcqjBoVg6yRD+fKMqe5UMW601yAa+y7SXY0gijMLUBknmnqDsbwWQbRShty654cKCa61Ng4Sa+uqX5nvre5TUeg3qerDab2HxGkXAOkFTvr9faFPO7JuF8YvuuAbtKUwG8ndqCfxj5X039e2n3eReGfyOoPNQoIeewwFG88eirdJ3qCCgN/ZZWxzvPZ7lhYLkyJ3RcnhAfTHpJONXW49NSBQSTCCJK4PR8//vc7RW8w+2qmghB1jP8qjejkC/DGaxyqwrkLJeZ+ACDQ8A1ExfAZ3kfZbaPiaN6/lAVcRdicyEhYbMM+BdYtv/QjXfQEMBN9Dqsi5FECqc4nk2pXdTsjCuKcYunMRIu94f3SJXg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 040059d7-e222-463c-dd75-08d8701a106e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 08:20:52.3854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tt7Kvyx5LWmqHkObVklVioc9I4lbKMLzHeqb0rZwzc/agq0LdwldKvucLD6ljeOORaXD8K3QtXwA/Sqj/KovmrdHXMEVnHYt4wzgSVMHh5E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5085
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pwq's rcu callback func only to release 'pwq' resources,
can use 'kfree_rcu' instead of 'call_rcu' func.

Signed-off-by: Zqiang <qiang.zhang@windriver.com>
---
 kernel/workqueue.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index ac088ce6059b..8d4fe649631a 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -3653,11 +3653,6 @@ static struct worker_pool *get_unbound_pool(const struct workqueue_attrs *attrs)
 	return NULL;
 }
 
-static void rcu_free_pwq(struct rcu_head *rcu)
-{
-	kmem_cache_free(pwq_cache,
-			container_of(rcu, struct pool_workqueue, rcu));
-}
 
 /*
  * Scheduled on system_wq by put_pwq() when an unbound pwq hits zero refcnt
@@ -3683,7 +3678,7 @@ static void pwq_unbound_release_workfn(struct work_struct *work)
 	put_unbound_pool(pool);
 	mutex_unlock(&wq_pool_mutex);
 
-	call_rcu(&pwq->rcu, rcu_free_pwq);
+	kfree_rcu(pwq, rcu);
 
 	/*
 	 * If we're the last pwq going away, @wq is already dead and no one
-- 
2.17.1

