Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83BE41D99D6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 16:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbgESOcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 10:32:55 -0400
Received: from inva020.nxp.com ([92.121.34.13]:37934 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbgESOcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 10:32:53 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 40ECB1A01B5;
        Tue, 19 May 2020 16:32:52 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3270C1A01B1;
        Tue, 19 May 2020 16:32:52 +0200 (CEST)
Received: from fsr-ub1864-126.ea.freescale.net (fsr-ub1864-126.ea.freescale.net [10.171.82.212])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id D347E203CE;
        Tue, 19 May 2020 16:32:51 +0200 (CEST)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH] staging: dpaa2-ethsw: fix reported link state
Date:   Tue, 19 May 2020 17:32:36 +0300
Message-Id: <20200519143236.21927-1-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.17.1
Reply-to: ioana.ciornei@nxp.com
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the .ndo_open() callback set netif_carrier_off() until the link state
interrupt is received so that the LOWER_UP flag does not show up
incorrectly in the output of 'ip link show'.

Fixes: 44baaa43d7cc ("staging: fsl-dpaa2/ethsw: Add Freescale DPAA2 Ethernet Switch driver")
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index 676d1ad1b50d..709ae937ac2f 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -473,6 +473,13 @@ static int port_open(struct net_device *netdev)
 	/* No need to allow Tx as control interface is disabled */
 	netif_tx_stop_all_queues(netdev);
 
+	/* Explicitly set carrier off, otherwise
+	 * netif_carrier_ok() will return true and cause 'ip link show'
+	 * to report the LOWER_UP flag, even though the link
+	 * notification wasn't even received.
+	 */
+	netif_carrier_off(netdev);
+
 	err = dpsw_if_enable(port_priv->ethsw_data->mc_io, 0,
 			     port_priv->ethsw_data->dpsw_handle,
 			     port_priv->idx);
-- 
2.17.1

