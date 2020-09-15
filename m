Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A210626A590
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 14:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgIOMux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 08:50:53 -0400
Received: from mail-db8eur05on2126.outbound.protection.outlook.com ([40.107.20.126]:25121
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726343AbgIOMmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 08:42:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mNK4vBVzZptl7akA0I6ukRFb0z7HK15/iK5YOS1aYV+BFWaZwmGqIa1+FGuxvAhrH9Kj/fIUKr/ZynA+y2QScb9ql9oE6AuSPxcNEceIqeD+HwseJ+g6+d5cer7jH3K1OT97NMAFENnlD2/50glAYyjG4N2vJhNq7ga1/l3qPdihV+1hU32TvCja9VrWreJPoKY9Nv7iTv/hOWlxdjKBK+LF2mPUgrl7jTquKd2sSiTMALQmY/L0fWIDGXEU9EDqvcq8aTkCz0yw16lg+WAMhu+E0cXJxJuaqYw6mX1STEDbtUkESODbvIJQGKgsxSO5hhEv8fjdX+8+lK66qkgAXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2+/4quCPJAGAvDqOL5gpZ1mSwdem1kuLNV96Y4DLWI=;
 b=OcEJKfEgsxWxVuYDrMhAlCA6LYY7RD2GnEWYYwyMcEOvkBV/SqW/KGFIl3Kr7DTJS3oRYpLoYuE7fAXbvpkoI16VI7ZkTDz/AzkdwSuaaxNfoBhVjYoozT8l8dqz8rnZkoPW7+htqOEzUDjMQMi95Xsm/dUU3+LFBxZYQufE3MSX3Q3mpv+wO+MJYopApO32IsxOAzIpa5a52XTTQc3CAqGWRcDKwURr0fLF55AlGNp4xOtd37Yii6dLIyHaFX5YjAuo2/yGIR1LjzHNoxsB6py9p6WuYTRfR1AhiSwUFHbkY/agddaLOKYRCg7ho52oWo6GQ68pcA8YuPESQ8JDlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2+/4quCPJAGAvDqOL5gpZ1mSwdem1kuLNV96Y4DLWI=;
 b=EnfOov8aks/dEW/2wBWPArwb6zQ1df3eLGCTigcVAMpUTanOySJwGtJyZmD1PhVJ2Q/6VASZzM3kiXBPSua3xcpLJBDoKYN4k+GeJkk8XSZFLQjOH+tWXMpc0eh2QK5x7GyCs2u8kqtMnmMqj83I2sKbhIyM34W9N6HSbZDfmMQ=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=plvision.eu;
Received: from HE1P190MB0539.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:56::28) by
 HE1P190MB0300.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:5c::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16; Tue, 15 Sep 2020 12:41:54 +0000
