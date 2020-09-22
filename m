Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E14D273F83
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 12:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgIVKVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 06:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgIVKVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 06:21:17 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48ACBC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 03:21:16 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id kk9so1226063pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 03:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8kFpb68GY01Th3w2DM0ucVhzKr5RUf/QH4HjyWEjVnQ=;
        b=udYxNjvDozIL3XAcOtUS3j8N61lhH1v5oV6FhOfe9fE0LmFh2ndgSsN2wkQRXmGkPG
         gHmtdYiyO5WUkq1qktY1ilQfpKxQQcCc+OGC6a1HgWGOBdGvyEsqCSDD7xm19oQGHvKo
         ybCyZPmkqhVe+QHxqQi+uGIbNdfah0gtX2MJX5gd8xAU8MaF6JdYPyhxu4grJTBCHFHJ
         W7hj/FXJmIn/o8wNFdCmNKWxWxxTNLj3PCs7R16oBcFbl6LyWQnX0+LsBKWk6Wz97Ub+
         P4bFl4lEYoQ8HGhqhW2tczleKPu1dHJ41h/jngEc2GnY9i99d35gP392UzFT7LoyjpDT
         sCDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8kFpb68GY01Th3w2DM0ucVhzKr5RUf/QH4HjyWEjVnQ=;
        b=Vr65p1OoTAxCivXiUsHeTjlbtAWoMiInOeDdT+T2ONoxB2eUEpkA/kgSYJY1NnmDO7
         cgOfHynS8yo/2DHW6G6ny/WwNj5Bp1GN1aUJRd900FpRwqxsTHl4U97KE2cTY6WTFruF
         EKBp3QZcN7SYzxUoo1pVLBOn4WTJKWR4u+6RvesN1jsLiQ7AnnfMFmrr0H0dXObvUhoG
         /8U5b12fKHuDEroZwE6/m1Ejhc1rwAkg107i4pL5DBl85Nt3elXIpPWTvVO/mip8ojGZ
         ibVkgqpEfXFmSlULU5vjeAqThTKwYUOI/vWpDg98RWUzaTJiWz1mBid84mKESjJ3/AmZ
         MTkw==
X-Gm-Message-State: AOAM532Rm+1F4z47gk3jGusS4ExGj63tS05AmK06/xwYKYRQRcEurQVG
        aWyEybsL+x1Nktoi+62LSOA=
X-Google-Smtp-Source: ABdhPJyxumYyhrHvqg+coXaIW1gWpxfUc+/iaYa0QuluhasJB4aJLKNFNbFdpuhdLs79sxrF7p4PoQ==
X-Received: by 2002:a17:90a:d90c:: with SMTP id c12mr3104675pjv.94.1600770076113;
        Tue, 22 Sep 2020 03:21:16 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:489:56d9:501b:f524:c013:2733])
        by smtp.gmail.com with ESMTPSA id a15sm14859037pfi.119.2020.09.22.03.21.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Sep 2020 03:21:15 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     lee.jones@linaro.org, matthias.bgg@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: [PATCH v5 09/10] mfd: mt6360: Merge header file into driver and remove unuse register define
Date:   Tue, 22 Sep 2020 18:20:17 +0800
Message-Id: <1600770019-11585-10-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600770019-11585-1-git-send-email-gene.chen.richtek@gmail.com>
References: <1600770019-11585-1-git-send-email-gene.chen.richtek@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

Merge header file into driver and remove unuse register define

Signed-off-by: Gene Chen <gene_chen@richtek.com>
---
 drivers/mfd/mt6360-core.c  |  48 ++++++++-
 include/linux/mfd/mt6360.h | 240 ---------------------------------------------
 2 files changed, 47 insertions(+), 241 deletions(-)
 delete mode 100644 include/linux/mfd/mt6360.h

diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
index 677c974..075b466 100644
--- a/drivers/mfd/mt6360-core.c
+++ b/drivers/mfd/mt6360-core.c
@@ -14,7 +14,53 @@
 #include <linux/regmap.h>
 #include <linux/slab.h>
 
