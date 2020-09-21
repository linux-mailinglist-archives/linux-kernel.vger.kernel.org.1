Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6792736E9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 01:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729003AbgIUXxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 19:53:09 -0400
Received: from mail-vi1eur05on2108.outbound.protection.outlook.com ([40.107.21.108]:48225
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728990AbgIUXxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 19:53:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bDlORKVDw4Sb5OWgCG0j0qqmtwwoYoT2wrxhCICQ8SPE6r7EMMRC14aLRluSJIeGDz9FmCykWGlotPpH+SlD7Usxm52/vsujIP9skDgtVdrnm+GycL/+SPQynxEpsDLaqn8r4EmYR8988lkS4LdrwdCVFJibvyDmNutL7BFnnsND7MvVn410MBlx++ODFpF+e90p7eIIa136yHOeauhYHms0rc8KG+355yP7/wsN7X9lbkW0NyJpuF1IS4B5maOA0wAoTNLF0h8WwlNFxCB9aYA8i1ZQma8hXvagvXgkDdsp+P/dSjk3QY+H74RwwqAXo6H4D8sm5FlXqp+ROSIL+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQMT0kuSbRNT9Gb4Lb8PmLMTUD4P2gMU1wIjpZyHZrQ=;
 b=Qdm5aYB29zIGWKPKwhUDCNkhK0eePAXnSa0rCNaHTQZHpTQCEK5GPFvVt7rPUemAgO5LsDZV2JxekbHaTDX/K4V8IGyvBEgRLI7SpTpQpgiM5oZPAiEHUsQPnDW2seeOz4hTroUO9ziw6hn9UXsJpXinwkQVJuAuH3ysENkZz9SYMA6hsn+uC4AYaAPywFtFg1T+UXl0gb7X0uWJEm4Gpw/QWPUE8Ta6pFFFvf+rFJz2vNsHqcytuv9kZINtsF8V15aG86b+tQ1ghekAUohhZsbYudoql1iWceU1u55yiC0n3OKanpStyvj6oL5bsx6Im2VsasL3KHU3IAKdJEoffQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQMT0kuSbRNT9Gb4Lb8PmLMTUD4P2gMU1wIjpZyHZrQ=;
 b=iAF+A/myfF4/+4DWO0RyFozXeARiA4QGKDkEysdtUHZHDprRoZd4/19BpKqDkwo28gFLyaOKWnz4Gh4sAxQaarDdwVW40ffY5Y4XhFa4Jm3Nx5mu9GYmRDHPG+oYcDnD5JxalP5KJ1IIU09BVnZBfXKS8+fnwP1OdaYoP8C7b9c=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=plvision.eu;
Received: from HE1P190MB0539.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:56::28) by
 HE1P190MB0299.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:55::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11; Mon, 21 Sep 2020 23:52:55 +0000
