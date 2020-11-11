Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA242AED13
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 10:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgKKJOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 04:14:14 -0500
Received: from mail-co1nam11on2044.outbound.protection.outlook.com ([40.107.220.44]:21781
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725830AbgKKJOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 04:14:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FEX95jgQnVwehHNZgs6SEs0MOzcPZHr2+4gFd+hKgus/67/9rYGCCYu717rf+II4DB6SjCWg9OUCs5MuFoUMsWKx+bnH/ErT8uBB1NVzVqzsezH84ZosiF1RvVmrNBH2vV86xgSrlpbOI4Sf2biyuOsyqfBMXt0cujyJ79Yiv6GrSeuKsqQ5HoJVpxa2DwuVUU9aU7PJ1xmFBNCB2sK7it6vkqz4hiGZh3uijUfW0aLNo3GveIfpWPabGe7H3jX+PSWpCEqvYxuTXCWmyf8t8S31ibEV9XbM6cO5Cc7f+quJUG1BGBQnLt9jdlaPI2ZZh16bIRI/8sYoZxybK8wPxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C8eZ334gbrlX+LvvtMPeUx60oKI9YOF3MhlX1+xS5Zw=;
 b=Df2FRQFuUB1OgF0+1hrkBY/EnzuznCyRJd4PrYVZRf5F/buprooFQOhafuQK68T2ECsSIrZAFDbm922AmBjf2rOX/mMvaQeEn7Rz4RzZUw091/lrfhTVYf1G1uaH2KxFHP6elvnrMXB5zWxzF6aqBSFy/H3TweXA+TuKOyX2n90E2u14xNfgQ+PGEC7zClru8hI3jK7bDukzNEKgvLOkEuuJRCf/trEZQMVBAPd2ZQ92tF60aDC/aoe0F+dIArPJck288KDO32Su3RC+MYSTMhpH/BZgAHCrO68GmNKNrVIAHgB2XMrKpB01yZeOE/yFe0VTjSLV/u+P40RnT5MkLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C8eZ334gbrlX+LvvtMPeUx60oKI9YOF3MhlX1+xS5Zw=;
 b=TfEeNDGBrut6lMp3D7wCJ5/ktyZGyp4yJvbsxXZmnqLGuVYY8rY/6cv4fWSnsbLU7ylu/3ynAaVDlUmK6bmsPjwrF8daR2mPEMo8M0xQnG9xvlXUcj0IJhtDXIDHXjdYs2Fv6hfTmKWmKoRaO3E5dLRNR1c1oIIWtfImOp3bXrk=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=windriver.com;
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BYAPR11MB3301.namprd11.prod.outlook.com (2603:10b6:a03:7f::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25; Wed, 11 Nov
 2020 09:14:09 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::dc7e:c582:20a1:5bc7]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::dc7e:c582:20a1:5bc7%6]) with mapi id 15.20.3541.025; Wed, 11 Nov 2020
 09:14:09 +0000
