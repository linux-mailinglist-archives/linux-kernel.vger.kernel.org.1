Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 259E12C5534
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 14:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389906AbgKZNZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 08:25:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389860AbgKZNZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:25:16 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5908C0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:25:15 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id q3so2243869edr.12
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cQeOeqOUNsUzfF0JL4vUqMRHKfG8Lm+YDjVMgms9LCQ=;
        b=QpGDbp2eBgIwKefUysT16RytBQziLGFJBxQeoTy+aVBDVcm7r1fsG8LqL6A+o9JCjf
         wW6do/77uFP1JaLATUDgmzMz6ID4dk1sxw4ZIiNX/bbEmMYClT4UDPf51Jqv36tjym0Q
         i86J4x2WsVXPYT1LQQZTyr7rfoMohTpzkATomXJOrRP2Dtr/Elf651VHGABc3DpbK2Zs
         lVymFzINrSsmM9Nf1n9yAl9AUzbeA+RMIvmym8uCX1dcs1X01PB0xmzBw6kLIrQosrE6
         QiG0e64e4HmLF5uOGBDcb6Yv4TN8TnpFutQ+Sehpk6X1oNuy1h7CHnMPAYfOhCq20qFJ
         FYug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=cQeOeqOUNsUzfF0JL4vUqMRHKfG8Lm+YDjVMgms9LCQ=;
        b=ouB7FjGEKecvbwIRDLelbQPbNyIzrmDbK9QBLnfZAd+1z+ln4GhFU/qzVIS8nPaFyF
         tY/Nk1FRZr/snwR7ooOTNGZ/XeQyjHj1qK+QF8HMKlzvs4ZTlvSP4yCqlD1SK+2V64Rq
         J/1fq883x2VPg/dgBe/mruE5johttLpVV6quu76Be79x0IrmdkxsiY9JquiCdsiV7St+
         naRUZ2bkN/RH/oRXDwqskK59USe4HvmceEKKKjM80OlEqfaE+OooV3R37gCLgRLizCrM
         SXvM5GllUZmsviocWcSiGXy9NHVtY5C59otcMwXpHoWfN9WXRFtMq/eKYZ8j6ugGBhve
         mO7g==
X-Gm-Message-State: AOAM5304NS77Rb2peDRK8OGgsx63v4hRbonAv1zXK8T2jtStzp72nLZu
        ZBUGjA0X+s/Re4JAkWeEVuOSGk2oIoJdXBE/
X-Google-Smtp-Source: ABdhPJxqPR7ITqZyUSue+6/AxAFJdqAZ1ARBtfjlqsUgYq7VI3xVkesO53eCg6a0tj4RtzFACnj9Vw==
X-Received: by 2002:a50:ed84:: with SMTP id h4mr2421995edr.230.1606397114470;
        Thu, 26 Nov 2020 05:25:14 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id d22sm2405852eja.72.2020.11.26.05.25.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Nov 2020 05:25:13 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/5] ARM: zynq: Fix leds subnode name for zc702/zybo-z7
Date:   Thu, 26 Nov 2020 14:25:02 +0100
Message-Id: <607a66783b129294364abf09a6fc8abd241ff4ee.1606397101.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1606397101.git.michal.simek@xilinx.com>
References: <cover.1606397101.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the leds subnode names to match (^led-[0-9a-f]$|led).

Similar change has been also done by commit 9a19a39ee48b ("arm64: dts:
zynqmp: Fix leds subnode name for zcu100/ultra96 v1").

The patch is fixing these warnings:
.../zynq-zc702.dt.yaml: leds: 'ds23' does not match any of the regexes:
'(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
From schema: .../Documentation/devicetree/bindings/leds/leds-gpio.yaml
.../zynq-zybo-z7.dt.yaml: gpio-leds: 'ld4' does not match any of the
regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
From schema: .../Documentation/devicetree/bindings/leds/leds-gpio.yaml

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm/boot/dts/zynq-zc702.dts   | 2 +-
 arch/arm/boot/dts/zynq-zybo-z7.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/zynq-zc702.dts b/arch/arm/boot/dts/zynq-zc702.dts
index 27cd6cb52f1b..10a7d0b8cf8b 100644
--- a/arch/arm/boot/dts/zynq-zc702.dts
+++ b/arch/arm/boot/dts/zynq-zc702.dts
@@ -49,7 +49,7 @@ sw13 {
 	leds {
 		compatible = "gpio-leds";
 
-		ds23 {
+		led-ds23 {
 			label = "ds23";
 			gpios = <&gpio0 10 0>;
 			linux,default-trigger = "heartbeat";
diff --git a/arch/arm/boot/dts/zynq-zybo-z7.dts b/arch/arm/boot/dts/zynq-zybo-z7.dts
index 357b78a5c11b..7b87e10d3953 100644
--- a/arch/arm/boot/dts/zynq-zybo-z7.dts
+++ b/arch/arm/boot/dts/zynq-zybo-z7.dts
@@ -25,7 +25,7 @@ chosen {
 	gpio-leds {
 		compatible = "gpio-leds";
 
-		ld4 {
+		led-ld4 {
 			label = "zynq-zybo-z7:green:ld4";
 			gpios = <&gpio0 7 GPIO_ACTIVE_HIGH>;
 		};
-- 
2.29.2

