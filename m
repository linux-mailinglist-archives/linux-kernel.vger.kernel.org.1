Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE6DB245DA5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 09:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbgHQHML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 03:12:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:57880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726747AbgHQHLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 03:11:23 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 713B422C9F;
        Mon, 17 Aug 2020 07:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597648277;
        bh=F4/0N358UMInRTChm1W025kSLWvagEEmCODOlEavrPA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LsuTlGibP80pkRNNjwvuxRN7Z5gbrkcKaN5JHtTv8TKBXqolnC/VfiOiuMjibS6KJ
         /PX6QYjUpZ6MbPvQDmnLYXu1zY3sXZV+qw8MNiS75e7oXvE8pYM12RW+pKs/b1bizD
         vI0mkg/Ubk19GTqs8fr3mVOe25xKr39479RMudOM=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k7ZIZ-00Bdk2-Jk; Mon, 17 Aug 2020 09:11:15 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH v3 18/44] staging: mfd: hi6421-spmi-pmic: cleanup OF properties
Date:   Mon, 17 Aug 2020 09:10:37 +0200
Message-Id: <24ffcd28a17ee7b0940d8aabef556d172d5feddf.1597647359.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597647359.git.mchehab+huawei@kernel.org>
References: <cover.1597647359.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the names of the DT properties and do some cleanups,
in order to better document them.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/hi6421-spmi-pmic.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
index f523b2d844b9..aed2d3ec2227 100644
--- a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
+++ b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
@@ -209,37 +209,37 @@ static int get_pmic_device_tree_data(struct device_node *np, struct hisi_pmic *p
 	int ret = 0;
 
 	/*get pmic irq num*/
-	ret = of_property_read_u32_array(np, "hisilicon,hisi-pmic-irq-num",
+	ret = of_property_read_u32_array(np, "irq-num",
 					 &pmic->irqnum, 1);
 	if (ret) {
-		pr_err("no hisilicon,hisi-pmic-irq-num property set\n");
+		pr_err("no irq-num property set\n");
 		ret = -ENODEV;
 		return ret;
 	}
 
 	/*get pmic irq array number*/
-	ret = of_property_read_u32_array(np, "hisilicon,hisi-pmic-irq-array",
+	ret = of_property_read_u32_array(np, "irq-array",
 					 &pmic->irqarray, 1);
 	if (ret) {
-		pr_err("no hisilicon,hisi-pmic-irq-array property set\n");
+		pr_err("no irq-array property set\n");
 		ret = -ENODEV;
 		return ret;
 	}
 
 	/*SOC_PMIC_IRQ_MASK_0_ADDR*/
-	ret = of_property_read_u32_array(np, "hisilicon,hisi-pmic-irq-mask-addr",
+	ret = of_property_read_u32_array(np, "irq-mask-addr",
 					 (int *)&pmic->irq_mask_addr, 2);
 	if (ret) {
-		pr_err("no hisilicon,hisi-pmic-irq-mask-addr property set\n");
+		pr_err("no irq-mask-addr property set\n");
 		ret = -ENODEV;
 		return ret;
 	}
 
 	/*SOC_PMIC_IRQ0_ADDR*/
-	ret = of_property_read_u32_array(np, "hisilicon,hisi-pmic-irq-addr",
+	ret = of_property_read_u32_array(np, "irq-addr",
 					 (int *)&pmic->irq_addr, 2);
 	if (ret) {
-		pr_err("no hisilicon,hisi-pmic-irq-addr property set\n");
+		pr_err("no irq-addr property set\n");
 		ret = -ENODEV;
 		return ret;
 	}
-- 
2.26.2

