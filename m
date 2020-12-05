Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 626912CF810
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 01:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730958AbgLEAlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 19:41:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbgLEAlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 19:41:50 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63892C0613D1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 16:41:03 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id d20so10086728lfe.11
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 16:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AUDE8QdNwf4Dqng/TYIbJgTg21ImnESldTYLjNGaiwk=;
        b=xil0RN2fcl247ib+vGwod06DbGSqxRb7un+Tu60z+g4mLUnG5oDb7C2Icub+0o0Rat
         Oh1ZGWT5/D3uGqkQias8YISelPdGeQEqbl3TG2LWBcOGrgVwwa8c0nLkhkewuPvKc6My
         h54avZ7CELxBEkXBHfGB1vIVUVdhcfw1BkRU0kaGxv9/N1Q6Ifipn7vT8zbgHoNud+a2
         14inDB5xzk5qBpDWV+6MSIDMcZ1lgiOkgmDQrV5RidUL+n5wNiH+Y70ROsSnmOpvGl+Q
         H/oprC3I6Lu3fDrxxkhjPDfRsgKem05XB4CQ1VzTSg5I3lhI63foM59pihT1jfAyBubf
         PRgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AUDE8QdNwf4Dqng/TYIbJgTg21ImnESldTYLjNGaiwk=;
        b=XM5vy6vQgY4mDIkf8hHGreu3kWqbHeqhO6R592NGsK4YiqYDf06KCS+XsF+Lv/0AZ5
         V2+bSFhTlSwaypM+QUPeFqbcQCsa5/C1i6W7xaH8ibDi23SC7DVyBMVgEhVuU+zzmLPE
         v4o05GXaV7J3v3eecFCNmJ26d57z0rn4d47spOqSIt32GApqYanjrMbVunVW/JsysAnn
         515HxNrZ//Ar1L9koJ14iYyAB1iKuMHfoRUSjL3gbKL9sIiNWxe3md5g/UGJN+lj7ZAI
         6QjiTPT7bUAkXZWlDlZoH0/TicEF1nkL0XqKW0/tYqy/ax9AnB39c+qxcITz8JbNyDIA
         Is+A==
X-Gm-Message-State: AOAM532FSShZIu/JKNuYHWO3iZfwTBx9gVsq/3aY1XGz4l2EJyfsHfeo
        4swTpeJUYKWxCDBYdidp9yJeYQ==
X-Google-Smtp-Source: ABdhPJx1XfakRayCrBYOnSRRV0kLB/ICXroPz/C6NEEPmqXPGV0yIEYlwSYPSVQnrRn5cZRCRWZuIA==
X-Received: by 2002:a05:6512:4c7:: with SMTP id w7mr4326545lfq.453.1607128861704;
        Fri, 04 Dec 2020 16:41:01 -0800 (PST)
Received: from localhost.bredbandsbolaget (c-92d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.146])
        by smtp.gmail.com with ESMTPSA id w123sm2125477lff.138.2020.12.04.16.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 16:41:01 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 1/2 v2] regulator: ab8500: Remove unused platform data
Date:   Sat,  5 Dec 2020 01:40:56 +0100
Message-Id: <20201205004057.1712753-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct ab8500_regulator_platform_data was a leftover
since the days before we probed all regulators from the
device tree. The ab8500-ext regulator was the only used,
defining platform data and register intialization that
was never used for anything, a copy of a boardfile no
longer in use.

Delete the ab8500_regulator_platform_data and make the
ab8500-ext regulator reference the regulator init data
in the local file directly. We are 100% device tree
these days.

Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- No changes.
- Resend with the other patch.

Lee: would be nice if you could ACK this, I do not plan
any other changes to the AB8500 headers for this kernel
cycle so there should not be any conflicts.
---
 drivers/regulator/ab8500-ext.c    | 417 +-----------------------------
 include/linux/mfd/abx500/ab8500.h |   3 -
 include/linux/regulator/ab8500.h  |  10 -
 3 files changed, 2 insertions(+), 428 deletions(-)

