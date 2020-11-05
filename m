Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE0462A7AFC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 10:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgKEJs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 04:48:27 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:14876 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725468AbgKEJsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 04:48:25 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A59lJK2028659;
        Thu, 5 Nov 2020 10:48:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=Mjl4STNOOLMuMfiM6VyfN1wo5XxL+uNG4rl8O9UFK6w=;
 b=rk7lCapr4f6cTEOJOOYbIXOJbuDsfgcQU8tNdPH98cWl2LlU+3FvTE7IgML9k/MBQ+D+
 fgW+0B1xvE2sfoGoH5pNmAAefdFqkzWYVsku15RmszBnKTXF2wvwdi0ll5D8tje5Rs3+
 XzTHBpuVSF9grpPKcXPIj6Dxtxt3Gfahfzf4xIV/ZC2mX5SNAoN0wtrpYbbGz0kzkH42
 Myqff814ZNK5YXd6slXsgVhNE/apZKlv8Yt1rTYDljjNQwYZfXB5jtnW5PCH81PVHj51
 eXlJmxj/K5VdORmY+keZ6Osa+KMrATQ7w9sPhng90Fax2ePgYKhxvdyJ87CoijQ33tu/ 2g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34h031yray-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Nov 2020 10:48:15 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1F607100034;
        Thu,  5 Nov 2020 10:48:13 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3A1F52365FE;
        Thu,  5 Nov 2020 10:48:13 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 5 Nov 2020 10:47:31
 +0100
From:   Lionel Debieve <lionel.debieve@st.com>
To:     Russell King <linux@armlinux.org.uk>,
        Alexandre Torgue <alexandre.torgue@st.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH 1/1] ARM: multi_v7_defconfig: add STM32 crypto support
Date:   Thu, 5 Nov 2020 10:47:30 +0100
Message-ID: <20201105094730.8320-1-lionel.debieve@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG7NODE1.st.com (10.75.127.19) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-05_05:2020-11-05,2020-11-05 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable crypto controllers enabling following flags as module:
CONFIG_CRYPTO_DEV_STM32_CRC
CONFIG_CRYPTO_DEV_STM32_HASH
CONFIG_CRYPTO_DEV_STM32_CRYP

Signed-off-by: Lionel Debieve <lionel.debieve@st.com>
---
 arch/arm/configs/multi_v7_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index a611b0c1e540..57eafa2d7775 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -1133,6 +1133,9 @@ CONFIG_CRYPTO_DEV_ATMEL_AES=m
 CONFIG_CRYPTO_DEV_ATMEL_TDES=m
 CONFIG_CRYPTO_DEV_ATMEL_SHA=m
 CONFIG_CRYPTO_DEV_ROCKCHIP=m
+CONFIG_CRYPTO_DEV_STM32_CRC=m
+CONFIG_CRYPTO_DEV_STM32_HASH=m
+CONFIG_CRYPTO_DEV_STM32_CRYP=m
 CONFIG_CMA_SIZE_MBYTES=64
 CONFIG_PRINTK_TIME=y
 CONFIG_MAGIC_SYSRQ=y
-- 
2.17.1

