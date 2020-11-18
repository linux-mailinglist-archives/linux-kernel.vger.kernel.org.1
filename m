Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF39C2B7AAC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 10:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbgKRJus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 04:50:48 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:53205 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727238AbgKRJur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 04:50:47 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AI9biaG023826;
        Wed, 18 Nov 2020 10:50:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=3uy/fMIRVHV92mc4foq3cLiUWFLlxU/uq/4hM1+2Gq8=;
 b=SUzDkvox61L5WsX0CBwHlwl6ASF2WoUT1/5XanY69Je7bJ/YF7J+I0dWmZVU7D1oxzSf
 1Ek9whQS8L7vQ7pOjj6hAAowtSBjCx9vvG0hhs2RShytIW8wqEoabvh0CbFAlVP05YAV
 3Pu9/nA+fLFbTQqrqE61mvtKc6X0I26083CwIMuWM9li+opkPtM5j/XltAjf/tNHbssL
 ajHLIw0ANTOBMMyXlxBt1LF/wYaVjcxkrK3b4JqaJmlA2GgRysBOcC0jD5s3cKyrNSHn
 t/m9tivKryrvPbKBl1x7zvsMzDu2PbuAkxL1RJ2drc9b7iY3zy42m8pd9KYqwGKa+3nK eg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34t5k57kjx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Nov 2020 10:50:20 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4B0DE100038;
        Wed, 18 Nov 2020 10:50:19 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 32E73246E6D;
        Wed, 18 Nov 2020 10:50:19 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 18 Nov 2020 10:50:18
 +0100
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <linux@armlinux.org.uk>, <shawnguo@kernel.org>, <olof@lixom.net>,
        <alexandre.torgue@st.com>, <krzk@kernel.org>,
        <geert+renesas@glider.be>, <amelie.delaunay@st.com>,
        <aisheng.dong@nxp.com>, <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <christian.gmeiner@gmail.com>, <enric.balletbo@collabora.com>,
        <lionel.debieve@st.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <olivier.moysan@st.com>
Subject: [PATCH 1/2] ARM: multi_v7_defconfig: enable spdifrx support
Date:   Wed, 18 Nov 2020 10:50:12 +0100
Message-ID: <20201118095013.16094-2-olivier.moysan@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201118095013.16094-1-olivier.moysan@st.com>
References: <20201118095013.16094-1-olivier.moysan@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-18_04:2020-11-17,2020-11-18 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add STM32 SPDIFRX support by enabling CONFIG_SND_SOC_STM32_SPDIFRX
as module.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 1fff2591e434..b30a3bc6762b 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -742,6 +742,7 @@ CONFIG_SND_SOC_RCAR=m
 CONFIG_SND_SOC_STI=m
 CONFIG_SND_SOC_STM32_SAI=m
 CONFIG_SND_SOC_STM32_I2S=m
+CONFIG_SND_SOC_STM32_SPDIFRX=m
 CONFIG_SND_SUN4I_CODEC=m
 CONFIG_SND_SOC_TEGRA=m
 CONFIG_SND_SOC_TEGRA20_I2S=m
-- 
2.17.1