From:   qiang.zhang@windriver.com
To:     pmladek@suse.com, tj@kernel.org
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kthread_worker: Add flush delayed work func
Date:   Wed, 11 Nov 2020 17:13:55 +0800
Message-Id: <20201111091355.19476-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK0PR03CA0111.apcprd03.prod.outlook.com
 (2603:1096:203:b0::27) To BYAPR11MB2632.namprd11.prod.outlook.com
 (2603:10b6:a02:c4::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-qzhang2-d1.wrs.com (60.247.85.82) by HK0PR03CA0111.apcprd03.prod.outlook.com (2603:1096:203:b0::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Wed, 11 Nov 2020 09:14:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6050f2f6-797a-45d9-99e3-08d8862225a9
X-MS-TrafficTypeDiagnostic: BYAPR11MB3301:
X-Microsoft-Antispam-PRVS: <BYAPR11MB3301948DC3A3FB2EA8D4D963FFE80@BYAPR11MB3301.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cV11jmJfz5ej42AzlO5/FGVjpk2ksGfs0sYLThA4Up1BQElGDKNipFJvI635y/qFrRLGpN3cFvMFw2bbFXJsJKfdi1BPb3ZZTlBxv/GoTbfRxpBYh/63g+aZrx4XdDsf1zjz36fTUibWTwlbGRYfWh72ZHZXkPpP4iAUpCB5FvQhzqzB/kusstfxvvCOfkhGEP5SiI7mf5LtRXYYeQkUUhE+mwabDSN0P0WYZr/QqGhMfANEQ1TIlp6NjiAdcS35kX7ZVhPDvOywo+8D5S1/VuuDdNebydM3ZS+IEjrdYbJxMgMDpGwUyTViWFceZ/PS9tJw3332KfmtGgZdXQRkOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(39840400004)(346002)(376002)(186003)(6486002)(83380400001)(16526019)(4326008)(66476007)(66946007)(316002)(2906002)(478600001)(26005)(6666004)(36756003)(66556008)(1076003)(5660300002)(8676002)(6506007)(86362001)(2616005)(6512007)(52116002)(8936002)(956004)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: kwsnBIO2gn9NG0Z2dKdp0dsdNTvYT2cEOJlxt/emALK+KwSbBEefyX2KtULg9zrR8vCixKCFa/VoRRX2fzM8gIvSGCz6uXY7U4zKqlihz2HlU/iVxmNGXTIOSPBYNjpjmnSPDRDCwDOYGyqZBVJtJo1NcOIF8oI07qP9kLrl36GAg2B4GyPsCD69ejvjUEIvdOycczsHv8tC+8yC3q9iYL/kHYcXHiuCicYR2MtQpqp/prUgXgi3IGl+HCDqa4QrmuJutqD6a+xoAT6kPn2T1XuLRGkn9UIH58RZAByOaU0TX3MYEdMwYoJNTeay2/uMwG5KqA2XYXKstnqmJZXcv2L7EesxftKx1Rs1EqdmjEpZydAZcUDHPcSUgaPeYrfMlYQZ2tePYG1E6m8vfvn0GxvMg6H2fILjSG+vIttxHgtTPyLs/Vi4Z72hDGe8tpuwsFiePz1WBjhGFcBJuDaLyh2DuLY5NbwwQNCH3cC4PUyNekRUgPQVV/s0QoFHiLuOwYQ2F0m+MWIPrlMRcKXaCFRglxgg1v9VUixAB6vVPyDzOE8//g9NJNUHX/CHIx3XvVuSPHbYc4W2utKkg6M8NUSv9Yt6qu+wKOod6gNq1xgW4fqvr7DjnShxhk7Mm4vrFyDLZVZ7D9LN0TQ3DGORSQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6050f2f6-797a-45d9-99e3-08d8862225a9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2020 09:14:09.4385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MMw7bboxHxOYHE+Gc6LikMDx25+iNEgZtAesbr39hHHVm9zdxRFofBVYMDRpFnJn6KMY47emBVEG2aF5ud+5fAUSvCTvM57khNddTNrJe+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3301
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zqiang <qiang.zhang@windriver.com>

Add 'kthread_flush_delayed_work' func, the principle of
this func is wait for a dwork to finish executing the
last queueing.

Signed-off-by: Zqiang <qiang.zhang@windriver.com>
---
 kernel/kthread.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index a5eceecd4513..1afe399ccd02 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -1045,6 +1045,30 @@ void kthread_flush_work(struct kthread_work *work)
 }
 EXPORT_SYMBOL_GPL(kthread_flush_work);
 
+/*
+ * kthread_flush_delayed_work - flush a kthread_delayed_work
+ * @dwork: dwork to flush
+ *
+ * wait for a dwork to finish executing the last queueing
+ */
+void kthread_flush_delayed_work(struct kthread_delayed_work *dwork)
+{
+	struct kthread_work *work = &dwork->work;
+	struct kthread_worker *worker = work->worker;
+	unsigned long flags;
+
+	if (del_timer_sync(&dwork->timer)) {
+		raw_spin_lock_irqsave(&worker->lock, flags);
+		list_del_init(&work->node);
+		if (!work->canceling)
+			kthread_insert_work(worker, work, &worker->work_list);
+
+		raw_spin_unlock_irqrestore(&worker->lock, flags);
+	}
+	kthread_flush_work(work);
+}
+EXPORT_SYMBOL_GPL(kthread_flush_delayed_work);
+
 /*
  * This function removes the work from the worker queue. Also it makes sure
  * that it won't get queued later via the delayed work's timer.
-- 
2.17.1

