Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C51D226A58E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 14:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgIOMuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 08:50:04 -0400
Received: from mail-eopbgr10106.outbound.protection.outlook.com ([40.107.1.106]:4528
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726333AbgIOMmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 08:42:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQrFlNs8roCyuvcaBLjgpoNKFEVa0PCnAnJ+WXwKlipiS2vvIcSwAi5bFLYgX3IomNWcUiaz8TRhWPs0wMT/4Txx6z82TVY79GlARMIU60o+nQx1U5puLcMUWCpRIFjPYmmsOh8GQIRZl3R4uUxAl/kiZ9i2VblxwjfVPQ5ysA9BvGSXclZl8sbnPhNe4TG7KWbuiW8Qd530tOcOubO3A5Cn27CHU4W7dsSn5gay1vGkZyyPLwNUvjNm+yDDhZx66xQLRbyLarw0TVifoa63sxNJNIqHq5kZuevfrJrvbZXiPLGSZ/9g4SWtEJTVdgmvW8m3bADVf9ConRMFbjDWjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVWdOUTM5L+BA5CDvMxi2Vqfhe8TnhULAsZLz5SLcDI=;
 b=dh9Jh2E32YfeRnUnJI4SQt7iuKIHvrFVhQrjIG+7ju8ebFSGqI4fHFAP3g77IRZE43IF/RV+h2uQpmTBlXA+GAK+Ep04iA0+v5vt/ygFJYv8derNZiZqFxTGoOGF/nMKPFRUV4vTBSIzgB10vrdK6OU+tdPcfcnvd0mtVU/oeVikd6Lz8btzGFU4O67rXuHa41KWJbK6TvWO40E0bWPpG95eBILWlKH52nESinGu0+88ckLlK1cilcMBfqhgYQ/MY4dfeDZ1fwlYnm+qmoEJg5NzH5nUjXm0cZJxwxcGh7rrkBCPdgLXdmgQtJ7LruBQ9NONHuKLC1aOqUX8wTbuUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVWdOUTM5L+BA5CDvMxi2Vqfhe8TnhULAsZLz5SLcDI=;
 b=rJsL/XReM/MWdCloZs1DXF0qHjdfH9kWtLnsNar6TcF4VVO2fjdBaQiPpmkG6oCNea71XvPviyopL506L6BmL5ciUrIUX80fT1iT5vp7ib9eg14J76GDgO1hlDgRgeYsb8j4BPwZGnTnXVqWIPNj542hli5gWn1Y6b4lfpf5/RU=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=plvision.eu;
Received: from HE1P190MB0539.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:56::28) by
 HE1P190MB0331.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:5b::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.19; Tue, 15 Sep 2020 12:41:56 +0000
