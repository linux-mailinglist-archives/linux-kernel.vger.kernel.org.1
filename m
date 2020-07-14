Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E242821F2BF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 15:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbgGNNfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 09:35:23 -0400
Received: from inva021.nxp.com ([92.121.34.21]:48266 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728200AbgGNNfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 09:35:18 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5F0CE201024;
        Tue, 14 Jul 2020 15:35:16 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 52B032001B2;
        Tue, 14 Jul 2020 15:35:16 +0200 (CEST)
Received: from fsr-ub1864-126.ea.freescale.net (fsr-ub1864-126.ea.freescale.net [10.171.82.212])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 128A6205A4;
        Tue, 14 Jul 2020 15:35:16 +0200 (CEST)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 4/6] staging: dpaa2-ethsw: disable switch ports are probe time
Date:   Tue, 14 Jul 2020 16:34:29 +0300
Message-Id: <20200714133431.17532-5-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200714133431.17532-1-ioana.ciornei@nxp.com>
References: <20200714133431.17532-1-ioana.ciornei@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MC firmware will enable the switch interfaces at DPSW creation
without waiting for an 'ifconfig up' on the switch interfaces. When this
happens, the states held by the Linux software vs the firmware are not
in sync. Make sure to disable the switch ports at probe time to not
encounter this issue.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index a1917842536e..f283ce195c1e 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -1672,6 +1672,10 @@ static int ethsw_probe(struct fsl_mc_device *sw_dev)
 		goto err_free_ports;
 	}
 
+	/* Make sure the switch ports are disabled at probe time */
+	for (i = 0; i < ethsw->sw_attr.num_ifs; i++)
+		dpsw_if_disable(ethsw->mc_io, 0, ethsw->dpsw_handle, i);
+
 	/* Setup IRQs */
 	err = ethsw_setup_irqs(sw_dev);
 	if (err)
-- 
2.25.1

