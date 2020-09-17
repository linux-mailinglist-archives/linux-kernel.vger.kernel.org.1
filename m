Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5A8126E6DF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 22:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgIQUoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 16:44:20 -0400
Received: from mail-eopbgr20134.outbound.protection.outlook.com ([40.107.2.134]:6243
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726180AbgIQUoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 16:44:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=feSxb0YB67d9StOFiFUkPJU31fcXmPMork085xNByeWouAlAe2YvKIZWuc06OrilaARouPpAuk/UspNlE1vXh6Av28eH6gOi9ndBag6Ssfv0lPHhJXocwx/UwR4fm8DX5Tgmt7aYDP08quaZZYAwp7V644XXCI6LlBoGEGSrDGJNpayVXvijiNHnLdIweDXqonvgb04VhlWeYmm05HYUY8qxE3V9r7l7SiX97ZM/EJ3fC5IYULg1K1lVE07O1EDPy3uIkYhIvcLHnsrRezzpV76J8GUuKMK00KjdjdH8z3zgAhcySnZsmx7ICxAMPCDE1F5hRHZ8CxMYuj5B2sMhfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8zOb91n91Y3daIekpvsStaFA7Vu1eHzg1ilaPw/1xvE=;
 b=IIgL/BIz2BUfpgvodUGcylqYITX/HNAm0ianuTQ+LIkWz1BJelTbvpcHocKMmYsb90A9rkhOgsCvF6d09J7Uh+LdDthw0Yd3fuFlgHu52tqtgDNaKQmhemHobTGtleu9vIRUO1tTshZOjcPKUqEp0AXaIkQZVubbYXuyuQPORbRdMJD4clk+HTCzfgncM5rKkLpcJRk0r08XnRXGMEkEryN3EsSKCjRznfBEEB3xLrwhj8rpr8t9UELgcpS/4U/+gvERrKCI7peIyWpG8J0ACm4RI9nQN/TgjMKwfT8pvxC+Wg8BQm0AeVK242mxRoz9J6AXElxcONT7IHCTxO+kcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8zOb91n91Y3daIekpvsStaFA7Vu1eHzg1ilaPw/1xvE=;
 b=Cr28K2n9+cOVi1iDfqFBkPy+UI0GFveOa5BtsERF4v2FuqO5qRBS/MMehgy7Lo1qQ3H5uqS8x7Ui8LT05p4eCFN96zrW/m1QGrPcLTgInO1kpRUadvNtwUkNGgPYDeSdRdFTmBzTLFS3P9NzSnMXQREFan5EeGiu5Oqw3vF1A/M=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB6PR0201MB2392.eurprd02.prod.outlook.com (2603:10a6:4:37::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.17; Thu, 17 Sep
 2020 20:44:14 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::3890:7b1:97a6:1e47]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::3890:7b1:97a6:1e47%7]) with mapi id 15.20.3391.011; Thu, 17 Sep 2020
 20:44:13 +0000
Subject: Re: [PATCH] arm64: dts: ti: k3-j721e: Rename mux header and update
 macro names
