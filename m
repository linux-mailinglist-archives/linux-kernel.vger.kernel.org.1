Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 875C019C180
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 14:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388441AbgDBMzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Apr 2020 08:55:22 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:10111 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388245AbgDBMzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 08:55:22 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48tNMW3Fznz9j;
        Thu,  2 Apr 2020 14:55:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1585832120; bh=5jAf1VoZWn9lMFIQz+fgkF64ICr0x3eCyKsy0w4hzhs=;
        h=Date:From:Subject:To:Cc:From;
        b=hM597ZbWrUkB5NfDrSE4QYZZRFZyrkL9NvMxmEAHsl8k1depplbDCoG/NQayKrES6
         AyOFKWPPDOi+qIltEkSZpfMLjGEnNrfCvulMKrFi9UYhvaxnl1A0om0gMYHiDaKx8h
         xDPQGOjLQsvOQWqh7h4ArqWBY4F6T9vq+pJBuROa0pghShtM5X/yo1Z3w56SfqXo24
         QyNMeqkRUe92S0g1CAIQhMeTr+Iaf8mZko56mYb2O1x2r/yXeudqFe1X+n7dNLY/4s
         +NOwcNBnMut9wu0ZA0nbc39lMsY/hHpi/Tei5EYZ8jfo6iiegvSqBjm9TXtvwGxth+
         zmKgwMQUX4cIQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Thu, 02 Apr 2020 14:55:18 +0200
Message-Id: <d01cfc2df21f016ef6c790e1ed8f3ed933cf5ad3.1585831987.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 1/2] bluetooth: hci_bcm: respect IRQ polarity from DT
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Guillaume La Roque <glaroque@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Frederic Danis <frederic.danis@linux.intel.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IRQ polarity is be configured in bcm_setup_sleep(). Make the
configured value match what is in the DeviceTree.

Cc: stable@vger.kernel.org
Fixes: f25a96c8eb46 ("Bluetooth: hci_bcm: enable IRQ capability from devicetree")
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/bluetooth/hci_bcm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index b236cb11c0dc..36b7f0d00c4b 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -1153,7 +1153,8 @@ static int bcm_of_probe(struct bcm_device *bdev)
 	device_property_read_u8_array(bdev->dev, "brcm,bt-pcm-int-params",
 				      bdev->pcm_int_params, 5);
 	bdev->irq = of_irq_get_byname(bdev->dev->of_node, "host-wakeup");
-
+	bdev->irq_active_low = irq_get_trigger_type(bdev->irq)
+			     & (IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_LEVEL_LOW);
 	return 0;
 }
 
-- 
2.20.1

