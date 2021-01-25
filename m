Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6676302559
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 14:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbhAYNNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 08:13:13 -0500
Received: from de-deferred1.bosch-org.com ([139.15.180.216]:58264 "EHLO
        de-deferred1.bosch-org.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728454AbhAYNIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 08:08:00 -0500
X-Greylist: delayed 522 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Jan 2021 08:07:03 EST
Received: from de-out1.bosch-org.com (snat-lb41g3-dmz-psi-sl1-maildeferred.fe.ssn.bosch.com [139.15.180.215])
        by si0vms0224.rbdmz01.com (Postfix) with ESMTPS id 4DPVHx1sYbzVfF;
        Mon, 25 Jan 2021 13:57:01 +0100 (CET)
Received: from si0vm1948.rbesz01.com (lb41g3-ha-dmz-psi-sl1-mailout.fe.ssn.bosch.com [139.15.230.188])
        by fe0vms0187.rbdmz01.com (Postfix) with ESMTPS id 4DPVFx0TyVz1XLDQx;
        Mon, 25 Jan 2021 13:55:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=de.bosch.com;
        s=key2-intmail; t=1611579317;
        bh=fP74M6HwZDCum3+vzeaerJPkseKxvj4gZV75mefECbo=; l=10;
        h=From:Subject:From:Reply-To:Sender;
        b=BqHGY9dggG91LOMyyOmva32qC8WOQ4Nx2jja3O1e9UG+7WlP5sF3m5pHDhdsG4jwf
         74zArTTcqoEdwJPHNYJrtghuZF9TB+wVXTMl32R03eR6vfnLq2LP+W5eU581xX5840
         NSm0umCe0RSlQuR3iOUmqWZfJd7VwhyrDn4Vi9Ow=
Received: from fe0vm02900.rbesz01.com (unknown [10.58.172.176])
        by si0vm1948.rbesz01.com (Postfix) with ESMTPS id 4DPVFx0BXpz5Nv;
        Mon, 25 Jan 2021 13:55:17 +0100 (CET)
X-AuditID: 0a3aad0c-f29ff700000020da-f7-600ebfb4e9fc
Received: from si0vm1950.rbesz01.com ( [10.58.173.29])
        (using TLS with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by fe0vm02900.rbesz01.com (SMG Outbound) with SMTP id 85.80.08410.4BFBE006; Mon, 25 Jan 2021 13:55:16 +0100 (CET)
Received: from SI-HUB2000.de.bosch.com (si-hub2000.de.bosch.com [10.4.103.108])
        by si0vm1950.rbesz01.com (Postfix) with ESMTPS id 4DPVFw6XHBzW7n;
        Mon, 25 Jan 2021 13:55:16 +0100 (CET)
Received: from luchador.grb-fir.grb.de.bosch.com (10.19.187.97) by
 SI-HUB2000.de.bosch.com (10.4.103.108) with Microsoft SMTP Server id
 15.1.2106.2; Mon, 25 Jan 2021 13:55:16 +0100
From:   Mark Jonas <mark.jonas@de.bosch.com>
To:     Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Adam.Thomson.Opensource@diasemi.com>,
        <stwiss.opensource@diasemi.com>, <marek.vasut@gmail.com>,
        <tingquan.ruan@cn.bosch.com>, <hubert.streidl@de.bosch.com>,
        Mark Jonas <mark.jonas@de.bosch.com>
Subject: [PATCH 1/1] mfd: da9063: Support SMBus and I2C mode
Date:   Mon, 25 Jan 2021 13:54:58 +0100
Message-ID: <20210125125458.1302525-2-mark.jonas@de.bosch.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210125125458.1302525-1-mark.jonas@de.bosch.com>
References: <20210125125458.1302525-1-mark.jonas@de.bosch.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMLMWRmVeSWpSXmKPExsXCZbVWVnfLfr4EgxtrbCyWvl/KbDH/yDlW
        i/tfjzJaXN41h83i6J57zBate4+wW1z9vZ7FYm/rRWYHDo8Vn/Q9ds66y+6xaVUnm8eda3vY
        PD5vkgtgjeKySUnNySxLLdK3S+DKeNewhrVgq2rFsaO9zA2Ml+S6GDk4JARMJNqvVncxcnEI
        Ccxgkjg3/wcjhLObUWLpsslMEM4OIOfPN/YuRk4ONgEtiZsndjCD2CICtRLrtm4AK2IW6GKS
        eDv5MytIQljARqL35hewIhYBVYljn1exgqzjFbCTmHbbFiQsISAvMfPSd7CZnAL2EhOPPWQG
        KRECKvm7LxUkzCsgKHFy5hMWEJsZqLx562xmCFtC4uCLF8wTGAVmISmbhaRsFpKyBYzMqxjF
        0lINynINjCwNDPSKklKLqwwM9ZLzczcxQsKdZwfjqZ4PeocYmTgYDzFKcDArifDu1uNJEOJN
        SaysSi3Kjy8qzUktPsQozcGiJM6rwrMxTkggPbEkNTs1tSC1CCbLxMEp1cDU/6OjSzJrkZ6E
        S7xN2PU3MhO8X7MKs8ne7Hsy9/iDQB2ma4W8vEm/HTtvLDs/kz+jxXGnvanjCk43pq4XdRbx
        tS90Yh876Skm3Ti4aoGcgqX10nVThP+rKR1btMXhXc1uLjFLtQXlGR5TF259NntT3+57k479
        SereP/dhfdWTMJcop//KH+UdFtrdf14u9z/hZvhi7tTNcxac661VOH8w6p3vjAemRepLt1zP
        mVo0ZZn348nv87zbbp7p1WvXWzr5C0tC/cPqPRfPODA5NBcW2L+4tUOebZc4+674sLCNsbFL
        c5mvc31nY+Y+8KRuvURB+cyKStbZ1gu3/mxSM8mvPMfGFrrbdsvs+zPNG+qVWIozEg21mIuK
        EwHzuIHI5gIAAA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hubert Streidl <hubert.streidl@de.bosch.com>

By default the PMIC DA9063 2-wire interface is SMBus compliant. This
means the PMIC will automatically reset the interface when the clock
signal ceases for more than the SMBus timeout of 35 ms.

If the I2C driver / device is not capable of creating atomic I2C
transactions, a context change can cause a ceasing of the the clock
signal. This can happen if for example a real-time thread is scheduled.
Then the DA9063 in SMBus mode will reset the 2-wire interface.
Subsequently a write message could end up in the wrong register. This
could cause unpredictable system behavior.

The DA9063 PMIC also supports an I2C compliant mode for the 2-wire
interface. This mode does not reset the interface when the clock
signal ceases. Thus the problem depicted above does not occur.

This patch makes the I2C mode configurable by device tree. The SMBus
compliant mode is kept as the default.

Signed-off-by: Hubert Streidl <hubert.streidl@de.bosch.com>
Signed-off-by: Mark Jonas <mark.jonas@de.bosch.com>
---
 Documentation/devicetree/bindings/mfd/da9063.txt |  7 +++++++
 drivers/mfd/da9063-core.c                        |  9 +++++++++
 drivers/mfd/da9063-i2c.c                         | 13 +++++++++++++
 include/linux/mfd/da9063/core.h                  |  1 +
 include/linux/mfd/da9063/registers.h             |  3 +++
 5 files changed, 33 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/da9063.txt b/Documentation/devicetree/bindings/mfd/da9063.txt
index 8da879935c59..256f2a25fe0a 100644
--- a/Documentation/devicetree/bindings/mfd/da9063.txt
+++ b/Documentation/devicetree/bindings/mfd/da9063.txt
@@ -19,6 +19,12 @@ Required properties:
 - interrupts : IRQ line information.
 - interrupt-controller
 
+Optional properties:
+
+- i2c-mode : Switch serial 2-wire interface into I2C mode. Without this
+  property the PMIC uses the SMBus mode (resets the interface if the clock
+  ceases for a longer time than the SMBus timeout).
+
 Sub-nodes:
 
 - regulators : This node defines the settings for the LDOs and BUCKs.
@@ -77,6 +83,7 @@ Example:
 		interrupt-parent = <&gpio6>;
 		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
+		i2c-mode;
 
 		rtc {
 			compatible = "dlg,da9063-rtc";
diff --git a/drivers/mfd/da9063-core.c b/drivers/mfd/da9063-core.c
index df407c3afce3..baa1e4310c8c 100644
--- a/drivers/mfd/da9063-core.c
+++ b/drivers/mfd/da9063-core.c
@@ -162,6 +162,15 @@ int da9063_device_init(struct da9063 *da9063, unsigned int irq)
 {
 	int ret;
 
+	if (da9063->i2cmode) {
+		ret = regmap_update_bits(da9063->regmap, DA9063_REG_CONFIG_J,
+				DA9063_TWOWIRE_TO, 0);
+		if (ret < 0) {
+			dev_err(da9063->dev, "Cannot enable I2C mode.\n");
+			return -EIO;
+		}
+	}
+
 	ret = da9063_clear_fault_log(da9063);
 	if (ret < 0)
 		dev_err(da9063->dev, "Cannot clear fault log\n");
diff --git a/drivers/mfd/da9063-i2c.c b/drivers/mfd/da9063-i2c.c
index 3781d0bb7786..af0bf13ab43e 100644
--- a/drivers/mfd/da9063-i2c.c
+++ b/drivers/mfd/da9063-i2c.c
@@ -351,6 +351,17 @@ static const struct of_device_id da9063_dt_ids[] = {
 	{ }
 };
 MODULE_DEVICE_TABLE(of, da9063_dt_ids);
+
+static void da9063_i2c_parse_dt(struct i2c_client *client, struct da9063 *da9063)
+{
+	struct device_node *np = client->dev.of_node;
+
+	if (of_property_read_bool(np, "i2c-mode"))
+		da9063->i2cmode = true;
+	else
+		da9063->i2cmode = false;
+}
+
 static int da9063_i2c_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
 {
@@ -366,6 +377,8 @@ static int da9063_i2c_probe(struct i2c_client *i2c,
 	da9063->chip_irq = i2c->irq;
 	da9063->type = id->driver_data;
 
+	da9063_i2c_parse_dt(i2c, da9063);
+
 	ret = da9063_get_device_type(i2c, da9063);
 	if (ret)
 		return ret;
diff --git a/include/linux/mfd/da9063/core.h b/include/linux/mfd/da9063/core.h
index fa7a43f02f27..866864c50f78 100644
--- a/include/linux/mfd/da9063/core.h
+++ b/include/linux/mfd/da9063/core.h
@@ -77,6 +77,7 @@ struct da9063 {
 	enum da9063_type type;
 	unsigned char	variant_code;
 	unsigned int	flags;
+	bool	i2cmode;
 
 	/* Control interface */
 	struct regmap	*regmap;
diff --git a/include/linux/mfd/da9063/registers.h b/include/linux/mfd/da9063/registers.h
index 1dbabf1b3cb8..6e0f66a2e727 100644
--- a/include/linux/mfd/da9063/registers.h
+++ b/include/linux/mfd/da9063/registers.h
@@ -1037,6 +1037,9 @@
 #define		DA9063_NONKEY_PIN_AUTODOWN	0x02
 #define		DA9063_NONKEY_PIN_AUTOFLPRT	0x03
 
+/* DA9063_REG_CONFIG_J (addr=0x10F) */
+#define DA9063_TWOWIRE_TO			0x40
+
 /* DA9063_REG_MON_REG_5 (addr=0x116) */
 #define DA9063_MON_A8_IDX_MASK			0x07
 #define		DA9063_MON_A8_IDX_NONE		0x00
-- 
2.25.1

