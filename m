Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43C6C278AB0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 16:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbgIYOQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 10:16:37 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:32014 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727733AbgIYOQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 10:16:36 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08PECell020376;
        Fri, 25 Sep 2020 16:16:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=FhgKpihRju6KwvA2I7sLOgchQYgMunlC1jVEupShDnU=;
 b=fxYWpL8GHnEWyOQ90cu/3CJgMpZ2N+MjcgrUFu4oVOTxdioh9aZR7PdfIls1ZG2kvOcm
 ZgdKrIKCZKE1MuHKddByQe42PHlRcd7N2T15u63svEgGFvjtVnhSDhyuSv0/Af62Dq7L
 zWsdwGZFoxm8iCVmjfj4V+JDq/uh3OaGZUIZpE0ywWSukzGAzCha3xVF6qF4Txs3m75Y
 MrZj03AXQwqcy9pKYrmdYnjjq/Ufu9eEuCHpHJUZlp3y2sCuEi5PSUvcsx/i4gek9bma
 7ojIqzMDQIXI5B+KUeNjbxOher11q+59867cjK7j3Gh9iahKT7kv3L6QXReQfg35H9Da /A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 33n7rwaq4m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Sep 2020 16:16:26 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7C62210002A;
        Fri, 25 Sep 2020 16:16:25 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5B6632BA2C0;
        Fri, 25 Sep 2020 16:16:25 +0200 (CEST)
Received: from localhost (10.75.127.48) by SFHDAG6NODE1.st.com (10.75.127.16)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 25 Sep 2020 16:16:24
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
Subject: [PATCH] drm/panel: rm68200: fix mode to 50fps
Date:   Fri, 25 Sep 2020 16:16:18 +0200
Message-ID: <20200925141618.12097-1-yannick.fertre@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG5NODE2.st.com (10.75.127.14) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-25_12:2020-09-24,2020-09-25 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compute new timings to get a framerate of 50fps with a pixel clock
@54Mhz.

Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
---
 drivers/gpu/drm/panel/panel-raydium-rm68200.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-raydium-rm68200.c b/drivers/gpu/drm/panel/panel-raydium-rm68200.c
index 2b9e48b0a491..412c0dbcb2b6 100644
--- a/drivers/gpu/drm/panel/panel-raydium-rm68200.c
+++ b/drivers/gpu/drm/panel/panel-raydium-rm68200.c
@@ -82,15 +82,15 @@ struct rm68200 {
 };
 
 static const struct drm_display_mode default_mode = {
-	.clock = 52582,
+	.clock = 54000,
 	.hdisplay = 720,
-	.hsync_start = 720 + 38,
-	.hsync_end = 720 + 38 + 8,
-	.htotal = 720 + 38 + 8 + 38,
+	.hsync_start = 720 + 48,
+	.hsync_end = 720 + 48 + 9,
+	.htotal = 720 + 48 + 9 + 48,
 	.vdisplay = 1280,
 	.vsync_start = 1280 + 12,
-	.vsync_end = 1280 + 12 + 4,
-	.vtotal = 1280 + 12 + 4 + 12,
+	.vsync_end = 1280 + 12 + 5,
+	.vtotal = 1280 + 12 + 5 + 12,
 	.flags = 0,
 	.width_mm = 68,
 	.height_mm = 122,
-- 
2.17.1

