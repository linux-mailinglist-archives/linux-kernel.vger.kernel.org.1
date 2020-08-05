Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBF9223C8A8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Aug 2020 11:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbgHEJGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Aug 2020 05:06:55 -0400
Received: from mail.ispras.ru ([83.149.199.84]:48086 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbgHEJGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 05:06:54 -0400
Received: from hellwig.intra.ispras.ru (unknown [10.10.2.182])
        by mail.ispras.ru (Postfix) with ESMTPS id 46FEB40A204E;
        Wed,  5 Aug 2020 09:06:52 +0000 (UTC)
From:   Evgeny Novikov <novikov@ispras.ru>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Evgeny Novikov <novikov@ispras.ru>,
        linux-usb@vger.kernel.org (open list:USB SUBSYSTEM),
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: [PATCH] USB: lvtest: return proper error code in probe
Date:   Wed,  5 Aug 2020 12:06:43 +0300
Message-Id: <20200805090643.3432-1-novikov@ispras.ru>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lvs_rh_probe() can return some nonnegative value from usb_control_msg()
when it is less than "USB_DT_HUB_NONVAR_SIZE + 2" that is considered as
a failure. Make lvs_rh_probe() return -EINVAL in this case.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Evgeny Novikov <novikov@ispras.ru>
---
 drivers/usb/misc/lvstest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/misc/lvstest.c b/drivers/usb/misc/lvstest.c
index 407fe7570f3b..f8686139d6f3 100644
--- a/drivers/usb/misc/lvstest.c
+++ b/drivers/usb/misc/lvstest.c
@@ -426,7 +426,7 @@ static int lvs_rh_probe(struct usb_interface *intf,
 			USB_DT_SS_HUB_SIZE, USB_CTRL_GET_TIMEOUT);
 	if (ret < (USB_DT_HUB_NONVAR_SIZE + 2)) {
 		dev_err(&hdev->dev, "wrong root hub descriptor read %d\n", ret);
-		return ret;
+		return ret < 0 ? ret : -EINVAL;
 	}
 
 	/* submit urb to poll interrupt endpoint */
-- 
2.26.2