Received: from HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 ([fe80::c1ab:71de:6bc2:89fe]) by HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 ([fe80::c1ab:71de:6bc2:89fe%6]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 12:41:54 +0000
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Vadym Kochan <vadym.kochan@plvision.eu>
Subject: [PATCH 1/3] nvmem: core: introduce cells parser
Date:   Tue, 15 Sep 2020 15:41:14 +0300
Message-Id: <20200915124116.7196-2-vadym.kochan@plvision.eu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200915124116.7196-1-vadym.kochan@plvision.eu>
References: <20200915124116.7196-1-vadym.kochan@plvision.eu>
Content-Type: text/plain
X-ClientProxiedBy: AM6P194CA0033.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:90::46) To HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:7:56::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pc60716vkochan.x.ow.s (217.20.186.93) by AM6P194CA0033.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:90::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Tue, 15 Sep 2020 12:41:53 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [217.20.186.93]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd49f04f-8f56-4810-0b5a-08d85974b9b7
X-MS-TrafficTypeDiagnostic: HE1P190MB0300:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1P190MB0300C74101718E440EB3BABC95200@HE1P190MB0300.EURP190.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ip3InMfLRM1ox+9xEvmU0BgtYmqIM5b/2NuCU/D1O/4raZTpwWiCLdbq6BF5ZhB+qQyTReaPXg69RHtpAVTn/a/S1S4iIbtYqS9tYpzUfrML3EmuoptWcARnWBzdJoQL3BP6eUOmD5Aet71V+W/AJOqGYeCMVxSYS+16cicoD7iN/XiQPmWylikHxYrs405cQR2F3f0/7wi5hJhKZz03QbamOm4GJECe/bqGyCYOT1OM9JD0w63vnwAbS8ohA0CyUbZ1nGO2KEEDJZxjA2vG/Sk2lV/OR+tiDmx3NHGCOzhnOLK/dggizI10OFk0J+X9/nTopOwcRFHxHnFZy0sj6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1P190MB0539.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(396003)(39830400003)(376002)(366004)(136003)(1076003)(956004)(2616005)(86362001)(4326008)(478600001)(107886003)(66946007)(8676002)(6486002)(316002)(6512007)(66556008)(110136005)(66476007)(186003)(16526019)(5660300002)(44832011)(8936002)(6506007)(26005)(6666004)(2906002)(83380400001)(36756003)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: d3U75iOq4Og0LygjVRC9M+RHiOkMtv2lZBUsZmU7GkRaHvqTs4/ZB1UPlUmbYlGkkR90BKib5nlXW1QdKf7yLH8zk7s1pqqydPLKVISVWjyq2hJdib4zfrNRz70Hl606JdB5zMLjSgDUYtlAb3NG03fFbDco3LLew6gdlWx4WIvIVhKdFQgpg/vil1YihPrgBPamV7XwUl/ByJ++xNSEMaMwqbKTdR4rA9GMsCJpU3Ee0F1UopFZHB6DDqE8jfc+9tp7rQ/43gCSU9kLL3JFec5k8w+cq/3q40dGg2JUCeaCFMbfKmvbe1kXwjtiGvDj8nB5HUT9fF+B8zG1parBa7RPwmo6HhCBjvuDM+PHA19U7QYaEINjinGIdLJVrczx0J9vEMjOy46IFvN9zTgLWDuyCwBRhlKTXhqoFCFfJwuLNQZc5nSbr1xU13OFI5WTlmCJdBcI9zgjTRfCkFJsiMxUYNYZMlsUEd2DoJ7iELALWcI9YOL+UdWCCr5w4uPgtyFkaGX66RwDseLLNilzyENwWVrBk7C8GBzzRkNMbMkK7SB/eHCl07L9RTuCslCBQIYZMzuEXkpynHA+SsAzoHSq9h3JV7+bj4lU//3CxHWT2/fU8v5JC6axTqVcgVS4My2oa+KHFBPmhwzBei6eXA==
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: cd49f04f-8f56-4810-0b5a-08d85974b9b7
X-MS-Exchange-CrossTenant-AuthSource: HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2020 12:41:54.1793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g2+YIREzqxBBhznEszj03xbhOZVS9G6cEbaEMGQMTl9L8w+NZltC5lerj5HQv+aopMXQb1adbWZs6p4q+/LcsFzaiFkUJlzvO46lfP9Wlcc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1P190MB0300
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently NVMEM core does not allow to register cells for an already
registered nvmem device and requires that this should be done before.
But there might a driver which needs to parse the nvmem device and then
register a cells table.

Introduce nvmem_parser API which allows to register cells parser which
is called during nvmem device registration. During this stage the parser
can read the nvmem device and register the cells table.

Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
---
 drivers/nvmem/core.c           | 89 ++++++++++++++++++++++++++++++++++
 include/linux/nvmem-provider.h | 27 +++++++++++
 2 files changed, 116 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 6cd3edb2eaf6..82a96032bc3f 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -55,6 +55,14 @@ struct nvmem_cell {
 	struct list_head	node;
 };
 
+struct nvmem_parser {
+	struct device_node	*nvmem_of;
+	struct kref		refcnt;
+	struct list_head	head;
+	nvmem_parse_t		cells_parse;
+	void *priv;
+};
+
 static DEFINE_MUTEX(nvmem_mutex);
 static DEFINE_IDA(nvmem_ida);
 
@@ -64,6 +72,9 @@ static LIST_HEAD(nvmem_cell_tables);
 static DEFINE_MUTEX(nvmem_lookup_mutex);
 static LIST_HEAD(nvmem_lookup_list);
 
+static DEFINE_MUTEX(nvmem_parser_mutex);
+static LIST_HEAD(nvmem_parser_list);
+
 static BLOCKING_NOTIFIER_HEAD(nvmem_notifier);
 
 static int nvmem_reg_read(struct nvmem_device *nvmem, unsigned int offset,
@@ -571,6 +582,30 @@ static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
 	return 0;
 }
 
