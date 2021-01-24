Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4488B301B7C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 12:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbhAXLq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 06:46:59 -0500
Received: from mga17.intel.com ([192.55.52.151]:56307 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbhAXLqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 06:46:48 -0500
IronPort-SDR: bjdvG2bK1MUiV3DtZ/Y45Kux5zipdPk81K9X8NXcGeUGs0oE6/RUVQTCWBKZFzyu1nYV7BcM0C
 Ica3Wl4GhMGA==
X-IronPort-AV: E=McAfee;i="6000,8403,9873"; a="159386927"
X-IronPort-AV: E=Sophos;i="5.79,371,1602572400"; 
   d="scan'208";a="159386927"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2021 03:46:03 -0800
IronPort-SDR: zNf2a4YQep0tNo6WyOhH/DHEEysgCO0DIfpvFp+VU5h9maVpklavINNlynlIzmXVzI1R+AoH8K
 6g6OxY6+bq6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,371,1602572400"; 
   d="scan'208";a="352574315"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP; 24 Jan 2021 03:46:02 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 24 Jan 2021 03:46:02 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 24 Jan 2021 03:46:01 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 24 Jan 2021 03:46:01 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Sun, 24 Jan 2021 03:46:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GX9f8U/bBGP/y6V2kqvl+bKeU91k/Z1jhE3z3KDJQdqzDj2a8VdGq4mV2cS2sr8FfxGwzK+SQXYhZfYKHpUjvSMBsX8MfoCkBCys6+5TTgSmvdCgkCH0grzBLaCGEzdVZ5GdUTTC3kAUa62i5hejImTvg6SL7Fn4oSVHVJlXsQGmFfk7gQvnsXt8GxNcPfXCGcy4/aDHhjcGxT2/GqNfWu2q+4SGjTEpHSSNHH2TpOFR6b5lZU8MLlA+vHpXW90N3G+IVZRVohvPwpj6DnCyINk+S6DIHHJc20mXnvFWjMsAmU33zOvtfs7XcMxikGKn2FQy47uHjBiNh7xjBpd1+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3XvcEsuqcxiQ4ZRjdRfkopiZfXxawerTAHqG24Z8MQ=;
 b=Zcy6oN6C/SxRPUCqFXsVRDGGK7Tz3L+Ffy+vVMqQdGQjTkMHkKbAwepRr0gX2fSR/RkZ3x0Lp7sIyZpa4oxwoesgWV9263MOyfpKiUAVqt0T4DuD0Bl9xoG6COAGfM3iMNrhEWzF86Id+yeH5LThtZi22ZhIZjQjHDQTm2TVyAGOKVaHbfIxj3nvYPsJRbL9W/dyT6mP0FHed5MpjxLZDPFCFRosCXqJjZkhnbVmkB4vYS/RO2rYUBUeE2/jrM/tvMsysCXIRPy2UcH4kZPWEEQ9V0tZkvyGpv8mHN1ru5ks1o3LWpoOj8e/QIrtKxlvSyphPnmz9gmLu6FcXAj28A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3XvcEsuqcxiQ4ZRjdRfkopiZfXxawerTAHqG24Z8MQ=;
 b=wL0t4dJKJLUTQQLaih7Rh4Y16AR+BMVt3XbvMcuvgDVgwjn+4NPzj7wbPKFnyk+Y1U5nWagwhXt+9DgHx8lKVsItJV46Agyh0pGRBzndUHdP4Te+kYZM6zhcnChJ0zKacYb5ntV/lyUrukFPAxniyoBxnmtlL58pdikHiVzXF44=
Received: from MWHPR11MB1406.namprd11.prod.outlook.com (2603:10b6:300:23::18)
 by MWHPR11MB2015.namprd11.prod.outlook.com (2603:10b6:300:28::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15; Sun, 24 Jan
 2021 11:46:00 +0000
Received: from MWHPR11MB1406.namprd11.prod.outlook.com
 ([fe80::89f0:cbc3:d9c2:6e7a]) by MWHPR11MB1406.namprd11.prod.outlook.com
 ([fe80::89f0:cbc3:d9c2:6e7a%7]) with mapi id 15.20.3784.017; Sun, 24 Jan 2021
 11:46:00 +0000
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
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 15/34] misc: xlink-pcie: Add XLink API interface
Thread-Topic: [PATCH v2 15/34] misc: xlink-pcie: Add XLink API interface
Thread-Index: AQHW5gTjSe4Zc5a7MkqoDqTwD9t4iKow3/mAgAIyadA=
Date:   Sun, 24 Jan 2021 11:46:00 +0000
Message-ID: <MWHPR11MB14061C5E2AFBE3D93ABBDADC85BE9@MWHPR11MB1406.namprd11.prod.outlook.com>
References: <20210108212600.36850-1-mgross@linux.intel.com>
 <20210108212600.36850-16-mgross@linux.intel.com> <YAhvhSpOv2Z4cwlB@kroah.com>
In-Reply-To: <YAhvhSpOv2Z4cwlB@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=intel.com;
x-originating-ip: [122.167.96.157]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a350781-44c1-4322-5a32-08d8c05d9ed6
x-ms-traffictypediagnostic: MWHPR11MB2015:
x-microsoft-antispam-prvs: <MWHPR11MB2015AED7E1C1D128DF54F7A785BE9@MWHPR11MB2015.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: REBSMafxPBb9Q/3aB+jcCbeh3Qf/NqUlD7eALn0Tt7GQ9nsAmfiiqzVPyQgbyImgELchSLHQ89magsAVGf5U2jEBstb6du4ELVDD2X65+Z4TMz+HmnPEJY32Cl9EnaO4r++NXLK+1NgewMYmFooFD7r3F50iga9R1Z3JnRD5ehm7Rz67sTY6XpTECI/yOz/q84Xam0m5TobwNPMRLqYWPzrCeluFBfzCXS17+sBGm6g/kirmn6DVWwE69tT5P6s3QsGgoWnzbMbk0ofTp6PsAp72T4fSAGIOicHwJIMWNPibi8ZszfU11MpIcKZWz0k9uAVNe1Xh5xDzIy5lqxkyQSPhDOqHdSu+tBPm1amE2mVx4CEWTzr9tJe8rr91lE5h6t7dvb8KhV7kNMWL3vCqzw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1406.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(346002)(366004)(376002)(2906002)(4326008)(86362001)(9686003)(55016002)(71200400001)(83380400001)(5660300002)(8936002)(8676002)(52536014)(316002)(66556008)(66946007)(53546011)(6506007)(76116006)(110136005)(33656002)(54906003)(478600001)(7696005)(26005)(64756008)(7416002)(66446008)(66476007)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Eme39UyMOt35CI7oJnzDlxFovkOErfy+Ep0rrsahv04gg5ugeAg7FhfgflP1?=
 =?us-ascii?Q?Ww/umjK/JpRqInwQJBADVE9Nz8d2D5kgF+C5jQ7WCJkB67rZtL+UlG+3XBFt?=
 =?us-ascii?Q?RK1QNQZiAwiInyFIPw+0FEpEC1jYhFhLIIpww64oXUINgUiv+crrWjROu1KV?=
 =?us-ascii?Q?/QexIiLeRtQdY6X+119ZTJ7o/c8PRbWEOZt63KRE+0Z6hQRTvSWAIcPOZCWr?=
 =?us-ascii?Q?IMG8PaSu0hiWUqG2DwOkIdshtGSmKWScP/gN9XVdbOdPopZ/PO3Rb6T9X916?=
 =?us-ascii?Q?vcYO8Tt3DQ6vnbck6jyNguDrGH/c+UcKrHcHzXQQVSPHc7W27vxTS+vFkAyk?=
 =?us-ascii?Q?KmZvppZejLqMcbfDWk04+Ret+Jzt3zU2YDRhtPKTO8jVjE7KATBdu7lNp7An?=
 =?us-ascii?Q?dKNwkpoQ1mJY6SVtoT9dDI+bAw59sZJRZVURU8HE5w0BgJFRsUvTGaftJzjn?=
 =?us-ascii?Q?OV+Pr8gL/fMBNs46o2SRF7LBS0Tif3MDOesfMnR+okrz2DAaOjKB/ERT/6L1?=
 =?us-ascii?Q?3ELmhIZ+htt9VxzvLnvODwDaZ0u7uYh9RV6rMWztgPVgzzz02bwZLg8Iggjk?=
 =?us-ascii?Q?JP5BScYuHmBuv2OW3GbiwTgRsp9bKyS+Ldyh7TkhO7IVMAdffbfJ1X7FXS4L?=
 =?us-ascii?Q?hOA3K4WaUMv+7bygruWfx2eKHKNpHTYW63R/c2caFylETJxf9S0K2cmb4C7B?=
 =?us-ascii?Q?L8zFoVkJY/CPjGMyFwzy/8kiIFlDCQNgy4V7xMrrwIR4gFfB4fSvZaZz9gbt?=
 =?us-ascii?Q?GL3xiidWxDpG/6LB6Wa9o7IZeE4QqjtWBUJ75CFgIqTM2v5DhGyjtmNDSlor?=
 =?us-ascii?Q?brqrJp7eXvHZChIWHxhIrpLxfuVOXpw9gH332UaRKGmCYWUFm9E4ekk9Dxtx?=
 =?us-ascii?Q?DHekqz1XZzN71KFdZkuQuzmr74BrU9CEq+nZnqMRCxrQ2bzJ7tIu8lJRpR+8?=
 =?us-ascii?Q?5AaRPXPOtskzNZ8KjPWL3qeGpS9IKRQS7O1fRmIf5Ok=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1406.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a350781-44c1-4322-5a32-08d8c05d9ed6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2021 11:46:00.0515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zUPNtJDjIdRNYd21zLCNzqtB1KprNXYiK5scCeC8BdDv69yHBMQAYEBlAHiKaOcYb0FmtZEdZov62bcNghfL00UI4uZKYKzgu216GxUcepo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB2015
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Thank you for the review.

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Wednesday, January 20, 2021 11:30 PM
> To: mgross@linux.intel.com
> Cc: markgross@kernel.org; arnd@arndb.de; bp@suse.de;
> damien.lemoal@wdc.com; dragan.cvetic@xilinx.com; corbet@lwn.net;
> leonard.crestez@nxp.com; palmerdabbelt@google.com;
> paul.walmsley@sifive.com; peng.fan@nxp.com; robh+dt@kernel.org;
> shawnguo@kernel.org; jassisinghbrar@gmail.com; linux-
> kernel@vger.kernel.org; Thokala, Srikanth <srikanth.thokala@intel.com>
> Subject: Re: [PATCH v2 15/34] misc: xlink-pcie: Add XLink API interface
>=20
> On Fri, Jan 08, 2021 at 01:25:41PM -0800, mgross@linux.intel.com wrote:
> > From: Srikanth Thokala <srikanth.thokala@intel.com>
> >
> > Provide interface for XLink layer to interact with XLink PCIe transport
> > layer on both local host and remote host.
> >
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Reviewed-by: Mark Gross <mgross@linux.intel.com>
> > Signed-off-by: Srikanth Thokala <srikanth.thokala@intel.com>
> > ---
> >  drivers/misc/xlink-pcie/common/interface.c   | 109 +++++++++++++++++++
> >  drivers/misc/xlink-pcie/local_host/Makefile  |   1 +
> >  drivers/misc/xlink-pcie/remote_host/Makefile |   1 +
> >  3 files changed, 111 insertions(+)
> >  create mode 100644 drivers/misc/xlink-pcie/common/interface.c
> >
> > diff --git a/drivers/misc/xlink-pcie/common/interface.c
> b/drivers/misc/xlink-pcie/common/interface.c
> > new file mode 100644
> > index 000000000000..56c1d9ed9d8f
> > --- /dev/null
> > +++ b/drivers/misc/xlink-pcie/common/interface.c
> > @@ -0,0 +1,109 @@
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
>=20
> Do you really need the ******* mess?  :)

It is not required; I will clean up.

>=20
> > +
> > +#include <linux/xlink_drv_inf.h>
> > +
> > +#include "core.h"
> > +#include "xpcie.h"
> > +
> > +/* Define xpcie driver interface API */
> > +int xlink_pcie_get_device_list(u32 *sw_device_id_list, u32
> *num_devices)
> > +{
> > +	if (!sw_device_id_list || !num_devices)
> > +		return -EINVAL;
> > +
> > +	*num_devices =3D intel_xpcie_get_device_num(sw_device_id_list);
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL(xlink_pcie_get_device_list);
>=20
> EXPORT_SYMBOL_GPL() for all of these perhaps?  I have to ask...

I agree with Mark, will make the change to use EXPORT_SYMBOL_GPL().

Thanks!
Srikanth

>=20
> thanks,
>=20
> greg k-h