Received: from HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 ([fe80::c1ab:71de:6bc2:89fe]) by HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 ([fe80::c1ab:71de:6bc2:89fe%6]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 12:41:56 +0000
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Vadym Kochan <vadym.kochan@plvision.eu>
Subject: [PATCH 2/3] nvmem: add ONIE nvmem cells parser
Date:   Tue, 15 Sep 2020 15:41:15 +0300
Message-Id: <20200915124116.7196-3-vadym.kochan@plvision.eu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200915124116.7196-1-vadym.kochan@plvision.eu>
References: <20200915124116.7196-1-vadym.kochan@plvision.eu>
Content-Type: text/plain
X-ClientProxiedBy: AM6P194CA0033.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:90::46) To HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:7:56::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pc60716vkochan.x.ow.s (217.20.186.93) by AM6P194CA0033.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:90::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Tue, 15 Sep 2020 12:41:54 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [217.20.186.93]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dcfe46d4-4b37-4b2f-42d9-08d85974ba3b
X-MS-TrafficTypeDiagnostic: HE1P190MB0331:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1P190MB0331EA9FCF8431EE402922D795200@HE1P190MB0331.EURP190.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MJwCh9wcctgVsFsQ281cYfqX27MXAkRoMaSjPeOF5Pt5OPZt6HeAKcX+j+HSV3mWPL7RTtGlp9wfNVxfExmpB2GBgTquuIr1G0iheW4eRzI9iVTee8KB/2Fp+vavD5+ONhQtenaVF2dZBQkQ5kIzVD5mANt4M5BUghd2oO2ED9wwQvGCH/QdHIWJSG1imFFCDjq+eeH6IGZy0U/UhRYJTS5ufV/Vy1tNDgMaumhzi6eHrsXhgFmfqRD25g4SJfssPZMkYs0gHjP7birJ0lNBePFk9jLd9jpyYYvrdx6i91gvmeqcsNQpR4wlvG+cDpxTHi/NsnEaz0qFYRMnnhli361304CEy3PHxY9BRM1dEwkiARMolkYweWbmAgWpAXqy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1P190MB0539.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39830400003)(366004)(396003)(376002)(136003)(346002)(6512007)(6506007)(4326008)(44832011)(36756003)(956004)(26005)(8676002)(2616005)(52116002)(6486002)(16526019)(186003)(2906002)(107886003)(83380400001)(86362001)(6666004)(1076003)(110136005)(5660300002)(8936002)(66946007)(316002)(66476007)(478600001)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: Hgd9HtVj8Yv8VATTUaSS3PI/tXAjg8utIXBAwLMnenQdntPo+vgyA89Q0lOOUkv82eMJv8n620N3T3ceAqGxwRJR0eldKYPUyqPY4+rFT0uOfx6uxUgelWHSmYV0whlVeW7xF9n3k623sBYRljlGtdlc3+kk+5zx03ysUFVEOkGoat1+vByhfgQ7lH0+VbrjwX4wFCFc6jwMA1ejZcKS5dsAyBUgjEjOlEgcAVnldCQcT/tIC0q2Env5eCaykvTQWMJr4OC3pUX3ZxYNmVKWbsx5lOuH/RIlq8HIarhgLsxW5fF0nZ7IXspbKMyuIUbNuaXkterYhTy8il1+2a+/Dp1ycd9w39jNgaWLA2d3BqwuNs7wB8Bj7sCcAmT+YgQ06ayMYjDEYpOGm4ErZneIc0YiuxCzVa37OhLu2LOXUc7QSEMjjX8sRWhJoNRfcWCMHFT3KQv3glalL9iAO+ck9A92vrP3A02Mmx7SiCu0H1B9zQjwakaxwMw1+VRpbKNUiB6WLXEqJHOpOdZRXTClfB3Q0SzofZI++h9JqOBfF4rbkeKfUGmmFfipehbegAHSZgN2N+VyQtMDClSgg32lJQZSPRgquIzvnvtkeuOADmKGAYV34m0xlBPOShkkCdKq4VwkOW21FRVOh5+RmcXVHQ==
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: dcfe46d4-4b37-4b2f-42d9-08d85974ba3b
X-MS-Exchange-CrossTenant-AuthSource: HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2020 12:41:55.0938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7IxsyHRpyGzl7FBMhIEK1GZwj9LxYhVxgVTH72eU7sel+E46a/9Pr/C9mLZ25qvf9iQZzmdCipA9MECfTKL/hCSGwuP62s0z4uOl4hKPzfU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1P190MB0331
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ONIE is a small operating system, pre-installed on bare metal network
switches, that provides an environment for automated provisioning.

This system requires that NVMEM (EEPROM) device holds various system
information (mac address, platform name, etc) in a special TLV layout.

The driver parses ONIE TLV attributes and registers them as NVMEM cells
which can be accessed by other platform driver. Also it allows to use
of_get_mac_address() to retrieve mac address for the netdev.

Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
---
 drivers/nvmem/Kconfig      |   9 +
 drivers/nvmem/Makefile     |   3 +
 drivers/nvmem/onie-cells.c | 348 +++++++++++++++++++++++++++++++++++++
 3 files changed, 360 insertions(+)
 create mode 100644 drivers/nvmem/onie-cells.c

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 954d3b4a52ab..0e27caf4934e 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -270,4 +270,13 @@ config SPRD_EFUSE
 	  This driver can also be built as a module. If so, the module
 	  will be called nvmem-sprd-efuse.
 