diff --git a/drivers/regulator/ab8500-ext.c b/drivers/regulator/ab8500-ext.c
index 8bb43a671ded..05f9531bd108 100644
--- a/drivers/regulator/ab8500-ext.c
+++ b/drivers/regulator/ab8500-ext.c
@@ -24,403 +24,6 @@
 #include <linux/mfd/abx500/ab8500.h>
 #include <linux/regulator/ab8500.h>
 
-static struct regulator_consumer_supply ab8500_vaux1_consumers[] = {
-	/* Main display, u8500 R3 uib */
-	REGULATOR_SUPPLY("vddi", "mcde_disp_sony_acx424akp.0"),
-	/* Main display, u8500 uib and ST uib */
-	REGULATOR_SUPPLY("vdd1", "samsung_s6d16d0.0"),
-	/* Secondary display, ST uib */
-	REGULATOR_SUPPLY("vdd1", "samsung_s6d16d0.1"),
-	/* SFH7741 proximity sensor */
-	REGULATOR_SUPPLY("vcc", "gpio-keys.0"),
-	/* BH1780GLS ambient light sensor */
-	REGULATOR_SUPPLY("vcc", "2-0029"),
-	/* lsm303dlh accelerometer */
-	REGULATOR_SUPPLY("vdd", "2-0018"),
-	/* lsm303dlhc accelerometer */
-	REGULATOR_SUPPLY("vdd", "2-0019"),
-	/* lsm303dlh magnetometer */
-	REGULATOR_SUPPLY("vdd", "2-001e"),
-	/* Rohm BU21013 Touchscreen devices */
-	REGULATOR_SUPPLY("avdd", "3-005c"),
-	REGULATOR_SUPPLY("avdd", "3-005d"),
-	/* Synaptics RMI4 Touchscreen device */
-	REGULATOR_SUPPLY("vdd", "3-004b"),
-	/* L3G4200D Gyroscope device */
-	REGULATOR_SUPPLY("vdd", "2-0068"),
-	/* Ambient light sensor device */
-	REGULATOR_SUPPLY("vdd", "3-0029"),
-	/* Pressure sensor device */
-	REGULATOR_SUPPLY("vdd", "2-005c"),
-	/* Cypress TrueTouch Touchscreen device */
-	REGULATOR_SUPPLY("vcpin", "spi8.0"),
-	/* Camera device */
-	REGULATOR_SUPPLY("vaux12v5", "mmio_camera"),
-};
-
-static struct regulator_consumer_supply ab8500_vaux2_consumers[] = {
-	/* On-board eMMC power */
-	REGULATOR_SUPPLY("vmmc", "sdi4"),
-	/* AB8500 audio codec */
-	REGULATOR_SUPPLY("vcc-N2158", "ab8500-codec.0"),
-	/* AB8500 accessory detect 1 */
-	REGULATOR_SUPPLY("vcc-N2158", "ab8500-acc-det.0"),
-	/* AB8500 Tv-out device */
-	REGULATOR_SUPPLY("vcc-N2158", "mcde_tv_ab8500.4"),
-	/* AV8100 HDMI device */
-	REGULATOR_SUPPLY("vcc-N2158", "av8100_hdmi.3"),
-};
-
-static struct regulator_consumer_supply ab8500_vaux3_consumers[] = {
-	REGULATOR_SUPPLY("v-SD-STM", "stm"),
-	/* External MMC slot power */
-	REGULATOR_SUPPLY("vmmc", "sdi0"),
-};
-
-static struct regulator_consumer_supply ab8500_vtvout_consumers[] = {
-	/* TV-out DENC supply */
-	REGULATOR_SUPPLY("vtvout", "ab8500-denc.0"),
-	/* Internal general-purpose ADC */
-	REGULATOR_SUPPLY("vddadc", "ab8500-gpadc.0"),
-	/* ADC for charger */
-	REGULATOR_SUPPLY("vddadc", "ab8500-charger.0"),
-	/* AB8500 Tv-out device */
-	REGULATOR_SUPPLY("vtvout", "mcde_tv_ab8500.4"),
-};
-
-static struct regulator_consumer_supply ab8500_vaud_consumers[] = {
-	/* AB8500 audio-codec main supply */
-	REGULATOR_SUPPLY("vaud", "ab8500-codec.0"),
-};
-
-static struct regulator_consumer_supply ab8500_vamic1_consumers[] = {
-	/* AB8500 audio-codec Mic1 supply */
-	REGULATOR_SUPPLY("vamic1", "ab8500-codec.0"),
-};
-
-static struct regulator_consumer_supply ab8500_vamic2_consumers[] = {
-	/* AB8500 audio-codec Mic2 supply */
-	REGULATOR_SUPPLY("vamic2", "ab8500-codec.0"),
-};
-
-static struct regulator_consumer_supply ab8500_vdmic_consumers[] = {
-	/* AB8500 audio-codec DMic supply */
-	REGULATOR_SUPPLY("vdmic", "ab8500-codec.0"),
-};
-
-static struct regulator_consumer_supply ab8500_vintcore_consumers[] = {
-	/* SoC core supply, no device */
-	REGULATOR_SUPPLY("v-intcore", NULL),
-	/* USB Transceiver */
-	REGULATOR_SUPPLY("vddulpivio18", "ab8500-usb.0"),
-	/* Handled by abx500 clk driver */
-	REGULATOR_SUPPLY("v-intcore", "abx500-clk.0"),
-};
-
-static struct regulator_consumer_supply ab8500_vana_consumers[] = {
-	/* DB8500 DSI */
-	REGULATOR_SUPPLY("vdddsi1v2", "mcde"),
-	REGULATOR_SUPPLY("vdddsi1v2", "b2r2_core"),
-	REGULATOR_SUPPLY("vdddsi1v2", "b2r2_1_core"),
-	REGULATOR_SUPPLY("vdddsi1v2", "dsilink.0"),
-	REGULATOR_SUPPLY("vdddsi1v2", "dsilink.1"),
-	REGULATOR_SUPPLY("vdddsi1v2", "dsilink.2"),
-	/* DB8500 CSI */
-	REGULATOR_SUPPLY("vddcsi1v2", "mmio_camera"),
-};
-
-/* ab8500 regulator register initialization */
-static struct ab8500_regulator_reg_init ab8500_reg_init[] = {
-	/*
-	 * VanaRequestCtrl          = HP/LP depending on VxRequest
-	 * VextSupply1RequestCtrl   = HP/LP depending on VxRequest
-	 */
-	INIT_REGULATOR_REGISTER(AB8500_REGUREQUESTCTRL2,       0xf0, 0x00),
-	/*
-	 * VextSupply2RequestCtrl   = HP/LP depending on VxRequest
-	 * VextSupply3RequestCtrl   = HP/LP depending on VxRequest
-	 * Vaux1RequestCtrl         = HP/LP depending on VxRequest
-	 * Vaux2RequestCtrl         = HP/LP depending on VxRequest
-	 */
-	INIT_REGULATOR_REGISTER(AB8500_REGUREQUESTCTRL3,       0xff, 0x00),
-	/*
-	 * Vaux3RequestCtrl         = HP/LP depending on VxRequest
-	 * SwHPReq                  = Control through SWValid disabled
-	 */
-	INIT_REGULATOR_REGISTER(AB8500_REGUREQUESTCTRL4,       0x07, 0x00),
-	/*
-	 * VanaSysClkReq1HPValid    = disabled
-	 * Vaux1SysClkReq1HPValid   = disabled
-	 * Vaux2SysClkReq1HPValid   = disabled
-	 * Vaux3SysClkReq1HPValid   = disabled
-	 */
-	INIT_REGULATOR_REGISTER(AB8500_REGUSYSCLKREQ1HPVALID1, 0xe8, 0x00),
-	/*
-	 * VextSupply1SysClkReq1HPValid = disabled
-	 * VextSupply2SysClkReq1HPValid = disabled
-	 * VextSupply3SysClkReq1HPValid = SysClkReq1 controlled
-	 */
-	INIT_REGULATOR_REGISTER(AB8500_REGUSYSCLKREQ1HPVALID2, 0x70, 0x40),
-	/*
-	 * VanaHwHPReq1Valid        = disabled
-	 * Vaux1HwHPreq1Valid       = disabled
-	 * Vaux2HwHPReq1Valid       = disabled
-	 * Vaux3HwHPReqValid        = disabled
-	 */
-	INIT_REGULATOR_REGISTER(AB8500_REGUHWHPREQ1VALID1,     0xe8, 0x00),
-	/*
-	 * VextSupply1HwHPReq1Valid = disabled
-	 * VextSupply2HwHPReq1Valid = disabled
-	 * VextSupply3HwHPReq1Valid = disabled
-	 */
-	INIT_REGULATOR_REGISTER(AB8500_REGUHWHPREQ1VALID2,     0x07, 0x00),
-	/*
-	 * VanaHwHPReq2Valid        = disabled
-	 * Vaux1HwHPReq2Valid       = disabled
-	 * Vaux2HwHPReq2Valid       = disabled
-	 * Vaux3HwHPReq2Valid       = disabled
-	 */
-	INIT_REGULATOR_REGISTER(AB8500_REGUHWHPREQ2VALID1,     0xe8, 0x00),
-	/*
-	 * VextSupply1HwHPReq2Valid = disabled
-	 * VextSupply2HwHPReq2Valid = disabled
-	 * VextSupply3HwHPReq2Valid = HWReq2 controlled
-	 */
-	INIT_REGULATOR_REGISTER(AB8500_REGUHWHPREQ2VALID2,     0x07, 0x04),
-	/*
-	 * VanaSwHPReqValid         = disabled
-	 * Vaux1SwHPReqValid        = disabled
-	 */
-	INIT_REGULATOR_REGISTER(AB8500_REGUSWHPREQVALID1,      0xa0, 0x00),
-	/*
-	 * Vaux2SwHPReqValid        = disabled
-	 * Vaux3SwHPReqValid        = disabled
-	 * VextSupply1SwHPReqValid  = disabled
-	 * VextSupply2SwHPReqValid  = disabled
-	 * VextSupply3SwHPReqValid  = disabled
-	 */
-	INIT_REGULATOR_REGISTER(AB8500_REGUSWHPREQVALID2,      0x1f, 0x00),
-	/*
-	 * SysClkReq2Valid1         = SysClkReq2 controlled
-	 * SysClkReq3Valid1         = disabled
-	 * SysClkReq4Valid1         = SysClkReq4 controlled
-	 * SysClkReq5Valid1         = disabled
-	 * SysClkReq6Valid1         = SysClkReq6 controlled
-	 * SysClkReq7Valid1         = disabled
-	 * SysClkReq8Valid1         = disabled
-	 */
-	INIT_REGULATOR_REGISTER(AB8500_REGUSYSCLKREQVALID1,    0xfe, 0x2a),
-	/*
-	 * SysClkReq2Valid2         = disabled
-	 * SysClkReq3Valid2         = disabled
-	 * SysClkReq4Valid2         = disabled
-	 * SysClkReq5Valid2         = disabled
-	 * SysClkReq6Valid2         = SysClkReq6 controlled
-	 * SysClkReq7Valid2         = disabled
-	 * SysClkReq8Valid2         = disabled
-	 */
-	INIT_REGULATOR_REGISTER(AB8500_REGUSYSCLKREQVALID2,    0xfe, 0x20),
-	/*
-	 * VTVoutEna                = disabled
-	 * Vintcore12Ena            = disabled
-	 * Vintcore12Sel            = 1.25 V
-	 * Vintcore12LP             = inactive (HP)
-	 * VTVoutLP                 = inactive (HP)
-	 */
-	INIT_REGULATOR_REGISTER(AB8500_REGUMISC1,              0xfe, 0x10),
-	/*
-	 * VaudioEna                = disabled
-	 * VdmicEna                 = disabled
-	 * Vamic1Ena                = disabled
-	 * Vamic2Ena                = disabled
-	 */
-	INIT_REGULATOR_REGISTER(AB8500_VAUDIOSUPPLY,           0x1e, 0x00),
-	/*
-	 * Vamic1_dzout             = high-Z when Vamic1 is disabled
-	 * Vamic2_dzout             = high-Z when Vamic2 is disabled
-	 */
-	INIT_REGULATOR_REGISTER(AB8500_REGUCTRL1VAMIC,         0x03, 0x00),
-	/*
-	 * VPll                     = Hw controlled (NOTE! PRCMU bits)
-	 * VanaRegu                 = force off
-	 */
-	INIT_REGULATOR_REGISTER(AB8500_VPLLVANAREGU,           0x0f, 0x02),
-	/*
-	 * VrefDDREna               = disabled
-	 * VrefDDRSleepMode         = inactive (no pulldown)
-	 */
-	INIT_REGULATOR_REGISTER(AB8500_VREFDDR,                0x03, 0x00),
-	/*
-	 * VextSupply1Regu          = force LP
-	 * VextSupply2Regu          = force OFF
-	 * VextSupply3Regu          = force HP (-> STBB2=LP and TPS=LP)
-	 * ExtSupply2Bypass         = ExtSupply12LPn ball is 0 when Ena is 0
-	 * ExtSupply3Bypass         = ExtSupply3LPn ball is 0 when Ena is 0
-	 */
-	INIT_REGULATOR_REGISTER(AB8500_EXTSUPPLYREGU,          0xff, 0x13),
-	/*
-	 * Vaux1Regu                = force HP
-	 * Vaux2Regu                = force off
-	 */
-	INIT_REGULATOR_REGISTER(AB8500_VAUX12REGU,             0x0f, 0x01),
-	/*
-	 * Vaux3Regu                = force off
-	 */
-	INIT_REGULATOR_REGISTER(AB8500_VRF1VAUX3REGU,          0x03, 0x00),
-	/*
-	 * Vaux1Sel                 = 2.8 V
-	 */
-	INIT_REGULATOR_REGISTER(AB8500_VAUX1SEL,               0x0f, 0x0C),
-	/*
-	 * Vaux2Sel                 = 2.9 V
-	 */
-	INIT_REGULATOR_REGISTER(AB8500_VAUX2SEL,               0x0f, 0x0d),
-	/*
-	 * Vaux3Sel                 = 2.91 V
-	 */
-	INIT_REGULATOR_REGISTER(AB8500_VRF1VAUX3SEL,           0x07, 0x07),
-	/*
-	 * VextSupply12LP           = disabled (no LP)
-	 */
-	INIT_REGULATOR_REGISTER(AB8500_REGUCTRL2SPARE,         0x01, 0x00),
-	/*
-	 * Vaux1Disch               = short discharge time
-	 * Vaux2Disch               = short discharge time
-	 * Vaux3Disch               = short discharge time
-	 * Vintcore12Disch          = short discharge time
-	 * VTVoutDisch              = short discharge time
-	 * VaudioDisch              = short discharge time
-	 */
-	INIT_REGULATOR_REGISTER(AB8500_REGUCTRLDISCH,          0xfc, 0x00),
-	/*
-	 * VanaDisch                = short discharge time
-	 * VdmicPullDownEna         = pulldown disabled when Vdmic is disabled
-	 * VdmicDisch               = short discharge time
-	 */
-	INIT_REGULATOR_REGISTER(AB8500_REGUCTRLDISCH2,         0x16, 0x00),
-};
-
-/* AB8500 regulators */
-static struct regulator_init_data ab8500_regulators[AB8500_NUM_REGULATORS] = {
-	/* supplies to the display/camera */
-	[AB8500_LDO_AUX1] = {
-		.supply_regulator = "ab8500-ext-supply3",
-		.constraints = {
-			.name = "V-DISPLAY",
-			.min_uV = 2800000,
-			.max_uV = 3300000,
-			.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE |
-					  REGULATOR_CHANGE_STATUS,
-			.boot_on = 1, /* display is on at boot */
-		},
-		.num_consumer_supplies = ARRAY_SIZE(ab8500_vaux1_consumers),
-		.consumer_supplies = ab8500_vaux1_consumers,
-	},
-	/* supplies to the on-board eMMC */
-	[AB8500_LDO_AUX2] = {
-		.supply_regulator = "ab8500-ext-supply3",
-		.constraints = {
-			.name = "V-eMMC1",
-			.min_uV = 1100000,
-			.max_uV = 3300000,
-			.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE |
-					  REGULATOR_CHANGE_STATUS |
-					  REGULATOR_CHANGE_MODE,
-			.valid_modes_mask = REGULATOR_MODE_NORMAL |
-					    REGULATOR_MODE_IDLE,
-		},
-		.num_consumer_supplies = ARRAY_SIZE(ab8500_vaux2_consumers),
-		.consumer_supplies = ab8500_vaux2_consumers,
-	},
-	/* supply for VAUX3, supplies to SDcard slots */
-	[AB8500_LDO_AUX3] = {
-		.supply_regulator = "ab8500-ext-supply3",
-		.constraints = {
-			.name = "V-MMC-SD",
-			.min_uV = 1100000,
-			.max_uV = 3300000,
-			.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE |
-					  REGULATOR_CHANGE_STATUS |
-					  REGULATOR_CHANGE_MODE,
-			.valid_modes_mask = REGULATOR_MODE_NORMAL |
-					    REGULATOR_MODE_IDLE,
-		},
-		.num_consumer_supplies = ARRAY_SIZE(ab8500_vaux3_consumers),
-		.consumer_supplies = ab8500_vaux3_consumers,
-	},
-	/* supply for tvout, gpadc, TVOUT LDO */
-	[AB8500_LDO_TVOUT] = {
-		.constraints = {
-			.name = "V-TVOUT",
-			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
-		},
-		.num_consumer_supplies = ARRAY_SIZE(ab8500_vtvout_consumers),
-		.consumer_supplies = ab8500_vtvout_consumers,
-	},
-	/* supply for ab8500-vaudio, VAUDIO LDO */
-	[AB8500_LDO_AUDIO] = {
-		.constraints = {
-			.name = "V-AUD",
-			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
-		},
-		.num_consumer_supplies = ARRAY_SIZE(ab8500_vaud_consumers),
-		.consumer_supplies = ab8500_vaud_consumers,
-	},
-	/* supply for v-anamic1 VAMic1-LDO */
-	[AB8500_LDO_ANAMIC1] = {
-		.constraints = {
-			.name = "V-AMIC1",
-			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
-		},
-		.num_consumer_supplies = ARRAY_SIZE(ab8500_vamic1_consumers),
-		.consumer_supplies = ab8500_vamic1_consumers,
-	},
-	/* supply for v-amic2, VAMIC2 LDO, reuse constants for AMIC1 */
-	[AB8500_LDO_ANAMIC2] = {
-		.constraints = {
-			.name = "V-AMIC2",
-			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
-		},
-		.num_consumer_supplies = ARRAY_SIZE(ab8500_vamic2_consumers),
-		.consumer_supplies = ab8500_vamic2_consumers,
-	},
-	/* supply for v-dmic, VDMIC LDO */
-	[AB8500_LDO_DMIC] = {
-		.constraints = {
-			.name = "V-DMIC",
-			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
-		},
-		.num_consumer_supplies = ARRAY_SIZE(ab8500_vdmic_consumers),
-		.consumer_supplies = ab8500_vdmic_consumers,
-	},
-	/* supply for v-intcore12, VINTCORE12 LDO */
-	[AB8500_LDO_INTCORE] = {
-		.constraints = {
-			.name = "V-INTCORE",
-			.min_uV = 1250000,
-			.max_uV = 1350000,
-			.input_uV = 1800000,
-			.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE |
-					  REGULATOR_CHANGE_STATUS |
-					  REGULATOR_CHANGE_MODE |
-					  REGULATOR_CHANGE_DRMS,
-			.valid_modes_mask = REGULATOR_MODE_NORMAL |
-					    REGULATOR_MODE_IDLE,
-		},
-		.num_consumer_supplies = ARRAY_SIZE(ab8500_vintcore_consumers),
-		.consumer_supplies = ab8500_vintcore_consumers,
-	},
-	/* supply for U8500 CSI-DSI, VANA LDO */
-	[AB8500_LDO_ANA] = {
-		.constraints = {
-			.name = "V-CSI-DSI",
-			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
-		},
-		.num_consumer_supplies = ARRAY_SIZE(ab8500_vana_consumers),
-		.consumer_supplies = ab8500_vana_consumers,
-	},
-};
-
 /* supply for VextSupply3 */
 static struct regulator_consumer_supply ab8500_ext_supply3_consumers[] = {
 	/* SIM supply for 3 V SIM cards */
@@ -465,15 +68,6 @@ static struct regulator_init_data ab8500_ext_regulators[] = {
 	},
 };
 
