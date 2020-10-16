Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8574628FFA6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 10:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404977AbgJPICA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 04:02:00 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:48205 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404885AbgJPICA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 04:02:00 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09G7vQro012248;
        Fri, 16 Oct 2020 10:01:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=FPlO1VgG+i/DE+Lhz4heZb30Y7T1Ybmq2rz3YZ0WyFo=;
 b=HyP7Iz/Ba3Wtks/G5Brv2Cz1rau7rjmjXV6yyhKdoxkxc2x/WdNP2K8Gva+6F5DPVN8x
 9pZQq5BnIhzv3Xo+o4bImr4vTnwA9LceZly2Xqua8kZoMBDhmj8pbt90+q05fDC59X+u
 fTxo2+/GDlgdj3msXEO/M0++AtAGW7XnPfAoJokjyoLgJ+OnVXCy+YDHyStrEH4SdvnP
 BAt201NBjYuO2BQ/rUGIYCeOYGoqUWf6hh21ZIWvBBHAo1o9Tex7g5thVVOuajw8nxPy
 NZ6dPNCM9whPpJvGi4SuRTw4osE0sR8DJX+fhT9WsSzprDz0NF5npdGDSrBSfqdlNDXr aw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 343587hswq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Oct 2020 10:01:45 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EBCF810002A;
        Fri, 16 Oct 2020 10:01:44 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag1node3.st.com [10.75.127.3])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CF6062D7BF1;
        Fri, 16 Oct 2020 10:01:44 +0200 (CEST)
Received: from localhost (10.75.127.46) by SFHDAG1NODE3.st.com (10.75.127.3)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 16 Oct 2020 10:01:05
 +0200
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <alexandre.torgue@st.com>
CC:     <vilhelm.gray@gmail.com>, <arnd@arndb.de>, <linux@armlinux.org.uk>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <fabrice.gasnier@st.com>
Subject: [PATCH] ARM: multi_v7_defconfig: enable counter subsystem and stm32 counter drivers
Date:   Fri, 16 Oct 2020 10:00:29 +0200
Message-ID: <1602835229-10903-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG6NODE2.st.com (10.75.127.17) To SFHDAG1NODE3.st.com
 (10.75.127.3)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-16_05:2020-10-16,2020-10-16 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables the counter subsystem and drivers for the stm32 timer and LP
timer.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 arch/arm/configs/multi_v7_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index e9e76e3..f052db3 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -1092,6 +1092,9 @@ CONFIG_FSI_MASTER_ASPEED=m
 CONFIG_FSI_SCOM=m
 CONFIG_FSI_SBEFIFO=m
 CONFIG_FSI_OCC=m
+CONFIG_COUNTER=m
+CONFIG_STM32_TIMER_CNT=m
+CONFIG_STM32_LPTIMER_CNT=m
 CONFIG_EXT4_FS=y
 CONFIG_AUTOFS4_FS=y
 CONFIG_MSDOS_FS=y
-- 
2.7.4

