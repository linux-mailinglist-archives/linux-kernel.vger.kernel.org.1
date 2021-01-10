Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 579D92F0504
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 04:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbhAJD7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 22:59:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:34974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbhAJD7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 22:59:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EE6B722DBF;
        Sun, 10 Jan 2021 03:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610251130;
        bh=XBh3xURhtblajRqazPG5HcxWnzDN6UC7F4000rWWthI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RumPg9Fr/nuLuP/rZ1sD74CYEP4SrdGa1xb2S14JE4K2Prx/NLHp+wrBa1FpRPSvv
         U0L4bsr8LyFGlxWAQyzTaM/PRYCD0AWlvbmZVM9c4SAeFKrWOELMArf6FObNj1zr6X
         lP/VrV+aioeRO4UNaj6/CHsWpx38Ws0tYR0EHBWHF7PE6DbvlLTHJc0RChnyLBmP9O
         jn5ErlYuVM3MhcLgNtE6euX3p9CFNNxVSLzT1bRYEQ45leSIzH3/a/nUQymkz6dw/A
         0s5DhAxJ6YUEJZdoPPJVv3IkR4V8M+lKPvf6jAScGRWOP5eK33OcpuEbO/5OVrgod6
         v/RSN7JZQKlhA==
Received: by wens.tw (Postfix, from userid 1000)
        id 095595F74A; Sun, 10 Jan 2021 11:58:47 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 2/3] dt-bindings: arm: rockchip: Add Radxa ROCK Pi E
Date:   Sun, 10 Jan 2021 11:58:45 +0800
Message-Id: <20210110035846.9155-3-wens@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210110035846.9155-1-wens@kernel.org>
References: <20210110035846.9155-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

Radxa ROCK Pi E is a router oriented SBC based on Rockchip's RK3328 SoC.
As the official wiki page puts it, "E for Ethernets".

It features the RK3328 SoC, gigabit and fast Ethernet RJ45 ports, both
directly served by Ethernet controllers in the SoC, a USB 3.0 host port,
a power-only USB type-C port, a 3.5mm headphone jack for audio output,
two LEDs, a 40-pin Raspberry Pi style GPIO header, and optional WiFi+BT
and PoE header.

The board comes in multiple configurations, differing in the amount of
onboard RAM, the level of WiFi+BT (none, 802.11n 2.4GHz, or 802.11ac
2.4 GHz & 5 GHz), and whether PoE is supported or not. These variants
can all share the same device tree.

The USB 2.0 OTG controller is available on the 40-pin header. This is
not enabled in the device tree, since it is possible to use it in a
host-only configuration, or in OTG mode with an extra pin from the
header as the ID pin.

The device tree is based on the one of the Rock64, with various parts
modified to match the ROCK Pi E, and some parts updated to newer styles,
such as the gmac2io node's mdio sub-node.

Add a compatible string for the new board.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 773fd4c531ed..c3036f95c7bc 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -468,6 +468,11 @@ properties:
           - const: radxa,rockpi4
           - const: rockchip,rk3399
 
+      - description: Radxa ROCK Pi E
+        items:
+          - const: radxa,rockpi-e
+          - const: rockchip,rk3328
+
       - description: Radxa ROCK Pi N8
         items:
           - const: radxa,rockpi-n8
-- 
2.29.2

