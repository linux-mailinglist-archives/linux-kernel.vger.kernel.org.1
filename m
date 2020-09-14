Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5CC8268CB1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 16:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgINOAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 10:00:06 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38280 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbgINN5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 09:57:45 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kHoyM-0001iw-KD; Mon, 14 Sep 2020 13:56:46 +0000
From:   Colin King <colin.king@canonical.com>
To:     John Stultz <john.stultz@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] misc: hisi_hikey_usb: fix return of uninitialized ret status variable
Date:   Mon, 14 Sep 2020 14:56:46 +0100
Message-Id: <20200914135646.99334-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the return value from ret is uninitialized so the function
hisi_hikey_usb_parse_kirin970 is returning a garbage value when
succeeding. Since ret is not used anywhere else in the function, remove
it and just return 0 success at the end of the function.

Addresses-Coverity: ("Uninitialixed scalar variable")
Fixes: d210a0023590 ("misc: hisi_hikey_usb: add support for Hikey 970")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/misc/hisi_hikey_usb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/misc/hisi_hikey_usb.c b/drivers/misc/hisi_hikey_usb.c
index 2ddd4072788d..5759e7209023 100644
--- a/drivers/misc/hisi_hikey_usb.c
+++ b/drivers/misc/hisi_hikey_usb.c
@@ -151,7 +151,6 @@ static int hisi_hikey_usb_parse_kirin970(struct platform_device *pdev,
 					 struct hisi_hikey_usb *hisi_hikey_usb)
 {
 	struct regulator *regulator;
-	int ret;
 
 	regulator = devm_regulator_get(&pdev->dev, "hub-vdd");
 	if (IS_ERR(regulator)) {
@@ -172,7 +171,7 @@ static int hisi_hikey_usb_parse_kirin970(struct platform_device *pdev,
 	if (IS_ERR(hisi_hikey_usb->reset))
 		return PTR_ERR(hisi_hikey_usb->reset);
 
-	return ret;
+	return 0;
 }
 
 static int hisi_hikey_usb_probe(struct platform_device *pdev)
-- 
2.27.0

