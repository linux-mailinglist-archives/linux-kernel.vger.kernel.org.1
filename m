Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2524273FA4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 12:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbgIVKbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 06:31:50 -0400
Received: from mail-eopbgr10057.outbound.protection.outlook.com ([40.107.1.57]:6846
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726353AbgIVKbu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 06:31:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DlvxxMU94tMFkY2WP+ZQA7pEWTOmPP0MGSTvyjGexZzgCeMvKMP/VQqNAK40kJ5Bs55yKCwRYo+c0rmAnSPGyxqurCj9BiMJORLAQkLElTwl/WM2Erggq3VQ4Hl8cSd63SHSWneBZuB6jRxbh6qqr7nU4l5fM551tuJD2OY2bztsRRZKNpC/9pH/I4HI8LXpQ2a7QQpxb/FQUaCkHpwr6PG5gqM1HLclq4+luamgUFabnHBOMp6BVEJwu0zCxOhK2bvWSI/zZAj1bUTwydzFgJqj6k7feogYNC/bBfF3fICe5yRsHaAMQ+Wrxuyx2PwD50CMcqO3s272MmnTeuzxMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/DSQh/FeDXLAuhm6emv3L7q7ZObCJNprLI9V+TMMmTA=;
 b=VRkz05IXm0aUJcW0m5Cc4S2INyIhV7WDyoDQ7ADIWy2KlkwqGoAqL4+rQtikltPeDbPZX3yEOIy796NQc5Xm2SD1yzIul35QnVkn4+XPmo/RK/hM4BFJDy5XiL7/ih5LBrzaZTlxyvb6I4/Bc7+bRPgiK0T6nW05RpQZzzxCUZZwwS0+GHlTNUhl4ra6x4LyFrx192GEOqQ6GNycsHcCFEzizWeCxEgcjkRKf/yE/ctPj0ZhdJ+BaRmVwfO79EuZ9g8Lbx1VgOsuoWfrL28JqFHAlGWCr8S0rgf5mgR39Yg3UtPnd/EMOnwlGpcgM6jxjh7hIldfFIqFgW8U2r4QLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/DSQh/FeDXLAuhm6emv3L7q7ZObCJNprLI9V+TMMmTA=;
 b=cXA/hzQ/toGv7A+llg4JtiXh9QjVFPJchCE6Np14kU+abq0B7vl+Ca3UssrbkPmwmNaML7LSVYIcQX3TJIa81gJZNYKCfQIt0FJZqCR1ECOdD+mZJomAZLgMA+5jUlwDEkRVKSjCgcfUeZgRUqNjX6wzG90h3RJhidRw2il0cyY=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB8PR04MB6858.eurprd04.prod.outlook.com (2603:10a6:10:113::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.26; Tue, 22 Sep
 2020 10:31:45 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::39ff:13b4:4f28:1413]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::39ff:13b4:4f28:1413%10]) with mapi id 15.20.3391.027; Tue, 22 Sep
 2020 10:31:45 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        abel.vesa@nxp.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, Anson.Huang@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        aisheng.dong@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] firmware: imx: add dummy functions
