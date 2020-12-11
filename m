Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3E922D74C3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 12:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394926AbgLKLd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 06:33:56 -0500
Received: from mga06.intel.com ([134.134.136.31]:52740 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391060AbgLKLdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 06:33:49 -0500
IronPort-SDR: MI4V0kcGBonKH93xbf53zoSbesfDet9EXFVyleeSSKofQnS34Aa4LPZ3LEe2BEjMD8Z5/9lUC+
 Nme4D72B+/ww==
X-IronPort-AV: E=McAfee;i="6000,8403,9831"; a="236012440"
X-IronPort-AV: E=Sophos;i="5.78,411,1599548400"; 
   d="scan'208";a="236012440"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2020 03:33:06 -0800
IronPort-SDR: RMW2Ki7emK7l8an+qXvRupYs81QsytOeYL+kwKXoe+tyPTgdInZAjLEK/FfJGkLulkLN7+I4yr
 kxS+GKoUI/TA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,411,1599548400"; 
   d="scan'208";a="379659955"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Dec 2020 03:33:06 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 11 Dec 2020 03:33:06 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 11 Dec 2020 03:33:06 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Fri, 11 Dec 2020 03:33:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hy243l54/fOR6aLY7diBVIbEiDeuHNblYQmX8Yxk1UAzsJ7Qe+8O4mFuK2Li8f8xIRE4D73pPOeXKRjXtsWDopjFinyZ4vQsfQon1te1TgrhHDPidwixRN8XsLCSHFcUn6ayYGSZLZBqECbPvw4M5STPmqj4QtuVHnKKxDfkCD7RXdpmjW4N0PTzk/p8gik2pO/zNtHYIfiOwBAYI0kqli/7k+xapLl1y5iWcinjfbzmsh6G/OYiigsPhiLW6PdPIAPNsDQspffsjI8y364xCwunri4kWEcb8TK2+Kb0BUbl+GeT5E7x8Dqvh2dKONA5BHo9AqmRVpBrejc8way0ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r27SalNXtKVNRwiv/D/8S1Ghvfbz+NQZEPhIAoo728s=;
 b=Q0nM17Yq37sxBNrzb6mkuuW7jK1LUpidqu8x+oAo1VQTUNJJxj7A/VOri5xSQb7NKV+T1sEjjFvCsRZETk6gjRBcRVs3W8li+yhCi4QOnnFmYtLTMUb6W1Foq0Jh6VgBVBKnHAnMDuG1xDdK5foJtJ8lLCcSP2w41SA6H49ERW3/Ii/lCPP2Pjm4/un9j1wpvPhC0q3VcsR8cGwOVq+dO3IK8NgPjA4J3mJyyqoKzkQJ0bnxZoo6e9eZLKMnDDM11QjeaXRba7yesCNSsOGSBKuHTSr3wDfubEFkYOfzT4qKG3i04i0N3iLxexTPUFGYOliS4wX55eWxhoqXz9LMvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r27SalNXtKVNRwiv/D/8S1Ghvfbz+NQZEPhIAoo728s=;
 b=YbXPegtxZYGiHWGpL3FThm8Be+HDzTMrd9ESGfjAwBGSx/1U12d3secAkMKZOEoeiKrJdzyAL85Xn9YK6/v2robOo1Fw7aBKB6mvZDwgfBH5hRydJPuDNkrbNoqioe6cE+fZiAdQ8USrNNlwZJJAOyB8sYdOu3bpJ7N9hfheyEw=
Received: from BYAPR11MB3783.namprd11.prod.outlook.com (2603:10b6:a03:f5::12)
 by BYAPR11MB3045.namprd11.prod.outlook.com (2603:10b6:a03:88::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Fri, 11 Dec
 2020 11:33:02 +0000
Received: from BYAPR11MB3783.namprd11.prod.outlook.com
 ([fe80::2c85:a097:7a95:4387]) by BYAPR11MB3783.namprd11.prod.outlook.com
 ([fe80::2c85:a097:7a95:4387%5]) with mapi id 15.20.3654.015; Fri, 11 Dec 2020
 11:33:02 +0000
From:   "Kelly, Seamus" <seamus.kelly@intel.com>
To:     Joe Perches <joe@perches.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>, "bp@suse.de" <bp@suse.de>,
        "damien.lemoal@wdc.com" <damien.lemoal@wdc.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "leonard.crestez@nxp.com" <leonard.crestez@nxp.com>,
        "palmerdabbelt@google.com" <palmerdabbelt@google.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "peng.fan@nxp.com" <peng.fan@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Ryan Carnaghi <ryan.r.carnaghi@intel.com>
Subject: RE: [PATCH 16/22] xlink-ipc: Add xlink ipc driver
Thread-Topic: [PATCH 16/22] xlink-ipc: Add xlink ipc driver
Thread-Index: AQHWyDJBAHRzyzcAgEmZdZQ/FXOFKKnq8huAgAbgG5A=
Date:   Fri, 11 Dec 2020 11:33:02 +0000
Message-ID: <BYAPR11MB37839DDCA13DC55E594F5D108ACA0@BYAPR11MB3783.namprd11.prod.outlook.com>
References: <20201201223511.65542-1-mgross@linux.intel.com>
         <20201201223511.65542-17-mgross@linux.intel.com>
 <d33f6b90d50feb6c05bd45ffdedf3fb6d5ceb5ee.camel@perches.com>
In-Reply-To: <d33f6b90d50feb6c05bd45ffdedf3fb6d5ceb5ee.camel@perches.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: perches.com; dkim=none (message not signed)
 header.d=none;perches.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [89.125.2.213]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3fbabe34-74ef-4575-a4aa-08d89dc8853a
x-ms-traffictypediagnostic: BYAPR11MB3045:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB3045514CF2B5B11B401C28C58ACA0@BYAPR11MB3045.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q7VmRYyq+//a0itNTEx9+WxLwCYhwWGALb/ivZQkjBvJmTJoPlpEs4Z12lkn4dZQJ1vP28x4BciyzmZG5a/I+ISbjFBi5rGoLTrtMNgR+gotEdoeq/whIAkJWA7OfOrfJl1CmNIlFngd7EGYBxiiEJLPMWl7IVKVmF/9mElAEFiXIadR9V4j8jNb4wesF3w+icLoFEkurdb3osuZ/b+WI8UoM1thcSZ9nsSgPORwopz4vWGJdq4uCwRVcb8dYZCtHUMdkJ5+Y5w3FAdb9AoA7plWXSpx5jKqIC8OvPNjtsZ9Ptox6bLlOcUj6qncLtHva8uU7BlG03SYe3gkCMLuEl/4ryo2q7pAmKOEpoRO9IxAsYfnuJaO9EvclEAARBTx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3783.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(366004)(376002)(8936002)(6506007)(2906002)(9686003)(64756008)(66946007)(7696005)(71200400001)(54906003)(5660300002)(508600001)(76116006)(66556008)(86362001)(66446008)(52536014)(33656002)(186003)(53546011)(26005)(921005)(7416002)(4326008)(66476007)(110136005)(8676002)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?2cq256szXK5gF1L7G35gbFosFMzE1CbDQ/v3wLJpG9jZMCSjq4zOAboBrDYU?=
 =?us-ascii?Q?+T0H7B3nGiXElg1xUgRe/oIaW4OEH/2PgUDFZdHuVNiw5yjiA+7jmlXXmarP?=
 =?us-ascii?Q?MultdTq48hwtrXeeuzoxfvFPqAUWsZNgBuXRGIvzRBNozy9RFgpEDYK29Z0A?=
 =?us-ascii?Q?cP3NKMVSkOS6TIhnB0Fuay5eLo/JAifb/iogM6wH3fxHLmk6GLn4ERF7p7Fo?=
 =?us-ascii?Q?hBdgBJOVJtVER0dgmYKkJoyJ7XN4BaX7TQg9fAmLzMf7tOkyZ935LXbltbrq?=
 =?us-ascii?Q?SiinCXOFXmlJ9UK+6VQwsEsB6Kt5Y8WMsWjpgTu82eBOeYpseP/8Y53MRJ3K?=
 =?us-ascii?Q?crRgIt/ah5FYgtbUq8wyEu5ENkNAitjMuZMcJbkyHC4w5jsjDy7uaHvNiTej?=
 =?us-ascii?Q?JiH6Qeb6b+J7qJbdO8rMZs+BlWQajymjxXr28N2xPnBeXq5NcWRqeLIMz7sZ?=
 =?us-ascii?Q?Guk4u84Qb3olNaJOp7zGKwpZjJFnJqWs+TOy98BlbPg11jWfpHFBYZjKpaKg?=
 =?us-ascii?Q?I1myKqNhKwYgGVGXgIv2GMhGpGx4zL3IbuhsmlwH4hSe5MblWkcR+N/r/K48?=
 =?us-ascii?Q?VzuYTDXDwC5rY9PDtZxSFBaRGARyWRVbhrJ5Es44lXGQCQBdwo4GfFw5zDAq?=
 =?us-ascii?Q?/OUjbtxX53j+nqAfOS72wmJx06oaFB+ELSATe0et1v0iGUwiDcFS/kOxzhnE?=
 =?us-ascii?Q?kE+GczP+se4weBbiLOppFqqeGDPOrrQ8RFaAg7vAwRTPCjRJaFz9jnz2KX84?=
 =?us-ascii?Q?m20YpJByPOjy3XCml8nAlEFn/wjOK3mwkiKsIQS0Y+Lqozdtq+Cpaw92HiZ4?=
 =?us-ascii?Q?kPBPX5jtcCfwL0Yb1O36uGNFWpjvDlPUbQUjHSgNLyqTNMZ65JtreiaWb2nx?=
 =?us-ascii?Q?4VGV9CAaZe+Y2i0wFhkKA2Z6h5Z26prTQWbN+n78Ad/gYB5vqokYIBnyRW9u?=
 =?us-ascii?Q?8IgMIJChLwmIjUZThyTGMnSS+zWMZlqfCgxiNjqqzKs=3D?=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3783.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fbabe34-74ef-4575-a4aa-08d89dc8853a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2020 11:33:02.5199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jrcMit2HeEydqTv+beBI/PGt5zC5AyLKybrpdlShhId6mZfGFWYc3M9fwipIT5XrZXNleIP76yorhWRJsOaSmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3045
X-OriginatorOrg: intel.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Joe Perches <joe@perches.com> =

Sent: Monday, December 7, 2020 2:33 AM
To: mgross@linux.intel.com; markgross@kernel.org; arnd@arndb.de; bp@suse.de=
; damien.lemoal@wdc.com; dragan.cvetic@xilinx.com; gregkh@linuxfoundation.o=
rg; corbet@lwn.net; leonard.crestez@nxp.com; palmerdabbelt@google.com; paul=
.walmsley@sifive.com; peng.fan@nxp.com; robh+dt@kernel.org; shawnguo@kernel=
.org
Cc: linux-kernel@vger.kernel.org; Kelly, Seamus <seamus.kelly@intel.com>; l=
inux-doc@vger.kernel.org; Ryan Carnaghi <ryan.r.carnaghi@intel.com>
Subject: Re: [PATCH 16/22] xlink-ipc: Add xlink ipc driver

On Tue, 2020-12-01 at 14:35 -0800, mgross@linux.intel.com wrote:
> From: Seamus Kelly <seamus.kelly@intel.com>
> =

> Add xLink driver, which interfaces the xLink Core driver with the Keem =

> Bay VPU IPC driver, thus enabling xLink to control and communicate =

> with the VPU IP present on the Intel Keem Bay SoC.

Trivial style comments:

> diff --git a/drivers/misc/xlink-ipc/xlink-ipc.c =

> b/drivers/misc/xlink-ipc/xlink-ipc.c

[]

> +/*
> + * xlink_reserved_memory_init() - Initialize reserved memory for the dev=
ice.
> + *
> + * @xlink_dev:	[in] The xlink ipc device the reserved memory is allocate=
d to.
> + *
> + * Return: 0 on success, negative error code otherwise.
> + */
> +static int xlink_reserved_memory_init(struct xlink_ipc_dev =

> +*xlink_dev) {
> +	struct device *dev =3D &xlink_dev->pdev->dev;
> +
> +	xlink_dev->local_xlink_mem.dev =3D init_xlink_reserved_mem_dev(dev,
> +								     "xlink_local_reserved",
> +								     LOCAL_XLINK_IPC_BUFFER_IDX);
> +	if (!xlink_dev->local_xlink_mem.dev)
> +		return -ENOMEM;

This sort of code, with a repeated struct dereference, generally reads bett=
er using a temporary and is also less prone to typo use.

	struct device *dev =3D &xlink_dev->pdev->dev;
	struct xlink_buf_mem *lxm =3D &xlink_dev->local_xlink_mem;

	lxm->dev =3D init_xlink_reserved_mem_dev(dev, "xlink_local_reserved",
					       LOCAL_XLINK_IPC_BUFFER_IDX);
	if (!lxm->dev)
		return -ENOMEM;

> +	xlink_dev->local_xlink_mem.size =3D get_xlink_reserved_mem_size(dev,
> +								      LOCAL_XLINK_IPC_BUFFER_IDX);

	lxm->size =3D get_xlink_reserved_mem_size(dev, LOCAL_XLINK_IPC_BUFFER_IDX);

etc...

[Kelly, Seamus] Thank you!  will do.



--------------------------------------------------------------
Intel Research and Development Ireland Limited
Registered in Ireland
Registered Office: Collinstown Industrial Park, Leixlip, County Kildare
Registered Number: 308263


This e-mail and any attachments may contain confidential material for the s=
ole
use of the intended recipient(s). Any review or distribution by others is
strictly prohibited. If you are not the intended recipient, please contact =
the
sender and delete all copies.

