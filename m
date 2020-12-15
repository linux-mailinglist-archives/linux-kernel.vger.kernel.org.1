Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF2912DB750
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 01:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbgLPAB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 19:01:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgLOX6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 18:58:30 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C228AC061793;
        Tue, 15 Dec 2020 15:57:49 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id e25so804126wme.0;
        Tue, 15 Dec 2020 15:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WKxyKv5Vyo6rLK3P0ayFnk4+OFVhwfk8r0VDndedKFQ=;
        b=UxJdc8UCiFt5HUoCcnfbmksH4dcJvng0S8iIRtgAwq/TC4IynPpqlQw+gKxeRpoLwa
         QfSzbnIChReD09o16wxIOkLYlQQCVWqslLrb84tew3X4jBdPTBjcL7pwvmwkEoERuSOj
         Q8i758LK0CfsjhFBJQAkj7ceQZt5JeMlSMClp08BoV7j3NKEyCgS742WHhVkorn/3/DS
         O2HTP0AjixO/sSannH0ZicVZwJWKtpHKEziuJcF32pMzXLCGDgP28LC8YmL322R1XbVW
         vaLFWyCW04QGy3/BvyfY+8LUP8h3inxz00syaV9ShQPKyLBgy92jCuAaVljTTX7bg56+
         QDyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WKxyKv5Vyo6rLK3P0ayFnk4+OFVhwfk8r0VDndedKFQ=;
        b=ggzyIr2q92UGv3oPuje0RoKwB53YrlIM7BhKBtsAvRVyR2CnLRm0tTFlV8ONnONsVy
         p7swYbDCfzmrdji32fa2P5L/iglI2OgVGR4rEr4hte0xTqGN4mANxRiNYc4vUtPjYl5i
         4O2gr6RynoALKijdJVjU1DhvQb+c+vMLXCRQUoVN9i1U+8rA1SkQ3HbcWdFakYOQ+uA4
         4tycUjsqWiGuCADmtAc9Gh7pEKsXONtehtIyeEoSgSEpWwQ4cQkPs+BO4fbFHJV12WoZ
         F5qobskMCekyNzSPX8bLkNDoiTGInWmbfDnihFeiTSJsflTpjiAbW9tmkRJj11O9NvvV
         J+/w==
X-Gm-Message-State: AOAM5326hwrS5yY+a1PoxLS+/71J7C1AltDDpRQI4Ehw70Bol97VLQWw
        NIrIu/BhOKTnptE6FfKrs/U=
X-Google-Smtp-Source: ABdhPJza0WyIqn8XhPVkMC6KtdkoN2+oLJrdjVKe0VNrN/LMXplDSZg1X55OpF9zJX1RceT35MOj1Q==
X-Received: by 2002:a1c:49c2:: with SMTP id w185mr815763wma.184.1608076668573;
        Tue, 15 Dec 2020 15:57:48 -0800 (PST)
Received: from adgra-XPS-15-9570.home (lfbn-idf1-1-1007-144.w86-238.abo.wanadoo.fr. [86.238.83.144])
        by smtp.gmail.com with ESMTPSA id c10sm204160wrb.92.2020.12.15.15.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 15:57:48 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     broonie@kernel.org, jagan@amarulasolutions.com,
        lgirdwood@gmail.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        troy.kisky@boundarydevices.com,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v2 6/7] regulator: pf8x00: use linear range for buck 1-6
Date:   Wed, 16 Dec 2020 00:56:38 +0100
Message-Id: <20201215235639.31516-7-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201215235639.31516-1-adrien.grassein@gmail.com>
References: <20201215235639.31516-1-adrien.grassein@gmail.com>
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
index ebb0ef0745f1..5ad940b3db0a 100644
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
2.20.1