Date:   Tue, 22 Sep 2020 18:24:29 +0800
Message-Id: <1600770269-30619-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0235.apcprd06.prod.outlook.com
 (2603:1096:4:ac::19) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 10.192.242.69 (119.31.174.67) by SG2PR06CA0235.apcprd06.prod.outlook.com (2603:1096:4:ac::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3391.11 via Frontend Transport; Tue, 22 Sep 2020 10:31:41 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e20a7fdd-7880-473b-2eaa-08d85ee2b3c6
X-MS-TrafficTypeDiagnostic: DB8PR04MB6858:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB6858C1BBA2E61130B513B4DE883B0@DB8PR04MB6858.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:669;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6W3ig+ynO1Weha/lJbjf7c82aX3BGLgSBsOS/Cux2WaoGM9ZVGABoIzkHRXWi5qkadV7kqtbWouiBvy4aG28XlaJrCVtUGr8mtHgheXXQVyu6dOJynGwPNFC3ADmx6sB/Npu7Z+puIMy6Hpg7xJHtpD6FN2SXDVin9EIGMtynrvL68HDS4ugg1tSeZZ0roaNSWnxVsKdm07GkHpgyL64ojjCzR6elurCJX8l785PPjCMdPPrNV86UDGZB6J5YFzsHLQE0Tzhq1SxrrZKQ3CJvkA1jKz6bEuqJl/1wIGWzMU3OqJQiEtT+2abjsN9HmMdeyMbOKstb9qhFueVMP9HsdVEYuiFdJ12WXqIoT5Kj8v9RBXjzeA5LVTEdmYqHky0/euOe/7XLy4RXIpc7SeGW+zR0Y3kEE3sN10xdYI8ewLIFmYE2hAPbx1DPjAgx97Z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(83380400001)(316002)(478600001)(16576012)(86362001)(4326008)(8936002)(6486002)(8676002)(6666004)(956004)(16526019)(52116002)(2616005)(26005)(186003)(66476007)(66946007)(2906002)(5660300002)(966005)(36756003)(66556008)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 832HzxcqkzyStk9pt9JrX8pEPXbEJc4mp184H4Rh2viZVDOKJxqer/YAf3cq9Emd7xyZqUT9QS/Pv5VK8v2t4iFJo1l+UeyPlf6Lwg5l7brEbU4mkxpfdfTUXMMNrAc+72NNzafMhC22sC+1BPm6YNceXfgamNQaZzrlghiLAYoRw8PhkBWcifMhDH+3G1DNzSDvf+dEeHkbFcp8CxJywIA4ckm/BE6Qqjm/CZepjANQ2rnlStAV//DhUyhW5EtCTkZ3Xf3uNixXL9KyZVcAA8UJ+7kWyb5fVBg1LTeEmXj1dN6jG9dK4ce9hy5qMtEC2eXk6S/RPreSNF8265aZQWYwhAgch+N+2jZBzfH4nM+LoGwNBSh3781x2OwYxNQ53bDk6G7nRQ4uO7JTqgDkZc3N6lFk7SHEQmst0Ypyc3upyZHFVYH3ZxZZU2yUthbEGpdhTS9aC7Pr5GHIbk6hZf1IcR+1k3HYhr32eO/PhyyMeRAC5DxumpTdLebWxe//la4X0Q29ZA4z05vM/B51m5XEYcw1B3MJvWetU5bF0c0Rg9EMsaS83CJEwXOwYqZYgqsePT7ezYvD+BqtOP+VkIIT8kMtXc2VBPoIX7z9secmXI9XkTGuj9EiWxNupCHcbpsi2p2RwqT8xq8Rp053jQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e20a7fdd-7880-473b-2eaa-08d85ee2b3c6
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2020 10:31:44.8343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MF+BPKFjyavVo8hFpCbVppLi5MDeyj/Oz68aKXUuc/9GO+FqYNpnlBWOKnsn5nE1kBvIQG4vOSRJ78tbwCkkiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6858
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

add dummy functions to avoid build failure when header files
are included, but drivers are not built.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V1: Seems this patch was missed. https://patchwork.kernel.org/cover/11395245/
    Rebased on linux-next.

 include/linux/firmware/imx/ipc.h      | 13 +++++++++++++
 include/linux/firmware/imx/sci.h      | 27 +++++++++++++++++++++++++++
 include/linux/firmware/imx/svc/misc.h | 19 +++++++++++++++++++
 3 files changed, 59 insertions(+)

diff --git a/include/linux/firmware/imx/ipc.h b/include/linux/firmware/imx/ipc.h
index 891057434858..0b4643571625 100644
--- a/include/linux/firmware/imx/ipc.h
+++ b/include/linux/firmware/imx/ipc.h
@@ -34,6 +34,7 @@ struct imx_sc_rpc_msg {
 	uint8_t func;
 };
 
+#ifdef CONFIG_IMX_SCU
 /*
  * This is an function to send an RPC message over an IPC channel.
  * It is called by client-side SCFW API function shims.
@@ -55,4 +56,16 @@ int imx_scu_call_rpc(struct imx_sc_ipc *ipc, void *msg, bool have_resp);
  * @return Returns an error code (0 = success, failed if < 0)
  */
 int imx_scu_get_handle(struct imx_sc_ipc **ipc);
+#else
+static inline int imx_scu_call_rpc(struct imx_sc_ipc *ipc, void *msg,
+				   bool have_resp)
+{
+	return -ENOTSUPP;
+}
+
+static inline int imx_scu_get_handle(struct imx_sc_ipc **ipc)
+{
+	return -ENOTSUPP;
+}
+#endif
 #endif /* _SC_IPC_H */
diff --git a/include/linux/firmware/imx/sci.h b/include/linux/firmware/imx/sci.h
index 22c76571a294..5cc63fe7e84d 100644
--- a/include/linux/firmware/imx/sci.h
+++ b/include/linux/firmware/imx/sci.h
@@ -16,9 +16,36 @@
 #include <linux/firmware/imx/svc/pm.h>
 #include <linux/firmware/imx/svc/rm.h>
 
+#if IS_ENABLED(CONFIG_IMX_SCU)
 int imx_scu_enable_general_irq_channel(struct device *dev);
 int imx_scu_irq_register_notifier(struct notifier_block *nb);
 int imx_scu_irq_unregister_notifier(struct notifier_block *nb);
 int imx_scu_irq_group_enable(u8 group, u32 mask, u8 enable);
 int imx_scu_soc_init(struct device *dev);
+#else
+static inline int imx_scu_soc_init(struct device *dev)
+{
+	return -ENOTSUPP;
+}
+
+static inline int imx_scu_enable_general_irq_channel(struct device *dev)
+{
+	return -ENOTSUPP;
+}
+
+static inline int imx_scu_irq_register_notifier(struct notifier_block *nb)
+{
+	return -ENOTSUPP;
+}
+
+static inline int imx_scu_irq_unregister_notifier(struct notifier_block *nb)
+{
+	return -ENOTSUPP;
+}
+
+static inline int imx_scu_irq_group_enable(u8 group, u32 mask, u8 enable)
+{
+	return -ENOTSUPP;
+}
+#endif
 #endif /* _SC_SCI_H */
diff --git a/include/linux/firmware/imx/svc/misc.h b/include/linux/firmware/imx/svc/misc.h
index 031dd4d3c766..760db08a67fc 100644
--- a/include/linux/firmware/imx/svc/misc.h
+++ b/include/linux/firmware/imx/svc/misc.h
@@ -46,6 +46,7 @@ enum imx_misc_func {
  * Control Functions
  */
 
+#ifdef CONFIG_IMX_SCU
 int imx_sc_misc_set_control(struct imx_sc_ipc *ipc, u32 resource,
 			    u8 ctrl, u32 val);
 
@@ -54,5 +55,23 @@ int imx_sc_misc_get_control(struct imx_sc_ipc *ipc, u32 resource,
 
 int imx_sc_pm_cpu_start(struct imx_sc_ipc *ipc, u32 resource,
 			bool enable, u64 phys_addr);
+#else
+static inline int imx_sc_misc_set_control(struct imx_sc_ipc *ipc,
+					  u32 resource, u8 ctrl, u32 val)
+{
+	return -ENOTSUPP;
+}
 
+static inline int imx_sc_misc_get_control(struct imx_sc_ipc *ipc,
+					  u32 resource, u8 ctrl, u32 *val)
+{
+	return -ENOTSUPP;
+}
+
+static inline int imx_sc_pm_cpu_start(struct imx_sc_ipc *ipc, u32 resource,
+				      bool enable, u64 phys_addr)
+{
+	return -ENOTSUPP;
+}
+#endif
 #endif /* _SC_MISC_API_H */
-- 
2.28.0

