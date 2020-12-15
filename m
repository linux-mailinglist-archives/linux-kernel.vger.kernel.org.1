Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16F1C2DA7E7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 07:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbgLOF7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 00:59:33 -0500
Received: from mail-eopbgr130058.outbound.protection.outlook.com ([40.107.13.58]:25094
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725778AbgLOF7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 00:59:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LCM2Rc259fT8NnmSTl24MwLiREv3kRu8Ulof5Z5+JoOdS3qQSvsKeqYKrPu3mL/wg0xLH9JOSQBAC6++Mm37K4oqpuSk8oICYFqEwK4OaJzt9Af+aGZLg6VZfvKPpklj4GvdnL8eWWLJRSbX4OTccPCrRQ8P30ykD9pQEHLKkHciCoIUYKl2AP4htlcEszfjUa5TEKPQhdTVcne5rBNCpdHQ1XX13SYlIO2uBt9S0NlyXlqwlUeLSiiD5Hhs+3az1s4+ahzU2I8tSbvvmwPF4Bf9NFSpWTIr678idmIP7XChsvgplruIGB2DCqjIcuGSRPlqFMdzkXIPXNeL0qUbPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+StpzcOPi0tFazus9pSl4OvpaNv05LA6FiAPV7CNMmA=;
 b=gOKFgEjim7W7JGf+JbjldnKmJruizs1yXoS8OcP7xk+tfGwc0gU5VIT6TetG/608RtHQDyoC5mlMExhKoMnfToitBuWaDWEJnxz4957SEPUjDiDdwFbOz8oEEO3zSlJ8+/ZokvKOH8BF6HESa20CGqOh/bqKB3PlocKJrw9pRyW6XpRHTMVMDtM5TtTbN/zhcnX9nUWwF2hT2G/krbd+bta0fbO3nWkwBAjf8aUSJjtTa+ZoOT71BvKOZux1Sz4a7OASNnF9YlXm+mYKq+r1J+saTnyrGBtQ5Tr2vJDnMR8f2gPhvXS7zxf1FOOdqdtmHSWeBiumV7GVsVd3XjmKiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+StpzcOPi0tFazus9pSl4OvpaNv05LA6FiAPV7CNMmA=;
 b=ItBljGQXD60pLltJSTqDGZCxIJj/fIRRh0EvO9D2dPqTF6GLefgtwQI1ckgxGnVFklLBM18njwpUBRqzpkiQCjKqmOhec5S+pesSwMIXqVjzP5lRfXODAQUnpQm21lSvqJXPQz5XRFA/KLauGfYeu4EhG/iwPWdZsAHzp4sbPm4=
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com (2603:10a6:10:1ec::9)
 by DBBPR04MB7515.eurprd04.prod.outlook.com (2603:10a6:10:202::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.25; Tue, 15 Dec
 2020 05:58:42 +0000
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::c8c:888f:3e0c:8d5c]) by DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::c8c:888f:3e0c:8d5c%5]) with mapi id 15.20.3654.026; Tue, 15 Dec 2020
 05:58:41 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     kernel test robot <lkp@intel.com>
CC:     Pawel Laszczak <pawell@cadence.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "a-govindraju@ti.com" <a-govindraju@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kurahul@cadence.com" <kurahul@cadence.com>
Subject: Re: [PATCH] usb: cdns3: Adds missing __iomem markers
Thread-Topic: [PATCH] usb: cdns3: Adds missing __iomem markers
Thread-Index: AQHW0hfGBMly9RIqbEOsghijqtNl3qn2uXEAgADw6gA=
Date:   Tue, 15 Dec 2020 05:58:41 +0000
Message-ID: <20201215055812.GA18223@b29397-desktop>
References: <20201214125043.29710-1-pawell@cadence.com>
 <202012142359.ZshcbBoP-lkp@intel.com>
