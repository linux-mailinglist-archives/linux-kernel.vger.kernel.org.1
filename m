Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B01826FC2B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 14:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgIRMKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 08:10:44 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:1465 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725955AbgIRMKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 08:10:38 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08IBaoSF026236;
        Fri, 18 Sep 2020 13:47:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=tjGetrJ4yp9Hd8vvDB1jD/Rg6jS8AAgizkiixAESV2U=;
 b=FHyI4v/Z1kT4+8ImNCVWx2mVHTa5fjehbXCfHO+4EG2z33aH2pmB+y+zjNwihwG3jWFQ
 Dg/Ljx0Svqsg1lYBRwLOa2OIJfwaZsS8UTBPeZo2pPDDk845me2hV2x9PR3raxDVkQnD
 EUKqHFHVCqMABbR/2/QGlmat29o2D0fNzmmHuIzzYZnKNeKSlTg8SmAZqYlY7Yp8U6ae
 1bxUthjKmM++lLkOdv0EEaiEDqU/P+HSNud0GtpXk4U3VZcYcbfEJNqGUbo4WKmffgiz
 OIvnHefvtFrpcB46MIXuJrKqWXm/+mmnGiA8prZ++1duYBqAcxG/NSalYstel5OcPIrK aw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 33k67c0s9w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Sep 2020 13:47:30 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AEEAD100034;
        Fri, 18 Sep 2020 13:47:29 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 77E10222CE8;
        Fri, 18 Sep 2020 13:47:29 +0200 (CEST)
Received: from localhost (10.75.127.46) by SFHDAG6NODE1.st.com (10.75.127.16)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 18 Sep 2020 13:47:28
 +0200
From:   Yannick Fertre <yannick.fertre@st.com>
To:     Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Antonio Borneo <antonio.borneo@st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/panel: otm8009a: allow using non-continuous dsi clock
Date:   Fri, 18 Sep 2020 13:47:26 +0200
Message-ID: <20200918114726.11188-1-yannick.fertre@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG5NODE3.st.com (10.75.127.15) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-18_14:2020-09-16,2020-09-18 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Antonio Borneo <antonio.borneo@st.com>

The panel is able to work when dsi clock is non-continuous, thus
the system power consumption can be reduced using such feature.

Add MIPI_DSI_CLOCK_NON_CONTINUOUS to panel's mode_flags.

Signed-off-by: Antonio Borneo <antonio.borneo@st.com>
---
 drivers/gpu/drm/panel/panel-orisetech-otm8009a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c b/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
index b6e377aa1131..6ac1accade80 100644
--- a/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
+++ b/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
@@ -452,7 +452,7 @@ static int otm8009a_probe(struct mipi_dsi_device *dsi)
 	dsi->lanes = 2;
 	dsi->format = MIPI_DSI_FMT_RGB888;
 	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
-			  MIPI_DSI_MODE_LPM;
+			  MIPI_DSI_MODE_LPM | MIPI_DSI_CLOCK_NON_CONTINUOUS;
 
 	drm_panel_init(&ctx->panel, dev, &otm8009a_drm_funcs,
 		       DRM_MODE_CONNECTOR_DSI);
-- 
2.17.1

