Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEBB7273F7E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 12:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgIVKU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 06:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbgIVKUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 06:20:55 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A897C061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 03:20:55 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id k14so11559250pgi.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 03:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=t5bxP7SBsyG/FaxnJHfQjTjpWsNLjhkZMYmiwNpRv5E=;
        b=hjzB0Tn+e1tqlMWN/8vAurHTJovCYlNFo33wzfKzxK/BSxjT+a6gJwTPsGAWYHvvKP
         CB2S3Yl2oe410H+Hw3kE2nXCgSX6aG+jJYSGohvOw2GJHHl1B7zp7OpWZGvCeqbqcpMm
         5uqt259jXkIexa0/jIwZe7+2VbfFZ1SbvoKLQJdafVOHuYhmNNPaOfluHhPC2WekjwUC
         Q2Fs1o52Og0j0m67TdEoYON34u6yya46oSjJ2dr37J3ATIhymi3Mv841xcRJbEsH9lDF
         crXaXYA1HRjd6vXEH0WbnrJc06r9bpDNIDWIiI0ZyJ3too8d0TIWR8o+ssEbFgWMu/RD
         IBKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=t5bxP7SBsyG/FaxnJHfQjTjpWsNLjhkZMYmiwNpRv5E=;
        b=BMhU0+olX7mdyTUR8SOhb5SLKywfXS3fVxT2NFXWG/F2XP9Z8hLTxMVEt49LjWu+yi
         SoTJBDWRnUTq6QlYNLnMNYrQhQDtoVOgWFJCUXydPBmna4Pzc+0T1bl232EW4VIVsP7Z
         GBTjKyFohRVbbwyYpRrR2Nn88O+RGzmVLlyFILQg+1Mjou6sax4Oh/XcFZS8HSEyq0qw
         JNDzNxMuGJY4RNqXnT1TZDos0myPOO9w+bQUjUJDZs38kJnVpTdVkJoXMhLS/OsgQR9n
         ZdRV8bb3VLdI0kJE+xw0SJvIgqZS43X0ra1YO9501EE7CBoStaQZA7eKU2OD1H+NQGgl
         Y3ww==
X-Gm-Message-State: AOAM531udCzqIt24TDniFC7y7dXKOuoHFtmuir6VoGmBlrFIflkDGonC
        hIaJwXz3WDk2ITbcSLLkQsE=
X-Google-Smtp-Source: ABdhPJyiL8lEbxFoQpmM4mEVqPw7egesz4ShUvdfOUira1TDWuI3zZOafQmiB9Ei2Nr05DRJr1wu4g==
X-Received: by 2002:a17:902:d913:b029:d1:f388:9fa6 with SMTP id c19-20020a170902d913b02900d1f3889fa6mr3938165plz.67.1600770054996;
        Tue, 22 Sep 2020 03:20:54 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:489:56d9:501b:f524:c013:2733])
        by smtp.gmail.com with ESMTPSA id a15sm14859037pfi.119.2020.09.22.03.20.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Sep 2020 03:20:54 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     lee.jones@linaro.org, matthias.bgg@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: [PATCH v5 04/10] mfd: mt6360: Combine mt6360 pmic/ldo resources into mt6360 regulator resources
Date:   Tue, 22 Sep 2020 18:20:12 +0800
Message-Id: <1600770019-11585-5-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600770019-11585-1-git-send-email-gene.chen.richtek@gmail.com>
References: <1600770019-11585-1-git-send-email-gene.chen.richtek@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

Combine mt6360 pmic/ldo resources into mt6360 regulator resources
to simplify the similar resources object.

Signed-off-by: Gene Chen <gene_chen@richtek.com>
---
 drivers/mfd/mt6360-core.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
index 692e47b..5119e51 100644
--- a/drivers/mfd/mt6360-core.c
+++ b/drivers/mfd/mt6360-core.c
@@ -265,7 +265,7 @@ static const struct resource mt6360_led_resources[] = {
 	DEFINE_RES_IRQ_NAMED(MT6360_FLED1_STRB_TO_EVT, "fled1_strb_to_evt"),
 };
 
-static const struct resource mt6360_pmic_resources[] = {
+static const struct resource mt6360_regulator_resources[] = {
 	DEFINE_RES_IRQ_NAMED(MT6360_BUCK1_PGB_EVT, "buck1_pgb_evt"),
 	DEFINE_RES_IRQ_NAMED(MT6360_BUCK1_OC_EVT, "buck1_oc_evt"),
 	DEFINE_RES_IRQ_NAMED(MT6360_BUCK1_OV_EVT, "buck1_ov_evt"),
@@ -278,9 +278,6 @@ static const struct resource mt6360_pmic_resources[] = {
 	DEFINE_RES_IRQ_NAMED(MT6360_LDO7_OC_EVT, "ldo7_oc_evt"),
 	DEFINE_RES_IRQ_NAMED(MT6360_LDO6_PGB_EVT, "ldo6_pgb_evt"),
 	DEFINE_RES_IRQ_NAMED(MT6360_LDO7_PGB_EVT, "ldo7_pgb_evt"),
-};
-
-static const struct resource mt6360_ldo_resources[] = {
 	DEFINE_RES_IRQ_NAMED(MT6360_LDO1_OC_EVT, "ldo1_oc_evt"),
 	DEFINE_RES_IRQ_NAMED(MT6360_LDO2_OC_EVT, "ldo2_oc_evt"),
 	DEFINE_RES_IRQ_NAMED(MT6360_LDO3_OC_EVT, "ldo3_oc_evt"),
@@ -298,10 +295,8 @@ static const struct mfd_cell mt6360_devs[] = {
 		    NULL, 0, 0, "mediatek,mt6360-chg"),
 	OF_MFD_CELL("mt6360-led", mt6360_led_resources,
 		    NULL, 0, 0, "mediatek,mt6360-led"),
-	OF_MFD_CELL("mt6360-pmic", mt6360_pmic_resources,
-		    NULL, 0, 0, "mediatek,mt6360-pmic"),
-	OF_MFD_CELL("mt6360-ldo", mt6360_ldo_resources,
-		    NULL, 0, 0, "mediatek,mt6360-ldo"),
+	OF_MFD_CELL("mt6360-regulator", mt6360_regulator_resources,
+		    NULL, 0, 0, "mediatek,mt6360-regulator"),
 	OF_MFD_CELL("mt6360-tcpc", NULL,
 		    NULL, 0, 0, "mediatek,mt6360-tcpc"),
 };
-- 
2.7.4

