Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191072C668E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 14:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730168AbgK0NRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 08:17:43 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:63992 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729967AbgK0NRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 08:17:43 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0ARCSdO0007149;
        Fri, 27 Nov 2020 14:17:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=XenMXX7jpB+ldiDL9YwCU3HGZQwucqgew9IYEnutEX4=;
 b=qPCKFoYVv9dt3F8SypMqylHcwU1r9jlPO4R9SGeixelEqb0Bmb9NYgzZ/kJOvBA/mIem
 fLYkPIVyThqISHF6t+gqJsEhwDw+HqFuPMp0WNuz7LMZgOU+d6b4XC9tFsvIkmBN6DyZ
 LKBV5MmQperULbaaB2B43f8z3UsjrBsT1IhagGmwNdLY+vdn3mHh/nYJm510AUaw0UXi
 ZQN6sQfZtaNLML6uqmdlNDUxSzDqEctfx8P+cwrCR+rjy5T9KGeJBoqji6MZCVS9rLRl
 UCilXFI/5tTgwGOTzjO4b+ubxv/3kDD37k3GE82jq5JLysSKKobsea0CQ7n60gwT8QMH Ew== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34y01d2r2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Nov 2020 14:17:37 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EA05C10002A;
        Fri, 27 Nov 2020 14:17:36 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B72C424A64B;
        Fri, 27 Nov 2020 14:17:36 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 27 Nov 2020 14:17:36
 +0100
From:   Amelie Delaunay <amelie.delaunay@st.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [PATCH v5 1/1 RESEND] usb: typec: stusb160x: fix power-opmode property with typec-power-opmode
Date:   Fri, 27 Nov 2020 14:17:35 +0100
Message-ID: <20201127131735.28280-1-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG3NODE1.st.com (10.75.127.7) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-27_06:2020-11-26,2020-11-27 signatures=0
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

