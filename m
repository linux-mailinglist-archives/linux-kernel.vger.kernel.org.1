Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7450E2E9535
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 13:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbhADMoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 07:44:10 -0500
Received: from mail-co1nam11on2043.outbound.protection.outlook.com ([40.107.220.43]:13899
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726711AbhADMoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 07:44:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nmn35oSJZb6hQHjtoLpFqv1OUwbf738siRum41DPaditfDL4DwickBfpaT2zOz9sbag/8bxkYmA86ErtE6kvCoihWcFRTY4ZHAt9KSCLzEKZw//dvXI2bNlpA+dq6pjLJ1kLCEIFSG9Y1R8fK63ua5mCNjW7Gq5fmDemyYfsj8U/R//NKBCuUO5Tqce85G7plb3l+RBPUjpayr4XZnAifQk88FEMoisXEhXFNCW1Wmr1tAeqd225z63X3M/R5ancwt0wEC/oYlqFhsJNTbAr7aN6CTj4BNwr54qyx7+AW9MKt4vP8hvcWXuPmN9b6z7tVEOUQwuOfSufA1QW9sFaJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x5Gk1f/oOvTBdR8zj0UZ9g1LdijiDYHc4H7hlyGU6Lc=;
 b=TwzbrsdbhAqHXeA+8xcUOBqScmoagaE895Jjtsbw4VvMlAdjRcnqfjb8oT8agRkNsk081dLD1qYwhD0kBNfTj+ZIKunsk7JNhDdII2CtliwcovZF3ywgKtsKCVF2zoWweWNjJzvh3F0v8Env8VHQDh5dmW0dvmjknyiynJYUAtDjQhwUMAk+/12t2rARt92Wj9crknaNQOBFPvGl7+G+/D2elMq5U9od4VaeFOkrxRv2tJvGBkieklscKrXHfPg6Yb2b8O3i+1wJyLT8/6cXCKjOQx+DIDTkwQOnP8VtbeUTkbxlY0mMSMzO1UW+0uUJsdqlpZxaR2cGf8XFBOtAug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x5Gk1f/oOvTBdR8zj0UZ9g1LdijiDYHc4H7hlyGU6Lc=;
 b=kFFBr59SY770n0fkf5Q9WY5nXHMyRdcDPQitzLGsXCX0X9oCs1+gifuOP5bqTUbrw0NUkV0eSX7IluMeSS59tQ0PKo1tfGfBb4mBGoiyXR+9sf+4bC8By+Q0CieFekYqkGlCtUxCM8qnbtLepmb3oiUT2xZbnDbA11Apn0u1idc=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BY5PR11MB3909.namprd11.prod.outlook.com (2603:10b6:a03:191::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.19; Mon, 4 Jan
 2021 12:43:19 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::94a4:4e15:ab64:5006]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::94a4:4e15:ab64:5006%5]) with mapi id 15.20.3700.031; Mon, 4 Jan 2021
 12:43:19 +0000
