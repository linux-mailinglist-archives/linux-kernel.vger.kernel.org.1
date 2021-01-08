Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41D982EF57F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 17:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbhAHQGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 11:06:23 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:57248 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727971AbhAHQGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 11:06:10 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 108G2EoX011561;
        Fri, 8 Jan 2021 10:05:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=2j2pa6/Jqo6QYZqsSeLPknoRF/7N3vv/yIiaZr+oTAo=;
 b=pjeryqd8SbN62ve1AflY1HOFGYsSF12MSr/J0ayKxf8VxDDs0WzXsuwGL63k5P4mLg9d
 SRYppa6wyfsynAPIVqyGqEf1A6PE/4j/kbqY1EFbHBF/O6pQRLZ7AyBPAFa3VpSO48Pb
 9hDk5PfaDMiCZTm95CJqlPj42QsapkYbqwQ5bQooHzxqtxX349NKk03PfgmDlm2lcQuc
 YuBECeZnrdT/5OHUjwQf0OvxqXRlLrwgPlDrBfOPQGSWkcnF8642gaPcyutHCx0rKe2b
 7UqxzyOYlSDmHBBtYkL8zwDshabVuM4jCo2TCnFM6KBM645O3oD93jk0gJHbi4GJdYZ8 ag== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 35wqjka90t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 08 Jan 2021 10:05:08 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 8 Jan 2021
 16:05:06 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Fri, 8 Jan 2021 16:05:06 +0000
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.64.226])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 62C1E11CB;
        Fri,  8 Jan 2021 16:05:06 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <kuninori.morimoto.gx@renesas.com>, <nsaenzjulienne@suse.de>,
        <f.fainelli@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <bcm-kernel-feedback-list@broadcom.com>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 1/6] of: base: Add of_count_phandle_with_fixed_args()
Date:   Fri, 8 Jan 2021 16:04:56 +0000
Message-ID: <20210108160501.7638-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210108160501.7638-1-rf@opensource.cirrus.com>
References: <20210108160501.7638-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 spamscore=0 clxscore=1015 bulkscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101080091
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an equivalent of of_count_phandle_with_args() for fixed argument
sets, to pair with of_parse_phandle_with_fixed_args().

The existing of_count_phandle_with_args() is modified to be a
private function that handles both cases and the public functions
are trivial wrappers round that.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 drivers/of/base.c  | 73 +++++++++++++++++++++++++++++++---------------
 include/linux/of.h |  9 ++++++
 2 files changed, 59 insertions(+), 23 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 161a23631472..c5ff2524bf40 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1720,34 +1720,22 @@ int of_parse_phandle_with_fixed_args(const struct device_node *np,
 }
 EXPORT_SYMBOL(of_parse_phandle_with_fixed_args);
 
-/**
- * of_count_phandle_with_args() - Find the number of phandles references in a property
- * @np:		pointer to a device tree node containing a list
- * @list_name:	property name that contains a list
- * @cells_name:	property name that specifies phandles' arguments count
- *
- * Returns the number of phandle + argument tuples within a property. It
- * is a typical pattern to encode a list of phandle and variable
- * arguments into a single property. The number of arguments is encoded
- * by a property in the phandle-target node. For example, a gpios
- * property would contain a list of GPIO specifies consisting of a
- * phandle and 1 or more arguments. The number of arguments are
- * determined by the #gpio-cells property in the node pointed to by the
- * phandle.
- */
-int of_count_phandle_with_args(const struct device_node *np, const char *list_name,
-				const char *cells_name)
+static int __of_count_phandle_with_args(const struct device_node *np,
+					const char *list_name,
+					const char *cells_name,
+					int cells_count)
 {
 	struct of_phandle_iterator it;
 	int rc, cur_index = 0;
 
 	/*
-	 * If cells_name is NULL we assume a cell count of 0. This makes
-	 * counting the phandles trivial as each 32bit word in the list is a
-	 * phandle and no arguments are to consider. So we don't iterate through
-	 * the list but just use the length to determine the phandle count.
+	 * If cells_count < 0 and cells_name is NULL we assume a cell count
+	 * of 0. A zero cell count makes counting the phandles trivial as each
+	 * 32bit word in the list is a phandle and no arguments are to consider.
+	 * So we don't iterate through the list but just use the length to
+	 * determine the phandle count.
 	 */
-	if (!cells_name) {
+	if ((cells_count < 0 && !cells_name) || cells_count == 0) {
 		const __be32 *list;
 		int size;
 
@@ -1758,7 +1746,7 @@ int of_count_phandle_with_args(const struct device_node *np, const char *list_na
 		return size / sizeof(*list);
 	}
 
-	rc = of_phandle_iterator_init(&it, np, list_name, cells_name, -1);
+	rc = of_phandle_iterator_init(&it, np, list_name, cells_name, cells_count);
 	if (rc)
 		return rc;
 
@@ -1770,8 +1758,47 @@ int of_count_phandle_with_args(const struct device_node *np, const char *list_na
 
 	return cur_index;
 }
+
+/**
+ * of_count_phandle_with_args() - Find the number of phandles references in a property
+ * @np:		pointer to a device tree node containing a list
+ * @list_name:	property name that contains a list
+ * @cells_name:	property name that specifies phandles' arguments count
+ *
+ * Returns the number of phandle + argument tuples within a property. It
+ * is a typical pattern to encode a list of phandle and variable
+ * arguments into a single property. The number of arguments is encoded
+ * by a property in the phandle-target node. For example, a gpios
+ * property would contain a list of GPIO specifies consisting of a
+ * phandle and 1 or more arguments. The number of arguments are
+ * determined by the #gpio-cells property in the node pointed to by the
+ * phandle.
+ */
+int of_count_phandle_with_args(const struct device_node *np, const char *list_name,
+				const char *cells_name)
+{
+	return __of_count_phandle_with_args(np, list_name, cells_name, -1);
+}
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
+	return __of_count_phandle_with_args(np, list_name, NULL, cells_count);
+}
+EXPORT_SYMBOL(of_count_phandle_with_fixed_args);
+
 /**
  * __of_add_property - Add a property to a node without lock operations
  */
diff --git a/include/linux/of.h b/include/linux/of.h
index 4b27c9a27df3..4f09d644a803 100644
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
@@ -888,6 +890,13 @@ static inline int of_count_phandle_with_args(struct device_node *np,
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

