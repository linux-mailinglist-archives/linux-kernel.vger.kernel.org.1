Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6A102E81F9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 21:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgLaUja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Dec 2020 15:39:30 -0500
Received: from vern.gendns.com ([98.142.107.122]:33778 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbgLaUj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Dec 2020 15:39:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lEeXgdp028VV5hJ5mjXAeX/jtJFLXFhcjN2tn3n28jk=; b=KBXtepTJnhf3DCcNTjuvamGQ1e
        gIE3D1D6f1qgaqNjr9hPkleRaS/DW6yKs6WX/LjfQJZYr1X0uoaUkbpfrUOdbKRYmM7ES89kVa1pb
        MlcNaPdBQjJyE/Y5YjnthgDg6HSP2fz+lz4T3VJEpzRes5qDo5uaIRNjmW6TT2wsQgNNnumbb2IrT
        UN0t75iK+qTfOANaW+jvklbVPiO3o32x470pGYmqTaseSIRbvmHJlG7U9RmYRA8L574kQLe6A9ovt
        G0TOPa9n0+AbVikhePp29opjbkaVONhCfg6ipRb90bTWnSou7+80sbEniW8z6wVl3FTbn0W757MNn
        n4lJtlOQ==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:54980 helo=freyr.lechnology.com)
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <david@lechnology.com>)
        id 1kv4ic-0006iP-6a; Thu, 31 Dec 2020 15:38:46 -0500
From:   David Lechner <david@lechnology.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     David Lechner <david@lechnology.com>, Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: da850: add MMD SDIO interrupts
Date:   Thu, 31 Dec 2020 14:38:29 -0600
Message-Id: <20201231203829.2726685-1-david@lechnology.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the MMC SDIO interrupts to the MMC nodes in the device tree
for TI DA850/AM18XX/OMAP-L138.

The missing interrupts were causing the following error message to be
printed:

    davinci_mmc 1c40000.mmc: IRQ index 1 not found

Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/boot/dts/da850.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 7cf31b6e48b7..d2c609e4da5b 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -537,7 +537,7 @@ mmc0: mmc@40000 {
 			reg = <0x40000 0x1000>;
 			cap-sd-highspeed;
 			cap-mmc-highspeed;
-			interrupts = <16>;
+			interrupts = <16>, <17>;
 			dmas = <&edma0 16 0>, <&edma0 17 0>;
 			dma-names = "rx", "tx";
 			clocks = <&psc0 5>;
@@ -567,7 +567,7 @@ mmc1: mmc@21b000 {
 			reg = <0x21b000 0x1000>;
 			cap-sd-highspeed;
 			cap-mmc-highspeed;
-			interrupts = <72>;
+			interrupts = <72>, <73>;
 			dmas = <&edma1 28 0>, <&edma1 29 0>;
 			dma-names = "rx", "tx";
 			clocks = <&psc1 18>;
-- 
2.25.1

