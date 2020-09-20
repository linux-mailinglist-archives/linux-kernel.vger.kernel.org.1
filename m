Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82BE327183F
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 23:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgITVlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 17:41:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:51834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbgITVlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 17:41:15 -0400
Received: from localhost.localdomain (unknown [194.230.155.191])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE2BE20829;
        Sun, 20 Sep 2020 21:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600638074;
        bh=6Q4ug0hWEa1GEfOS1tG8oJU9yv/p0VtczqGdqMr744c=;
        h=From:To:Cc:Subject:Date:From;
        b=AMiFAryxlO+ofSKACHsqO2QpbpyQn/JeKsmbPVaV2vj0kkBkrCZQuuCh/uMnWpQSb
         fFE68gYJYAhOEz7Np+lf6qzhO28wJThbmmVcpFsj6ed4pLG++BpfJcFKDFosKPeiEu
         GDxKKgoibk0aiX8oAT4fNqQXwSCtRiP8uAuEkUfk=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] regulator: enable compile testing for Maxim and Samsung PMIC drivers
Date:   Sun, 20 Sep 2020 23:41:07 +0200
Message-Id: <20200920214107.6299-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of Maxim and Samsung PMIC/MUIC regulator drivers can be compile
tested to increase build coverage.  This allows to build them on
configurations without I2C (as I2C is required by dependency - parent
MFD driver).

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/regulator/Kconfig | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 4efa27b0f9f5..278ae0b06aee 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -510,7 +510,7 @@ config REGULATOR_MAX1586
 
 config REGULATOR_MAX77620
 	tristate "Maxim 77620/MAX20024 voltage regulator"
-	depends on MFD_MAX77620
+	depends on MFD_MAX77620 || COMPILE_TEST
 	help
 	  This driver controls Maxim MAX77620 voltage output regulator
 	  via I2C bus. The provided regulator is suitable for Tegra
@@ -519,7 +519,7 @@ config REGULATOR_MAX77620
 
 config REGULATOR_MAX77650
 	tristate "Maxim MAX77650/77651 regulator support"
-	depends on MFD_MAX77650
+	depends on MFD_MAX77650 || COMPILE_TEST
 	help
 	  Regulator driver for MAX77650/77651 PMIC from Maxim
 	  Semiconductor. This device has a SIMO with three independent
@@ -542,7 +542,7 @@ config REGULATOR_MAX8660
 
 config REGULATOR_MAX8907
 	tristate "Maxim 8907 voltage regulator"
-	depends on MFD_MAX8907
+	depends on MFD_MAX8907 || COMPILE_TEST
 	help
 	  This driver controls a Maxim 8907 voltage output regulator
 	  via I2C bus. The provided regulator is suitable for Tegra
@@ -592,7 +592,7 @@ config REGULATOR_MAX8998
 
 config REGULATOR_MAX77686
 	tristate "Maxim 77686 regulator"
-	depends on MFD_MAX77686
+	depends on MFD_MAX77686 || COMPILE_TEST
 	help
 	  This driver controls a Maxim 77686 regulator
 	  via I2C bus. The provided regulator is suitable for
@@ -600,7 +600,7 @@ config REGULATOR_MAX77686
 
 config REGULATOR_MAX77693
 	tristate "Maxim 77693/77843 regulator"
-	depends on (MFD_MAX77693 || MFD_MAX77843)
+	depends on MFD_MAX77693 || MFD_MAX77843 || COMPILE_TEST
 	help
 	  This driver controls a Maxim 77693/77843 regulators via I2C bus.
 	  The regulators include two LDOs, 'SAFEOUT1', 'SAFEOUT2'
@@ -609,7 +609,7 @@ config REGULATOR_MAX77693
 
 config REGULATOR_MAX77802
 	tristate "Maxim 77802 regulator"
-	depends on MFD_MAX77686
+	depends on MFD_MAX77686 || COMPILE_TEST
 	help
 	  This driver controls a Maxim 77802 regulator
 	  via I2C bus. The provided regulator is suitable for
@@ -941,14 +941,14 @@ config REGULATOR_RT5033
 
 config REGULATOR_S2MPA01
 	tristate "Samsung S2MPA01 voltage regulator"
-	depends on MFD_SEC_CORE
+	depends on MFD_SEC_CORE || COMPILE_TEST
 	help
 	 This driver controls Samsung S2MPA01 voltage output regulator
 	 via I2C bus. S2MPA01 has 10 Bucks and 26 LDO outputs.
 
 config REGULATOR_S2MPS11
 	tristate "Samsung S2MPS11/13/14/15/S2MPU02 voltage regulator"
-	depends on MFD_SEC_CORE
+	depends on MFD_SEC_CORE || COMPILE_TEST
 	help
 	 This driver supports a Samsung S2MPS11/13/14/15/S2MPU02 voltage
 	 output regulator via I2C bus. The chip is comprised of high efficient
@@ -957,7 +957,7 @@ config REGULATOR_S2MPS11
 
 config REGULATOR_S5M8767
 	tristate "Samsung S5M8767A voltage regulator"
-	depends on MFD_SEC_CORE
+	depends on MFD_SEC_CORE || COMPILE_TEST
 	help
 	 This driver supports a Samsung S5M8767A voltage output regulator
 	 via I2C bus. S5M8767A have 9 Bucks and 28 LDOs output and
-- 
2.17.1

