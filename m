Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17D5C29E323
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 03:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730352AbgJ2Cpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 22:45:39 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:39746 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726143AbgJ1Vdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:33:36 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09SFkttw015934;
        Wed, 28 Oct 2020 16:54:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=My//I8tAAL0mcppmcnPGDlZb1Fs1wApvMcb494W8c+M=;
 b=TUdb7FOxztuv9L0bhgSiWpJxFS1o4nX7zdL8NBWrTajSajyJSYyBDrbMVnOa80seVYZk
 5cpUEMBy2n2JuCP/VnpRWW+7o10gsLB4XQB2Iwp9/4Dw5/FuyEhvRED6VCxlA5oaQ18/
 WbUxwmG49XZ9F/aqJ5ZdQg4LikWrvinUe9JpXBio5NQjk8/gUlJINjOgvbuUVmODsgAJ
 blEh6E8AxHiE8mXNxk2RlDWxe1bnMUNt5tq5NBlBOJlMx/i/61qktCtuMsyLfFCicEC4
 +q7UMnASGjjK7CwSAx7UXWsVrsRheGhr9smfdMoXHt6ti7RwA67ugWiTyLLLIJuTxghr 0A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34ccffk8hs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Oct 2020 16:54:20 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C78BA100056;
        Wed, 28 Oct 2020 16:54:17 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 03FF02B8A0E;
        Wed, 28 Oct 2020 16:53:36 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 28 Oct 2020 16:53:35
 +0100
From:   Amelie Delaunay <amelie.delaunay@st.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [PATCH 1/1] usb: typec: stusb160x: fix signedness comparison issue with enum variables
Date:   Wed, 28 Oct 2020 16:53:37 +0100
Message-ID: <20201028155337.9196-1-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-10-28_07:2020-10-28,2020-10-28 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

chip->port_type and chip->pwr_opmode are enums and when GCC considers them
as unsigned, the conditions are never met.
This patch takes advantage of the ret variable and fixes the following
warnings:
drivers/usb/typec/stusb160x.c:548 stusb160x_get_fw_caps() warn: unsigned 'chip->port_type' is never less than zero.
drivers/usb/typec/stusb160x.c:570 stusb160x_get_fw_caps() warn: unsigned 'chip->pwr_opmode' is never less than zero.

Fixes: da0cb6310094 ("usb: typec: add support for STUSB160x Type-C controller family")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 drivers/usb/typec/stusb160x.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/typec/stusb160x.c b/drivers/usb/typec/stusb160x.c
index da7f1957bcb3..8519d33bc3e7 100644
--- a/drivers/usb/typec/stusb160x.c
+++ b/drivers/usb/typec/stusb160x.c
@@ -544,11 +544,11 @@ static int stusb160x_get_fw_caps(struct stusb160x *chip,
 	 */
 	ret = fwnode_property_read_string(fwnode, "power-role", &cap_str);
 	if (!ret) {
-		chip->port_type = typec_find_port_power_role(cap_str);
-		if ((int)chip->port_type < 0) {
-			ret = chip->port_type;
+		ret = typec_find_port_power_role(cap_str);
+		if (ret < 0)
 			return ret;
-		}
+		chip->port_type = ret;
+
 	}
 	chip->capability.type = chip->port_type;
 
@@ -565,16 +565,13 @@ static int stusb160x_get_fw_caps(struct stusb160x *chip,
 	 */
 	ret = fwnode_property_read_string(fwnode, "power-opmode", &cap_str);
 	if (!ret) {
-		chip->pwr_opmode = typec_find_pwr_opmode(cap_str);
+		ret = typec_find_pwr_opmode(cap_str);
 		/* Power delivery not yet supported */
-		if ((int)chip->pwr_opmode < 0 ||
-		    chip->pwr_opmode == TYPEC_PWR_MODE_PD) {
-			ret = (int)chip->pwr_opmode < 0 ? chip->pwr_opmode :
-							  -EINVAL;
-			dev_err(chip->dev, "bad power operation mode: %d\n",
-				chip->pwr_opmode);
-			return ret;
+		if (ret < 0 || ret == TYPEC_PWR_MODE_PD) {
+			dev_err(chip->dev, "bad power operation mode: %d\n", ret);
+			return -EINVAL;
 		}
+		chip->pwr_opmode = ret;
 	}
 
 	return 0;
-- 
2.17.1

