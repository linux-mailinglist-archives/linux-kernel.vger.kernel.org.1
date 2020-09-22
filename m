Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51EB2274A8F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 23:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgIVVEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 17:04:44 -0400
Received: from o1.b.az.sendgrid.net ([208.117.55.133]:64697 "EHLO
        o1.b.az.sendgrid.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgIVVEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 17:04:44 -0400
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Sep 2020 17:04:43 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
        h=from:subject:in-reply-to:references:to:cc:content-type:
        content-transfer-encoding;
        s=001; bh=RXpY8dpHwOG6DTXBuKGsQgIxGYTQmxgNdlG63ogXV34=;
        b=IGNLfkgfCClJtOSq7gH91CU2+3kDdVJ2Vhvr3KF66NcQQQ5UZG4NEFGwyXWarzHW2SdG
        okToDwk1r377iCAcKRPhlnbWZoOuZ9wcW2YiyqmiTz7Nom8+BRk5aSBJJQEdE2P8fYnwfE
        H0jvqMhM2iG5VuJt/Emin8uxBaN+PXqHY=
Received: by filterdrecv-p3las1-6f66587546-d82vt with SMTP id filterdrecv-p3las1-6f66587546-d82vt-19-5F6A65BB-4E
        2020-09-22 20:59:39.828778021 +0000 UTC m=+82856.869292196
Received: from bionic.localdomain (unknown)
        by ismtpd0007p1lon1.sendgrid.net (SG) with ESMTP
        id 8HP0odj2Q3iwldJChdNcsg
        Tue, 22 Sep 2020 20:59:39.176 +0000 (UTC)
From:   Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v3 0/6] Support more HDMI modes on RK3228/RK3328
Date:   Tue, 22 Sep 2020 20:59:39 +0000 (UTC)
Message-Id: <20200922205933.5540-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200108210740.28769-1-jonas@kwiboo.se>
References: <20200108210740.28769-1-jonas@kwiboo.se>
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h5Eiatl8ZaYBj6H9X?=
 =?us-ascii?Q?aXTTzxnx4oxm3pCMKRYrCNYnjUiunOTnBlfBTxV?=
 =?us-ascii?Q?JOYOWZMAQopiuHFLQnYX5NpevjkXzVjlvc7R6Q0?=
 =?us-ascii?Q?Yrzp8nYiFEMuW2Xi4S4tnMnEupGgzXa7tg6u85T?=
 =?us-ascii?Q?n323el9Hfrq4jpaAuhxGkrhZr+ka=2FAhYOX6Rg1j?=
 =?us-ascii?Q?BlVqtv8Sdu4uJ1hM=2Fl09Q=3D=3D?=
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Jonas Karlman <jonas@kwiboo.se>, Vinod Koul <vkoul@kernel.org>,
        Zheng Yang <zhengyang@rock-chips.com>,
        Algea Cao <algea.cao@rock-chips.com>,
        Huicong Xu <xhc@rock-chips.com>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a long overdue revival of an old series that prepares support for
more HDMI modes, YUV420 and 10-bit output on RK3228/RK3328.

This v3 series contains the original v2 patches targeting the inno hdmi phy
driver, a separate series targeting drm driver should follow in a few days.

Part of this has been reworked from vendor BSP 4.4 kernel commits.

Patch 1-5 fixes issues and shortcomings in the inno hdmi phy driver.

Patch 6 adds support for more pixel clock rates in order to support
common DMT modes in addition to CEA modes.

Changes in v3:
  - split series
  - drop drm and device tree changes

Changes in v2:
  - collect acked-by tag
  - drop the limit resolution width to 3840 patch

This series is also available at [1].

[1] https://github.com/Kwiboo/linux-rockchip/commits/next-20200922-inno-hdmi-phy

Regards,
Jonas

Algea Cao (1):
  phy/rockchip: inno-hdmi: Support more pre-pll configuration

Huicong Xu (1):
  phy/rockchip: inno-hdmi: force set_rate on power_on

Jonas Karlman (3):
  phy/rockchip: inno-hdmi: use correct vco_div_5 macro on rk3328
  phy/rockchip: inno-hdmi: remove unused no_c from rk3328 recalc_rate
  phy/rockchip: inno-hdmi: do not power on rk3328 post pll on reg write

Zheng Yang (1):
  phy/rockchip: inno-hdmi: round fractal pixclock in rk3328 recalc_rate

 drivers/phy/rockchip/phy-rockchip-inno-hdmi.c | 110 ++++++++++++------
 1 file changed, 74 insertions(+), 36 deletions(-)

-- 
2.17.1

