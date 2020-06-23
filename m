Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C98E320511B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 13:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732511AbgFWLrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 07:47:23 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:54260 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732494AbgFWLrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 07:47:19 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 05NBkITw013767;
        Tue, 23 Jun 2020 20:46:20 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 05NBkITw013767
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1592912780;
        bh=+vQzGBmxVMQUIdgzH/KQsgAtEagEu6vSgTXMfq8htGI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lcOmIh5PIb0NSH3F/W1hVs0bEu3AuRcyAjGSeZqcOOtbn+cwaeYLLgDrC4s83LVWK
         hjFgzYn/E4RZ+64NBuS13jYwBXByvKv+CK6i557BuFye5i84kYHbqjyBghC9l2YEKi
         iclLjmuXFoVZPqm0loHwPq/qQQCMR6AfCwyKh8SKkiHntD2l3jGS72Rjdr3uVQ1Yxw
         fJ5WFM+x3Lhjb1QRbIwneqz72QVmHoTjeeXCQECze3YQkPztmgWi2VRO9Ue/xQKN+m
         mg7XtGAuWbejQMP6Qj5z4JEk9PWbtL+nlEI6E0xo2YqCBXfYQs/hv9oKvSGFfMQ8so
         7vu0T0wX8GExA==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] ARM: dts: uniphier: change support card to simple-mfd from simple-bus
Date:   Tue, 23 Jun 2020 20:46:14 +0900
Message-Id: <20200623114614.792648-4-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200623114614.792648-1-yamada.masahiro@socionext.com>
References: <20200623114614.792648-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'make ARCH=arm dtbs_check' emits the following warning:

  support-card@1,1f00000: $nodename:0: 'support-card@1,1f00000' does not match '^(bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'

Maybe, simple-mfd could be a better fit for this device.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/dts/uniphier-support-card.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/uniphier-support-card.dtsi b/arch/arm/boot/dts/uniphier-support-card.dtsi
index 11e46e7de7c5..eedc10cbc6e6 100644
--- a/arch/arm/boot/dts/uniphier-support-card.dtsi
+++ b/arch/arm/boot/dts/uniphier-support-card.dtsi
@@ -10,7 +10,7 @@ &system_bus {
 	ranges = <1 0x00000000 0x42000000 0x02000000>;
 
 	support_card: support-card@1,1f00000 {
-		compatible = "simple-bus";
+		compatible = "simple-mfd";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0x00000000 1 0x01f00000 0x00100000>;
-- 
2.25.1