-static struct ab8500_regulator_platform_data ab8500_regulator_plat_data = {
-	.reg_init               = ab8500_reg_init,
-	.num_reg_init           = ARRAY_SIZE(ab8500_reg_init),
-	.regulator              = ab8500_regulators,
-	.num_regulator          = ARRAY_SIZE(ab8500_regulators),
-	.ext_regulator          = ab8500_ext_regulators,
-	.num_ext_regulator      = ARRAY_SIZE(ab8500_ext_regulators),
-};
-
 /**
  * struct ab8500_ext_regulator_info - ab8500 regulator information
  * @dev: device pointer
@@ -788,7 +382,6 @@ static struct ab8500_ext_regulator_info
 static int ab8500_ext_regulator_probe(struct platform_device *pdev)
 {
 	struct ab8500 *ab8500 = dev_get_drvdata(pdev->dev.parent);
-	struct ab8500_regulator_platform_data *pdata = &ab8500_regulator_plat_data;
 	struct regulator_config config = { };
 	struct regulator_dev *rdev;
 	int i;
@@ -798,12 +391,6 @@ static int ab8500_ext_regulator_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	/* make sure the platform data has the correct size */
-	if (pdata->num_ext_regulator != ARRAY_SIZE(ab8500_ext_regulator_info)) {
-		dev_err(&pdev->dev, "Configuration error: size mismatch.\n");
-		return -EINVAL;
-	}
-
 	/* check for AB8500 2.x */
 	if (is_ab8500_2p0_or_earlier(ab8500)) {
 		struct ab8500_ext_regulator_info *info;
@@ -823,11 +410,11 @@ static int ab8500_ext_regulator_probe(struct platform_device *pdev)
 		info = &ab8500_ext_regulator_info[i];
 		info->dev = &pdev->dev;
 		info->cfg = (struct ab8500_ext_regulator_cfg *)
-			pdata->ext_regulator[i].driver_data;
+			ab8500_ext_regulators[i].driver_data;
 
 		config.dev = &pdev->dev;
 		config.driver_data = info;
-		config.init_data = &pdata->ext_regulator[i];
+		config.init_data = &ab8500_ext_regulators[i];
 
 		/* register regulator with framework */
 		rdev = devm_regulator_register(&pdev->dev, &info->desc,
diff --git a/include/linux/mfd/abx500/ab8500.h b/include/linux/mfd/abx500/ab8500.h
index 524a7e4702c2..302a330c5c84 100644
--- a/include/linux/mfd/abx500/ab8500.h
+++ b/include/linux/mfd/abx500/ab8500.h
@@ -368,7 +368,6 @@ struct ab8500 {
 	int it_latchhier_num;
 };
 
-struct ab8500_regulator_platform_data;
 struct ab8500_codec_platform_data;
 struct ab8500_sysctrl_platform_data;
 
@@ -376,11 +375,9 @@ struct ab8500_sysctrl_platform_data;
  * struct ab8500_platform_data - AB8500 platform data
  * @irq_base: start of AB8500 IRQs, AB8500_NR_IRQS will be used
  * @init: board-specific initialization after detection of ab8500
- * @regulator: machine-specific constraints for regulators
  */
 struct ab8500_platform_data {
 	void (*init) (struct ab8500 *);
-	struct ab8500_regulator_platform_data *regulator;
 	struct ab8500_codec_platform_data *codec;
 	struct ab8500_sysctrl_platform_data *sysctrl;
 };
diff --git a/include/linux/regulator/ab8500.h b/include/linux/regulator/ab8500.h
index 3ab1ddf151a2..ecf7b4713df9 100644
--- a/include/linux/regulator/ab8500.h
+++ b/include/linux/regulator/ab8500.h
@@ -153,14 +153,4 @@ enum ab8500_ext_regulator_id {
 	AB8500_NUM_EXT_REGULATORS,
 };
 
-/* AB8500 regulator platform data */
-struct ab8500_regulator_platform_data {
-	int num_reg_init;
-	struct ab8500_regulator_reg_init *reg_init;
-	int num_regulator;
-	struct regulator_init_data *regulator;
-	int num_ext_regulator;
-	struct regulator_init_data *ext_regulator;
-};
-
 #endif
-- 
2.26.2

