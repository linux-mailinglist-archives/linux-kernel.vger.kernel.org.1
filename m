Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1944C2B7ADF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 11:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgKRKB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 05:01:28 -0500
Received: from mout01.posteo.de ([185.67.36.65]:34294 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbgKRKB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 05:01:28 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 16840160065
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 11:01:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1605693685; bh=v8UAjGpio2L3U6uefLm3bgiYOb0YO6gUIAJEPaPwEk0=;
        h=Date:From:To:Cc:Subject:From;
        b=JkOgY0UZInV7o8/9YXe076aOBo6gK8Hg3WZgBnK3BXcoclbbkbVO8Du06Nx8bnNTv
         fFh2NNijb0UZswbWbshHtAwou/dpdjkUi/q6dunSXP3PEufXPZb/DEMwr9vtGATDZ5
         +y7DtrcuwD4kj8RPpzd18A2zEVZA9aftchu6REshq2jrudlme9pBhqiKX/E55YWsrx
         s85DrIYqh5FYhVNjFq5zLp4dz4D+ss96FO9MchA5E8wx0ipg1XzFg6rTjc7g5Mc/oV
         IOD9nozHJNW2RztQhpO22MkOURB+teFH5D0+xWT0EwqafaZheHL1lZL0V9tucE5RXm
         WaR0R4fC8MSrg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Cbdcf5pbKz6tm5;
        Wed, 18 Nov 2020 11:01:22 +0100 (CET)
Date:   Wed, 18 Nov 2020 11:01:21 +0100
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: [PATCH 0/2] hwspinlock: add sunxi hardware spinlock support
Message-ID: <cover.1605693132.git.wilken.gottwalt@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the Allwinner SoCs contain a spinlock unit which can be used for
synchronization/locking between different subsystems. According to the
several Allwinner datasheets most of the sun8i and sun50i SoCs share the
same hardware with at least 32 (32bit wide) registers for 32 spinlocks.
The implemented spinlock hardware can support 32, 64, 128 or 256
registers.

This driver supports all four register bank sizes and also provides some
additional information via debugfs. The driver can be build by setting
the HWSPINLOCK_SUNXI symbol and can be also compiled as module.

This patch adds the driver for this hardware and updates the hwlock
documentation on how to use it. According to the datasheets the H2+, H3,
H5 and H6 SoCs share exactly the same spinlock hardware. But I'm pretty
sure that the whole sun8i family has the same hardware. The sun50i family
may be a different story. The H616 is missing the whole spinlock part in
the datasheets, so I assume this is a sun50i part that does not support
hwspinlocks.

The driver itself is not yet enabled in the devicetree files of the H2/H3,
H5 and H6 SoCs, because for now I'm only able to test the driver against
a H2+ device (OrangePi Zero).

This patch adds:
- hwspinlock driver sunxi_hwspinlock
- hwspinlock dt bindings documentation
- updates MAINTAINERS

Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>

Wilken Gottwalt (2):
  dt-bindings: hwlock: sunxi: add sunxi_hwspinlock documentation
  hwspinlock: add sunxi hardware spinlock support

 .../bindings/hwlock/sunxi-hwspinlock.yaml     |  64 ++++
 MAINTAINERS                                   |   6 +
 drivers/hwspinlock/Kconfig                    |   9 +
 drivers/hwspinlock/Makefile                   |   1 +
 drivers/hwspinlock/sunxi_hwspinlock.c         | 282 ++++++++++++++++++
 5 files changed, 362 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwlock/sunxi-hwspinlock.yaml
 create mode 100644 drivers/hwspinlock/sunxi_hwspinlock.c

-- 
2.29.2

