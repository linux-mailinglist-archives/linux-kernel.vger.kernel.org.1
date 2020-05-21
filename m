Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6A651DCE94
	for <lists+linux-kernel@lfdr.de>; Thu, 21 May 2020 15:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbgEUNul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 May 2020 09:50:41 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50074 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728060AbgEUNul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 09:50:41 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jblao-0006b4-Gr; Thu, 21 May 2020 13:50:38 +0000
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: fbtft: fb_st7789v: make HSD20_IPS numeric and not a string
Date:   Thu, 21 May 2020 14:50:38 +0100
Message-Id: <20200521135038.345878-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently HSD20_IPS is defined as "true" and will always result in a
non-zero result even if it is defined as "false" because it is an array
and that will never be zero. Fix this by defining it as an integer 1
rather than a literal string.

Addessses-Coverity: ("Array compared against 0")
Fixes: f03c9b788472 ("staging: fbtft: fb_st7789v: Initialize the Display")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/fbtft/fb_st7789v.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fb_st7789v.c b/drivers/staging/fbtft/fb_st7789v.c
index ebc17e05ecd0..3a280cc1892c 100644
--- a/drivers/staging/fbtft/fb_st7789v.c
+++ b/drivers/staging/fbtft/fb_st7789v.c
@@ -24,7 +24,7 @@
 	"D0 05 0A 09 08 05 2E 44 45 0F 17 16 2B 33\n" \
 	"D0 05 0A 09 08 05 2E 43 45 0F 16 16 2B 33"
 
-#define HSD20_IPS "true"
+#define HSD20_IPS 1
 
 /**
  * enum st7789v_command - ST7789V display controller commands
-- 
2.25.1

