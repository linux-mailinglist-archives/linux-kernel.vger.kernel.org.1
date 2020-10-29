Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34B4429E809
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 10:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbgJ2J6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 05:58:38 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:1347 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727200AbgJ2J6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 05:58:34 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09T9v7YD009828;
        Thu, 29 Oct 2020 10:58:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=sYYTvityoCYrsSoKNe2qZDhh1lZpuC1PZ84KcUj9xUY=;
 b=B7K4zex4tKQKuc68r+D5m0ezftRYHf17UTo6dLNdC2ZNgEcHsXLnFpcfqbnqDv8UBYC3
 OO28vpGNtrk3p1XdEA/ysvapUz+hdSgpsXOKytrQoHzhVKZYfOzRpUwh65oS/Obrw2V4
 gNuHPWL28mOJad3Cndc7YLpYGBceXuaynBX445O1iLV7jyFDiXsUB9MQah7SmQWmE7I/
 YOXvJmvIeDmcit1cjOpOuLdG/um0AYOIgTi4HWLV8zx8CIr8l3eqjpaQxIstv0hm6Soh
 sY22mcxbwoKO689zEwW+No7CTiSHm4UvGC5r1wZlaLBhHFcMv55f53RYywgWDK3Sct1H Cw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34ccj278du-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Oct 2020 10:58:17 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B7947100034;
        Thu, 29 Oct 2020 10:58:16 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A6CE8221F97;
        Thu, 29 Oct 2020 10:58:16 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 29 Oct 2020 10:58:16
 +0100
From:   Amelie Delaunay <amelie.delaunay@st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Russell King <linux@armlinux.org.uk>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [RESEND PATCH v3 4/4] ARM: multi_v7_defconfig: enable STUSB160X Type-C port controller support
Date:   Thu, 29 Oct 2020 10:58:06 +0100
Message-ID: <20201029095806.10648-5-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201029095806.10648-1-amelie.delaunay@st.com>
References: <20201029095806.10648-1-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG7NODE1.st.com (10.75.127.19) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-10-29_03:2020-10-29,2020-10-29 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable support for the STMicroelectronics STUSB160X USB Type-C port
controller driver by turning on CONFIG_TYPEC and CONFIG_TYPEC_STUSB160X as
modules.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 arch/arm/configs/multi_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index e731cdf7c88c..41d0def64ce6 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -828,6 +828,8 @@ CONFIG_USB_CONFIGFS_F_HID=y
 CONFIG_USB_CONFIGFS_F_UVC=y
 CONFIG_USB_CONFIGFS_F_PRINTER=y
 CONFIG_USB_ETH=m
+CONFIG_TYPEC=m
+CONFIG_TYPEC_STUSB160X=m
 CONFIG_MMC=y
 CONFIG_MMC_BLOCK_MINORS=16
 CONFIG_MMC_ARMMMCI=y
-- 
2.17.1