Received: from HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 ([fe80::c1ab:71de:6bc2:89fe]) by HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 ([fe80::c1ab:71de:6bc2:89fe%6]) with mapi id 15.20.3391.019; Mon, 21 Sep 2020
 23:52:55 +0000
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Vadym Kochan <vadym.kochan@plvision.eu>
Subject: [PATCH 1/2] nvmem: add ONIE nvmem provider
Date:   Tue, 22 Sep 2020 02:52:36 +0300
Message-Id: <20200921235237.7980-2-vadym.kochan@plvision.eu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200921235237.7980-1-vadym.kochan@plvision.eu>
References: <20200921235237.7980-1-vadym.kochan@plvision.eu>
Content-Type: text/plain
X-ClientProxiedBy: AM5PR1001CA0069.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:206:15::46) To HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:7:56::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pc60716vkochan.x.ow.s (217.20.186.93) by AM5PR1001CA0069.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:206:15::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.13 via Frontend Transport; Mon, 21 Sep 2020 23:52:54 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [217.20.186.93]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 132405d3-0053-41f3-3392-08d85e8975df
X-MS-TrafficTypeDiagnostic: HE1P190MB0299:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1P190MB02992642F234435C29E48158953A0@HE1P190MB0299.EURP190.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NXCGCsaL3tCLvGf6jrDIVePp2sdAoAu9omI7utTgZnRYALGhnou37DHpL0wyQm7ipHW8K+UTP8RRBB3+fNL+Bz5NQT4aAlxCRlPRAp3uTS63rRghhizd+cBftYjSOIEwxeuTlyq5+9vq/Usx9RrYDF4ckwS71N4QnZahrPwzstlc7z/LFhSge+Va2pOTvjQSwnipeDCX5Fz1w5N77FpXoWIBprdH9LZPMBMBa/C4cBVrNKqYRH79iC98dycf++F/7KgBYLD6oygCK4v3L5tB9/Vc2qXJdtUppzVRtBbwrq4Izid8wjf89+6mtYCbTn9Dp15aW/vItxEd0OYnT6ILPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1P190MB0539.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39830400003)(396003)(366004)(376002)(346002)(136003)(8936002)(2616005)(110136005)(316002)(8676002)(44832011)(956004)(4326008)(6506007)(52116002)(107886003)(83380400001)(478600001)(6512007)(66476007)(66556008)(6666004)(36756003)(2906002)(1076003)(5660300002)(16526019)(186003)(66946007)(86362001)(26005)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: x68LN8jr1WKASCViHQFfxK0XGuawfVy9YUcBDMM2wXnGqh0cQ4gm949Sh7IWhDBPiWz1fJ6V6Ef9DX+P/v2t3AzsdhHycfvvDoeMtqrRKZqPZVj6HyQ0u3VB8Vy9rNao5tX48ueycGy3KNjSFFA0FcUuYWQ0jl8zrf6XKAkFm8uVScoh6S2+BdUNshpWhEhgETUBgJ+4ZcrbzwbRILeV6AMevy9pQ9R/24OxC3QXvzs14VpuGnFoPwUrZ7nat09lLRtF/lpzN8ERAZHmeO1J4vEF0VN1HC22fLOUhtRcvw8sssoSTX0+4MUnkHzrDT13XRD992SBiFJtRGPlvTnvaEwmgb/q890YVCC4B37Bi/TctXwNJIo/QoxIx4AslATg7J557KBccCivN2Y8KuL8r3uGWtatl1jkok7qbnP6PL9mcMcOK74yjTkAk6CK6FhfhT0gWCB88Yr59jq3hXheggVCrmDi26bCX8kSuC2un6IU2igMy/0eChlpGPKppgwSy0YGi0ZLgzekPC3l84TZcs39ZX2BHmwfJ+0KFa4l+KejLi89nu63+XN4EMOOxkq6E4ZGQRRNaE5rYLWTpSGi2LEqdmJkxdSIuBlp5EPkEvVzp/Zi/LZyWj9VQB5nqs9bTrZC5BxQaiUi+JertLpu1Q==
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 132405d3-0053-41f3-3392-08d85e8975df
X-MS-Exchange-CrossTenant-AuthSource: HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2020 23:52:55.7035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BGXdHkTgn/ybaTOy9ad+kjEkLduEPGX/xqRjtMVLzJfTlLVM4g868N2UXZb5Uyw+T21+4R5vS3n2pbkm7I635zys/W2uvem885hqf8Yibc8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1P190MB0299
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

The provider differs from the normal NVMEM providers that it is not
depends on particular storage but uses other nvmem as accessor for
reading the cell, and proxies the reg_read() call to this device driver.

Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
---
 drivers/nvmem/Kconfig  |   9 ++
 drivers/nvmem/Makefile |   2 +
 drivers/nvmem/onie.c   | 357 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 368 insertions(+)
 create mode 100644 drivers/nvmem/onie.c

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 954d3b4a52ab..77387bd13105 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -270,4 +270,13 @@ config SPRD_EFUSE
 	  This driver can also be built as a module. If so, the module
 	  will be called nvmem-sprd-efuse.
 
+config NVMEM_ONIE
+	tristate "ONIE NVMEM support"
+	help
+	  This is a driver to provide cells from ONIE TLV structure stored
+	  on NVMEM device.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called nvmem-onie.
+
 endif
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index a7c377218341..fbf30c94447e 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -55,3 +55,5 @@ obj-$(CONFIG_NVMEM_ZYNQMP)	+= nvmem_zynqmp_nvmem.o
 nvmem_zynqmp_nvmem-y		:= zynqmp_nvmem.o
 obj-$(CONFIG_SPRD_EFUSE)	+= nvmem_sprd_efuse.o
 nvmem_sprd_efuse-y		:= sprd-efuse.o
