Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6C862AF1F3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 14:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgKKNWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 08:22:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgKKNWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 08:22:00 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63755C0613D1;
        Wed, 11 Nov 2020 05:22:00 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 11so2068986ljf.2;
        Wed, 11 Nov 2020 05:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9r8b49v3ljRgTZvFAK4d4bWtQHAXArk3oNTb3u4fiLk=;
        b=Uj1A0CfbE2XeLHe3CdC7MeMYY0nAH9W5JXxtsE8KohRUij0Es6UpaHYgTSKcmRncl9
         lzwd+FfeMJ0+f1sFzz47qsO+XzzHkwNW6IoK65hYUsifHPOJzhXbY2vm3Q/vmiJejbUC
         SWJKePFV3pigYGgp0CeESneg1CAObVqHpXs2MkIPwApV4s4QV61YsWqkqMGJwnFjSBkl
         q0sKJRKTq0c+E3i5QHDqmSKx6B7LH5cYOPPaGvWL7ei3GqKlTbCeLnT8Mg7lBEhe3hul
         ANoHR8qJO4zWa8NBOth12VbLxl8FzSOrf+6vVpKGbDZHg9NjgGDRErjBcF+CzweJOw7M
         oTjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9r8b49v3ljRgTZvFAK4d4bWtQHAXArk3oNTb3u4fiLk=;
        b=hyPKCdzgQa06Y1ohcXZZX+ZjtTdEB1WviKf1EFxQLwpPFiwrpqJ9o7A6uj8Q1a4ljU
         ujy3yzO/f4pJDjQPwkt53Tp9Upn6t1oLcy9qpsCFsOBuhjteSWtRQ6GQe3T/hIf2DL4N
         rcOcHVlg9F9rJIHfFWDAIj50k2QczAAYZpHrGJGIqHBNxm7XEPmBn5NhkB3m2SYH1/Fk
         tUhsFZlAfWjtVWgfg7MjXuTgn0mP0/TDaR27TZEJ6I0jmym7MizMpxm4m1CDthaVzfZh
         NCaismtWHBNbJerusFFWv1Ylil+RFh65SR3fcN6SCwWCuLRtXU2KmYZzhLoC+WoR7L4Z
         4Q3Q==
X-Gm-Message-State: AOAM533dIguyoFxo7i5fCOdnAz9Ox8sYVO37fHybn2y/qjRO9loL9N27
        6/0VMeqOzqEYskSf7XVTFK/PGVBjIm6jJqY0
X-Google-Smtp-Source: ABdhPJzN/eXdGxoCDY5GlSXpuq9R04QSHslNVJU7LNNoweciGDxkm1itgTaG89BpzFa6dKVqTrmopw==
X-Received: by 2002:a2e:90cb:: with SMTP id o11mr2572076ljg.465.1605100918885;
        Wed, 11 Nov 2020 05:21:58 -0800 (PST)
Received: from DESKTOP-GSFPEC9.localdomain (broadband-46-242-8-148.ip.moscow.rt.ru. [46.242.8.148])
        by smtp.gmail.com with ESMTPSA id z8sm235545ljh.74.2020.11.11.05.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 05:21:58 -0800 (PST)
From:   Konstantin Aladyshev <aladyshev22@gmail.com>
Cc:     supreeth.venkatesh@amd.com, aladyshev22@gmail.com,
        Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: aspeed: amd-ethanolx: Add GPIO line names
Date:   Wed, 11 Nov 2020 16:21:33 +0300
Message-Id: <20201111132133.1253-1-aladyshev22@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add GPIO line names for AMD EthanolX customer reference board.
It populates AST2500 GPIO lines (A0-A7 to AC0-AC7) with AMD EthanolX
designated names.

Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
index b93ed44eba0c..96ff0aea64e5 100644
--- a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
@@ -97,6 +97,50 @@
 		     &pinctrl_adc4_default>;
 };
 
+&gpio {
+	status = "okay";
+	gpio-line-names =
+	/*A0-A7*/	"","","FAULT_LED","CHASSIS_ID_LED","","","","",
+	/*B0-B7*/	"","","","","","","","",
+	/*C0-C7*/	"CHASSIS_ID_BTN","INTRUDER","AC_LOSS","","","","","",
+	/*D0-D7*/	"HDT_DBREQ","LOCAL_SPI_ROM_SEL","FPGA_SPI_ROM_SEL","JTAG_MUX_S",
+			"JTAG_MUX_OE","HDT_SEL","ASERT_WARM_RST_BTN","FPGA_RSVD",
+	/*E0-E7*/	"","","MON_P0_PWR_BTN","MON_P0_RST_BTN","MON_P0_NMI_BTN",
+			"MON_P0_PWR_GOOD","MON_PWROK","MON_RESET",
+	/*F0-F7*/	"MON_P0_PROCHOT","MON_P1_PROCHOT","MON_P0_THERMTRIP",
+			"MON_P1_THERMTRIP","P0_PRESENT","P1_PRESENT","MON_ATX_PWR_OK","",
+	/*G0-G7*/	"BRD_REV_ID_3","BRD_REV_ID_2","BRD_REV_ID_1","BRD_REV_ID_0",
+			"P0_APML_ALERT","P1_APML_ALERT","FPGA ALERT","",
+	/*H0-H7*/	"BRD_ID_0","BRD_ID_1","BRD_ID_2","BRD_ID_3",
+			"PCIE_DISCONNECTED","USB_DISCONNECTED","SPARE_0","SPARE_1",
+	/*I0-I7*/	"","","","","","","","",
+	/*J0-J7*/	"","","","","","","","",
+	/*K0-K7*/	"","","","","","","","",
+	/*L0-L7*/	"","","","","","","","",
+	/*M0-M7*/	"ASSERT_PWR_BTN","ASSERT_RST_BTN","ASSERT_NMI_BTN",
+			"ASSERT_LOCAL_LOCK","ASSERT_P0_PROCHOT","ASSERT_P1_PROCHOT",
+			"ASSERT_CLR_CMOS","ASSERT_BMC_READY",
+	/*N0-N7*/	"","","","","","","","",
+	/*O0-O7*/	"","","","","","","","",
+	/*P0-P7*/	"P0_VDD_CORE_RUN_VRHOT","P0_VDD_SOC_RUN_VRHOT",
+			"P0_VDD_MEM_ABCD_SUS_VRHOT","P0_VDD_MEM_EFGH_SUS_VRHOT",
+			"P1_VDD_CORE_RUN_VRHOT","P1_VDD_SOC_RUN_VRHOT",
+			"P1_VDD_MEM_ABCD_SUS_VRHOT","P1_VDD_MEM_EFGH_SUS_VRHOT",
+	/*Q0-Q7*/	"","","","","","","","",
+	/*R0-R7*/	"","","","","","","","",
+	/*S0-S7*/	"","","","","","","","",
+	/*T0-T7*/	"","","","","","","","",
+	/*U0-U7*/	"","","","","","","","",
+	/*V0-V7*/	"","","","","","","","",
+	/*W0-W7*/	"","","","","","","","",
+	/*X0-X7*/	"","","","","","","","",
+	/*Y0-Y7*/	"","","","","","","","",
+	/*Z0-Z7*/	"","","","","","","","",
+	/*AA0-AA7*/	"","SENSOR THERM","","","","","","",
+	/*AB0-AB7*/	"","","","","","","","",
+	/*AC0-AC7*/	"","","","","","","","";
+};
+
 //APML for P0
 &i2c0 {
 	status = "okay";
-- 
2.17.1

