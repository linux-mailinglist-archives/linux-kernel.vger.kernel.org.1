Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3BD82CF0D0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 16:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730587AbgLDPew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 10:34:52 -0500
Received: from mout02.posteo.de ([185.67.36.66]:40095 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727570AbgLDPew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 10:34:52 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 8D4992400FE
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 16:33:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1607096034; bh=nDvMnhXWtgMMBG2z1fvOQmeQhnArJ175aNNKMSNKFjA=;
        h=Date:From:To:Cc:Subject:From;
        b=SVyExLu+L5Q/zS5MLhFTwsRaJAeg9Gdq3NPYvDk6q2jaVN5xQAQHsvhGZu6yF+84s
         PyHjEYMryD56JqXLbh0gL6NCMIzlafR+NuNj/1X/r8l5B5esOq4YoewTnkMVvlrT1x
         UUra1PalMpK1Zb503YaZlOO7nEjToWjNCZa05m1ydkYsGATGCBZzfl2t8BGkL90mR0
         sfKuAq/8cEhRebIx0wWsF0R5neYSjUpazh+bNi/XIe+lsqO6B2fmj+KOKeqEKAAIlV
         /496ap0peA5SBrWWk+ovPSJ393GRkg+yhyg5DTTknxhUC9vRmsiqxRBXS7tCXtjjrh
         rs7IoW6ke1uGg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4CncDq6Q5Fz9rxg;
        Fri,  4 Dec 2020 16:33:47 +0100 (CET)
Date:   Fri, 4 Dec 2020 16:33:46 +0100
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: [PATCH v2 0/2] hwspinlock: add sunxi hardware spinlock support
Message-ID: <cover.1607094989.git.wilken.gottwalt@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the Allwinner sun8i and sun50i based SoCs contain a spinlock
unit which can be used to sync access to devices shared between the ARM
cores in the embedded OpenRisc (AR100) core. This spinlock unit is
included in the A83T, A64, H2+, H3, H5 and H6 SoCs and according to the
datasheets support at least 32 spinlocks. The implementation supports
32, 64, 128 and 256 spinlock setups, but there is no known SoC yet,
which supports more the 32.

This driver adds support for this hardware spinlock unit to Linux
including all 4 possible setups. The driver reports the found setup via
debugfs. It can be build as a builtin and normal module by using the
HWSPINLOCK_SUNXI symbol.

This driver is the first step to enable hwspinlock support in Linux,
but also needs support on the OpenRisc core side in the crust firmware.
This patch provides the driver and binding documentation but is not yet
included into the sun8i and sun50i dtsi files. Also not every sun8i or
sun50i SoC seem to have support for this hardware. For example the H616
is missing the whole spinlock section in the datasheets.

This patch adds:
- hwspinlock driver sunxi_hwspinlock
- updates makefiles
- hwspinlock dt bindings documentation
- updates MAINTAINERS

Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>

Changes in v2:
  - redone coverletter
  - fixed ranges in the device tree description
  - added suggestions from Bjorn Andersson and Maxime Ripard to the driver
  - provided better driver and test description

Wilken Gottwalt (2):
  dt-bindings: hwlock: sunxi: add sunxi_hwspinlock documentation
  hwspinlock: add sunxi hardware spinlock support

 .../bindings/hwlock/sunxi-hwspinlock.yaml     |  64 +++++
 MAINTAINERS                                   |   6 +
 drivers/hwspinlock/Kconfig                    |   9 +
 drivers/hwspinlock/Makefile                   |   1 +
 drivers/hwspinlock/sunxi_hwspinlock.c         | 234 ++++++++++++++++++
 5 files changed, 314 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwlock/sunxi-hwspinlock.yaml
 create mode 100644 drivers/hwspinlock/sunxi_hwspinlock.c

-- 
2.29.2

