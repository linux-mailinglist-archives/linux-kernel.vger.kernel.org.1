Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9711E2188F3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 15:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbgGHN2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 09:28:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:35448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728364AbgGHN2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 09:28:23 -0400
Received: from localhost.localdomain (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6389020720;
        Wed,  8 Jul 2020 13:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594214903;
        bh=Zm0vRkPmY6u6bWWPYkdhNztB3K3KOvBWgJDEqO2XRCs=;
        h=From:To:Cc:Subject:Date:From;
        b=az5MX7zhlDJIwX4qRC+EMo6PEBnkslm3H97CY/p5t2TTyaF2b01HXNcehY/6owB/h
         +hXJphvV9p6XmxrO4SjMggJeCKyXOjW8Jh1+dC4ARA1YPyMh94Js89BYZW7vUp8rUN
         l7ve2VHWrU4CUk3GmePyIDs5GsNgVgxUt5u/urbY=
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Igal Liberman <igall@marvell.com>
Subject: [PATCH 1/6] phy-mvebu-a3700-utmi: correct typo in struct mvebu_a3700_utmi comments
Date:   Wed,  8 Jul 2020 18:58:04 +0530
Message-Id: <20200708132809.265967-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We get warning with W=1 build:
drivers/phy/marvell/phy-mvebu-a3700-utmi.c:84: warning: Function
parameter or member 'usb_misc' not described in 'mvebu_a3700_utmi'

Fix that by correcting the typo usb_mis

Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Igal Liberman <igall@marvell.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/phy/marvell/phy-mvebu-a3700-utmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/marvell/phy-mvebu-a3700-utmi.c b/drivers/phy/marvell/phy-mvebu-a3700-utmi.c
index 23bc3bf5c4c0..8834436bc9db 100644
--- a/drivers/phy/marvell/phy-mvebu-a3700-utmi.c
+++ b/drivers/phy/marvell/phy-mvebu-a3700-utmi.c
@@ -72,7 +72,7 @@ struct mvebu_a3700_utmi_caps {
  * struct mvebu_a3700_utmi - PHY driver data
  *
  * @regs: PHY registers
- * @usb_mis: Regmap with USB miscellaneous registers including PHY ones
+ * @usb_misc: Regmap with USB miscellaneous registers including PHY ones
  * @caps: PHY capabilities
  * @phy: PHY handle
  */
-- 
2.26.2

