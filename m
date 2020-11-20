Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 375602BA5BE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 10:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbgKTJQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 04:16:36 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:48609 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727185AbgKTJQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 04:16:34 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AK9Blqd012545;
        Fri, 20 Nov 2020 10:15:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=R/vYxilZj+dFFN/UrLsX4aZGw1rVzm4efQsXjf2WTUM=;
 b=Gn+BkJmpEZYiJ89gbWVEOtTpmXfBUNMfyA5v0JpYC+fWQOeF4oZQ8Q3+lFTgvQ2BCoE6
 SEUw5RQA2NdamyDh70K2tGzzeyzyipk3l1Cu14iKW5uSe+Qr5XdWDBQUax+kMfdCbtJm
 r5a5ndGTircPEkSwoxOxPqkjCxsBn0pvzC1GpV9Z5Eb06jXC9vODQEVx2WiQo2q0d/v3
 1T/eupB++iXfIJD+QFl+DZ1/FE3bJ0s0iJcGUeYA96URQDcxNNbGVJsziVM5hqU6DD9F
 /q+Lb0ohTff5RieGLw1din76vVl5w60FIpVJYmxhHWcHrFj/ZleanKIUKGYv/rpNPD1T 9Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34x70msbn2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Nov 2020 10:15:12 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 37036100038;
        Fri, 20 Nov 2020 10:15:12 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 18187236075;
        Fri, 20 Nov 2020 10:15:12 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 20 Nov 2020 10:15:11
 +0100
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <linux@armlinux.org.uk>, <shawnguo@kernel.org>, <olof@lixom.net>,
        <alexandre.torgue@st.com>, <krzk@kernel.org>,
        <geert+renesas@glider.be>, <amelie.delaunay@st.com>,
        <aisheng.dong@nxp.com>, <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <christian.gmeiner@gmail.com>, <enric.balletbo@collabora.com>,
        <lionel.debieve@st.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <olivier.moysan@st.com>
Subject: [PATCH v2 2/2] ARM: multi_v7_defconfig: enable dfsdm audio support
Date:   Fri, 20 Nov 2020 10:15:06 +0100
Message-ID: <20201120091506.18326-3-olivier.moysan@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201120091506.18326-1-olivier.moysan@st.com>
References: <20201120091506.18326-1-olivier.moysan@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG3NODE1.st.com (10.75.127.7) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-20_04:2020-11-19,2020-11-20 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add STM32 DFSDM audio support by enabling CONFIG_SND_SOC_STM32_DFSDM
as module.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index b30a3bc6762b..083d5f4450f4 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -743,6 +743,7 @@ CONFIG_SND_SOC_STI=m
 CONFIG_SND_SOC_STM32_SAI=m
 CONFIG_SND_SOC_STM32_I2S=m
 CONFIG_SND_SOC_STM32_SPDIFRX=m
+CONFIG_SND_SOC_STM32_DFSDM=m
 CONFIG_SND_SUN4I_CODEC=m
 CONFIG_SND_SOC_TEGRA=m
 CONFIG_SND_SOC_TEGRA20_I2S=m
-- 
2.17.1

