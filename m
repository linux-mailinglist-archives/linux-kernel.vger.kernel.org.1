Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8C732AE85D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 06:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbgKKFrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 00:47:32 -0500
Received: from mail-bn8nam11on2064.outbound.protection.outlook.com ([40.107.236.64]:39840
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725468AbgKKFrb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 00:47:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ny6ihMfM1Xr+MTmio762+Dy3SvFL+kDxtUqhNV8fhFKdvFLa9MSMTlFSSs++4lXgam/zqkBVh2nadQHqptKINsWRrc3E7OIOGn5CvAMZ4tLhSEC9BUTzHcIxb0p0KX/wwQU6G51Ub5q3i0+5KaSTFeFRtGxVKdlBax+CQhscnmXLzREKGlDUyolhLzMJ90rr33D/gbrQT0gQ4kSVnmg3YkuR4t1wyb0H9o7iMVYMDXD3gghub6Jdzq85nKnGOxibLT7T8BMgea2usBnL+RllxsM9xmLMASuedxysGLqAR+7Rf7+fS5udxmUJfX0s1y8OWqZEuEQkkRlZUh77Key+mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0wiFo4Wj7c3GWSujv2NSoQcm/hKsaXLxGtWIoufFVQ=;
 b=jUXH5P37Egl2cjLQuCoFClXXwhSZZPIXdJ8QrDlCkDGNTfPkilyn5X1jMZvuMDfSayLtn1hUGZm7BGrpCHYRGzWY6yH64abBG4ZFEYHxMUvMulYUPnNm0t6UQjmWj0UFXocgKxN4gtG/5Oy0awUlTmzDsGA1NtI7apGkl+u9zHKWwTAPn8KXhJUAPS04CLKYkF8fOE8Kifo950d8lAekTSSfwmokDyiP9ES+C4f6HIqdr6vtUqS6oha3D37kLHYDsa9gWDvymfhuSVpa22eC5lnAHlVfMhXtnP/10zG6cFdyRVkRrOTcQZKtC1gIsZXI4x7itBVIR4DbAD7kvNS0Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=openfive.com; dmarc=pass action=none header.from=openfive.com;
 dkim=pass header.d=openfive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=osportal.onmicrosoft.com; s=selector2-osportal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0wiFo4Wj7c3GWSujv2NSoQcm/hKsaXLxGtWIoufFVQ=;
 b=H0aXcZZtsXITj+nSDwwBdMMqN8W4rjfdedXzmAWRWkLCpmknoMuWGsqoar+ApgTfyBZVoVgMVskID9KXy7hPAx/DRt9y1vtEWAZRVWzC8XI7X1x45+RGqcxlCcy95stS1zO5SXCMNL8a0qW7IbK0GbLRFDxpUeGmELmb7/1dQOM=
Received: from MN2PR13MB2797.namprd13.prod.outlook.com (2603:10b6:208:f2::30)
 by MN2PR13MB3661.namprd13.prod.outlook.com (2603:10b6:208:1ed::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.10; Wed, 11 Nov
 2020 05:47:24 +0000
Received: from MN2PR13MB2797.namprd13.prod.outlook.com
 ([fe80::dcec:40d7:3fd6:308d]) by MN2PR13MB2797.namprd13.prod.outlook.com
 ([fe80::dcec:40d7:3fd6:308d%7]) with mapi id 15.20.3564.021; Wed, 11 Nov 2020
 05:47:24 +0000
From:   Pragnesh Patel <pragnesh.patel@openfive.com>
To:     Zong Li <zong.li@sifive.com>
CC:     Erik Danie <erik.danie@sifive.com>,
        "Henry Styles ( Sifive)" <hes@sifive.com>,
        Zong Li <zong.li@sifive.com>,
        "Paul Walmsley ( Sifive)" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        Yash Shah <yash.shah@openfive.com>,
        "schwab@linux-m68k.org" <schwab@linux-m68k.org>
Subject: RE: [PATCH v2 3/3] clk: sifive: Add a driver for the SiFive FU740
 PRCI IP block
Thread-Topic: [PATCH v2 3/3] clk: sifive: Add a driver for the SiFive FU740
 PRCI IP block
Thread-Index: AQHWtzMtNKm5eEeORU2O71pjWXhnZKnCbJVw
Date:   Wed, 11 Nov 2020 05:47:24 +0000
Message-ID: <MN2PR13MB279780E93DE61125B38006F5EBE80@MN2PR13MB2797.namprd13.prod.outlook.com>
References: <20201110072748.46705-1-zong.li@sifive.com>
 <20201110072748.46705-4-zong.li@sifive.com>
In-Reply-To: <20201110072748.46705-4-zong.li@sifive.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: sifive.com; dkim=none (message not signed)
 header.d=none;sifive.com; dmarc=none action=none header.from=openfive.com;
x-originating-ip: [2405:204:8004:b7c5:a5e5:20a7:4d2f:98e3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e2bd45ee-0395-40ce-9642-08d8860543c2
x-ms-traffictypediagnostic: MN2PR13MB3661:
x-ld-processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR13MB3661926A7052F419E8C6F396EBE80@MN2PR13MB3661.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mTxHLyx3JX6hh4bK5K1KLL2Td4XNYrpFdw3jn/Yk8vobLSSxchnKp5CszLVdygAbDr4xY3v57ysAWlQH+DqHx4ezF8TKJJ95OWLc3ShU2kMCUnOVguoy5cA0bqkyQTxGKINsLUjZKKYFWJHPq/TGCySVdT/Xiyf1Lu1bcWEA5YdIapooT6ZDus9344UNazxZGyiJpQVVegeM5pWC3e9wDvS1PqWaVP2g+dt09cKPvXHa4h2T5ooe8AMBMUHQoFymYGBTZwFtsty+4+nMnR2ko3ZcWAurDMYl78PAwHr1TUxUZigmXl5lSHc7rnsadUiRBlgb2/vJWcp7hMonpcPTOlhliAF3lq6d7nNDDyXcKysfkIa8SE/BPovvwxM3/HefpYI3GRLHs+TrvXYORCJ3UYVQlyFu+2mEuLTkARA94rHyqEh6zs8/LCPS6PNwcm8zJyEK8HvvohgAA7mjXpnX6g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB2797.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(6029001)(136003)(376002)(346002)(396003)(366004)(39840400004)(52536014)(2906002)(8676002)(316002)(5660300002)(7696005)(66946007)(4326008)(76116006)(478600001)(6506007)(186003)(64756008)(86362001)(66476007)(66556008)(83380400001)(9686003)(71200400001)(33656002)(30864003)(55016002)(44832011)(66446008)(54906003)(6862004)(8936002)(2004002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 7cL0SzdLdDDw2UXsztdDA8MnBKpgJ23fgJzeyRuPc+rLZJthz3K19yjqvOFG4UkTx6pkXSIlSbC8GjGrGIV+6/onPl5wOAKV5UgbaHp17ZgMJDHeZa2omXehyBruFBBZXXuUyymh1HnaFeoV9pf4dsPo+CYpgyhoLbNmv4wSklMf0Qqru2YP3satAFllXTw3rCuaD7O8iXt7ukbP6yU39FSQFXyGbiShEw6ccjdzPloiOJOW9ENmh14U84O6zpDi9aP6YS4Pw3aoCMrPmOr/DxV1/toSog9O35AP82FFa1xf2JvLnSDGF+gDVAhWOpOyURrLumdX54oyIt78v3NUUhS01Mt642/eXtndo8QYe1bj24lffmhJnsdJNwEKa6r9nqpgPmB2Slw/PkJE6YPBnjPD2ICSyvwyXeH3z/m01SzqVAnyoemSUp7K2NZtY/usuzQ0guOncGsS3od0m5BOxC7BAsvf1r7uws9WXI0NRGwtAfEkMeyGWEQKH4Tx7uOKeesPGK7PEFLtmOQDsMn2aPmJTkug1R4/eOv6yJf7ht4o0WeHA01f/CFZ9gIZxQ3b7i8GOKYhbBMznjNuqAUxyj3oq5vev6pDNSX5juR7tOdzP+gj+GirWIOtlM6A7UoPVNXDdYgoADzrzYN3VxMMRa96ROLBCZhBgLH2nbD4zKwSBdK31HkRnoXHisiPiL2VNnnZFOa5kjCG7S6naMSv+A==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: openfive.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB2797.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2bd45ee-0395-40ce-9642-08d8860543c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2020 05:47:24.0590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jBbq0tfHu9ExrX+JQnJbS6FrHi+zL+2qdseC5jiazCHh2rc3dmJvBJSBF1Sn4S0HYntLpON19wdb2Mq/hUQrXNRXKVYLA13VjJ4TKmHOXDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3661
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zong,

>-----Original Message-----
>From: linux-riscv <linux-riscv-bounces@lists.infradead.org> On Behalf Of Z=
ong Li
>Sent: 10 November 2020 12:58
>To: Paul Walmsley ( Sifive) <paul.walmsley@sifive.com>; palmer@dabbelt.com=
;
>sboyd@kernel.org; schwab@linux-m68k.org; aou@eecs.berkeley.edu;
>mturquette@baylibre.com; Yash Shah <yash.shah@openfive.com>; linux-
>kernel@vger.kernel.org; linux-clk@vger.kernel.org; linux-
>riscv@lists.infradead.org
>Cc: Erik Danie <erik.danie@sifive.com>; Henry Styles ( Sifive) <hes@sifive=
.com>;
>Zong Li <zong.li@sifive.com>
>Subject: [PATCH v2 3/3] clk: sifive: Add a driver for the SiFive FU740 PRC=
I IP
>block
>
>Add driver code for the SiFive FU740 PRCI IP block. This IP block handles =
reset
>and clock control for the SiFive FU740 device and implements SoC-level clo=
ck
>tree controls and dividers.
>
>This driver contains bug fixes and contributions from Henry Styles
><hes@sifive.com> and Erik Danie <erik.danie@sifive.com>.
>
>Signed-off-by: Zong Li <zong.li@sifive.com>
>Cc: Henry Styles <hes@sifive.com>
>Cc: Erik Danie <erik.danie@sifive.com>
>---
> drivers/clk/sifive/Kconfig                    |   4 +-
> drivers/clk/sifive/Makefile                   |   1 +
> drivers/clk/sifive/fu740-prci.c               | 122 ++++++++++++++++++
> drivers/clk/sifive/fu740-prci.h               |  21 +++
> drivers/clk/sifive/sifive-prci.c              | 120 +++++++++++++++++
> drivers/clk/sifive/sifive-prci.h              |  88 +++++++++++++
> include/dt-bindings/clock/sifive-fu740-prci.h |  23 ++++
> 7 files changed, 377 insertions(+), 2 deletions(-)  create mode 100644
>drivers/clk/sifive/fu740-prci.c  create mode 100644 drivers/clk/sifive/fu7=
40-
>prci.h  create mode 100644 include/dt-bindings/clock/sifive-fu740-prci.h
>
>diff --git a/drivers/clk/sifive/Kconfig b/drivers/clk/sifive/Kconfig index
>ab48cf7e0105..1c14eb20c066 100644
>--- a/drivers/clk/sifive/Kconfig
>+++ b/drivers/clk/sifive/Kconfig
>@@ -13,7 +13,7 @@ config CLK_SIFIVE_PRCI
> 	select CLK_ANALOGBITS_WRPLL_CLN28HPC
> 	help
> 	  Supports the Power Reset Clock interface (PRCI) IP block found in
>-	  FU540 SoCs. If this kernel is meant to run on a SiFive FU540 SoC,
>-	  enable this driver.
>+	  FU540/FU740 SoCs. If this kernel is meant to run on a SiFive FU540/
>+	  FU740 SoCs, enable this driver.
>
> endif
>diff --git a/drivers/clk/sifive/Makefile b/drivers/clk/sifive/Makefile ind=
ex
>fe3e2cb4c4d8..2c05798e4ba4 100644
>--- a/drivers/clk/sifive/Makefile
>+++ b/drivers/clk/sifive/Makefile
>@@ -2,3 +2,4 @@
> obj-y +=3D sifive-prci.o
>
> obj-$(CONFIG_CLK_SIFIVE_PRCI)	+=3D fu540-prci.o
>+obj-$(CONFIG_CLK_SIFIVE_PRCI)	+=3D fu740-prci.o
>diff --git a/drivers/clk/sifive/fu740-prci.c b/drivers/clk/sifive/fu740-pr=
ci.c new file
>mode 100644 index 000000000000..3b87e273c3eb
>--- /dev/null
>+++ b/drivers/clk/sifive/fu740-prci.c
>@@ -0,0 +1,122 @@
>+// SPDX-License-Identifier: GPL-2.0
>+/*
>+ * Copyright (C) 2018-2019 SiFive, Inc.
>+ * Wesley Terpstra
>+ * Paul Walmsley
>+ * Zong Li
>+ *
>+ * This program is free software; you can redistribute it and/or modify
>+ * it under the terms of the GNU General Public License version 2 as
>+ * published by the Free Software Foundation.
>+ *
>+ * This program is distributed in the hope that it will be useful,
>+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
>+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>+ * GNU General Public License for more details.
>+ */
>+
>+#include <dt-bindings/clock/sifive-fu740-prci.h>
>+#include <linux/module.h>
>+#include "sifive-prci.h"
>+
>+/* PRCI integration data for each WRPLL instance */
>+
>+static struct __prci_wrpll_data __prci_corepll_data =3D {
>+	.cfg0_offs =3D PRCI_COREPLLCFG0_OFFSET,
>+	.enable_bypass =3D sifive_prci_coreclksel_use_hfclk,
>+	.disable_bypass =3D sifive_prci_coreclksel_use_final_corepll,
>+};
>+
>+static struct __prci_wrpll_data __prci_ddrpll_data =3D {
>+	.cfg0_offs =3D PRCI_DDRPLLCFG0_OFFSET,
>+};
>+
>+static struct __prci_wrpll_data __prci_gemgxlpll_data =3D {
>+	.cfg0_offs =3D PRCI_GEMGXLPLLCFG0_OFFSET, };
>+
>+static struct __prci_wrpll_data __prci_dvfscorepll_data =3D {
>+	.cfg0_offs =3D PRCI_DVFSCOREPLLCFG0_OFFSET,
>+	.enable_bypass =3D sifive_prci_corepllsel_use_corepll,
>+	.disable_bypass =3D sifive_prci_corepllsel_use_dvfscorepll,
>+};
>+
>+static struct __prci_wrpll_data __prci_hfpclkpll_data =3D {
>+	.cfg0_offs =3D PRCI_HFPCLKPLLCFG0_OFFSET,
>+	.enable_bypass =3D sifive_prci_hfpclkpllsel_use_hfclk,
>+	.disable_bypass =3D sifive_prci_hfpclkpllsel_use_hfpclkpll,
>+};
>+
>+static struct __prci_wrpll_data __prci_cltxpll_data =3D {
>+	.cfg0_offs =3D PRCI_CLTXPLLCFG0_OFFSET,
>+};
>+
>+/* Linux clock framework integration */
>+
>+static const struct clk_ops sifive_fu740_prci_wrpll_clk_ops =3D {
>+	.set_rate =3D sifive_prci_wrpll_set_rate,
>+	.round_rate =3D sifive_prci_wrpll_round_rate,
>+	.recalc_rate =3D sifive_prci_wrpll_recalc_rate, };
>+
>+static const struct clk_ops sifive_fu740_prci_wrpll_ro_clk_ops =3D {
>+	.recalc_rate =3D sifive_prci_wrpll_recalc_rate, };
>+
>+static const struct clk_ops sifive_fu740_prci_tlclksel_clk_ops =3D {
>+	.recalc_rate =3D sifive_prci_tlclksel_recalc_rate, };
>+
>+static const struct clk_ops sifive_fu740_prci_hfpclkplldiv_clk_ops =3D {
>+	.recalc_rate =3D sifive_prci_hfpclkplldiv_recalc_rate,
>+};
>+
>+/* List of clock controls provided by the PRCI */ struct __prci_clock
>+__prci_init_clocks_fu740[] =3D {
>+	[PRCI_CLK_COREPLL] =3D {
>+		.name =3D "corepll",
>+		.parent_name =3D "hfclk",
>+		.ops =3D &sifive_fu740_prci_wrpll_clk_ops,
>+		.pwd =3D &__prci_corepll_data,
>+	},
>+	[PRCI_CLK_DDRPLL] =3D {
>+		.name =3D "ddrpll",
>+		.parent_name =3D "hfclk",
>+		.ops =3D &sifive_fu740_prci_wrpll_ro_clk_ops,
>+		.pwd =3D &__prci_ddrpll_data,
>+	},
>+	[PRCI_CLK_GEMGXLPLL] =3D {
>+		.name =3D "gemgxlpll",
>+		.parent_name =3D "hfclk",
>+		.ops =3D &sifive_fu740_prci_wrpll_clk_ops,
>+		.pwd =3D &__prci_gemgxlpll_data,
>+	},
>+	[PRCI_CLK_DVFSCOREPLL] =3D {
>+		.name =3D "dvfscorepll",
>+		.parent_name =3D "hfclk",
>+		.ops =3D &sifive_fu740_prci_wrpll_clk_ops,
>+		.pwd =3D &__prci_dvfscorepll_data,
>+	},
>+	[PRCI_CLK_HFPCLKPLL] =3D {
>+		.name =3D "hfpclkpll",
>+		.parent_name =3D "hfclk",
>+		.ops =3D &sifive_fu740_prci_wrpll_clk_ops,
>+		.pwd =3D &__prci_hfpclkpll_data,
>+	},
>+	[PRCI_CLK_CLTXPLL] =3D {
>+		.name =3D "cltxpll",
>+		.parent_name =3D "hfclk",
>+		.ops =3D &sifive_fu740_prci_wrpll_clk_ops,
>+		.pwd =3D &__prci_cltxpll_data,
>+	},
>+	[PRCI_CLK_TLCLK] =3D {
>+		.name =3D "tlclk",
>+		.parent_name =3D "corepll",
>+		.ops =3D &sifive_fu740_prci_tlclksel_clk_ops,
>+	},
>+	[PRCI_CLK_PCLK] =3D {
>+		.name =3D "pclk",
>+		.parent_name =3D "hfpclkpll",
>+		.ops =3D &sifive_fu740_prci_hfpclkplldiv_clk_ops,
>+	},
>+};
>diff --git a/drivers/clk/sifive/fu740-prci.h b/drivers/clk/sifive/fu740-pr=
ci.h new
>file mode 100644 index 000000000000..13ef971f7764
>--- /dev/null
>+++ b/drivers/clk/sifive/fu740-prci.h
>@@ -0,0 +1,21 @@
>+/* SPDX-License-Identifier: GPL-2.0 */
>+/*
>+ * Copyright (C) 2020 SiFive, Inc.
>+ * Zong Li
>+ */
>+
>+#ifndef __SIFIVE_CLK_FU740_PRCI_H
>+#define __SIFIVE_CLK_FU740_PRCI_H
>+
>+#include "sifive-prci.h"
>+
>+#define NUM_CLOCK_FU740	8
>+
>+extern struct __prci_clock __prci_init_clocks_fu740[NUM_CLOCK_FU740];
>+
>+static const struct prci_clk_desc prci_clk_fu740 =3D {
>+	.clks =3D __prci_init_clocks_fu740,
>+	.num_clks =3D ARRAY_SIZE(__prci_init_clocks_fu740),
>+};
>+
>+#endif /* __SIFIVE_CLK_FU740_PRCI_H */
>diff --git a/drivers/clk/sifive/sifive-prci.c b/drivers/clk/sifive/sifive-=
prci.c
>index 0ac729eeb71b..4098dbc5881a 100644
>--- a/drivers/clk/sifive/sifive-prci.c
>+++ b/drivers/clk/sifive/sifive-prci.c
>@@ -27,6 +27,7 @@
> #include <linux/of_device.h>
> #include "sifive-prci.h"
> #include "fu540-prci.h"
>+#include "fu740-prci.h"
>
> /*
>  * Private functions
>@@ -242,6 +243,18 @@ unsigned long sifive_prci_tlclksel_recalc_rate(struct
>clk_hw *hw,
> 	return div_u64(parent_rate, div);
> }
>
>+/* HFPCLK clock integration */
>+
>+unsigned long sifive_prci_hfpclkplldiv_recalc_rate(struct clk_hw *hw,
>+						   unsigned long parent_rate)
>+{
>+	struct __prci_clock *pc =3D clk_hw_to_prci_clock(hw);
>+	struct __prci_data *pd =3D pc->pd;
>+	u32 div =3D __prci_readl(pd, PRCI_HFPCLKPLLDIV_OFFSET);
>+
>+	return div_u64(parent_rate, div + 2);
>+}
>+
> /*
>  * Core clock mux control
>  */
>@@ -287,6 +300,112 @@ void sifive_prci_coreclksel_use_corepll(struct
>__prci_data *pd)
> 	r =3D __prci_readl(pd, PRCI_CORECLKSEL_OFFSET);	/* barrier */
> }
>
>+/**
>+ * sifive_prci_coreclksel_use_final_corepll() - switch the CORECLK mux
>+to output
>+ * FINAL_COREPLL
>+ * @pd: struct __prci_data * for the PRCI containing the CORECLK mux
>+reg
>+ *
>+ * Switch the CORECLK mux to the final COREPLL output clock; return
>+once
>+ * complete.
>+ *
>+ * Context: Any context.  Caller must prevent concurrent changes to the
>+ *          PRCI_CORECLKSEL_OFFSET register.
>+ */
>+void sifive_prci_coreclksel_use_final_corepll(struct __prci_data *pd) {
>+	u32 r;
>+
>+	r =3D __prci_readl(pd, PRCI_CORECLKSEL_OFFSET);
>+	r &=3D ~PRCI_CORECLKSEL_CORECLKSEL_MASK;
>+	__prci_writel(r, PRCI_CORECLKSEL_OFFSET, pd);
>+
>+	r =3D __prci_readl(pd, PRCI_CORECLKSEL_OFFSET);	/* barrier */
>+}
>+
>+/**
>+ * sifive_prci_corepllsel_use_dvfscorepll() - switch the COREPLL mux to
>+ * output DVFS_COREPLL
>+ * @pd: struct __prci_data * for the PRCI containing the COREPLL mux
>+reg
>+ *
>+ * Switch the COREPLL mux to the DVFSCOREPLL output clock; return once
>complete.
>+ *
>+ * Context: Any context.  Caller must prevent concurrent changes to the
>+ *          PRCI_COREPLLSEL_OFFSET register.
>+ */
>+void sifive_prci_corepllsel_use_dvfscorepll(struct __prci_data *pd) {
>+	u32 r;
>+
>+	r =3D __prci_readl(pd, PRCI_COREPLLSEL_OFFSET);
>+	r |=3D PRCI_COREPLLSEL_COREPLLSEL_MASK;
>+	__prci_writel(r, PRCI_COREPLLSEL_OFFSET, pd);
>+
>+	r =3D __prci_readl(pd, PRCI_COREPLLSEL_OFFSET);	/* barrier */
>+}
>+
>+/**
>+ * sifive_prci_corepllsel_use_corepll() - switch the COREPLL mux to
>+ * output COREPLL
>+ * @pd: struct __prci_data * for the PRCI containing the COREPLL mux
>+reg
>+ *
>+ * Switch the COREPLL mux to the COREPLL output clock; return once comple=
te.
>+ *
>+ * Context: Any context.  Caller must prevent concurrent changes to the
>+ *          PRCI_COREPLLSEL_OFFSET register.
>+ */
>+void sifive_prci_corepllsel_use_corepll(struct __prci_data *pd) {
>+	u32 r;
>+
>+	r =3D __prci_readl(pd, PRCI_COREPLLSEL_OFFSET);
>+	r &=3D ~PRCI_COREPLLSEL_COREPLLSEL_MASK;
>+	__prci_writel(r, PRCI_COREPLLSEL_OFFSET, pd);
>+
>+	r =3D __prci_readl(pd, PRCI_COREPLLSEL_OFFSET);	/* barrier */
>+}
>+
>+/**
>+ * sifive_prci_hfpclkpllsel_use_hfclk() - switch the HFPCLKPLL mux to
>+ * output HFCLK
>+ * @pd: struct __prci_data * for the PRCI containing the HFPCLKPLL mux
>+reg
>+ *
>+ * Switch the HFPCLKPLL mux to the HFCLK input source; return once comple=
te.
>+ *
>+ * Context: Any context.  Caller must prevent concurrent changes to the
>+ *          PRCI_HFPCLKPLLSEL_OFFSET register.
>+ */
>+void sifive_prci_hfpclkpllsel_use_hfclk(struct __prci_data *pd) {
>+	u32 r;
>+
>+	r =3D __prci_readl(pd, PRCI_HFPCLKPLLSEL_OFFSET);
>+	r |=3D PRCI_HFPCLKPLLSEL_HFPCLKPLLSEL_MASK;
>+	__prci_writel(r, PRCI_HFPCLKPLLSEL_OFFSET, pd);
>+
>+	r =3D __prci_readl(pd, PRCI_HFPCLKPLLSEL_OFFSET);	/* barrier */
>+}
>+
>+/**
>+ * sifive_prci_hfpclkpllsel_use_hfpclkpll() - switch the HFPCLKPLL mux
>+to
>+ * output HFPCLKPLL
>+ * @pd: struct __prci_data * for the PRCI containing the HFPCLKPLL mux
>+reg
>+ *
>+ * Switch the HFPCLKPLL mux to the HFPCLKPLL output clock; return once
>complete.
>+ *
>+ * Context: Any context.  Caller must prevent concurrent changes to the
>+ *          PRCI_HFPCLKPLLSEL_OFFSET register.
>+ */
>+void sifive_prci_hfpclkpllsel_use_hfpclkpll(struct __prci_data *pd) {
>+	u32 r;
>+
>+	r =3D __prci_readl(pd, PRCI_HFPCLKPLLSEL_OFFSET);
>+	r &=3D ~PRCI_HFPCLKPLLSEL_HFPCLKPLLSEL_MASK;
>+	__prci_writel(r, PRCI_HFPCLKPLLSEL_OFFSET, pd);
>+
>+	r =3D __prci_readl(pd, PRCI_HFPCLKPLLSEL_OFFSET);	/* barrier */
>+}
>+
> /**
>  * __prci_register_clocks() - register clock controls in the PRCI
>  * @dev: Linux struct device *
>@@ -391,6 +510,7 @@ static int sifive_prci_probe(struct platform_device
>*pdev)
>
> static const struct of_device_id sifive_prci_of_match[] =3D {
> 	{.compatible =3D "sifive,fu540-c000-prci", .data =3D &prci_clk_fu540},
>+	{.compatible =3D "sifive,fu740-c000-prci", .data =3D &prci_clk_fu740},
> 	{}
> };
>
>diff --git a/drivers/clk/sifive/sifive-prci.h b/drivers/clk/sifive/sifive-=
prci.h
>index 025f717bc053..bc0646bc9c3e 100644
>--- a/drivers/clk/sifive/sifive-prci.h
>+++ b/drivers/clk/sifive/sifive-prci.h
>@@ -117,6 +117,87 @@
> #define PRCI_CLKMUXSTATUSREG_TLCLKSEL_STATUS_MASK			\
> 		(0x1 << PRCI_CLKMUXSTATUSREG_TLCLKSEL_STATUS_SHIFT)
>
>+/* CLTXPLLCFG0 */
>+#define PRCI_CLTXPLLCFG0_OFFSET		0x30
>+#define PRCI_CLTXPLLCFG0_DIVR_SHIFT	0
>+#define PRCI_CLTXPLLCFG0_DIVR_MASK	(0x3f <<
>PRCI_CLTXPLLCFG0_DIVR_SHIFT)
>+#define PRCI_CLTXPLLCFG0_DIVF_SHIFT	6
>+#define PRCI_CLTXPLLCFG0_DIVF_MASK	(0x1ff <<
>PRCI_CLTXPLLCFG0_DIVF_SHIFT)
>+#define PRCI_CLTXPLLCFG0_DIVQ_SHIFT	15
>+#define PRCI_CLTXPLLCFG0_DIVQ_MASK	(0x7 <<
>PRCI_CLTXPLLCFG0_DIVQ_SHIFT)
>+#define PRCI_CLTXPLLCFG0_RANGE_SHIFT	18
>+#define PRCI_CLTXPLLCFG0_RANGE_MASK	(0x7 <<
>PRCI_CLTXPLLCFG0_RANGE_SHIFT)
>+#define PRCI_CLTXPLLCFG0_BYPASS_SHIFT	24
>+#define PRCI_CLTXPLLCFG0_BYPASS_MASK	(0x1 <<
>PRCI_CLTXPLLCFG0_BYPASS_SHIFT)
>+#define PRCI_CLTXPLLCFG0_FSE_SHIFT	25
>+#define PRCI_CLTXPLLCFG0_FSE_MASK	(0x1 <<
>PRCI_CLTXPLLCFG0_FSE_SHIFT)
>+#define PRCI_CLTXPLLCFG0_LOCK_SHIFT	31
>+#define PRCI_CLTXPLLCFG0_LOCK_MASK	(0x1 <<
>PRCI_CLTXPLLCFG0_LOCK_SHIFT)
>+
>+/* CLTXPLLCFG1 */
>+#define PRCI_CLTXPLLCFG1_OFFSET		0x34
>+#define PRCI_CLTXPLLCFG1_CKE_SHIFT	24

