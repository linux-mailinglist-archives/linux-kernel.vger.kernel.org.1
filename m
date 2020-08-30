Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E51C256F65
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Aug 2020 18:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbgH3Qj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Aug 2020 12:39:28 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:42195 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726505AbgH3QjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 12:39:07 -0400
Received: from [78.134.86.56] (port=34202 helo=melee.dev.aim)
        by hostingweb31.netsons.net with esmtpa (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1kCQMB-000E3G-O1; Sun, 30 Aug 2020 18:39:03 +0200
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-fpga@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>,
        Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anatolij Gustschin <agust@denx.de>
Subject: [PATCH v4 1/5] fpga manager: xilinx-spi: remove stray comment
Date:   Sun, 30 Aug 2020 18:38:46 +0200
Message-Id: <20200830163850.8380-1-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.28.0
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

Remove comment committed by mistake.

Fixes: dd2784c01d93 ("fpga manager: xilinx-spi: check INIT_B pin during write_init")
Reviewed-by: Tom Rix <trix@redhat.com>
Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>

---

Changes in v4:
 - add Reviewed-by Tom Rix

Changes in v3: none.

Changes in v2: none.
---
 drivers/fpga/xilinx-spi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/fpga/xilinx-spi.c b/drivers/fpga/xilinx-spi.c
index 2967aa2a74e2..502fae0d1d85 100644
--- a/drivers/fpga/xilinx-spi.c
+++ b/drivers/fpga/xilinx-spi.c
@@ -57,7 +57,6 @@ static int wait_for_init_b(struct fpga_manager *mgr, int value,
 
 	if (conf->init_b) {
 		while (time_before(jiffies, timeout)) {
-			/* dump_state(conf, "wait for init_d .."); */
 			if (gpiod_get_value(conf->init_b) == value)
 				return 0;
 			usleep_range(100, 400);
-- 
2.28.0

