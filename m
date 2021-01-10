Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 149F62F06C3
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 12:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbhAJLyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 06:54:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbhAJLyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 06:54:54 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFAA2C0617A3;
        Sun, 10 Jan 2021 03:54:13 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id 81so14684821ioc.13;
        Sun, 10 Jan 2021 03:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7RoK005uE/qFSPumNKEGnm/g33j+iG5Ts9GmzGFIgKE=;
        b=YgXbtQmnK5M/P0WS7dYb1HCf3k5xprdseoGJn1TEsERtyLnVpnuGsy3VkAjSFZYSQI
         tQsFWaWv7iNPvTx0EJ0jwSXdXwuVdYMaTBYj3S4H/blsca7tnnhvw647SO9QnTR4sFb5
         +wqNsPnvLeE9U+7Ppq2QlC/7Osz6VrMsOnwneydQDe4FtCaGGp/9TzNd3HKhzMnF//lV
         R6s1lIBU1HvMadq+amh8Cp5MWcuoxsHfPuF6fJVuM2N2LOm7M7BJfYcHPIYJVbQEDWjj
         FrL1IMTbtrwozCk7aJ8JjIlf6VOpxzIH6ATtAAHL/EqClnO3PfeNe+uHhyTeU6YCWqnO
         +IVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7RoK005uE/qFSPumNKEGnm/g33j+iG5Ts9GmzGFIgKE=;
        b=AhRNKzaV8OIE5dxktwgAb+c7cxVToo5od0Wl3qRI54ZF9B5dOnycuhEIovjKyMPsLB
         78yc47zR4zR6EPNUI4cCvRTGOns9FvSMeT+AGuFb8P4rzver2KgWkpZpC80Ufl7Nrw/e
         5jI/2Oei8UiRcpFY6qCApKW07cANOVokEligHSxkHJvvp4ZysFIqkzQJBpakZM8VkJZI
         /X7IsQfExH48PRHpMH6/P80EWDlssI132ZYGei1ME+cKfRJCw0sRN5seAwKeDh6VxdeH
         f517J5LjFZDAlhYJnoUtjg05J6+wicpLtCDhs+DIUvIO6UBoC3f9eK/gbVLOFQ62v81U
         LaLw==
X-Gm-Message-State: AOAM5303k5rjcIZC46+vCdIH8FDLYo2e7ND36fiAuZfEgperZQPmQmuG
        xz8C8i/z0F0srLXfODbPS9U=
X-Google-Smtp-Source: ABdhPJwF3q87BcCxzzvNxRtizuQv69WzUYBls3XK6WJwaUUZ6MFkWkJUGa4e58JcBGDAcbzIZtAx6g==
X-Received: by 2002:a02:6557:: with SMTP id u84mr10391980jab.82.1610279653238;
        Sun, 10 Jan 2021 03:54:13 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:4119:2ef1:4993:8ada])
        by smtp.gmail.com with ESMTPSA id 64sm9518063iow.9.2021.01.10.03.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jan 2021 03:54:12 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: imx8mn-beacon-som: Configure RTC aliases
Date:   Sun, 10 Jan 2021 05:53:53 -0600
Message-Id: <20210110115354.1259994-1-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the i.MX8MN Beacon SOM, there is an RTC chip which is fed power
from the baseboard during power off.  The SNVS RTC integrated into
the SoC is not fed power.  Depending on the order the modules are
loaded, this can be a problem if the external RTC isn't rtc0.

Make the alias for rtc0 point to the external RTC all the time and
rtc1 point to the SVNS in order to correctly hold date/time over
a power-cycle.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-beacon-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-beacon-som.dtsi
index 67e5e5b9ddea..2120e6485393 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-beacon-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn-beacon-som.dtsi
@@ -4,6 +4,11 @@
  */
 
 / {
+	aliases {
+		rtc0 = &rtc;
+		rtc1 = &snvs_rtc;
+	};
+
 	usdhc1_pwrseq: usdhc1_pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		pinctrl-names = "default";
@@ -212,7 +217,7 @@ eeprom@50 {
 		reg = <0x50>;
 	};
 
-	rtc@51 {
+	rtc: rtc@51 {
 		compatible = "nxp,pcf85263";
 		reg = <0x51>;
 	};
-- 
2.25.1

