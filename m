Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3043245CCE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 09:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgHQHBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 03:01:49 -0400
Received: from ms-10.1blu.de ([178.254.4.101]:40302 "EHLO ms-10.1blu.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726613AbgHQHAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 03:00:47 -0400
Received: from [78.43.71.214] (helo=marius.fritz.box)
        by ms-10.1blu.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <mail@mariuszachmann.de>)
        id 1k7Z8N-00009O-MZ; Mon, 17 Aug 2020 09:00:43 +0200
From:   Marius Zachmann <mail@mariuszachmann.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Marius Zachmann <mail@mariuszachmann.de>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] hwmon: corsair-cpro: fix ccp_probe, add delay
Date:   Mon, 17 Aug 2020 09:00:40 +0200
Message-Id: <20200817070040.7952-1-mail@mariuszachmann.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Con-Id: 241080
X-Con-U: 0-mail
X-Originating-IP: 78.43.71.214
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Possibly because of the changes in usbhid/hid-core.c the first
raw input report is not received during ccp_probe function and it will
timeout. I am not sure, whether this behaviour is expected after
hid_device_io_start or if I am missing something.
As a solution this adds msleep(50) to ccp_probe so that all initial
input reports can be received.

Signed-off-by: Marius Zachmann <mail@mariuszachmann.de>
---
v2:
- fix accidentally deleted comment

---
 drivers/hwmon/corsair-cpro.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwmon/corsair-cpro.c b/drivers/hwmon/corsair-cpro.c
index 591929ec217a..c04fac1d820f 100644
--- a/drivers/hwmon/corsair-cpro.c
+++ b/drivers/hwmon/corsair-cpro.c
@@ -10,6 +10,7 @@

 #include <linux/bitops.h>
 #include <linux/completion.h>
+#include <linux/delay.h>
 #include <linux/hid.h>
 #include <linux/hwmon.h>
 #include <linux/kernel.h>
@@ -513,6 +514,7 @@ static int ccp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	init_completion(&ccp->wait_input_report);

 	hid_device_io_start(hdev);
+	msleep(50); /* wait before events can be received */

 	/* temp and fan connection status only updates when device is powered on */
 	ret = get_temp_cnct(ccp);
--
2.28.0
