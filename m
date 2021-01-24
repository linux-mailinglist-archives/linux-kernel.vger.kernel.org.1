Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63AF3301B89
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 12:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbhAXLuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 06:50:18 -0500
Received: from mga06.intel.com ([134.134.136.31]:22657 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726855AbhAXLtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 06:49:14 -0500
IronPort-SDR: 8nF/MjGERHeSnBEoNPBFLx2agm7v9FDGI1MRuVpQyedZfnZLL0KXLWmDli0ucWi41NnYxWiOuo
 HgKjdIUOSp+Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9873"; a="241148519"
X-IronPort-AV: E=Sophos;i="5.79,371,1602572400"; 
   d="scan'208";a="241148519"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2021 03:48:32 -0800
IronPort-SDR: QFJa5BjlOhOeHHUo6QD/+uYTT3z//hvsnnAq2SohOS5EXsn9SU3F1PPhl9aLnOMk82FwkVyr80
 kwvTAJwLK0ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,371,1602572400"; 
   d="scan'208";a="573159447"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 24 Jan 2021 03:48:31 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 24 Jan 2021 03:48:31 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 24 Jan 2021 03:48:31 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Sun, 24 Jan 2021 03:48:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+UkvPOL31n3wHXk8sxYS9wr29lXZJYOvdyBiB6JLekqKuxh+aQsWQIvPIszPD7+NouxWt5FVAjUDn32JP9tQlvRAIZofIy+WiEHSTL+FzlWFpWLKldkJh5obc+tv6/+VwugncXuakovfi0pO9LGuVNN/0tbwP9nT9+x1tKkObI27oJ+gldSJtxrzvhUYhJi/j5BsP8wyGQrFQQBvWCPMfJdVPxKKveEgtycS/Qsqh5ey6QyajO8g9fO/q0WWpuegauIYj+5HSyrGMHj70SKyNxzj56p4hc0n8FzLjQ4iUTqKthR5w9jbqljyp+M85m2BuAXP8w/AhNQwo6in0GpVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hP3dN5lDi/mVe/DA/bvOnLOTgH0xq478xbWModtry+A=;
 b=PmUC/zL7AlGm/iHSccXcZlFo+2C+474pH7cgK9Pn72SkVpsf9PyWYUElBWyCx5RXRQPe5n7kxK2GYaob7zC0GBj7iuAo1WMANFIz6AAkZqGH4+opDvvG0Lq1DR2vQug7LrRpp8k4lTyRWGeg1TfGCIGBWZxg/eeX4wJup5XJ5ZWDAcQxj8/+m8PvkkDIjpw8kNYT5FuLcd0qctAm0GcpPjN2mXi4Te19nq9u9L4xHe7TqhDKOA7Z33mm8phaONX0CprKEGz9I0C3jakt2OlV1gOOPT2Gex5rbpZgOqYIy1W+lx2taKSsCOwHss8kynh8UlxgXtj8D4MT+A2JOCMxWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hP3dN5lDi/mVe/DA/bvOnLOTgH0xq478xbWModtry+A=;
 b=bagAnsT34Sx4p0E3IdTMpJ4WmE+RGSzeUEkNYT3b8DOjhzjamEG46q63y55O7Xq9YubuUwh2AwRbjOxfeC3wkP06MbKIx2ky6yBB4OCk240fAp6MOIHWrxisv4dTCu5LzqnVYfAf62cl9RlE+bG00Pzn2eJsymuepFJcSkHJLhU=
Received: from MWHPR11MB1406.namprd11.prod.outlook.com (2603:10b6:300:23::18)
 by MWHPR11MB2015.namprd11.prod.outlook.com (2603:10b6:300:28::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15; Sun, 24 Jan
 2021 11:48:29 +0000
Received: from MWHPR11MB1406.namprd11.prod.outlook.com
 ([fe80::89f0:cbc3:d9c2:6e7a]) by MWHPR11MB1406.namprd11.prod.outlook.com
 ([fe80::89f0:cbc3:d9c2:6e7a%7]) with mapi id 15.20.3784.017; Sun, 24 Jan 2021
 11:48:29 +0000
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>
Subject: RE: [PATCH v2 09/34] misc: xlink-pcie: lh: Add PCIe EPF driver for
 Local Host
Thread-Topic: [PATCH v2 09/34] misc: xlink-pcie: lh: Add PCIe EPF driver for
 Local Host
Thread-Index: AQHW5gUs6vFsn5nCsUuTx5ZeA9F45qow34mAgAIzIbA=
Date:   Sun, 24 Jan 2021 11:48:29 +0000
Message-ID: <MWHPR11MB14061D584C7CC0CE3AD58F1A85BE9@MWHPR11MB1406.namprd11.prod.outlook.com>
References: <20210108212600.36850-1-mgross@linux.intel.com>
 <20210108212600.36850-10-mgross@linux.intel.com> <YAhvJ2MxqnX2g0nS@kroah.com>
In-Reply-To: <YAhvJ2MxqnX2g0nS@kroah.com>
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
x-ms-office365-filtering-correlation-id: 3a9560b7-ca78-4110-a96a-08d8c05df7bd
x-ms-traffictypediagnostic: MWHPR11MB2015:
x-microsoft-antispam-prvs: <MWHPR11MB20153B70FBDC6F0389E9A72E85BE9@MWHPR11MB2015.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X8r/B5eNHZV04b9XSsAOd73903qh7jvCJUQsP78jKP75PNGOXr2ZI+84brGAE7JXWvXco56oz2BF59jaJKvDyPtClkQCVpi6lX4TQD5qJf7JETWRK7yPcrgD2vrmBmweieHAclNOIlytSquf4TVGDZAO7K9Z9lXZPiqhAYm03oXGhpS27Okcdg6Oy2CwxYAXVzowU+K5hy+9pLWxhrZCKQlmQi8KEUpo0svHjd9T4AidvPnyt8THDO0vOvvdXDu/sPmN14sk0154ZfdAb4+Nn5nllH+2+Ad54J2YoHNKIarEHh2FyNGy4bMly3COw1cm0v945c9uZdxSp8aLs8X2B1Pobaug4kD3rVFefTmxNoX21YzxPv2gyvWNwfD6GqyDuFOJUpcwc5A1b2QBMgDICvkIe1vzD9oHfq6Ez9T/sP2FCGZR1L6i5Qc1IuU5o6C5+BLN4sCjAabxQlMueEFBNw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1406.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(346002)(366004)(376002)(2906002)(4326008)(86362001)(9686003)(55016002)(71200400001)(83380400001)(5660300002)(8936002)(8676002)(52536014)(316002)(66556008)(66946007)(53546011)(6506007)(76116006)(110136005)(33656002)(54906003)(478600001)(7696005)(26005)(966005)(64756008)(7416002)(66446008)(66476007)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?jiZKUu77EGECIaT/LtlFgnAJMipyARJWhYtSZ0xeKBTuHocg48I870SsgAEd?=
 =?us-ascii?Q?JuiMjkwRArd6ia89ZE70ejtQohr8e/vr2Av1LVD6NBiUZg0gvQGff9BwZFOH?=
 =?us-ascii?Q?OfGZpr3I0jjh4uWP/zgtScuuGGob8IWyT0AlWy3RuR9THPDZsp6/vA49E+zc?=
 =?us-ascii?Q?1VQsb+tYndvV/s7NZ+2GOkYlkOybfNFIGwVvL7EpJTQYwU6e5hk9YV7oQ/Dz?=
 =?us-ascii?Q?BY6c7ZQ9atvZ7Zfu4dDtIHd3bFp94bJzN3sIui7LwdXLtM0YPaeXemgVC70J?=
 =?us-ascii?Q?1GywMmi0bl/9e4Er5b9QbC0nqjQ/l2v2VPild/u6Oy2whWAOtHxBSNJbs2zJ?=
 =?us-ascii?Q?zRJffbbunXoStvxcDodZj5Ew/W3JkHtMtr7dOGb1o342xN2yUhPeHTdbzOE3?=
 =?us-ascii?Q?IWQhRvhmHyt0N0XZvSEHGpfskVxFBxfVDdXvavzN2w/NKarMuHDOFwggQvHA?=
 =?us-ascii?Q?pSotLs+AWiIRZhVUNrXaFECIPic5peOU5Tq8WGjlVjf9NoaX0cxf9U0Ffoga?=
 =?us-ascii?Q?a35qNs+d2HN+XOI12jqXIBTt3uN1UjzfpW+ltyMhTJyGteciuEXzyFzzJviU?=
 =?us-ascii?Q?4L4Bo+sxMK61OUQAaIk2OoBO/tZLdv09GRt6+deywsfHZnU3sSz+5pllKflP?=
 =?us-ascii?Q?wM7sI4548+8rC3OpMUo6ScDMEPA/78fx8uLPsACnluktnzkCghS0vkauzeXt?=
 =?us-ascii?Q?7CVG5fZjtxvqM8d2YxgjHg6WFqsIf48XsG2oP7E1XQ80CIMo0Vf8A9X1Frj0?=
 =?us-ascii?Q?FKMLKEghsSvWq2ExHSF8EXj38VZtXBnNDaTTuOjrBnJ6HJ4ZAH81AHntMhVn?=
 =?us-ascii?Q?Mkf4/MYnBDdHVKoO5zG1dVG4wbLo36Z+K2YtZUgmsP/BWHhkyxT1BEoXKvfw?=
 =?us-ascii?Q?u93ODvmCMXyvfdLGef9KV4Q8KDoPDXerQ7JcDPLXBhz7eCLeBtzEOP9BuwVa?=
 =?us-ascii?Q?tDKQPIw1Sj+xdVdPUw0HvVL13D2wHA8EPUf8dSMoYeA=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1406.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a9560b7-ca78-4110-a96a-08d8c05df7bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2021 11:48:29.1839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UxOEYN+TMH7HNwr+S5z1+KnoL+p0meKAyvxix5zfYUpalYlSw9eL3BWL9cJH7JqfvmZNF6RbTrfOsxqqPoBYa4/MWgAtCh1E62x40xfyWzM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB2015
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Thank you for the review.

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Wednesday, January 20, 2021 11:28 PM
> To: mgross@linux.intel.com
> Cc: markgross@kernel.org; arnd@arndb.de; bp@suse.de;
> damien.lemoal@wdc.com; dragan.cvetic@xilinx.com; corbet@lwn.net;
> leonard.crestez@nxp.com; palmerdabbelt@google.com;
> paul.walmsley@sifive.com; peng.fan@nxp.com; robh+dt@kernel.org;
> shawnguo@kernel.org; jassisinghbrar@gmail.com; linux-
> kernel@vger.kernel.org; Thokala, Srikanth <srikanth.thokala@intel.com>;
> Derek Kiernan <derek.kiernan@xilinx.com>
> Subject: Re: [PATCH v2 09/34] misc: xlink-pcie: lh: Add PCIe EPF driver
> for Local Host
>=20
> On Fri, Jan 08, 2021 at 01:25:35PM -0800, mgross@linux.intel.com wrote:
> > From: Srikanth Thokala <srikanth.thokala@intel.com>
> >
> > Add PCIe EPF driver for local host (lh) to configure BAR's and other
> > HW resources. Underlying PCIe HW controller is a Synopsys DWC PCIe core=
.
> >
> > Cc: Derek Kiernan <derek.kiernan@xilinx.com>
> > Cc: Dragan Cvetic <dragan.cvetic@xilinx.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Reviewed-by: Mark Gross <mgross@linux.intel.com>
> > Signed-off-by: Srikanth Thokala <srikanth.thokala@intel.com>
> > ---
> >  MAINTAINERS                                 |   6 +
> >  drivers/misc/Kconfig                        |   1 +
> >  drivers/misc/Makefile                       |   1 +
> >  drivers/misc/xlink-pcie/Kconfig             |   9 +
> >  drivers/misc/xlink-pcie/Makefile            |   1 +
> >  drivers/misc/xlink-pcie/local_host/Makefile |   2 +
> >  drivers/misc/xlink-pcie/local_host/epf.c    | 413 ++++++++++++++++++++
> >  drivers/misc/xlink-pcie/local_host/epf.h    |  39 ++
> >  drivers/misc/xlink-pcie/local_host/xpcie.h  |  38 ++
>=20
> Why such a deep directory tree?  Why is "local_host" needed?

Xlink-pcie comprises of local host (ARM CPU) and remote host (IA CPU)
variants. It is a transport layer that establishes communication between
them.=20

local_host/ running on ARM CPU is based on PCI Endpoint Framework
remote_host/ running on IA CPU is a PCIe Endpoint driver

As these two variants are architecturally different, we are maintaining
under two directories.

>=20
> Anyway, one thing stood out instantly:
>=20
> > +static int intel_xpcie_check_bar(struct pci_epf *epf,
> > +				 struct pci_epf_bar *epf_bar,
> > +				 enum pci_barno barno,
> > +				 size_t size, u8 reserved_bar)
> > +{
> > +	if (reserved_bar & (1 << barno)) {
> > +		dev_err(&epf->dev, "BAR%d is already reserved\n", barno);
> > +		return -EFAULT;
>=20
> That error is only allowed when you really have a fault from
> reading/writing to/from userspace memory.  Not this type of foolish
> programming error by the caller.

Thanks for pointing out, I will use appropriate error value to return.
=20
> > +	}
> > +
> > +	if (epf_bar->size !=3D 0 && epf_bar->size < size) {
> > +		dev_err(&epf->dev, "BAR%d fixed size is not enough\n", barno);
> > +		return -ENOMEM;
>=20
> Did you really run out of memory or was the parameters sent to you
> incorrect?  -EINVAL is the properly thing here, right?

Sure, I will change to return -EINVAL.

>=20
>=20
>=20
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int intel_xpcie_configure_bar(struct pci_epf *epf,
> > +				     const struct pci_epc_features
> > +					*epc_features)
>=20
> Odd indentation :(

I had to break this as the checkpatch complained about 80-line warning.
I will fix this to have better indentation.

>=20
> > +{
> > +	struct pci_epf_bar *epf_bar;
> > +	bool bar_fixed_64bit;
> > +	int ret, i;
> > +
> > +	for (i =3D BAR_0; i <=3D BAR_5; i++) {
> > +		epf_bar =3D &epf->bar[i];
> > +		bar_fixed_64bit =3D !!(epc_features->bar_fixed_64bit & (1 <<
> i));
> > +		if (bar_fixed_64bit)
> > +			epf_bar->flags |=3D PCI_BASE_ADDRESS_MEM_TYPE_64;
> > +		if (epc_features->bar_fixed_size[i])
> > +			epf_bar->size =3D epc_features->bar_fixed_size[i];
> > +
> > +		if (i =3D=3D BAR_2) {
> > +			ret =3D intel_xpcie_check_bar(epf, epf_bar, BAR_2,
> > +						    BAR2_MIN_SIZE,
> > +						    epc_features->reserved_bar);
> > +			if (ret)
> > +				return ret;
> > +		}
> > +
> > +		if (i =3D=3D BAR_4) {
> > +			ret =3D intel_xpcie_check_bar(epf, epf_bar, BAR_4,
> > +						    BAR4_MIN_SIZE,
> > +						    epc_features->reserved_bar);
> > +			if (ret)
> > +				return ret;
> > +		}
>=20
> Why do you need to check all of this?  Where is the data coming from
> that could be incorrect?

PCI BAR attributes, as inputs, are coming from the PCIe controller driver
through PCIe End Point Framework.  These checks are required to compare the=
=20
configuration this driver is expecting to the configuration coming from
the PCIe controller driver.

FYI, PCIe controller driver for Intel Keem Bay is currently under review:
https://lore.kernel.org/linux-pci/20210122032610.4958-1-srikanth.thokala@in=
tel.com/

Thanks!
Srikanth

>=20
> thanks,
>=20
> greg k-h
