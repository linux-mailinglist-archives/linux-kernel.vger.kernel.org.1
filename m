Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 692112188F8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 15:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729540AbgGHN2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 09:28:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:35570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729529AbgGHN2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 09:28:33 -0400
Received: from localhost.localdomain (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 212D220786;
        Wed,  8 Jul 2020 13:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594214912;
        bh=Z8i8kZRHYSfnform4ND6CgkWhvdYpt/R9KGxNDEf+ZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EYX2l3M7NiZwn49tXB/YkeEWpNs0X4VeKRT7mgDLXDUjLc0R05y01CR2Wt5c42n+T
         4dmSU0glE5EI5z9vW+EpnEgX0zkT1D00hqEE04R0g5gw6ulpz3SCEQoon3sSYqqbsq
         rBbl3VYaA/p/rSqrz51P4viI9xn7G6w0LhN/4beM=
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 5/6] phy: exynos5-usbdrd: use correct format for structure description
Date:   Wed,  8 Jul 2020 18:58:08 +0530
Message-Id: <20200708132809.265967-5-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200708132809.265967-1-vkoul@kernel.org>
References: <20200708132809.265967-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We get warning with W=1 build:
drivers/phy/samsung/phy-exynos5-usbdrd.c:211: warning: Function
parameter or member 'phys' not described in 'exynos5_usbdrd_phy'
drivers/phy/samsung/phy-exynos5-usbdrd.c:211: warning: Function
parameter or member 'vbus' not described in 'exynos5_usbdrd_phy'
drivers/phy/samsung/phy-exynos5-usbdrd.c:211: warning: Function
parameter or member 'vbus_boost' not described in 'exynos5_usbdrd_phy'

These members are provided with description but format is not quite
right resulting in above warnings

Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/phy/samsung/phy-exynos5-usbdrd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsung/phy-exynos5-usbdrd.c
index eb06ce9f748f..bfb0e8914103 100644
--- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
+++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
@@ -180,14 +180,14 @@ struct exynos5_usbdrd_phy_drvdata {
  * @utmiclk: clock for utmi+ phy
  * @itpclk: clock for ITP generation
  * @drv_data: pointer to SoC level driver data structure
- * @phys[]: array for 'EXYNOS5_DRDPHYS_NUM' number of PHY
+ * @phys: array for 'EXYNOS5_DRDPHYS_NUM' number of PHY
  *	    instances each with its 'phy' and 'phy_cfg'.
  * @extrefclk: frequency select settings when using 'separate
  *	       reference clocks' for SS and HS operations
  * @ref_clk: reference clock to PHY block from which PHY's
  *	     operational clocks are derived
- * vbus: VBUS regulator for phy
- * vbus_boost: Boost regulator for VBUS present on few Exynos boards
+ * @vbus: VBUS regulator for phy
+ * @vbus_boost: Boost regulator for VBUS present on few Exynos boards
  */
 struct exynos5_usbdrd_phy {
 	struct device *dev;
-- 
2.26.2

