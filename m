Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 911262F919C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jan 2021 11:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbhAQKIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 05:08:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:43686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbhAQKIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 05:08:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 582242065D;
        Sun, 17 Jan 2021 10:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610878040;
        bh=Yw9bKGMMjbT/B2fs5V+L315qs6+uxMdbZj5J9okSfmI=;
        h=From:To:Cc:Subject:Date:From;
        b=hJ1o7fUCIcY87s/Ai2uDdfkd8CcYCLdk23ZBzfX46jKfKboOgq0q1YIDf5Z6v9Nwj
         JA/fZN/ZEBB4+j7i1fyqLNZGsfzWRIxT4rrwogn3dvBe0oyOccW+fNjOokoFX556dr
         hdlsbnUoblPGrntlcPLvMv2LJqQYAmaKTivzmWcV3y1A0y4SGrUZjmcsV1zNSLHuma
         P0XQJcIGn4exx6daNIWQtNPV60PxV2DQFQjjR5a4TfEhuTUO2iJdj3j+46tmP0JzWW
         tCafu36KlJOOdWPiwyb0Vte/FoGK6EpajZXQmjK0NqNwjfTidq50GrvP7xBy/FCPAo
         8JAvDSTlpH54A==
Received: by wens.tw (Postfix, from userid 1000)
        id A30705FA96; Sun, 17 Jan 2021 18:07:17 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 0/3] arm64: rockchip: rk3328: Add Radxa ROCK Pi E
Date:   Sun, 17 Jan 2021 18:07:07 +0800
Message-Id: <20210117100710.4857-1-wens@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

Hi everyone,

This is v2 of my ROCK Pi E support series.

Changes since v1:

- Picked up Rob's Ack for the binding
- Dropped comment about LED color
- Dropped max-frequency from emmc node
- Changed pingroup name from "ethernet-phy" to "ephy" to avoid DT binding
  check failure
- Dropped cap-mmc-highspeed from sdmmc node
- Fixed regulator properties to have consistent ordering
- Added adc-key for recovery button
- Sorted header files

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
 .../boot/dts/rockchip/rk3328-rock-pi-e.dts    | 382 ++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3328.dtsi      |   1 +
 4 files changed, 389 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts

-- 
2.29.2

