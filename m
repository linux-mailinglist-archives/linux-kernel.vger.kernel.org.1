Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F51290DC4
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 00:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408483AbgJPWdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 18:33:08 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59966 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404934AbgJPWdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 18:33:08 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kTYHY-0000dH-34; Fri, 16 Oct 2020 22:33:04 +0000
From:   Colin King <colin.king@canonical.com>
To:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: wfx: make a const array static, makes object smaller
Date:   Fri, 16 Oct 2020 23:33:03 +0100
Message-Id: <20201016223303.687278-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate const array filter_ies on the stack but instead
make it static. Makes the object code smaller by 261 bytes.

Before:
   text	   data	    bss	    dec	    hex	filename
  21674	   3166	    448	  25288	   62c8	drivers/staging/wfx/sta.o

After:
   text	   data	    bss	    dec	    hex	filename
  21349	   3230	    448	  25027	   61c3	drivers/staging/wfx/sta.o

(gcc version 10.2.0)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/wfx/sta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/wfx/sta.c b/drivers/staging/wfx/sta.c
index 2320a81eae0b..196779a1b89a 100644
--- a/drivers/staging/wfx/sta.c
+++ b/drivers/staging/wfx/sta.c
@@ -63,7 +63,7 @@ void wfx_suspend_hot_dev(struct wfx_dev *wdev, enum sta_notify_cmd cmd)
 
 static void wfx_filter_beacon(struct wfx_vif *wvif, bool filter_beacon)
 {
-	const struct hif_ie_table_entry filter_ies[] = {
+	static const struct hif_ie_table_entry filter_ies[] = {
 		{
 			.ie_id        = WLAN_EID_VENDOR_SPECIFIC,
 			.has_changed  = 1,
-- 
2.27.0

