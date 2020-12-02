Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C60972CC2B1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 17:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728586AbgLBQrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 11:47:32 -0500
Received: from mga01.intel.com ([192.55.52.88]:64533 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726525AbgLBQrc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 11:47:32 -0500
IronPort-SDR: TVXfLiyWqDtRJw0V5353Jw3LlCwLgUoK94O0agcgqA26z3UuLRGAAXWGLRrmAp1xclRMvMoWGt
 WuQ7T6otvJuA==
X-IronPort-AV: E=McAfee;i="6000,8403,9823"; a="191265740"
X-IronPort-AV: E=Sophos;i="5.78,387,1599548400"; 
   d="scan'208";a="191265740"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 08:46:51 -0800
IronPort-SDR: ITmUTCZhK+qEsizipt/YmVg39JA81MnlhCvAQsaV7WF81ZLPDoagRe0nf+9C6aFNBDCW/4QCc2
 eDh6xtL8N9qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,387,1599548400"; 
   d="scan'208";a="550127523"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga005.jf.intel.com with ESMTP; 02 Dec 2020 08:46:49 -0800
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 2 Dec 2020 08:46:45 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 2 Dec 2020 08:46:43 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 2 Dec 2020 08:46:43 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 2 Dec 2020 08:46:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k60bWMGrS/SR+VzR/1zhBrYSQGR3AvHUk9VvuLWLQgBKKZ8e5PLX/bUuIVwSWZQZtpJLiJDwuSUWSiknEzfBlX+U+KgfJNQfxJ6/WZLBmnQNLUMBtl+Re+cVER56yytAYxU1FtObgvOL9hMvOIyJ2hT7rMXGv3dWIjLJVtOMKxe3C1zlzOEvEjYrzNbvTELtvpHLVDJEYtZF1/8UdGlfl4eYUni/qKbkjwwcfgqZnwjnFBbNwwJUZQr3rpUVEeaXGoS0XoGvUWcAi308HfYxf0DZBwrbmwCl0T4jIPWlygMJSVvTJwiEoCGiDcVAT/iblq35iboQ5qgCiOmmji92Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jCvEGkY2RkYj+RZUrT6kNhECmfYsjilS9mrppyGpvfM=;
 b=jFfGyuFFMsmspejzEz5L3/v2RJhXBFZTX8cuf9vrpCR+ydt3eaoGr+jFnsLwwYfK+B7smSKIb9zlOjMEX2fAUq8KatU7bFOmSd4TPBKye/DVjF0R++uD4Nk0CU1as2vMaTSWcnBvXJnOQ2E9pc8Om2Q0Woaa1dDjSZ3wSe658J79Yrb9nnGkDWsg46V10xUTq9nVULMspkC05XFIkqvPKoS4pGpciG7J4hvIKJ/9MScyPqjLE4dIfeGLQ7FhvdAxJIanlhWrDyjA+sQMlvINBAttVFAbUaNq0PSytbXFBrkgAEFPCSntUo2NxrfwI6zJxA5iVBzcP483BFDAmB8Bzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jCvEGkY2RkYj+RZUrT6kNhECmfYsjilS9mrppyGpvfM=;
 b=NTu3Xgtk0Mk0/wvqevmqmBbGFl3DkEN6bFRfVSTg01JCpRNEyUehOqA2wtOFT+qZebJegx7KmqjyZMNWhE+BjC0tqbDp0MfAlzdlSB/dNwdJZPT7vVOtfZ3bJ24h/fN5EjpAT6nm/93NvUbrnffBWrK7Hko9jwBK03dJc17jiec=
Received: from CY4PR11MB1781.namprd11.prod.outlook.com (2603:10b6:903:124::13)
 by CY4PR1101MB2198.namprd11.prod.outlook.com (2603:10b6:910:1d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Wed, 2 Dec
 2020 16:46:41 +0000
Received: from CY4PR11MB1781.namprd11.prod.outlook.com
 ([fe80::8135:848d:4e4:8f26]) by CY4PR11MB1781.namprd11.prod.outlook.com
 ([fe80::8135:848d:4e4:8f26%4]) with mapi id 15.20.3611.031; Wed, 2 Dec 2020
 16:46:41 +0000
From:   "Thokala, Srikanth" <srikanth.thokala@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>
CC:     "markgross@kernel.org" <markgross@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>, "bp@suse.de" <bp@suse.de>,
        "damien.lemoal@wdc.com" <damien.lemoal@wdc.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "leonard.crestez@nxp.com" <leonard.crestez@nxp.com>,
        "palmerdabbelt@google.com" <palmerdabbelt@google.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "peng.fan@nxp.com" <peng.fan@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 09/22] misc: xlink-pcie: lh: Add core communication logic
Thread-Topic: [PATCH 09/22] misc: xlink-pcie: lh: Add core communication logic
Thread-Index: AQHWyDJT4s0PQTkyOUypKya3kV+KRKnjVXAAgACtfKA=
Date:   Wed, 2 Dec 2020 16:46:41 +0000
Message-ID: <CY4PR11MB1781C8BAD8C2B4641EC445F985F30@CY4PR11MB1781.namprd11.prod.outlook.com>
References: <20201201223511.65542-1-mgross@linux.intel.com>
 <20201201223511.65542-10-mgross@linux.intel.com> <X8cxpqf7MMCNacqm@kroah.com>
In-Reply-To: <X8cxpqf7MMCNacqm@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=intel.com;
x-originating-ip: [171.76.107.214]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 538ff2b8-b6f3-4913-15d0-08d896e1d89d
x-ms-traffictypediagnostic: CY4PR1101MB2198:
x-microsoft-antispam-prvs: <CY4PR1101MB21985A149EE045CC56A1476085F30@CY4PR1101MB2198.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vXDvU5Hw6w0lld1ucMsCOHBkVBkL5uUhGl8KD8RTojviyTGw4F39diP1Ew6JZMIaqCqNKI+n74UggbgKkiU+vWL1m3l4MIWv7FCPATS+cnmgnJ+HOJNi0GyYhz/Jt//KlxJwcTU2b/ETD4ACN2Fnli3WAGBYIRHn5r609v7xwqHuzGRnDq+uJeOWot2yU3UWGzRY+w9R9hUs/h2dm1Yde2wjioqmSgLOTmDzVyjDtsso+JfDwMlCbb8FlcFri9Hv3kZPt3cAaWWw45Uv4soxX4Nt7VRsgiawCJowGOcx+cx4D9sXjjBCpTfB8qGwa/XLIKNaFvdMwu1/riLuxnpm5A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1781.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(136003)(366004)(346002)(8676002)(76116006)(66446008)(9686003)(7416002)(55016002)(53546011)(33656002)(2906002)(6506007)(66946007)(64756008)(186003)(316002)(66476007)(5660300002)(4326008)(26005)(478600001)(66556008)(71200400001)(7696005)(86362001)(8936002)(54906003)(52536014)(110136005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?LObIc1qT0m086SFwwiSUFAaAR3elO37XyxHkfdLaO0m5Y9PLwqt1pImaxI9I?=
 =?us-ascii?Q?w44PRtBrMxESMuFumQZzd9OKKETEbmtGjyp8YHyZ/cm8q8SVYtuq1iNAzRQU?=
 =?us-ascii?Q?OOISc1iOGB01PJDKgBTpdQWimkD7WUtpRyEAS4m2eY+0GY8ITAmCjHKbsirD?=
 =?us-ascii?Q?9tf5rbP9bSkNS+3v5Z9yoDLEsN2zXCvSmynLotWeCdS4HlzGMkfIdcnHKRm0?=
 =?us-ascii?Q?D4SsJG6dmwWlfg6agiAgr/LVwg1t49GBSIFRJ+e7gWC4gmOxv7iDvEedIPnr?=
 =?us-ascii?Q?I5do5UBaEdf4V9zpXOKN04r4xouPq7kUmmyU342kbDtbYinIif4ND7YxBWi4?=
 =?us-ascii?Q?+y4gSuF/81knB0zlGHsHSTncFGOXHWTtUUFK6G8UuWSD0I+eJdaA0NpHnScz?=
 =?us-ascii?Q?pPwZQggVtS6Q6LUQL9H4QyoCQR4QTLrI6Up8FE3y6i5YKTzP+nlMCjcT6dyb?=
 =?us-ascii?Q?h2d4bYa9RGTWwpNf0QtyRTRwizxaUicv3C96wdCj0A2diGJn3cTNOx0CnS07?=
 =?us-ascii?Q?ktYBSIOSPM5iiwwRvzDp1steuTHzAUoT57DPZaaQIa1aHcFK+QWHOcXdaKPG?=
 =?us-ascii?Q?G9BYxoled8dTx/ipc0AglAk9K++1tFZ5/RerwNrhCbqnh4KUnf9ed7CMi5Mt?=
 =?us-ascii?Q?/oA4cAdkpYWVwAn4e7ynqZwRZtGzSuSxruimMHDtLJhO+UzHIF9IAAilPFeG?=
 =?us-ascii?Q?uDX+eTKMENjJ+DKSpn7UEGarqekl8ArBZKQLWO4NKaNAvD0UvGeiYndf4oVK?=
 =?us-ascii?Q?JxxORAC0zVJBVSnS+QUKHbAe67uQAD74CF3JmqYSoCt17fd2gI7tHYZ9DqzU?=
 =?us-ascii?Q?iRe0U/yAc36u9NpPj9GNBZRTdXuihP+Xeo4RKJbTDcaPdYNVWTxprXEX/cZJ?=
 =?us-ascii?Q?/Aff0rjJB10bEZ6c1a8HwaDlAwX+Jvw9h6jcqiBiDZFfqF0n6CFpqUh8ou1g?=
 =?us-ascii?Q?NnhIcf8u4CYntZycDyMmj+GZnf5SIyWBZHeauRK2/ck=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1781.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 538ff2b8-b6f3-4913-15d0-08d896e1d89d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2020 16:46:41.7817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o5i0GsDHLvVJhvZOy03QWm0cLwnKjK6ivGKKJjuOPo/I/kN5ahhbNcCIVjxQTR1KaHq25d9sYdzXmMGiyW4dvnO41PtVVcL4m5jM4qXFtOY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2198
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Wednesday, December 2, 2020 11:48 AM
> To: mgross@linux.intel.com
> Cc: markgross@kernel.org; arnd@arndb.de; bp@suse.de;
> damien.lemoal@wdc.com; dragan.cvetic@xilinx.com; corbet@lwn.net;
> leonard.crestez@nxp.com; palmerdabbelt@google.com;
> paul.walmsley@sifive.com; peng.fan@nxp.com; robh+dt@kernel.org;
> shawnguo@kernel.org; linux-kernel@vger.kernel.org; Thokala, Srikanth
> <srikanth.thokala@intel.com>
> Subject: Re: [PATCH 09/22] misc: xlink-pcie: lh: Add core communication
> logic
>=20
> On Tue, Dec 01, 2020 at 02:34:58PM -0800, mgross@linux.intel.com wrote:
> > From: Srikanth Thokala <srikanth.thokala@intel.com>
> >
> > Add logic to establish communication with the remote host which is
> through
> > ring buffer management and MSI/Doorbell interrupts
> >
> > Reviewed-by: Mark Gross <mgross@linux.intel.com>
> > Signed-off-by: Srikanth Thokala <srikanth.thokala@intel.com>
> > ---
> >  drivers/misc/xlink-pcie/local_host/Makefile |   2 +
> >  drivers/misc/xlink-pcie/local_host/core.c   | 894 ++++++++++++++++++++
> >  drivers/misc/xlink-pcie/local_host/core.h   | 247 ++++++
> >  drivers/misc/xlink-pcie/local_host/epf.c    | 116 ++-
> >  drivers/misc/xlink-pcie/local_host/epf.h    |  26 +
> >  drivers/misc/xlink-pcie/local_host/util.c   | 375 ++++++++
> >  drivers/misc/xlink-pcie/local_host/util.h   |  70 ++
> >  drivers/misc/xlink-pcie/local_host/xpcie.h  |  65 ++
> >  include/linux/xlink_drv_inf.h               |  60 ++
> >  9 files changed, 1847 insertions(+), 8 deletions(-)
> >  create mode 100644 drivers/misc/xlink-pcie/local_host/core.c
> >  create mode 100644 drivers/misc/xlink-pcie/local_host/core.h
> >  create mode 100644 drivers/misc/xlink-pcie/local_host/util.c
> >  create mode 100644 drivers/misc/xlink-pcie/local_host/util.h
> >  create mode 100644 include/linux/xlink_drv_inf.h
> >
> > diff --git a/drivers/misc/xlink-pcie/local_host/Makefile
> b/drivers/misc/xlink-pcie/local_host/Makefile
> > index 54fc118e2dd1..28761751d43b 100644
> > --- a/drivers/misc/xlink-pcie/local_host/Makefile
> > +++ b/drivers/misc/xlink-pcie/local_host/Makefile
> > @@ -1,3 +1,5 @@
> >  obj-$(CONFIG_XLINK_PCIE_LH_DRIVER) +=3D mxlk_ep.o
> >  mxlk_ep-objs :=3D epf.o
> >  mxlk_ep-objs +=3D dma.o
> > +mxlk_ep-objs +=3D core.o
> > +mxlk_ep-objs +=3D util.o
> > diff --git a/drivers/misc/xlink-pcie/local_host/core.c
> b/drivers/misc/xlink-pcie/local_host/core.c
> > new file mode 100644
> > index 000000000000..aecaaa783153
> > --- /dev/null
> > +++ b/drivers/misc/xlink-pcie/local_host/core.c
> > @@ -0,0 +1,894 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> >
> +/***********************************************************************=
*
> *****
> > + *
> > + * Intel Keem Bay XLink PCIe Driver
> > + *
> > + * Copyright (C) 2020 Intel Corporation
> > + *
> > +
> *************************************************************************=
*
> **/
> > +
> > +#include <linux/of_reserved_mem.h>
> > +
> > +#include "epf.h"
> > +#include "core.h"
> > +#include "util.h"
> > +
> > +static struct xpcie *global_xpcie;
> > +
> > +static int rx_pool_size =3D SZ_32M;
> > +module_param(rx_pool_size, int, 0664);
> > +MODULE_PARM_DESC(rx_pool_size, "receiving pool size (default 32 MiB)")=
;
> > +
> > +static int tx_pool_size =3D SZ_32M;
> > +module_param(tx_pool_size, int, 0664);
> > +MODULE_PARM_DESC(tx_pool_size, "transmitting pool size (default 32
> MiB)");
> > +
> > +static int fragment_size =3D XPCIE_FRAGMENT_SIZE;
> > +module_param(fragment_size, int, 0664);
> > +MODULE_PARM_DESC(fragment_size, "transfer descriptor size (default 128
> KiB)");
> > +
> > +static bool tx_pool_coherent =3D true;
> > +module_param(tx_pool_coherent, bool, 0664);
> > +MODULE_PARM_DESC(tx_pool_coherent,
> > +		 "transmitting pool using coherent memory (default true)");
> > +
> > +static bool rx_pool_coherent;
> > +module_param(rx_pool_coherent, bool, 0664);
> > +MODULE_PARM_DESC(rx_pool_coherent,
> > +		 "receiving pool using coherent memory (default false)");
>=20
> This isn't the 1990's anymore.  Please make these dynamic such that they
> are never needed (the code figures out the best values), or on some
> per-device basis using configfs or sysfs.

Sure, I will fix it in my v2.

thanks!
Srikanth
=20
> thanks,
>=20
> greg k-h