To:     Roger Quadros <rogerq@ti.com>, nm@ti.com
Cc:     t-kristo@ti.com, nsekhar@ti.com, kishon@ti.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20200917161649.27667-1-rogerq@ti.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <313b8869-2576-de47-708d-4a7511a3ed44@axentia.se>
Date:   Thu, 17 Sep 2020 22:44:05 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20200917161649.27667-1-rogerq@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0901CA0049.eurprd09.prod.outlook.com
 (2603:10a6:3:45::17) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.226.217.78) by HE1PR0901CA0049.eurprd09.prod.outlook.com (2603:10a6:3:45::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14 via Frontend Transport; Thu, 17 Sep 2020 20:44:12 +0000
X-Originating-IP: [85.226.217.78]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8c8ea8e-3da9-4cfd-64da-08d85b4a6fe2
X-MS-TrafficTypeDiagnostic: DB6PR0201MB2392:
X-Microsoft-Antispam-PRVS: <DB6PR0201MB23923C818591235317B1714FBC3E0@DB6PR0201MB2392.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UdWydGsWtrOVcX6nqItAr+V6pW7zKceWC6uD+RZMou5I/9kXGOaVMCefpQYSHYuIGN0XSX0iDv+VbS0CojoEVN2Hw5NU4PIv92OaaNxAwHOPf3FTGMNFj37FnF/jSZBpR4JtLZ8aFfxlI5k4uJxoH//jv9EZvls47m/iyqITvmituVq7uUfAszG6dX8uyE53dJvAWeBm3H4vdVzHqBe376y8i4d0lnxGqr0P73/trdEJiQa9lItZ+JsvMNb8vAA4oJub2dMQX8RKXahRxHHRa/XilGuTNeNFHkH3Bcd9sowUaQKYvY8dpW/xwyDrVzSgpX9m4eFc5C/oiBwqvFb8dnlEUeUc0gaJCHEanXGZpJeJqW8u06zCv6q94wfJf2j8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39840400004)(346002)(136003)(366004)(376002)(53546011)(5660300002)(478600001)(36916002)(4326008)(8936002)(31686004)(31696002)(86362001)(6486002)(6666004)(186003)(8676002)(83380400001)(16526019)(36756003)(52116002)(26005)(66946007)(66556008)(2616005)(316002)(66476007)(2906002)(956004)(16576012)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: TiWnDRCxq3OxIyKIPU0qGs4IINwXbBy2+IZwlvPPF+BeyEsh2aF4Fdl4BMpzJU18CgeEMpOG/e3wro9NL/tSrfO6ogrS+Cw2mR166ozzYEOBz2ZrZ8JZG17/wkJeftHtt9PemuWCwUVBGBuRROFff3TJXm7K4sDUsbWCqCkCCyDypPLaLjhjbyjm+zFuyNn3c1JbUUG1HTfp4e6jsq+65Jm2uvV3JA0UIMKr+1pTDyN+aE2G54DXLi2c4PFfUAS8iNmfvf1OUPeYCsiGF7mBix7K3uztCmUka4QfP3BAoyFbnXTm9ttBDU+OuFolZeKyKerxrgWRnn7QSsl502+hokivQ24UqyXz0H7ujdxBjeewJcMT+C+ofdvaRSkuG139XyX3NSHeaYze+9g32M65S30sW1kRIcv7rQePkFkXhfLGvRivOnQspsVedRJ014oQnmjTmxHXFI1jNwPHzB0/qJcURX6D6IZHMc+0d0zLc8RaDjIK6BRv/sV8cmUF4FoI2ha8ahbiRJU3E9SEg9srVNydK6MuB8Z/nHfi7wN8prIHP/z5QB5hht23JIwGujhPae0bqoFuaWKnxVJ3qOcXurYknktw3p20GokJtJR58jNDOI2vpwpCTnrTyL1/AU4VNuuMReSSM/1JjbZ/1WOfvg==
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: d8c8ea8e-3da9-4cfd-64da-08d85b4a6fe2
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 20:44:13.8658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DF09QuK0SOPMLN5zUG0Z6h1BsjEc9kLe+7+F2+ARG4FXNnooXadeHNWjiens1Iaf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0201MB2392
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

A few questions. I don't really care, but if someone does then at least I
highlighted few thing out.

On 2020-09-17 18:16, Roger Quadros wrote:
> We intend to use one header file for SERDES MUX for all
> TI SoCs so rename the header file.
> 
> The exsting macros are too generic. Prefix them with SoC name.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  .../dts/ti/k3-j721e-common-proc-board.dts     | 11 ++--
>  arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 13 +++--
>  include/dt-bindings/mux/mux-j721e-wiz.h       | 53 ------------------
>  include/dt-bindings/mux/ti-serdes.h           | 55 +++++++++++++++++++
>  4 files changed, 68 insertions(+), 64 deletions(-)
>  delete mode 100644 include/dt-bindings/mux/mux-j721e-wiz.h
>  create mode 100644 include/dt-bindings/mux/ti-serdes.h
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
> index 8bc1e6ecc50e..493f64ee7a2a 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
> @@ -404,11 +404,12 @@
>  };
>  
>  &serdes_ln_ctrl {
> -	idle-states = <SERDES0_LANE0_PCIE0_LANE0>, <SERDES0_LANE1_PCIE0_LANE1>,
> -		      <SERDES1_LANE0_PCIE1_LANE0>, <SERDES1_LANE1_PCIE1_LANE1>,
> -		      <SERDES2_LANE0_PCIE2_LANE0>, <SERDES2_LANE1_PCIE2_LANE1>,
> -		      <SERDES3_LANE0_USB3_0_SWAP>, <SERDES3_LANE1_USB3_0>,
> -		      <SERDES4_LANE0_EDP_LANE0>, <SERDES4_LANE1_EDP_LANE1>, <SERDES4_LANE2_EDP_LANE2>, <SERDES4_LANE3_EDP_LANE3>;
> +	idle-states = <J721E_SERDES0_LANE0_PCIE0_LANE0>, <J721E_SERDES0_LANE1_PCIE0_LANE1>,
> +		      <J721E_SERDES1_LANE0_PCIE1_LANE0>, <J721E_SERDES1_LANE1_PCIE1_LANE1>,
> +		      <J721E_SERDES2_LANE0_PCIE2_LANE0>, <J721E_SERDES2_LANE1_PCIE2_LANE1>,
> +		      <J721E_SERDES3_LANE0_USB3_0_SWAP>, <J721E_SERDES3_LANE1_USB3_0>,
> +		      <J721E_SERDES4_LANE0_EDP_LANE0>, <J721E_SERDES4_LANE1_EDP_LANE1>,
> +		      <J721E_SERDES4_LANE2_EDP_LANE2>, <J721E_SERDES4_LANE3_EDP_LANE3>;
>  };
>  
>  &serdes_wiz3 {
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> index d14060207f00..924c51146d01 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> @@ -6,7 +6,7 @@
>   */
>  #include <dt-bindings/phy/phy.h>
>  #include <dt-bindings/mux/mux.h>
> -#include <dt-bindings/mux/mux-j721e-wiz.h>
> +#include <dt-bindings/mux/ti-serdes.h>
>  
>  &cbass_main {
>  	msmc_ram: sram@70000000 {
> @@ -38,11 +38,12 @@
>  					<0x40b0 0x3>, <0x40b4 0x3>, /* SERDES3 lane0/1 select */
>  					<0x40c0 0x3>, <0x40c4 0x3>, <0x40c8 0x3>, <0x40cc 0x3>;
>  					/* SERDES4 lane0/1/2/3 select */
> -			idle-states = <SERDES0_LANE0_PCIE0_LANE0>, <SERDES0_LANE1_PCIE0_LANE1>,
> -				      <SERDES1_LANE0_PCIE1_LANE0>, <SERDES1_LANE1_PCIE1_LANE1>,
> -				      <SERDES2_LANE0_PCIE2_LANE0>, <SERDES2_LANE1_PCIE2_LANE1>,
> -				      <MUX_IDLE_AS_IS>, <SERDES3_LANE1_USB3_0>,
> -				      <SERDES4_LANE0_EDP_LANE0>, <SERDES4_LANE1_EDP_LANE1>, <SERDES4_LANE2_EDP_LANE2>, <SERDES4_LANE3_EDP_LANE3>;
> +			idle-states = <J721E_SERDES0_LANE0_PCIE0_LANE0>, <J721E_SERDES0_LANE1_PCIE0_LANE1>,
> +				      <J721E_SERDES1_LANE0_PCIE1_LANE0>, <J721E_SERDES1_LANE1_PCIE1_LANE1>,
> +				      <J721E_SERDES2_LANE0_PCIE2_LANE0>, <J721E_SERDES2_LANE1_PCIE2_LANE1>,
> +				      <MUX_IDLE_AS_IS>, <J721E_SERDES3_LANE1_USB3_0>,
> +				      <J721E_SERDES4_LANE0_EDP_LANE0>, <J721E_SERDES4_LANE1_EDP_LANE1>,
> +				      <J721E_SERDES4_LANE2_EDP_LANE2>, <J721E_SERDES4_LANE3_EDP_LANE3>;
>  		};
>  
>  		usb_serdes_mux: mux-controller@4000 {
> diff --git a/include/dt-bindings/mux/mux-j721e-wiz.h b/include/dt-bindings/mux/mux-j721e-wiz.h
> deleted file mode 100644
> index fd1c4ea9fc7f..000000000000
> --- a/include/dt-bindings/mux/mux-j721e-wiz.h
> +++ /dev/null
> @@ -1,53 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/*
> - * This header provides constants for J721E WIZ.
> - */
> -
> -#ifndef _DT_BINDINGS_J721E_WIZ
> -#define _DT_BINDINGS_J721E_WIZ
> -
> -#define SERDES0_LANE0_QSGMII_LANE1	0x0
> -#define SERDES0_LANE0_PCIE0_LANE0	0x1
> -#define SERDES0_LANE0_USB3_0_SWAP	0x2
> -
> -#define SERDES0_LANE1_QSGMII_LANE2	0x0
> -#define SERDES0_LANE1_PCIE0_LANE1	0x1
> -#define SERDES0_LANE1_USB3_0		0x2
> -
> -#define SERDES1_LANE0_QSGMII_LANE3	0x0
> -#define SERDES1_LANE0_PCIE1_LANE0	0x1
> -#define SERDES1_LANE0_USB3_1_SWAP	0x2
> -#define SERDES1_LANE0_SGMII_LANE0	0x3
> -
> -#define SERDES1_LANE1_QSGMII_LANE4	0x0
> -#define SERDES1_LANE1_PCIE1_LANE1	0x1
> -#define SERDES1_LANE1_USB3_1		0x2
> -#define SERDES1_LANE1_SGMII_LANE1	0x3
> -
> -#define SERDES2_LANE0_PCIE2_LANE0	0x1
> -#define SERDES2_LANE0_SGMII_LANE0	0x3
> -#define SERDES2_LANE0_USB3_1_SWAP	0x2
> -
> -#define SERDES2_LANE1_PCIE2_LANE1	0x1
> -#define SERDES2_LANE1_USB3_1		0x2
> -#define SERDES2_LANE1_SGMII_LANE1	0x3
> -
> -#define SERDES3_LANE0_PCIE3_LANE0	0x1
> -#define SERDES3_LANE0_USB3_0_SWAP	0x2
> -
> -#define SERDES3_LANE1_PCIE3_LANE1	0x1
> -#define SERDES3_LANE1_USB3_0		0x2
> -
> -#define SERDES4_LANE0_EDP_LANE0		0x0
> -#define SERDES4_LANE0_QSGMII_LANE5	0x2
> -
> -#define SERDES4_LANE1_EDP_LANE1		0x0
> -#define SERDES4_LANE1_QSGMII_LANE6	0x2
> -
> -#define SERDES4_LANE2_EDP_LANE2		0x0
> -#define SERDES4_LANE2_QSGMII_LANE7	0x2
> -
> -#define SERDES4_LANE3_EDP_LANE3		0x0
> -#define SERDES4_LANE3_QSGMII_LANE8	0x2
> -
> -#endif /* _DT_BINDINGS_J721E_WIZ */
> diff --git a/include/dt-bindings/mux/ti-serdes.h b/include/dt-bindings/mux/ti-serdes.h
> new file mode 100644
> index 000000000000..3e1f2d243e4a
> --- /dev/null
> +++ b/include/dt-bindings/mux/ti-serdes.h
> @@ -0,0 +1,55 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * This header provides constants for SERDES MUX for TI SoCs
> + */
> +
> +#ifndef _DT_BINDINGS_TI_SERDES_MUX
> +#define _DT_BINDINGS_TI_SERDES_MUX

I would have spelled this _DT_BINDINGS_MUX_TI_SERDES. But as stated, it
doesn't really matter to me.

> +
> +/* J721E */
> +
> +#define J721E_SERDES0_LANE0_QSGMII_LANE1	0x0
> +#define J721E_SERDES0_LANE0_PCIE0_LANE0		0x1
> +#define J721E_SERDES0_LANE0_USB3_0_SWAP		0x2
> +
> +#define J721E_SERDES0_LANE1_QSGMII_LANE2	0x0
> +#define J721E_SERDES0_LANE1_PCIE0_LANE1		0x1
> +#define J721E_SERDES0_LANE1_USB3_0		0x2
> +
> +#define J721E_SERDES1_LANE0_QSGMII_LANE3	0x0
> +#define J721E_SERDES1_LANE0_PCIE1_LANE0		0x1
> +#define J721E_SERDES1_LANE0_USB3_1_SWAP		0x2
> +#define J721E_SERDES1_LANE0_SGMII_LANE0		0x3
> +
> +#define J721E_SERDES1_LANE1_QSGMII_LANE4	0x0
> +#define J721E_SERDES1_LANE1_PCIE1_LANE1		0x1
> +#define J721E_SERDES1_LANE1_USB3_1		0x2
> +#define J721E_SERDES1_LANE1_SGMII_LANE1		0x3
> +
> +#define J721E_SERDES2_LANE0_PCIE2_LANE0		0x1
> +#define J721E_SERDES2_LANE0_SGMII_LANE0		0x3
> +#define J721E_SERDES2_LANE0_USB3_1_SWAP		0x2
> +
> +#define J721E_SERDES2_LANE1_PCIE2_LANE1		0x1
> +#define J721E_SERDES2_LANE1_USB3_1		0x2
> +#define J721E_SERDES2_LANE1_SGMII_LANE1		0x3
> +
> +#define J721E_SERDES3_LANE0_PCIE3_LANE0		0x1
> +#define J721E_SERDES3_LANE0_USB3_0_SWAP		0x2
> +
> +#define J721E_SERDES3_LANE1_PCIE3_LANE1		0x1
> +#define J721E_SERDES3_LANE1_USB3_0		0x2
> +
> +#define J721E_SERDES4_LANE0_EDP_LANE0		0x0
> +#define J721E_SERDES4_LANE0_QSGMII_LANE5	0x2
> +
> +#define J721E_SERDES4_LANE1_EDP_LANE1		0x0
> +#define J721E_SERDES4_LANE1_QSGMII_LANE6	0x2
> +
> +#define J721E_SERDES4_LANE2_EDP_LANE2		0x0
> +#define J721E_SERDES4_LANE2_QSGMII_LANE7	0x2
> +
> +#define J721E_SERDES4_LANE3_EDP_LANE3		0x0
> +#define J721E_SERDES4_LANE3_QSGMII_LANE8	0x2
> +
> +#endif /* _DT_BINDINGS_TI_SERDES_MUX */
> 

The J7200-series listed *all* possible mux values, some with names
like BLA_BLA_UNUSED. Why is that different here? Some dt-files using
the J7200 then ended up using these "unused" entries (for idle-states)
so maybe thoes values are useful here as well? The choice of using
_UNUSED for entries that end up being used can of course also be
debated :-)

If it is ill-adviced to use the values not listed above, that's
another matter of course...

I don't know the answer to the above, and will not be impacted in the
least, I'm just throwing out questions. So, either way:

Acked-by: Peter Rosin <peda@axentia.se>

Cheers,
Peter
