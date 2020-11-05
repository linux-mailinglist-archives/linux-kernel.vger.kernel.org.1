Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB33F2A7D81
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 12:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730392AbgKELud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 06:50:33 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:56977 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729916AbgKELu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 06:50:27 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kadmV-0005FE-8t; Thu, 05 Nov 2020 11:50:19 +0000
From:   Colin King <colin.king@canonical.com>
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] hwmon: corsair-psu: fix unintentional sign extension issue
Date:   Thu,  5 Nov 2020 11:50:19 +0000
Message-Id: <20201105115019.41735-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The shifting of the u8 integer data[3] by 24 bits to the left will
be promoted to a 32 bit signed int and then sign-extended to a
long. In the event that the top bit of data[3] is set then all
then all the upper 32 bits of a 64 bit long end up as also being
set because of the sign-extension. Fix this by casting data[3] to
a long before the shift.

Addresses-Coverity: ("Unintended sign extension")
Fixes: ce15cd2cee8b ("hwmon: add Corsair PSU HID controller driver")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/hwmon/corsair-psu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/corsair-psu.c b/drivers/hwmon/corsair-psu.c
index e92d0376e7ac..5d19a888231a 100644
--- a/drivers/hwmon/corsair-psu.c
+++ b/drivers/hwmon/corsair-psu.c
@@ -241,7 +241,7 @@ static int corsairpsu_get_value(struct corsairpsu_data *priv, u8 cmd, u8 rail, l
 	 * the LINEAR11 conversion are the watts values which are about 1200 for the strongest psu
 	 * supported (HX1200i)
 	 */
-	tmp = (data[3] << 24) + (data[2] << 16) + (data[1] << 8) + data[0];
+	tmp = ((long)data[3] << 24) + (data[2] << 16) + (data[1] << 8) + data[0];
 	switch (cmd) {
 	case PSU_CMD_IN_VOLTS:
 	case PSU_CMD_IN_AMPS:
-- 
2.27.0

