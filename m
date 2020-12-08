Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86AF82D2E76
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 16:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730125AbgLHPkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 10:40:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:44298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729334AbgLHPkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 10:40:35 -0500
From:   Oded Gabbay <ogabbay@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai
Subject: [PATCH] habanalabs/gaudi: enhance reset message
Date:   Tue,  8 Dec 2020 17:39:46 +0200
Message-Id: <20201208153947.18678-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201208153947.18678-1-ogabbay@kernel.org>
References: <20201208153947.18678-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Print the initiator who performs the hard-reset for easier debugging.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index f316b898e8e0..b0528883a995 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -3936,11 +3936,15 @@ static void gaudi_hw_fini(struct hl_device *hdev, bool hard_reset)
 
 		WREG32(mmPSOC_GLOBAL_CONF_SW_ALL_RST,
 			1 << PSOC_GLOBAL_CONF_SW_ALL_RST_IND_SHIFT);
-	}
 
-	dev_info(hdev->dev,
-		"Issued HARD reset command, going to wait %dms\n",
-		reset_timeout_ms);
+		dev_info(hdev->dev,
+			"Issued HARD reset command, going to wait %dms\n",
+			reset_timeout_ms);
+	} else {
+		dev_info(hdev->dev,
+			"Firmware performs HARD reset, going to wait %dms\n",
+			reset_timeout_ms);
+	}
 
 	/*
 	 * After hard reset, we can't poll the BTM_FSM register because the PSOC
-- 
2.17.1

