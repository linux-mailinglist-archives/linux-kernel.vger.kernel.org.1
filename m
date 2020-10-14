Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70EBE28E28E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 16:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731153AbgJNOyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 10:54:54 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:32428 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728965AbgJNOyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 10:54:51 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 09EEpi80023902;
        Wed, 14 Oct 2020 09:54:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=bBy5LfwwfVhr4zvv5l4NPCrI6nTVQPaTkMub+rmgFxk=;
 b=gxZOPXc8QwDEzQqDTGtZbO5DfO6DSKg+wjfE1X9m3Bqe5hzADmst5JyK5K0XYS6fhCaU
 SmlanPYY1A7gJC5tKEzR5BUK3vZMf+f1njexcHG2YBsrOplWcxFaJDcditMVeEXIfZBg
 6IjOTvyJ4agKeJjeLJyeSFI8nnkx1PCFtsetW9LZS9jnYmBQMCAClQu2eHBfIGmnMs5b
 4+IBphedy5ZKDiPnnhWozco20jY7YdJKrJFmEMy4SsPD7pDGMGTdl9NgLp6ZLh8FvGK9
 AmueFfVuC7HQj+hDMOTmCbrC4fjQd7AzBV2WGrLWMQOTFC0KGJkA75TzW/sDCbp90MPi Dg== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 343ac1wbwc-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 14 Oct 2020 09:54:35 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 14 Oct
 2020 15:54:33 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Wed, 14 Oct 2020 15:54:33 +0100
Received: from AUSNPC0LSNW1-debian.ad.cirrus.com (ausnpc0lsnw1.ad.cirrus.com [198.61.64.143])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id A86102AA;
        Wed, 14 Oct 2020 14:54:32 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <nsaenzjulienne@suse.de>
CC:     <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 1/7] of: base: Add of_count_phandle_with_fixed_args()
Date:   Wed, 14 Oct 2020 15:54:12 +0100
Message-ID: <20201014145418.31838-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201014145418.31838-1-rf@opensource.cirrus.com>
References: <20201014145418.31838-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 mlxscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010140108
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an equivalent of of_count_phandle_with_args() for fixed argument
sets, to pair with of_parse_phandle_with_fixed_args().

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/of/base.c  | 42 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/of.h |  9 +++++++++
 2 files changed, 51 insertions(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index ea44fea99813..45d8b0e65345 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1772,6 +1772,48 @@ int of_count_phandle_with_args(const struct device_node *np, const char *list_na
 }
 EXPORT_SYMBOL(of_count_phandle_with_args);
 
+/**
+ * of_count_phandle_with_fixed_args() - Find the number of phandles references in a property
+ * @np:		pointer to a device tree node containing a list
+ * @list_name:	property name that contains a list
+ * @cell_count: number of argument cells following the phandle
+ *
+ * Returns the number of phandle + argument tuples within a property. It
+ * is a typical pattern to encode a list of phandle and variable
+ * arguments into a single property.
+ */
+int of_count_phandle_with_fixed_args(const struct device_node *np,
+				     const char *list_name,
+				     int cells_count)
+{
+	struct of_phandle_iterator it;
+	int rc, cur_index = 0;
+
+	if (!cells_count) {
+		const __be32 *list;
+		int size;
+
+		list = of_get_property(np, list_name, &size);
+		if (!list)
+			return -ENOENT;
+
+		return size / sizeof(*list);
+	}
+
+	rc = of_phandle_iterator_init(&it, np, list_name, NULL, cells_count);
+	if (rc)
+		return rc;
+
+	while ((rc = of_phandle_iterator_next(&it)) == 0)
+		cur_index += 1;
+
+	if (rc != -ENOENT)
+		return rc;
+
+	return cur_index;
+}
+EXPORT_SYMBOL(of_count_phandle_with_fixed_args);
+
 /**
  * __of_add_property - Add a property to a node without lock operations
  */
diff --git a/include/linux/of.h b/include/linux/of.h
index 5cf7ae0465d1..9f315da4e9da 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -377,6 +377,8 @@ extern int of_parse_phandle_with_fixed_args(const struct device_node *np,
 	struct of_phandle_args *out_args);
 extern int of_count_phandle_with_args(const struct device_node *np,
 	const char *list_name, const char *cells_name);
+extern int of_count_phandle_with_fixed_args(const struct device_node *np,
+	const char *list_name, int cells_count);
 
 /* phandle iterator functions */
 extern int of_phandle_iterator_init(struct of_phandle_iterator *it,
@@ -886,6 +888,13 @@ static inline int of_count_phandle_with_args(struct device_node *np,
 	return -ENOSYS;
 }
 
+static inline int of_count_phandle_with_fixed_args(const struct device_node *np,
+						   const char *list_name,
+						   int cells_count)
+{
+	return -ENOSYS;
+}
+
 static inline int of_phandle_iterator_init(struct of_phandle_iterator *it,
 					   const struct device_node *np,
 					   const char *list_name,
-- 
2.20.1

