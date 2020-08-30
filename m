Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F206256F64
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Aug 2020 18:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbgH3QjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Aug 2020 12:39:18 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:44611 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726508AbgH3QjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 12:39:07 -0400
Received: from [78.134.86.56] (port=34202 helo=melee.dev.aim)
        by hostingweb31.netsons.net with esmtpa (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1kCQMD-000E3G-0X; Sun, 30 Aug 2020 18:39:05 +0200
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-fpga@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>,
        Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anatolij Gustschin <agust@denx.de>
Subject: [PATCH v4 5/5] fpga manager: xilinx-spi: provide better diagnostics on programming failure
Date:   Sun, 30 Aug 2020 18:38:50 +0200
Message-Id: <20200830163850.8380-5-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200830163850.8380-1-luca@lucaceresoli.net>
References: <20200830163850.8380-1-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the DONE pin does not go high after programming to confirm programming
success, the INIT_B pin provides some info on the reason. Use it if
available to provide a more explanatory error message.

Reviewed-by: Tom Rix <trix@redhat.com>
Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>

---

Changes in v4:
 - add Reviewed-by Tom Rix

Changes in v3: none.

Changes in v2:
 - also check for gpiod_get_value() errors (Tom Rix)
---
 drivers/fpga/xilinx-spi.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/xilinx-spi.c b/drivers/fpga/xilinx-spi.c
index 52aab5a1f0ba..824abbbd631e 100644
--- a/drivers/fpga/xilinx-spi.c
+++ b/drivers/fpga/xilinx-spi.c
@@ -195,7 +195,21 @@ static int xilinx_spi_write_complete(struct fpga_manager *mgr,
 			return 0;
 	}
 
-	dev_err(&mgr->dev, "Timeout after config data transfer\n");
+	if (conf->init_b) {
+		ret = gpiod_get_value(conf->init_b);
+
+		if (ret < 0) {
+			dev_err(&mgr->dev, "Error reading INIT_B (%d)\n", ret);
+			return ret;
+		}
+
+		dev_err(&mgr->dev,
+			ret ? "CRC error or invalid device\n"
+			: "Missing sync word or incomplete bitstream\n");
+	} else {
+		dev_err(&mgr->dev, "Timeout after config data transfer\n");
+	}
+
 	return -ETIMEDOUT;
 }
 
-- 
2.28.0

