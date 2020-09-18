Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58E4A26FCB2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 14:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgIRMjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 08:39:02 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:26556 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726129AbgIRMjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 08:39:02 -0400
X-Greylist: delayed 3083 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Sep 2020 08:39:00 EDT
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08IBbjg1026256;
        Fri, 18 Sep 2020 13:46:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=Hu/KSWEoWh4NPDwl+w3TG7Q+/qxEmxQMay9Dl+q9Ji4=;
 b=uSOH8OVesdownjxiiwWFEAFOHHPSYcjRrOCWL396RG2ZW/gKGVxcrMH7POE3Ul2WeiGk
 HXvyAH7Ljy/ofjzOU9MzeE2jwvuViCNhH1035ioFFf++f/O+PZH54O9KEL11tNrfyPIw
 c8owI0lXr3ueOfGrqdq4aaCL5MF25o4NtFv/5XaSTnKa5NZMTByBjbcBRbK9wIN4Lkf5
 ApF9patl2d/D46tYY4uPTHCpxdTn9+t08vmQZAmSOQ/R+pwz77/AdY9EwdOL96VxHpf+
 O4UGfXvrODHZXucajilNsF7E5WQ88bAQxfPFWU86xBAjLvzguxnK/K37B/qm2Ux7LLs4 vw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 33k691qvpj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Sep 2020 13:46:57 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BE0FA10002A;
        Fri, 18 Sep 2020 13:46:56 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9A4212B4D32;
        Fri, 18 Sep 2020 13:46:56 +0200 (CEST)
Received: from localhost (10.75.127.44) by SFHDAG6NODE1.st.com (10.75.127.16)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 18 Sep 2020 13:46:55
 +0200
From:   Yannick Fertre <yannick.fertre@st.com>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philippe Cornu <philippe.cornu@st.com>,
        Antonio Borneo <antonio.borneo@st.com>,
        Yannick Fertre <yannick.fertre@st.com>,
        Angelo Ribeiro <Angelo.Ribeiro@synopsys.com>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Markus Elfring <elfring@users.sourceforge.net>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/bridge/synopsys: dsi: fix initialization sequence
Date:   Fri, 18 Sep 2020 13:46:53 +0200
Message-ID: <20200918114653.10932-1-yannick.fertre@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG8NODE2.st.com (10.75.127.23) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-18_14:2020-09-16,2020-09-18 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current driver calls drm_bridge_add(), to add the dsi bridge
to the global bridge list, in dw_mipi_dsi_host_attach().
Thus, it relies on the probing of panel or bridge sub-nodes to
trigger the execution of dsi host attach() that will, in turn,
call dw_mipi_dsi_host_attach().
This causes an incomplete driver initialization if the panel or
the next bridge is not present as sub-node, e.g. because it is an
i2c device, thus sub-node of the respective i2c controller.

Move the relevant code from host attach() to probe(), and the
corresponding code from detach() to remove().

Signed-off-by: Antonio Borneo <antonio.borneo@st.com>
Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 73 ++++++++++++-------
 1 file changed, 48 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