In-Reply-To: <202012142359.ZshcbBoP-lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.9.4 (2018-02-28)
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6e87852d-97b3-4993-3052-08d8a0be79b6
x-ms-traffictypediagnostic: DBBPR04MB7515:
x-microsoft-antispam-prvs: <DBBPR04MB751585729F704737E681F3608BC60@DBBPR04MB7515.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 44rKnAQGB55mXVq9KmlbWgrp26cuAjHmerkpkkCbyhNgyUIV7hLxcLKElN2fGASO08cZu2/3/fHz6XaM9U9TItbM6Jw+mL2nV6mmNOMEsjeN0yn7+X378sfnOvDgI7wwIkbzO9rsXeM+SMUYHv6Q7jnRICzjg3fD6R/6NA0rE2eQ/Kd5WRu2pveCzAgU9niyWhanFa+BLkSh6J4yqTl4iPcjn06hEFmv/djWNy/ibCYTyDoHB+/VQGhpxwATX9deq41zoJI1okzwgxVefdhXhc7xwY5JLCrtEHcJUhHXfjnuUlwm675MowivT8+3XdPXNGtOBtFT2CXp/sL7jruoAHMr8JlmytyUCmqBCKy4k+WHZiTPerAjiYcU0jcpKGSoyJWOW2M1MbvKk7VBCiMrnw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7979.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(39860400002)(396003)(366004)(376002)(136003)(346002)(54906003)(66476007)(316002)(71200400001)(83380400001)(6506007)(33656002)(91956017)(8936002)(45080400002)(966005)(4326008)(186003)(26005)(86362001)(478600001)(30864003)(5660300002)(64756008)(8676002)(6916009)(9686003)(66946007)(6512007)(33716001)(66556008)(76116006)(2906002)(1076003)(53546011)(7416002)(44832011)(6486002)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?TCxBlUDnC1G5+kel4MlMXXn27vXipfuThBvO7iQ4Dcfzz4/2ZfKiWK+QGHaC?=
 =?us-ascii?Q?+LhkV3dEtzDwYxKa8QPpDh4UcCIn+R1eSd39jm2JqUuHcUD3A48d7+7/+vOK?=
 =?us-ascii?Q?w3sSzXTgIQETyWwy7K1gSVEsRKE0XEt5jJ6G6339Nn5+HagBGlfX1LQJ0ZoY?=
 =?us-ascii?Q?gTsEF3Vv3U0CP5+rHeJ7m/MNbmVtZ37ZUdO2Tth+gdOOWNe7WmAoKEexCxwP?=
 =?us-ascii?Q?9D/xwwVyteLL5Co1NUIjsSnC8bTgJb0lVmLaQBHEiY8/gtI9DsqspM1YonZL?=
 =?us-ascii?Q?D5lsP89HVXgtWrU2/OOU1PphGKHkvYwRSNI+i+CC32nP3Po1vEfIEgdIfuly?=
 =?us-ascii?Q?L9Cq33ZNvqxs6CigAmdTMgVJ5ywMC1TWKtAcpjvw3C5v3lYtXErzFktYQATj?=
 =?us-ascii?Q?awADg5dLcLwBmEjriJ/k1rQybzOdIRM8kx2+nSd5yBNlZ67PN/QplYN+NczN?=
 =?us-ascii?Q?Dkgfux0zN1Xd/CxrgrS5JZ8QvFEm5W00hNlDULca/JeoXxrVrwUpxLtfgncR?=
 =?us-ascii?Q?3hhp3ryAviVWLS8Pi1P4zbiBdF34vzB0XBrT/5bXvLoR4zDHABTQ+GowdTXA?=
 =?us-ascii?Q?ndoIe2MAYpFekQGcpj54fgctWT6U4b4pjBzvn62pO1/LREpdzy8cAgfrezmA?=
 =?us-ascii?Q?uWGQa/wuA7k8CDctc0uyYzxx+JiExRlFibaU0yUGCny8AjlCWr8WWl7A+lAN?=
 =?us-ascii?Q?ve1+2i+ru/ePVIKWLfEiIy3fCrUajY5SzulPDeyNxLN4CfrBsMOa22U/88Wv?=
 =?us-ascii?Q?1emFFuJP6Ua7kINvpMLCMDj8cqSg+XLPdEi2pX7frIu3ol7phokwJ5jF3ULc?=
 =?us-ascii?Q?wSGYMNNNgL/vqaHnLKxPOUjxPa/EitkSUJpPM1nYlkpr2/m5R3r0o/OP1j7w?=
 =?us-ascii?Q?LRgZdJUnW5FVIJjvDDSHRC22YlNrxanCBvEY9IYneVRjP/WorAZ7yBJ6J4rP?=
 =?us-ascii?Q?WoQqv/oaqasrKcz20cgupIfycfKgx6drtf/0TRmcKchaEq0oiL3oDlDXAF+K?=
 =?us-ascii?Q?DY7J?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A9B2218C91E11A4A866BABFFB8938117@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7979.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e87852d-97b3-4993-3052-08d8a0be79b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2020 05:58:41.8571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d1edWVmDYHr0ijc3u+0UrM0q6aCybHmXGDNnPRZhoNFjFoIhmDeNJ170HJJN4rUAjSJINsR/Zy2FUaZsO9s9vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7515
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-12-14 23:35:56, kernel test robot wrote:
> Hi Pawel,
>=20
> I love your patch! Perhaps something to improve:
>=20
> [auto build test WARNING on next-20201211]
> [cannot apply to peter.chen-usb/ci-for-usb-next v5.10 v5.10-rc7 v5.10-rc6=
 v5.10]

