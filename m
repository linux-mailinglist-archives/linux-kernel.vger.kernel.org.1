Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 485392EFE59
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 08:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbhAIHuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 02:50:15 -0500
Received: from mga02.intel.com ([134.134.136.20]:12686 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725847AbhAIHuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 02:50:14 -0500
IronPort-SDR: oximk0aFsuqBGTzmGRfvWs1upjQs0JIk4hcZQw40vwWtpJnuxIOrj0itgzUrkOCE6pTgOlkueL
 27X0m9b0lY9g==
X-IronPort-AV: E=McAfee;i="6000,8403,9858"; a="164771548"
X-IronPort-AV: E=Sophos;i="5.79,333,1602572400"; 
   d="scan'208";a="164771548"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2021 23:49:32 -0800
IronPort-SDR: 8DrCS+0187iHJjF5so76OeC6yXuC1r+ArCBb9oGqPVJ6au8iUxG3+ODQbqf7p5NTnAtFYmmfTT
 slrn/aRvpONg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,333,1602572400"; 
   d="scan'208";a="380398980"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP; 08 Jan 2021 23:49:32 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 8 Jan 2021 23:49:31 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 8 Jan 2021 23:49:31 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Fri, 8 Jan 2021 23:49:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HbSzoyAMfvZCyrSu/HhQGMQWCzpnNwaOxxAo7sAzv0aIDToeJo1rWQUYRqzklBeWdQRd29dx3Dosh1m96goKqtvQDhJrq/uxh4wUVZQ/A9yRstUJDmN8V/bdW794NFftfPntBZJ+/tcvruojMtF0/MZTP+tB69sAk2iu/4kI+Y/tRA65Kf5NnTtJgOJqiiklfAfRGt42V4yffTeBHREnuo9hFUDK0RxbLMVKdSr48m4wC6RLca5mqBOv8qvvfen89y0/0FmuYUVMRoNCBG3Cwz8fWEUKtWzQJC7HdVvvafOb97V6+VduLW+SbuOmIp4bir30Ujou6UFLLMMzfNtaYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PqInLP6lPjBrsKWmaCZ6bkdgXSBKKkGOjK4JN8EGhFE=;
 b=CBTvjMRR11vWvotCfi4o4nLROdHGZSur9rfxqPwbxpiIYvzqBkiVVGw/HDF8UHAiE2gzadHW5gYuGRohW2M88FYl5QqneYA+7cE73qsjQZcgP/vI7o5hiSRoIpAupwVW+4GqoVrVtBJAdAQFMToAB5/VGQ8fY8aktL6ssPYx0bL+Pc/FoLPkeFQBzwy7nVrfgUkuN6Olz1Hr74VcJOdgCtfNsMFsXRKDbj6Ev+e8XjoIB6cC4h85RtI95aT7vO+sw2aZVV+eCqeagXRHZOSQciXYBaWBitAgwe2r48jursfzsbHbd9dop78FjlHMP1hFeKoPkb0+npq/7O8SavRYmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PqInLP6lPjBrsKWmaCZ6bkdgXSBKKkGOjK4JN8EGhFE=;
 b=BgKynvLL1KlP/f5QCZbCHaknU4p9dXt969F4UeNFs/LUuMtWk2PUlKwf3+Y3ojrN6ZYdFEh0QLsjGzx/kRCisC35T9V/Qlb5FmuGVcCXD/6IlSLR8pY7MhjbZ6+ccx4YUExTVA25qV6Ve6lNjp2QqgsfWnJp+PfR/FCaJCrx30c=
Received: from SA2PR11MB5018.namprd11.prod.outlook.com (2603:10b6:806:11a::20)
 by SN6PR11MB3182.namprd11.prod.outlook.com (2603:10b6:805:bf::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Sat, 9 Jan
 2021 07:49:24 +0000
Received: from SA2PR11MB5018.namprd11.prod.outlook.com
 ([fe80::95d4:6cec:fd81:5712]) by SA2PR11MB5018.namprd11.prod.outlook.com
 ([fe80::95d4:6cec:fd81:5712%6]) with mapi id 15.20.3742.008; Sat, 9 Jan 2021
 07:49:24 +0000
From:   "Chen, Mike Ximing" <mike.ximing.chen@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>
Subject: RE: [PATCH v8 04/20] dlb: add device ioctl layer and first three
 ioctls
Thread-Topic: [PATCH v8 04/20] dlb: add device ioctl layer and first three
 ioctls
Thread-Index: AQHW4w80G3nX6IgdcUmItLJqTgp06qoclpeAgAJCkzA=
Date:   Sat, 9 Jan 2021 07:49:24 +0000
Message-ID: <SA2PR11MB5018670AEC81EA93598E1212D9AD0@SA2PR11MB5018.namprd11.prod.outlook.com>
References: <20210105025839.23169-1-mike.ximing.chen@intel.com>
 <20210105025839.23169-5-mike.ximing.chen@intel.com>
 <X/dmB3q6QEd2aQdG@kroah.com>
In-Reply-To: <X/dmB3q6QEd2aQdG@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=intel.com;
x-originating-ip: [69.141.163.46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cacfad73-daaf-49c2-f976-08d8b4731534
x-ms-traffictypediagnostic: SN6PR11MB3182:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB31822AA731BA481378F70EA7D9AD0@SN6PR11MB3182.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n+wsXA5ruudshDwBG9q5MK7+TsD4Sp4l+V61B7VBqMBjF2m403CIdDzDyW4YwsSw+kgk7RMptCJNkLTMzCgw1tYQE6aItEwcWfWfM4Ux1SC8AmEMpgil46oNB5IXjkjXsFkkhrJ0VIUO3gJ8pqoRMx+Qj9TvZaW1Iu22fgrfUCqnFTjXMflMpKl4bLW2L+neyr8MMotJe0vqzTcbSpd1wVGQhMVj2QhF8gyPXW/qHD6MHg/x8bTlcjqiXdjbdyWd1OkaBwSqf7bgn0/N4Ss90pLSyYLz+zv8RwBLX561x3RtpaPzvdhXMVLLnESoHbwAkW+EpMBOxAIYyGn5h3cmntI5GlBfA2iooYtC9YTXdtc5qax0uPWhR0eHPRiqnnza4l81ymZmV7DYa+LAVcpp0g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5018.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(39860400002)(346002)(396003)(366004)(33656002)(186003)(6506007)(5660300002)(76116006)(66946007)(6916009)(8936002)(53546011)(54906003)(4326008)(83380400001)(26005)(66476007)(64756008)(66556008)(66446008)(30864003)(7696005)(55016002)(8676002)(86362001)(478600001)(2906002)(316002)(9686003)(71200400001)(52536014)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?rHoDPTWxqjIkHJZEHAY5Xv8wa3fvsVEH9m/nxW1E62IuMRsfvIZ1pA25hiZv?=
 =?us-ascii?Q?rUFvQ7oFnjL7AhE1EtfXk33GB8W7RrbTlrpJ+DTESMOYqFdSEYA3bsJgmMAJ?=
 =?us-ascii?Q?uKQ6AOWHnEp/WdS2dMlWNwybLLpVuGzsTDElE2tygnLW3MyThPou13PWPouX?=
 =?us-ascii?Q?l3od6rApqC0TF7v5rexAe2ffaLwD0NLqwZcoojC0IMdNWUW22IEyEkAFagLr?=
 =?us-ascii?Q?9SgIhJTXlJ/Ha0x4xylNumVcrbBG8BDlV18kgDHYlqM0taChui/DjPbKZLAJ?=
 =?us-ascii?Q?4DXJdo/qTSyL0zdsQ8O+/YUXsfFzxAJFIcDYsHJK7Odd2K9r6i3WGHaiPpcj?=
 =?us-ascii?Q?gSj4y2oWnkaUJiQIUMW535DF/jeLUA+yceegeo+i98QkyV8eb2etVdxsBhmb?=
 =?us-ascii?Q?PkWx29N8HqzQUejaVC8KFxlGI8i2gpHvTzKBxXK8r/moXR/QLGgSEa+38gWW?=
 =?us-ascii?Q?KW0p6d6CNe686tCMTteU7wda0XE4Otd6d0q29cvkPxZIZ46cpBZiISxqaM8t?=
 =?us-ascii?Q?wZOcv1OXeVUBQSbNL4tcMFoQ97BZUriuUCPEVlXftC+H02lB7tCB0dLIOChy?=
 =?us-ascii?Q?38jeKQsv5rzLAj/IwAPua+tkjJgLZ2Q6Xn+36m1p3TzlK+242J4tSMVW08r8?=
 =?us-ascii?Q?RR6zSPWouDOlFkD9KCGM1b65h9R5iG31MbDBQWIAX03yjXXNtRj1oQfJyIlP?=
 =?us-ascii?Q?4zmJW+UgP0OvgNg/riFp/7zxNQj3CdbVAq6EVWWgj+7zsaZZFP7a//qp5IcM?=
 =?us-ascii?Q?uZkxJm5clAe1Ro5ESyTFgUKC6qg4ZdWDOu2jBQDe/w3wWDwZyRNWuEIMkmMI?=
 =?us-ascii?Q?UE/TnoewJ/+/J1XN4imvxtb36YLz5IWRtDeyyFA/6Z68aT8xlgeP+gsPSxR5?=
 =?us-ascii?Q?wP/Ivas1qj4QykCLpfo0ALCLaX25hmCQCQo8srPH6rhKmcWGNJGWk6DDEzDf?=
 =?us-ascii?Q?5YbFw12Sfrb4VY14+jKwioMZl3qrvHuOibe5zwiZhaM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5018.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cacfad73-daaf-49c2-f976-08d8b4731534
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2021 07:49:24.1553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YNyP2P2uYDQCnOE8eyA000AlF4I7zv4mmyunIQnFcJgaivnudWkvFHdAWF/Fv6rKm8+Wz/vXpiWE4dxfUJCwUqe76AQf4VtWIaaW1nd2h7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3182
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Thursday, January 7, 2021 2:51 PM
> To: Chen, Mike Ximing <mike.ximing.chen@intel.com>
> Cc: linux-kernel@vger.kernel.org; arnd@arndb.de; Williams, Dan J
> <dan.j.williams@intel.com>; pierre-louis.bossart@linux.intel.com; Gage Ea=
ds
> <gage.eads@intel.com>
> Subject: Re: [PATCH v8 04/20] dlb: add device ioctl layer and first three=
 ioctls
>=20
> On Mon, Jan 04, 2021 at 08:58:23PM -0600, Mike Ximing Chen wrote:
> > Introduce the dlb device ioctl layer and the first three ioctls: query
> > device version, query available resources, and create a scheduling doma=
in.
> > Also introduce the user-space interface file dlb_user.h.
> >
> > The device version query is designed to allow each DLB device version/t=
ype
> > to have its own unique ioctl API through the /dev/dlb%d node. Each such=
 API
> > would share in common the device version command as its first command, =
and
> > all subsequent commands can be unique to the particular device.
> >
> > The hardware operation for scheduling domain creation will be added in =
a
> > subsequent commit.
> >
> > Signed-off-by: Gage Eads <gage.eads@intel.com>
> > Signed-off-by: Mike Ximing Chen <mike.ximing.chen@intel.com>
> > Reviewed-by: Magnus Karlsson <magnus.karlsson@intel.com>
> > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  .../userspace-api/ioctl/ioctl-number.rst      |   1 +
> >  drivers/misc/dlb/Makefile                     |   2 +-
> >  drivers/misc/dlb/dlb_bitmap.h                 |  32 ++++
> >  drivers/misc/dlb/dlb_ioctl.c                  | 119 +++++++++++++
> >  drivers/misc/dlb/dlb_ioctl.h                  |  11 ++
> >  drivers/misc/dlb/dlb_main.c                   |   3 +
> >  drivers/misc/dlb/dlb_main.h                   |   7 +
> >  drivers/misc/dlb/dlb_pf_ops.c                 |  21 +++
> >  drivers/misc/dlb/dlb_resource.c               |  63 +++++++
> >  drivers/misc/dlb/dlb_resource.h               |   5 +
> >  include/uapi/linux/dlb.h                      | 166 ++++++++++++++++++
> >  11 files changed, 429 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/misc/dlb/dlb_ioctl.c
> >  create mode 100644 drivers/misc/dlb/dlb_ioctl.h
> >  create mode 100644 include/uapi/linux/dlb.h
> >
> > diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst
> b/Documentation/userspace-api/ioctl/ioctl-number.rst
> > index 55a2d9b2ce33..afca043d59f8 100644
> > --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> > +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> > @@ -241,6 +241,7 @@ Code  Seq#    Include File
> Comments
> >  'h'   00-7F                                                          c=
onflict! Charon filesystem
> >                                                                       <=
mailto:zapman@interlan.net>
> >  'h'   00-1F  linux/hpet.h                                            c=
onflict!
> > +'h'   00-1F  uapi/linux/dlb.h                                        c=
onflict!
> >  'h'   80-8F  fs/hfsplus/ioctl.c
> >  'i'   00-3F  linux/i2o-dev.h                                         c=
onflict!
> >  'i'   0B-1F  linux/ipmi.h                                            c=
onflict!
> > diff --git a/drivers/misc/dlb/Makefile b/drivers/misc/dlb/Makefile
> > index 8a49ea5fd752..aaafb3086d8d 100644
> > --- a/drivers/misc/dlb/Makefile
> > +++ b/drivers/misc/dlb/Makefile
> > @@ -7,4 +7,4 @@
> >  obj-$(CONFIG_INTEL_DLB) :=3D dlb.o
> >
> >  dlb-objs :=3D dlb_main.o
> > -dlb-objs +=3D dlb_pf_ops.o dlb_resource.o
> > +dlb-objs +=3D dlb_pf_ops.o dlb_resource.o dlb_ioctl.o
> > diff --git a/drivers/misc/dlb/dlb_bitmap.h b/drivers/misc/dlb/dlb_bitma=
p.h
> > index fb3ef52a306d..3ea78b42c79f 100644
> > --- a/drivers/misc/dlb/dlb_bitmap.h
> > +++ b/drivers/misc/dlb/dlb_bitmap.h
> > @@ -73,4 +73,36 @@ static inline void dlb_bitmap_free(struct dlb_bitmap
> *bitmap)
> >  	kfree(bitmap);
> >  }
> >
> > +/**
> > + * dlb_bitmap_longest_set_range() - returns longest contiguous range o=
f set
> > + *				     bits
> > + * @bitmap: pointer to dlb_bitmap structure.
> > + *
> > + * Return:
> > + * Returns the bitmap's longest contiguous range of set bits upon succ=
ess,
> > + * <0 otherwise.
> > + *
> > + * Errors:
> > + * EINVAL - bitmap is NULL or is uninitialized.
> > + */
> > +static inline int dlb_bitmap_longest_set_range(struct dlb_bitmap *bitm=
ap)
> > +{
> > +	int max_len, len;
> > +	int start, end;
> > +
> > +	if (!bitmap || !bitmap->map)
> > +		return -EINVAL;
> > +
> > +	if (bitmap_weight(bitmap->map, bitmap->len) =3D=3D 0)
> > +		return 0;
> > +
> > +	max_len =3D 0;
> > +	bitmap_for_each_set_region(bitmap->map, start, end, 0, bitmap->len) {
> > +		len =3D end - start;
> > +		if (max_len < len)
> > +			max_len =3D len;
> > +	}
> > +	return max_len;
> > +}
> > +
> >  #endif /*  __DLB_OSDEP_BITMAP_H */
> > diff --git a/drivers/misc/dlb/dlb_ioctl.c b/drivers/misc/dlb/dlb_ioctl.=
c
> > new file mode 100644
> > index 000000000000..c072ed9b921c
> > --- /dev/null
> > +++ b/drivers/misc/dlb/dlb_ioctl.c
> > @@ -0,0 +1,119 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/* Copyright(C) 2016-2020 Intel Corporation. All rights reserved. */
> > +
> > +#include <linux/uaccess.h>
> > +#include <linux/nospec.h>
> > +
> > +#include <uapi/linux/dlb.h>
> > +
> > +#include "dlb_ioctl.h"
> > +#include "dlb_main.h"
> > +
> > +/* [7:0]: device revision, [15:8]: device version */
> > +#define DLB_SET_DEVICE_VERSION(ver, rev) (((ver) << 8) | (rev))
> > +
> > +static int
> > +dlb_ioctl_get_device_version(struct dlb *dlb __attribute__((unused)),
> > +			     void *karg)
> > +{
> > +	struct dlb_get_device_version_args *arg =3D karg;
> > +
> > +	arg->response.status =3D 0;
> > +	arg->response.id =3D DLB_SET_DEVICE_VERSION(2, DLB_REV_A0);
> > +
> > +	return 0;
> > +}
> > +
> > +static int dlb_ioctl_create_sched_domain(struct dlb *dlb,
> > +					 void *karg)
> > +{
> > +	struct dlb_create_sched_domain_args *arg =3D karg;
> > +	struct dlb_cmd_response *resp;
> > +	int ret;
> > +
> > +	mutex_lock(&dlb->resource_mutex);
> > +
> > +	BUILD_BUG_ON(offsetof(typeof(*arg), response) !=3D 0);
> > +	resp =3D &arg->response;
> > +
> > +	ret =3D dlb->ops->create_sched_domain(&dlb->hw, arg, resp);
> > +
> > +	mutex_unlock(&dlb->resource_mutex);
> > +
> > +	return ret;
> > +}
> > +
> > +static int dlb_ioctl_get_num_resources(struct dlb *dlb,
> > +				       void *karg)
> > +{
> > +	struct dlb_get_num_resources_args *arg =3D karg;
> > +	int ret;
> > +
> > +	mutex_lock(&dlb->resource_mutex);
> > +	ret =3D dlb->ops->get_num_resources(&dlb->hw, arg);
> > +	mutex_unlock(&dlb->resource_mutex);
> > +
> > +	return ret;
> > +}
> > +
> > +typedef int (*dlb_ioctl_fn_t)(struct dlb *dlb,
> > +			      void *karg);
> > +
> > +static dlb_ioctl_fn_t dlb_ioctl_fns[NUM_DLB_CMD] =3D {
> > +	dlb_ioctl_get_device_version,
> > +	dlb_ioctl_create_sched_domain,
> > +	dlb_ioctl_get_num_resources
>=20
> {sigh}
>=20
> No, do NOT do this.  Have real function calls, where the compiler can
> properly check the arguments and do the correct copying from memory and
> all that mess.  That way you don't have to try to keep this list in sync
> with:
>=20
> > +};
> > +
> > +static int dlb_ioctl_arg_size[NUM_DLB_CMD] =3D {
> > +	sizeof(struct dlb_get_device_version_args),
> > +	sizeof(struct dlb_create_sched_domain_args),
> > +	sizeof(struct dlb_get_num_resources_args)
>=20
> That list.
>=20
> Ugh, no.  that's no way to write maintainable code that you will be able
> to understand in 2 years.
>=20

dlb_ioctl() was implemented with switch-case and real function calls previo=
usly.=20
We changed to the table/list implementation during a code restructure. I wi=
ll move
back to the old implementation.=20

> > +};
> > +
> > +long
> > +dlb_ioctl(struct file *f,
> > +	  unsigned int cmd,
> > +	  unsigned long user_arg)
>=20
> Please stop wrapping lines where they are not needed.  Use the whole
> line whenever you can.  You do that a LOT in this patch series.
>=20
>=20
OK. Will check and correct line breaks in the patch set.

> > +{
> > +	struct dlb *dlb;
> > +	dlb_ioctl_fn_t fn;
> > +	u32 cmd_nr;
> > +	void *karg;
> > +	int size;
> > +	int ret;
> > +
> > +	dlb =3D f->private_data;
> > +
> > +	if (!dlb) {
> > +		pr_err("dlb: [%s()] Invalid DLB data\n", __func__);
> > +		return -EFAULT;
>=20
> This error value is only allowed if you really do have a memory fault.
>=20
> Hint, you do not here.
>=20
> How can that value ever be NULL?
>

It is targeted at some very rare cases, in which an ioctl command are calle=
d immediately after a device unbind (by a different process/application).
=20
> > +	}
> > +
> > +	if (_IOC_NR(cmd) >=3D NUM_DLB_CMD) {
> > +		dev_err(dlb->dev, "[%s()] Unexpected DLB command %d\n",
> > +			__func__, _IOC_NR(cmd));
> > +		return -EINVAL;
>=20
> Wrong error value.
>=20
> And now you have a simple way to cause a DoS on your kernel error log.
> Don't log foolish errors like this that a user can cause.
>=20
> > +	}
> > +
> > +	/* Block potential speculation on invalid command numbers.
> > +	 */
> > +	cmd_nr =3D array_index_nospec(_IOC_NR(cmd), NUM_DLB_CMD);
>=20
> Really?  Why?  If you do this correctly it is not an issue at all.
>=20
> > +
> > +	size =3D dlb_ioctl_arg_size[cmd_nr];
> > +	fn =3D dlb_ioctl_fns[cmd_nr];
> > +
> > +	karg =3D kzalloc(size, GFP_KERNEL);
> > +	if (!karg)
> > +		return -ENOMEM;
> > +
> > +	if (copy_from_user(karg, (void __user *)user_arg, size))
> > +		return -EFAULT;
> > +
> > +	ret =3D fn(dlb, karg);
> > +
> > +	if (copy_to_user((void __user *)user_arg, karg, size))
> > +		return -EFAULT;
>=20
> What happens if your ioctl command did not want anything copied back?
>=20
> That's why you don't do the crazy list of ioctl function pointers.  This
> is Linux, spell out the code obviously please.
>=20

OK. I see the various issues with the table/list implementation.  I will mo=
ve back to the switch-case and function call implementation.
Thanks

>=20
> > +
> > +	return ret;
> > +}
> > diff --git a/drivers/misc/dlb/dlb_ioctl.h b/drivers/misc/dlb/dlb_ioctl.=
h
> > new file mode 100644
> > index 000000000000..0737676f4208
> > --- /dev/null
> > +++ b/drivers/misc/dlb/dlb_ioctl.h
> > @@ -0,0 +1,11 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/* Copyright(C) 2016-2020 Intel Corporation. All rights reserved. */
> > +
> > +#ifndef __DLB_IOCTL_H
> > +#define __DLB_IOCTL_H
> > +
> > +#include "dlb_main.h"
> > +
> > +long dlb_ioctl(struct file *f, unsigned int cmd, unsigned long user_ar=
g);
>=20
> A .h file for a single function?  No.  It's a simple driver, you only
> need 1 .h file for it.
>=20

I will try to combine some .h files.

>=20
> > +
> > +#endif /* __DLB_IOCTL_H */
> > diff --git a/drivers/misc/dlb/dlb_main.c b/drivers/misc/dlb/dlb_main.c
> > index daa5eb75380f..787610bf6b20 100644
> > --- a/drivers/misc/dlb/dlb_main.c
> > +++ b/drivers/misc/dlb/dlb_main.c
> > @@ -10,6 +10,7 @@
> >  #include <linux/pci.h>
> >  #include <linux/uaccess.h>
> >
> > +#include "dlb_ioctl.h"
> >  #include "dlb_main.h"
> >  #include "dlb_resource.h"
> >
> > @@ -68,6 +69,8 @@ static int dlb_device_create(struct dlb *dlb, struct =
pci_dev
> *pdev)
> >
> >  static const struct file_operations dlb_fops =3D {
> >  	.owner   =3D THIS_MODULE,
> > +	.unlocked_ioctl =3D dlb_ioctl,
> > +	.compat_ioctl =3D compat_ptr_ioctl,
>=20
> Why do you need a compat ioctl for a brand new ioctl you are creating
> now?
>=20
>=20

It is not needed. Will remove it.

>=20
> >  };
> >
> >  /**********************************/
> > diff --git a/drivers/misc/dlb/dlb_main.h b/drivers/misc/dlb/dlb_main.h
> > index aaa806be66af..b3be39397fa2 100644
> > --- a/drivers/misc/dlb/dlb_main.h
> > +++ b/drivers/misc/dlb/dlb_main.h
> > @@ -12,6 +12,8 @@
> >  #include <linux/pci.h>
> >  #include <linux/types.h>
> >
> > +#include <uapi/linux/dlb.h>
> > +
> >  #include "dlb_hw_types.h"
> >
> >  /*
> > @@ -37,6 +39,11 @@ struct dlb_device_ops {
> >  	int (*init_driver_state)(struct dlb *dlb);
> >  	void (*enable_pm)(struct dlb *dlb);
> >  	int (*wait_for_device_ready)(struct dlb *dlb, struct pci_dev *pdev);
> > +	int (*create_sched_domain)(struct dlb_hw *hw,
> > +				   struct dlb_create_sched_domain_args *args,
> > +				   struct dlb_cmd_response *resp);
> > +	int (*get_num_resources)(struct dlb_hw *hw,
> > +				 struct dlb_get_num_resources_args *args);
> >  };
> >
> >  extern struct dlb_device_ops dlb_pf_ops;
> > diff --git a/drivers/misc/dlb/dlb_pf_ops.c b/drivers/misc/dlb/dlb_pf_op=
s.c
> > index a88f9519ac60..67d4300ca093 100644
> > --- a/drivers/misc/dlb/dlb_pf_ops.c
> > +++ b/drivers/misc/dlb/dlb_pf_ops.c
> > @@ -100,6 +100,25 @@ dlb_pf_wait_for_device_ready(struct dlb *dlb, stru=
ct
> pci_dev *pdev)
> >  	return 0;
> >  }
> >
> > +/*****************************/
> > +/****** IOCTL callbacks ******/
> > +/*****************************/
> > +
> > +static int
> > +dlb_pf_create_sched_domain(struct dlb_hw *hw,
> > +			   struct dlb_create_sched_domain_args *args,
> > +			   struct dlb_cmd_response *resp)
> > +{
> > +	return 0;
>=20
> Why have an empty function?  Just don't define it until you need it.
>=20
>=20
>=20
> > +}
> > +
> > +static int
> > +dlb_pf_get_num_resources(struct dlb_hw *hw,
> > +			 struct dlb_get_num_resources_args *args)
> > +{
> > +	return dlb_hw_get_num_resources(hw, args, false, 0);
> > +}
> > +
> >  /********************************/
> >  /****** DLB PF Device Ops ******/
> >  /********************************/
> > @@ -110,4 +129,6 @@ struct dlb_device_ops dlb_pf_ops =3D {
> >  	.init_driver_state =3D dlb_pf_init_driver_state,
> >  	.enable_pm =3D dlb_pf_enable_pm,
> >  	.wait_for_device_ready =3D dlb_pf_wait_for_device_ready,
> > +	.create_sched_domain =3D dlb_pf_create_sched_domain,
> > +	.get_num_resources =3D dlb_pf_get_num_resources,
> >  };
> > diff --git a/drivers/misc/dlb/dlb_resource.c b/drivers/misc/dlb/dlb_res=
ource.c
> > index 3c60b704f3d6..93936611027b 100644
> > --- a/drivers/misc/dlb/dlb_resource.c
> > +++ b/drivers/misc/dlb/dlb_resource.c
> > @@ -200,6 +200,69 @@ int dlb_resource_init(struct dlb_hw *hw)
> >  	return ret;
> >  }
> >
> > +/**
> > + * dlb_hw_get_num_resources() - query the PCI function's available res=
ources
> > + * @hw: dlb_hw handle for a particular device.
> > + * @arg: pointer to resource counts.
> > + * @vdev_req: indicates whether this request came from a vdev.
> > + * @vdev_id: If vdev_req is true, this contains the vdev's ID.
> > + *
> > + * This function returns the number of available resources for the PF =
or for a
> > + * VF.
> > + *
> > + * A vdev can be either an SR-IOV virtual function or a Scalable IOV v=
irtual
> > + * device.
> > + *
> > + * Return:
> > + * Returns 0 upon success, -EINVAL if vdev_req is true and vdev_id is
> > + * invalid.
> > + */
> > +int dlb_hw_get_num_resources(struct dlb_hw *hw,
> > +			     struct dlb_get_num_resources_args *arg,
> > +			     bool vdev_req,
> > +			     unsigned int vdev_id)
> > +{
> > +	struct dlb_function_resources *rsrcs;
> > +	struct dlb_bitmap *map;
> > +	int i;
> > +
> > +	if (vdev_req && vdev_id >=3D DLB_MAX_NUM_VDEVS)
> > +		return -EINVAL;
> > +
> > +	if (vdev_req)
> > +		rsrcs =3D &hw->vdev[vdev_id];
> > +	else
> > +		rsrcs =3D &hw->pf;
> > +
> > +	arg->num_sched_domains =3D rsrcs->num_avail_domains;
> > +
> > +	arg->num_ldb_queues =3D rsrcs->num_avail_ldb_queues;
> > +
> > +	arg->num_ldb_ports =3D 0;
> > +	for (i =3D 0; i < DLB_NUM_COS_DOMAINS; i++)
> > +		arg->num_ldb_ports +=3D rsrcs->num_avail_ldb_ports[i];
> > +
> > +	for (i =3D 0; i < DLB_NUM_COS_DOMAINS; i++)
> > +		arg->num_cos_ldb_ports[i] =3D rsrcs->num_avail_ldb_ports[i];
> > +
> > +	arg->num_dir_ports =3D rsrcs->num_avail_dir_pq_pairs;
> > +
> > +	arg->num_atomic_inflights =3D rsrcs->num_avail_aqed_entries;
> > +
> > +	map =3D rsrcs->avail_hist_list_entries;
> > +
> > +	arg->num_hist_list_entries =3D bitmap_weight(map->map, map->len);
> > +
> > +	arg->max_contiguous_hist_list_entries =3D
> > +		dlb_bitmap_longest_set_range(map);
> > +
> > +	arg->num_ldb_credits =3D rsrcs->num_avail_qed_entries;
> > +
> > +	arg->num_dir_credits =3D rsrcs->num_avail_dqed_entries;
> > +
> > +	return 0;
> > +}
> > +
> >  /**
> >   * dlb_clr_pmcsr_disable() - power on bulk of DLB 2.0 logic
> >   * @hw: dlb_hw handle for a particular device.
> > diff --git a/drivers/misc/dlb/dlb_resource.h b/drivers/misc/dlb/dlb_res=
ource.h
> > index 2229813d9c45..752645900f34 100644
> > --- a/drivers/misc/dlb/dlb_resource.h
> > +++ b/drivers/misc/dlb/dlb_resource.h
> > @@ -12,6 +12,11 @@ int dlb_resource_init(struct dlb_hw *hw);
> >
> >  void dlb_resource_free(struct dlb_hw *hw);
> >
> > +int dlb_hw_get_num_resources(struct dlb_hw *hw,
> > +			     struct dlb_get_num_resources_args *arg,
> > +			     bool vdev_req,
> > +			     unsigned int vdev_id);
> > +
> >  void dlb_clr_pmcsr_disable(struct dlb_hw *hw);
> >
> >  #endif /* __DLB_RESOURCE_H */
> > diff --git a/include/uapi/linux/dlb.h b/include/uapi/linux/dlb.h
> > new file mode 100644
> > index 000000000000..956d5e9d1ddc
> > --- /dev/null
> > +++ b/include/uapi/linux/dlb.h
> > @@ -0,0 +1,166 @@
> > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
> > + * Copyright(c) 2016-2020 Intel Corporation
> > + */
>=20
> Use the correct comment line for SPDX please.
>=20

Will do.

>=20
> > +
> > +#ifndef __DLB_H
> > +#define __DLB_H
> > +
> > +#include <linux/types.h>
> > +
> > +struct dlb_cmd_response {
> > +	__u32 status; /* Interpret using enum dlb_error */
> > +	__u32 id;
> > +};
> > +
> > +/********************************/
> > +/* 'dlb' device file commands  */
> > +/********************************/
> > +
> > +#define DLB_DEVICE_VERSION(x) (((x) >> 8) & 0xFF)
> > +#define DLB_DEVICE_REVISION(x) ((x) & 0xFF)
> > +
> > +enum dlb_revisions {
> > +	DLB_REV_A0 =3D 0,
>=20
> What is a "revision" and why do you care about it?

This is for different revisions of hardware. Each revision of hardware may =
have a slight different configuration/feature.

>=20
> > +};
> > +
> > +/*
> > + * DLB_CMD_GET_DEVICE_VERSION: Query the DLB device version.
> > + *
> > + *	Each DLB device version has its own unique ioctl API, but all share
> > + *	this as the first command in their interface, which tells user-spac=
e
> > + *	which API to use. The device revision is provided in case of any
> > + *	hardware errata.
> > + *
> > + * Output parameters:
> > + * - response.status: Detailed error code. In certain cases, such as i=
f the
> > + *	ioctl request arg is invalid, the driver won't set status.
> > + * - response.id[7:0]: Device revision.
> > + * - response.id[15:8]: Device version.
>=20
> So userspace has to do different things depending on what the hardware
> type is?  Why not make a totally different driver for new hardware
> types if things are going to change in the future?
>=20

This comment is not correct (sorry about this).  There will be different=20
versions of  DLB hardware (of the same type). All DLB devices will have the=
 same ioctl
API and userspace interface.

>=20
> > + */
> > +
> > +struct dlb_get_device_version_args {
> > +	/* Output parameters */
> > +	struct dlb_cmd_response response;
> > +};
> > +
> > +/*
> > + * DLB_CMD_CREATE_SCHED_DOMAIN: Create a DLB 2.0 scheduling domain and
> reserve
> > + *	its hardware resources. This command returns the newly created doma=
in
> > + *	ID and a file descriptor for accessing the domain.
> > + *
> > + * Input parameters:
> > + * - num_ldb_queues: Number of load-balanced queues.
> > + * - num_ldb_ports: Number of load-balanced ports that can be allocate=
d from
> > + *	any class-of-service with available ports.
> > + * - num_cos_ldb_ports[4]: Number of load-balanced ports from
> > + *	classes-of-service 0-3.
> > + * - num_dir_ports: Number of directed ports. A directed port has one =
directed
> > + *	queue, so no num_dir_queues argument is necessary.
> > + * - num_atomic_inflights: This specifies the amount of temporary atom=
ic QE
> > + *	storage for the domain. This storage is divided among the domain's
> > + *	load-balanced queues that are configured for atomic scheduling.
> > + * - num_hist_list_entries: Amount of history list storage. This is di=
vided
> > + *	among the domain's CQs.
> > + * - num_ldb_credits: Amount of load-balanced QE storage (QED). QEs oc=
cupy this
> > + *	space until they are scheduled to a load-balanced CQ. One credit
> > + *	represents the storage for one QE.
> > + * - num_dir_credits: Amount of directed QE storage (DQED). QEs occupy=
 this
> > + *	space until they are scheduled to a directed CQ. One credit represe=
nts
> > + *	the storage for one QE.
> > + * - cos_strict: If set, return an error if there are insufficient por=
ts in
> > + *	class-of-service N to satisfy the num_ldb_ports_cosN argument. If
> > + *	unset, attempt to fulfill num_ldb_ports_cosN arguments from other
> > + *	classes-of-service if class N does not contain enough free ports.
> > + * - padding1: Reserved for future use.
> > + *
> > + * Output parameters:
> > + * - response.status: Detailed error code. In certain cases, such as i=
f the
> > + *	ioctl request arg is invalid, the driver won't set status.
> > + * - response.id: domain ID.
> > + * - domain_fd: file descriptor for performing the domain's ioctl oper=
ations
> > + * - padding0: Reserved for future use.
>=20
> These are upside down as per the structure definition below.
>=20
> And insist that your "padding" must be set to 0 and enforce it,
> otherwise it is useless.
>=20
> I'm stopping reviewing here...
>=20
> greg k-h

Will change the order of the comments. Thanks for the review. I will submit=
 the revised patch set after making the suggested changes.

Best Regards,
Mike

