Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13A4F227B91
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 11:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729003AbgGUJTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 05:19:52 -0400
Received: from inva021.nxp.com ([92.121.34.21]:56062 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727048AbgGUJTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 05:19:33 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7376D200464;
        Tue, 21 Jul 2020 11:19:32 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 675CA20044D;
        Tue, 21 Jul 2020 11:19:32 +0200 (CEST)
Received: from fsr-ub1864-126.ea.freescale.net (fsr-ub1864-126.ea.freescale.net [10.171.82.212])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 29294202A9;
        Tue, 21 Jul 2020 11:19:32 +0200 (CEST)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 4/6] staging: dpaa2-ethsw: destroy workqueue after deregistering the notifiers
Date:   Tue, 21 Jul 2020 12:19:17 +0300
Message-Id: <20200721091919.20394-5-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200721091919.20394-1-ioana.ciornei@nxp.com>
References: <20200721091919.20394-1-ioana.ciornei@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should destroy the switch workqueue only after deregistering the
switchdev notifiers. Without this fix, we could end up with switchdev
notifications on a draining workqueue and also with a lock up since the
netdevice reference count is increased (in port_switchdev_event) and not
decreased ever (since the workqueue did not run).

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index 83e6bd4a803b..9114437645a8 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -1628,8 +1628,6 @@ static int ethsw_remove(struct fsl_mc_device *sw_dev)
 
 	ethsw_teardown_irqs(sw_dev);
 
-	destroy_workqueue(ethsw->workqueue);
-
 	dpsw_disable(ethsw->mc_io, 0, ethsw->dpsw_handle);
 
 	for (i = 0; i < ethsw->sw_attr.num_ifs; i++) {
@@ -1640,6 +1638,9 @@ static int ethsw_remove(struct fsl_mc_device *sw_dev)
 	kfree(ethsw->ports);
 
 	ethsw_takedown(sw_dev);
+
+	destroy_workqueue(ethsw->workqueue);
+
 	fsl_mc_portal_free(ethsw->mc_io);
 
 	kfree(ethsw);
-- 
2.25.1