-#include <linux/mfd/mt6360.h>
+enum {
+	MT6360_SLAVE_TCPC = 0,
+	MT6360_SLAVE_PMIC,
+	MT6360_SLAVE_LDO,
+	MT6360_SLAVE_PMU,
+	MT6360_SLAVE_MAX,
+};
+
+struct mt6360_ddata {
+	struct i2c_client *i2c[MT6360_SLAVE_MAX];
+	struct device *dev;
+	struct regmap *regmap;
+	struct regmap_irq_chip_data *irq_data;
+	unsigned int chip_rev;
+	u8 crc8_tbl[CRC8_TABLE_SIZE];
+};
+
+#define MT6360_TCPC_SLAVEID		0x4E
+#define MT6360_PMIC_SLAVEID		0x1A
+#define MT6360_LDO_SLAVEID		0x64
+#define MT6360_PMU_SLAVEID		0x34
+
+#define MT6360_REG_TCPCSTART		0x00
+#define MT6360_REG_TCPCEND		0xFF
+#define MT6360_REG_PMICSTART		0x100
+#define MT6360_REG_PMICEND		0x13B
+#define MT6360_REG_LDOSTART		0x200
+#define MT6360_REG_LDOEND		0x21C
+#define MT6360_REG_PMUSTART		0x300
+#define MT6360_PMU_DEV_INFO		0x300
+#define MT6360_PMU_CHG_IRQ1		0x3D0
+#define MT6360_PMU_CHG_MASK1		0x3F0
+#define MT6360_REG_PMUEND		0x3FF
+
+#define MT6360_PMU_IRQ_REGNUM		16
+
+#define CHIP_VEN_MASK			0xF0
+#define CHIP_VEN_MT6360			0x50
+#define CHIP_REV_MASK			0x0F
+
+#define MT6360_ADDRESS_MASK		0x3F
+#define MT6360_DATA_SIZE_1_BYTE		0x00
+#define MT6360_DATA_SIZE_2_BYTES	0x40
+#define MT6360_DATA_SIZE_3_BYTES	0x80
+#define MT6360_DATA_SIZE_4_BYTES	0xC0
+
+#define MT6360_CRC8_POLYNOMIAL		0x7
 
 /* reg 0 -> 0 ~ 7 */
 #define MT6360_CHG_TREG_EVT		4
