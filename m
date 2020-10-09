Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 707E1288C9B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 17:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389276AbgJIPaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 11:30:12 -0400
Received: from inva020.nxp.com ([92.121.34.13]:57552 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389135AbgJIPaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 11:30:10 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A1FAB1A055F;
        Fri,  9 Oct 2020 17:30:07 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 94AFA1A0557;
        Fri,  9 Oct 2020 17:30:07 +0200 (CEST)
Received: from fsr-ub1864-126.ea.freescale.net (fsr-ub1864-126.ea.freescale.net [10.171.82.212])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 67441202CE;
        Fri,  9 Oct 2020 17:30:07 +0200 (CEST)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 1/2] staging: dpaa2-switch: add a dpaa2_switch_ prefix to all functions in ethsw-ethtool.c
Date:   Fri,  9 Oct 2020 18:29:59 +0300
Message-Id: <20201009153000.14550-2-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201009153000.14550-1-ioana.ciornei@nxp.com>
References: <20201009153000.14550-1-ioana.ciornei@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some static functions in the dpaa2-switch driver don't have a distinct
prefix and this is becoming an inconvenience when looking at, for
example, a perf top output and trying to determine easily which entries
are dpaa2 switch related. Ammend this by adding the prefix to all the
functions.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 .../staging/fsl-dpaa2/ethsw/ethsw-ethtool.c   | 55 ++++++++++---------
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c       |  2 +-
 drivers/staging/fsl-dpaa2/ethsw/ethsw.h       |  2 +-
 3 files changed, 30 insertions(+), 29 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw-ethtool.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw-ethtool.c