This CFG1_CLK_SHIFT should be changed to 31.

>+#define PRCI_CLTXPLLCFG1_CKE_MASK	(0x1 <<
>PRCI_CLTXPLLCFG1_CKE_SHIFT)
>+
>+/* DVFSCOREPLLCFG0 */
>+#define PRCI_DVFSCOREPLLCFG0_OFFSET	0x38
>+
>+/* DVFSCOREPLLCFG1 */
>+#define PRCI_DVFSCOREPLLCFG1_OFFSET	0x3c
>+#define PRCI_DVFSCOREPLLCFG1_CKE_SHIFT	24

Same here

>+#define PRCI_DVFSCOREPLLCFG1_CKE_MASK	(0x1 <<
>PRCI_DVFSCOREPLLCFG1_CKE_SHIFT)
>+
>+/* COREPLLSEL */
>+#define PRCI_COREPLLSEL_OFFSET			0x40
>+#define PRCI_COREPLLSEL_COREPLLSEL_SHIFT	0
>+#define PRCI_COREPLLSEL_COREPLLSEL_MASK					\
>+		(0x1 << PRCI_COREPLLSEL_COREPLLSEL_SHIFT)
>+
>+/* HFPCLKPLLCFG0 */
>+#define PRCI_HFPCLKPLLCFG0_OFFSET		0x50
>+#define PRCI_HFPCLKPLL_CFG0_DIVR_SHIFT		0
>+#define PRCI_HFPCLKPLL_CFG0_DIVR_MASK					\
>+		(0x3f << PRCI_HFPCLKPLLCFG0_DIVR_SHIFT)
>+#define PRCI_HFPCLKPLL_CFG0_DIVF_SHIFT		6
>+#define PRCI_HFPCLKPLL_CFG0_DIVF_MASK					\
>+		(0x1ff << PRCI_HFPCLKPLLCFG0_DIVF_SHIFT)
>+#define PRCI_HFPCLKPLL_CFG0_DIVQ_SHIFT		15
>+#define PRCI_HFPCLKPLL_CFG0_DIVQ_MASK					\
>+		(0x7 << PRCI_HFPCLKPLLCFG0_DIVQ_SHIFT)
>+#define PRCI_HFPCLKPLL_CFG0_RANGE_SHIFT		18
>+#define PRCI_HFPCLKPLL_CFG0_RANGE_MASK					\
>+		(0x7 << PRCI_HFPCLKPLLCFG0_RANGE_SHIFT)
>+#define PRCI_HFPCLKPLL_CFG0_BYPASS_SHIFT	24
>+#define PRCI_HFPCLKPLL_CFG0_BYPASS_MASK					\
>+		(0x1 << PRCI_HFPCLKPLLCFG0_BYPASS_SHIFT)
>+#define PRCI_HFPCLKPLL_CFG0_FSE_SHIFT		25
>+#define PRCI_HFPCLKPLL_CFG0_FSE_MASK					\
>+		(0x1 << PRCI_HFPCLKPLLCFG0_FSE_SHIFT)
>+#define PRCI_HFPCLKPLL_CFG0_LOCK_SHIFT		31
>+#define PRCI_HFPCLKPLL_CFG0_LOCK_MASK					\
>+		(0x1 << PRCI_HFPCLKPLLCFG0_LOCK_SHIFT)
>+
>+/* HFPCLKPLLCFG1 */
>+#define PRCI_HFPCLKPLLCFG1_OFFSET		0x54
>+#define PRCI_HFPCLKPLLCFG1_CKE_SHIFT		24

