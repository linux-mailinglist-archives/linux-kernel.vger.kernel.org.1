Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E09312188F4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 15:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729490AbgGHN21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 09:28:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:35502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728364AbgGHN20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 09:28:26 -0400
Received: from localhost.localdomain (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECB152078D;
        Wed,  8 Jul 2020 13:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594214905;
        bh=tJ6fc5RcuF5jbuGKpc5fAqO8Uz1v2tADclOlEjLXGQ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FUPB+vK8kcGhAvAvkXEHM5iYkJCNE6uLPBdyRh2mB/VJzZ1u4BPzH+LVV3CaRsXGq
         npVCfMtJvdOIcyqu+ohfIu2HhdpKmvgjQ8b3rap8RTSWlksS576aR0Q5TGaoGsxCVv
         fL6L6noJQzHQmiJAdiZYPqUVjMrayRUAx8pp+5fU=
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/6] phy: mapphone-mdm6600: Add missing description for some structure fields
Date:   Wed,  8 Jul 2020 18:58:05 +0530
Message-Id: <20200708132809.265967-2-vkoul@kernel.org>
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
drivers/phy/motorola/phy-mapphone-mdm6600.c:185: warning: Function
parameter or member 'val' not described in 'phy_mdm6600_cmd'
drivers/phy/motorola/phy-mapphone-mdm6600.c:200: warning: Function
parameter or member 'work' not described in 'phy_mdm6600_status'

Fix that by adding description for 'val' and 'work'

Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/phy/motorola/phy-mapphone-mdm6600.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/motorola/phy-mapphone-mdm6600.c b/drivers/phy/motorola/phy-mapphone-mdm6600.c
index 94a34cf75eb3..5172971f4c36 100644
--- a/drivers/phy/motorola/phy-mapphone-mdm6600.c
+++ b/drivers/phy/motorola/phy-mapphone-mdm6600.c
@@ -178,6 +178,7 @@ static const struct phy_ops gpio_usb_ops = {
 /**
  * phy_mdm6600_cmd() - send a command request to mdm6600
  * @ddata: device driver data
+ * @val: value of cmd to be set
  *
  * Configures the three command request GPIOs to the specified value.
  */
@@ -194,7 +195,7 @@ static void phy_mdm6600_cmd(struct phy_mdm6600 *ddata, int val)
 
 /**
  * phy_mdm6600_status() - read mdm6600 status lines
- * @ddata: device driver data
+ * @work: work structure
  */
 static void phy_mdm6600_status(struct work_struct *work)
 {
-- 
2.26.2

