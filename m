Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D589288C9C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 17:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389284AbgJIPaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 11:30:16 -0400
Received: from inva021.nxp.com ([92.121.34.21]:41124 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389214AbgJIPaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 11:30:15 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E0F902010F8;
        Fri,  9 Oct 2020 17:30:07 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D84C62003EB;
        Fri,  9 Oct 2020 17:30:07 +0200 (CEST)
Received: from fsr-ub1864-126.ea.freescale.net (fsr-ub1864-126.ea.freescale.net [10.171.82.212])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id A2E42202CE;
        Fri,  9 Oct 2020 17:30:07 +0200 (CEST)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 2/2] staging: dpaa2-switch: add a dpaa2_switch prefix to all functions in ethsw.c
Date:   Fri,  9 Oct 2020 18:30:00 +0300
Message-Id: <20201009153000.14550-3-ioana.ciornei@nxp.com>
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
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 439 ++++++++++++------------
 1 file changed, 219 insertions(+), 220 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index ee47c6b07a50..20c6326e5dee 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -24,7 +24,7 @@
 
 #define DEFAULT_VLAN_ID			1
 
-static int ethsw_add_vlan(struct ethsw_core *ethsw, u16 vid)
+static int dpaa2_switch_add_vlan(struct ethsw_core *ethsw, u16 vid)
 {
 	int err;
 
@@ -43,7 +43,7 @@ static int ethsw_add_vlan(struct ethsw_core *ethsw, u16 vid)
 	return 0;
 }
 
-static bool ethsw_port_is_up(struct ethsw_port_priv *port_priv)
+static bool dpaa2_switch_port_is_up(struct ethsw_port_priv *port_priv)
 {
 	struct net_device *netdev = port_priv->netdev;
 	struct dpsw_link_state state;
@@ -62,7 +62,7 @@ static bool ethsw_port_is_up(struct ethsw_port_priv *port_priv)
 	return state.up ? true : false;
 }
 