Sorry, I changed the branch name to reflect the branch does not only queue
chipidea USB patches.

next branch: for-usb-next
fixes branch: for-usb-fixes

Peter

> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit-s=
cm.com%2Fdocs%2Fgit-format-patch&amp;data=3D04%7C01%7Cpeter.chen%40nxp.com%=
7C6ce79474794448ae12b008d8a045f9ce%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7=
C0%7C637435572341553421%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjo=
iV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DCy3huYNzWiJ57OKm=
zmaleCT14gcFr8RyYDnqTfZWNG4%3D&amp;reserved=3D0]
>=20
> url:    https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F=
%2Fgithub.com%2F0day-ci%2Flinux%2Fcommits%2FPawel-Laszczak%2Fusb-cdns3-Adds=
-missing-__iomem-markers%2F20201214-205353&amp;data=3D04%7C01%7Cpeter.chen%=
40nxp.com%7C6ce79474794448ae12b008d8a045f9ce%7C686ea1d3bc2b4c6fa92cd99c5c30=
1635%7C0%7C0%7C637435572341553421%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwM=
DAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3Dx5XoDU=
UskeGteTFaPjgS24Hrbb712XqMqaIkqwXWu14%3D&amp;reserved=3D0
> base:    3cc2bd440f2171f093b3a8480a4b54d8c270ed38
> config: riscv-allmodconfig (attached as .config)
> compiler: riscv64-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=3D1 build):
>         wget https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%=
3A%2F%2Fraw.githubusercontent.com%2Fintel%2Flkp-tests%2Fmaster%2Fsbin%2Fmak=
e.cross&amp;data=3D04%7C01%7Cpeter.chen%40nxp.com%7C6ce79474794448ae12b008d=
8a045f9ce%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637435572341553421%7=
CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwi=
LCJXVCI6Mn0%3D%7C1000&amp;sdata=3DjAavg0T3itnjkbHXADvePHHgtYeqiVTBt%2BoatHT=
0VHU%3D&amp;reserved=3D0 -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%=
2F%2Fgithub.com%2F0day-ci%2Flinux%2Fcommit%2F315bfcf1e0604de6ecfc1856cf5820=
876390f16c&amp;data=3D04%7C01%7Cpeter.chen%40nxp.com%7C6ce79474794448ae12b0=
08d8a045f9ce%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63743557234155342=
1%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1ha=
WwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DSQ75IXxfld6HMRIFkZ%2F8Z4YqxnFP%2F%2BZ%=
2BsYZIycNeO%2FA%3D&amp;reserved=3D0
>         git remote add linux-review https://eur01.safelinks.protection.ou=
tlook.com/?url=3Dhttps%3A%2F%2Fgithub.com%2F0day-ci%2Flinux&amp;data=3D04%7=
C01%7Cpeter.chen%40nxp.com%7C6ce79474794448ae12b008d8a045f9ce%7C686ea1d3bc2=
b4c6fa92cd99c5c301635%7C0%7C0%7C637435572341553421%7CUnknown%7CTWFpbGZsb3d8=
eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&a=
mp;sdata=3DZVS4723WbEO03hbsLXJ%2B%2FmB5EZElulY7lAsMEMatiko%3D&amp;reserved=
=3D0
>         git fetch --no-tags linux-review Pawel-Laszczak/usb-cdns3-Adds-mi=
ssing-__iomem-markers/20201214-205353
>         git checkout 315bfcf1e0604de6ecfc1856cf5820876390f16c
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-9.3.0 make.cros=
s ARCH=3Driscv=20
>=20
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>=20
> All warnings (new ones prefixed by >>):
>=20
>    In file included from arch/riscv/include/asm/io.h:23,
>                     from include/linux/io.h:13,
>                     from include/linux/irq.h:20,
>                     from include/asm-generic/hardirq.h:17,
>                     from ./arch/riscv/include/generated/asm/hardirq.h:1,
>                     from include/linux/hardirq.h:10,
>                     from include/linux/interrupt.h:11,
>                     from drivers/usb/cdns3/drd.c:13:
>    drivers/usb/cdns3/drd.c: In function 'cdns_otg_disable_irq':
>    drivers/usb/cdns3/drd.c:159:31: error: dereferencing pointer to incomp=
lete type 'struct cdns_otg_irq_reg'
>      159 |  writel(0, &cdns->otg_irq_regs->ien);
>          |                               ^~
>    arch/riscv/include/asm/mmio.h:93:76: note: in definition of macro 'wri=
tel_cpu'
>       93 | #define writel_cpu(v, c) ((void)__raw_writel((__force u32)cpu_=
to_le32(v), (c)))
>          |                                                               =
             ^
