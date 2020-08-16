Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D477A24577F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Aug 2020 14:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbgHPMBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Aug 2020 08:01:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:52396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726308AbgHPMAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 08:00:13 -0400
Received: from localhost.localdomain (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD9D1207D3;
        Sun, 16 Aug 2020 12:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597579203;
        bh=CXcNyaPtavfj7aGTBkfdqdo9bINGV1Mzg2Iw/8pbozY=;
        h=From:To:Cc:Subject:Date:From;
        b=oYBQms5G+ACe346GACm1SD4S49w7jSNQPi0x7irHu6s97Uqxj8yV+8bgPJyw0wMmM
         x7VbuvLuaAfh7QoVOwxKeHoszMwTuK6OSaZzarT11F3ee95LqOu9bliy9ZDnRq3eIU
         uHlV251FUBhbUhAqRRUmUUf4bXOTkq7TnrMJBgP0=
From:   Vinod Koul <vkoul@kernel.org>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] usb: renesas-xhci: add missing versions
Date:   Sun, 16 Aug 2020 17:29:50 +0530
Message-Id: <20200816115950.400594-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some devices in wild are reporting firmware version as 0x2011 and
0x2020, so add these as well

Reported by: Anastasios Vacharakis <vacharakis@gmail.com>
Reported by: Glen Journeay <journeay@gmail.com>
Fixes: 2478be82de44 ("usb: renesas-xhci: Add ROM loader for uPD720201")
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=208911
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
Greg, this fixes regression for folks with preprogrammed controllers with
firmware version 0x2020 and 0x2011, please mark as stable material

 drivers/usb/host/xhci-pci-renesas.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci-pci-renesas.c b/drivers/usb/host/xhci-pci-renesas.c
index 59b1965ad0a3..f32b5a958ace 100644
--- a/drivers/usb/host/xhci-pci-renesas.c
+++ b/drivers/usb/host/xhci-pci-renesas.c
@@ -50,14 +50,19 @@
 #define RENESAS_RETRY	10000
 #define RENESAS_DELAY	10
 
-#define ROM_VALID_01 0x2013
-#define ROM_VALID_02 0x2026
+/* keep the ids sorted */
+#define ROM_VALID_01 0x2011
+#define ROM_VALID_02 0x2013
+#define ROM_VALID_03 0x2020
+#define ROM_VALID_04 0x2026
 
 static int renesas_verify_fw_version(struct pci_dev *pdev, u32 version)
 {
 	switch (version) {
 	case ROM_VALID_01:
 	case ROM_VALID_02:
+	case ROM_VALID_03:
+	case ROM_VALID_04:
 		return 0;
 	}
 	dev_err(&pdev->dev, "FW has invalid version :%d\n", version);
-- 
2.26.2

