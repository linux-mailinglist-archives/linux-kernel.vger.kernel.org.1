Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6C981BF742
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 13:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgD3L5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 07:57:09 -0400
Received: from plaes.org ([188.166.43.21]:37004 "EHLO plaes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbgD3L5J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 07:57:09 -0400
Received: from localhost (unknown [IPv6:2001:1530:1000:d397:940e:6b9e:3deb:3])
        by plaes.org (Postfix) with ESMTPSA id BE84340020;
        Thu, 30 Apr 2020 11:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
        t=1588247827; bh=9ytpHlutDRoUSh496p21AHYxrRL9x3p+AfLf7VwScpI=;
        h=From:To:Cc:Subject:Date:From;
        b=PZnDZsL8HLNYJpzeW6lPXaNSKVBxBuZWZn3UyrJxNKlokN2Ckj0PNMi7/J06UfrNz
         UEMk1fD0LJQDrOWRTWk631RYhGm1SSrl3FLiC8nsgz4EZ7TdiD8rDT7skIjmgNLgg9
         RkdSJiYvge5C4GeEKMGXZRLBHZqllnkcTxAlMqlnDXsDwob+6p2QZrCNGHQ9xBs24C
         PgPxhhTcbHyi00zbWuQIXjldu8/ayw6NeB4uwMBrHeKCiKXJpj5tITfc46Ep4zTSyi
         akHL875ivcDwCWMO2LPDDb4qAfpVDiqdY8y+iUfCP8xGs7Kddzt+XZA8PoqkNmin1u
         fK+U8KiV2hkDw==
From:   Priit Laes <plaes@plaes.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-sunxi@googlegroups.com
Cc:     Priit Laes <plaes@plaes.org>
Subject: [PATCH v2 0/6] ARM: sunxi: Clean up sun7i-a20-gmac-clk usage 
Date:   Thu, 30 Apr 2020 14:56:56 +0300
Message-Id: <20200430115702.5768-1-plaes@plaes.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This serie implements syscon-based regmap access to dwmac-sunxi driver,
allowing to deprecate the allwinner,sun7i-a20-gmac-clk clock driver.

In order to register regmap, we firstly need to change existing clock
setups (sun7i-a20 and sun6i-a31) from CLK_OF_DECLARE to
CLK_OF_DECLARE_DRIVER to allow probing the same driver again via the
platform driver framework.

This patchset touches 3 areas:
- sun7i and sun6i CCUs now set up regmap to allow dwmac-sunxi driver
to access GMAC clock register.
- dwmac-sunxi can now handle syscon-based clock register to handle
its own clock.
- sun7i and sun6i devicetrees are converted to use the new syscon-based
access.

After this patchset:
- sun7i-a20 works fully without legacy sunxi clocks (CLK_SUNXI)
- only sun9i-a80 SoC remains as a single sun7i-a20-gmac-clk user.

Please note that sun6i-a31 changes are only build-tested, as I lack
the hardware to test this.

Changes since v2:
* Fix broken sun6i-a31 CCU patch.
* Rename series to "Clean up sun7i-a20-gmac-clk usage"

Changes since v1:
* Use CLK_OF_DECLARE_DRIVER to make it possible to probe again and set up
regmap using platform device probe.
* Clarify the meaning of "legacy" in dwmac-sunxi driver.
* Make sure we don't mess with the RX/TX delay settings when updating
clock registers.
* Update devicetree bindings
* Add sun6i-A31 support. (not tested due to lack of hardware)

Priit Laes (6):
  clk: sunxi-ng: a20: Register regmap for sun7i CCU
  clk: sunxi-ng: a31: Register regmap for sun6i CCU
  net: stmmac: dwmac-sunxi: Implement syscon-based clock handling
  dt-bindings: net: sun7i-gmac: Add syscon support
  ARM: dts: sun7i: Use syscon-based implementation for gmac
  ARM: dts: sun6i: Use syscon-based implementation for gmac

 .../net/allwinner,sun7i-a20-gmac.yaml         |  15 +-
 arch/arm/boot/dts/sun6i-a31.dtsi              |  35 +----
 arch/arm/boot/dts/sun7i-a20.dtsi              |  36 +----
 drivers/clk/sunxi-ng/ccu-sun4i-a10.c          |  62 ++++++++-
 drivers/clk/sunxi-ng/ccu-sun6i-a31.c          |  62 ++++++++-
 .../net/ethernet/stmicro/stmmac/dwmac-sunxi.c | 130 ++++++++++++++++--
 6 files changed, 261 insertions(+), 79 deletions(-)

-- 
2.26.2

