Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8B42F107B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 11:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbhAKKtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 05:49:35 -0500
Received: from mail-dm6nam10on2078.outbound.protection.outlook.com ([40.107.93.78]:27969
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728725AbhAKKte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 05:49:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=chLv4pAIq41seZ25SI3y7B8VefdMzJS6eOkKPDF5IBcr7bW4W5RdxcqSfZFYOck/R5fG+6m87pJkSxh8jY1qOs9WC0nzG+VmuveOTdx0JujbvJ8NwahB8jol4AWzI7ZUdhX+7Li7JSsI2Q1OkVeWC5dHx35Vu0EVgJAtMMA6gM6TqwqUMl/lk2w2+pwr9a9uKOOAmhsjkBj8dIQj14RVsIMWqZm46k3T+uBw/mlQk3biIIW3LKaSbhffb43XOUDp0JIclidNnqHTAIPH2JX9Hn9jDu4tLmxBYfKQUo35aqq22mm8cIGIwvaquOlsRg8sAAmOcXmf+6GEgox8I57L5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hib1AXVRh3gBGFJDHRQUpbYAUGsYHa/OB3EAtajoWyo=;
 b=KKKhZKrF/Z0s4pXUIWVLD8Y9mVKEQYFgrMEAds6lW7bRtfxgQhgJ3C+NptUwP0+CoU1JQ++0no/efxkcCD2Z6C3OnBd5GhYZoCTeYgQbmtqVWGmMIwn0NMZcnIn9G8JTyA9LWOPo+uBBmm4uRwjQ+m008R3NJfUIvAaayBJV3f5+SwRcc+yAUaLHWpuSulVsOIFsYkRnXwyYmdsbKA9UIF3/TBlnvOiv4J+DOJpT/1SUBp4MeptJfIYTrm+6dHzVjanRl+3IBll39N2eX2uy1t5ONB7edKGv/POdnF46cNyy03+kegU+91wQY25qmZ5aiDtcO6BkmHtQAg19U9PuYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hib1AXVRh3gBGFJDHRQUpbYAUGsYHa/OB3EAtajoWyo=;
 b=JsXv05CZODRwQ/ajo9czWQY18ZkYjopvwAm3frPXIiU+ZMR/63B/dmhG+Cy9Z+/rzvMpAupJUPRJtBueAdwYca0vWPtVYpayd2yWOBnBuVEHFwoXqrMBjZXX3JoyVJbKMhmuCq7Xzo8LecDtWQ9LaZkD/fGGGPTG0gOgH1HDSzE=
Authentication-Results: brauner.io; dkim=none (message not signed)
 header.d=none;brauner.io; dmarc=none action=none header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by BYAPR11MB3304.namprd11.prod.outlook.com (2603:10b6:a03:7a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Mon, 11 Jan
 2021 10:48:20 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::89db:d2c3:7a57:75a6]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::89db:d2c3:7a57:75a6%2]) with mapi id 15.20.3742.012; Mon, 11 Jan 2021
 10:48:20 +0000
