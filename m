Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C58D82D2223
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 05:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgLHEix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 23:38:53 -0500
Received: from mail-bn8nam11on2093.outbound.protection.outlook.com ([40.107.236.93]:37217
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726063AbgLHEix (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 23:38:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GnrjW4ZkSGesasRp94XJ4svNn4wUcdeZ2IcAlakHtEBKFjMZkmWDyqVxcFvPyStnWxkwgFtQ16pOT5KbjCwiar5M8XmqJwkYWv+89klVvqds3/WELZGUdsXLTAGvDS5L3Bn41pwSSsI1RA5Krg+HW357UmpmwBaMi/vw7RhDYVQxgpo+pAaFYzzjqyw9Az62zYxInHJz3eEn9zIHGdYUUkCoZuZlA1Up0OvKbP2UVkjea1nI2ZhBy8m3s2bxNY5wwApcj7kcw3dCTQFEna3Yu8XxiVed+zQZQcrOU6eeqaIuLZSN+Mv+VuzY/FL6zQu8/9BShBCHc6NPu4oFTzLL3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zowWx9r79gxlIXGvn+jvngd/RKH7zbvKzmcW7d7yoU8=;
 b=mQC186bU2WwWLefH1FWDy3MfPtxw7pr3fFU15yR+vHK4Hwk6RbCJ1IhBVhrcJmyindOz+HYfkon7ve6w+UnaipBlG3XObUigytTagdveER3yea58dy4Ox74yqpZC0rJmsqSOKOo3E4+eKTy4BfDkICjOZsD066IcOmsw+YDcHkcFQUeMj0zMJc5s3t4c+ZrwjUvJfPVA6HJZTFTTRD2C++bgvss+QY9t+dMLuBF87kzAjp1lkv9u/6JxcmkSFVDbZLI0okqE/SE9i+OHb4WBgsJjAEV1pEN9iWu6L6Ld3ktLDTL4E9v8mdR0XyCNCkEka6swxwiIYcHRAwUHVLe6sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zowWx9r79gxlIXGvn+jvngd/RKH7zbvKzmcW7d7yoU8=;
 b=axGGVVAh4uyJ5wwNQykUhp/vWtPJcTgobtwuW6BCIRKkfjNjEmzFa9VYnXQZb7lx1FeL8iL/GIcUYiY8QsP9KHpEER2CEnEZoPEX32DUR5L52X3y2TND7b81m535DWLlSmYJFpm9kL4BlseYWVyeM+rj40AgpPBhEFFijbkn384=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none
 header.from=os.amperecomputing.com;
Received: from MW2PR0102MB3482.prod.exchangelabs.com (2603:10b6:302:c::32) by
 MWHPR01MB2383.prod.exchangelabs.com (2603:10b6:300:3c::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.21; Tue, 8 Dec 2020 04:37:44 +0000
Received: from MW2PR0102MB3482.prod.exchangelabs.com
 ([fe80::e903:700a:f17:7a17]) by MW2PR0102MB3482.prod.exchangelabs.com
 ([fe80::e903:700a:f17:7a17%7]) with mapi id 15.20.3632.021; Tue, 8 Dec 2020
 04:37:44 +0000
From:   Quan Nguyen <quan@os.amperecomputing.com>
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Sam Ravnborg <sam@ravnborg.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        allen <allen.chen@ite.com.tw>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org
Subject: [PATCH 2/2] ARM: dts: aspeed: Add device tree for Ampere's Mt. Jade BMC
Date:   Tue,  8 Dec 2020 11:37:00 +0700
Message-Id: <20201208043700.23098-3-quan@os.amperecomputing.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201208043700.23098-1-quan@os.amperecomputing.com>
References: <20201208043700.23098-1-quan@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [118.69.219.201]
X-ClientProxiedBy: SG2PR06CA0247.apcprd06.prod.outlook.com
 (2603:1096:4:ac::31) To MW2PR0102MB3482.prod.exchangelabs.com
 (2603:10b6:302:c::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hcm-sw-17.amperecomputing.com (118.69.219.201) by SG2PR06CA0247.apcprd06.prod.outlook.com (2603:1096:4:ac::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend Transport; Tue, 8 Dec 2020 04:37:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df203ce3-e12a-4576-8041-08d89b330195
X-MS-TrafficTypeDiagnostic: MWHPR01MB2383:
X-Microsoft-Antispam-PRVS: <MWHPR01MB23838B358B313639B3FAC24DF2CD0@MWHPR01MB2383.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VLdhsF+PXw78YySYFFcza3ho7sAyjBG3bKgSNgFs7vpFsxYxgwLvP7jJHfwHLHaoshBsshfkAoRjvmXvc+bCvq1dUgwwxG5FpbwWuhNQ+mUQGo0vikv15aMr6n4AqNoVyI+IlMF+ow7SAKRlUrO6OE2NUSTUPTqqhWquOxHpYvkxFhtt5PThwJdxmJk/lRVCme6nKXPZXd+euzEQg1HBVn3knJ+PTCWpUBuzCqRI5yrpE0opM8rEaicL8CNZrf4gcKtzYgxNEthqFdxwVVS9UcvsXq9F7a3ToCrocTAYTZHikkplFFp37pxr7mInuMIdggw35yNrJS90Ddu3vWjKy7cf+HdJ/g86nyvpRH3h2EYwD6gAoNyxzyRXoXBR5OCR7yx14aK1/m8V92ydCr+uc3ePbHFVzOXYJIbkIjZk2XI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR0102MB3482.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(39850400004)(346002)(366004)(6506007)(316002)(66556008)(478600001)(2616005)(52116002)(2906002)(921005)(66476007)(30864003)(6666004)(5660300002)(86362001)(66946007)(8676002)(16526019)(110136005)(26005)(6486002)(8936002)(1076003)(7416002)(186003)(83380400001)(6512007)(956004)(473944003)(414714003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?GoGoYxlQyRQb+rK0eDZ9el1BmZX6AeYCRDAYdu+3jAar0BnZLWhsNA/wqfWe?=
 =?us-ascii?Q?HnSdI+OH8wylooRizcIKpuLQDVryrmFSd8HydClrDMP0KSsg8vMldUmg7AUa?=
 =?us-ascii?Q?bIaXpiJdsfz7wb3PdN3rCIgtuRpTefiCj3j84Xna4bJnV0txgeDGrAo2deeJ?=
 =?us-ascii?Q?WMhemYbboP7RMKyZ6W0GI9JvUiyZgW+3q6B/LQta3Jnf78/SydQdmyJCDR9F?=
 =?us-ascii?Q?71cqvagYNC3Y92HP5RWJDg3NElQeKBsKsNBj3zrQBci74GTgKMLkxiVjO4Ic?=
 =?us-ascii?Q?5U/xS6xJqFo9zegKsrpbEgkArj/A9+uLNjOrasiKZwWPjHC3RErTlt1fBHgo?=
 =?us-ascii?Q?C2tiAwagQIPPsO8o/ZLBiRtIr/0kpua2eRmmkCx8MLeKppKDMQfcKMgzOOEe?=
 =?us-ascii?Q?YmRvvUL+CYVNV3h3stHn03IFdAvosXstIXwTtVyJMa8Clwessb74pOMVQL9g?=
 =?us-ascii?Q?TyW7lScLm6iGeChT5J1QtpHnlG0yAm/LOKgc6xLyKrwysQ9fPrxvKH/LwT5L?=
 =?us-ascii?Q?nIQ5HxIJrjaqnmJMxhtyVTHGDyTBbsHbTrLyDSkMB5CVAfioD4S4pM/BQiGB?=
 =?us-ascii?Q?LzfV5Q2ugYxN2VCJ9mHh8R8WgA3KC3Zb3nmYc48bToqBEsKGjCbu4QT5j0a2?=
 =?us-ascii?Q?RMGn392/wO0Z0vQQOVoj9RgaSnbZKMrl6jwPE6ywcwgg69k7sGn9PR+5c/CX?=
 =?us-ascii?Q?aFksNw3r57GvI2WDjRrBAMfBDiXiTuQoRF2x04fyA2PhtiyokkrKASNy283e?=
 =?us-ascii?Q?NoDrB/EcETDwhrU3pAtAPq9BblkNBRDXYqPtEGiGzRI7Hb70eNuKPxDDFtnA?=
 =?us-ascii?Q?mfIvybwHlrUCGn9DvnBS+26rGeYRvQqpkXLjpTFsvimv/UzsyXdnaTHeUt/8?=
 =?us-ascii?Q?+eYK11KBOIHMM3Q7l8M7I75QAZCbiITrfI6HPTZoTC+KdIBrv+2G9XY+1j5F?=
 =?us-ascii?Q?WwWEmbmZs+kobmVVieKCW6gKj2A8/dcuDYfaQZ4PFWRa5mPIzhM6hHYmb9X8?=
 =?us-ascii?Q?2adS?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-AuthSource: MW2PR0102MB3482.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2020 04:37:44.3828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-Network-Message-Id: df203ce3-e12a-4576-8041-08d89b330195
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w1gRyF6KDNfzcKszpJ7q2w8ryBTrB3MR44CD6BPeKerT3yc3ZQgM6ZlbSkEBcPmOPLN09CgOzw4P+AFvqDDL0J9XADZyuQiQh/kYYG3o9Qw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR01MB2383
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Mt. Jade BMC is an ASPEED AST2500-based BMC for the Mt. Jade
hardware reference platform with Ampere's Altra Processor Family.

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
Signed-off-by: Phong Vo <phong@os.amperecomputing.com>
Signed-off-by: Thang Q. Nguyen <thang@os.amperecomputing.com>
---
 arch/arm/boot/dts/Makefile                    |   1 +
 .../arm/boot/dts/aspeed-bmc-ampere-mtjade.dts | 558 ++++++++++++++++++
 2 files changed, 559 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 9f9f3e49132a..5da5e8f93554 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1398,6 +1398,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-ast2500-evb.dtb \
 	aspeed-ast2600-evb.dtb \
 	aspeed-bmc-amd-ethanolx.dtb \
+	aspeed-bmc-ampere-mtjade.dtb \
 	aspeed-bmc-arm-centriq2400-rep.dtb \
 	aspeed-bmc-arm-stardragon4800-rep2.dtb \
 	aspeed-bmc-bytedance-g220a.dtb \
diff --git a/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts b/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
new file mode 100644
index 000000000000..8f5ec22e51c2
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
@@ -0,0 +1,558 @@
+// SPDX-License-Identifier: GPL-2.0+
+/dts-v1/;
+#include "aspeed-g5.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
+
+/ {
+	model = "Ampere Mt. Jade BMC";
+	compatible = "ampere,mtjade-bmc", "aspeed,ast2500";
+
+	chosen {
+		stdout-path = &uart5;
+		bootargs = "console=ttyS4,115200 earlyprintk";
+	};
+
+	memory@80000000 {
+		reg = <0x80000000 0x20000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		vga_memory: framebuffer@9f000000 {
+			no-map;
+			reg = <0x9f000000 0x01000000>; /* 16M */
+		};
+
+		gfx_memory: framebuffer {
+			size = <0x01000000>;
+			alignment = <0x01000000>;
+			compatible = "shared-dma-pool";
+			reusable;
+		};
+
+		video_engine_memory: jpegbuffer {
+			size = <0x02000000>;	/* 32M */
+			alignment = <0x01000000>;
+			compatible = "shared-dma-pool";
+			reusable;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		fault {
+			gpios = <&gpio ASPEED_GPIO(B, 6) GPIO_ACTIVE_HIGH>;
+		};
+
+		identify {
+			gpios = <&gpio ASPEED_GPIO(Q, 6) GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		shutdown_ack {
+			label = "SHUTDOWN_ACK";
+			gpios = <&gpio ASPEED_GPIO(G, 2) GPIO_ACTIVE_LOW>;
+			linux,code = <ASPEED_GPIO(G, 2)>;
+		};
+
+		reboot_ack {
+			label = "REBOOT_ACK";
+			gpios = <&gpio ASPEED_GPIO(J, 3) GPIO_ACTIVE_LOW>;
+			linux,code = <ASPEED_GPIO(J, 3)>;
+		};
+
+		S0_overtemp {
+			label = "S0_OVERTEMP";
+			gpios = <&gpio ASPEED_GPIO(G, 3) GPIO_ACTIVE_LOW>;
+			linux,code = <ASPEED_GPIO(G, 3)>;
+		};
+
+		S0_hightemp {
+			label = "S0_HIGHTEMP";
+			gpios = <&gpio ASPEED_GPIO(J, 0) GPIO_ACTIVE_LOW>;
+			linux,code = <ASPEED_GPIO(J, 0)>;
+		};
+
+		S0_cpu_fault {
+			label = "S0_CPU_FAULT";
+			gpios = <&gpio ASPEED_GPIO(J, 1) GPIO_ACTIVE_HIGH>;
+			linux,code = <ASPEED_GPIO(J, 1)>;
+		};
+
+		S1_overtemp {
+			label = "S1_OVERTEMP";
+			gpios = <&gpio ASPEED_GPIO(Z, 6) GPIO_ACTIVE_LOW>;
+			linux,code = <ASPEED_GPIO(Z, 6)>;
+		};
+
+		S1_hightemp {
+			label = "S1_HIGHTEMP";
+			gpios = <&gpio ASPEED_GPIO(AB, 0) GPIO_ACTIVE_LOW>;
+			linux,code = <ASPEED_GPIO(AB, 0)>;
+		};
+
+		S1_cpu_fault {
+			label = "S1_CPU_FAULT";
+			gpios = <&gpio ASPEED_GPIO(Z, 1) GPIO_ACTIVE_HIGH>;
+			linux,code = <ASPEED_GPIO(Z, 1)>;
+		};
+
+		id_button {
+			label = "ID_BUTTON";
+			gpios = <&gpio ASPEED_GPIO(Q, 5) GPIO_ACTIVE_LOW>;
+			linux,code = <ASPEED_GPIO(Q, 5)>;
+		};
+
+	};
+
+	gpioA0mux: mux-controller {
+		compatible = "gpio-mux";
+		#mux-control-cells = <0>;
+		mux-gpios = <&gpio ASPEED_GPIO(A, 0) GPIO_ACTIVE_LOW>;
+	};
+
+	adc0mux: adc0mux {
+		compatible = "io-channel-mux";
+		io-channels = <&adc 0>;
+		#io-channel-cells = <1>;
+		io-channel-names = "parent";
+		mux-controls = <&gpioA0mux>;
+		channels = "s0", "s1";
+	};
+
+	adc1mux: adc1mux {
+		compatible = "io-channel-mux";
+		io-channels = <&adc 1>;
+		#io-channel-cells = <1>;
+		io-channel-names = "parent";
+		mux-controls = <&gpioA0mux>;
+		channels = "s0", "s1";
+	};
+
+	adc2mux: adc2mux {
+		compatible = "io-channel-mux";
+		io-channels = <&adc 2>;
+		#io-channel-cells = <1>;
+		io-channel-names = "parent";
+		mux-controls = <&gpioA0mux>;
+		channels = "s0", "s1";
+	};
+
+	adc3mux: adc3mux {
+		compatible = "io-channel-mux";
+		io-channels = <&adc 3>;
+		#io-channel-cells = <1>;
+		io-channel-names = "parent";
+		mux-controls = <&gpioA0mux>;
+		channels = "s0", "s1";
+	};
+
+	adc4mux: adc4mux {
+		compatible = "io-channel-mux";
+		io-channels = <&adc 4>;
+		#io-channel-cells = <1>;
+		io-channel-names = "parent";
+		mux-controls = <&gpioA0mux>;
+		channels = "s0", "s1";
+	};
+
+	adc5mux: adc5mux {
+		compatible = "io-channel-mux";
+		io-channels = <&adc 5>;
+		#io-channel-cells = <1>;
+		io-channel-names = "parent";
+		mux-controls = <&gpioA0mux>;
+		channels = "s0", "s1";
+	};
+
+	adc6mux: adc6mux {
+		compatible = "io-channel-mux";
+		io-channels = <&adc 6>;
+		#io-channel-cells = <1>;
+		io-channel-names = "parent";
+		mux-controls = <&gpioA0mux>;
+		channels = "s0", "s1";
+	};
+
+	adc7mux: adc7mux {
+		compatible = "io-channel-mux";
+		io-channels = <&adc 7>;
+		#io-channel-cells = <1>;
+		io-channel-names = "parent";
+		mux-controls = <&gpioA0mux>;
+		channels = "s0", "s1";
+	};
+
+	adc8mux: adc8mux {
+		compatible = "io-channel-mux";
+		io-channels = <&adc 8>;
+		#io-channel-cells = <1>;
+		io-channel-names = "parent";
+		mux-controls = <&gpioA0mux>;
+		channels = "s0", "s1";
+	};
+
+	adc9mux: adc9mux {
+		compatible = "io-channel-mux";
+		io-channels = <&adc 9>;
+		#io-channel-cells = <1>;
+		io-channel-names = "parent";
+		mux-controls = <&gpioA0mux>;
+		channels = "s0", "s1";
+	};
+
+	adc10mux: adc10mux {
+		compatible = "io-channel-mux";
+		io-channels = <&adc 10>;
+		#io-channel-cells = <1>;
+		io-channel-names = "parent";
+		mux-controls = <&gpioA0mux>;
+		channels = "s0", "s1";
+	};
+
+	adc11mux: adc11mux {
+		compatible = "io-channel-mux";
+		io-channels = <&adc 11>;
+		#io-channel-cells = <1>;
+		io-channel-names = "parent";
+		mux-controls = <&gpioA0mux>;
+		channels = "s0", "s1";
+	};
+
+	adc12mux: adc12mux {
+		compatible = "io-channel-mux";
+		io-channels = <&adc 12>;
+		#io-channel-cells = <1>;
+		io-channel-names = "parent";
+		mux-controls = <&gpioA0mux>;
+		channels = "s0", "s1";
+	};
+
+	adc13mux: adc13mux {
+		compatible = "io-channel-mux";
+		io-channels = <&adc 13>;
+		#io-channel-cells = <1>;
+		io-channel-names = "parent";
+		mux-controls = <&gpioA0mux>;
+		channels = "s0", "s1";
+	};
+
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&adc0mux 0>, <&adc0mux 1>,
+			<&adc1mux 0>, <&adc1mux 1>,
+			<&adc2mux 0>, <&adc2mux 1>,
+			<&adc3mux 0>, <&adc3mux 1>,
+			<&adc4mux 0>, <&adc4mux 1>,
+			<&adc5mux 0>, <&adc5mux 1>,
+			<&adc6mux 0>, <&adc6mux 1>,
+			<&adc7mux 0>, <&adc7mux 1>,
+			<&adc8mux 0>, <&adc8mux 1>,
+			<&adc9mux 0>, <&adc9mux 1>,
+			<&adc10mux 0>, <&adc10mux 1>,
+			<&adc11mux 0>, <&adc11mux 1>,
+			<&adc12mux 0>, <&adc12mux 1>,
+			<&adc13mux 0>, <&adc13mux 1>;
+	};
+
+	iio-hwmon-adc14 {
+		compatible = "iio-hwmon";
+		io-channels = <&adc 14>;
+	};
+
+	iio-hwmon-battery {
+		compatible = "iio-hwmon";
+		io-channels = <&adc 15>;
+	};
+};
+
+&fmc {
+	status = "okay";
+	flash@0 {
+		status = "okay";
+		m25p,fast-read;
+		label = "bmc";
+		/* spi-max-frequency = <50000000>; */
+#include "openbmc-flash-layout.dtsi"
+	};
+};
+
+&spi1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi1_default>;
+
+	flash@0 {
+		status = "okay";
+		m25p,fast-read;
+		label = "pnor";
+		/* spi-max-frequency = <100000000>; */
+	};
+};
+
+&uart1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_txd1_default
+			 &pinctrl_rxd1_default
+			 &pinctrl_ncts1_default
+			 &pinctrl_nrts1_default>;
+};
+
+&uart2 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_txd2_default
+			 &pinctrl_rxd2_default>;
+};
+
+&uart3 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_txd3_default
+			 &pinctrl_rxd3_default>;
+};
+
+&uart4 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_txd4_default
+			 &pinctrl_rxd4_default>;
+};
+
+/* The BMC's uart */
+&uart5 {
+	status = "okay";
+};
+
+&mac1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rgmii2_default &pinctrl_mdio2_default>;
+};
+
+&i2c0 {
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+};
+
+&i2c2 {
+	status = "okay";
+};
+
+&i2c3 {
+	status = "okay";
+	eeprom@50 {
+		compatible = "microchip,24c64", "atmel,24c64";
+		reg = <0x50>;
+		pagesize = <32>;
+	};
+
+	inlet_mem2: tmp175@28 {
+		compatible = "ti,tmp175";
+		reg = <0x28>;
+	};
+
+	inlet_cpu: tmp175@29 {
+		compatible = "ti,tmp175";
+		reg = <0x29>;
+	};
+
+	inlet_mem1: tmp175@2a {
+		compatible = "ti,tmp175";
+		reg = <0x2a>;
+	};
+
+	outlet_cpu: tmp175@2b {
+		compatible = "ti,tmp175";
+		reg = <0x2b>;
+	};
+
+	outlet1: tmp175@2c {
+		compatible = "ti,tmp175";
+		reg = <0x2c>;
+	};
+
+	outlet2: tmp175@2d {
+		compatible = "ti,tmp175";
+		reg = <0x2d>;
+	};
+};
+
+&i2c4 {
+	status = "okay";
+	rtc@51 {
+		compatible = "nxp,pcf85063a";
+		reg = <0x51>;
+	};
+};
+
+&i2c5 {
+	status = "okay";
+};
+
+&i2c6 {
+	status = "okay";
+	psu@58 {
+		compatible = "pmbus";
+		reg = <0x58>;
+	};
+
+	psu@59 {
+		compatible = "pmbus";
+		reg = <0x59>;
+	};
+};
+
+&i2c7 {
+	status = "okay";
+};
+
+&i2c8 {
+	status = "okay";
+};
+
+&i2c9 {
+	status = "okay";
+};
+
+&gfx {
+	status = "okay";
+	memory-region = <&gfx_memory>;
+};
+
+&pinctrl {
+	aspeed,external-nodes = <&gfx &lhc>;
+};
+
+&pwm_tacho {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm2_default &pinctrl_pwm3_default
+			&pinctrl_pwm4_default &pinctrl_pwm5_default
+			&pinctrl_pwm6_default &pinctrl_pwm7_default>;
+
+	fan@0 {
+		reg = <0x02>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x04>;
+	};
+
+	fan@1 {
+		reg = <0x02>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x05>;
+	};
+
+	fan@2 {
+		reg = <0x03>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x06>;
+	};
+
+	fan@3 {
+		reg = <0x03>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x07>;
+	};
+
+	fan@4 {
+		reg = <0x04>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x08>;
+	};
+
+	fan@5 {
+		reg = <0x04>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x09>;
+	};
+
+	fan@6 {
+		reg = <0x05>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x0a>;
+	};
+
+	fan@7 {
+		reg = <0x05>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x0b>;
+	};
+
+	fan@8 {
+		reg = <0x06>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x0c>;
+	};
+
+	fan@9 {
+		reg = <0x06>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x0d>;
+	};
+
+	fan@10 {
+		reg = <0x07>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x0e>;
+	};
+
+	fan@11 {
+		reg = <0x07>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x0f>;
+	};
+
+};
+
+&vhub {
+	status = "okay";
+};
+
+&adc {
+	status = "okay";
+};
+
+&video {
+	status = "okay";
+	memory-region = <&video_engine_memory>;
+};
+
+&gpio {
+	gpio-line-names =
+	/*A0-A7*/	"","","","S0_BMC_SPECIAL_BOOT","","","","",
+	/*B0-B7*/	"BMC_SELECT_EEPROM","","","",
+			"POWER_BUTTON","","","",
+	/*C0-C7*/	"","","","","","","","",
+	/*D0-D7*/	"","","","","","","","",
+	/*E0-E7*/	"","","","","","","","",
+	/*F0-F7*/	"","","BMC_SYS_PSON_L","S0_DDR_SAVE","PGOOD",
+			"S1_DDR_SAVE","","",
+	/*G0-G7*/	"S0_FW_BOOT_OK","SHD_REQ_L","","S0_OVERTEMP_L","","",
+			"","",
+	/*H0-H7*/	"","","","","","","","",
+	/*I0-I7*/	"","","S1_BMC_SPECIAL_BOOT","","","","","",
+	/*J0-J7*/	"S0_HIGHTEMP_L","S0_FAULT_L","S0_SCP_AUTH_FAIL_L","",
+			"","","","",
+	/*K0-K7*/	"","","","","","","","",
+	/*L0-L7*/       "","","","BMC_SYSRESET_L","SPI_AUTH_FAIL_L","","","",
+	/*M0-M7*/	"","","","","","","","",
+	/*N0-N7*/	"","","","","","","","",
+	/*O0-O7*/	"","","","","","","","",
+	/*P0-P7*/	"","","","","","","","",
+	/*Q0-Q7*/	"","","","","","UID_BUTTON","","",
+	/*R0-R7*/	"","","BMC_EXT_HIGHTEMP_L","","","RESET_BUTTON","","",
+	/*S0-S7*/	"","","","","","","","",
+	/*T0-T7*/	"","","","","","","","",
+	/*U0-U7*/	"","","","","","","","",
+	/*V0-V7*/	"","","","","","","","",
+	/*W0-W7*/	"","","","","","","","",
+	/*X0-X7*/	"","","","","","","","",
+	/*Y0-Y7*/	"","","","","","","","",
+	/*Z0-Z7*/	"S0_BMC_PLIMIT","S1_FAULT_L","S1_FW_BOOT_OK","","",
+			"S1_SCP_AUTH_FAIL_L","S1_OVERTEMP_L","",
+	/*AA0-AA7*/	"","","","","","","","",
+	/*AB0-AB7*/	"S1_HIGHTEMP_L","S1_BMC_PLIMIT","S0_BMC_DDR_ADDR",
+			"S1_BMC_DDR_ADR","","","","",
+	/*AC0-AC7*/	"SYS_PWR_GD","","","","","BMC_READY","SLAVE_PRESENT_L",
+			"BMC_OCP_PG";
+};
-- 
2.28.0

