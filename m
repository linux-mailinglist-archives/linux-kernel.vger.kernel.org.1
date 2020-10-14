Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABDF428DB91
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 10:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbgJNIal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 04:30:41 -0400
Received: from mail-dm6nam12on2086.outbound.protection.outlook.com ([40.107.243.86]:45408
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726138AbgJNIak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 04:30:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BDMIa225C8x3KHnfsbZO5llCgJvdfnqlxJMYl7uDTxPCVDQX1aTuR3W35MDXtT79rDYY6fcglRF7l9S2zGXE0edTKEWFMbfUF63Gkl3v35SXomMMKpoKbPI87wrkBKW9YosHlScecI2KtQsktGFwPXteIRjq4DdGAGz94EVIwXps5RBdfIZQYh5BU2btX0RtKRGIp4/Bfh6n2tARdS7Ody7m97vEqlFNXO3n6gtuP41OLnS+9md5vfsbVfU6sGlXc/rw4U+FEt0lIZQdnxVlhvIR0WiX9J882fWxUNXMRqeW7aK7cyak3BTufFEURUGj9eTThXlh7ydzsuepTsrlKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Svf8rBKn2AP5ICQU3Up1KmOksFAv4cHs9U1GZzR82g=;
 b=fo4EIeMtZJm7O9UKcYXR1JOP4iClLJFMWgOlMunbnma68X45iUBLNYLd84gMhflb5/pcU5kVhtq+plIKtwc95aLDlcj+L4htSNiL3Zxc7KSmNYmkHIvkBOaGtDBwIoOu+7fxBe8cE5QTlvGysDZlzcBD59pMbIZ8W/A9HPmTAuuK9wfKe2v33eD4RthuqQ2HTmJgLazvqkYn/5ATcpRW156NM4ixfPVkr96h8upMzLZYrktY201R0kOR1s9XkgF+ckBVD6uYpXcl/IoJRPqdRMOEvVpFWl2efSukleGj1xzLMI5yXC1DWX4zahdVhSqkN1HmqOo6mJlvUN51pxaCnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Svf8rBKn2AP5ICQU3Up1KmOksFAv4cHs9U1GZzR82g=;
 b=CeLE8/nwzQHDAakulwEHC8IjwpElTrM/mSrmNZpoQbznt0/Mt+ivsYGCYKqS6GjnumzlH7aj7Qn7QdnJP57mg2Am22ZOK1BB53aHAn1ItggT3DJAtFIuX5L83BcGmNWtpk3B3l4gfRUAwpBC4zitht7HHsxLseQA12DofBQ7HdA=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BYAPR11MB2679.namprd11.prod.outlook.com (2603:10b6:a02:c7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Wed, 14 Oct
 2020 08:30:40 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::80e9:e002:eeff:4d05]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::80e9:e002:eeff:4d05%3]) with mapi id 15.20.3455.030; Wed, 14 Oct 2020
 08:30:40 +0000