+config NVMEM_ONIE_CELLS
+	tristate "ONIE TLV cells support"
+	help
+	  This is a driver to provide cells from ONIE TLV structure stored
+	  on NVMEM device.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called nvmem-onie-cells.
+
 endif
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index a7c377218341..2199784a489f 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -55,3 +55,6 @@ obj-$(CONFIG_NVMEM_ZYNQMP)	+= nvmem_zynqmp_nvmem.o
 nvmem_zynqmp_nvmem-y		:= zynqmp_nvmem.o
 obj-$(CONFIG_SPRD_EFUSE)	+= nvmem_sprd_efuse.o
 nvmem_sprd_efuse-y		:= sprd-efuse.o
+
+obj-$(CONFIG_NVMEM_ONIE_CELLS)	+= nvmem-onie-cells.o
+nvmem-onie-cells-y		:= onie-cells.o
diff --git a/drivers/nvmem/onie-cells.c b/drivers/nvmem/onie-cells.c
new file mode 100644
index 000000000000..4696050e6568
--- /dev/null
+++ b/drivers/nvmem/onie-cells.c
@@ -0,0 +1,348 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * ONIE NVMEM cells provider
+ *
+ * Author: Vadym Kochan <vadym.kochan@plvision.eu>
+ */
+
+#define ONIE_NVMEM_DRVNAME	"onie-nvmem-cells"
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/nvmem-provider.h>
+#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#define ONIE_NVMEM_TLV_MAX_LEN	2048
+
+#define ONIE_NVMEM_HDR_ID	"TlvInfo"
+
+struct onie_nvmem_hdr {
+	u8 id[8];
+	u8 version;
+	__be16 data_len;
+} __packed;
+
+struct onie_nvmem_tlv {
+	u8 type;
+	u8 len;
+	u8 val[0];
+} __packed;
+
+struct onie_nvmem_attr {
+	struct list_head head;
+	const char *name;
+	unsigned int offset;
+	unsigned int len;
+};
+
+struct onie_nvmem {
+	unsigned int attr_count;
+	struct list_head attrs;
+	struct device *dev;
+
+	struct nvmem_cell_lookup *lookup;
+	struct nvmem_cell_table table;
+	struct nvmem_parser *parser;
+};
+
+static bool onie_nvmem_hdr_is_valid(struct onie_nvmem_hdr *hdr)
+{
+	if (memcmp(hdr->id, ONIE_NVMEM_HDR_ID, sizeof(hdr->id)) != 0)
+		return false;
+	if (hdr->version != 0x1)
+		return false;
+
+	return true;
+}
+
+static void onie_nvmem_attrs_free(struct onie_nvmem *onie)
+{
+	struct onie_nvmem_attr *attr, *tmp;
+
+	list_for_each_entry_safe(attr, tmp, &onie->attrs, head) {
+		list_del(&attr->head);
+		kfree(attr);
+	}
+}
+
+static const char *onie_nvmem_attr_name(u8 type)
+{
+	switch (type) {
+	case 0x21: return "product-name";
+	case 0x22: return "part-number";
+	case 0x23: return "serial-number";
+	case 0x24: return "mac-address";
+	case 0x25: return "manufacture-date";
+	case 0x26: return "device-version";
+	case 0x27: return "label-revision";
+	case 0x28: return "platforn-name";
+	case 0x29: return "onie-version";
+	case 0x2A: return "num-macs";
+	case 0x2B: return "manufacturer";
+	case 0x2C: return "country-code";
+	case 0x2D: return "vendor";
+	case 0x2E: return "diag-version";
+	case 0x2F: return "service-tag";
+	case 0xFD: return "vendor-extension";
+	case 0xFE: return "crc32";
+
+	default: return "unknown";
+	}
+}
+
+static int onie_nvmem_tlv_parse(struct onie_nvmem *onie, u8 *data, u16 len)
+{
+	unsigned int hlen = sizeof(struct onie_nvmem_hdr);
+	unsigned int offset = 0;
+	int err;
+
+	onie->attr_count = 0;
+
+	while (offset < len) {
+		struct onie_nvmem_attr *attr;
+		struct onie_nvmem_tlv *tlv;
+
+		tlv = (struct onie_nvmem_tlv *)(data + offset);
+
+		if (offset + tlv->len >= len) {
+			dev_err(onie->dev, "TLV len is too big(0x%x) at 0x%x\n",
+				tlv->len, hlen + offset);
+
+			/* return success in case something was parsed */
+			return 0;
+		}
+
+		attr = kmalloc(sizeof(*attr), GFP_KERNEL);
+		if (!attr) {
+			err = -ENOMEM;
+			goto err_attr_alloc;
+		}
+
+		attr->name = onie_nvmem_attr_name(tlv->type);
+		/* skip 'type' and 'len' */
+		attr->offset = hlen + offset + 2;
+		attr->len = tlv->len;
+
+		list_add(&attr->head, &onie->attrs);
+		onie->attr_count++;
+
+		offset += sizeof(*tlv) + tlv->len;
+	}
+
+	if (!onie->attr_count)
+		return -EINVAL;
+
+	return 0;
+
+err_attr_alloc:
+	onie_nvmem_attrs_free(onie);
+	return err;
+}
+
+static int
+onie_nvmem_decode(struct onie_nvmem *onie, struct nvmem_device *nvmem)
+{
+	struct onie_nvmem_hdr hdr;
+	u8 *data;
+	u16 len;
+	int ret;
+
+	ret = nvmem_device_read(nvmem, 0, sizeof(hdr), &hdr);
+	if (ret < 0)
+		return ret;
+
+	if (!onie_nvmem_hdr_is_valid(&hdr)) {
+		dev_err(onie->dev, "invalid ONIE TLV header\n");
+		return -EINVAL;
+	}
+
+	len = be16_to_cpu(hdr.data_len);
+
+	if (len > ONIE_NVMEM_TLV_MAX_LEN)
+		len = ONIE_NVMEM_TLV_MAX_LEN;
+
+	data = kmalloc(len, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	ret = nvmem_device_read(nvmem, sizeof(hdr), len, data);
+	if (ret < 0)
+		goto err_data_read;
+
+	ret = onie_nvmem_tlv_parse(onie, data, len);
+	if (ret)
+		goto err_info_parse;
+
+	kfree(data);
+
+	return 0;
+
+err_info_parse:
+err_data_read:
+	kfree(data);
+	return ret;
+}
+
+static int onie_nvmem_cells_parse(struct onie_nvmem *onie,
+				  struct nvmem_device *nvmem,
+				  struct nvmem_cell_table *table)
+{
+	struct nvmem_cell_info *cells;
+	struct onie_nvmem_attr *attr;
+	unsigned int ncells = 0;
+	int err;
+
+	INIT_LIST_HEAD(&onie->attrs);
+	onie->attr_count = 0;
+
+	err = onie_nvmem_decode(onie, nvmem);
+	if (err)
+		return err;
+
+	cells = kmalloc_array(onie->attr_count, sizeof(*cells), GFP_KERNEL);
+	if (!cells) {
+		err = -ENOMEM;
+		goto err_cells_alloc;
+	}
+
+	onie->lookup = kmalloc_array(onie->attr_count,
+				     sizeof(struct nvmem_cell_lookup),
+				     GFP_KERNEL);
+	if (!onie->lookup) {
+		err = -ENOMEM;
+		goto err_lookup_alloc;
+	}
+
+	list_for_each_entry(attr, &onie->attrs, head) {
+		struct nvmem_cell_lookup *lookup;
+		struct nvmem_cell_info *cell;
+
+		cell = &cells[ncells];
+
+		lookup = &onie->lookup[ncells];
+		lookup->con_id = NULL;
+
+		cell->offset = attr->offset;
+		cell->name = attr->name;
+		cell->bytes = attr->len;
+		cell->bit_offset = 0;
+		cell->nbits = 0;
+
+		lookup->nvmem_name = nvmem_dev_name(nvmem);
+		lookup->dev_id = dev_name(onie->dev);
+		lookup->cell_name = cell->name;
+		lookup->con_id = cell->name;
+
+		ncells++;
+	}
+
+	table->nvmem_name = nvmem_dev_name(nvmem);
+	table->ncells = ncells;
+	table->cells = cells;
+
+	onie_nvmem_attrs_free(onie);
+
+	return 0;
+
+err_lookup_alloc:
+	kfree(cells);
+err_cells_alloc:
+	onie_nvmem_attrs_free(onie);
+
+	return err;
+}
+
+static void onie_cells_parse(void *priv, struct nvmem_device *nvmem)
+{
+	struct onie_nvmem *onie = priv;
+	int err;
+
+	err = onie_nvmem_cells_parse(onie, nvmem, &onie->table);
+	if (err) {
+		dev_err(onie->dev, "failed to parse ONIE attributes\n");
+		return;
+	}
+
+	nvmem_add_cell_lookups(onie->lookup, onie->table.ncells);
+	nvmem_add_cell_table(&onie->table);
+}
+
+static int onie_nvmem_probe(struct platform_device *pdev)
+{
+	struct nvmem_parser_config parser_config = { };
+	struct device *dev = &pdev->dev;
+	struct onie_nvmem *onie;
+
+	onie = kzalloc(sizeof(*onie), GFP_KERNEL);
+	if (!onie)
+		return -ENOMEM;
+
+	onie->dev = dev;
+
+	dev_set_drvdata(dev, onie);
+
+	parser_config.cells_parse = onie_cells_parse;
+	parser_config.priv = onie;
+	parser_config.dev = dev;
+
+	onie->parser = nvmem_parser_register(&parser_config);
+	if (IS_ERR(onie->parser))
+		return PTR_ERR(onie->parser);
+
+	return 0;
+}
+
+static int onie_nvmem_remove(struct platform_device *pdev)
+{
+	struct onie_nvmem *onie = dev_get_drvdata(&pdev->dev);
+
+	if (onie->lookup)
+		nvmem_del_cell_lookups(onie->lookup, onie->attr_count);
+	if (onie->table.cells)
+		nvmem_del_cell_table(&onie->table);
+	nvmem_parser_unregister(onie->parser);
+	kfree(onie->table.cells);
+	kfree(onie->lookup);
+	kfree(onie);
+
+	return 0;
+}
+
+static const struct of_device_id onie_nvmem_match[] = {
+	{
+		.compatible = "onie-nvmem-cells",
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, onie_nvmem_match);
+
+static struct platform_driver onie_nvmem_driver = {
+	.probe = onie_nvmem_probe,
+	.remove = onie_nvmem_remove,
+	.driver = {
+		.name = ONIE_NVMEM_DRVNAME,
+		.of_match_table = onie_nvmem_match,
+	},
+};
+
+static int __init onie_nvmem_init(void)
+{
+	return platform_driver_register(&onie_nvmem_driver);
+}
+
+static void __exit onie_nvmem_exit(void)
+{
+	platform_driver_unregister(&onie_nvmem_driver);
+}
+
+subsys_initcall(onie_nvmem_init);
+module_exit(onie_nvmem_exit);
+
+MODULE_AUTHOR("Vadym Kochan <vadym.kochan@plvision.eu>");
+MODULE_DESCRIPTION("ONIE NVMEM cells driver");
+MODULE_LICENSE("GPL");
-- 
2.17.1

