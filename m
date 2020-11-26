Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6A32C5DF9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 23:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388241AbgKZWqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 17:46:06 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:57539 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730967AbgKZWqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 17:46:06 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kiQ1b-0006f8-62; Thu, 26 Nov 2020 22:46:03 +0000
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: most: Fix spelling mistake "tranceiver" -> "transceiver"
Date:   Thu, 26 Nov 2020 22:46:02 +0000
Message-Id: <20201126224602.13878-1-colin.king@canonical.com>
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
 drivers/staging/most/i2c/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/most/i2c/Kconfig b/drivers/staging/most/i2c/Kconfig
index 19a094b5bee0..ff64283cbad1 100644
--- a/drivers/staging/most/i2c/Kconfig
+++ b/drivers/staging/most/i2c/Kconfig
@@ -7,7 +7,7 @@ config MOST_I2C
 	tristate "I2C"
 	depends on I2C
 	help
-	  Say Y here if you want to connect via I2C to network tranceiver.
+	  Say Y here if you want to connect via I2C to network transceiver.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called most_i2c.
-- 
2.29.2

