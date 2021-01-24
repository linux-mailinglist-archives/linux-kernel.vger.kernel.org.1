Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D56F3301E17
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 19:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbhAXSSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 13:18:52 -0500
Received: from mga02.intel.com ([134.134.136.20]:13247 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725863AbhAXSSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 13:18:51 -0500
IronPort-SDR: rkkmhsh1K1u+rF19u+VKgStqMydGo/Kj1PAUKX9CMObRkWKqgQY975p04i63FD22LqlR9IdKzr
 H8y0S5DXlZMQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9874"; a="166730665"
X-IronPort-AV: E=Sophos;i="5.79,371,1602572400"; 
   d="scan'208";a="166730665"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2021 10:18:09 -0800
IronPort-SDR: DoGUHzuWxofCafxhqaYVvblJjpsGpiklY7RtuNxJhI8NCGkWCcSl34uvT9SPqgycvjT6IrhBjz
 vi0sTYdsl5+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,371,1602572400"; 
   d="scan'208";a="401862499"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP; 24 Jan 2021 10:18:09 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Sun, 24 Jan 2021 10:18:09 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 24 Jan 2021 10:18:08 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Sun, 24 Jan 2021 10:18:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UDvLb1jNXIgRUiKWciQ+o83T/otrjl/4wCHXClb3/2gu3teNGWY8NBbITGbEnlfEES4JJpV5tpybd7WwMjLwShOAgGuuhzfa17SPaVz/muyhCd/pNVQnSkuimDMAXJ9leh3zkuWG9E34bD8j6L8cUxQDdzTh93TooWmy84oEBrO0b5i2xdaxQfiiiVDtkHmzBLTkwfxtUVUindaSC7bpY8kgOkwiP6GdQ1oJNhhprv3dDA02vFIWXcHppe2AmNY+ofWwbtUmyqkYHPGRAG/Bpy6hJ7JL7C8DAN/+Tq0420gwQjTiTBNAcI6K7j6b18NaXRE1NE5weCHRkOWuneOqVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ykAxWgI6D6K2AqfJGgtrD8o1TSHMnbGkQJNyBsVspNM=;
 b=hCFrwDn1321yh/fTPLl2UZKjqE312x+eRtnN52Ka3Fy6GHJ0+0Xy9EKZqoUZnYH+ENYm7xjd9QNT4A3b9fs6wu8FhmHfIDutGDLGJIHKe78egD2mzgq/tqo/tNTvCss03jzfe7bEKxiAFG6s3BlvK2X9jiHQ15E2ZILidZCc/dDMeIRVf4v6Y6vcJkbFi2H9eEYD5LtAmayRRgGGA05LEQxKOyVGBYdJ19fcEcthTTogvLPeq1bTqPsVnsEYrS2kC76EVzHBp6EbIYOqMiGxYibXMWLETFus550OJEUnMjmttO3Bv8wsVyv56EdQ3vJ1wqVes+LUx9YSJz3wbSp6xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ykAxWgI6D6K2AqfJGgtrD8o1TSHMnbGkQJNyBsVspNM=;
 b=P9Jx2ETT6w7Le6wr1EtYTVMPRHsLckf/dSEioPBOoP8obFMpx1XeD1Vj124yZLNRkqUTwtsg8ZTckQhyh8ps7wDeIZNEkp7jJjIk3UNu/6vXbOz6+RYTka/bdemuDK3BNyGVqWkDmhP4z2N8b9W93zD4eSMDtIGE4ygz4rguMAU=
Received: from MWHPR11MB1406.namprd11.prod.outlook.com (2603:10b6:300:23::18)
 by CO1PR11MB5108.namprd11.prod.outlook.com (2603:10b6:303:92::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Sun, 24 Jan
 2021 18:18:06 +0000
Received: from MWHPR11MB1406.namprd11.prod.outlook.com
 ([fe80::89f0:cbc3:d9c2:6e7a]) by MWHPR11MB1406.namprd11.prod.outlook.com
 ([fe80::89f0:cbc3:d9c2:6e7a%7]) with mapi id 15.20.3784.017; Sun, 24 Jan 2021
 18:18:06 +0000
From:   "Thokala, Srikanth" <srikanth.thokala@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
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
Thread-Index: AQHW5gUs6vFsn5nCsUuTx5ZeA9F45qow34mAgAIzIbCAA7E3AIAAahWQ
Date:   Sun, 24 Jan 2021 18:18:06 +0000
Message-ID: <MWHPR11MB140692C814867EC209F14E0185BE9@MWHPR11MB1406.namprd11.prod.outlook.com>
References: <20210108212600.36850-1-mgross@linux.intel.com>
 <20210108212600.36850-10-mgross@linux.intel.com> <YAhvJ2MxqnX2g0nS@kroah.com>
 <MWHPR11MB14061D584C7CC0CE3AD58F1A85BE9@MWHPR11MB1406.namprd11.prod.outlook.com>
 <YA1gclRd4HRNrmhM@kroah.com>
In-Reply-To: <YA1gclRd4HRNrmhM@kroah.com>
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
x-ms-office365-filtering-correlation-id: 8aabbd08-f575-451e-a8a3-08d8c09465b8
x-ms-traffictypediagnostic: CO1PR11MB5108:
x-microsoft-antispam-prvs: <CO1PR11MB510899CA697DF21570B7BB4685BE9@CO1PR11MB5108.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8STo7bOwgeNqJlcO3gaHMbEvrRqxJW6XfiX37g2thRzlic3BpKP8rs6pR8eg7QCz2vwve6O+a1k/+0Xgq8zNL4oPXlrt10xQsuM/eXP0mAoNUkSfpISpJYsPp4b92uu/DNyMaRov8Q96p9vgAOYUGEYkKD3Sqn0+s1Aok2I7ugeXEz+XgmQ/h2+VI3AEK/2EcNr6zDACtlGxTPtVqQGn2YNCBOG5AFwkmDttySRjr1W4j+tEdNIBAaDVTaDOt5vv/hgS9wiacX/UCmTtY1bCfchsURzu9GKoc6Pal0Kq9JTlzcJx02lg/ACGJC4U60ZV7dDmFK6UlREeAa15S653oFhyebuwYP9jugAg5nLQ7kEQQVd5g8POb8GLVMf2qT7IEm+MlG3rEYktkpkw3MHV2g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1406.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(376002)(396003)(39860400002)(71200400001)(7696005)(4326008)(478600001)(316002)(8676002)(33656002)(186003)(55016002)(26005)(5660300002)(66946007)(6916009)(53546011)(7416002)(6506007)(66446008)(52536014)(66556008)(9686003)(66476007)(8936002)(83380400001)(2906002)(54906003)(64756008)(76116006)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?yNNka0exEF9WlL93iKlazYewe88BFPfxO1V2ZAEn5lFhqRs1sYe6RolvRqiL?=
 =?us-ascii?Q?GW+tPyg1w/y0FIfwO1AZ8GzX+vMwZ1J7Eyf1V2mMPsY/+g06wspqT2uIr0d6?=
 =?us-ascii?Q?h+PrvRdQiKT751RTaDiDU9iOSYn2BEDYxg82nIV4KmDvc34NOI0ClTNggXAE?=
 =?us-ascii?Q?E2hw161TYICbCzlbiIELM9LhKpwouA2G5OQlXIoCL41nbLkCjqybpa8DNCRn?=
 =?us-ascii?Q?UYcW0uCG0pO2HMmmasXEm+9Ap7w9iwfhDSDtoWShTDDEDlpPJT/oZjgU8O/9?=
 =?us-ascii?Q?uaBSySQcrr2DXw0ag3mKVsdVnJIATL1mC8xZrlB7x0ddbvg3mDZzCsUoTxyT?=
 =?us-ascii?Q?C5uQ+FmewcfEhGfCT28PGfdmItQqhs5t16JAYmlnJeISsBnAzWEAPHq4vaGu?=
 =?us-ascii?Q?yK2CIKAK9kMoXiC1Ssa29lM396LjRUTbsmz0jlPJzw00+v/ekFhYtTU3oMb3?=
 =?us-ascii?Q?H/NkqQfGZS5cWDPqQQLN6mniTgG30qMm8yg1tY1gPDf8zdwk4XEgEm6o/aHG?=
 =?us-ascii?Q?JmMTlzwx5lJYkMnqFyuYVKpwuFp8WgG+Uk472zW1HevZCPjt1HA5p0lkK4yr?=
 =?us-ascii?Q?wUz4ZmStyKlA9KRyV9ujQ+tbdpDHuOxE7Yy/Xc7e+WGT9NrS9ll50lREfo7s?=
 =?us-ascii?Q?qrxsZLBmyHrFhnn17hx0hftVn1IldkRZ8fdjmM3742CM/q2/urb4M6VgXPUH?=
 =?us-ascii?Q?WLrlUqiA7Rot8YiB4MLdSz7SrrxuAyHeB27/pVy3IejrSxeBzvBCO0reiRZt?=
 =?us-ascii?Q?oJI2BaHUc3WxI2qtVe/8yV1mWegPlkVg1319CY6fR3ygehxaoQMVfRYbXOk4?=
 =?us-ascii?Q?Qm0TiCCV9Hu5UeCqaLmOMiooZE3eV/HhTdoJaLq28nUgGlGRtfohmj5FmRC1?=
 =?us-ascii?Q?252Ez2M4C/2DPtaUbUT3CjeVGiwepWzsMZJhXZm4LKLvoo1p78DJadYtyERu?=
 =?us-ascii?Q?f2jarNrk1ZbJ+cgCjhidVlrO1eWziqxnu8S2O42yTQM=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1406.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aabbd08-f575-451e-a8a3-08d8c09465b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2021 18:18:06.5179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h8SoHYwntC5beOQuUqarGvfiQljNLY+Xj/cL5nua31zMU0uN+Wvbj07KpvWjdPzDqjg77PmVFPpHb9yaihVHX+c9DGLaSS9X5dkMRpC+cso=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5108
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Sunday, January 24, 2021 5:27 PM
> To: Thokala, Srikanth <srikanth.thokala@intel.com>
> Cc: mgross@linux.intel.com; markgross@kernel.org; arnd@arndb.de;
> bp@suse.de; damien.lemoal@wdc.com; dragan.cvetic@xilinx.com;
> corbet@lwn.net; leonard.crestez@nxp.com; palmerdabbelt@google.com;
> paul.walmsley@sifive.com; peng.fan@nxp.com; robh+dt@kernel.org;
> shawnguo@kernel.org; jassisinghbrar@gmail.com; linux-
> kernel@vger.kernel.org; Derek Kiernan <derek.kiernan@xilinx.com>
> Subject: Re: [PATCH v2 09/34] misc: xlink-pcie: lh: Add PCIe EPF driver
> for Local Host
>=20
> On Sun, Jan 24, 2021 at 11:48:29AM +0000, Thokala, Srikanth wrote:
> > > > +{
> > > > +	struct pci_epf_bar *epf_bar;
> > > > +	bool bar_fixed_64bit;
> > > > +	int ret, i;
> > > > +
> > > > +	for (i =3D BAR_0; i <=3D BAR_5; i++) {
> > > > +		epf_bar =3D &epf->bar[i];
> > > > +		bar_fixed_64bit =3D !!(epc_features->bar_fixed_64bit & (1
> <<
> > > i));
> > > > +		if (bar_fixed_64bit)
> > > > +			epf_bar->flags |=3D PCI_BASE_ADDRESS_MEM_TYPE_64;
> > > > +		if (epc_features->bar_fixed_size[i])
> > > > +			epf_bar->size =3D epc_features->bar_fixed_size[i];
> > > > +
> > > > +		if (i =3D=3D BAR_2) {
> > > > +			ret =3D intel_xpcie_check_bar(epf, epf_bar, BAR_2,
> > > > +						    BAR2_MIN_SIZE,
> > > > +						    epc_features->reserved_bar);
> > > > +			if (ret)
> > > > +				return ret;
> > > > +		}
> > > > +
> > > > +		if (i =3D=3D BAR_4) {
> > > > +			ret =3D intel_xpcie_check_bar(epf, epf_bar, BAR_4,
> > > > +						    BAR4_MIN_SIZE,
> > > > +						    epc_features->reserved_bar);
> > > > +			if (ret)
> > > > +				return ret;
> > > > +		}
> > >
> > > Why do you need to check all of this?  Where is the data coming from
> > > that could be incorrect?
> >
> > PCI BAR attributes, as inputs, are coming from the PCIe controller
> driver
> > through PCIe End Point Framework.  These checks are required to compare
> the
> > configuration this driver is expecting to the configuration coming from
> > the PCIe controller driver.
>=20
> So why do you not trust that information coming from the caller?
> Shouldn't it always be correct as it already is validated by that
> in-kernel caller?  Don't check for things you don't have to check for
> because you control the code that calls this stuff.

Sure, I agree to your point.
I will fix it in my next version.

Thanks!
Srikanth

>=20
> thanks,
>=20
> greg k-h