Same here and I am not able to see your 1st patch in this series.

Thanks
Pragnesh

>+#define PRCI_HFPCLKPLLCFG1_CKE_MASK					\
>+		(0x1 << PRCI_HFPCLKPLLCFG1_CKE_SHIFT)
>+
>+/* HFPCLKPLLSEL */
>+#define PRCI_HFPCLKPLLSEL_OFFSET		0x58
>+#define PRCI_HFPCLKPLLSEL_HFPCLKPLLSEL_SHIFT	0
>+#define PRCI_HFPCLKPLLSEL_HFPCLKPLLSEL_MASK				\
>+		(0x1 << PRCI_HFPCLKPLLSEL_HFPCLKPLLSEL_SHIFT)
>+
>+/* HFPCLKPLLDIV */
>+#define PRCI_HFPCLKPLLDIV_OFFSET		0x5c
>+
>+/* PRCIPLL */
>+#define PRCI_PRCIPLL_OFFSET			0xe0
>+
>+/* PROCMONCFG */
>+#define PRCI_PROCMONCFG_OFFSET			0xf0
>+
> /*
>  * Private structures
>  */
>@@ -187,6 +268,11 @@ struct prci_clk_desc {
> /* Core clock mux control */
> void sifive_prci_coreclksel_use_hfclk(struct __prci_data *pd);  void
>sifive_prci_coreclksel_use_corepll(struct __prci_data *pd);
>+void sifive_prci_coreclksel_use_final_corepll(struct __prci_data *pd);
>+void sifive_prci_corepllsel_use_dvfscorepll(struct __prci_data *pd);
>+void sifive_prci_corepllsel_use_corepll(struct __prci_data *pd); void
>+sifive_prci_hfpclkpllsel_use_hfclk(struct __prci_data *pd); void
>+sifive_prci_hfpclkpllsel_use_hfpclkpll(struct __prci_data *pd);
>
> /* Linux clock framework integration */  long sifive_prci_wrpll_round_rat=
e(struct
>clk_hw *hw, unsigned long rate, @@ -197,5 +283,7 @@ unsigned long
>sifive_prci_wrpll_recalc_rate(struct clk_hw *hw,
> 					    unsigned long parent_rate);
> unsigned long sifive_prci_tlclksel_recalc_rate(struct clk_hw *hw,
> 					       unsigned long parent_rate);
>+unsigned long sifive_prci_hfpclkplldiv_recalc_rate(struct clk_hw *hw,
>+						   unsigned long parent_rate);
>
> #endif /* __SIFIVE_CLK_SIFIVE_PRCI_H */ diff --git a/include/dt-
>bindings/clock/sifive-fu740-prci.h b/include/dt-bindings/clock/sifive-fu74=
0-prci.h
>new file mode 100644
>index 000000000000..cd7706ea5677
>--- /dev/null
>+++ b/include/dt-bindings/clock/sifive-fu740-prci.h
>@@ -0,0 +1,23 @@
>+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
>+/*
>+ * Copyright (C) 2019 SiFive, Inc.
>+ * Wesley Terpstra
>+ * Paul Walmsley
>+ * Zong Li
>+ */
>+
>+#ifndef __DT_BINDINGS_CLOCK_SIFIVE_FU740_PRCI_H
>+#define __DT_BINDINGS_CLOCK_SIFIVE_FU740_PRCI_H
>+
>+/* Clock indexes for use by Device Tree data and the PRCI driver */
>+
>+#define PRCI_CLK_COREPLL	       0
>+#define PRCI_CLK_DDRPLL		       1
>+#define PRCI_CLK_GEMGXLPLL	       2
>+#define PRCI_CLK_DVFSCOREPLL	       3
>+#define PRCI_CLK_HFPCLKPLL	       4
>+#define PRCI_CLK_CLTXPLL	       5
>+#define PRCI_CLK_TLCLK		       6
>+#define PRCI_CLK_PCLK		       7
>+
>+#endif	/* __DT_BINDINGS_CLOCK_SIFIVE_FU740_PRCI_H */
>--
>2.29.2
>
>
>_______________________________________________
>linux-riscv mailing list
>linux-riscv@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/linux-riscv
