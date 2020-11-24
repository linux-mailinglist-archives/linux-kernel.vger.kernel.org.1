Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 154DF2C300E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 19:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404315AbgKXSig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 13:38:36 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.82]:16947 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404163AbgKXSif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 13:38:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1606243111;
        s=strato-dkim-0002; d=fossekall.de;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=c9+Aw0zhDi+u9T9vJxY9YbhByQIR/dvqhXcDtth54Z8=;
        b=WcQ11MioIusbI+Er2tP0PJW9ElXqceFFoS+k4+oDgjCVqnolfHMCcxeQPtWaiWji4d
        Rxq0o1V22pjDuwMBVefb86kkrVZIJs9m2Ll0D1KpCS7GeMIix0QxlPVoiLVLG3P1eNHB
        MIu+QTwJ6Kn5TntaIUAoDkum7qH4/u9JX3DYdpd0qWLD3fZoSZip4g4kEbWCAbMrh7kZ
        5wyaOoOzkQP6kpyDRTMwVdLOB95Z0ZIzdplWMBpMvKliBo4uVxZWJiAR4pwudO914T+u
        AQXmmIdfjiiUy4kCyGN2pFB3wNcmb8eo4ceKraK/btAZGSrSRUD+JZW8gKvp3VW/X3HF
        J/ug==
X-RZG-AUTH: ":O2kGeEG7b/pS1EzgE2y7nF0STYsSLflpbjNKxx7cGrBOdI6BL9pkS3QW19mO7I+/JwRspuzJFZuRzQ=="
X-RZG-CLASS-ID: mo00
Received: from aerfugl
        by smtp.strato.de (RZmta 47.3.4 AUTH)
        with ESMTPSA id g02087wAOIcRFbK
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Tue, 24 Nov 2020 19:38:27 +0100 (CET)
Received: from koltrast.a98shuttle.de ([192.168.1.27] helo=a98shuttle.de)
        by aerfugl with smtp (Exim 4.89)
        (envelope-from <michael@a98shuttle.de>)
        id 1khdCp-0008JZ-NF; Tue, 24 Nov 2020 19:38:23 +0100
Received: (nullmailer pid 2250752 invoked by uid 502);
        Tue, 24 Nov 2020 18:38:23 -0000
From:   Michael Klein <michael@fossekall.de>
To:     Andrei Stefanescu <andrei.stefanescu@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, trivial@kernel.org,
        Michael Klein <michael@fossekall.de>
Subject: [PATCH 2/2] mfd: fix spelling mistakes
Date:   Tue, 24 Nov 2020 19:37:30 +0100
Message-Id: <20201124183730.2250690-3-michael@fossekall.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201124183730.2250690-1-michael@fossekall.de>
References: <20201124183730.2250690-1-michael@fossekall.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Michael Klein <michael@fossekall.de>
---
 drivers/regulator/da9055-regulator.c | 4 ++--
 include/linux/mfd/da9055/reg.h       | 4 ++--
 include/linux/mfd/si476x-core.h      | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/da9055-regulator.c b/drivers/regulator/da9055-regulator.c
index 73ff5fc7d8d7..c0394ac5e60a 100644
--- a/drivers/regulator/da9055-regulator.c
+++ b/drivers/regulator/da9055-regulator.c
@@ -184,7 +184,7 @@ static int da9055_regulator_get_voltage_sel(struct regulator_dev *rdev)
 	ret &= info->conf.sel_mask;
 
 	/* Get the voltage for the active register set A/B */
-	if (ret == DA9055_REGUALTOR_SET_A)
+	if (ret == DA9055_REGULATOR_SET_A)
 		ret = da9055_reg_read(regulator->da9055, volt.reg_a);
 	else
 		ret = da9055_reg_read(regulator->da9055, volt.reg_b);
@@ -231,7 +231,7 @@ static int da9055_regulator_set_voltage_sel(struct regulator_dev *rdev,
 	ret &= info->conf.sel_mask;
 
 	/* Set the voltage */
-	if (ret == DA9055_REGUALTOR_SET_A)
+	if (ret == DA9055_REGULATOR_SET_A)
 		return da9055_reg_update(regulator->da9055, info->volt.reg_a,
 					 info->volt.v_mask, selector);
 	else
diff --git a/include/linux/mfd/da9055/reg.h b/include/linux/mfd/da9055/reg.h
index 54a717b6c3de..1204e6b152d5 100644
--- a/include/linux/mfd/da9055/reg.h
+++ b/include/linux/mfd/da9055/reg.h
@@ -344,8 +344,8 @@
 #define	DA9055_VLDO_GPI_MASK		0x60
 #define	DA9055_LDO_CONF_SHIFT		0x07
 #define	DA9055_LDO_CONF_MASK		0x80
-#define	DA9055_REGUALTOR_SET_A		0x00
-#define	DA9055_REGUALTOR_SET_B		0x10
+#define	DA9055_REGULATOR_SET_A		0x00
+#define	DA9055_REGULATOR_SET_B		0x10
 
 /* DA9055_REG_ADC_MAN (addr=0x1B) */
 #define	DA9055_ADC_MUX_SHIFT		0
diff --git a/include/linux/mfd/si476x-core.h b/include/linux/mfd/si476x-core.h
index 4708c2b8512a..dd95c37ca134 100644
--- a/include/linux/mfd/si476x-core.h
+++ b/include/linux/mfd/si476x-core.h
@@ -57,7 +57,7 @@ enum si476x_mfd_cells {
  * @SI476X_POWER_DOWN: In this state all regulators are turned off
  * and the reset line is pulled low. The device is completely
  * inactive.
- * @SI476X_POWER_UP_FULL: In this state all the power regualtors are
+ * @SI476X_POWER_UP_FULL: In this state all the power regulators are
  * turned on, reset line pulled high, IRQ line is enabled(polling is
  * active for polling use scenario) and device is turned on with
  * POWER_UP command. The device is ready to be used.
-- 
2.29.2

