Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0F8C2C78A1
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 11:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbgK2KY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 05:24:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgK2KYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 05:24:53 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C06C0613D4
        for <linux-kernel@vger.kernel.org>; Sun, 29 Nov 2020 02:24:12 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id d18so11155641edt.7
        for <linux-kernel@vger.kernel.org>; Sun, 29 Nov 2020 02:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=newoldbits-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sjOibnMN7nIxvbRaGccAflEou/+xl9Xs41ThDMc0fJs=;
        b=Vnup04KsksW53rdTnSeQojyoymyd7l+1Bv/51ksm2/4zt6ukqHjH5Nb2SgamlcUVya
         GvS40SX+B7wfjZ7sQ9B6R1bC6qTSecZLYfIZPgVP/kFgg2YBa0K4HVm9vuPYE4y9GzwE
         phg+waSDyTOMpZdQHQp2JpqSnOWAbFarPJvaSwcK2BocvqENPoxyGFW+uP4Hmj3IneG3
         MRyaDbW2kS3ob7D54gSwZzyaLM9a6WCzsDDsGUCi+JwPSzXMDqspIDz1ShO/TTQd4Wfi
         O7MF1SdNLhie78+LUrlQGHQjWYhB50p0lfe47mRyOecta8WKE9vGdbefJ8Z6V1SY4QUZ
         o7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sjOibnMN7nIxvbRaGccAflEou/+xl9Xs41ThDMc0fJs=;
        b=KER6XpD37rq74vNuctALolOIVlfKEIrigw/Wo9igohbgWgXRYk1aeSJNtubWXvU70B
         TnrONYVKu+u2eqokAGXkRx0/A/NyYdBRmYOON3fi9MaoLdbsFXk6Oxy+aAuekCqn7YO5
         3pkgai6m87jq9Mzj5DBXjyDhAfRyYZ/js41khlfIt7LMwqHk3dWuZweEPABBbyriS3ic
         UUYw404W0GOZxeu6WeT5DWEFq0KndKxMEQmNhewe2laRDJg8Nrsnf4eQoXZ56vqsQAHO
         g+FhXKPqLrNk/1SOm1OT4+K0tx4rmTgFl6Fk1xmkF+NUiYrLx2fOKtV6G+0gppDgqSzS
         KgKQ==
X-Gm-Message-State: AOAM533FyCoJ9gHfkTfyPG03swc1LefL8KzmMWOODNqV5H+zzOUMlGj9
        5yQ6pNcUmX0yeUpvtmCF8kvLGQ==
X-Google-Smtp-Source: ABdhPJz2GY+kSDm29q/e54qq74YSfl2a3BEk1+TPbKSrHTIZMHdWRCJL2cNB87Ij0ToCHJdXtffM5Q==
X-Received: by 2002:a05:6402:170e:: with SMTP id y14mr17105906edu.115.1606645451268;
        Sun, 29 Nov 2020 02:24:11 -0800 (PST)
Received: from nuc1.lan (208.2-240-81.adsl-dyn.isp.belgacom.be. [81.240.2.208])
        by smtp.gmail.com with ESMTPSA id gq19sm4605244ejb.10.2020.11.29.02.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 02:24:10 -0800 (PST)
From:   Jean Pihet <jean.pihet@newoldbits.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ryan Barnett <ryan.barnett@rockwellcollins.com>,
        Conrad Ratschan <conrad.ratschan@rockwellcollins.com>,
        Hugo Cornelis <hugo.cornelis@essensium.com>,
        Arnout Vandecappelle <arnout.vandecappelle@essensium.com>,
        Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 2/2] net: dsa: ksz8795: adjust CPU link to host interface
Date:   Sun, 29 Nov 2020 11:24:00 +0100
Message-Id: <20201129102400.157786-2-jean.pihet@newoldbits.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201129102400.157786-1-jean.pihet@newoldbits.com>
References: <20201129102400.157786-1-jean.pihet@newoldbits.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for RGMII in 100 and 1000 Mbps.

Adjust the CPU port based on the host interface settings: interface
MII type, speed, duplex.

Signed-off-by: Jean Pihet <jean.pihet@newoldbits.com>
---
 drivers/net/dsa/microchip/ksz8795.c | 93 ++++++++++++++++++-----------
 1 file changed, 57 insertions(+), 36 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8795.c b/drivers/net/dsa/microchip/ksz8795.c
index 1e101ab56cea..09c1173cc607 100644
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
 
+void ksz8795_adjust_link(struct dsa_switch *ds, int port,
+						 struct phy_device *phydev)
+{
+	struct ksz_device *dev = ds->priv;
+	struct ksz_port *p = &dev->ports[port];
+
+	/* Adjust the link interface mode and speed for the CPU port */
+	if (port == dev->cpu_port)
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

