Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D48022F0503
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 04:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbhAJD7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 22:59:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:35000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726447AbhAJD7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 22:59:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5E65723118;
        Sun, 10 Jan 2021 03:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610251130;
        bh=C/W4mAMHGOQEJFNc8A0ODhMjqrOG4pFNWO9ISfCS7NA=;
        h=From:To:Cc:Subject:Date:From;
        b=Y93JeKdyAKyhGB4P8WXWuhbnwq7A9jr7SK9zh1DWVEhlrO1kpsqDkKFNP/RFU1Vkf
         uFGupvNgAEQessF2vacB3nhjt2s8gP6HIUPdiHrqat5kI9zAY1LFR1y9UwyhSOtOVe
         IXV9GSyySjh9JtG3idR/WXgW1RC4DSO3l9jzpVT/NNhqlSBKOpEZt1orETVxujLTuo
         jTGIKz0rVWUfo4juDW0W6cz8lRPfn/4IczG/A0TQ0oYJphIMaADnyl+PTh/u/o4wA8
         OnLh8zkr2TfIreFPNAUHEdHCj+qw9d6aLWXqNu7ZxsR8VnjQxxQo+VMxYTb+8pjOiV
         X1Tf0PwfrxNqQ==
Received: by wens.tw (Postfix, from userid 1000)
        id F0B055FB6A; Sun, 10 Jan 2021 11:58:46 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 0/3] arm64: rockchip: rk3328: Add Radxa ROCK Pi E
Date:   Sun, 10 Jan 2021 11:58:43 +0800
Message-Id: <20210110035846.9155-1-wens@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

Hi everyone,

This series adds support for the Radxa ROCK Pi E. This is a router
oriented SBC based on Rockchip's RK3328 SoC. As the official wiki page
puts it, "E for Ethernets".

It features the RK3328 SoC, gigabit and fast Ethernet RJ45 ports, both
directly served by Ethernet controllers in the SoC, a USB 3.0 host port,
a power-only USB type-C port, a 3.5mm headphone jack for audio output,
two LEDs, a 40-pin Raspberry Pi style GPIO header, and optional WiFi+BT
and PoE header.

The board comes in multiple configurations, differing in the amount of
onboard RAM, the level of WiFi+BT (none, 802.11n 2.4GHz, or 802.11ac
2.4 GHz & 5 GHz), and whether PoE is supported or not. These variants
can all share the same device tree. Currently, the 802.11ac chip
lacks an in-kernel driver.

The USB 2.0 OTG controller is available on the 40-pin header. This is
not enabled in the device tree, since it is possible to use it in a
host-only configuration, or in OTG mode with an extra pin from the
header as the ID pin.

The device tree is based on the one of the Rock64, with various parts
modified to match the ROCK Pi E, and some parts updated to newer styles,
such as the gmac2io node's mdio sub-node.

Patch 1 adds the clock_in_out property to the gmac2phy node. This would
always have the same setting for gmac2phy, which uses an integrated PHY
in RMII mode. Having this set by default makes enabling gmac2phy at the
board level simpler.

Patch 2 adds a compatible string for this board to the list of Rockchip
based devices.

Patch 3 adds a device tree file for this board. This is based on the
one for the Rock64, with many modifications to adapt it to the new
board, as well as style updates.

Please have a look.


Regards
ChenYu

Chen-Yu Tsai (3):
  arm64: dts: rockchip: rk3328: Add clock_in_out property to gmac2phy
    node
  dt-bindings: arm: rockchip: Add Radxa ROCK Pi E
  arm64: dts: rockchip: rk3328: Add Radxa ROCK Pi E

 .../devicetree/bindings/arm/rockchip.yaml     |   5 +
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3328-rock-pi-e.dts    | 369 ++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3328.dtsi      |   1 +
 4 files changed, 376 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts

-- 
2.29.2

