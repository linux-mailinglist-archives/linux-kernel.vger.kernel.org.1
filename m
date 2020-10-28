Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 818EA29E2F1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 03:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgJ1Vdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:33:41 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:41641 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725989AbgJ1Vdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:33:35 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09SF6vEx025320;
        Wed, 28 Oct 2020 16:17:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=pPYG/LhfAgAZlR2F/GmGEbUodjwV2nmicwRkUApDpvw=;
 b=u8+ZjN/B6IdqCdgc7M3GIWXSOMeVT8MVxlLAg1Pefm3kw8NCcC8zHorJSszySXZRwPpX
 Za9HpnTACoRlZSUYIxtMNosjpwV7RxwbdIfxk2hjarJZ9fTNcgUfgZQc3bswesxNRQIK
 lJHRp6JU3PIGLub3uJapn+xpmqP5xxpH6gVczND8AOAmSLowTAG91C76+0zs8tzwlCOL
 fjvH71HPG6Gd4MsB3e6ZoCg1MtdV5G7KcF9Vcxo7DsNhb7vGRs2R9qTygJKGlVl42Hh7
 gm38GDQCWU1vmpZ36ALO0NZTgHQHTozgTPpMJnmAkjo+P8P8eLAxS/witbDaRAaVhnpm aQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34ccf3tc02-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Oct 2020 16:17:03 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8395E100034;
        Wed, 28 Oct 2020 16:17:02 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 47AF724F94B;
        Wed, 28 Oct 2020 16:17:02 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 28 Oct 2020 16:17:01
 +0100
From:   Amelie Delaunay <amelie.delaunay@st.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [PATCH 1/1] usb: typec: add missing MODULE_DEVICE_TABLE() to stusb160x
Date:   Wed, 28 Oct 2020 16:17:03 +0100
Message-ID: <20201028151703.31195-1-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-10-28_07:2020-10-28,2020-10-28 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When stusb160x driver is built as a module, no modalias information is
available, and it prevents the module to be loaded by udev.
Add MODULE_DEVICE_TABLE() to fix this issue.

Fixes: da0cb6310094 ("usb: typec: add support for STUSB160x Type-C controller family")
Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 drivers/usb/typec/stusb160x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/typec/stusb160x.c b/drivers/usb/typec/stusb160x.c
index da7f1957bcb3..42076697e26c 100644
--- a/drivers/usb/typec/stusb160x.c
+++ b/drivers/usb/typec/stusb160x.c
@@ -633,6 +633,7 @@ static const struct of_device_id stusb160x_of_match[] = {
 	{ .compatible = "st,stusb1600", .data = &stusb1600_regmap_config},
 	{},
 };
+MODULE_DEVICE_TABLE(of, stusb160x_of_match);
 
 static int stusb160x_probe(struct i2c_client *client)
 {
-- 
2.17.1

