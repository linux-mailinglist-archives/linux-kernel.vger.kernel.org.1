Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEA6273F81
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 12:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbgIVKVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 06:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbgIVKVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 06:21:11 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30D4C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 03:21:11 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 7so11555013pgm.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 03:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eTozcscQct40BurorhsUtgIPXBxStv+/H/KVS2Q9tCE=;
        b=bQWsrq6u+hyFzIcLsfxU+jUSQq6Bgm7eQGESQazBKVb9Gmdg8YUmxFZ/RD914DIpXl
         9m1hHPDOZxSDcM2znik7ci5uh8wslt5vHtlI8O0OogNSv4Ey5cNbDwVo1ldIjHg4QO8j
         J6+X+UV+YbR9N1FdxLkE7pxIRpGuYXaBazwsvf5VnmRhdw1O48C6WCbzVbHEBUKC0FTH
         dJYzPHtK0n0YT33pBJ8gRjywpwEluoz3XpdoBJirTDTa5uYpOzCdiU4N950KhDo6rBkU
         iZA1JAXnxJKWcjZilwBEVFf6ZyjaCFx+VOqnz7eA3VUrOZaCSBvyGiadUeUxlElIiP9J
         5Dqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eTozcscQct40BurorhsUtgIPXBxStv+/H/KVS2Q9tCE=;
        b=ewDOZOpmf1ScLxBkBVi79c4LxrmBAvt7Os4GnI/x4GZPQYl6qrAuUci0nXd7Pjg6/p
         zdnZBnt4SZOje2MV6YerjBCblMXkqXEU2AJuZM59ew/Stz4eo1PlLHDzTMK2sxfH2SCK
         F0TRm6Z9Unm/lkxhwBQccWdtRapxZJVmrv2QOOcxdUv2OJg19JwX00Se2LTvYJT1geBz
         jnlVK0X07iXDKXBmgavyP/OeFpnskLnK3sx9wenBAerKySidtJZt7GvidSpglU+epkHK
         n63K0IjsXUZP35EF1N4YWMlwi0g1Zg1raNNmLTKxJryMJiHsT8jQSb/Imr1J/LItTmtW
         Rw9Q==
X-Gm-Message-State: AOAM5303NcTf5bAe6JuJe4zu7v6jGgNqtJVSq/x1C/r3ITPvTBiVDD/j
        mkyW1rRqIbIBNxDLX8U+teDnV4eMrvA=
X-Google-Smtp-Source: ABdhPJypDmOWsT5hKM5KgIgufpr2weGbFukeO4YcsU9r9mwe3wUTFuD1QUS+d8xIJVWG/OnYO4xGcw==
X-Received: by 2002:a63:e249:: with SMTP id y9mr2940042pgj.117.1600770071353;
        Tue, 22 Sep 2020 03:21:11 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:489:56d9:501b:f524:c013:2733])
        by smtp.gmail.com with ESMTPSA id a15sm14859037pfi.119.2020.09.22.03.21.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Sep 2020 03:21:10 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     lee.jones@linaro.org, matthias.bgg@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: [PATCH v5 08/10] mfd: mt6360: Fix flow which is used to check ic exist
Date:   Tue, 22 Sep 2020 18:20:16 +0800
Message-Id: <1600770019-11585-9-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600770019-11585-1-git-send-email-gene.chen.richtek@gmail.com>
References: <1600770019-11585-1-git-send-email-gene.chen.richtek@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

Fix flow which is used to check ic exist.

Signed-off-by: Gene Chen <gene_chen@richtek.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/mt6360-core.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
index 2356d99..677c974 100644
--- a/drivers/mfd/mt6360-core.c
+++ b/drivers/mfd/mt6360-core.c
@@ -293,6 +293,25 @@ static const struct mfd_cell mt6360_devs[] = {
 		    NULL, 0, 0, "mediatek,mt6360-tcpc"),
 };
 
+static int mt6360_check_vendor_info(struct mt6360_ddata *ddata)
+{
+	u32 info;
+	int ret;
+
+	ret = regmap_read(ddata->regmap, MT6360_PMU_DEV_INFO, &info);
+	if (ret < 0)
+		return ret;
+
+	if ((info & CHIP_VEN_MASK) != CHIP_VEN_MT6360) {
+		dev_err(&client->dev, "Device not supported\n");
+		return -ENODEV;
+	}
+
+	ddata->chip_rev = info & CHIP_REV_MASK;
+
+	return 0;
+}
+
 static const unsigned short mt6360_slave_addr[MT6360_SLAVE_MAX] = {
 	MT6360_PMU_SLAVEID,
 	MT6360_PMIC_SLAVEID,
@@ -303,7 +322,6 @@ static const unsigned short mt6360_slave_addr[MT6360_SLAVE_MAX] = {
 static int mt6360_probe(struct i2c_client *client)
 {
 	struct mt6360_ddata *ddata;
-	unsigned int reg_data;
 	int i, ret;
 
 	ddata = devm_kzalloc(&client->dev, sizeof(*ddata), GFP_KERNEL);
@@ -319,17 +337,9 @@ static int mt6360_probe(struct i2c_client *client)
 		return PTR_ERR(ddata->regmap);
 	}
 
-	ret = regmap_read(ddata->regmap, MT6360_PMU_DEV_INFO, &reg_data);
-	if (ret) {
-		dev_err(&client->dev, "Device not found\n");
+	ret = mt6360_check_vendor_info(ddata);
+	if (ret)
 		return ret;
-	}
-
-	ddata->chip_rev = reg_data & CHIP_REV_MASK;
-	if (ddata->chip_rev != CHIP_VEN_MT6360) {
-		dev_err(&client->dev, "Device not supported\n");
-		return -ENODEV;
-	}
 
 	ret = devm_regmap_add_irq_chip(&client->dev, ddata->regmap, client->irq,
 				       0, 0, &mt6360_irq_chip,
-- 
2.7.4

