Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE9D215830
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jul 2020 15:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729228AbgGFNUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jul 2020 09:20:22 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56324 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729072AbgGFNUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 09:20:21 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jsR2f-0007tU-Ll; Mon, 06 Jul 2020 13:20:17 +0000
From:   Colin King <colin.king@canonical.com>
To:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] staging: wfx: fix uninitialized variable bytes_done
Date:   Mon,  6 Jul 2020 14:20:17 +0100
Message-Id: <20200706132017.487627-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable bytes_done is not initialized and hence the first
FIFO size check on bytes_done may be breaking prematurely from
the loop if bytes_done contains a large bogus uninitialized value.
Fix this by initializing bytes_done to zero.

Addresses-Coverity: ("Uninitialized scalar variable")
Fixes: a9408ad79ff3 ("staging: wfx: load the firmware faster")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/wfx/fwio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/wfx/fwio.c b/drivers/staging/wfx/fwio.c
index d9a886f3e64b..206c6cf6511c 100644
--- a/drivers/staging/wfx/fwio.c
+++ b/drivers/staging/wfx/fwio.c
@@ -177,7 +177,7 @@ static int wait_ncp_status(struct wfx_dev *wdev, u32 status)
 static int upload_firmware(struct wfx_dev *wdev, const u8 *data, size_t len)
 {
 	int ret;
-	u32 offs, bytes_done;
+	u32 offs, bytes_done = 0;
 	ktime_t now, start;
 
 	if (len % DNLD_BLOCK_SIZE) {
-- 
2.27.0

