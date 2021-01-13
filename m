Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D56C82F53C1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 21:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbhAMT7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 14:59:11 -0500
Received: from smtprelay03.ispgateway.de ([80.67.18.15]:52389 "EHLO
        smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728450AbhAMT7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 14:59:10 -0500
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Jan 2021 14:59:09 EST
Received: from [84.39.76.69] (helo=thinkstation.fritz.box)
        by smtprelay03.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <vogelchr@vogel.cx>)
        id 1kzm9y-0006Vv-JA; Wed, 13 Jan 2021 20:50:26 +0100
From:   Christian Vogel <vogelchr@vogel.cx>
To:     greg@kroah.com
Cc:     zbr@ioremap.net, vogelchr@vogel.cx, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] w1/w1.c: w1 address crc quick for DS28E04 eeproms
Date:   Wed, 13 Jan 2021 20:50:17 +0100
Message-Id: <20210113195018.7498-2-vogelchr@vogel.cx>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210113195018.7498-1-vogelchr@vogel.cx>
References: <20210113195018.7498-1-vogelchr@vogel.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Df-Sender: Y2hyaXNAb21ncHduaWVzLmRl
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Onewire addresses are 64bit family(8bit), unique_id(48bit), crc(8bit)
(LSBt to MSB) and self-consistent: crc = crc8(family, unique).

DS28E04-100 4096-Bit Addressable 1-Wire EEPROM with PIO have strap pins
to set 7 LSB of the address, unfortunately without updating the crc
part of the address. It is only consistent if all strap pins float high.
[see datasheet 19-6134; Rev 12/11 page 6: 64-bit device id number]

We therefore introduce a special handling of family 0x1c (DS28E04) to
check address consistency with 7 LSBs of the unique_id set to 1.

Acked-by: Evgeniy Polyakov <zbr@ioremap.net>
Signed-off-by: Christian Vogel <vogelchr@vogel.cx>
---
 drivers/w1/w1.c | 39 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
index 15a2ee32f116..f2ae2e563dc5 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -25,6 +25,8 @@
 #include "w1_netlink.h"
 
 #define W1_FAMILY_DEFAULT	0
+#define W1_FAMILY_DS28E04       0x1C /* for crc quirk */
+
 
 static int w1_timeout = 10;
 module_param_named(timeout, w1_timeout, int, 0);
@@ -913,11 +915,44 @@ void w1_reconnect_slaves(struct w1_family *f, int attach)
 	mutex_unlock(&w1_mlock);
 }
 
+static int w1_addr_crc_is_valid(struct w1_master *dev, u64 rn)
+{
+	u64 rn_le = cpu_to_le64(rn);
+	struct w1_reg_num *tmp = (struct w1_reg_num *)&rn;
+	u8 crc;
+
+	crc = w1_calc_crc8((u8 *)&rn_le, 7);
+
+	/* quirk:
+	 *   DS28E04 (1w eeprom) has strapping pins to change
+	 *   address, but will not update the crc. So normal rules
+	 *   for consistent w1 addresses are violated. We test
+	 *   with the 7 LSBs of the address forced high.
+	 *
+	 *   (char*)&rn_le = { family, addr_lsb, ..., addr_msb, crc }.
+	 */
+	if (crc != tmp->crc && tmp->family == W1_FAMILY_DS28E04) {
+		u64 corr_le = rn_le;
+
+		((u8 *)&corr_le)[1] |= 0x7f;
+		crc = w1_calc_crc8((u8 *)&corr_le, 7);
+
+		dev_info(&dev->dev, "DS28E04 crc workaround on %02x.%012llx.%02x\n",
+			tmp->family, (unsigned long long)tmp->id, tmp->crc);
+	}
+
+	if (crc != tmp->crc) {
+		dev_dbg(&dev->dev, "w1 addr crc mismatch: %02x.%012llx.%02x != 0x%02x.\n",
+			tmp->family, (unsigned long long)tmp->id, tmp->crc, crc);
+		return 0;
+	}
+	return 1;
+}
+
 void w1_slave_found(struct w1_master *dev, u64 rn)
 {
 	struct w1_slave *sl;
 	struct w1_reg_num *tmp;
-	u64 rn_le = cpu_to_le64(rn);
 
 	atomic_inc(&dev->refcnt);
 
@@ -927,7 +962,7 @@ void w1_slave_found(struct w1_master *dev, u64 rn)
 	if (sl) {
 		set_bit(W1_SLAVE_ACTIVE, &sl->flags);
 	} else {
-		if (rn && tmp->crc == w1_calc_crc8((u8 *)&rn_le, 7))
+		if (rn && w1_addr_crc_is_valid(dev, rn))
 			w1_attach_slave_device(dev, tmp);
 	}
 
-- 
2.30.0

