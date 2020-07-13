Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1F002188F5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 15:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbgGHN2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 09:28:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:35562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728210AbgGHN2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 09:28:30 -0400
Received: from localhost.localdomain (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE5DE20774;
        Wed,  8 Jul 2020 13:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594214910;
        bh=Asm/7hdVVy9foo9+ooUHC1IjpqNSr3EIkQe1fuY60FU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oxPX3v6ZTeE3iLG/SYYSfJChh1qDtTNTeY/al5tudYDK5Dwg/F/BMmCkbBcfHEKkL
         chdfcSJeAZgWPgERJ0sRZB1wW9OTdfd5CWiyHffTviIdrP2096e/oXLVErS5zYuE5R
         J0d79h6+E6inH3ST6YEvvkXqww7NdvgrAti8c/rs=
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Chris Zhong <zyw@rock-chips.com>
Subject: [PATCH 4/6] phy: rockchip-typec: use correct format for structure description
Date:   Wed,  8 Jul 2020 18:58:07 +0530
Message-Id: <20200708132809.265967-4-vkoul@kernel.org>
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
drivers/phy/rockchip/phy-rockchip-typec.c:360: warning: cannot
understand function prototype: 'struct rockchip_usb3phy_port_cfg '

The 'struct rockchip_usb3phy_port_cfg ' is commented properly but uses
wrong format, so fix that up

Cc: Chris Zhong <zyw@rock-chips.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/phy/rockchip/phy-rockchip-typec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-typec.c b/drivers/phy/rockchip/phy-rockchip-typec.c
index 24563160197f..70a31251b202 100644
--- a/drivers/phy/rockchip/phy-rockchip-typec.c
+++ b/drivers/phy/rockchip/phy-rockchip-typec.c
@@ -347,7 +347,7 @@ struct usb3phy_reg {
 };
 
 /**
- * struct rockchip_usb3phy_port_cfg: usb3-phy port configuration.
+ * struct rockchip_usb3phy_port_cfg - usb3-phy port configuration.
  * @reg: the base address for usb3-phy config.
  * @typec_conn_dir: the register of type-c connector direction.
  * @usb3tousb2_en: the register of type-c force usb2 to usb2 enable.
-- 
2.26.2