+obj-$(CONFIG_NVMEM_ONIE)	+= nvmem-onie.o
+nvmem-onie-y			:= onie.o
diff --git a/drivers/nvmem/onie.c b/drivers/nvmem/onie.c
new file mode 100644
index 000000000000..5f280f227b44
--- /dev/null
+++ b/drivers/nvmem/onie.c
@@ -0,0 +1,357 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * ONIE NVMEM provider
+ *
+ * Author: Vadym Kochan <vadym.kochan@plvision.eu>
+ */
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
+	struct nvmem_cell_lookup *lookup;
+	struct nvmem_cell_info *cells;
+	int ncells;
+	struct nvmem_device *nvmem;
+	unsigned int attr_count;
+	struct list_head attrs;
+	struct device *dev;
+	u8 version;
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
+	default: return NULL;
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
+		const char *name;
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
+		name = onie_nvmem_attr_name(tlv->type);
+		if (!name)
+			goto onie_next_tlv;
+
+		attr = kmalloc(sizeof(*attr), GFP_KERNEL);
+		if (!attr) {
+			err = -ENOMEM;
+			goto err_attr_alloc;
+		}
+
+		/* skip 'type' and 'len' */
+		attr->offset = hlen + offset + 2;
+		attr->len = tlv->len;
+		attr->name = name;
+
+		list_add(&attr->head, &onie->attrs);
+		onie->attr_count++;
+
+onie_next_tlv:
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
+	onie->version = hdr.version;
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
+				  struct nvmem_device *nvmem)
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
+		cell->offset = attr->offset;
+		cell->name = attr->name;
+		cell->bytes = attr->len;
+		cell->bit_offset = 0;
+		cell->nbits = 0;
+
+		lookup = &onie->lookup[ncells];
+
+		lookup->nvmem_name = "onie0";
+		lookup->dev_id = dev_name(onie->dev);
+		lookup->cell_name = cell->name;
+		lookup->con_id = cell->name;
+
+		ncells++;
+	}
+
+	onie->ncells = ncells;
+	onie->cells = cells;
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
+static int onie_nvmem_read(void *priv, unsigned int off, void *val, size_t count)
+{
+	struct onie_nvmem *onie = priv;
+	int rc;
+
+	rc = nvmem_device_read(onie->nvmem, off, count, val);
+	if (rc != count)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int onie_nvmem_probe(struct platform_device *pdev)
+{
+	struct nvmem_config nvmem_config = { };
+	struct device *dev = &pdev->dev;
+	struct onie_nvmem *onie;
+	int err;
+
+	onie = devm_kzalloc(dev, sizeof(*onie), GFP_KERNEL);
+	if (!onie)
+		return -ENOMEM;
+
+	onie->nvmem = of_nvmem_device_get(dev_of_node(dev), NULL);
+	if (IS_ERR(onie->nvmem))
+		return PTR_ERR(onie->nvmem);
+
+	onie->dev = dev;
+
+	dev_set_drvdata(dev, onie);
+
+	err = onie_nvmem_cells_parse(onie, onie->nvmem);
+	if (err) {
+		dev_err(onie->dev, "failed to parse ONIE attributes\n");
+		goto err_nvmem_put;
+	}
+
+	nvmem_add_cell_lookups(onie->lookup, onie->ncells);
+
+	nvmem_config.id = 0;
+	nvmem_config.name = "onie";
+	nvmem_config.base_dev = dev;
+	nvmem_config.dev = dev;
+	nvmem_config.owner = THIS_MODULE;
+	nvmem_config.reg_read = onie_nvmem_read;
+	nvmem_config.priv = onie;
+	nvmem_config.ncells = onie->ncells;
+	nvmem_config.cells = onie->cells;
+
+	err = PTR_ERR_OR_ZERO(devm_nvmem_register(dev, &nvmem_config));
+
+err_nvmem_put:
+	if (err)
+		nvmem_device_put(onie->nvmem);
+	else
+		dev_info(dev, "ONIE TLV v%u\n", onie->version);
+
+	return err;
+}
+
+static int onie_nvmem_remove(struct platform_device *pdev)
+{
+	struct onie_nvmem *onie = dev_get_drvdata(&pdev->dev);
+
+	nvmem_del_cell_lookups(onie->lookup, onie->attr_count);
+	nvmem_device_put(onie->nvmem);
+	kfree(onie->lookup);
+	kfree(onie->cells);
+	kfree(onie);
+
+	return 0;
+}
+
+static const struct of_device_id onie_nvmem_match[] = {
+	{
+		.compatible = "onie-nvmem",
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, onie_nvmem_match);
+
+static struct platform_driver onie_nvmem_driver = {
+	.probe = onie_nvmem_probe,
+	.remove = onie_nvmem_remove,
+	.driver = {
+		.name = "onie-nvmem",
+		.of_match_table = onie_nvmem_match,
+	},
+};
+module_platform_driver(onie_nvmem_driver);
+
+MODULE_AUTHOR("Vadym Kochan <vadym.kochan@plvision.eu>");
+MODULE_DESCRIPTION("ONIE NVMEM driver");
+MODULE_LICENSE("GPL");
-- 
2.17.1