>    drivers/usb/cdns3/drd.c:159:2: note: in expansion of macro 'writel'
>      159 |  writel(0, &cdns->otg_irq_regs->ien);
>          |  ^~~~~~
>    drivers/usb/cdns3/drd.c: In function 'cdns_drd_init':
>    drivers/usb/cdns3/drd.c:409:22: error: assignment to 'struct cdns_otg_=
irq_reg *' from incompatible pointer type 'struct cdns_otg_irq_regs *' [-We=
rror=3Dincompatible-pointer-types]
>      409 |   cdns->otg_irq_regs =3D (struct cdns_otg_irq_regs __iomem  *)
>          |                      ^
>    In file included from include/linux/byteorder/little_endian.h:5,
>                     from arch/riscv/include/uapi/asm/byteorder.h:10,
>                     from include/asm-generic/bitops/le.h:6,
>                     from arch/riscv/include/asm/bitops.h:202,
>                     from include/linux/bitops.h:32,
>                     from include/linux/kernel.h:11,
>                     from drivers/usb/cdns3/drd.c:12:
> >> drivers/usb/cdns3/drd.c:421:33: warning: passing argument 1 of '__raw_=
readl' makes pointer from integer without a cast [-Wint-conversion]
>      421 |   if (readl(cdns->otg_cdnsp_regs->did) =3D=3D OTG_CDNSP_DID) {
>          |             ~~~~~~~~~~~~~~~~~~~~^~~~~
>          |                                 |
>          |                                 __le32 {aka unsigned int}
>    include/uapi/linux/byteorder/little_endian.h:34:51: note: in definitio=
n of macro '__le32_to_cpu'
>       34 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
>          |                                                   ^
>    arch/riscv/include/asm/mmio.h:140:47: note: in expansion of macro 'rea=
dl_cpu'
>      140 | #define readl(c) ({ u32 __v; __io_br(); __v =3D readl_cpu(c); =
__io_ar(__v); __v; })
>          |                                               ^~~~~~~~~
>    drivers/usb/cdns3/drd.c:421:7: note: in expansion of macro 'readl'
>      421 |   if (readl(cdns->otg_cdnsp_regs->did) =3D=3D OTG_CDNSP_DID) {
>          |       ^~~~~
>    In file included from arch/riscv/include/asm/io.h:23,
>                     from include/linux/io.h:13,
>                     from include/linux/irq.h:20,
>                     from include/asm-generic/hardirq.h:17,
>                     from ./arch/riscv/include/generated/asm/hardirq.h:1,
>                     from include/linux/hardirq.h:10,
>                     from include/linux/interrupt.h:11,
>                     from drivers/usb/cdns3/drd.c:13:
>    arch/riscv/include/asm/mmio.h:63:60: note: expected 'const volatile vo=
id *' but argument is of type '__le32' {aka 'unsigned int'}
>       63 | static inline u32 __raw_readl(const volatile void __iomem *add=
r)
>          |                               ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~=
~
>    drivers/usb/cdns3/drd.c:422:23: error: assignment to 'struct cdns_otg_=
irq_reg *' from incompatible pointer type 'struct cdns_otg_irq_regs *' [-We=
rror=3Dincompatible-pointer-types]
>      422 |    cdns->otg_irq_regs =3D (struct cdns_otg_irq_regs __iomem *)
>          |                       ^
>    drivers/usb/cdns3/drd.c:426:23: error: assignment to 'struct cdns_otg_=
irq_reg *' from incompatible pointer type 'struct cdns_otg_irq_regs *' [-We=
rror=3Dincompatible-pointer-types]
>      426 |    cdns->otg_irq_regs =3D (struct cdns_otg_irq_regs __iomem *)
>          |                       ^
>    cc1: some warnings being treated as errors
>=20
> vim +/__raw_readl +421 drivers/usb/cdns3/drd.c
>=20
>    383=09
>    384	int cdns_drd_init(struct cdns *cdns)
>    385	{
>    386		void __iomem *regs;
>    387		u32 state;
>    388		int ret;
>    389=09
>    390		regs =3D devm_ioremap_resource(cdns->dev, &cdns->otg_res);
>    391		if (IS_ERR(regs))
>    392			return PTR_ERR(regs);
>    393=09
>    394		/* Detection of DRD version. Controller has been released
>    395		 * in three versions. All are very similar and are software compa=
tible,
>    396		 * but they have same changes in register maps.
>    397		 * The first register in oldest version is command register and i=
t's
>    398		 * read only. Driver should read 0 from it. On the other hand, in=
 v1
>    399		 * and v2 the first register contains device ID number which is n=
ot
>    400		 * set to 0. Driver uses this fact to detect the proper version o=
f
>    401		 * controller.
>    402		 */
>    403		cdns->otg_v0_regs =3D regs;
>    404		if (!readl(&cdns->otg_v0_regs->cmd)) {
>    405			cdns->version  =3D CDNS3_CONTROLLER_V0;
>    406			cdns->otg_v1_regs =3D NULL;
>    407			cdns->otg_cdnsp_regs =3D NULL;
>    408			cdns->otg_regs =3D regs;
>    409			cdns->otg_irq_regs =3D (struct cdns_otg_irq_regs __iomem  *)
>    410					     &cdns->otg_v0_regs->ien;
>    411			writel(1, &cdns->otg_v0_regs->simulate);
>    412			dev_dbg(cdns->dev, "DRD version v0 (%08x)\n",
>    413				 readl(&cdns->otg_v0_regs->version));
>    414		} else {
>    415			cdns->otg_v0_regs =3D NULL;
>    416			cdns->otg_v1_regs =3D regs;
>    417			cdns->otg_cdnsp_regs =3D regs;
>    418=09
>    419			cdns->otg_regs =3D (void __iomem *)&cdns->otg_v1_regs->cmd;
>    420=09
>  > 421			if (readl(cdns->otg_cdnsp_regs->did) =3D=3D OTG_CDNSP_DID) {
>    422				cdns->otg_irq_regs =3D (struct cdns_otg_irq_regs __iomem *)
>    423						      &cdns->otg_cdnsp_regs->ien;
>    424				cdns->version  =3D CDNSP_CONTROLLER_V2;
>    425			} else {
>    426				cdns->otg_irq_regs =3D (struct cdns_otg_irq_regs __iomem *)
>    427						      &cdns->otg_v1_regs->ien;
>    428				writel(1, &cdns->otg_v1_regs->simulate);
>    429				cdns->version  =3D CDNS3_CONTROLLER_V1;
>    430			}
>    431=09
>    432			dev_dbg(cdns->dev, "DRD version v1 (ID: %08x, rev: %08x)\n",
>    433				 readl(&cdns->otg_v1_regs->did),
>    434				 readl(&cdns->otg_v1_regs->rid));
>    435		}
>    436=09
>    437		state =3D OTGSTS_STRAP(readl(&cdns->otg_regs->sts));
>    438=09
>    439		/* Update dr_mode according to STRAP configuration. */
>    440		cdns->dr_mode =3D USB_DR_MODE_OTG;
>    441=09
>    442		if ((cdns->version =3D=3D CDNSP_CONTROLLER_V2 &&
>    443		     state =3D=3D OTGSTS_CDNSP_STRAP_HOST) ||
>    444		    (cdns->version !=3D CDNSP_CONTROLLER_V2 &&
>    445		     state =3D=3D OTGSTS_STRAP_HOST)) {
>    446			dev_dbg(cdns->dev, "Controller strapped to HOST\n");
>    447			cdns->dr_mode =3D USB_DR_MODE_HOST;
>    448		} else if ((cdns->version =3D=3D CDNSP_CONTROLLER_V2 &&
>    449			    state =3D=3D OTGSTS_CDNSP_STRAP_GADGET) ||
>    450			   (cdns->version !=3D CDNSP_CONTROLLER_V2 &&
>    451			    state =3D=3D OTGSTS_STRAP_GADGET)) {
>    452			dev_dbg(cdns->dev, "Controller strapped to PERIPHERAL\n");
>    453			cdns->dr_mode =3D USB_DR_MODE_PERIPHERAL;
>    454		}
>    455=09
>    456		ret =3D devm_request_threaded_irq(cdns->dev, cdns->otg_irq,
>    457						cdns_drd_irq,
>    458						cdns_drd_thread_irq,
>    459						IRQF_SHARED,
>    460						dev_name(cdns->dev), cdns);
>    461		if (ret) {
>    462			dev_err(cdns->dev, "couldn't get otg_irq\n");
>    463			return ret;
>    464		}
>    465=09
>    466		state =3D readl(&cdns->otg_regs->sts);
>    467		if (OTGSTS_OTG_NRDY(state)) {
>    468			dev_err(cdns->dev, "Cadence USB3 OTG device not ready\n");
>    469			return -ENODEV;
>    470		}
>    471=09
>    472		return 0;
>    473	}
>    474=09
>=20
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
.01.org%2Fhyperkitty%2Flist%2Fkbuild-all%40lists.01.org&amp;data=3D04%7C01%=
7Cpeter.chen%40nxp.com%7C6ce79474794448ae12b008d8a045f9ce%7C686ea1d3bc2b4c6=
fa92cd99c5c301635%7C0%7C0%7C637435572341553421%7CUnknown%7CTWFpbGZsb3d8eyJW=
IjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;s=
data=3Dv9fQGKZKobtIysXu43lCekV%2FoXCc2EZZXIxoTtQpSdw%3D&amp;reserved=3D0



--=20

Thanks,
Peter Chen=