index 4f0bff86e43e..ace4a6d28562 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw-ethtool.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw-ethtool.c
@@ -12,7 +12,7 @@
 static struct {
 	enum dpsw_counter id;
 	char name[ETH_GSTRING_LEN];
-} ethsw_ethtool_counters[] =  {
+} dpaa2_switch_ethtool_counters[] =  {
 	{DPSW_CNT_ING_FRAME,		"rx frames"},
 	{DPSW_CNT_ING_BYTE,		"rx bytes"},
 	{DPSW_CNT_ING_FLTR_FRAME,	"rx filtered frames"},
@@ -27,10 +27,10 @@ static struct {
 
 };
 
-#define ETHSW_NUM_COUNTERS	ARRAY_SIZE(ethsw_ethtool_counters)
+#define DPAA2_SWITCH_NUM_COUNTERS	ARRAY_SIZE(dpaa2_switch_ethtool_counters)
 
-static void ethsw_get_drvinfo(struct net_device *netdev,
-			      struct ethtool_drvinfo *drvinfo)
+static void dpaa2_switch_get_drvinfo(struct net_device *netdev,
+				     struct ethtool_drvinfo *drvinfo)
 {
 	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
 	u16 version_major, version_minor;
@@ -53,8 +53,8 @@ static void ethsw_get_drvinfo(struct net_device *netdev,
 }
 
 static int
-ethsw_get_link_ksettings(struct net_device *netdev,
-			 struct ethtool_link_ksettings *link_ksettings)
+dpaa2_switch_get_link_ksettings(struct net_device *netdev,
+				struct ethtool_link_ksettings *link_ksettings)
 {
 	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
 	struct dpsw_link_state state = {0};
@@ -84,8 +84,8 @@ ethsw_get_link_ksettings(struct net_device *netdev,
 }
 
 static int
-ethsw_set_link_ksettings(struct net_device *netdev,
-			 const struct ethtool_link_ksettings *link_ksettings)
+dpaa2_switch_set_link_ksettings(struct net_device *netdev,
+				const struct ethtool_link_ksettings *link_ksettings)
 {
 	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
 	struct ethsw_core *ethsw = port_priv->ethsw_data;
@@ -132,55 +132,56 @@ ethsw_set_link_ksettings(struct net_device *netdev,
 	return err;
 }
 
-static int ethsw_ethtool_get_sset_count(struct net_device *dev, int sset)
+static int dpaa2_switch_ethtool_get_sset_count(struct net_device *dev, int sset)
 {
 	switch (sset) {
 	case ETH_SS_STATS:
-		return ETHSW_NUM_COUNTERS;
+		return DPAA2_SWITCH_NUM_COUNTERS;
 	default:
 		return -EOPNOTSUPP;
 	}
 }
 
-static void ethsw_ethtool_get_strings(struct net_device *netdev,
-				      u32 stringset, u8 *data)
+static void dpaa2_switch_ethtool_get_strings(struct net_device *netdev,
+					     u32 stringset, u8 *data)
 {
 	int i;
 
 	switch (stringset) {
 	case ETH_SS_STATS:
-		for (i = 0; i < ETHSW_NUM_COUNTERS; i++)
+		for (i = 0; i < DPAA2_SWITCH_NUM_COUNTERS; i++)
 			memcpy(data + i * ETH_GSTRING_LEN,
-			       ethsw_ethtool_counters[i].name, ETH_GSTRING_LEN);
+			       dpaa2_switch_ethtool_counters[i].name,
+			       ETH_GSTRING_LEN);
 		break;
 	}
 }
 
-static void ethsw_ethtool_get_stats(struct net_device *netdev,
-				    struct ethtool_stats *stats,
-				    u64 *data)
+static void dpaa2_switch_ethtool_get_stats(struct net_device *netdev,
+					   struct ethtool_stats *stats,
+					   u64 *data)
 {
 	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
 	int i, err;
 
-	for (i = 0; i < ETHSW_NUM_COUNTERS; i++) {
+	for (i = 0; i < DPAA2_SWITCH_NUM_COUNTERS; i++) {
 		err = dpsw_if_get_counter(port_priv->ethsw_data->mc_io, 0,
 					  port_priv->ethsw_data->dpsw_handle,
 					  port_priv->idx,
-					  ethsw_ethtool_counters[i].id,
+					  dpaa2_switch_ethtool_counters[i].id,
 					  &data[i]);
 		if (err)
 			netdev_err(netdev, "dpsw_if_get_counter[%s] err %d\n",
-				   ethsw_ethtool_counters[i].name, err);
+				   dpaa2_switch_ethtool_counters[i].name, err);
 	}
 }
 
-const struct ethtool_ops ethsw_port_ethtool_ops = {
-	.get_drvinfo		= ethsw_get_drvinfo,
+const struct ethtool_ops dpaa2_switch_port_ethtool_ops = {
+	.get_drvinfo		= dpaa2_switch_get_drvinfo,
 	.get_link		= ethtool_op_get_link,
-	.get_link_ksettings	= ethsw_get_link_ksettings,
-	.set_link_ksettings	= ethsw_set_link_ksettings,
-	.get_strings		= ethsw_ethtool_get_strings,
-	.get_ethtool_stats	= ethsw_ethtool_get_stats,
-	.get_sset_count		= ethsw_ethtool_get_sset_count,
+	.get_link_ksettings	= dpaa2_switch_get_link_ksettings,
+	.set_link_ksettings	= dpaa2_switch_set_link_ksettings,
+	.get_strings		= dpaa2_switch_ethtool_get_strings,
+	.get_ethtool_stats	= dpaa2_switch_ethtool_get_stats,
+	.get_sset_count		= dpaa2_switch_ethtool_get_sset_count,
 };
diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index 316fd9afd461..ee47c6b07a50 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -1711,7 +1711,7 @@ static int ethsw_probe_port(struct ethsw_core *ethsw, u16 port_idx)
 
 	SET_NETDEV_DEV(port_netdev, dev);
 	port_netdev->netdev_ops = &ethsw_port_ops;
-	port_netdev->ethtool_ops = &ethsw_port_ethtool_ops;
+	port_netdev->ethtool_ops = &dpaa2_switch_port_ethtool_ops;
 
 	/* Set MTU limits */
 	port_netdev->min_mtu = ETH_MIN_MTU;
diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.h b/drivers/staging/fsl-dpaa2/ethsw/ethsw.h
index d136dbdcaffa..5f9211ccb1ef 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.h
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.h
@@ -39,7 +39,7 @@
 
 #define ETHSW_FEATURE_MAC_ADDR	BIT(0)
 
-extern const struct ethtool_ops ethsw_port_ethtool_ops;
+extern const struct ethtool_ops dpaa2_switch_port_ethtool_ops;
 
 struct ethsw_core;
 
-- 
2.28.0

