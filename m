Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6245826BA6B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 04:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgIPC4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 22:56:09 -0400
Received: from mail-db8eur05on2067.outbound.protection.outlook.com ([40.107.20.67]:51073
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726341AbgIPC4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 22:56:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBuBXQBJmeYp56C7YRjfyFlh6+tqJ6sWiWGG2L5K3w6Zt90fgDaHf1FuQanxoxXR4v8U0gpXC2mPqOsV3X5aP3G0QnJC4u1dnTISAZ4ERYEniWy2xj+ODfdTGJlxhZUteWHBW63hIFTcSxCxthLDRF68fbiGlK/Hxbpnka9/4F5FvKCRRK/i39hH5hztin/UGGvpBaUb72TpvVu9G0wCA6U0QlSpwYbp6G+Z5ExoQoGmFHZ8uzHT4HAEzreHuX0I4oh15+Tpy3ZfttVsQwiSnHu2F7kR79qa8OqmfZDs+k2kiNNLVkLOcTjKh5hDI7Sun/EfOpUbwZJU8I3qWh/Zlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQGEwU6mhVXJnZUNK2mGmKwMpV43P3jw6Cc6Ob7/2lA=;
 b=R6yhotRP2OzlTW5T46WHUnu0v/hTAKDvXcO09A32j6Baj1hJdQymYDJnBV08b4eaMw57wBmr5XeAS0t3iLSBmDu6eeBqKTOjIvQ+Q+59yYldEaIVxTnMtLLRXBN4/y1ex9x6HOewR5RpSi4GPGooUzIgpvIr2H5hTnipBkfILB+lPmuDuitVUElAUkP6us/eDfBL7SXS9V0VIZWKeaxQC79IbLa0nE67wTT/oc2otZ6cdHzNRxZwgfzYGlAUHpv/CaogVcMDIYm8jRIB/jf9qstY8tWx7TGgbRJirNRjY7noTxEbMdF/FYSMMmj8x/+sXOWNVKvQUZkDjgs/U5X/6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQGEwU6mhVXJnZUNK2mGmKwMpV43P3jw6Cc6Ob7/2lA=;
 b=aXvx/mVNnXANmwdiBsOz5WHLte54+i0nVNRAGBFTuoYuNtozduA6FDug908s+HRzdZRgfetoyLb/v+506nDYSZdJ1UUjB28ZCC2xYt12XQSyYikuNJvuJEJlsnNlB8CaO2qttFbr+aE5oMOvKOHdEW8oyhwa4Zw/JoW43GL257s=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB8PR04MB7177.eurprd04.prod.outlook.com (2603:10a6:10:127::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.17; Wed, 16 Sep
 2020 02:55:54 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::39ff:13b4:4f28:1413]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::39ff:13b4:4f28:1413%10]) with mapi id 15.20.3370.019; Wed, 16 Sep
 2020 02:55:54 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        abel.vesa@nxp.com, robh+dt@kernel.org
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, Anson.Huang@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 4/4] ARM: imx: cpuidle-imx7ulp: Stop mode disallowed when HSRUN
Date:   Wed, 16 Sep 2020 10:48:37 +0800
Message-Id: <1600224517-31465-5-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600224517-31465-1-git-send-email-peng.fan@nxp.com>
References: <1600224517-31465-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0165.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::21) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 10.192.242.69 (119.31.174.67) by SG2PR01CA0165.apcprd01.prod.exchangelabs.com (2603:1096:4:28::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3391.11 via Frontend Transport; Wed, 16 Sep 2020 02:55:49 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 33d56087-e325-42a1-b60a-08d859ec0767
X-MS-TrafficTypeDiagnostic: DB8PR04MB7177:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB71776D27708CF58A8265163A88210@DB8PR04MB7177.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:64;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pghf5VcVGytp0wfZ85czEUDHerJAOoR9UjQ2t75n9+lh8LoU/OR+CYSTxtoVDCtL19YRKi/kWX0j6YiYwC+LEZfIJ/VJOFC91X9pJ+M86ffc6hbmul9HewNAvXN03q7Nkc+prrtS50JA12WdHGWcGsDT/ZaJ9j/lvnyeNPTTxyridIqgjjOVcXWWaczdh8ZOsYmOxtEd1IDk+f2/5AbKVlBQywwZybfw/azp5VAgnos2YSnOUsdA51Vr6g7nZ2MO+9KFdLkJmRpU2ErzNeFqtDXKebki08Tjx1CSPEAzAICt3jrR9xo9NebQ1EC5RgpjDx9cJPsIRhsrVyrMKnrAXEZ6jvx3cd5xyZuFioFOphu2APv1NmeISg+Hra45KU1Q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52116002)(498600001)(2616005)(2906002)(6486002)(956004)(83380400001)(16576012)(36756003)(86362001)(8676002)(4326008)(66946007)(26005)(66476007)(66556008)(16526019)(186003)(9686003)(6666004)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 1i2jgOI3hyNVnOvljJwfslQWZgMsQ4PByssPqHIAk2LQdCPWq7sEbVGg6aNGZkc2b65oaEX5WTS8BleSf1myzZnNW19agKNDJzIUr7mIO+2g/Eaf2zLZZRMWn6fRqKpZLjqh2vUljDteQmzrPQW43pHuavzMvjDhk+oSpJhT5QpiA63R17rZK2tkrpp8YZYRAmKwmu7GvsCJxkvM0KcJcHe7IdwsTlopspMapu5jpGOMZTcW0fDXoLcdP8soEh5bn0BwjEVYf1xK2KvzoVnx1wEvNzacUYLmW3h6pmhL5EVH5zJwBfAGFqVal8jtKv/by1PrZ+u8HWkxKsFNl1sc3gl2O2Zj9ePbceSsGTy1dahbyG58pl689lT7grpCJCu0U0hEcGmWvSyAJIzhg+hhn4qkpr9f0++WtWZQunpXS0NeVUcURVKGxv4Y/EXn2GEpdL8H/gQ23IVehW4S274qhxPYKuaG707Oe2YSUKgsP78AB5N9OmjsREV+SHiWtV2GXcrQpVkRX8rFfAxqOZMnrFzavtX3OMLpLbO2K73bgCFGo3V/Q5SJ4BAch+dMMUD9+9MLZhtYBFr3KC6qTPuQZOAbPEUcMwXGcDxC5GylxYwtVvp8QkmT1n3zxQCkAqTAraqx8wpDuB2AEvYybABZ+A==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33d56087-e325-42a1-b60a-08d859ec0767
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 02:55:54.6715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FORMuXKh1AI5rT3p+OLWwhdgmFKYj8lBBpQX4C8eBBfKEuhOGS/cii0xL4Luj++fWk+uJRwq9fI7qrMuIQ2C5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7177
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

