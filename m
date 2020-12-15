Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59B032DB569
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 21:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbgLOUvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 15:51:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727976AbgLOUuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 15:50:04 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47D4C0611C5;
        Tue, 15 Dec 2020 12:49:06 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id a3so478308wmb.5;
        Tue, 15 Dec 2020 12:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VOwHUnMwDHMUa1rvKsjcJQjz89OY4wK32GabZtinnfs=;
        b=JiKE4GdKngSvirj6RPyQCf/4W4u3+uAUVJDsXak4jPfNAqyvAfjDoM7lQawtzs5v0P
         sd+yF/xgz0GSrkp8iudQh7KprfEPRKbHNIHEPMhgodwMZ00bctzVTUvrKTd9qkGVsz2U
         h78SGkGAb5oZfzw+t3rIEHkBFllc0guCskkN6vRZjS4s4PW0EX9l9LTX9u0EgerId/Qr
         Aczf4uhyDjsVUKC8EPUUFcShOOruCygyPUB8A93MpaJVpQCyTWsLRClYGyXzomn6FmwE
         ZKzzkiCofTeMAk+RGYhgIPXQVXkFRuOQPYkJ4mL4A2NMapIyVnmsCwxrRsQOMZYl52hx
         17Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VOwHUnMwDHMUa1rvKsjcJQjz89OY4wK32GabZtinnfs=;
        b=gU+l1TjvViiEi8MmCNJhU1ZO/JKdRrwudWbQyhU4i5+G/wpt+gaRbK9gvxOlsljww2
         oHeLbFsJZchgoBgjSA5kLsQEEfPP6NHD46+TGkA7N53Kp+UhNY9yjLCPdwrqd/u7WikZ
         PYMvCMSrW863nVWfiXmP4W82hP8aOVMz2hhF+BAe7pBq2X04Y/RWwvtt+VMIF071mZXE
         K8t9XpASR2X3UaV4MU6kCKu2Nsdybny8UaSnKlb26aGAgIOn4P98yGvSIiMnpJe0NYag
         1thhWbIRZ9dFPK4Wcw5eO7qNn8GsB6Jz62eRAmbBoqcW7w+hTXn2pRltxwJZxyhRDoiO
         TFjQ==
X-Gm-Message-State: AOAM530XqgL3BVEQCPaxC1ilWzWSety/tUY/sfPDnSIBQ7PNxXhztUUu
        hPMszMJjb2QibpY/Zd2cXdQ=
X-Google-Smtp-Source: ABdhPJwUBlAAAIikGf7hdg7ZgN0kqFVuwCfdpLy6iwzBFB3Wy9PmPulKRvOQMm+EvmJGfFJYvU/F5g==
X-Received: by 2002:a1c:6208:: with SMTP id w8mr597439wmb.96.1608065345725;
        Tue, 15 Dec 2020 12:49:05 -0800 (PST)
Received: from adgra-XPS-15-9570.home (lfbn-idf1-1-1007-144.w86-238.abo.wanadoo.fr. [86.238.83.144])
        by smtp.gmail.com with ESMTPSA id i16sm37199246wrx.89.2020.12.15.12.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 12:49:04 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
To:     broonie@kernel.org, jagan@amarulasolutions.com
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        troy.kisky@boundarydevices.com,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH 6/6] regulator: pf8x00: use linear range for buck 1-6
Date:   Tue, 15 Dec 2020 21:48:58 +0100
Message-Id: <20201215204858.8186-7-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201215204858.8186-1-adrien.grassein@gmail.com>
References: <20201215204858.8186-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a linear range to describe the voltages of the
bucks 1-6 instead of listing it one by one (via a macro)

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
---
 drivers/regulator/pf8x00-regulator.c | 38 ++++++----------------------
 1 file changed, 8 insertions(+), 30 deletions(-)

diff --git a/drivers/regulator/pf8x00-regulator.c b/drivers/regulator/pf8x00-regulator.c
index 335aa77ef5fc..d5c1916c0646 100644
--- a/drivers/regulator/pf8x00-regulator.c
+++ b/drivers/regulator/pf8x00-regulator.c
@@ -155,35 +155,11 @@ static const unsigned int pf8x00_sw_current_table[] = {
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
@@ -248,7 +224,7 @@ static const struct regulator_ops pf8x00_buck1_6_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
 	.is_enabled = regulator_is_enabled_regmap,
-	.list_voltage = regulator_list_voltage_table,
+	.list_voltage = regulator_list_voltage_linear_range,
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 	.get_current_limit = regulator_get_current_limit_regmap,
@@ -307,7 +283,9 @@ static const struct regulator_ops pf8x00_vsnvs_ops = {
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

