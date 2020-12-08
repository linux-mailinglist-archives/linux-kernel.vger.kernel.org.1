Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 530622D27C1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 10:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbgLHJfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 04:35:01 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:47375 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727482AbgLHJfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 04:35:00 -0500
Received: from orion.localdomain ([95.117.39.192]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MDhQt-1ktUBK0RVv-00AoTj; Tue, 08 Dec 2020 10:32:09 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     duncan.sands@free.fr, accessrunner-general@lists.sourceforge.net,
        linux-usb@vger.kernel.org
Subject: [PATCH 3/3] drivers: usb: atm: use pr_err() and pr_warn() instead of raw printk()
Date:   Tue,  8 Dec 2020 10:32:06 +0100
Message-Id: <20201208093206.24780-3-info@metux.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201208093206.24780-1-info@metux.net>
References: <20201208093206.24780-1-info@metux.net>
X-Provags-ID: V03:K1:MmyerTd2PpR2Z6zqetbr9VnuqB7jfj2Aq2+ftbj5b6kC3eQIVeu
 7d26a0rA1zLDCHdQ3SGbT88WgDRZvu8MNw8D4CNpu7T7B0LEdbP4z/dbCBXTy1fLT/gxSOv
 O3f5+OHRIJVEf4NZvbICGJA+BJmlBZ+tYbYWBxSX8BZE6DEyrQNV6xF7kEIkV0stP9uD4rt
 zzybvbZ4M8ZnlzmZjSZPg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:GAEp16o9VWk=:EfpMJ1HqMj/DZqe+yxrE/+
 6I72SeZLrLcSS0oY4uzrv452BWQiEGw7ozIebcsKaQ0Dq23ryGUEC4wSrKrogFDbkMWrXaf2f
 VeFqQlHZ3JsTMaRk9mdS26f4F6fCNNXOIt91NzvNWOJr2ftnK+mgasM4qLeVdS3vNKjL0zPdT
 V5g65FpTxJT4W9dKv51TrtmZrGIxC1+xnwsjvG+tV2sIgV7+mHXIjnUi9S6T/dGar1VeHQQs2
 n5BdpKBHADOLf5Wti2eKjka4wf6ONmAJdVSdYxyHiQUtgMv/73pbqcci9ohTeIa7pIeeSfb7r
 cztuk9qGu0Aq6+Pr1vctxKmZ41gBHk4rAOPFFkL7iREvkbPIp5d0gAopnEBJapw/lxz3WzG76
 1ycO45OeG94LrOKz2MEr5zpWD/ZTzpGmc/oA2VhSkOGaLBd5AVa92PW3YPaA5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we have the nice helpers pr_err() and pr_warn(), use them instead
of raw printk().

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/usb/atm/usbatm.c  | 2 +-
 drivers/usb/atm/xusbatm.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/atm/usbatm.c b/drivers/usb/atm/usbatm.c
index 56fe30d247da..1c90aa273a41 100644
--- a/drivers/usb/atm/usbatm.c
+++ b/drivers/usb/atm/usbatm.c
@@ -1278,7 +1278,7 @@ EXPORT_SYMBOL_GPL(usbatm_usb_disconnect);
 static int __init usbatm_usb_init(void)
 {
 	if (sizeof(struct usbatm_control) > sizeof_field(struct sk_buff, cb)) {
-		printk(KERN_ERR "%s unusable with this kernel!\n", usbatm_driver_name);
+		pr_err("%s unusable with this kernel!\n", usbatm_driver_name);
 		return -EIO;
 	}
 
diff --git a/drivers/usb/atm/xusbatm.c b/drivers/usb/atm/xusbatm.c
index ffc9810070a3..0befbf63d1cc 100644
--- a/drivers/usb/atm/xusbatm.c
+++ b/drivers/usb/atm/xusbatm.c
@@ -179,7 +179,7 @@ static int __init xusbatm_init(void)
 	    num_vendor != num_product ||
 	    num_vendor != num_rx_endpoint ||
 	    num_vendor != num_tx_endpoint) {
-		printk(KERN_WARNING "xusbatm: malformed module parameters\n");
+		pr_warn("xusbatm: malformed module parameters\n");
 		return -EINVAL;
 	}
 
-- 
2.11.0

