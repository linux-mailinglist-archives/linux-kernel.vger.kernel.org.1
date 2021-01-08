Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB8462EFB72
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 23:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbhAHWwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 17:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbhAHWwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 17:52:13 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63EFDC061798;
        Fri,  8 Jan 2021 14:50:56 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id y23so9691652wmi.1;
        Fri, 08 Jan 2021 14:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M8hpe74Y0ylqdEhOyhfh9qdEDpDAnUYsjuG7nsUgvkQ=;
        b=YxkfN4SGdTskHQVdUnKS/YK6Wb2GAeXqCFRVTHNxJDoC4l5RUrvNvjDXjzNPe2upZD
         8ppsXPzGr//DdMPd/3+wu7Z5cr4IPXziN9ouQKiEj1KfRN729nRrNA6duxQe9qwhy3n/
         n+IZs2IYACFXFKFPIT45RlRQhX/v9EgolEA+mu6pjhOy6yJ+gblYr26Swp4b+zKNKPmC
         5qMzydT6mPLD2H899gUl4UlfvP9bHmhMRshHTLyXqikPfPrk2JMCoXMJrOZju6t9eJoN
         Beg9tjqJF8HbKbzCppTdq7o7OHDko8N4kQ0Vn+stSy8GP57VkAnedvxhXOz4brZL88bb
         94CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M8hpe74Y0ylqdEhOyhfh9qdEDpDAnUYsjuG7nsUgvkQ=;
        b=GuQ15/4wyY5JiCnBas9W+u/UkjRSGO9TEqaj4CHfSKuYFo5fJylueTsa4/5TCLKGjl
         SOYnATQtHq51YxswH3gRE0Gi290o8pdfWNxFyQ6fdN8hRc3CDPV3pPeEyt6op7aJ6F2p
         z3rBBmn9fNR7OpWFQ25WTze1lXO38ElNLgrbNDCbJulJQQi60KGpunSNSeYz8sLDyC9R
         Hpzgtf2TvVLKySqKj0sFsLgPPxjusjS/kDq1ZzTiHvlcXBj8KYC0dLVyprFPmIYy0qeH
         eKBzFuOfPQeRVXsmwBs+VmoDsdMkBNq7enz3dpnMWjf2RMPmFgHS1fENlf1G+iAgm/jR
         u/4w==
X-Gm-Message-State: AOAM530GDy0p090i19SMmuGcp+e50T1XpNG7RKw4p16ieyBdtmsDmbdf
        Rawo5wCEWfoswjU1FT39PdU=
X-Google-Smtp-Source: ABdhPJyW9PBgcWEBHASPVGkghyoyo/ECt3Bn9iEbnbOBaYt5QJ5pDdmxBLXIHh3dJIljDtDFzBM5/g==
X-Received: by 2002:a1c:2c83:: with SMTP id s125mr4879995wms.161.1610146255142;
        Fri, 08 Jan 2021 14:50:55 -0800 (PST)
Received: from adgra-XPS-15-9570.home (2a01cb0008bd270094076597458eade1.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:9407:6597:458e:ade1])
        by smtp.gmail.com with ESMTPSA id o23sm15900644wro.57.2021.01.08.14.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 14:50:54 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     broonie@kernel.org, jagan@amarulasolutions.com,
        lgirdwood@gmail.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v3 5/6] regulator: pf8x00: use linear range for buck 1-6
Date:   Fri,  8 Jan 2021 23:50:05 +0100
Message-Id: <20210108225006.153700-6-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210108225006.153700-1-adrien.grassein@gmail.com>
References: <20210108225006.153700-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a linear range to describe the voltages of the
bucks 1-6 instead of listing it one by one (via a macro)

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
---
 drivers/regulator/pf8x00-regulator.c | 40 +++++++---------------------
 1 file changed, 9 insertions(+), 31 deletions(-)

diff --git a/drivers/regulator/pf8x00-regulator.c b/drivers/regulator/pf8x00-regulator.c
index 90383e394f85..4b57f74e7326 100644
--- a/drivers/regulator/pf8x00-regulator.c
+++ b/drivers/regulator/pf8x00-regulator.c
@@ -147,35 +147,11 @@ static const unsigned int pf8x00_sw_current_table[] = {
 	2100000, 2600000, 3000000, 4500000,
 };
 
-#define SWV(i)		(6250 * i + 400000)
-#define SWV_LINE(i)	SWV(i*8+0), SWV(i*8+1), SWV(i*8+2), SWV(i*8+3), \
-			SWV(i*8+4), SWV(i*8+5), SWV(i*8+6), SWV(i*8+7)
-
 /* Output: 0.4V to 1.8V */
-static const int pf8x00_sw1_to_6_voltages[] = {
-	SWV_LINE(0),
-	SWV_LINE(1),
-	SWV_LINE(2),
-	SWV_LINE(3),
-	SWV_LINE(4),
-	SWV_LINE(5),
-	SWV_LINE(6),
-	SWV_LINE(7),
-	SWV_LINE(8),
-	SWV_LINE(9),
-	SWV_LINE(10),
-	SWV_LINE(11),
-	SWV_LINE(12),
-	SWV_LINE(13),
-	SWV_LINE(14),
-	SWV_LINE(15),
-	SWV_LINE(16),
-	SWV_LINE(17),
-	SWV_LINE(18),
-	SWV_LINE(19),
-	SWV_LINE(20),
-	SWV_LINE(21),
-	1500000, 1800000,
+#define PF8XOO_SW1_6_VOLTAGE_NUM 0xB2
+static const struct linear_range pf8x00_sw1_to_6_voltages[] = {
+	REGULATOR_LINEAR_RANGE(400000, 0x00, 0xB0, 6250),
+	REGULATOR_LINEAR_RANGE(1800000, 0xB1, 0xB1, 0),
 };
 
 /* Output: 1.0V to 4.1V */
@@ -240,7 +216,7 @@ static const struct regulator_ops pf8x00_buck1_6_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
 	.is_enabled = regulator_is_enabled_regmap,
-	.list_voltage = regulator_list_voltage_table,
+	.list_voltage = regulator_list_voltage_linear_range,
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 	.get_current_limit = regulator_get_current_limit_regmap,
@@ -294,12 +270,14 @@ static const struct regulator_ops pf8x00_vsnvs_ops = {
 			.of_match = _name,			\
 			.regulators_node = "regulators",	\
 			.of_parse_cb = pf8x00_of_parse_cb,	\
-			.n_voltages = ARRAY_SIZE(voltages),	\
+			.n_voltages = PF8XOO_SW1_6_VOLTAGE_NUM,	\
 			.ops = &pf8x00_buck1_6_ops,		\
 			.type = REGULATOR_VOLTAGE,		\
 			.id = PF8X00_BUCK ## _id,		\
 			.owner = THIS_MODULE,			\
-			.volt_table = voltages,			\
+			.linear_ranges = pf8x00_sw1_to_6_voltages, \
+			.n_linear_ranges = \
+				ARRAY_SIZE(pf8x00_sw1_to_6_voltages), \
 			.vsel_reg = (base) + SW_RUN_VOLT,	\
 			.vsel_mask = 0xff,			\
 			.curr_table = pf8x00_sw_current_table, \
-- 
2.25.1