From:   qiang.zhang@windriver.com
To:     tj@kernel.org, jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] workqueue: tracing the name of the workqueue instead of it's address
Date:   Mon,  4 Jan 2021 20:43:06 +0800
Message-Id: <20210104124306.24375-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK0PR03CA0108.apcprd03.prod.outlook.com
 (2603:1096:203:b0::24) To BYAPR11MB2632.namprd11.prod.outlook.com
 (2603:10b6:a02:c4::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-qzhang2-d1.wrs.com (60.247.85.82) by HK0PR03CA0108.apcprd03.prod.outlook.com (2603:1096:203:b0::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.19 via Frontend Transport; Mon, 4 Jan 2021 12:43:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8cc02784-1590-48f6-cdd9-08d8b0ae50a5
X-MS-TrafficTypeDiagnostic: BY5PR11MB3909:
X-Microsoft-Antispam-PRVS: <BY5PR11MB39099B517E7D385D3D4757D1FFD20@BY5PR11MB3909.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:63;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aql69udvfdwP7t5JG4jgEaMnRvPVYiamiv4+JiYXYadhZ0UCw2ia9my/zqgb67yNXnvMEe0KRqPOGzyVK5WF+4mC4Z65c5L4uroTUnzJEOnUV9PaOe5kj2n3MTm7yYUgDsIMFkHXcOzWICgNDcRRXbRv1iVXIKiMKUWPrPT/QrXzpB7U2YrM98/PumQD9zhE7U4wlw9LpjyTSnGHm0sBS2Gnnjvgg3RWKnsHpa7bs3eQTyOU6EIygRf9fUhO/uOQUiTyKJQvLxt5DfDrk+JEemV8coXbAJPBaIlXb2ikXceJcVr1XVNjaS1gCTz0VCXmHh8oQUXfADXpcT2GfUmfHq4sgI0o9RiA64pftJsJpeNN9zewk/3BsL7cDatuaGX27JQ7ERBAZ1NPDjI8AzUxmg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(136003)(346002)(376002)(366004)(396003)(316002)(66556008)(6506007)(5660300002)(26005)(52116002)(2906002)(66946007)(8936002)(66476007)(1076003)(86362001)(186003)(16526019)(8676002)(36756003)(6512007)(9686003)(6486002)(478600001)(4326008)(6666004)(83380400001)(956004)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Kk//Wsx99sh5q7MbAVyte6xCpamWoHuuDvaX9CHAgXFZAbVuO2Ol0VNkbR3+?=
 =?us-ascii?Q?uEoumqMjIZAqQtUBKBxNl/UIMo5oQdrI9Pid/Xx/Xfwtil4qtlnSfheosGGU?=
 =?us-ascii?Q?ib77jz6a0NXzuJUiNFrtDj4SP4s1E/HzIR/5U0iWi89ru+G2fL8fvVFgQi51?=
 =?us-ascii?Q?iPLYO8Be09OZxDfH8B4F1BadF6YeKMwLSaLgvlF1sflUExFLsxEQ7NVulfPW?=
 =?us-ascii?Q?L7wjsl8TxZtrVe5RXkyteATkCr+/+STJYmPSgH367/TO5HEN3eC4Rww8y5v5?=
 =?us-ascii?Q?hpyFN7ep7CZrRm3+tcBQP/vuHsSkTOz/Cwtl0n8HHiL46DTA3jKFU2Z3bsF+?=
 =?us-ascii?Q?hogoKmikBPBYuTrNT0emnS3oSI5ckX6CaewcNMF74AgsedhaZoiST5/87yZO?=
 =?us-ascii?Q?qPAD4eQ1KvD4QvZgI89iyTYooGXevrYSJkGWBAECSzQdcS/OUm6AHCj0EdZd?=
 =?us-ascii?Q?ia7p3LbWfgX+3Poo+w3u0KJEUSLObxB9yRTyUGfLQHjwCM6FuvXrJ5/lRt5D?=
 =?us-ascii?Q?sSVjdBV4Jfc8sC+EeabweTqLEE1w+nGknANSBL+qsY+PD/lVe8LUAanmUMAK?=
 =?us-ascii?Q?5druorwXJrqaRmHHcUAd38ZcHGWabulpzex1UkMeWGagCI99hiukk+MkDYHv?=
 =?us-ascii?Q?7defvaRRe0fHF38SX7S3k5Zbh2TkAG7fRirrc/5PTIDZ4IeJwIx1hh1Qp/z3?=
 =?us-ascii?Q?B5yMV0rav2mYyHUuMciwceRM2Ge4GpNgSn2Dp2+Y4VuQz9/qW78ggNWhd2v/?=
 =?us-ascii?Q?06mPdsn8l/Qa/AJelNbrdEUP26r7WmU0HOg8ep96ewxolfOaWlhKVnA8RgcW?=
 =?us-ascii?Q?u68e6gL4bfBt5wVZdqLp9CUZ3ld3IBjZwkTcw6wnXWcpyI3iPelNu9B5RB/L?=
 =?us-ascii?Q?OG9N5CxEnyEraKijgtSzCVDD6HmuTuC3PslhlxfvXzF23A1u5KCfuXzKgYif?=
 =?us-ascii?Q?rgNK1G3DJZwDI+t7n5Bde2TnnYNQHa/sBnvfPxsTCYE=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2021 12:43:19.5457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cc02784-1590-48f6-cdd9-08d8b0ae50a5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 92jry+y57IRGQxF1OYNBIK/fjnqR5snuUG5IlC6zklCbMyVOAzGxzkxBSQ466y+GPRbL5F2dLnrwWb9z8Vl+Eyx0l93IZDmOTciGEVxoKq0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3909
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zqiang <qiang.zhang@windriver.com>

This patch tracing workqueue name instead of it's address, the
new format is as follows.

workqueue_queue_work: work struct=0000000084e3df56 function=
drm_fb_helper_dirty_work workqueue=events req_cpu=256 cpu=1

This tell us to know which workqueue our work is queued.

Signed-off-by: Zqiang <qiang.zhang@windriver.com>
---
 include/trace/events/workqueue.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/trace/events/workqueue.h b/include/trace/events/workqueue.h
index 9b8ae961acc5..970cc2ea2850 100644
--- a/include/trace/events/workqueue.h
+++ b/include/trace/events/workqueue.h
@@ -30,7 +30,7 @@ TRACE_EVENT(workqueue_queue_work,
 	TP_STRUCT__entry(
 		__field( void *,	work	)
 		__field( void *,	function)
-		__field( void *,	workqueue)
+		__field( const char *,	workqueue)
 		__field( unsigned int,	req_cpu	)
 		__field( unsigned int,	cpu	)
 	),
@@ -38,12 +38,12 @@ TRACE_EVENT(workqueue_queue_work,
 	TP_fast_assign(
 		__entry->work		= work;
 		__entry->function	= work->func;
-		__entry->workqueue	= pwq->wq;
+		__entry->workqueue	= pwq->wq->name;
 		__entry->req_cpu	= req_cpu;
 		__entry->cpu		= pwq->pool->cpu;
 	),
 
-	TP_printk("work struct=%p function=%ps workqueue=%p req_cpu=%u cpu=%u",
+	TP_printk("work struct=%p function=%ps workqueue=%s req_cpu=%u cpu=%u",
 		  __entry->work, __entry->function, __entry->workqueue,
 		  __entry->req_cpu, __entry->cpu)
 );
-- 
2.17.1