+static struct nvmem_parser *
+__nvmem_parser_find_of(const struct nvmem_device *nvmem)
+{
+	struct nvmem_parser *parser;
+
+	list_for_each_entry(parser, &nvmem_parser_list, head) {
+		if (dev_of_node(nvmem->base_dev) == parser->nvmem_of)
+			return parser;
+	}
+
+	return NULL;
+}
+
+static void nvmem_cells_parse(struct nvmem_device *nvmem)
+{
+	struct nvmem_parser *parser;
+
+	mutex_lock(&nvmem_parser_mutex);
+	parser = __nvmem_parser_find_of(nvmem);
+	if (parser && parser->cells_parse)
+		parser->cells_parse(parser->priv, nvmem);
+	mutex_unlock(&nvmem_parser_mutex);
+}
+
 /**
  * nvmem_register() - Register a nvmem device for given nvmem_config.
  * Also creates a binary entry in /sys/bus/nvmem/devices/dev-name/nvmem
@@ -674,6 +709,8 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 			goto err_teardown_compat;
 	}
 
+	nvmem_cells_parse(nvmem);
+
 	rval = nvmem_add_cells_from_table(nvmem);
 	if (rval)
 		goto err_remove_cells;
@@ -1630,6 +1667,58 @@ const char *nvmem_dev_name(struct nvmem_device *nvmem)
 }
 EXPORT_SYMBOL_GPL(nvmem_dev_name);
 
+struct nvmem_parser *
+nvmem_parser_register(const struct nvmem_parser_config *config)
+{
+	struct device_node *nvmem_of;
+	struct nvmem_parser *parser;
+	int err;
+
+	if (!config->cells_parse)
+		return ERR_PTR(-EINVAL);
+
+	if (!config->dev)
+		return ERR_PTR(-EINVAL);
+
+	nvmem_of = of_parse_phandle(dev_of_node(config->dev), "nvmem", 0);
+	if (!nvmem_of)
+		return ERR_PTR(-EINVAL);
+
+	parser = kzalloc(sizeof(*parser), GFP_KERNEL);
+	if (!parser) {
+		err = -ENOMEM;
+		goto err_alloc;
+	}
+
+	parser->cells_parse = config->cells_parse;
+	/* parser->cells_remove = config->cells_remove; */
+	parser->nvmem_of = nvmem_of;
+	parser->priv = config->priv;
+	kref_init(&parser->refcnt);
+
+	mutex_lock(&nvmem_parser_mutex);
+	list_add(&parser->head, &nvmem_parser_list);
+	mutex_unlock(&nvmem_parser_mutex);
+
+	return parser;
+
+err_alloc:
+	of_node_put(nvmem_of);
+
+	return ERR_PTR(err);
+}
+EXPORT_SYMBOL(nvmem_parser_register);
+
+void nvmem_parser_unregister(struct nvmem_parser *parser)
+{
+	mutex_lock(&nvmem_parser_mutex);
+	of_node_put(parser->nvmem_of);
+	list_del(&parser->head);
+	kfree(parser);
+	mutex_unlock(&nvmem_parser_mutex);
+}
+EXPORT_SYMBOL(nvmem_parser_unregister);
+
 static int __init nvmem_init(void)
 {
 	return bus_register(&nvmem_bus_type);
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 06409a6c40bc..854d0cf5234f 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -15,10 +15,13 @@
 
 struct nvmem_device;
 struct nvmem_cell_info;
+struct nvmem_cell_table;
+
 typedef int (*nvmem_reg_read_t)(void *priv, unsigned int offset,
 				void *val, size_t bytes);
 typedef int (*nvmem_reg_write_t)(void *priv, unsigned int offset,
 				 void *val, size_t bytes);
+typedef void (*nvmem_parse_t)(void *priv, struct nvmem_device *nvmem);
 
 enum nvmem_type {
 	NVMEM_TYPE_UNKNOWN = 0,
@@ -100,6 +103,12 @@ struct nvmem_cell_table {
 	struct list_head	node;
 };
 
+struct nvmem_parser_config {
+	nvmem_parse_t	cells_parse;
+	void		*priv;
+	struct device	*dev;
+};
+
 #if IS_ENABLED(CONFIG_NVMEM)
 
 struct nvmem_device *nvmem_register(const struct nvmem_config *cfg);
@@ -110,9 +119,19 @@ struct nvmem_device *devm_nvmem_register(struct device *dev,
 
 int devm_nvmem_unregister(struct device *dev, struct nvmem_device *nvmem);
 
+int nvmem_cell_parser_register(const char *nvmem_name,
+			       const struct nvmem_config *cfg);
+void nvmem_cell_parser_unregister(const char *nvmem_name,
+				  const struct nvmem_config *cfg);
+
 void nvmem_add_cell_table(struct nvmem_cell_table *table);
 void nvmem_del_cell_table(struct nvmem_cell_table *table);
 
+struct nvmem_parser *
+nvmem_parser_register(const struct nvmem_parser_config *config);
+
+void nvmem_parser_unregister(struct nvmem_parser *parser);
+
 #else
 
 static inline struct nvmem_device *nvmem_register(const struct nvmem_config *c)
@@ -137,5 +156,13 @@ devm_nvmem_unregister(struct device *dev, struct nvmem_device *nvmem)
 static inline void nvmem_add_cell_table(struct nvmem_cell_table *table) {}
 static inline void nvmem_del_cell_table(struct nvmem_cell_table *table) {}
 
+static inline struct nvmem_parser *
+nvmem_parser_register(const struct nvmem_parser_config *config)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void nvmem_parser_unregister(struct nvmem_parser *parser) {}
+
 #endif /* CONFIG_NVMEM */
 #endif  /* ifndef _LINUX_NVMEM_PROVIDER_H */
-- 
2.17.1

