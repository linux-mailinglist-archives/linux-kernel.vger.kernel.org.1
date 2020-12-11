Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9C42D74C4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 12:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395001AbgLKLfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 06:35:33 -0500
Received: from mga06.intel.com ([134.134.136.31]:52789 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394998AbgLKLfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 06:35:10 -0500
IronPort-SDR: J6q7751Fhcqnej8L7JAFITOQYPFPfOMDB1hi0QDca+56VG/uoQE42M9ZG7V4t9SZey0IQJ9MtM
 2+5EQvvwm2cA==
X-IronPort-AV: E=McAfee;i="6000,8403,9831"; a="236012534"
X-IronPort-AV: E=Sophos;i="5.78,411,1599548400"; 
   d="scan'208";a="236012534"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2020 03:34:29 -0800
IronPort-SDR: SlxhapbMNATFEgNXKGs9nytoRKII3awJayb2e9j/2KqLtJlukhlrp2gIe4zfyRrACTcz2o2B3C
 zkBp+v/WmBCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,411,1599548400"; 
   d="scan'208";a="371577260"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga004.fm.intel.com with ESMTP; 11 Dec 2020 03:34:28 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 11 Dec 2020 03:34:28 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 11 Dec 2020 03:34:28 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Fri, 11 Dec 2020 03:34:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hyyz1/9ko5f5M1cJJE16J7aqwTc74tUM3jb/GWxiMEpyrHjrTo1eXm7kOrqg741SAlwJcEbiZhG5gA7V8lZXwK0JaAIwthyy6DssalQ2x9Onq0KzDFNPlotM+8tmu0hczXd1s5GkySg/hvXGoRtN8FxoohsmNHBAiNqo7B/7N0l1sE0F8vyiaThDfew2EC13+kyOByKCnWbyPuqEMX8fJeUc8w6/Boq7hqpSZB9Y6BOnZr7Ou4AlAr1aA0CWcGXfgsyQpbOmoxMiQLbCvNtIf0FzovU3psm3c4ToMsbo9tsVRBit9L9rywv+r2rEcJlk9+NtEAlipb9S7EQDoVWE7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NHK+bp5XPU3zCYC0srNmd9CUeHaXIH41oozIr9wc45E=;
 b=ZvS0VIrfPjxAiz8eeoNrInHZYKVdatDoHzwgClTkTdYlU+t0NDYi5sRuPwtkqgE63B0I1hvh4pMjWleK67rJUURmjU5mnB51/vx0C1VfzLSDeCQ37upybSQ/ok5UKy7+bKa98Oy7C9W+7rASo1s/beNiAwFqwy8xYvsYNmqn4MSYN4yS3XE2E8dMY3dmQtcmwieGBPyr3+gdGCnmSzDvIVRjb6RbHqH7c4W+BAe/ERNug5aypMgnyZ4DdeneRP1t6bJhFrYmaXUOMQ3DhwVgb6tJwuyF7rjd8Hm4uFe3USesdWSGxa3vVzK6t5yDQf1uEpJkxPn8BuaNLi1dwnJ/Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NHK+bp5XPU3zCYC0srNmd9CUeHaXIH41oozIr9wc45E=;
 b=JXynBqHtttQbSaX0lfUohHNuKoBvbRJTzLEc17nApr+vLGPOxGh490DKqORd1WmqisIIaXwrw7xnE3hREjatbFzTbkrnu1dn2EKxXQKUdfTa4NHS8L4CC5fkvaDYLjV8LDLJHf0xY8oX9PgtCirZJMLYEWPPLV1w8Ea2gysLEOs=
Received: from BYAPR11MB3783.namprd11.prod.outlook.com (2603:10b6:a03:f5::12)
 by BYAPR11MB2950.namprd11.prod.outlook.com (2603:10b6:a03:8f::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.23; Fri, 11 Dec
 2020 11:34:26 +0000
Received: from BYAPR11MB3783.namprd11.prod.outlook.com
 ([fe80::2c85:a097:7a95:4387]) by BYAPR11MB3783.namprd11.prod.outlook.com
 ([fe80::2c85:a097:7a95:4387%5]) with mapi id 15.20.3654.015; Fri, 11 Dec 2020
 11:34:26 +0000
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
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 21/22] xlink-core: add async channel and events
Thread-Topic: [PATCH 21/22] xlink-core: add async channel and events
Thread-Index: AQHWyDJFetb15Z+o8EW1hshAcoVksKnq+GuAgAbZ9OA=
Date:   Fri, 11 Dec 2020 11:34:26 +0000
Message-ID: <BYAPR11MB3783776629BEAB3C3292D9B18ACA0@BYAPR11MB3783.namprd11.prod.outlook.com>
References: <20201201223511.65542-1-mgross@linux.intel.com>
         <20201201223511.65542-22-mgross@linux.intel.com>
 <b23bffa8810b3f80bf4cbc8b654f3d73a3b6a2ce.camel@perches.com>
In-Reply-To: <b23bffa8810b3f80bf4cbc8b654f3d73a3b6a2ce.camel@perches.com>
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
x-ms-office365-filtering-correlation-id: f420d74b-7dfe-411a-7a95-08d89dc8b752
x-ms-traffictypediagnostic: BYAPR11MB2950:
x-microsoft-antispam-prvs: <BYAPR11MB29509E9CEE80EAB3ECA873FA8ACA0@BYAPR11MB2950.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /9BFPM9INd95T5x7EbUBu5Wc8FVIBZ9G1/MzXLzGAp6IdkWBR7psIIgDmf3OMmcyN/tAouyJl55mFbdHY1GtkBDxxRcn/UIjrOrnrYDUqtpCsZngoGvWyavJ89R3pOSPVCkx1M5a424q48oyKh5eGDfIK1pDEZYnBqVlh5G5yTcfyrXDpI70WYlq85SWp7LWcz/R6Dt+T2VCHiFprtbHHrYDg6sn2nQTYMFsJjLKdafjXavGnvbl7htVhS0agQeawGjDXJ3gnVaxMhVFOgSa2HbQypCxYVhva0TeLdMGwE9Wqr74EMsYco1lv3ExKywKf6qEuszdLvTBtG6sI8hyA4+vugCAJYb0rD7DeeRZnZSKIG+DalYpHF1f2Wm2J+aq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3783.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(136003)(508600001)(110136005)(9686003)(7416002)(53546011)(5660300002)(52536014)(4326008)(186003)(86362001)(33656002)(71200400001)(64756008)(7696005)(66446008)(66946007)(2906002)(8676002)(55016002)(8936002)(6506007)(26005)(66556008)(921005)(66476007)(76116006)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?Etjg68yHyI5kHZgpU2SYIyShAEMpeaFTqgmxpqQNKvk0Vn3goeFLm97FKo?=
 =?iso-8859-1?Q?SEeKi1xwopKfCZojSSOxX96Zhu5db01xRzxhSizfXiUFNyVCfEYumGJRhQ?=
 =?iso-8859-1?Q?Ko2yNsZAZ19MgXsO9yAKSALliRs9CM5OZz53Efn6QOAO1Ay+r+dmnFlSpo?=
 =?iso-8859-1?Q?+F8hx9Cd2r/rAyIxfe1yRau/zI7E1SFT5CXlnH5zzUqGjtl5pSPb5nKQMT?=
 =?iso-8859-1?Q?NwMFWd6V8CYUR/9+BkC4PnkHyrrjhAXJa/5gk0pkvrWMz4JdD8xkODsf8Z?=
 =?iso-8859-1?Q?fJvCZUzPn8i/PPnyfP6NCqcf/J791T02Y6zzktU64cYizoeKQB4OgkjYYV?=
 =?iso-8859-1?Q?vwneO0KGlIrgrRa9voPVS0PVqAg6PHp8FZu8Jzq/H96XQxegRnqlvig5ip?=
 =?iso-8859-1?Q?ZcmjtJV+OybXj6Dz+MOjdfjoUJK9trAYhWBFBsrT5fVq+PHXOjSJluPRaH?=
 =?iso-8859-1?Q?nInMY1rfrJe5JMkYZg5MvE4QRFRvELK6KO1wDvUsxbnW8uyWe/J50NQOg1?=
 =?iso-8859-1?Q?Yd5eplW56+I6XHgDGJVIG8/MZNUEr6qZme77WL2RfGBFFZuFrN1nsQBxpG?=
 =?iso-8859-1?Q?WuBTS0jbtzpZszkO4GYeseZlMKdUWV1lU7kGXSAt3uoCPHbvAc7s2mQv7U?=
 =?iso-8859-1?Q?6BdGkXuEmwsx2TitrfHdW5StwTEag9Cvci2CP9Xq2l444vxXuBRd9DRsOh?=
 =?iso-8859-1?Q?0kBctZKwK337DTv+bcU+Lp17wZSEpXDYrxqjCB5lBVzy4GxP307xJ0Ao1+?=
 =?iso-8859-1?Q?3t86643JnRB30eeXX8hJv2wHhpfslZOCc1VVNt6nWdJBcgSdpmUcATI7k5?=
 =?iso-8859-1?Q?lmuY2NXu/7iqOoK46QM5S4KhdPadWY178aqeO4Ow0WCr5te3npqCwVybVt?=
 =?iso-8859-1?Q?RALZGeu9/LW/oRTB3+jlV7IB/GjN9X6XqUuDhQKjAC3xrRtma4a42Ruabc?=
 =?iso-8859-1?Q?DgAg7MiGh9M1aZJf2HDgT5iNk0zSHwsZd/gm2UaCeKipP38u9Hv6YYh6hY?=
 =?iso-8859-1?Q?wXf3VvD7uWwQuwrak=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3783.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f420d74b-7dfe-411a-7a95-08d89dc8b752
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2020 11:34:26.6671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BbvWDzcPax3V/nzjhTC+RFQ554tC45X2y8jw6lTX/mvB5bDh+3vagndcCX+u3BViugqriH6q5VXluHemHSGwrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2950
X-OriginatorOrg: intel.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: Joe Perches <joe@perches.com> =

Sent: Monday, December 7, 2020 2:55 AM
To: mgross@linux.intel.com; markgross@kernel.org; arnd@arndb.de; bp@suse.de=
; damien.lemoal@wdc.com; dragan.cvetic@xilinx.com; gregkh@linuxfoundation.o=
rg; corbet@lwn.net; leonard.crestez@nxp.com; palmerdabbelt@google.com; paul=
.walmsley@sifive.com; peng.fan@nxp.com; robh+dt@kernel.org; shawnguo@kernel=
.org
Cc: linux-kernel@vger.kernel.org; Kelly, Seamus <seamus.kelly@intel.com>
Subject: Re: [PATCH 21/22] xlink-core: add async channel and events

On Tue, 2020-12-01 at 14:35 -0800, mgross@linux.intel.com wrote:
> Enable asynchronous channel and event communication.
[]
> diff --git a/drivers/misc/xlink-core/xlink-core.c =

> b/drivers/misc/xlink-core/xlink-core.c
[]
> +
> +// sysfs attribute functions
> +
> +static ssize_t event0_show(struct device *dev, struct =

> +device_attribute *attr, char *buf) {
> +	struct keembay_xlink_dev *xlink_dev =3D dev_get_drvdata(dev);
> +	struct xlink_attr *a =3D &xlink_dev->eventx[0];
> +
> +	return scnprintf(buf, PAGE_SIZE, "0x%x 0x%lx\n", a->sw_dev_id, =

> +a->value); }
> +
> +static ssize_t event1_show(struct device *dev, struct =

> +device_attribute *attr, char *buf) {
> +	struct keembay_xlink_dev *xlink_dev =3D dev_get_drvdata(dev);
> +	struct xlink_attr *a =3D &xlink_dev->eventx[1];
> +
> +	return scnprintf(buf, PAGE_SIZE, "0x%x 0x%lx\n", a->sw_dev_id, =

> +a->value); }
> +
> +static ssize_t event2_show(struct device *dev, struct =

> +device_attribute *attr, char *buf) {
> +	struct keembay_xlink_dev *xlink_dev =3D dev_get_drvdata(dev);
> +	struct xlink_attr *a =3D &xlink_dev->eventx[2];
> +
> +	return scnprintf(buf, PAGE_SIZE, "0x%x 0x%lx\n", a->sw_dev_id, =

> +a->value); }
> +
> +static ssize_t event3_show(struct device *dev, struct =

> +device_attribute *attr, char *buf) {
> +	struct keembay_xlink_dev *xlink_dev =3D dev_get_drvdata(dev);
> +	struct xlink_attr *a =3D &xlink_dev->eventx[3];
> +
> +	return scnprintf(buf, PAGE_SIZE, "0x%x 0x%lx\n", a->sw_dev_id, =

> +a->value); }

These could use the sysfs_emit function and not scnprintf and as well could=
 use a single shared function with an index.

Something like:

static ssize_t eventx_show(struct device *dev, struct device_attr *attr, in=
t index, char *buf) {
	struct keembay_xlink_dev *xlink_dev =3D dev_get_drvdata(dev);
	struct xlink_attr *a =3D &xlink_dev->eventx[index];

	return sysfs_emit(buf, "0x%x 0x%lx\n", a->sw_dev_id, a->value); }

static ssize_t event0_show(struct device *dev, struct device_attribute *att=
r, char *buf) {
	return eventx_show(dev, attr, 0, buf);
}

etc...
[Kelly, Seamus]  Thank you!  will do.

> @@ -270,19 +353,23 @@ static long xlink_ioctl(struct file *file, unsigned=
 int cmd, unsigned long arg)
> =A0	struct xlinkconnect		con	=3D {0};
> =A0	struct xlinkrelease		rel	=3D {0};
> =A0	struct xlinkstartvpu		startvpu =3D {0};
> +	struct xlinkcallback		cb	=3D {0};
> =A0	struct xlinkgetdevicename	devn	=3D {0};
> =A0	struct xlinkgetdevicelist	devl	=3D {0};
> =A0	struct xlinkgetdevicestatus	devs	=3D {0};
> =A0	struct xlinkbootdevice		boot	=3D {0};
> =A0	struct xlinkresetdevice		res	=3D {0};
> =A0	struct xlinkdevmode		devm	=3D {0};
> +	struct xlinkregdevevent		regdevevent =3D {0};

Perhaps significantly less stack would be used if these declarations were m=
oved into the case blocks where used.  Less initialization would be done pe=
r ioctl too.

[Kelly, Seamus]  This has changed significantly In next patch and I take yo=
ur comments ( on next patch also ) Thanks

> @@ -318,6 +405,30 @@ static long xlink_ioctl(struct file *file, unsigned =
int cmd, unsigned long arg)
> =A0		if (copy_to_user((void __user *)op.return_code, (void *)&rc, sizeof(=
rc)))
> =A0			return -EFAULT;
> =A0		break;
> +	case XL_DATA_READY_CALLBACK:
> +		if (copy_from_user(&cb, (void __user *)arg,
> +				   sizeof(struct xlinkcallback)))
> +			return -EFAULT;
> +		if (copy_from_user(&devh, (void __user *)cb.handle,
> +				   sizeof(struct xlink_handle)))
> +			return -EFAULT;
> +		CHANNEL_SET_USER_BIT(cb.chan); // set MSbit for user space call
> +		rc =3D xlink_data_available_event(&devh, cb.chan, cb.callback);
> +		if (copy_to_user((void __user *)cb.return_code, (void *)&rc, sizeof(rc=
)))
> +			return -EFAULT;
> +		break;

	case XL_DATA_READY_CALLBACK: {
		struct xlinkcallback cb	=3D {};
		etc...
		break;
	}



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