From:   yanfei.xu@windriver.com
To:     christian@brauner.io
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] kthread: remove comments about old _do_fork() helper
Date:   Mon, 11 Jan 2021 18:48:07 +0800
Message-Id: <20210111104807.18022-1-yanfei.xu@windriver.com>
X-Mailer: git-send-email 2.18.2
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR03CA0045.apcprd03.prod.outlook.com
 (2603:1096:202:17::15) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-lpggp1.wrs.com (60.247.85.82) by HK2PR03CA0045.apcprd03.prod.outlook.com (2603:1096:202:17::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.2 via Frontend Transport; Mon, 11 Jan 2021 10:48:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc1d2521-ee78-430f-5206-08d8b61e690e
X-MS-TrafficTypeDiagnostic: BYAPR11MB3304:
X-Microsoft-Antispam-PRVS: <BYAPR11MB330467E5F6BEF4218AB4F08EE4AB0@BYAPR11MB3304.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L8GjFNWI5FCmyKdnqGrMjt/gLDlC8n1Av/t68+DWD1Fwc97UWFMNKR3AZ3/yISMRee9qaTKyhKpQIJaFQIJ1QHExUpufObMv806n8mEkRA21+/uEbuPgz9AJhDO9yiBx2TSS7kQ/gK20iznRZK7eDrVY50uJrJrpRqEamIQcTKPqBq4RWTzOmOd62TZ2xf0gHImP0/y3fFWFmceMBKVmywlEtqmSQ4saQLYDeu40uq3wfP0BbZ0Jcm2lwFgyav2053RueaVrGvMh3Nrjf14Yj7GFz9YiDo4RaPNZ0qVzYvJzM7E64gKpHT7hWqGNU/hgwkqmzlt5mj47oKL/WwhaWVUU2unKs6VLjr/FcG4f6gQRBPn3ArJDJrUrRVZqclOVg7B0rloX/znCZ/k6iY1SdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(366004)(346002)(39840400004)(396003)(4326008)(186003)(478600001)(316002)(5660300002)(9686003)(16526019)(6512007)(6916009)(26005)(6486002)(83380400001)(2616005)(8676002)(36756003)(86362001)(6666004)(6506007)(2906002)(66946007)(66476007)(52116002)(956004)(1076003)(66556008)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?YvotMFWoJuZ8s2d1CT96MXYMf+bN+35DaRdkKKJJC8egj0A4HxuScuCYPpbt?=
 =?us-ascii?Q?bqa7zWJ9f1oe22oiioDW1JcjAKIzcYF3FuliagLhlTfZeJI0Azfo1wy//+AJ?=
 =?us-ascii?Q?qLSOOZ8ZhI9rjHXa5+rFznAqNM0VyMjjPRQH24PRkoxrDTKDvYNvBoN+QmB2?=
 =?us-ascii?Q?TJFqe6VMr6sEEvrSYXTP4elD7ApOdt0igSMlmWajUD/q8hbyqicM4rr1H0RM?=
 =?us-ascii?Q?H/XoVDW+J6R4IR1fLz8c3LFemomIpu/G+aP2X57G1AQIaR3ZQ1fpOQ5qfnwB?=
 =?us-ascii?Q?3stnKwqqQJY2H0qJ+CTuOEyWvAcai7SwzTR7gzfpcmknS2FQg3ToqkFk45M3?=
 =?us-ascii?Q?jOZgPdjysld6H/fq6CpBT3WpuwMtxc/CX2wCCjrpCX2Xkgzfmibo3meBQ67w?=
 =?us-ascii?Q?3bL1La2NCSCq4kvVcORgA8WfqJjb8UXyP5PQHXd3Dng/EuLafU2PDsJJSAan?=
 =?us-ascii?Q?4Md0w0ZScwKzsP17qUqWHKiHBJd7rEaWJNpAvqNaVsRvMz4nJbVN7kpjy6eB?=
 =?us-ascii?Q?UbMHVNCSVAPlQWVza2Jd/0vJS/eWKEO4imQ64b5UN4/Y+SSim/nivMiZcpIQ?=
 =?us-ascii?Q?ShVlT2IPl2W71kOqZTePnaKuXFgDC+b3Sy97rbTiZqtW3ZujvQzrC+AJapoV?=
 =?us-ascii?Q?l6sNSGNzDoZ60uMVNW3i507YP3MqYG+uCOk26xcGwk6xJhOKvhU0ZWn1u+hf?=
 =?us-ascii?Q?WMdm9PGJ//GuGb7dmWWkL3sBi8MS/f/STN6Sm/RDJkfcLmOcJzqpmV/NY8VT?=
 =?us-ascii?Q?PKjNaSmzefBQa1jd1jE4M+2UBJpFqap3QYv/efw8NrretnQTD0vPmgdtf4/q?=
 =?us-ascii?Q?e1WKml1H10vtTisiX5VausApdgPyLC3VT5WlBfiiPNWyFRjiVIa5dltSHbhN?=
 =?us-ascii?Q?I1sPNuyrkDyifIBfsp8STYICrdCeS7lI3nqfD4LPrUBjaxMfQIZi+703Nimp?=
 =?us-ascii?Q?wjSP8I0PWAXso7GKB/WsF8bUm4opaI+aiJV9QAeRP/A=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2021 10:48:20.0025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-Network-Message-Id: dc1d2521-ee78-430f-5206-08d8b61e690e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z9xw5HgHWecku6HmXVvsv/Pb+0mxSh1geYbSiDKjitZhSVp0nv/IFd4OkpXvhqgTWxb0q76vJ2uQoKW7pO3JmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3304
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yanfei Xu <yanfei.xu@windriver.com>

The old _do_fork() helper has been removed in favor of kernel_clone().
Here correct some comments which still contain _do_fork()

Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
---
 include/trace/events/sched.h | 2 +-
 kernel/kthread.c             | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 5039af667645..cbe3e152d24c 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -366,7 +366,7 @@ TRACE_EVENT(sched_process_wait,
 );
 
 /*
- * Tracepoint for do_fork:
+ * Tracepoint for kernel_clone:
  */
 TRACE_EVENT(sched_process_fork,
 
diff --git a/kernel/kthread.c b/kernel/kthread.c
index a5eceecd4513..fb9c3dcbb68d 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -294,7 +294,7 @@ static int kthread(void *_create)
 	do_exit(ret);
 }
 
-/* called from do_fork() to get node information for about to be created task */
+/* called from kernel_clone() to get node information for about to be created task */
 int tsk_fork_get_node(struct task_struct *tsk)
 {
 #ifdef CONFIG_NUMA
-- 
2.18.2

