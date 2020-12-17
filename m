Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80B6E2DD5A2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 18:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbgLQRBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 12:01:47 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:59386 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726773AbgLQRBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 12:01:39 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BHGvWpM002507;
        Thu, 17 Dec 2020 18:00:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=T+pS0I5znHYfC4osHui4ytbDqcO9jybXlXCJRJV+/+s=;
 b=XzN16XHusFyG/PVBR+qIBEzfvG9Vjc42VQdaK7KxLADjQEovaGx1oE9oiGgSBU+79G62
 3G2j8pHSvGbQ6A16FOt0s+7NbqeXktOHBdqiiKAlpk9wvApHL0Sp4I7XjVKfo3bblDJn
 u1aRrQmpMWVewixHJ1/kQd0JrXj9gsWindSpPAGJXFr3RUf3Zp54VYPioSh4VJFgcgTw
 XYE2RYniwZMrvejHuIvYpJuBycW/C7c/v5bbKfG2Tk3hbSbRk/WTNyWsXLFC25/AWb4u
 7oeBeAlo1ZIFsV9ow+S+dNOp0ukp/HpTUdWGeaaELEV0fJo4DAyhuOKWBWb/WVz36gNs 5A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 35cpwegwhu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Dec 2020 18:00:55 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6272710002A;
        Thu, 17 Dec 2020 18:00:55 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 59BF325AAE1;
        Thu, 17 Dec 2020 18:00:55 +0100 (CET)
Received: from localhost (10.75.127.50) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 17 Dec 2020 18:00:54
 +0100
From:   <patrice.chotard@foss.st.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Vincent Abriou <vincent.abriou@st.com>
Subject: [PATCH 2/2] MAINTAINERS: Remove Vincent Abriou for STM/STI DRM drivers.
Date:   Thu, 17 Dec 2020 18:00:44 +0100
Message-ID: <20201217170044.12061-3-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201217170044.12061-1-patrice.chotard@foss.st.com>
References: <20201217170044.12061-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG4NODE3.st.com (10.75.127.12) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-17_11:2020-12-15,2020-12-17 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrice Chotard <patrice.chotard@foss.st.com>

Remove Vincent Abriou's email as he has no more review activities on
STM/STI DRM drivers.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Vincent Abriou <vincent.abriou@st.com>
---
 MAINTAINERS | 2 --
 1 file changed, 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 685b72a22cee..010160a89a10 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5913,7 +5913,6 @@ F:	drivers/gpu/drm/rockchip/
 
 DRM DRIVERS FOR STI
 M:	Benjamin Gaignard <benjamin.gaignard@linaro.org>
-M:	Vincent Abriou <vincent.abriou@st.com>
 L:	dri-devel@lists.freedesktop.org
 S:	Maintained
 T:	git git://anongit.freedesktop.org/drm/drm-misc
@@ -5924,7 +5923,6 @@ DRM DRIVERS FOR STM
 M:	Yannick Fertre <yannick.fertre@foss.st.com>
 M:	Philippe Cornu <philippe.cornu@foss.st.com>
 M:	Benjamin Gaignard <benjamin.gaignard@linaro.org>
-M:	Vincent Abriou <vincent.abriou@st.com>
 L:	dri-devel@lists.freedesktop.org
 S:	Maintained
 T:	git git://anongit.freedesktop.org/drm/drm-misc
-- 
2.17.1

