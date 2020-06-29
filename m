Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E1620D14F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jun 2020 20:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbgF2Skd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jun 2020 14:40:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:60642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728204AbgF2SkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:40:21 -0400
Received: from localhost.localdomain (unknown [194.230.155.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9249523343;
        Mon, 29 Jun 2020 08:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593418543;
        bh=lTTyTKp2tnmquFcsNq5+ReqbndcL5tQpxX5n04EmKg4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CIXnTVclnOLzWhqMwlZEeXtUHfKlInmCrPzVPoiuvQNDxrpMXkUAQoWQ9ZUILAKRd
         4JKNV3KCk1V5yrI2UWQaEciDSj18o35mf9xTx0GHubwlX0iKkW3E8t6Pu9pHrqk54o
         VN8G0rgHtjWGjCDIutnCriTdqSuEeA2T+FxdGTTw=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Tsahee Zidenberg <tsahee@annapurnalabs.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 2/3] arm64: dts: alpine: Align GIC nodename with dtschema
Date:   Mon, 29 Jun 2020 10:15:34 +0200
Message-Id: <20200629081535.13502-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200629081535.13502-1-krzk@kernel.org>
References: <20200629081535.13502-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix dtschema validator warnings like:
    gic@f0100000: $nodename:0:
        'gic@f0100000' does not match '^interrupt-controller(@[0-9a-f,]+)*$'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/al/alpine-v2.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/al/alpine-v2.dtsi b/arch/arm64/boot/dts/al/alpine-v2.dtsi
index d5e7e2bb4e6c..de2eaf77b1ff 100644
--- a/arch/arm64/boot/dts/al/alpine-v2.dtsi
+++ b/arch/arm64/boot/dts/al/alpine-v2.dtsi
@@ -113,7 +113,7 @@
 				     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-		gic: gic@f0100000 {
+		gic: interrupt-controller@f0100000 {
 			compatible = "arm,gic-v3";
 			reg = <0x0 0xf0200000 0x0 0x10000>,	/* GIC Dist */
 			      <0x0 0xf0280000 0x0 0x200000>,	/* GICR */
-- 
2.17.1

