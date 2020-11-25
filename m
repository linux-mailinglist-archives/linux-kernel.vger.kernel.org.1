Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A39402C4979
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 22:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731080AbgKYVDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 16:03:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728622AbgKYVDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 16:03:47 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11ED5C0613D4;
        Wed, 25 Nov 2020 13:03:47 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id o8so3538234ioh.0;
        Wed, 25 Nov 2020 13:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WwznoyDHBsJCVbgMxaR7ZjCVsPFN2HZtH9ujSY9qRqY=;
        b=WGfi9RAHiHe/zNHl6FtySgMn2q2nuu92HdPboNPVhihz6HNjPoxVI7L2DNrh14Ehc0
         U97Frh//zAg/GOvjMi0YJMJNXwancZp03JcHm3ZTwQxSP79vHLc9973vc/UDxJGhSINT
         r7PAL9djodayR8lBXMl28aCmJxIyjK+t+o5K36lBEAz9ETaarHhQaaAIAaUQw8c37JmE
         30p8O4wF5B7D5Y56/uyN5OYpngRch2icVa8bo0NVFP0W+0/rYHODWlrXgvE2PaCVYTJX
         rbpeRj8UNSrJ7neKt1R3v3UpZyegrI38vuw1KrPRMuwtNZ5LOglHvvoSl/cQfMjSLM9U
         5l6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WwznoyDHBsJCVbgMxaR7ZjCVsPFN2HZtH9ujSY9qRqY=;
        b=dxabIQ1MFlg1ol0CcIm7oHXF1JXDOKhjT1tlKArZbHAp3iSt/8+mcYhp8EQUYL4dHG
         NBsOwlbbUdL3Pnwa+Udd8tycG1N67m3WkB+ndiRp/q8SWzIGFYHTMALbr/Jetq2hmOPf
         8KdrPtKzot9dMjPp2P8385m8SXzRW+w9VcNBwJYhyFHHLG3MAUZYSJe7wH+Vb0ou0/8O
         qYF2d5Z8IoyHVGsW2lsh+hf4d4LxM6YMLsXkErX5qbQjfmCFTcZRgksG8rEWVMlm9gsG
         fkmH+K7XqbCf8KN/+Cj4aMd6wcZEexoeujH3piTAvD/InARhDb5SUJ4RhULIm1XTtbGx
         KEZQ==
X-Gm-Message-State: AOAM533AqUSvWgs9WghjUpbxGqKlPiqVZq9WTiwUnEtN+kXSBb5uH7RH
        6VyAkU0K4AFc5nIMOxEeaQo=
X-Google-Smtp-Source: ABdhPJzaBSwjfWAsLwaG+BNk9frishX4cRzHoimLv/uEeFvvobpUfwCg0b5CKl+lSvhdD5TlT8/PnA==
X-Received: by 2002:a6b:750e:: with SMTP id l14mr4143177ioh.151.1606338226154;
        Wed, 25 Nov 2020 13:03:46 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:8da2:e979:8d1:eddb])
        by smtp.gmail.com with ESMTPSA id x23sm1564979ioh.28.2020.11.25.13.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 13:03:45 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: imx8mm-beacon-som: Fix RTC aliases
Date:   Wed, 25 Nov 2020 15:03:38 -0600
Message-Id: <20201125210339.1071419-1-aford173@gmail.com>
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

Fixes: 593816fa2f35 ("arm64: dts: imx: Add Beacon i.MX8m-Mini development kit")

Signed-off-by: Adam Ford <aford173@gmail.com>

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

