Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B58302C9994
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 09:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbgLAIfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 03:35:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbgLAIfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 03:35:10 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8082C0613D2
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 00:34:23 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id bo9so2331828ejb.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 00:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=newoldbits-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m/3Vg/QqxRAHJbDe0CxGSyyv7iws+9zRRr1f65R8fuo=;
        b=FM/ZIqNlf6mVRsRqIPflwyzlZliPGy7P2OAW5IOFL3qxQXEXBm04NLInXHGeSCXeTy
         hnAEgKeNgZjxDuXdt+NfQYuTvmt+0iD1/k8UkNoT2rtRpYBHlIqEbKMnHbV/lrl5Lhum
         a6Lw2u6/beZXkHT/ehl6hrsQ+sTqyIeaROehQ+B3JCoC31hf6Ik9i8DlQb4hRoOzNCQq
         tr2Ayr9sqa/fALAsVHRmsad/BPvVYSCO7boLgECX4HxZzN4Y/7w43y58cwBsFPEHR3tu
         jmsM4rZ0LQl1xX9dRzdyvpoJKvqXDFWxjpk0pdt6/zSvxjSTrA63hveoriCsZuzFF2CO
         sQGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m/3Vg/QqxRAHJbDe0CxGSyyv7iws+9zRRr1f65R8fuo=;
        b=oNLyiBVTwGWvl/pghCn0QNU9bo3taCWBgbfgXHdoUwSe1tX6FP7zy1ZhCXT/H5waiW
         OW57MQ6d5hCgRbrl8y2ZRW0WlGqks1wMFltpuixlH6ATTYY3BjlwKn49/OMPtDHIir3t
         7hhh88kjv1WG6EKMHCKsNXMjaNwdk6rYj+GcIZeM0wxibdfrFV3BsGmoACMCKNJAu+UP
         OkpKB2hW1Ba7zrLysvRA7JotTsmJZL2D22moZ05gVoLMUMk70tkJWa63WR3U7lmewqYl
         BFfFyIpLeeI1LoFxjQVt/pDPlGp+2P+VoUiBvQOrIoYwXcJ9iF5+fgPeMKolX4McLmnf
         XXGw==
X-Gm-Message-State: AOAM530+QjmYt9hlxjongcrn3f1Jlh2+4fiWcIxMj0rbLZ/LUQTJpXDR
        oE9TaXr5oxDiAHvXMb6FnQ4yDQ==
X-Google-Smtp-Source: ABdhPJyehl/I+4bBX8teUz/UJJsuu0zwAAYUCYiXlbgNa7sJKNCWznb5jy0B6Z7SKF18nQ2mUktWIg==
X-Received: by 2002:a17:906:d9c7:: with SMTP id qk7mr1938154ejb.384.1606811662624;
        Tue, 01 Dec 2020 00:34:22 -0800 (PST)
Received: from nuc1.lan ([91.176.93.208])
        by smtp.gmail.com with ESMTPSA id d1sm458417eje.82.2020.12.01.00.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 00:34:21 -0800 (PST)
From:   Jean Pihet <jean.pihet@newoldbits.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ryan Barnett <ryan.barnett@rockwellcollins.com>,
        Conrad Ratschan <conrad.ratschan@rockwellcollins.com>,
        Hugo Cornelis <hugo.cornelis@essensium.com>,
        Arnout Vandecappelle <arnout.vandecappelle@essensium.com>,
        Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH v2] net: dsa: ksz8795: adjust CPU link to host interface
Date:   Tue,  1 Dec 2020 09:34:08 +0100
Message-Id: <20201201083408.51006-1-jean.pihet@newoldbits.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for RGMII in 100 and 1000 Mbps.

Adjust the CPU port settings from the host interface settings: interface
MII type, speed, duplex.

Signed-off-by: Jean Pihet <jean.pihet@newoldbits.com>
---
 drivers/net/dsa/microchip/ksz8795.c | 93 ++++++++++++++++++-----------
 1 file changed, 57 insertions(+), 36 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8795.c b/drivers/net/dsa/microchip/ksz8795.c
index 1e101ab56cea..e76390bba3a0 100644
--- a/drivers/net/dsa/microchip/ksz8795.c
+++ b/drivers/net/dsa/microchip/ksz8795.c
@@ -916,10 +916,53 @@ static void ksz8795_port_mirror_del(struct dsa_switch *ds, int port,
 			     PORT_MIRROR_SNIFFER, false);
 }
 