-static int ethsw_port_set_pvid(struct ethsw_port_priv *port_priv, u16 pvid)
+static int dpaa2_switch_port_set_pvid(struct ethsw_port_priv *port_priv, u16 pvid)
 {
 	struct ethsw_core *ethsw = port_priv->ethsw_data;
 	struct net_device *netdev = port_priv->netdev;
@@ -80,7 +80,7 @@ static int ethsw_port_set_pvid(struct ethsw_port_priv *port_priv, u16 pvid)
 	tci_cfg.vlan_id = pvid;
 
 	/* Interface needs to be down to change PVID */
-	up = ethsw_port_is_up(port_priv);
+	up = dpaa2_switch_port_is_up(port_priv);
 	if (up) {
 		err = dpsw_if_disable(ethsw->mc_io, 0,
 				      ethsw->dpsw_handle,
@@ -117,8 +117,8 @@ static int ethsw_port_set_pvid(struct ethsw_port_priv *port_priv, u16 pvid)
 	return err;
 }
 
-static int ethsw_port_add_vlan(struct ethsw_port_priv *port_priv,
-			       u16 vid, u16 flags)
+static int dpaa2_switch_port_add_vlan(struct ethsw_port_priv *port_priv,
+				      u16 vid, u16 flags)
 {
 	struct ethsw_core *ethsw = port_priv->ethsw_data;
 	struct net_device *netdev = port_priv->netdev;
@@ -153,7 +153,7 @@ static int ethsw_port_add_vlan(struct ethsw_port_priv *port_priv,
 	}
 
 	if (flags & BRIDGE_VLAN_INFO_PVID) {
-		err = ethsw_port_set_pvid(port_priv, vid);
+		err = dpaa2_switch_port_set_pvid(port_priv, vid);
 		if (err)
 			return err;
 	}
@@ -161,7 +161,7 @@ static int ethsw_port_add_vlan(struct ethsw_port_priv *port_priv,
 	return 0;
 }
 
-static int ethsw_set_learning(struct ethsw_core *ethsw, bool enable)
+static int dpaa2_switch_set_learning(struct ethsw_core *ethsw, bool enable)
 {
 	enum dpsw_fdb_learning_mode learn_mode;
 	int err;
@@ -182,7 +182,7 @@ static int ethsw_set_learning(struct ethsw_core *ethsw, bool enable)
 	return 0;
 }
 
-static int ethsw_port_set_flood(struct ethsw_port_priv *port_priv, bool enable)
+static int dpaa2_switch_port_set_flood(struct ethsw_port_priv *port_priv, bool enable)
 {
 	int err;
 
@@ -199,7 +199,7 @@ static int ethsw_port_set_flood(struct ethsw_port_priv *port_priv, bool enable)
 	return 0;
 }
 
-static int ethsw_port_set_stp_state(struct ethsw_port_priv *port_priv, u8 state)
+static int dpaa2_switch_port_set_stp_state(struct ethsw_port_priv *port_priv, u8 state)
 {
 	struct dpsw_stp_cfg stp_cfg = {
 		.state = state,
@@ -229,7 +229,7 @@ static int ethsw_port_set_stp_state(struct ethsw_port_priv *port_priv, u8 state)
 	return 0;
 }
 
-static int ethsw_dellink_switch(struct ethsw_core *ethsw, u16 vid)
+static int dpaa2_switch_dellink(struct ethsw_core *ethsw, u16 vid)
 {
 	struct ethsw_port_priv *ppriv_local = NULL;
 	int i, err;
@@ -252,8 +252,8 @@ static int ethsw_dellink_switch(struct ethsw_core *ethsw, u16 vid)
 	return 0;
 }
 
-static int ethsw_port_fdb_add_uc(struct ethsw_port_priv *port_priv,
-				 const unsigned char *addr)
+static int dpaa2_switch_port_fdb_add_uc(struct ethsw_port_priv *port_priv,
+					const unsigned char *addr)
 {
 	struct dpsw_fdb_unicast_cfg entry = {0};
 	int err;
@@ -271,8 +271,8 @@ static int ethsw_port_fdb_add_uc(struct ethsw_port_priv *port_priv,
 	return err;
 }
 
-static int ethsw_port_fdb_del_uc(struct ethsw_port_priv *port_priv,
-				 const unsigned char *addr)
+static int dpaa2_switch_port_fdb_del_uc(struct ethsw_port_priv *port_priv,
+					const unsigned char *addr)
 {
 	struct dpsw_fdb_unicast_cfg entry = {0};
 	int err;
@@ -291,8 +291,8 @@ static int ethsw_port_fdb_del_uc(struct ethsw_port_priv *port_priv,
 	return err;
 }
 
-static int ethsw_port_fdb_add_mc(struct ethsw_port_priv *port_priv,
-				 const unsigned char *addr)
+static int dpaa2_switch_port_fdb_add_mc(struct ethsw_port_priv *port_priv,
+					const unsigned char *addr)
 {
 	struct dpsw_fdb_multicast_cfg entry = {0};
 	int err;
@@ -312,8 +312,8 @@ static int ethsw_port_fdb_add_mc(struct ethsw_port_priv *port_priv,
 	return err;
 }
 
-static int ethsw_port_fdb_del_mc(struct ethsw_port_priv *port_priv,
-				 const unsigned char *addr)
+static int dpaa2_switch_port_fdb_del_mc(struct ethsw_port_priv *port_priv,
+					const unsigned char *addr)
 {
 	struct dpsw_fdb_multicast_cfg entry = {0};
 	int err;
@@ -333,33 +333,33 @@ static int ethsw_port_fdb_del_mc(struct ethsw_port_priv *port_priv,
 	return err;
 }
 
-static int port_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
-			struct net_device *dev, const unsigned char *addr,
-			u16 vid, u16 flags,
-			struct netlink_ext_ack *extack)
+static int dpaa2_switch_port_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
+				     struct net_device *dev, const unsigned char *addr,
+				     u16 vid, u16 flags,
+				     struct netlink_ext_ack *extack)
 {
 	if (is_unicast_ether_addr(addr))
-		return ethsw_port_fdb_add_uc(netdev_priv(dev),
-					     addr);
+		return dpaa2_switch_port_fdb_add_uc(netdev_priv(dev),
+						    addr);
 	else
-		return ethsw_port_fdb_add_mc(netdev_priv(dev),
-					     addr);
+		return dpaa2_switch_port_fdb_add_mc(netdev_priv(dev),
+						    addr);
 }
 
-static int port_fdb_del(struct ndmsg *ndm, struct nlattr *tb[],
-			struct net_device *dev,
-			const unsigned char *addr, u16 vid)
+static int dpaa2_switch_port_fdb_del(struct ndmsg *ndm, struct nlattr *tb[],
+				     struct net_device *dev,
+				     const unsigned char *addr, u16 vid)
 {
 	if (is_unicast_ether_addr(addr))
-		return ethsw_port_fdb_del_uc(netdev_priv(dev),
-					     addr);
+		return dpaa2_switch_port_fdb_del_uc(netdev_priv(dev),
+						    addr);
 	else
-		return ethsw_port_fdb_del_mc(netdev_priv(dev),
-					     addr);
+		return dpaa2_switch_port_fdb_del_mc(netdev_priv(dev),
+						    addr);
 }
 
-static void port_get_stats(struct net_device *netdev,
-			   struct rtnl_link_stats64 *stats)
+static void dpaa2_switch_port_get_stats(struct net_device *netdev,
+					struct rtnl_link_stats64 *stats)
 {
 	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
 	u64 tmp;
@@ -424,26 +424,26 @@ static void port_get_stats(struct net_device *netdev,
 	netdev_err(netdev, "dpsw_if_get_counter err %d\n", err);
 }
 
-static bool port_has_offload_stats(const struct net_device *netdev,
-				   int attr_id)
+static bool dpaa2_switch_port_has_offload_stats(const struct net_device *netdev,
+						int attr_id)
 {
 	return (attr_id == IFLA_OFFLOAD_XSTATS_CPU_HIT);
 }
 
-static int port_get_offload_stats(int attr_id,
-				  const struct net_device *netdev,
-				  void *sp)
+static int dpaa2_switch_port_get_offload_stats(int attr_id,
+					       const struct net_device *netdev,
+					       void *sp)
 {
 	switch (attr_id) {
 	case IFLA_OFFLOAD_XSTATS_CPU_HIT:
-		port_get_stats((struct net_device *)netdev, sp);
+		dpaa2_switch_port_get_stats((struct net_device *)netdev, sp);
 		return 0;
 	}
 
 	return -EINVAL;
 }
 
-static int port_change_mtu(struct net_device *netdev, int mtu)
+static int dpaa2_switch_port_change_mtu(struct net_device *netdev, int mtu)
 {
 	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
 	int err;
@@ -463,7 +463,7 @@ static int port_change_mtu(struct net_device *netdev, int mtu)
 	return 0;
 }
 
-static int port_carrier_state_sync(struct net_device *netdev)
+static int dpaa2_switch_port_carrier_state_sync(struct net_device *netdev)
 {
 	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
 	struct dpsw_link_state state;
@@ -496,7 +496,7 @@ static int port_carrier_state_sync(struct net_device *netdev)
 	return 0;
 }
 
-static int port_open(struct net_device *netdev)
+static int dpaa2_switch_port_open(struct net_device *netdev)
 {
 	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
 	int err;
@@ -520,10 +520,10 @@ static int port_open(struct net_device *netdev)
 	}
 
 	/* sync carrier state */
-	err = port_carrier_state_sync(netdev);
+	err = dpaa2_switch_port_carrier_state_sync(netdev);
 	if (err) {
 		netdev_err(netdev,
-			   "port_carrier_state_sync err %d\n", err);
+			   "dpaa2_switch_port_carrier_state_sync err %d\n", err);
 		goto err_carrier_sync;
 	}
 
@@ -536,7 +536,7 @@ static int port_open(struct net_device *netdev)
 	return err;
 }
 
-static int port_stop(struct net_device *netdev)
+static int dpaa2_switch_port_stop(struct net_device *netdev)
 {
 	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
 	int err;
@@ -552,8 +552,8 @@ static int port_stop(struct net_device *netdev)
 	return 0;
 }
 
-static netdev_tx_t port_dropframe(struct sk_buff *skb,
-				  struct net_device *netdev)
+static netdev_tx_t dpaa2_switch_port_dropframe(struct sk_buff *skb,
+					       struct net_device *netdev)
 {
 	/* we don't support I/O for now, drop the frame */
 	dev_kfree_skb_any(skb);
@@ -561,8 +561,8 @@ static netdev_tx_t port_dropframe(struct sk_buff *skb,
 	return NETDEV_TX_OK;
 }
 
-static int swdev_get_port_parent_id(struct net_device *dev,
-				    struct netdev_phys_item_id *ppid)
+static int dpaa2_switch_port_parent_id(struct net_device *dev,
+				       struct netdev_phys_item_id *ppid)
 {
 	struct ethsw_port_priv *port_priv = netdev_priv(dev);
 
@@ -572,8 +572,8 @@ static int swdev_get_port_parent_id(struct net_device *dev,
 	return 0;
 }
 
-static int port_get_phys_name(struct net_device *netdev, char *name,
-			      size_t len)
+static int dpaa2_switch_port_get_phys_name(struct net_device *netdev, char *name,
+					   size_t len)
 {
 	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
 	int err;
@@ -592,8 +592,8 @@ struct ethsw_dump_ctx {
 	int idx;
 };
 
-static int ethsw_fdb_do_dump(struct fdb_dump_entry *entry,
-			     struct ethsw_dump_ctx *dump)
+static int dpaa2_switch_fdb_dump_nl(struct fdb_dump_entry *entry,
+				    struct ethsw_dump_ctx *dump)
 {
 	int is_dynamic = entry->type & DPSW_FDB_ENTRY_DINAMIC;
 	u32 portid = NETLINK_CB(dump->cb->skb).portid;
@@ -632,8 +632,8 @@ static int ethsw_fdb_do_dump(struct fdb_dump_entry *entry,
 	return -EMSGSIZE;
 }
 
-static int port_fdb_valid_entry(struct fdb_dump_entry *entry,
-				struct ethsw_port_priv *port_priv)
+static int dpaa2_switch_port_fdb_valid_entry(struct fdb_dump_entry *entry,
+					     struct ethsw_port_priv *port_priv)
 {
 	int idx = port_priv->idx;
 	int valid;
@@ -646,9 +646,9 @@ static int port_fdb_valid_entry(struct fdb_dump_entry *entry,
 	return valid;
 }
 
-static int port_fdb_dump(struct sk_buff *skb, struct netlink_callback *cb,
-			 struct net_device *net_dev,
-			 struct net_device *filter_dev, int *idx)
+static int dpaa2_switch_port_fdb_dump(struct sk_buff *skb, struct netlink_callback *cb,
+				      struct net_device *net_dev,
+				      struct net_device *filter_dev, int *idx)
 {
 	struct ethsw_port_priv *port_priv = netdev_priv(net_dev);
 	struct ethsw_core *ethsw = port_priv->ethsw_data;
@@ -693,10 +693,10 @@ static int port_fdb_dump(struct sk_buff *skb, struct netlink_callback *cb,
 	for (i = 0; i < num_fdb_entries; i++) {
 		fdb_entry = fdb_entries[i];
 
-		if (!port_fdb_valid_entry(&fdb_entry, port_priv))
+		if (!dpaa2_switch_port_fdb_valid_entry(&fdb_entry, port_priv))
 			continue;
 
-		err = ethsw_fdb_do_dump(&fdb_entry, &dump);
+		err = dpaa2_switch_fdb_dump_nl(&fdb_entry, &dump);
 		if (err)
 			goto end;
 	}
@@ -715,7 +715,7 @@ static int port_fdb_dump(struct sk_buff *skb, struct netlink_callback *cb,
 	return err;
 }
 
-static int ethsw_port_set_mac_addr(struct ethsw_port_priv *port_priv)
+static int dpaa2_switch_port_set_mac_addr(struct ethsw_port_priv *port_priv)
 {
 	struct ethsw_core *ethsw = port_priv->ethsw_data;
 	struct net_device *net_dev = port_priv->netdev;
@@ -755,30 +755,30 @@ static int ethsw_port_set_mac_addr(struct ethsw_port_priv *port_priv)
 	return 0;
 }
 
-static const struct net_device_ops ethsw_port_ops = {
-	.ndo_open		= port_open,
-	.ndo_stop		= port_stop,
+static const struct net_device_ops dpaa2_switch_port_ops = {
+	.ndo_open		= dpaa2_switch_port_open,
+	.ndo_stop		= dpaa2_switch_port_stop,
 
 	.ndo_set_mac_address	= eth_mac_addr,
-	.ndo_get_stats64	= port_get_stats,
-	.ndo_change_mtu		= port_change_mtu,
-	.ndo_has_offload_stats	= port_has_offload_stats,
-	.ndo_get_offload_stats	= port_get_offload_stats,
-	.ndo_fdb_add		= port_fdb_add,
-	.ndo_fdb_del		= port_fdb_del,
-	.ndo_fdb_dump		= port_fdb_dump,
-
-	.ndo_start_xmit		= port_dropframe,
-	.ndo_get_port_parent_id	= swdev_get_port_parent_id,
-	.ndo_get_phys_port_name = port_get_phys_name,
+	.ndo_get_stats64	= dpaa2_switch_port_get_stats,
+	.ndo_change_mtu		= dpaa2_switch_port_change_mtu,
+	.ndo_has_offload_stats	= dpaa2_switch_port_has_offload_stats,
+	.ndo_get_offload_stats	= dpaa2_switch_port_get_offload_stats,
+	.ndo_fdb_add		= dpaa2_switch_port_fdb_add,
+	.ndo_fdb_del		= dpaa2_switch_port_fdb_del,
+	.ndo_fdb_dump		= dpaa2_switch_port_fdb_dump,
+
+	.ndo_start_xmit		= dpaa2_switch_port_dropframe,
+	.ndo_get_port_parent_id	= dpaa2_switch_port_parent_id,
+	.ndo_get_phys_port_name = dpaa2_switch_port_get_phys_name,
 };
 
-static bool ethsw_port_dev_check(const struct net_device *netdev,
-				 struct notifier_block *nb)
+static bool dpaa2_switch_port_dev_check(const struct net_device *netdev,
+					struct notifier_block *nb)
 {
 	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
 
-	if (netdev->netdev_ops == &ethsw_port_ops &&
+	if (netdev->netdev_ops == &dpaa2_switch_port_ops &&
 	    (!nb || &port_priv->ethsw_data->port_nb == nb ||
 	     &port_priv->ethsw_data->port_switchdev_nb == nb ||
 	     &port_priv->ethsw_data->port_switchdevb_nb == nb))
@@ -787,17 +787,17 @@ static bool ethsw_port_dev_check(const struct net_device *netdev,
 	return false;
 }
 
-static void ethsw_links_state_update(struct ethsw_core *ethsw)
+static void dpaa2_switch_links_state_update(struct ethsw_core *ethsw)
 {
 	int i;
 
 	for (i = 0; i < ethsw->sw_attr.num_ifs; i++) {
-		port_carrier_state_sync(ethsw->ports[i]->netdev);
-		ethsw_port_set_mac_addr(ethsw->ports[i]);
+		dpaa2_switch_port_carrier_state_sync(ethsw->ports[i]->netdev);
+		dpaa2_switch_port_set_mac_addr(ethsw->ports[i]);
 	}
 }
 
-static irqreturn_t ethsw_irq0_handler_thread(int irq_num, void *arg)
+static irqreturn_t dpaa2_switch_irq0_handler_thread(int irq_num, void *arg)
 {
 	struct device *dev = (struct device *)arg;
 	struct ethsw_core *ethsw = dev_get_drvdata(dev);
@@ -819,13 +819,13 @@ static irqreturn_t ethsw_irq0_handler_thread(int irq_num, void *arg)
 	}
 
 	if (status & DPSW_IRQ_EVENT_LINK_CHANGED)
-		ethsw_links_state_update(ethsw);
+		dpaa2_switch_links_state_update(ethsw);
 
 out:
 	return IRQ_HANDLED;
 }
 
-static int ethsw_setup_irqs(struct fsl_mc_device *sw_dev)
+static int dpaa2_switch_setup_irqs(struct fsl_mc_device *sw_dev)
 {
 	struct device *dev = &sw_dev->dev;
 	struct ethsw_core *ethsw = dev_get_drvdata(dev);
@@ -855,7 +855,7 @@ static int ethsw_setup_irqs(struct fsl_mc_device *sw_dev)
 
 	err = devm_request_threaded_irq(dev, irq->msi_desc->irq,
 					NULL,
-					ethsw_irq0_handler_thread,
+					dpaa2_switch_irq0_handler_thread,
 					IRQF_NO_SUSPEND | IRQF_ONESHOT,
 					dev_name(dev), dev);
 	if (err) {
@@ -886,7 +886,7 @@ static int ethsw_setup_irqs(struct fsl_mc_device *sw_dev)
 	return err;
 }
 
-static void ethsw_teardown_irqs(struct fsl_mc_device *sw_dev)
+static void dpaa2_switch_teardown_irqs(struct fsl_mc_device *sw_dev)
 {
 	struct device *dev = &sw_dev->dev;
 	struct ethsw_core *ethsw = dev_get_drvdata(dev);
@@ -900,21 +900,21 @@ static void ethsw_teardown_irqs(struct fsl_mc_device *sw_dev)
 	fsl_mc_free_irqs(sw_dev);
 }
 
-static int port_attr_stp_state_set(struct net_device *netdev,
-				   struct switchdev_trans *trans,
-				   u8 state)
+static int dpaa2_switch_port_attr_stp_state_set(struct net_device *netdev,
+						struct switchdev_trans *trans,
+						u8 state)
 {
 	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
 
 	if (switchdev_trans_ph_prepare(trans))
 		return 0;
 
-	return ethsw_port_set_stp_state(port_priv, state);
+	return dpaa2_switch_port_set_stp_state(port_priv, state);
 }
 
-static int port_attr_br_flags_pre_set(struct net_device *netdev,
-				      struct switchdev_trans *trans,
-				      unsigned long flags)
+static int dpaa2_switch_port_attr_br_flags_pre_set(struct net_device *netdev,
+						   struct switchdev_trans *trans,
+						   unsigned long flags)
 {
 	if (flags & ~(BR_LEARNING | BR_FLOOD))
 		return -EINVAL;
@@ -922,9 +922,9 @@ static int port_attr_br_flags_pre_set(struct net_device *netdev,
 	return 0;
 }
 
-static int port_attr_br_flags_set(struct net_device *netdev,
-				  struct switchdev_trans *trans,
-				  unsigned long flags)
+static int dpaa2_switch_port_attr_br_flags_set(struct net_device *netdev,
+					       struct switchdev_trans *trans,
+					       unsigned long flags)
 {
 	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
 	int err = 0;
@@ -933,35 +933,35 @@ static int port_attr_br_flags_set(struct net_device *netdev,
 		return 0;
 
 	/* Learning is enabled per switch */
-	err = ethsw_set_learning(port_priv->ethsw_data,
-				 !!(flags & BR_LEARNING));
+	err = dpaa2_switch_set_learning(port_priv->ethsw_data,
+					!!(flags & BR_LEARNING));
 	if (err)
 		goto exit;
 
-	err = ethsw_port_set_flood(port_priv, !!(flags & BR_FLOOD));
+	err = dpaa2_switch_port_set_flood(port_priv, !!(flags & BR_FLOOD));
 
 exit:
 	return err;
 }
 
-static int swdev_port_attr_set(struct net_device *netdev,
-			       const struct switchdev_attr *attr,
-			       struct switchdev_trans *trans)
+static int dpaa2_switch_port_attr_set(struct net_device *netdev,
+				      const struct switchdev_attr *attr,
+				      struct switchdev_trans *trans)
 {
 	int err = 0;
 
 	switch (attr->id) {
 	case SWITCHDEV_ATTR_ID_PORT_STP_STATE:
-		err = port_attr_stp_state_set(netdev, trans,
-					      attr->u.stp_state);
+		err = dpaa2_switch_port_attr_stp_state_set(netdev, trans,
+							   attr->u.stp_state);
 		break;
 	case SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS:
-		err = port_attr_br_flags_pre_set(netdev, trans,
-						 attr->u.brport_flags);
+		err = dpaa2_switch_port_attr_br_flags_pre_set(netdev, trans,
+							      attr->u.brport_flags);
 		break;
 	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS:
-		err = port_attr_br_flags_set(netdev, trans,
-					     attr->u.brport_flags);
+		err = dpaa2_switch_port_attr_br_flags_set(netdev, trans,
+							  attr->u.brport_flags);
 		break;
 	case SWITCHDEV_ATTR_ID_BRIDGE_VLAN_FILTERING:
 		/* VLANs are supported by default  */
@@ -974,9 +974,9 @@ static int swdev_port_attr_set(struct net_device *netdev,
 	return err;
 }
 
-static int port_vlans_add(struct net_device *netdev,
-			  const struct switchdev_obj_port_vlan *vlan,
-			  struct switchdev_trans *trans)
+static int dpaa2_switch_port_vlans_add(struct net_device *netdev,
+				       const struct switchdev_obj_port_vlan *vlan,
+				       struct switchdev_trans *trans)
 {
 	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
 	struct ethsw_core *ethsw = port_priv->ethsw_data;
@@ -1004,13 +1004,13 @@ static int port_vlans_add(struct net_device *netdev,
 	for (vid = vlan->vid_begin; vid <= vlan->vid_end; vid++) {
 		if (!port_priv->ethsw_data->vlans[vid]) {
 			/* this is a new VLAN */
-			err = ethsw_add_vlan(port_priv->ethsw_data, vid);
+			err = dpaa2_switch_add_vlan(port_priv->ethsw_data, vid);
 			if (err)
 				return err;
 
 			port_priv->ethsw_data->vlans[vid] |= ETHSW_VLAN_GLOBAL;
 		}
-		err = ethsw_port_add_vlan(port_priv, vid, vlan->flags);
+		err = dpaa2_switch_port_add_vlan(port_priv, vid, vlan->flags);
 		if (err)
 			break;
 	}
@@ -1018,8 +1018,8 @@ static int port_vlans_add(struct net_device *netdev,
 	return err;
 }
 
-static int port_lookup_address(struct net_device *netdev, int is_uc,
-			       const unsigned char *addr)
+static int dpaa2_switch_port_lookup_address(struct net_device *netdev, int is_uc,
+					    const unsigned char *addr)
 {
 	struct netdev_hw_addr_list *list = (is_uc) ? &netdev->uc : &netdev->mc;
 	struct netdev_hw_addr *ha;
@@ -1035,9 +1035,9 @@ static int port_lookup_address(struct net_device *netdev, int is_uc,
 	return 0;
 }
 
-static int port_mdb_add(struct net_device *netdev,
-			const struct switchdev_obj_port_mdb *mdb,
-			struct switchdev_trans *trans)
+static int dpaa2_switch_port_mdb_add(struct net_device *netdev,
+				     const struct switchdev_obj_port_mdb *mdb,
+				     struct switchdev_trans *trans)
 {
 	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
 	int err;
@@ -1046,38 +1046,38 @@ static int port_mdb_add(struct net_device *netdev,
 		return 0;
 
 	/* Check if address is already set on this port */
-	if (port_lookup_address(netdev, 0, mdb->addr))
+	if (dpaa2_switch_port_lookup_address(netdev, 0, mdb->addr))
 		return -EEXIST;
 
-	err = ethsw_port_fdb_add_mc(port_priv, mdb->addr);
+	err = dpaa2_switch_port_fdb_add_mc(port_priv, mdb->addr);
 	if (err)
 		return err;
 
 	err = dev_mc_add(netdev, mdb->addr);
 	if (err) {
 		netdev_err(netdev, "dev_mc_add err %d\n", err);
-		ethsw_port_fdb_del_mc(port_priv, mdb->addr);
+		dpaa2_switch_port_fdb_del_mc(port_priv, mdb->addr);
 	}
 
 	return err;
 }
 
-static int swdev_port_obj_add(struct net_device *netdev,
-			      const struct switchdev_obj *obj,
-			      struct switchdev_trans *trans)
+static int dpaa2_switch_port_obj_add(struct net_device *netdev,
+				     const struct switchdev_obj *obj,
+				     struct switchdev_trans *trans)
 {
 	int err;
 
 	switch (obj->id) {
 	case SWITCHDEV_OBJ_ID_PORT_VLAN:
-		err = port_vlans_add(netdev,
-				     SWITCHDEV_OBJ_PORT_VLAN(obj),
-				     trans);
+		err = dpaa2_switch_port_vlans_add(netdev,
+						  SWITCHDEV_OBJ_PORT_VLAN(obj),
+						  trans);
 		break;
 	case SWITCHDEV_OBJ_ID_PORT_MDB:
-		err = port_mdb_add(netdev,
-				   SWITCHDEV_OBJ_PORT_MDB(obj),
-				   trans);
+		err = dpaa2_switch_port_mdb_add(netdev,
+						SWITCHDEV_OBJ_PORT_MDB(obj),
+						trans);
 		break;
 	default:
 		err = -EOPNOTSUPP;
@@ -1087,7 +1087,7 @@ static int swdev_port_obj_add(struct net_device *netdev,
 	return err;
 }
 
-static int ethsw_port_del_vlan(struct ethsw_port_priv *port_priv, u16 vid)
+static int dpaa2_switch_port_del_vlan(struct ethsw_port_priv *port_priv, u16 vid)
 {
 	struct ethsw_core *ethsw = port_priv->ethsw_data;
 	struct net_device *netdev = port_priv->netdev;
@@ -1098,7 +1098,7 @@ static int ethsw_port_del_vlan(struct ethsw_port_priv *port_priv, u16 vid)
 		return -ENOENT;
 
 	if (port_priv->vlans[vid] & ETHSW_VLAN_PVID) {
-		err = ethsw_port_set_pvid(port_priv, 0);
+		err = dpaa2_switch_port_set_pvid(port_priv, 0);
 		if (err)
 			return err;
 	}
@@ -1136,7 +1136,7 @@ static int ethsw_port_del_vlan(struct ethsw_port_priv *port_priv, u16 vid)
 
 		ethsw->vlans[vid] &= ~ETHSW_VLAN_GLOBAL;
 
-		err = ethsw_dellink_switch(ethsw, vid);
+		err = dpaa2_switch_dellink(ethsw, vid);
 		if (err)
 			return err;
 	}
@@ -1144,8 +1144,8 @@ static int ethsw_port_del_vlan(struct ethsw_port_priv *port_priv, u16 vid)
 	return 0;
 }
 
-static int port_vlans_del(struct net_device *netdev,
-			  const struct switchdev_obj_port_vlan *vlan)
+static int dpaa2_switch_port_vlans_del(struct net_device *netdev,
+				       const struct switchdev_obj_port_vlan *vlan)
 {
 	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
 	int vid, err = 0;
@@ -1154,7 +1154,7 @@ static int port_vlans_del(struct net_device *netdev,
 		return -EOPNOTSUPP;
 
 	for (vid = vlan->vid_begin; vid <= vlan->vid_end; vid++) {
-		err = ethsw_port_del_vlan(port_priv, vid);
+		err = dpaa2_switch_port_del_vlan(port_priv, vid);
 		if (err)
 			break;
 	}
@@ -1162,16 +1162,16 @@ static int port_vlans_del(struct net_device *netdev,
 	return err;
 }
 
-static int port_mdb_del(struct net_device *netdev,
-			const struct switchdev_obj_port_mdb *mdb)
+static int dpaa2_switch_port_mdb_del(struct net_device *netdev,
+				     const struct switchdev_obj_port_mdb *mdb)
 {
 	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
 	int err;
 
-	if (!port_lookup_address(netdev, 0, mdb->addr))
+	if (!dpaa2_switch_port_lookup_address(netdev, 0, mdb->addr))
 		return -ENOENT;
 
-	err = ethsw_port_fdb_del_mc(port_priv, mdb->addr);
+	err = dpaa2_switch_port_fdb_del_mc(port_priv, mdb->addr);
 	if (err)
 		return err;
 
@@ -1184,17 +1184,17 @@ static int port_mdb_del(struct net_device *netdev,
 	return err;
 }
 
-static int swdev_port_obj_del(struct net_device *netdev,
-			      const struct switchdev_obj *obj)
+static int dpaa2_switch_port_obj_del(struct net_device *netdev,
+				     const struct switchdev_obj *obj)
 {
 	int err;
 
 	switch (obj->id) {
 	case SWITCHDEV_OBJ_ID_PORT_VLAN:
-		err = port_vlans_del(netdev, SWITCHDEV_OBJ_PORT_VLAN(obj));
+		err = dpaa2_switch_port_vlans_del(netdev, SWITCHDEV_OBJ_PORT_VLAN(obj));
 		break;
 	case SWITCHDEV_OBJ_ID_PORT_MDB:
-		err = port_mdb_del(netdev, SWITCHDEV_OBJ_PORT_MDB(obj));
+		err = dpaa2_switch_port_mdb_del(netdev, SWITCHDEV_OBJ_PORT_MDB(obj));
 		break;
 	default:
 		err = -EOPNOTSUPP;
@@ -1203,23 +1203,22 @@ static int swdev_port_obj_del(struct net_device *netdev,
 	return err;
 }
 
-static int
-ethsw_switchdev_port_attr_set_event(struct net_device *netdev,
-				    struct switchdev_notifier_port_attr_info
-				    *port_attr_info)
+static int dpaa2_switch_port_attr_set_event(struct net_device *netdev,
+					    struct switchdev_notifier_port_attr_info
+					    *port_attr_info)
 {
 	int err;
 
-	err = swdev_port_attr_set(netdev, port_attr_info->attr,
-				  port_attr_info->trans);
+	err = dpaa2_switch_port_attr_set(netdev, port_attr_info->attr,
+					 port_attr_info->trans);
 
 	port_attr_info->handled = true;
 	return notifier_from_errno(err);
 }
 
 /* For the moment, only flood setting needs to be updated */
-static int port_bridge_join(struct net_device *netdev,
-			    struct net_device *upper_dev)
+static int dpaa2_switch_port_bridge_join(struct net_device *netdev,
+					 struct net_device *upper_dev)
 {
 	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
 	struct ethsw_core *ethsw = port_priv->ethsw_data;
@@ -1237,7 +1236,7 @@ static int port_bridge_join(struct net_device *netdev,
 		}
 
 	netdev_for_each_lower_dev(upper_dev, other_dev, iter) {
-		if (!ethsw_port_dev_check(other_dev, NULL))
+		if (!dpaa2_switch_port_dev_check(other_dev, NULL))
 			continue;
 
 		other_port_priv = netdev_priv(other_dev);
@@ -1249,35 +1248,35 @@ static int port_bridge_join(struct net_device *netdev,
 	}
 
 	/* Enable flooding */
-	err = ethsw_port_set_flood(port_priv, 1);
+	err = dpaa2_switch_port_set_flood(port_priv, 1);
 	if (!err)
 		port_priv->bridge_dev = upper_dev;
 
 	return err;
 }
 
-static int port_bridge_leave(struct net_device *netdev)
+static int dpaa2_switch_port_bridge_leave(struct net_device *netdev)
 {
 	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
 	int err;
 
 	/* Disable flooding */
-	err = ethsw_port_set_flood(port_priv, 0);
+	err = dpaa2_switch_port_set_flood(port_priv, 0);
 	if (!err)
 		port_priv->bridge_dev = NULL;
 
 	return err;
 }
 
-static int port_netdevice_event(struct notifier_block *nb,
-				unsigned long event, void *ptr)
+static int dpaa2_switch_port_netdevice_event(struct notifier_block *nb,
+					     unsigned long event, void *ptr)
 {
 	struct net_device *netdev = netdev_notifier_info_to_dev(ptr);
 	struct netdev_notifier_changeupper_info *info = ptr;
 	struct net_device *upper_dev;
 	int err = 0;
 
-	if (!ethsw_port_dev_check(netdev, nb))
+	if (!dpaa2_switch_port_dev_check(netdev, nb))
 		return NOTIFY_DONE;
 
 	/* Handle just upper dev link/unlink for the moment */
@@ -1285,9 +1284,9 @@ static int port_netdevice_event(struct notifier_block *nb,
 		upper_dev = info->upper_dev;
 		if (netif_is_bridge_master(upper_dev)) {
 			if (info->linking)
-				err = port_bridge_join(netdev, upper_dev);
+				err = dpaa2_switch_port_bridge_join(netdev, upper_dev);
 			else
-				err = port_bridge_leave(netdev);
+				err = dpaa2_switch_port_bridge_leave(netdev);
 		}
 	}
 
@@ -1301,7 +1300,7 @@ struct ethsw_switchdev_event_work {
 	unsigned long event;
 };
 
-static void ethsw_switchdev_event_work(struct work_struct *work)
+static void dpaa2_switch_event_work(struct work_struct *work)
 {
 	struct ethsw_switchdev_event_work *switchdev_work =
 		container_of(work, struct ethsw_switchdev_event_work, work);
@@ -1317,11 +1316,11 @@ static void ethsw_switchdev_event_work(struct work_struct *work)
 		if (!fdb_info->added_by_user)
 			break;
 		if (is_unicast_ether_addr(fdb_info->addr))
-			err = ethsw_port_fdb_add_uc(netdev_priv(dev),
-						    fdb_info->addr);
+			err = dpaa2_switch_port_fdb_add_uc(netdev_priv(dev),
+							   fdb_info->addr);
 		else
-			err = ethsw_port_fdb_add_mc(netdev_priv(dev),
-						    fdb_info->addr);
+			err = dpaa2_switch_port_fdb_add_mc(netdev_priv(dev),
+							   fdb_info->addr);
 		if (err)
 			break;
 		fdb_info->offloaded = true;
@@ -1332,9 +1331,9 @@ static void ethsw_switchdev_event_work(struct work_struct *work)
 		if (!fdb_info->added_by_user)
 			break;
 		if (is_unicast_ether_addr(fdb_info->addr))
-			ethsw_port_fdb_del_uc(netdev_priv(dev), fdb_info->addr);
+			dpaa2_switch_port_fdb_del_uc(netdev_priv(dev), fdb_info->addr);
 		else
-			ethsw_port_fdb_del_mc(netdev_priv(dev), fdb_info->addr);
+			dpaa2_switch_port_fdb_del_mc(netdev_priv(dev), fdb_info->addr);
 		break;
 	}
 
@@ -1345,8 +1344,8 @@ static void ethsw_switchdev_event_work(struct work_struct *work)
 }
 
 /* Called under rcu_read_lock() */
-static int port_switchdev_event(struct notifier_block *nb,
-				unsigned long event, void *ptr)
+static int dpaa2_switch_port_event(struct notifier_block *nb,
+				   unsigned long event, void *ptr)
 {
 	struct net_device *dev = switchdev_notifier_info_to_dev(ptr);
 	struct ethsw_port_priv *port_priv = netdev_priv(dev);
@@ -1354,17 +1353,17 @@ static int port_switchdev_event(struct notifier_block *nb,
 	struct switchdev_notifier_fdb_info *fdb_info = ptr;
 	struct ethsw_core *ethsw = port_priv->ethsw_data;
 
-	if (!ethsw_port_dev_check(dev, nb))
+	if (!dpaa2_switch_port_dev_check(dev, nb))
 		return NOTIFY_DONE;
 
 	if (event == SWITCHDEV_PORT_ATTR_SET)
-		return ethsw_switchdev_port_attr_set_event(dev, ptr);
+		return dpaa2_switch_port_attr_set_event(dev, ptr);
 
 	switchdev_work = kzalloc(sizeof(*switchdev_work), GFP_ATOMIC);
 	if (!switchdev_work)
 		return NOTIFY_BAD;
 
-	INIT_WORK(&switchdev_work->work, ethsw_switchdev_event_work);
+	INIT_WORK(&switchdev_work->work, dpaa2_switch_event_work);
 	switchdev_work->dev = dev;
 	switchdev_work->event = event;
 
@@ -1397,20 +1396,19 @@ static int port_switchdev_event(struct notifier_block *nb,
 	return NOTIFY_BAD;
 }
 
-static int
-ethsw_switchdev_port_obj_event(unsigned long event, struct net_device *netdev,
-			       struct switchdev_notifier_port_obj_info
-			       *port_obj_info)
+static int dpaa2_switch_port_obj_event(unsigned long event,
+				       struct net_device *netdev,
+				       struct switchdev_notifier_port_obj_info *port_obj_info)
 {
 	int err = -EOPNOTSUPP;
 
 	switch (event) {
 	case SWITCHDEV_PORT_OBJ_ADD:
-		err = swdev_port_obj_add(netdev, port_obj_info->obj,
-					 port_obj_info->trans);
+		err = dpaa2_switch_port_obj_add(netdev, port_obj_info->obj,
+						port_obj_info->trans);
 		break;
 	case SWITCHDEV_PORT_OBJ_DEL:
-		err = swdev_port_obj_del(netdev, port_obj_info->obj);
+		err = dpaa2_switch_port_obj_del(netdev, port_obj_info->obj);
 		break;
 	}
 
@@ -1418,45 +1416,45 @@ ethsw_switchdev_port_obj_event(unsigned long event, struct net_device *netdev,
 	return notifier_from_errno(err);
 }
 
-static int port_switchdev_blocking_event(struct notifier_block *nb,
-					 unsigned long event, void *ptr)
+static int dpaa2_switch_port_blocking_event(struct notifier_block *nb,
+					    unsigned long event, void *ptr)
 {
 	struct net_device *dev = switchdev_notifier_info_to_dev(ptr);
 
-	if (!ethsw_port_dev_check(dev, nb))
+	if (!dpaa2_switch_port_dev_check(dev, nb))
 		return NOTIFY_DONE;
 
 	switch (event) {
 	case SWITCHDEV_PORT_OBJ_ADD:
 	case SWITCHDEV_PORT_OBJ_DEL:
-		return ethsw_switchdev_port_obj_event(event, dev, ptr);
+		return dpaa2_switch_port_obj_event(event, dev, ptr);
 	case SWITCHDEV_PORT_ATTR_SET:
-		return ethsw_switchdev_port_attr_set_event(dev, ptr);
+		return dpaa2_switch_port_attr_set_event(dev, ptr);
 	}
 
 	return NOTIFY_DONE;
 }
 
-static int ethsw_register_notifier(struct device *dev)
+static int dpaa2_switch_register_notifier(struct device *dev)
 {
 	struct ethsw_core *ethsw = dev_get_drvdata(dev);
 	int err;
 
-	ethsw->port_nb.notifier_call = port_netdevice_event;
+	ethsw->port_nb.notifier_call = dpaa2_switch_port_netdevice_event;
 	err = register_netdevice_notifier(&ethsw->port_nb);
 	if (err) {
 		dev_err(dev, "Failed to register netdev notifier\n");
 		return err;
 	}
 
-	ethsw->port_switchdev_nb.notifier_call = port_switchdev_event;
+	ethsw->port_switchdev_nb.notifier_call = dpaa2_switch_port_event;
 	err = register_switchdev_notifier(&ethsw->port_switchdev_nb);
 	if (err) {
 		dev_err(dev, "Failed to register switchdev notifier\n");
 		goto err_switchdev_nb;
 	}
 
-	ethsw->port_switchdevb_nb.notifier_call = port_switchdev_blocking_event;
+	ethsw->port_switchdevb_nb.notifier_call = dpaa2_switch_port_blocking_event;
 	err = register_switchdev_blocking_notifier(&ethsw->port_switchdevb_nb);
 	if (err) {
 		dev_err(dev, "Failed to register switchdev blocking notifier\n");
@@ -1472,7 +1470,7 @@ static int ethsw_register_notifier(struct device *dev)
 	return err;
 }
 
-static void ethsw_detect_features(struct ethsw_core *ethsw)
+static void dpaa2_switch_detect_features(struct ethsw_core *ethsw)
 {
 	ethsw->features = 0;
 
@@ -1480,7 +1478,7 @@ static void ethsw_detect_features(struct ethsw_core *ethsw)
 		ethsw->features |= ETHSW_FEATURE_MAC_ADDR;
 }
 
-static int ethsw_init(struct fsl_mc_device *sw_dev)
+static int dpaa2_switch_init(struct fsl_mc_device *sw_dev)
 {
 	struct device *dev = &sw_dev->dev;
 	struct ethsw_core *ethsw = dev_get_drvdata(dev);
@@ -1523,7 +1521,7 @@ static int ethsw_init(struct fsl_mc_device *sw_dev)
 		goto err_close;
 	}
 
-	ethsw_detect_features(ethsw);
+	dpaa2_switch_detect_features(ethsw);
 
 	err = dpsw_reset(ethsw->mc_io, 0, ethsw->dpsw_handle);
 	if (err) {
@@ -1568,7 +1566,7 @@ static int ethsw_init(struct fsl_mc_device *sw_dev)
 		goto err_close;
 	}
 
-	err = ethsw_register_notifier(dev);
+	err = dpaa2_switch_register_notifier(dev);
 	if (err)
 		goto err_destroy_ordered_workqueue;
 
@@ -1582,7 +1580,7 @@ static int ethsw_init(struct fsl_mc_device *sw_dev)
 	return err;
 }
 
-static int ethsw_port_init(struct ethsw_port_priv *port_priv, u16 port)
+static int dpaa2_switch_port_init(struct ethsw_port_priv *port_priv, u16 port)
 {
 	struct net_device *netdev = port_priv->netdev;
 	struct ethsw_core *ethsw = port_priv->ethsw_data;
@@ -1603,7 +1601,7 @@ static int ethsw_port_init(struct ethsw_port_priv *port_priv, u16 port)
 		return err;
 	}
 
-	err = ethsw_port_set_pvid(port_priv, 0);
+	err = dpaa2_switch_port_set_pvid(port_priv, 0);
 	if (err)
 		return err;
 
@@ -1615,7 +1613,7 @@ static int ethsw_port_init(struct ethsw_port_priv *port_priv, u16 port)
 	return err;
 }
 
-static void ethsw_unregister_notifier(struct device *dev)
+static void dpaa2_switch_unregister_notifier(struct device *dev)
 {
 	struct ethsw_core *ethsw = dev_get_drvdata(dev);
 	struct notifier_block *nb;
@@ -1639,20 +1637,20 @@ static void ethsw_unregister_notifier(struct device *dev)
 			"Failed to unregister netdev notifier (%d)\n", err);
 }
 
-static void ethsw_takedown(struct fsl_mc_device *sw_dev)
+static void dpaa2_switch_takedown(struct fsl_mc_device *sw_dev)
 {
 	struct device *dev = &sw_dev->dev;
 	struct ethsw_core *ethsw = dev_get_drvdata(dev);
 	int err;
 
-	ethsw_unregister_notifier(dev);
+	dpaa2_switch_unregister_notifier(dev);
 
 	err = dpsw_close(ethsw->mc_io, 0, ethsw->dpsw_handle);
 	if (err)
 		dev_warn(dev, "dpsw_close err %d\n", err);
 }
 
-static int ethsw_remove(struct fsl_mc_device *sw_dev)
+static int dpaa2_switch_remove(struct fsl_mc_device *sw_dev)
 {
 	struct ethsw_port_priv *port_priv;
 	struct ethsw_core *ethsw;
@@ -1662,7 +1660,7 @@ static int ethsw_remove(struct fsl_mc_device *sw_dev)
 	dev = &sw_dev->dev;
 	ethsw = dev_get_drvdata(dev);
 
-	ethsw_teardown_irqs(sw_dev);
+	dpaa2_switch_teardown_irqs(sw_dev);
 
 	dpsw_disable(ethsw->mc_io, 0, ethsw->dpsw_handle);
 
@@ -1673,7 +1671,7 @@ static int ethsw_remove(struct fsl_mc_device *sw_dev)
 	}
 	kfree(ethsw->ports);
 
-	ethsw_takedown(sw_dev);
+	dpaa2_switch_takedown(sw_dev);
 
 	destroy_workqueue(ethsw->workqueue);
 
@@ -1686,7 +1684,8 @@ static int ethsw_remove(struct fsl_mc_device *sw_dev)
 	return 0;
 }
 
-static int ethsw_probe_port(struct ethsw_core *ethsw, u16 port_idx)
+static int dpaa2_switch_probe_port(struct ethsw_core *ethsw,
+				   u16 port_idx)
 {
 	struct ethsw_port_priv *port_priv;
 	struct device *dev = ethsw->dev;
@@ -1710,18 +1709,18 @@ static int ethsw_probe_port(struct ethsw_core *ethsw, u16 port_idx)
 	port_priv->flood = true;
 
 	SET_NETDEV_DEV(port_netdev, dev);
-	port_netdev->netdev_ops = &ethsw_port_ops;
+	port_netdev->netdev_ops = &dpaa2_switch_port_ops;
 	port_netdev->ethtool_ops = &dpaa2_switch_port_ethtool_ops;
 
 	/* Set MTU limits */
 	port_netdev->min_mtu = ETH_MIN_MTU;
 	port_netdev->max_mtu = ETHSW_MAX_FRAME_LENGTH;
 
-	err = ethsw_port_init(port_priv, port_idx);
+	err = dpaa2_switch_port_init(port_priv, port_idx);
 	if (err)
 		goto err_port_probe;
 
-	err = ethsw_port_set_mac_addr(port_priv);
+	err = dpaa2_switch_port_set_mac_addr(port_priv);
 	if (err)
 		goto err_port_probe;
 
@@ -1741,7 +1740,7 @@ static int ethsw_probe_port(struct ethsw_core *ethsw, u16 port_idx)
 	return err;
 }
 
-static int ethsw_probe(struct fsl_mc_device *sw_dev)
+static int dpaa2_switch_probe(struct fsl_mc_device *sw_dev)
 {
 	struct device *dev = &sw_dev->dev;
 	struct ethsw_core *ethsw;
@@ -1766,7 +1765,7 @@ static int ethsw_probe(struct fsl_mc_device *sw_dev)
 		goto err_free_drvdata;
 	}
 
-	err = ethsw_init(sw_dev);
+	err = dpaa2_switch_init(sw_dev);
 	if (err)
 		goto err_free_cmdport;
 
@@ -1784,7 +1783,7 @@ static int ethsw_probe(struct fsl_mc_device *sw_dev)
 	}
 
 	for (i = 0; i < ethsw->sw_attr.num_ifs; i++) {
-		err = ethsw_probe_port(ethsw, i);
+		err = dpaa2_switch_probe_port(ethsw, i);
 		if (err)
 			goto err_free_ports;
 	}
@@ -1800,7 +1799,7 @@ static int ethsw_probe(struct fsl_mc_device *sw_dev)
 		dpsw_if_disable(ethsw->mc_io, 0, ethsw->dpsw_handle, i);
 
 	/* Setup IRQs */
-	err = ethsw_setup_irqs(sw_dev);
+	err = dpaa2_switch_setup_irqs(sw_dev);
 	if (err)
 		goto err_stop;
 
@@ -1819,7 +1818,7 @@ static int ethsw_probe(struct fsl_mc_device *sw_dev)
 	kfree(ethsw->ports);
 
 err_takedown:
-	ethsw_takedown(sw_dev);
+	dpaa2_switch_takedown(sw_dev);
 
 err_free_cmdport:
 	fsl_mc_portal_free(ethsw->mc_io);
@@ -1831,26 +1830,26 @@ static int ethsw_probe(struct fsl_mc_device *sw_dev)
 	return err;
 }
 
-static const struct fsl_mc_device_id ethsw_match_id_table[] = {
+static const struct fsl_mc_device_id dpaa2_switch_match_id_table[] = {
 	{
 		.vendor = FSL_MC_VENDOR_FREESCALE,
 		.obj_type = "dpsw",
 	},
 	{ .vendor = 0x0 }
 };
-MODULE_DEVICE_TABLE(fslmc, ethsw_match_id_table);
+MODULE_DEVICE_TABLE(fslmc, dpaa2_switch_match_id_table);
 
-static struct fsl_mc_driver eth_sw_drv = {
+static struct fsl_mc_driver dpaa2_switch_drv = {
 	.driver = {
 		.name = KBUILD_MODNAME,
 		.owner = THIS_MODULE,
 	},
-	.probe = ethsw_probe,
-	.remove = ethsw_remove,
-	.match_id_table = ethsw_match_id_table
+	.probe = dpaa2_switch_probe,
+	.remove = dpaa2_switch_remove,
+	.match_id_table = dpaa2_switch_match_id_table
 };
 
-module_fsl_mc_driver(eth_sw_drv);
+module_fsl_mc_driver(dpaa2_switch_drv);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("DPAA2 Ethernet Switch Driver");
-- 
2.28.0

