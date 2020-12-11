Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7EE2D74CB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 12:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404635AbgLKLhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 06:37:47 -0500
Received: from mga14.intel.com ([192.55.52.115]:23122 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392070AbgLKLhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 06:37:35 -0500
IronPort-SDR: gTDyM5Qo3u/w5CtmRoT8gyv0dIWF2x2s/pdF9YCAl4DqfXtpNc+h6+ekgUm/c7YSkt9JvBBrEn
 XYeEbtDIY3Qg==
X-IronPort-AV: E=McAfee;i="6000,8403,9831"; a="173653384"
X-IronPort-AV: E=Sophos;i="5.78,411,1599548400"; 
   d="scan'208";a="173653384"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2020 03:36:54 -0800
IronPort-SDR: tQtJW4RtQZkWhZ4DQJW/7itUW822ruBp4DAtSv0GXC9D4kOlJw/TdiS5UlaxIkaeUnRuBU+POj
 Vup/b0cMWbKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,411,1599548400"; 
   d="scan'208";a="440834402"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga001.fm.intel.com with ESMTP; 11 Dec 2020 03:36:53 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 11 Dec 2020 03:36:53 -0800
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 11 Dec 2020 03:36:52 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 11 Dec 2020 03:36:52 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Fri, 11 Dec 2020 03:36:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eZ+9qA4aY9gQSknYPe/Y5hIPmtHA/vBJmVFrwOy8NlDvIjQKLGK3UX681EVBLxqOcNd/pan90v9dCCLLrWueUJTeU/i5yUafNnp4ve7L7NotzQSt74biMJLfila6J8Uff2LO6Li/ThdrnECjiD/3qczQcM/bCZWYgH2wVc/jRYTWd8FoLyJLy33tLcRN2ZEArO5C/cFw2zwzXu+oJRAjOzOcngdKZiCI2H0VCsWyo901iXD+hW1PcBlUi3g8Neajdjy+64KIQSCcnsZIrpEg9stsvfJsrZDP0O4255c9nUSxyymoTw0t6RfD7yw6KgZxcE04sb/Br5u2sIIWIk7Fjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2K85VREV5qq1nEDEXGJhOBja+6unmFiidrEQYQdt3Qw=;
 b=E+bXkuTxyhuz939mDM+ZZ0qZVfvhkFjs317KuqYskd/4wT0QFIJCcpC5m8/nDUZEjXnTsnz3DpCy2NCNI6EJ5aUTlkS9j+7y3tnmVYy6haZS7Orfoqjxi+IK097/GqfiZXOGOHnn8wumjewI4UcfWww2oWc7gXd0nX/TcpTGIWaqjItGK/j6g8THjL6VPbNe2Sn+nCIA8L3emvUUqZswJTBSgXmbCUWtwydZ7ja9qQDLyZYPNKo0Q5yVl26ajIQNea8S9yf1LXJM+jaBEEz/DSA9G0aX2sCuuiIBthO6S8timboER9OsHdeIfdODdFR6NpAVpd+W0AApnakGyt45Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2K85VREV5qq1nEDEXGJhOBja+6unmFiidrEQYQdt3Qw=;
 b=DVV4HGyCyIzOqXTMiOohEKmET/Fevse9BqdSqee4B2TeYXHm9mgEELT2BlTeYvAzTTYCx+yp2UT7hgEwhBZC8449nrKQCi776d6NMhSbO0FHHEhOibPOnOce9YPAyec/b89PTpU28VliI2Dfcm7d/DUlGvDpPxKm3EJJdOKRVzQ=
Received: from BYAPR11MB3783.namprd11.prod.outlook.com (2603:10b6:a03:f5::12)
 by BYAPR11MB2950.namprd11.prod.outlook.com (2603:10b6:a03:8f::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.23; Fri, 11 Dec
 2020 11:36:50 +0000
Received: from BYAPR11MB3783.namprd11.prod.outlook.com
 ([fe80::2c85:a097:7a95:4387]) by BYAPR11MB3783.namprd11.prod.outlook.com
 ([fe80::2c85:a097:7a95:4387%5]) with mapi id 15.20.3654.015; Fri, 11 Dec 2020
 11:36:50 +0000
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
Subject: RE: [PATCH 22/22] xlink-core: factorize xlink_ioctl function by
 creating sub-functions for each ioctl command
Thread-Topic: [PATCH 22/22] xlink-core: factorize xlink_ioctl function by
 creating sub-functions for each ioctl command
Thread-Index: AQHWyDJR8ItxJgs1qEGd/hLs04kNn6nueskAgANYXnA=
Date:   Fri, 11 Dec 2020 11:36:50 +0000
Message-ID: <BYAPR11MB3783897584146E0B770086FF8ACA0@BYAPR11MB3783.namprd11.prod.outlook.com>
References: <20201201223511.65542-1-mgross@linux.intel.com>
         <20201201223511.65542-23-mgross@linux.intel.com>
 <f54fcb1e9f90b529826d8d6abb2ae99b15108d16.camel@perches.com>
In-Reply-To: <f54fcb1e9f90b529826d8d6abb2ae99b15108d16.camel@perches.com>
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
x-ms-office365-filtering-correlation-id: fe737ec6-65ae-4b61-c0ed-08d89dc90ce6
x-ms-traffictypediagnostic: BYAPR11MB2950:
x-microsoft-antispam-prvs: <BYAPR11MB295098F5D1520FEE0352829D8ACA0@BYAPR11MB2950.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hdnvv0b3rIKjR5sFEokE6HOjA4BPE3FI8Irop0c8oB/Ix8i+QdA7fEoGMsf24EQiJqcA4zUFTx+4In2UluN5scjg+3maLygmYED/SXweMPIhHXGw7iAQkAtGaivZeKJIRxrFXfhhqTyPzigabIs4c+TyJjXPpXHAdn7ZDa6OyVwQwraRTfZPBS/anFlQzd75eWiRFgaahpHFXm6N2w3FH/yipPo21pZqrBEQhXC02gcNy+0nsEvv5FZirjCBdGSkW4zw3x+NPqAIoFg9N0WEQUD8mDlHtdDFy7Dn6qQB/iMCNuz5edcHTQQClg1lpWJX/nb2RGQzKscGDu6vKv9dBGDfOoqJ/h9ZsfQDRYAFEmTzmDOeMhmwrLfsPC4NZiSC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3783.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(136003)(508600001)(110136005)(9686003)(7416002)(53546011)(5660300002)(52536014)(4326008)(186003)(86362001)(33656002)(71200400001)(64756008)(7696005)(66446008)(66946007)(2906002)(8676002)(55016002)(8936002)(6506007)(26005)(66556008)(921005)(66476007)(76116006)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?sk1KOQBTvNCxLnSPFzCVY3BbkvgfOywARJ/sdV/9lrVJ11BFEyTQjQ3X1715?=
 =?us-ascii?Q?qly2iddIz1xfNH4G5H/skdlHMxWu6v3WPauvhK7cbXZpGTLwJJSAAsti/264?=
 =?us-ascii?Q?JhujMiNJz3D/w7U9wxoAEufpxko8Atxv1IYUImpAtvsfz8H7Q06twoPsZCmj?=
 =?us-ascii?Q?r6wwyDCXUl81nquH6PgMTBlmLxk2CzkxMAYewkVTC4Uf/eV5VEZbnM9nsiLh?=
 =?us-ascii?Q?LG/VsAj2emNxYKIff53aBeVG5hwI5GzOyULVNhYfIoAuCn95ylIXcj0fOBdr?=
 =?us-ascii?Q?2vhWeXCtjAKNQoYn/vp3iPypN9swPEqmMl3MLwdaYwlZJxvKqmjeq/copN5r?=
 =?us-ascii?Q?m4/A2p05RK3BXmmpWnXrwqDsn7Fz36cLbrVaJobuybzaE4j1WkYPtVBu7X4+?=
 =?us-ascii?Q?COlDdgdMbPIxqfRULN/13arl+ESiaUAnuBIyOAGY92QzOghr0Zxg31py8szk?=
 =?us-ascii?Q?OfODWyue5mZYpISWl1uFbdjy2X8Sl8zdd+fwVsRAmtId5wI9uev/zdw0sF55?=
 =?us-ascii?Q?/3ftkxl6u9Yp+wEiMzx40ar03C7zRWvTi5uq50LORlUfJvyYrR0DBkW+qSn/?=
 =?us-ascii?Q?vXTDOEFiIppztI+UiebafHk5/NsogKC2KS9w4r870swu4nVCWORc9hCM7Jhs?=
 =?us-ascii?Q?594OY7fFXeiD0QPkWpD+dKKA3Kvt93QvWq87lM8MBwMY6kxTwf/aZJS8lt+6?=
 =?us-ascii?Q?RCF0MuQM0CzTmkeUiBRt7EFYqWhQxKf1pl0jvJBhPXk/kDJpBp6B4U7U07I0?=
 =?us-ascii?Q?7Zh5Q1HtiWBCw+ilNIUENB2MDcvHi0UNDHoCQ0c502rt7gFd9K5Xz/JViRrm?=
 =?us-ascii?Q?i/p9LcESomVsy0SCJP6rZobZj6qJ1dX42SeC/KHz+6BBBa+2XF8krnzt6GZe?=
 =?us-ascii?Q?aGpAdO9TFwc5u83OOK3vsP8ixBCO7wPx4fjL41NdIceak1jfcmPVKzzzjWTY?=
 =?us-ascii?Q?/a4rtP1/6pQB6aw7dzIZUiIrnSP28G+NnoZKlg69ErM=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3783.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe737ec6-65ae-4b61-c0ed-08d89dc90ce6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2020 11:36:50.2282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a7/UmNFqrTlNVlF0OqhT1fV0WQfVvzRn1efqHT1UBVLBaXQFmBtfJ7jTQzbS1MIcQDs+liBi/ow1U3OemPVa5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2950
X-OriginatorOrg: intel.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: Joe Perches <joe@perches.com> =

Sent: Wednesday, December 9, 2020 8:31 AM
To: mgross@linux.intel.com; markgross@kernel.org; arnd@arndb.de; bp@suse.de=
; damien.lemoal@wdc.com; dragan.cvetic@xilinx.com; gregkh@linuxfoundation.o=
rg; corbet@lwn.net; leonard.crestez@nxp.com; palmerdabbelt@google.com; paul=
.walmsley@sifive.com; peng.fan@nxp.com; robh+dt@kernel.org; shawnguo@kernel=
.org
Cc: linux-kernel@vger.kernel.org; Kelly, Seamus <seamus.kelly@intel.com>
Subject: Re: [PATCH 22/22] xlink-core: factorize xlink_ioctl function by cr=
eating sub-functions for each ioctl command

On Tue, 2020-12-01 at 14:35 -0800, mgross@linux.intel.com wrote:
> Refactor the too large IOCTL function to call helper functions.
[]
> diff --git a/drivers/misc/xlink-core/xlink-ioctl.c =

> b/drivers/misc/xlink-core/xlink-ioctl.c
[]
> +int ioctl_write_data(unsigned long arg) {
> +	struct xlink_handle	devh	=3D {0};
> +	struct xlinkwritedata		wr	=3D {0};
> +	int rc =3D 0;
> +
> +	if (copy_from_user(&wr, (void __user *)arg,
> +			   sizeof(struct xlinkwritedata)))
> +		return -EFAULT;
> +	if (copy_from_user(&devh, (void __user *)wr.handle,
> +			   sizeof(struct xlink_handle)))
> +		return -EFAULT;
> +	if (wr.size <=3D XLINK_MAX_DATA_SIZE) {
> +		rc =3D xlink_write_data_user(&devh, wr.chan, wr.pmessage,
> +					   wr.size);
> +		if (copy_to_user((void __user *)wr.return_code, (void *)&rc,
> +				 sizeof(rc)))
> +			return -EFAULT;
> +	} else {
> +		return -EFAULT;
> +	}

Please reverse the test to reduce indentation
[Kelly, Seamus]  Thank you!  will do.

	if (wr.size > XLINK_MAX_DATA_SIZE)
		return -EFAULT;
	rc =3D xlink_write_data_user(&devh, wr.chan, wr.pmessage, wr.size);
	if (copy_to_user((void __user *)wr.return_code, (void *)&rc, sizeof(rc)))
		return -EFAULT;
	return rc;

The last 3 lines here are repeated multiple times in many functions.
It might be sensible to add something like:

int copy_result_to_user(u32 *where, int rc) {
	if (copy_to_user((void __user *)where, &rc, sizeof(rc)))
		return -EFAULT;
	return rc;
}

so this could be written

	rc =3D xlink_write_data_user(&devh, wr.chan, wr.pmessage, wr.size);

	return copy_result_to_user(wr.return_code, rc);

[Kelly, Seamus] Thank you!  will do.

IMO: return_code isn't a great name for a pointer as it rather indicates a =
value not an address and there's an awful lot of casting to __user in all t=
his code that perhaps should be marked in the struct definitions rather tha=
n inside the function uses.

[Kelly, Seamus] Thank you!  will do.
> +}
> +
> +int ioctl_write_control_data(unsigned long arg) {
> +	struct xlink_handle	devh	=3D {0};

All of these initializations with {0} should use {} instead as the first el=
ement of whatever struct is not guaranteed to be assignable as an int and g=
cc/clang guarantee 0 initialization
[Kelly, Seamus] Thank you!  will do.

> +	struct xlinkwritedata		wr	=3D {0};
> +	u8 volbuf[XLINK_MAX_BUF_SIZE];
> +	int rc =3D 0;
> +
> +	if (copy_from_user(&wr, (void __user *)arg,
> +			   sizeof(struct xlinkwritedata)))
> +		return -EFAULT;
> +	if (copy_from_user(&devh, (void __user *)wr.handle,
> +			   sizeof(struct xlink_handle)))
> +		return -EFAULT;
> +	if (wr.size <=3D XLINK_MAX_CONTROL_DATA_SIZE) {
> +		if (copy_from_user(volbuf, (void __user *)wr.pmessage,
> +				   wr.size))
> +			return -EFAULT;
> +		rc =3D xlink_write_control_data(&devh, wr.chan, volbuf,
> +					      wr.size);
> +		if (copy_to_user((void __user *)wr.return_code,
> +				 (void *)&rc, sizeof(rc)))
> +			return -EFAULT;
> +	} else {
> +		return -EFAULT;

Same test reversal and deindentation please.
[Kelly, Seamus] Thank you!  will do.

> +	}
> +	return rc;
> +}
> +


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

