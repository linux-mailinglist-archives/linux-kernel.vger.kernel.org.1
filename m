Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBE92DD5E4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 18:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729038AbgLQRRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 12:17:49 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:60435 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727260AbgLQRRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 12:17:49 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kpwtm-0000A1-3d; Thu, 17 Dec 2020 17:17:06 +0000
From:   Colin King <colin.king@canonical.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] timekeeping: Fix spelling mistake in Kconfig "fullfill" -> "fulfill"
Date:   Thu, 17 Dec 2020 17:17:05 +0000
Message-Id: <20201217171705.57586-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in the Kconfig help text. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 kernel/time/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
index 9a41848b6ebb..83e158d016ba 100644
--- a/kernel/time/Kconfig
+++ b/kernel/time/Kconfig
@@ -141,7 +141,7 @@ config CONTEXT_TRACKING_FORCE
 	  dynticks working.
 
 	  This option stands for testing when an arch implements the
-	  context tracking backend but doesn't yet fullfill all the
+	  context tracking backend but doesn't yet fulfill all the
 	  requirements to make the full dynticks feature working.
 	  Without the full dynticks, there is no way to test the support
 	  for context tracking and the subsystems that rely on it: RCU
-- 
2.29.2