From:   qiang.zhang@windriver.com
To:     tj@kernel.org, pmladek@suse.com, hdanton@sina.com
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v4] kthread_worker: Prevent queuing delayed work from timer_fn when it is being canceled
Date:   Wed, 14 Oct 2020 16:30:30 +0800
Message-Id: <20201014083030.16895-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: BY5PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::22) To BYAPR11MB2632.namprd11.prod.outlook.com
 (2603:10b6:a02:c4::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-qzhang2-d1.wrs.com (60.247.85.82) by BY5PR03CA0012.namprd03.prod.outlook.com (2603:10b6:a03:1e0::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21 via Frontend Transport; Wed, 14 Oct 2020 08:30:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 619fc318-c0c4-4220-3b3e-08d8701b6f2a
X-MS-TrafficTypeDiagnostic: BYAPR11MB2679:
X-Microsoft-Antispam-PRVS: <BYAPR11MB267961DA2F563ED8CE296183FF050@BYAPR11MB2679.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ycs8ICHUkQJKTmABD7NhEAfLOB84wRe7FqwL+dsm5NBvIBqZU3HI1rh8QFUl46iUktR27XV8HAOmAk+WCPSXPs6t/Yep1CHU68xCMXd1BSHdh62Q6WDfP5l32M+I88CDZWm6zO9AUUxkM028dgilx4hADc9zIt9Enc8bhdnXsNqgWYZiNLD8Vv8zJyhbsqXoAsS+3Xr0/h6SmLLnQW5Md3lUszB8D8S22qfEEYS2qPX6VKCWrvKOdg/ROzQmtustl/jzpfmyY6vN1E6/JHGF+rlGUUg2b+tsWx7ATSCl+Uxa2k3aVNxDRRt4uKC3UakPNOAW5yoKAiwIxhJoEwoZxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39850400004)(396003)(136003)(366004)(376002)(86362001)(6666004)(8936002)(186003)(9686003)(6512007)(16526019)(1076003)(26005)(83380400001)(4326008)(66946007)(66476007)(36756003)(316002)(6506007)(66556008)(2616005)(478600001)(5660300002)(8676002)(956004)(52116002)(2906002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: eRkBANU7KMERuFhFuaLf4Tvn2WKdYTIZo2gh/B35LR6Qtu6dwVqd6BFr/Q6D+uvWUYoSG/f5avHyw8pQnIlawu9pAe3p9toDPbIGbNziu4ERbaPoUwJNhJiBVczjXl37badUc/oY/3qnJufZUb3ZO43NXLhzle8aqZL11EvBNDJv0NdK8csqa6i0s1OcOw/xLVy+8t2iYJjgvsJpynBa6eKfonbSFtPN5nx7rR7pTNWtS9GRy5r0bn9RcyMPMoO0+519NX9j4T/NPUYjH16HPDwPMoYcZZM1bGSExN4I5o+SiT9nHMPZYnZ67y9LrA5CTqCXCrMRx/YZv2VTfc/5rI6p5qV1FQBX76nk5B96uxiZVhHd+HjUE0f3wKmfvsssp4YRQWkx+D2h3IIxX6CYJHZS6PEa2JDbNd3yOFLZwc8OyxqIJDZxuncDwFZVttTe6qFJ/yAS5Hf9k7PG7omxXBzpb7BxIBVb0AjCflLPBBcUMEbbxUAXPhXCp3I7pFIsQxUJnV0gc0oc0uxVF/l6J92wkCvdZnP8GZnJlPczRGB2zPOSxYKxaE8TjiOIi+Gqm7RDbcrbas4AZfUYDPHVlYIsJ7aCfk5deHnwKkAkpWxjyByrO+MUoLsCpZgk51moVa2FZ7sHOQxk0bdt7fPFlw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 619fc318-c0c4-4220-3b3e-08d8701b6f2a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 08:30:40.7499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ghwStp6gfqT6n6c5C/G9Bijhl7axEqmCafT4x2UHHH/+07AV5wvff30uXPQTpphH7nrme7mT0/RXqSAT9ka7inS5ODJp5c/rG/STVnRivMc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2679
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zqiang <qiang.zhang@windriver.com>

There is a small race window when a delayed work is being canceled and
the work still might be queued from the timer_fn:

	CPU0						CPU1
kthread_cancel_delayed_work_sync()
   __kthread_cancel_work_sync()
     __kthread_cancel_work()
        work->canceling++;
					      kthread_delayed_work_timer_fn()
						   kthread_insert_work();

BUG: kthread_insert_work() should not get called when work->canceling
is set.

Cc: <stable@vger.kernel.org>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Zqiang <qiang.zhang@windriver.com>
--- 
 v1->v2->v3:
 Change the description of the problem and add 'Reviewed-by' tags.
 v3->v4:
 Add 'stable' and 'Acked-by' tags.

 kernel/kthread.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index 3edaa380dc7b..85a2c9b32049 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -897,7 +897,8 @@ void kthread_delayed_work_timer_fn(struct timer_list *t)
 	/* Move the work from worker->delayed_work_list. */
 	WARN_ON_ONCE(list_empty(&work->node));
 	list_del_init(&work->node);
-	kthread_insert_work(worker, work, &worker->work_list);
+	if (!work->canceling)
+		kthread_insert_work(worker, work, &worker->work_list);
 
 	raw_spin_unlock_irqrestore(&worker->lock, flags);
 }
-- 
2.17.1