index 6b268f9445b3..aa74abddc79f 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
@@ -314,9 +314,7 @@ static int dw_mipi_dsi_host_attach(struct mipi_dsi_host *host,
 {
 	struct dw_mipi_dsi *dsi = host_to_dsi(host);
 	const struct dw_mipi_dsi_plat_data *pdata = dsi->plat_data;
-	struct drm_bridge *bridge;
-	struct drm_panel *panel;
-	int ret;
+	int ret = -ENODEV;
 
 	if (device->lanes > dsi->plat_data->max_data_lanes) {
 		dev_err(dsi->dev, "the number of data lanes(%u) is too many\n",
@@ -329,22 +327,6 @@ static int dw_mipi_dsi_host_attach(struct mipi_dsi_host *host,
 	dsi->format = device->format;
 	dsi->mode_flags = device->mode_flags;
 
-	ret = drm_of_find_panel_or_bridge(host->dev->of_node, 1, 0,
-					  &panel, &bridge);
-	if (ret)
-		return ret;
-
-	if (panel) {
-		bridge = drm_panel_bridge_add_typed(panel,
-						    DRM_MODE_CONNECTOR_DSI);
-		if (IS_ERR(bridge))
-			return PTR_ERR(bridge);
-	}
-
-	dsi->panel_bridge = bridge;
-
-	drm_bridge_add(&dsi->bridge);
-
 	if (pdata->host_ops && pdata->host_ops->attach) {
 		ret = pdata->host_ops->attach(pdata->priv_data, device);
 		if (ret < 0)
@@ -367,10 +349,6 @@ static int dw_mipi_dsi_host_detach(struct mipi_dsi_host *host,
 			return ret;
 	}
 
-	drm_of_panel_bridge_remove(host->dev->of_node, 1, 0);
-
-	drm_bridge_remove(&dsi->bridge);
-
 	return 0;
 }
 
@@ -1105,6 +1083,9 @@ __dw_mipi_dsi_probe(struct platform_device *pdev,
 	struct device *dev = &pdev->dev;
 	struct reset_control *apb_rst;
 	struct dw_mipi_dsi *dsi;
+	struct drm_bridge *bridge;
+	struct drm_panel *panel;
+	int i, nb_endpoints;
 	int ret;
 
 	dsi = devm_kzalloc(dev, sizeof(*dsi), GFP_KERNEL);
@@ -1172,8 +1153,7 @@ __dw_mipi_dsi_probe(struct platform_device *pdev,
 	ret = mipi_dsi_host_register(&dsi->dsi_host);
 	if (ret) {
 		dev_err(dev, "Failed to register MIPI host: %d\n", ret);
-		dw_mipi_dsi_debugfs_remove(dsi);
-		return ERR_PTR(ret);
+		goto err_pmr_enable;
 	}
 
 	dsi->bridge.driver_private = dsi;
@@ -1182,11 +1162,54 @@ __dw_mipi_dsi_probe(struct platform_device *pdev,
 	dsi->bridge.of_node = pdev->dev.of_node;
 #endif
 
+	/* Get number of endpoints */
+	nb_endpoints = of_graph_get_endpoint_count(pdev->dev.of_node);
+	if (!nb_endpoints) {
+		ret = -ENODEV;
+		goto err_host_reg;
+	}
+
+	for (i = 1; i < nb_endpoints; i++) {
+		ret = drm_of_find_panel_or_bridge(pdev->dev.of_node, i, 0,
+						  &panel, &bridge);
+		if (!ret)
+			break;
+		else if (ret == -EPROBE_DEFER)
+			goto err_host_reg;
+	}
+
+	/* check if an error is returned >> no panel or bridge detected */
+	if (ret)
+		goto err_host_reg;
+
+	if (panel) {
+		bridge = drm_panel_bridge_add_typed(panel, DRM_MODE_CONNECTOR_DSI);
+		if (IS_ERR(bridge)) {
+			ret = PTR_ERR(bridge);
+			goto err_host_reg;
+		}
+	}
+
+	dsi->panel_bridge = bridge;
+
+	drm_bridge_add(&dsi->bridge);
+
 	return dsi;
+
+err_host_reg:
+	mipi_dsi_host_unregister(&dsi->dsi_host);
+
+err_pmr_enable:
+	pm_runtime_disable(dev);
+	dw_mipi_dsi_debugfs_remove(dsi);
+
+	return ERR_PTR(ret);
 }
 
 static void __dw_mipi_dsi_remove(struct dw_mipi_dsi *dsi)
 {
+	drm_bridge_remove(&dsi->bridge);
+	drm_panel_bridge_remove(dsi->panel_bridge);
 	mipi_dsi_host_unregister(&dsi->dsi_host);
 
 	pm_runtime_disable(dsi->dev);
-- 
2.17.1

