Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE0952C5242
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 11:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388204AbgKZKp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 05:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388180AbgKZKp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 05:45:57 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE302C0613D4;
        Thu, 26 Nov 2020 02:45:56 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id u21so1301484iol.12;
        Thu, 26 Nov 2020 02:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K4xHL/8FlQ96VISXMQL4ONhhtmirwRht9opUGBD2zQA=;
        b=glb3h6WTBIewNlAWOUlSd/IIyOtgvsAi8FtttskSdd4zjZhPYlhIABFouihIcHEh+l
         rIXF1HTv5wg+4+F1jrHm0YZS6w6JkzXPA6Jm1PiWQTTZ3nlZPscUIf5r0XMmeNgdBLWF
         aR4Kh5jMabXDYgmoWPIdQXg4kgNMH35EgUhoyb5HEtgNVMjFLxdqWjLdlov1SiOeZQZT
         Lyt64dxJ+RseZMHPs92AWGqyOO/E4eZsc+ic+5bq2/dHT9MkTrm+q7F1MaNN6Wrk//z8
         thf9UWHmJFM+6+yUO7ppx20UvQv/znU/Ms0TevQ+gK+Ifbn+PQzcacFWKwDAT+YSHNag
         ZBvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K4xHL/8FlQ96VISXMQL4ONhhtmirwRht9opUGBD2zQA=;
        b=jZDre2vQwFlGcmJAWVb+5MX1yMG9+UUQ40NoN44+wfr0ifyjCVYlA6k9Qpj4ZI4fxk
         TAY+JvwdQZn+BTcN69OlenJb76zz8USfWixspZSgsN60wztcbqLjhgwcDEi067TL0B0g
         6O2kDQgY2sP3aGpY7uWKNIuvImKMo76RO/yjKaJMEb0Od6DPZyL1kzpUjfmO5bQLpR4f
         CF9/nm3zIVUNxJREY7KVqFP9m5iB56OIziWqUaoCgj4uGw+wveVmb3o9viEJDTmqXMWa
         K+Ztxyq9OdRFIGo5mMB71VWEYCDzrFX9YDIS6ffVNVAlx/1RMsMzainoYJsRQ3evm6Ic
         EUPw==
X-Gm-Message-State: AOAM533ADV+waiPFbZPnfeSAIoyWZm44tkf+Imob1LUWEEaOXEMAYKPX
        MuI/ro7hTdHybJ8xHUjo144=
X-Google-Smtp-Source: ABdhPJzDOeykMQDQwWYaH8BZZEKy3+g0zBvmGpk8Ma4RCWDqGqO6xLogZT9PMYRs6pfQYvuusZpAHw==
X-Received: by 2002:a05:6638:110c:: with SMTP id n12mr2572846jal.75.1606387556168;
        Thu, 26 Nov 2020 02:45:56 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:8da2:e979:8d1:eddb])
        by smtp.gmail.com with ESMTPSA id u11sm2366189iol.51.2020.11.26.02.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 02:45:55 -0800 (PST)
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
Subject: [PATCH V2 1/2] arm64: dts: imx8mm-beacon-som: Configure RTC aliases
Date:   Thu, 26 Nov 2020 04:45:34 -0600
Message-Id: <20201126104535.1075658-1-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the i.MX8MM Beacon SOM, there is an RTC chip which is fed power
from the baseboard during power off.  The SNVS RTC integrated into
the SoC is not fed power.  Depending on the order the modules are
loaded, this can be a problem if the external RTC isn't rtc0.

Make the alias for rtc0 point to the external RTC all the time and
rtc1 point to the SVNS in order to correctly hold date/time over
a power-cycle.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V2:  Remove fixes tag

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
index 5565775270f9..9bdefbba9e90 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
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
@@ -219,7 +224,7 @@ eeprom@50 {
 		reg = <0x50>;
 	};
 
-	rtc@51 {
+	rtc: rtc@51 {
 		compatible = "nxp,pcf85263";
 		reg = <0x51>;
 	};
-- 
2.25.1

