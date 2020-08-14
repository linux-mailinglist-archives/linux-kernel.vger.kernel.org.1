Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1C8244E61
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Aug 2020 20:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbgHNSLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Aug 2020 14:11:50 -0400
Received: from mail.manjaro.org ([176.9.38.148]:48580 "EHLO mail.manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728034AbgHNSLt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 14:11:49 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.manjaro.org (Postfix) with ESMTP id 19751E1446;
        Fri, 14 Aug 2020 20:11:46 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from mail.manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Ch5L_yQBq8EW; Fri, 14 Aug 2020 20:11:43 +0200 (CEST)
From:   Tobias Schramm <t.schramm@manjaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tobias Schramm <t.schramm@manjaro.org>
Subject: [PATCH] ARM: dts: stm32: use stm32h7 usart compatible string for stm32h743
Date:   Fri, 14 Aug 2020 20:11:25 +0200
Message-Id: <20200814181125.3202399-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously the FIFO on the stm32h743 usart was not utilized, because
the stm32f7 compatible configures it without FIFO support.

Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
---
 arch/arm/boot/dts/stm32h743.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/stm32h743.dtsi b/arch/arm/boot/dts/stm32h743.dtsi
index 69e2f1e78ed6..9dd58974bf8d 100644
--- a/arch/arm/boot/dts/stm32h743.dtsi
+++ b/arch/arm/boot/dts/stm32h743.dtsi
@@ -126,7 +126,7 @@ spi3: spi@40003c00 {
 		};
 
 		usart2: serial@40004400 {
-			compatible = "st,stm32f7-uart";
+			compatible = "st,stm32h7-uart";
 			reg = <0x40004400 0x400>;
 			interrupts = <38>;
 			status = "disabled";
@@ -194,7 +194,7 @@ dac2: dac@2 {
 		};
 
 		usart1: serial@40011000 {
-			compatible = "st,stm32f7-uart";
+			compatible = "st,stm32h7-uart";
 			reg = <0x40011000 0x400>;
 			interrupts = <37>;
 			status = "disabled";
-- 
2.28.0