When cpu runs in HSRUN mode, cpuidle is not allowed to run into
Stop mode. So add imx7ulp_get_mode to get thr cpu run mode,
and use WAIT mode instead, when cpu in HSRUN mode.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/common.h          |  1 +
 arch/arm/mach-imx/cpuidle-imx7ulp.c | 14 +++++++++++---
 arch/arm/mach-imx/pm-imx7ulp.c      | 10 ++++++++++
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 72c3fcc32910..707ac650f1c2 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -103,6 +103,7 @@ void imx6_set_int_mem_clk_lpm(bool enable);
 void imx6sl_set_wait_clk(bool enter);
 int imx_mmdc_get_ddr_type(void);
 int imx7ulp_set_lpm(enum ulp_cpu_pwr_mode mode);
+u32 imx7ulp_get_mode(void);
 
 void imx_cpu_die(unsigned int cpu);
 int imx_cpu_kill(unsigned int cpu);
diff --git a/arch/arm/mach-imx/cpuidle-imx7ulp.c b/arch/arm/mach-imx/cpuidle-imx7ulp.c
index ca86c967d19e..e7009d10b331 100644
--- a/arch/arm/mach-imx/cpuidle-imx7ulp.c
+++ b/arch/arm/mach-imx/cpuidle-imx7ulp.c
@@ -15,10 +15,18 @@
 static int imx7ulp_enter_wait(struct cpuidle_device *dev,
 			    struct cpuidle_driver *drv, int index)
 {
-	if (index == 1)
+	u32 mode;
+
+	if (index == 1) {
 		imx7ulp_set_lpm(ULP_PM_WAIT);
-	else
-		imx7ulp_set_lpm(ULP_PM_STOP);
+	} else {
+		mode = imx7ulp_get_mode();
+
+		if (mode == 3)
+			imx7ulp_set_lpm(ULP_PM_WAIT);
+		else
+			imx7ulp_set_lpm(ULP_PM_STOP);
+	}
 
 	cpu_do_idle();
 
diff --git a/arch/arm/mach-imx/pm-imx7ulp.c b/arch/arm/mach-imx/pm-imx7ulp.c
index 393faf1e8382..1410ccfc71bd 100644
--- a/arch/arm/mach-imx/pm-imx7ulp.c
+++ b/arch/arm/mach-imx/pm-imx7ulp.c
@@ -63,6 +63,16 @@ int imx7ulp_set_lpm(enum ulp_cpu_pwr_mode mode)
 	return 0;
 }
 
+u32 imx7ulp_get_mode(void)
+{
+	u32 mode;
+
+	mode = readl_relaxed(smc1_base + SMC_PMCTRL) & BM_PMCTRL_RUNM;
+	mode >>= BP_PMCTRL_RUNM;
+
+	return mode;
+}
+
 void __init imx7ulp_pm_init(void)
 {
 	struct device_node *np;
-- 
2.28.0

