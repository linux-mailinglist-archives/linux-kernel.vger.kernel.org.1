Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77A40276CA8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 11:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbgIXJBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 05:01:25 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:13686 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727345AbgIXJBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 05:01:17 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08O8vdTU024333;
        Thu, 24 Sep 2020 11:01:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=MA+9poxCALvNJJsLDbmOc9iqUepm6Qqt4V8rDPuLSBo=;
 b=Vr08c0asAPnpgf9MFQsacatabxYeq8v6+kmyZHFHzVnYURtzswgNJk6DIuLa4EJNWDJx
 icRwfwBXkW+MyCd1GI6BbkMhdTLHqhD052xx0jABOt6aEQJMuPJ7CRnjAY1j2tcbDoSj
 PAap00cdvUsqRtW101AcBJfCOo/JJt69vj44WAio1MKFWfG/CMk7YZlmG/b7TftPND9n
 K4g7z9DlPrR31WItc5o+SBTKyIfjQv7LwsTD6CEyASnYYrIyt0xflr7mglyQnrb6kG7q
 RnJkbf1Kh1WwW+f15Iu474E3gawsd6htcIX7PouRo5HY3Pp8qLY+gcL5vdBpl7Cz8+kr fQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 33n748cs6j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Sep 2020 11:01:03 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 30D23100038;
        Thu, 24 Sep 2020 11:01:03 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1E0BA2A4D64;
        Thu, 24 Sep 2020 11:01:03 +0200 (CEST)
Received: from localhost (10.75.127.46) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 24 Sep 2020 11:01:02
 +0200
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
Subject: [PATCH v3 6/6] ARM: multi_v7_defconfig: enable STUSB160X Type-C port controller support
Date:   Thu, 24 Sep 2020 11:00:49 +0200
Message-ID: <20200924090049.9041-7-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200924090049.9041-1-amelie.delaunay@st.com>
References: <20200924090049.9041-1-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-24_05:2020-09-24,2020-09-24 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable support for the STMicroelectronics STUSB160X USB Type-C port
controller driver by turning on CONFIG_TYPEC and CONFIG_TYPEC_STUSB160X as
modules.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
No changes in v3.
No changes in v2.
---
 arch/arm/configs/multi_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index e9e76e32f10f..d90fba19fcdb 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -826,6 +826,8 @@ CONFIG_USB_CONFIGFS_F_HID=y
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

