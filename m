Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39AB928DB99
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 10:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbgJNIbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 04:31:55 -0400
Received: from mail-dm6nam08on2071.outbound.protection.outlook.com ([40.107.102.71]:6447
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727736AbgJNIby (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 04:31:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kWRkrx301stZYXXohLBfiKYMn7wBwDm84H09LY26ttt3x68PjX+GRXbB/vn+3SFbpNjf2jBaKprv5/zy4RoAvvO28NQeK46bdhMawFPBwriuRpTIeVBtvgPFpj74dTAwIVXkLFAbeox6o90CTQn766WJph4CcrlbWLnzxbLd7diP9HRPPDG1/4zki4R0q1p0jNAVeXm4tCoIfxV1XxZIhnbyRVWV8Ob04TlBfZaQdXoEHjqkZBTeOhD0UAWN15M4ONbWjIXqZ8wXOTruCVPmwW370ZKIC6EKrcrfT15/lsENOSg1FyeLoHKCMpeZeGNWO6Ic4WeDeJaCRFvAdtgiMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CplmIumk0JE4XfoLvBT0McmcIElreNv91qLtnM1vglM=;
 b=mEKVhHTp3N4XSuvfeZ+NZ9qcYZcyiFToev811CIGVuSiXxO+46DTGdC0tIFVlVIYVdP6RH3w03sLFT1RcTAVbhdR6E67rrRLTVCxtHneFNrtBoKBCGdYtRjfEnuCQQ/VCWVQI95YE3aHrP4DbKo/q74cPz4wD8iJkPNpLrCGSjlVR0pMYNnj621ovq3afveMqSDch+fhn1A7ZTEJV9QH5VNRK/1c2EURILXQtVMpruZuRoZkGRU8tza7p4kcn8TJbUZAhl4HIvF/n4eZeTBkQ1LkpraP4/VbLwBhhw4GbzRiyAFRYT1GiwuqYtaOUoSTnUdMvUjQdFGEDwJgKbw6FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CplmIumk0JE4XfoLvBT0McmcIElreNv91qLtnM1vglM=;
 b=fYmc7VyXRuUpMVdJ/YSb3Qhk+Xfe1E3ePichi2xnlGSgIHohhMZcEq1qoYDSz1kMovePN5j6GKjX6YlHXdBxHbc1xu96/BBxve4vqfyVmGXwB4o+u+buN2d/ely75lk/QfVgqEq3TxLXMmWoOkQtyeHd7pR61vI/ZF6Qj7yzKC8=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BY5PR11MB4150.namprd11.prod.outlook.com (2603:10b6:a03:190::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.26; Wed, 14 Oct
 2020 08:31:55 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::80e9:e002:eeff:4d05]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::80e9:e002:eeff:4d05%3]) with mapi id 15.20.3455.030; Wed, 14 Oct 2020
 08:31:55 +0000
From:   qiang.zhang@windriver.com
To:     tj@kernel.org, jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] workqueue: replace call_rcu with kfree_rcu
Date:   Wed, 14 Oct 2020 16:31:45 +0800
Message-Id: <20201014083145.16959-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: BYAPR11CA0043.namprd11.prod.outlook.com
 (2603:10b6:a03:80::20) To BYAPR11MB2632.namprd11.prod.outlook.com
 (2603:10b6:a02:c4::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-qzhang2-d1.wrs.com (60.247.85.82) by BYAPR11CA0043.namprd11.prod.outlook.com (2603:10b6:a03:80::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20 via Frontend Transport; Wed, 14 Oct 2020 08:31:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3048f26-96d3-41e2-71c3-08d8701b9b71
X-MS-TrafficTypeDiagnostic: BY5PR11MB4150:
X-Microsoft-Antispam-PRVS: <BY5PR11MB41506829B690784751D1D94EFF050@BY5PR11MB4150.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:480;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bnxob/daaxJKqrPfyblOTOcmjy2Z5NPEYp105u7BgCp1pr52WagEdMGenivnv9E+/xcXCpIAw/ZyIWZ8MBD/M33rRsWZV00XhCaj0by54rSn/d4pfbFXKVTzMXtsZg8Vu0lSbkCNm+HVd3QbVqhaSJPB0bX7Lap8sP262W9V9R5jJwOKNa/SDbHOEGgm2gh5RwPROJOBBEcZ1tObwDdXyL1XtTdPWy1h28dT8GXxW4Al9yMuJ9l8HCdwuvMrHjLvh0CRO5gB/+1xiDeLj1BYJd/KLNqMRqx9pBsdkzB5HWPR9cqGhKAdsUMR32XdcpfNBOdDU3LDEdL7WiPGs8bXYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(136003)(366004)(376002)(346002)(396003)(83380400001)(6486002)(6506007)(6666004)(1076003)(36756003)(316002)(52116002)(8936002)(26005)(16526019)(4326008)(6512007)(66476007)(86362001)(66556008)(8676002)(5660300002)(66946007)(9686003)(478600001)(956004)(186003)(2906002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ZUa6wVG/jJmdCglojG/xX0eWy0vkETSw81h3qEXPFB/TiGlF2UZPzxzwnLw4sHOy0YVIcfG162GZ81bSNYO7mtZtIT3C1ZyKy1aS+Szth9O++qBtNErmyu3t3wkt/zutNamOmzKTlqNrnmHajJM1QXMPkFeQ1uSfiGnFpaYUW470I9wEccASICUrMvML/8S5+el+o4tgi9esq/XTFyZ1NgbOZQqTg/agiqNxqTSG/xP5O/GcTq4GH8KdlGeQwsz8kBtz9PbQmGt80XinPdEIfJSiDFIv70F3knMMgm43b/7S4FFbeY5VfjBFiywnTgtdfIgOE4ZdJpoVlYEq/9w5j+L7YYzxsvN1y4Z2YUq1lRO+TWdwXJECR7yyIbLLAhi8an0SQcKDlUaoPfAe4WmSNZiOPlI87t+TI7HYoxvzO1T4B8IP3Jm1L9ZcIJCspZJGGfTnPh8ssYchqwvIPTq7JP5SCpsr78rJyP4qZasGgbaW4uhtLlgTD7bfkDbS/YIFMY9GQFjtr2PfWL3Wbj7CVdu+y0uancWXoANZBIiZJ+9dEkJNks7S/BN0ksDx+Pii1YwpYEpzDm8llVUycdXlve6EITukiZS24+Famer5K1AI51Xg1GYyEYELe5cfPhi41cHqAf1qSk+enHRce8fX2g==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3048f26-96d3-41e2-71c3-08d8701b9b71
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 08:31:55.0234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rhqVtzeVyVnlm6yetZ4tG1d34lE6rHtj0WjQVqbNEMf7GD3B9hQeltEhqw/xEisAYAAhk78BDOG5eVAG3FDqR6CW7e2TLOymXUfX+1KJ1ok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4150
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zqiang <qiang.zhang@windriver.com>

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