diff --git a/include/linux/mfd/mt6360.h b/include/linux/mfd/mt6360.h
deleted file mode 100644
index ef8257d..0000000
--- a/include/linux/mfd/mt6360.h
+++ /dev/null
@@ -1,240 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (c) 2020 MediaTek Inc.
- */
-
-#ifndef __MT6360_H__
-#define __MT6360_H__
-
-#include <linux/regmap.h>
-
-enum {
-	MT6360_SLAVE_PMU = 0,
-	MT6360_SLAVE_PMIC,
-	MT6360_SLAVE_LDO,
-	MT6360_SLAVE_TCPC,
-	MT6360_SLAVE_MAX,
-};
-
-#define MT6360_PMU_SLAVEID	0x34
-#define MT6360_PMIC_SLAVEID	0x1A
-#define MT6360_LDO_SLAVEID	0x64
-#define MT6360_TCPC_SLAVEID	0x4E
-
-struct mt6360_ddata {
-	struct i2c_client *i2c[MT6360_SLAVE_MAX];
-	struct device *dev;
-	struct regmap *regmap;
-	struct regmap_irq_chip_data *irq_data;
-	unsigned int chip_rev;
-};
-
-/* PMU register defininition */
-#define MT6360_PMU_DEV_INFO			0x00
-#define MT6360_PMU_CORE_CTRL1			0x01
-#define MT6360_PMU_RST1				0x02
-#define MT6360_PMU_CRCEN			0x03
-#define MT6360_PMU_RST_PAS_CODE1		0x04
-#define MT6360_PMU_RST_PAS_CODE2		0x05
-#define MT6360_PMU_CORE_CTRL2			0x06
-#define MT6360_PMU_TM_PAS_CODE1			0x07
-#define MT6360_PMU_TM_PAS_CODE2			0x08
-#define MT6360_PMU_TM_PAS_CODE3			0x09
-#define MT6360_PMU_TM_PAS_CODE4			0x0A
-#define MT6360_PMU_IRQ_IND			0x0B
-#define MT6360_PMU_IRQ_MASK			0x0C
-#define MT6360_PMU_IRQ_SET			0x0D
-#define MT6360_PMU_SHDN_CTRL			0x0E
-#define MT6360_PMU_TM_INF			0x0F
-#define MT6360_PMU_I2C_CTRL			0x10
-#define MT6360_PMU_CHG_CTRL1			0x11
-#define MT6360_PMU_CHG_CTRL2			0x12
-#define MT6360_PMU_CHG_CTRL3			0x13
-#define MT6360_PMU_CHG_CTRL4			0x14
-#define MT6360_PMU_CHG_CTRL5			0x15
-#define MT6360_PMU_CHG_CTRL6			0x16
-#define MT6360_PMU_CHG_CTRL7			0x17
-#define MT6360_PMU_CHG_CTRL8			0x18
-#define MT6360_PMU_CHG_CTRL9			0x19
-#define MT6360_PMU_CHG_CTRL10			0x1A
-#define MT6360_PMU_CHG_CTRL11			0x1B
-#define MT6360_PMU_CHG_CTRL12			0x1C
-#define MT6360_PMU_CHG_CTRL13			0x1D
-#define MT6360_PMU_CHG_CTRL14			0x1E
-#define MT6360_PMU_CHG_CTRL15			0x1F
-#define MT6360_PMU_CHG_CTRL16			0x20
-#define MT6360_PMU_CHG_AICC_RESULT		0x21
-#define MT6360_PMU_DEVICE_TYPE			0x22
-#define MT6360_PMU_QC_CONTROL1			0x23
-#define MT6360_PMU_QC_CONTROL2			0x24
-#define MT6360_PMU_QC30_CONTROL1		0x25
-#define MT6360_PMU_QC30_CONTROL2		0x26
-#define MT6360_PMU_USB_STATUS1			0x27
-#define MT6360_PMU_QC_STATUS1			0x28
-#define MT6360_PMU_QC_STATUS2			0x29
-#define MT6360_PMU_CHG_PUMP			0x2A
-#define MT6360_PMU_CHG_CTRL17			0x2B
-#define MT6360_PMU_CHG_CTRL18			0x2C
-#define MT6360_PMU_CHRDET_CTRL1			0x2D
-#define MT6360_PMU_CHRDET_CTRL2			0x2E
-#define MT6360_PMU_DPDN_CTRL			0x2F
-#define MT6360_PMU_CHG_HIDDEN_CTRL1		0x30
-#define MT6360_PMU_CHG_HIDDEN_CTRL2		0x31
-#define MT6360_PMU_CHG_HIDDEN_CTRL3		0x32
-#define MT6360_PMU_CHG_HIDDEN_CTRL4		0x33
-#define MT6360_PMU_CHG_HIDDEN_CTRL5		0x34
-#define MT6360_PMU_CHG_HIDDEN_CTRL6		0x35
-#define MT6360_PMU_CHG_HIDDEN_CTRL7		0x36
-#define MT6360_PMU_CHG_HIDDEN_CTRL8		0x37
-#define MT6360_PMU_CHG_HIDDEN_CTRL9		0x38
-#define MT6360_PMU_CHG_HIDDEN_CTRL10		0x39
-#define MT6360_PMU_CHG_HIDDEN_CTRL11		0x3A
-#define MT6360_PMU_CHG_HIDDEN_CTRL12		0x3B
-#define MT6360_PMU_CHG_HIDDEN_CTRL13		0x3C
-#define MT6360_PMU_CHG_HIDDEN_CTRL14		0x3D
-#define MT6360_PMU_CHG_HIDDEN_CTRL15		0x3E
-#define MT6360_PMU_CHG_HIDDEN_CTRL16		0x3F
-#define MT6360_PMU_CHG_HIDDEN_CTRL17		0x40
-#define MT6360_PMU_CHG_HIDDEN_CTRL18		0x41
-#define MT6360_PMU_CHG_HIDDEN_CTRL19		0x42
-#define MT6360_PMU_CHG_HIDDEN_CTRL20		0x43
-#define MT6360_PMU_CHG_HIDDEN_CTRL21		0x44
-#define MT6360_PMU_CHG_HIDDEN_CTRL22		0x45
-#define MT6360_PMU_CHG_HIDDEN_CTRL23		0x46
-#define MT6360_PMU_CHG_HIDDEN_CTRL24		0x47
-#define MT6360_PMU_CHG_HIDDEN_CTRL25		0x48
-#define MT6360_PMU_BC12_CTRL			0x49
-#define MT6360_PMU_CHG_STAT			0x4A
-#define MT6360_PMU_RESV1			0x4B
-#define MT6360_PMU_TYPEC_OTP_TH_SEL_CODEH	0x4E
-#define MT6360_PMU_TYPEC_OTP_TH_SEL_CODEL	0x4F
-#define MT6360_PMU_TYPEC_OTP_HYST_TH		0x50
-#define MT6360_PMU_TYPEC_OTP_CTRL		0x51
-#define MT6360_PMU_ADC_BAT_DATA_H		0x52
-#define MT6360_PMU_ADC_BAT_DATA_L		0x53
-#define MT6360_PMU_IMID_BACKBST_ON		0x54
-#define MT6360_PMU_IMID_BACKBST_OFF		0x55
-#define MT6360_PMU_ADC_CONFIG			0x56
-#define MT6360_PMU_ADC_EN2			0x57
-#define MT6360_PMU_ADC_IDLE_T			0x58
-#define MT6360_PMU_ADC_RPT_1			0x5A
-#define MT6360_PMU_ADC_RPT_2			0x5B
-#define MT6360_PMU_ADC_RPT_3			0x5C
-#define MT6360_PMU_ADC_RPT_ORG1			0x5D
-#define MT6360_PMU_ADC_RPT_ORG2			0x5E
-#define MT6360_PMU_BAT_OVP_TH_SEL_CODEH		0x5F
-#define MT6360_PMU_BAT_OVP_TH_SEL_CODEL		0x60
-#define MT6360_PMU_CHG_CTRL19			0x61
-#define MT6360_PMU_VDDASUPPLY			0x62
-#define MT6360_PMU_BC12_MANUAL			0x63
-#define MT6360_PMU_CHGDET_FUNC			0x64
-#define MT6360_PMU_FOD_CTRL			0x65
-#define MT6360_PMU_CHG_CTRL20			0x66
-#define MT6360_PMU_CHG_HIDDEN_CTRL26		0x67
-#define MT6360_PMU_CHG_HIDDEN_CTRL27		0x68
-#define MT6360_PMU_RESV2			0x69
-#define MT6360_PMU_USBID_CTRL1			0x6D
-#define MT6360_PMU_USBID_CTRL2			0x6E
-#define MT6360_PMU_USBID_CTRL3			0x6F
-#define MT6360_PMU_FLED_CFG			0x70
-#define MT6360_PMU_RESV3			0x71
-#define MT6360_PMU_FLED1_CTRL			0x72
-#define MT6360_PMU_FLED_STRB_CTRL		0x73
-#define MT6360_PMU_FLED1_STRB_CTRL2		0x74
-#define MT6360_PMU_FLED1_TOR_CTRL		0x75
-#define MT6360_PMU_FLED2_CTRL			0x76
-#define MT6360_PMU_RESV4			0x77
-#define MT6360_PMU_FLED2_STRB_CTRL2		0x78
-#define MT6360_PMU_FLED2_TOR_CTRL		0x79
-#define MT6360_PMU_FLED_VMIDTRK_CTRL1		0x7A
-#define MT6360_PMU_FLED_VMID_RTM		0x7B
-#define MT6360_PMU_FLED_VMIDTRK_CTRL2		0x7C
-#define MT6360_PMU_FLED_PWSEL			0x7D
-#define MT6360_PMU_FLED_EN			0x7E
-#define MT6360_PMU_FLED_Hidden1			0x7F
-#define MT6360_PMU_RGB_EN			0x80
-#define MT6360_PMU_RGB1_ISNK			0x81
-#define MT6360_PMU_RGB2_ISNK			0x82
-#define MT6360_PMU_RGB3_ISNK			0x83
-#define MT6360_PMU_RGB_ML_ISNK			0x84
-#define MT6360_PMU_RGB1_DIM			0x85
-#define MT6360_PMU_RGB2_DIM			0x86
-#define MT6360_PMU_RGB3_DIM			0x87
-#define MT6360_PMU_RESV5			0x88
-#define MT6360_PMU_RGB12_Freq			0x89
-#define MT6360_PMU_RGB34_Freq			0x8A
-#define MT6360_PMU_RGB1_Tr			0x8B
-#define MT6360_PMU_RGB1_Tf			0x8C
-#define MT6360_PMU_RGB1_TON_TOFF		0x8D
-#define MT6360_PMU_RGB2_Tr			0x8E
-#define MT6360_PMU_RGB2_Tf			0x8F
-#define MT6360_PMU_RGB2_TON_TOFF		0x90
-#define MT6360_PMU_RGB3_Tr			0x91
-#define MT6360_PMU_RGB3_Tf			0x92
-#define MT6360_PMU_RGB3_TON_TOFF		0x93
-#define MT6360_PMU_RGB_Hidden_CTRL1		0x94
-#define MT6360_PMU_RGB_Hidden_CTRL2		0x95
-#define MT6360_PMU_RESV6			0x97
-#define MT6360_PMU_SPARE1			0x9A
-#define MT6360_PMU_SPARE2			0xA0
-#define MT6360_PMU_SPARE3			0xB0
-#define MT6360_PMU_SPARE4			0xC0
-#define MT6360_PMU_CHG_IRQ1			0xD0
-#define MT6360_PMU_CHG_IRQ2			0xD1
-#define MT6360_PMU_CHG_IRQ3			0xD2
-#define MT6360_PMU_CHG_IRQ4			0xD3
-#define MT6360_PMU_CHG_IRQ5			0xD4
-#define MT6360_PMU_CHG_IRQ6			0xD5
-#define MT6360_PMU_QC_IRQ			0xD6
-#define MT6360_PMU_FOD_IRQ			0xD7
-#define MT6360_PMU_BASE_IRQ			0xD8
-#define MT6360_PMU_FLED_IRQ1			0xD9
-#define MT6360_PMU_FLED_IRQ2			0xDA
-#define MT6360_PMU_RGB_IRQ			0xDB
-#define MT6360_PMU_BUCK1_IRQ			0xDC
-#define MT6360_PMU_BUCK2_IRQ			0xDD
-#define MT6360_PMU_LDO_IRQ1			0xDE
-#define MT6360_PMU_LDO_IRQ2			0xDF
-#define MT6360_PMU_CHG_STAT1			0xE0
-#define MT6360_PMU_CHG_STAT2			0xE1
-#define MT6360_PMU_CHG_STAT3			0xE2
-#define MT6360_PMU_CHG_STAT4			0xE3
-#define MT6360_PMU_CHG_STAT5			0xE4
-#define MT6360_PMU_CHG_STAT6			0xE5
-#define MT6360_PMU_QC_STAT			0xE6
-#define MT6360_PMU_FOD_STAT			0xE7
-#define MT6360_PMU_BASE_STAT			0xE8
-#define MT6360_PMU_FLED_STAT1			0xE9
-#define MT6360_PMU_FLED_STAT2			0xEA
-#define MT6360_PMU_RGB_STAT			0xEB
-#define MT6360_PMU_BUCK1_STAT			0xEC
-#define MT6360_PMU_BUCK2_STAT			0xED
-#define MT6360_PMU_LDO_STAT1			0xEE
-#define MT6360_PMU_LDO_STAT2			0xEF
-#define MT6360_PMU_CHG_MASK1			0xF0
-#define MT6360_PMU_CHG_MASK2			0xF1
-#define MT6360_PMU_CHG_MASK3			0xF2
-#define MT6360_PMU_CHG_MASK4			0xF3
-#define MT6360_PMU_CHG_MASK5			0xF4
-#define MT6360_PMU_CHG_MASK6			0xF5
-#define MT6360_PMU_QC_MASK			0xF6
-#define MT6360_PMU_FOD_MASK			0xF7
-#define MT6360_PMU_BASE_MASK			0xF8
-#define MT6360_PMU_FLED_MASK1			0xF9
-#define MT6360_PMU_FLED_MASK2			0xFA
-#define MT6360_PMU_FAULTB_MASK			0xFB
-#define MT6360_PMU_BUCK1_MASK			0xFC
-#define MT6360_PMU_BUCK2_MASK			0xFD
-#define MT6360_PMU_LDO_MASK1			0xFE
-#define MT6360_PMU_LDO_MASK2			0xFF
-#define MT6360_PMU_MAXREG			MT6360_PMU_LDO_MASK2
-
-/* MT6360_PMU_IRQ_SET */
-#define MT6360_PMU_IRQ_REGNUM	16
-#define MT6360_IRQ_RETRIG	BIT(2)
-
-#define CHIP_VEN_MASK				0xF0
-#define CHIP_VEN_MT6360				0x50
-#define CHIP_REV_MASK				0x0F
-
-#endif /* __MT6360_H__ */
-- 
2.7.4

