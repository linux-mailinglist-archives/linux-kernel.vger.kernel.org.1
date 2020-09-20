Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38A882714FB
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 16:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbgITOUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 10:20:48 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57238 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgITOUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 10:20:48 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kK0Cs-0007OB-Eu; Sun, 20 Sep 2020 14:20:46 +0000
From:   Colin King <colin.king@canonical.com>
To:     John Stultz <john.stultz@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] misc: hisi_hikey_usb: clean up indentation issue
Date:   Sun, 20 Sep 2020 15:20:46 +0100
Message-Id: <20200920142046.33123-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a return statement that is indented too deeply,
fix this by removing the extraneous tab.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/misc/hisi_hikey_usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/hisi_hikey_usb.c b/drivers/misc/hisi_hikey_usb.c
index 5759e7209023..cc93569e601c 100644
--- a/drivers/misc/hisi_hikey_usb.c
+++ b/drivers/misc/hisi_hikey_usb.c
@@ -162,7 +162,7 @@ static int hisi_hikey_usb_parse_kirin970(struct platform_device *pdev,
 		dev_err(&pdev->dev,
 			"get hub-vdd-supply failed with error %ld\n",
 			PTR_ERR(regulator));
-			return PTR_ERR(regulator);
+		return PTR_ERR(regulator);
 	}
 	hisi_hikey_usb->regulator = regulator;
 
-- 
2.27.0

