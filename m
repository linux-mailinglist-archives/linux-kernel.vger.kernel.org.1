Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7FFB26FCB9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 14:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbgIRMkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 08:40:14 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:9722 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726121AbgIRMkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 08:40:10 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08IBc0g3028190;
        Fri, 18 Sep 2020 13:47:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=6pOVws/I6cfHaGqYL8/y2lOPLnCLBYUUlSxVz/K1gjM=;
 b=e9strKYH1RVbhGaSdNeP0lL68WlXd+P0e9ZElZby+ED7SUMgXfMlGEc2h+PHRIH4EVEJ
 IHhALjste9W9q+YXbNCHU/pQtReSUwf/hma3pNSr8F/4bL/FDbMdpD0Q5riqAxJLH8Vn
 hhYzL9Ab+tiAr60XpD+9xNdJC7281ISlS5G1whOcxAu83fN6sJ6EYaeQtIvdyiLg6QBs
 Xu+vWAgvLFOCpbLVxudNiyETP21FLMldYPqcWboDXIvI9GQuiaf614Qr7pYG5woRV5aM
 aEVJ87qT6eDb4DXwpK25glBIGS7Q+rDD2MQ3lQ0V3j+5tsRVPbqSB70vvn9GSyU+jQkJ tg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 33k695qtvc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Sep 2020 13:47:42 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7127810002A;
        Fri, 18 Sep 2020 13:47:42 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7754021FEB3;
        Fri, 18 Sep 2020 13:47:39 +0200 (CEST)
Received: from localhost (10.75.127.47) by SFHDAG6NODE1.st.com (10.75.127.16)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 18 Sep 2020 13:47:38
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
Subject: [PATCH] drm/panel: rm68200: allow using non-continuous dsi clock
Date:   Fri, 18 Sep 2020 13:47:36 +0200
Message-ID: <20200918114736.11322-1-yannick.fertre@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-18_14:2020-09-16,2020-09-18 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The panel is able to work when dsi clock is non-continuous, thus
the system power consumption can be reduced using such feature.

Add MIPI_DSI_CLOCK_NON_CONTINUOUS to panel's mode_flags.

Signed-off-by: Antonio Borneo <antonio.borneo@st.com>
Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
---
 drivers/gpu/drm/panel/panel-raydium-rm68200.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-raydium-rm68200.c b/drivers/gpu/drm/panel/panel-raydium-rm68200.c
index f908eeafb1af..2b9e48b0a491 100644
--- a/drivers/gpu/drm/panel/panel-raydium-rm68200.c
+++ b/drivers/gpu/drm/panel/panel-raydium-rm68200.c
@@ -391,7 +391,7 @@ static int rm68200_probe(struct mipi_dsi_device *dsi)
 	dsi->lanes = 2;
 	dsi->format = MIPI_DSI_FMT_RGB888;
 	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
-			  MIPI_DSI_MODE_LPM;
+			  MIPI_DSI_MODE_LPM | MIPI_DSI_CLOCK_NON_CONTINUOUS;
 
 	drm_panel_init(&ctx->panel, dev, &rm68200_drm_funcs,
 		       DRM_MODE_CONNECTOR_DSI);
-- 
2.17.1

