Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6ECA2DAD9E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 14:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbgLONBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 08:01:21 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:33524 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728385AbgLONA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 08:00:58 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kp9w8-0006Nq-Qr; Tue, 15 Dec 2020 13:00:16 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mailbox: fix spelling mistake in Kconfig "Intergrated" -> "Integrated"
Date:   Tue, 15 Dec 2020 13:00:16 +0000
Message-Id: <20201215130016.200851-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in the Kconfig, fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/mailbox/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index f4abe3529acd..68de2c6af727 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -78,7 +78,7 @@ config OMAP_MBOX_KFIFO_SIZE
 	  module parameter).
 
 config ROCKCHIP_MBOX
-	bool "Rockchip Soc Intergrated Mailbox Support"
+	bool "Rockchip Soc Integrated Mailbox Support"
 	depends on ARCH_ROCKCHIP || COMPILE_TEST
 	help
 	  This driver provides support for inter-processor communication
-- 
2.29.2

