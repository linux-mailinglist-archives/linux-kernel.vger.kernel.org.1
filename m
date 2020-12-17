Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14DB12DD5A1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 18:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbgLQRBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 12:01:43 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:11232 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727388AbgLQRBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 12:01:40 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BHGveQG014681;
        Thu, 17 Dec 2020 18:00:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=v7E4+SfU1oWMGpqPz035ukFPpBj20RGItKJvqOmkBso=;
 b=nER3jFTUdfG83M+zFEz+enB+1PaYLACRm09lTTIpyjehNrpKx0cYr+ZWtFhE+2XEBnwt
 2DL2p+DlODzh8oMJHeCHpt93OsP4ngakHRo1irHq4V9pKCg0VQzU9XpxBZYnJ23XFSLB
 r3Ax6cC2YnM493n84rvjg/v7tBoiWTcvcS29zSoDDMWPdQjPDZFq+sQd1zgkrQMn1mu6
 h42agx/XNy+eWXGCCvSBA6QL8HLsNGwbIhpyysTLY61pqA/5lgL9TbtdDulh8Fd6AACs
 3ZR5vZK9f6xB6pM5GcrLj9EHD1aMK+zGlZmKLQgKMe23c0+Px0MbeRE76dnLohDV/jJz Bw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 35cq038vc7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Dec 2020 18:00:55 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 931AF100034;
        Thu, 17 Dec 2020 18:00:54 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 89BFB25AAE1;
        Thu, 17 Dec 2020 18:00:54 +0100 (CET)
Received: from localhost (10.75.127.51) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 17 Dec 2020 18:00:54
 +0100
From:   <patrice.chotard@foss.st.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH 1/2] MAINTAINERS: Update some st.com email addresses to foss.st.com
Date:   Thu, 17 Dec 2020 18:00:43 +0100
Message-ID: <20201217170044.12061-2-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201217170044.12061-1-patrice.chotard@foss.st.com>
References: <20201217170044.12061-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-17_11:2020-12-15,2020-12-17 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrice Chotard <patrice.chotard@foss.st.com>

Update some st.com to foss.st.com addresses related to STMicroelectronics
drivers. All these people will now use this new email address for upstream
activities.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 MAINTAINERS | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 281de213ef47..685b72a22cee 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2497,7 +2497,7 @@ N:	sc27xx
 N:	sc2731
 
 ARM/STI ARCHITECTURE
-M:	Patrice Chotard <patrice.chotard@st.com>
+M:	Patrice Chotard <patrice.chotard@foss.st.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 W:	http://www.stlinux.com
@@ -2530,7 +2530,7 @@ F:	include/linux/remoteproc/st_slim_rproc.h
 
 ARM/STM32 ARCHITECTURE
 M:	Maxime Coquelin <mcoquelin.stm32@gmail.com>
-M:	Alexandre Torgue <alexandre.torgue@st.com>
+M:	Alexandre Torgue <alexandre.torgue@foss.st.com>
 L:	linux-stm32@st-md-mailman.stormreply.com (moderated for non-subscribers)
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
@@ -3143,7 +3143,7 @@ C:	irc://irc.oftc.net/bcache
 F:	drivers/md/bcache/
 
 BDISP ST MEDIA DRIVER
-M:	Fabien Dessenne <fabien.dessenne@st.com>
+M:	Fabien Dessenne <fabien.dessenne@foss.st.com>
 L:	linux-media@vger.kernel.org
 S:	Supported
 W:	https://linuxtv.org
@@ -5007,7 +5007,7 @@ S:	Maintained
 F:	drivers/platform/x86/dell-wmi.c
 
 DELTA ST MEDIA DRIVER
-M:	Hugues Fruchet <hugues.fruchet@st.com>
+M:	Hugues Fruchet <hugues.fruchet@foss.st.com>
 L:	linux-media@vger.kernel.org
 S:	Supported
 W:	https://linuxtv.org
@@ -5921,8 +5921,8 @@ F:	Documentation/devicetree/bindings/display/st,stih4xx.txt
 F:	drivers/gpu/drm/sti
 
 DRM DRIVERS FOR STM
-M:	Yannick Fertre <yannick.fertre@st.com>
-M:	Philippe Cornu <philippe.cornu@st.com>
+M:	Yannick Fertre <yannick.fertre@foss.st.com>
+M:	Philippe Cornu <philippe.cornu@foss.st.com>
 M:	Benjamin Gaignard <benjamin.gaignard@linaro.org>
 M:	Vincent Abriou <vincent.abriou@st.com>
 L:	dri-devel@lists.freedesktop.org
@@ -8116,7 +8116,7 @@ F:	include/linux/hugetlb.h
 F:	mm/hugetlb.c
 
 HVA ST MEDIA DRIVER
-M:	Jean-Christophe Trotin <jean-christophe.trotin@st.com>
+M:	Jean-Christophe Trotin <jean-christophe.trotin@foss.st.com>
 L:	linux-media@vger.kernel.org
 S:	Supported
 W:	https://linuxtv.org
@@ -10972,7 +10972,7 @@ T:	git git://linuxtv.org/media_tree.git
 F:	drivers/media/dvb-frontends/stv6111*
 
 MEDIA DRIVERS FOR STM32 - DCMI
-M:	Hugues Fruchet <hugues.fruchet@st.com>
+M:	Hugues Fruchet <hugues.fruchet@foss.st.com>
 L:	linux-media@vger.kernel.org
 S:	Supported
 T:	git git://linuxtv.org/media_tree.git
@@ -16567,7 +16567,7 @@ F:	Documentation/devicetree/bindings/media/i2c/st,st-mipid02.txt
 F:	drivers/media/i2c/st-mipid02.c
 
 ST STM32 I2C/SMBUS DRIVER
-M:	Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
+M:	Pierre-Yves MORDRET <pierre-yves.mordret@foss.st.com>
 L:	linux-i2c@vger.kernel.org
 S:	Maintained
 F:	drivers/i2c/busses/i2c-stm32*
@@ -16682,7 +16682,7 @@ S:	Maintained
 F:	drivers/block/skd*[ch]
 
 STI AUDIO (ASoC) DRIVERS
-M:	Arnaud Pouliquen <arnaud.pouliquen@st.com>
+M:	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt
@@ -16702,15 +16702,15 @@ T:	git git://linuxtv.org/media_tree.git
 F:	drivers/media/usb/stk1160/
 
 STM32 AUDIO (ASoC) DRIVERS
-M:	Olivier Moysan <olivier.moysan@st.com>
-M:	Arnaud Pouliquen <arnaud.pouliquen@st.com>
+M:	Olivier Moysan <olivier.moysan@foss.st.com>
+M:	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/sound/st,stm32-*.txt
 F:	sound/soc/stm/
 
 STM32 TIMER/LPTIMER DRIVERS
-M:	Fabrice Gasnier <fabrice.gasnier@st.com>
+M:	Fabrice Gasnier <fabrice.gasnier@foss.st.com>
 S:	Maintained
 F:	Documentation/ABI/testing/*timer-stm32
 F:	Documentation/devicetree/bindings/*/*stm32-*timer*
@@ -16720,7 +16720,7 @@ F:	include/linux/*/stm32-*tim*
 
 STMMAC ETHERNET DRIVER
 M:	Giuseppe Cavallaro <peppe.cavallaro@st.com>
-M:	Alexandre Torgue <alexandre.torgue@st.com>
+M:	Alexandre Torgue <alexandre.torgue@foss.st.com>
 M:	Jose Abreu <joabreu@synopsys.com>
 L:	netdev@vger.kernel.org
 S:	Supported
-- 
2.17.1