+static void ksz8795_mii_config(struct ksz_device *dev, struct ksz_port *p)
+{
+	u8 data8;
+
+	/* Configure MII interface for proper network communication. */
+	ksz_read8(dev, REG_PORT_5_CTRL_6, &data8);
+	data8 &= ~PORT_INTERFACE_TYPE;
+	data8 &= ~PORT_GMII_1GPS_MODE;
+	switch (p->interface) {
+	case PHY_INTERFACE_MODE_MII:
+		p->phydev.speed = SPEED_100;
+		break;
+	case PHY_INTERFACE_MODE_RMII:
+		data8 |= PORT_INTERFACE_RMII;
+		p->phydev.speed = SPEED_100;
+		break;
+	case PHY_INTERFACE_MODE_GMII:
+		data8 |= PORT_GMII_1GPS_MODE;
+		data8 |= PORT_INTERFACE_GMII;
+		p->phydev.speed = SPEED_1000;
+		break;
+	default:
+		data8 &= ~PORT_RGMII_ID_IN_ENABLE;
+		data8 &= ~PORT_RGMII_ID_OUT_ENABLE;
+		if (p->interface == PHY_INTERFACE_MODE_RGMII_ID ||
+		    p->interface == PHY_INTERFACE_MODE_RGMII_RXID)
+			data8 |= PORT_RGMII_ID_IN_ENABLE;
+		if (p->interface == PHY_INTERFACE_MODE_RGMII_ID ||
+		    p->interface == PHY_INTERFACE_MODE_RGMII_TXID)
+			data8 |= PORT_RGMII_ID_OUT_ENABLE;
+		/* Support RGMII in 100 and 1000 Mbps */
+		if (p->phydev.speed == SPEED_1000) {
+			data8 |= PORT_GMII_1GPS_MODE;
+		} else {
+			p->phydev.speed = SPEED_100;
+		}
+		data8 |= PORT_INTERFACE_RGMII;
+		break;
+	}
+	ksz_write8(dev, REG_PORT_5_CTRL_6, data8);
+	p->phydev.duplex = 1;
+}
+
 static void ksz8795_port_setup(struct ksz_device *dev, int port, bool cpu_port)
 {
 	struct ksz_port *p = &dev->ports[port];
-	u8 data8, member;
+	u8 member;
 
 	/* enable broadcast storm limit */
 	ksz_port_cfg(dev, port, P_BCAST_STORM_CTRL, PORT_BROADCAST_STORM, true);
@@ -943,41 +986,7 @@ static void ksz8795_port_setup(struct ksz_device *dev, int port, bool cpu_port)
 				 port);
 			p->interface = dev->compat_interface;
 		}
-
-		/* Configure MII interface for proper network communication. */
-		ksz_read8(dev, REG_PORT_5_CTRL_6, &data8);
-		data8 &= ~PORT_INTERFACE_TYPE;
-		data8 &= ~PORT_GMII_1GPS_MODE;
-		switch (p->interface) {
-		case PHY_INTERFACE_MODE_MII:
-			p->phydev.speed = SPEED_100;
-			break;
-		case PHY_INTERFACE_MODE_RMII:
-			data8 |= PORT_INTERFACE_RMII;
-			p->phydev.speed = SPEED_100;
-			break;
-		case PHY_INTERFACE_MODE_GMII:
-			data8 |= PORT_GMII_1GPS_MODE;
-			data8 |= PORT_INTERFACE_GMII;
-			p->phydev.speed = SPEED_1000;
-			break;
-		default:
-			data8 &= ~PORT_RGMII_ID_IN_ENABLE;
-			data8 &= ~PORT_RGMII_ID_OUT_ENABLE;
-			if (p->interface == PHY_INTERFACE_MODE_RGMII_ID ||
-			    p->interface == PHY_INTERFACE_MODE_RGMII_RXID)
-				data8 |= PORT_RGMII_ID_IN_ENABLE;
-			if (p->interface == PHY_INTERFACE_MODE_RGMII_ID ||
-			    p->interface == PHY_INTERFACE_MODE_RGMII_TXID)
-				data8 |= PORT_RGMII_ID_OUT_ENABLE;
-			data8 |= PORT_GMII_1GPS_MODE;
-			data8 |= PORT_INTERFACE_RGMII;
-			p->phydev.speed = SPEED_1000;
-			break;
-		}
-		ksz_write8(dev, REG_PORT_5_CTRL_6, data8);
-		p->phydev.duplex = 1;
-
+        ksz8795_mii_config(dev, p);
 		member = dev->port_mask;
 	} else {
 		member = dev->host_mask | p->vid_member;
@@ -1102,11 +1111,23 @@ static int ksz8795_setup(struct dsa_switch *ds)
 	return 0;
 }
 
+static void ksz8795_adjust_link(struct dsa_switch *ds, int port,
+								struct phy_device *phydev)
+{
+	struct ksz_device *dev = ds->priv;
+	struct ksz_port *p = &dev->ports[port];
+
+	/* Adjust the link interface mode and speed for the CPU port */
+	if (dsa_is_cpu_port(ds, port))
+		ksz8795_mii_config(dev, p);
+}
+
 static const struct dsa_switch_ops ksz8795_switch_ops = {
 	.get_tag_protocol	= ksz8795_get_tag_protocol,
 	.setup			= ksz8795_setup,
 	.phy_read		= ksz_phy_read16,
 	.phy_write		= ksz_phy_write16,
+	.adjust_link		= ksz8795_adjust_link,
 	.phylink_mac_link_down	= ksz_mac_link_down,
 	.port_enable		= ksz_enable_port,
 	.get_strings		= ksz8795_get_strings,
-- 
2.26.2

