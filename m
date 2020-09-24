Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53DC2276CA4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 11:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbgIXJB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 05:01:27 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:45367 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727340AbgIXJBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 05:01:15 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08O8ujau013743;
        Thu, 24 Sep 2020 11:00:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=qOPGSA4k71owNvAkgVgp5TldnSG68YhSY830P7UkA/I=;
 b=bIOHvamUs6vElV/APFQyD+/d0FFkehc1CJEJJA4vvv2VqZ/7AZlzSgai3/PQ4Nq9VbXK
 3+MJ1P1tDe7HgidrRoDlX7cdOkp85jL9kxVAf4AEXXz2w22p116KawDGvGn+AbPRinJ6
 4ANc5tE5uJQL5pP8a0klXIdQ+rKJ5Sf0w+4sACWdEC3p/l+lksyG1v8xe1quIvTX02MG
 zoiqYPG7YFnG/vQr5Lkv+fv9Xh+PyL1qo3ZXsh6iV+NabOYNsadjgbD3lGAf14OeQicD
 G/xR/OO5GxD69a68ZdYVMrtQVUwuZzLJxl6iz4ZEKBcoMAMIUO+XQZRfuGkxoNR9A0fW DQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 33n7f02r6j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Sep 2020 11:00:58 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0E74110002A;
        Thu, 24 Sep 2020 11:00:58 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id F0C7B2A4D61;
        Thu, 24 Sep 2020 11:00:57 +0200 (CEST)
Received: from localhost (10.75.127.45) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 24 Sep 2020 11:00:57
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
Subject: [PATCH v3 2/6] usb: typec: add typec_find_pwr_opmode
Date:   Thu, 24 Sep 2020 11:00:45 +0200
Message-ID: <20200924090049.9041-3-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200924090049.9041-1-amelie.delaunay@st.com>
References: <20200924090049.9041-1-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG5NODE1.st.com (10.75.127.13) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-24_05:2020-09-24,2020-09-24 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a function that converts power operation mode string into
power operation mode value.

It is useful to configure power operation mode through device tree
property, as power capabilities may be linked to hardware design.

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
No changes in v3.
No changes in v2.
---
 drivers/usb/typec/class.c | 15 +++++++++++++++
 include/linux/usb/typec.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 02655694f200..35eec707cb51 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -1448,6 +1448,21 @@ void typec_set_pwr_opmode(struct typec_port *port,
 }
 EXPORT_SYMBOL_GPL(typec_set_pwr_opmode);
 
+/**
+ * typec_find_pwr_opmode - Get the typec power operation mode capability
+ * @name: power operation mode string
+ *
+ * This routine is used to find the typec_pwr_opmode by its string @name.
+ *
+ * Returns typec_pwr_opmode if success, otherwise negative error code.
+ */
+int typec_find_pwr_opmode(const char *name)
+{
+	return match_string(typec_pwr_opmodes,
+			    ARRAY_SIZE(typec_pwr_opmodes), name);
+}
+EXPORT_SYMBOL_GPL(typec_find_pwr_opmode);
+
 /**
  * typec_find_orientation - Convert orientation string to enum typec_orientation
  * @name: Orientation string
diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
index 9cb1bec94b71..6be558045942 100644
--- a/include/linux/usb/typec.h
+++ b/include/linux/usb/typec.h
@@ -268,6 +268,7 @@ int typec_set_mode(struct typec_port *port, int mode);
 
 void *typec_get_drvdata(struct typec_port *port);
 
+int typec_find_pwr_opmode(const char *name);
 int typec_find_orientation(const char *name);
 int typec_find_port_power_role(const char *name);
 int typec_find_power_role(const char *name);
-- 
2.17.1

