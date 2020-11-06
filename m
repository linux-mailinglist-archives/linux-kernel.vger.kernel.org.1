Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20D742A9A04
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 17:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbgKFQ6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 11:58:41 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:12280 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727474AbgKFQ6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 11:58:39 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A6GvLoW020517;
        Fri, 6 Nov 2020 17:58:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=XenMXX7jpB+ldiDL9YwCU3HGZQwucqgew9IYEnutEX4=;
 b=G+w1ZZppV+wz4iskZtLF22i51Wp0PIbDYORQukZd9mV22WrkWZZn7KRPHXpIcLlK+KHk
 BCu8Jqr8cYsB66F+yIQRRyA1Iw7O91K60L/Zvgz9LCNMdIWMqd1N73PaqPt5/hoGmQjT
 9z2fSyg2n7ujlrhcd1yocy28WRgyhnafwtASxLQZhTeMwF1dOuOAx7BcgZpqfTMPhTyx
 Ug+LxZD7yAj3MEK0JcpumUdmP2pO7xLml98DJdgf1Ni3dnshsfYxUklwtiF0FeBmP2L2
 tVgb+QJnAV4IsIwnV+CLf4TmYua+6384txXEHXlpx+cniBr5l753Zv61fmKyM9fPhlhB iQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34h0328gra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Nov 2020 17:58:14 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 585DE10002A;
        Fri,  6 Nov 2020 17:58:14 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 490A52C41F5;
        Fri,  6 Nov 2020 17:58:14 +0100 (CET)
Received: from localhost (10.75.127.46) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 6 Nov 2020 17:58:13
 +0100
From:   Amelie Delaunay <amelie.delaunay@st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Russell King <linux@armlinux.org.uk>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Jun Li <lijun.kernel@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [PATCH v5 3/5] usb: typec: stusb160x: fix power-opmode property with typec-power-opmode
Date:   Fri, 6 Nov 2020 17:58:03 +0100
Message-ID: <20201106165805.31534-4-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201106165805.31534-1-amelie.delaunay@st.com>
References: <20201106165805.31534-1-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-06_06:2020-11-05,2020-11-06 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device tree property is named typec-power-opmode, not power-opmode.

Fixes: da0cb6310094 ("usb: typec: add support for STUSB160x Type-C controller family")
Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/stusb160x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/stusb160x.c b/drivers/usb/typec/stusb160x.c
index 2a618f02f4f1..d21750bbbb44 100644
--- a/drivers/usb/typec/stusb160x.c
+++ b/drivers/usb/typec/stusb160x.c
@@ -562,7 +562,7 @@ static int stusb160x_get_fw_caps(struct stusb160x *chip,
 	 * Supported power operation mode can be configured through device tree
 	 * else it is read from chip registers in stusb160x_get_caps.
 	 */
-	ret = fwnode_property_read_string(fwnode, "power-opmode", &cap_str);
+	ret = fwnode_property_read_string(fwnode, "typec-power-opmode", &cap_str);
 	if (!ret) {
 		ret = typec_find_pwr_opmode(cap_str);
 		/* Power delivery not yet supported */
-- 
2.17.1

