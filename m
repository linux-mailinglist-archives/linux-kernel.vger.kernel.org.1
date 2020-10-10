Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1B0328A1ED
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 00:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387459AbgJJWrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 18:47:51 -0400
Received: from o1.b.az.sendgrid.net ([208.117.55.133]:2796 "EHLO
        o1.b.az.sendgrid.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731237AbgJJTFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 15:05:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
        h=from:subject:in-reply-to:references:to:cc:content-type:
        content-transfer-encoding;
        s=001; bh=wESJQvpdfDsvdWan8Taf/CIlNvse8X0Jhu+UUVMx4i4=;
        b=oXyDx2YvexeMHXYOvbXPDaqn7APjYxMiKb/+bt1EPMIeinaG1tI43qsAINzdwXP0TvRC
        TGAxfps8nxUEaisW46e/HLaZ4r2Dm/K2ehKlcx1Rk1qerfHXpXvjmhk6i0zgLk1fV1usnQ
        xUEDUvaVFvvVXJrYub/A1a83Rdq79lztg=
Received: by filterdrecv-p3mdw1-6685f47d68-9kn8s with SMTP id filterdrecv-p3mdw1-6685f47d68-9kn8s-18-5F81D401-55
        2020-10-10 15:32:17.741501173 +0000 UTC m=+233773.767440829
Received: from bionic.localdomain (unknown)
        by ismtpd0005p1lon1.sendgrid.net (SG) with ESMTP
        id vof286gPTU2LuS_fpzD_jA
        Sat, 10 Oct 2020 15:32:17.455 +0000 (UTC)
From:   Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v3 0/6] Support more HDMI modes on RK3228/RK3328
Date:   Sat, 10 Oct 2020 15:32:17 +0000 (UTC)
Message-Id: <20201010153214.19722-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200108210740.28769-1-jonas@kwiboo.se>
References: <20200108210740.28769-1-jonas@kwiboo.se>
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h4CO0Scf6vcnfmbTz?=
 =?us-ascii?Q?4mZdRxcxfQtbnNCh2SLgMT0C=2FS7YcNADP=2FsQMH8?=
 =?us-ascii?Q?oK9pQPq1ftJEnG1hGSopqK8EFAKG0s5Nqb=2FW583?=
 =?us-ascii?Q?aEt4CUdbpksi1MqtWBOuRNnyQIL0JPCtiVFBBOI?=
 =?us-ascii?Q?SDyThqTz8VE9sfu62vHWaZBObXTLt3m+fmCQ7uj?=
 =?us-ascii?Q?2s88LD9LUKly1le9rY4nQ=3D=3D?=
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Jonas Karlman <jonas@kwiboo.se>, Vinod Koul <vkoul@kernel.org>,
        Zheng Yang <zhengyang@rock-chips.com>,
        Algea Cao <algea.cao@rock-chips.com>,
        Huicong Xu <xhc@rock-chips.com>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Entity-ID: wSPGWgGSXUap++qShBI+ag==
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a long overdue revival of an old series that adds support for
more HDMI modes on RK3228/RK3328.

This v3 series contains the original v2 patches targeting the inno hdmi phy
driver, a separate series targeting drm driver will follow, see [2] for
current work-in-progress of drm driver part.

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

[1] https://github.com/Kwiboo/linux-rockchip/commits/next-20201009-inno-hdmi-phy
[2] https://github.com/Kwiboo/linux-rockchip/commits/next-20201009-drm-rockchip

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

