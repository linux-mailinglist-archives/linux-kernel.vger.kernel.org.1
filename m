Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17E8E247A89
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 00:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730111AbgHQWhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 18:37:18 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45496 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729191AbgHQWhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 18:37:15 -0400
Received: from [82.43.126.140] (helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1k7nkf-0008NN-Oo; Mon, 17 Aug 2020 22:37:13 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mailbox: remove duplicate "the the" phrase in Kconfig text
Date:   Mon, 17 Aug 2020 23:37:13 +0100
Message-Id: <20200817223713.5659-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The Kconfig help text contains the phrase "the the" in the help
text. Fix this and reformat a couple of lines.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/mailbox/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 05b1009e2820..581ad9154a4a 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -47,9 +47,9 @@ config ARMADA_37XX_RWTM_MBOX
 	depends on ARCH_MVEBU || COMPILE_TEST
 	depends on OF
 	help
-	  Mailbox implementation for communication with the the firmware
-	  running on the Cortex-M3 rWTM secure processor of the Armada 37xx
-	  SOC. Say Y here if you are building for such a device (for example
+	  Mailbox implementation for communication with the firmware running
+	  on the Cortex-M3 rWTM secure processor of the Armada 37xx SOC.
+	  Say Y here if you are building for such a device (for example
 	  the Turris Mox router).
 
 config OMAP2PLUS_MBOX
-- 
2.27.0

