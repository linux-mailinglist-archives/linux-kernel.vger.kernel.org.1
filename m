Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7199C273F7D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 12:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgIVKU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 06:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgIVKUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 06:20:51 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CBBC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 03:20:51 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id l71so11573363pge.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 03:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Joo9G8dpZiV+ukJjlPwDuzRh/fKHk3sZ/ezTEfq1J4w=;
        b=J9uP1cs6+B/YsiudN5S6Ow1nA2gyo0SYtCj2mK62DnuUeMv/VvvC+YSmLlGIojl20c
         Gdu9Nm8PnopmEUSNGynTglZaEZwEIiEj1p7B2JjcGs/TiSi21/LPe84W58CI864DrA+q
         uQX/RXyI+cac30GcjAYWG8g/BQCZjCEDZMXgLTvCsAwQR1xmXYdDIxFOXRfCMPzRcRIt
         BlYZ7gJHK+06GZzgrFRZ+owZmVB2KroPPwIMTBGTxezlcPQCbyC0luCYeNMXwZcB3lhu
         WzPMf5ZDbtXO4YZAXCr5Kv01vwWcblL5a8xSI/6tfkvqZgNKeOipX4Fq5SjtNxviqCfT
         Ksuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Joo9G8dpZiV+ukJjlPwDuzRh/fKHk3sZ/ezTEfq1J4w=;
        b=hYuXOpSWbjzHRnoawNEXn18TxIISofCp5c7Sni6lO2B00q06Ye/9D51rYoT3WlhVqa
         sxWuWyG3QAGt2Hwnt4jYsbSFG4IfWtHueZUsezYyu+0BjXsQ4aotmqDgwhF1OdJBMJfg
         QxWrurgBaoiZtIvmrjYlhs1rJLms5yY8q/pJtAwukdfbZEuhgiRVV8UzVVVchR2HxcaI
         FkEJRad+YlHWwIL+dyMmWLLOaDvnNuNZwKFlGWQYRCQ/wK5myeUS9tQUWzXcmurAB9h8
         9c2YjX3JVykE/dSIBSs0TgrqxA3UT58UvrkfXQ6Ribtc/k1s1DyhpBilF4dXh5/um2fm
         Bbag==
X-Gm-Message-State: AOAM531+9ar1Vn5Bpjx08EYNCbJSy91LXtteRBF/br9h/CtW3sP2w3/Y
        jI384l4Ak6WLNvhd6Rcn+5U=
X-Google-Smtp-Source: ABdhPJy5ak3fqE/fdF88qGdH6s7sOyYpvxXPALqUIUmvI+Ri9RQtt023ptdWx9aqoINk4h9m3DqSXg==
X-Received: by 2002:a17:902:b216:b029:d1:e5e7:be05 with SMTP id t22-20020a170902b216b02900d1e5e7be05mr3993925plr.56.1600770051158;
        Tue, 22 Sep 2020 03:20:51 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:489:56d9:501b:f524:c013:2733])
        by smtp.gmail.com with ESMTPSA id a15sm14859037pfi.119.2020.09.22.03.20.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Sep 2020 03:20:50 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     lee.jones@linaro.org, matthias.bgg@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: [PATCH v5 03/10] mfd: mt6360: Indicate sub-dev compatible name by using "-"
Date:   Tue, 22 Sep 2020 18:20:11 +0800
Message-Id: <1600770019-11585-4-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600770019-11585-1-git-send-email-gene.chen.richtek@gmail.com>
References: <1600770019-11585-1-git-send-email-gene.chen.richtek@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

Indicate sub-dev compatible name by using "-".

Signed-off-by: Gene Chen <gene_chen@richtek.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/mt6360-core.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
index befee70..692e47b 100644
--- a/drivers/mfd/mt6360-core.c
+++ b/drivers/mfd/mt6360-core.c
@@ -292,18 +292,18 @@ static const struct resource mt6360_ldo_resources[] = {
 };
 
 static const struct mfd_cell mt6360_devs[] = {
-	OF_MFD_CELL("mt6360_adc", mt6360_adc_resources,
-		    NULL, 0, 0, "mediatek,mt6360_adc"),
-	OF_MFD_CELL("mt6360_chg", mt6360_chg_resources,
-		    NULL, 0, 0, "mediatek,mt6360_chg"),
-	OF_MFD_CELL("mt6360_led", mt6360_led_resources,
-		    NULL, 0, 0, "mediatek,mt6360_led"),
-	OF_MFD_CELL("mt6360_pmic", mt6360_pmic_resources,
-		    NULL, 0, 0, "mediatek,mt6360_pmic"),
-	OF_MFD_CELL("mt6360_ldo", mt6360_ldo_resources,
-		    NULL, 0, 0, "mediatek,mt6360_ldo"),
-	OF_MFD_CELL("mt6360_tcpc", NULL,
-		    NULL, 0, 0, "mediatek,mt6360_tcpc"),
+	OF_MFD_CELL("mt6360-adc", mt6360_adc_resources,
+		    NULL, 0, 0, "mediatek,mt6360-adc"),
+	OF_MFD_CELL("mt6360-chg", mt6360_chg_resources,
+		    NULL, 0, 0, "mediatek,mt6360-chg"),
+	OF_MFD_CELL("mt6360-led", mt6360_led_resources,
+		    NULL, 0, 0, "mediatek,mt6360-led"),
+	OF_MFD_CELL("mt6360-pmic", mt6360_pmic_resources,
+		    NULL, 0, 0, "mediatek,mt6360-pmic"),
+	OF_MFD_CELL("mt6360-ldo", mt6360_ldo_resources,
+		    NULL, 0, 0, "mediatek,mt6360-ldo"),
+	OF_MFD_CELL("mt6360-tcpc", NULL,
+		    NULL, 0, 0, "mediatek,mt6360-tcpc"),
 };
 
 static const unsigned short mt6360_slave_addr[MT6360_SLAVE_MAX] = {
-- 
2.7.4

