Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEBBD2EFE5A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 08:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbhAIH42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 02:56:28 -0500
Received: from mga17.intel.com ([192.55.52.151]:7240 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725847AbhAIH42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 02:56:28 -0500
IronPort-SDR: IWzWVw6tP+Ix+vh/O0aPMnm5sTi1X6WdDf4Panwz7nCv4p+wBnhTslfk3y2RRHfuTMndI7m47t
 aK4rHhy7NNSw==
X-IronPort-AV: E=McAfee;i="6000,8403,9858"; a="157474023"
X-IronPort-AV: E=Sophos;i="5.79,333,1602572400"; 
   d="scan'208";a="157474023"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2021 23:55:47 -0800
IronPort-SDR: NCk7yNnHA+wJqI0gKM6Tr2R1O99FI0I13MzK1SLpVtaQw2VzR9vxlS2GHL/zhB5Enht3QRM6WJ
 LR3Ig2jZc7Aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,333,1602572400"; 
   d="scan'208";a="351932401"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga008.fm.intel.com with ESMTP; 08 Jan 2021 23:55:47 -0800
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 8 Jan 2021 23:55:46 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 8 Jan 2021 23:55:46 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Fri, 8 Jan 2021 23:55:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DwytuMdjPg0P6CjO4UxtzpmUiJ4wqRWzEmcoul5tYkzDrReA5kGt4NHDIWVTRqPbhrIB0mSiwWAQ3aMlkfJeuD1yrlaGczVj9rhVq1KRz3e5cBF+CWkJ7l3iocMG6xzFaY4CBouA44WPwiyYu/maZwJZWypVwT0WNM+NFuOxZgc1VDKwhbGprfwIneszC0JE4R+03uIGb5jGov4QVBpziZ4IL8gr80ZJ68k3tqWDyE4B6t8rUIjU/Qa0jt2ymEcDtRLyJi6rk1T3SVcb1gsRusG2Keg6e6LYB6/5Krx4eoXCGlqHy4+xOa+x7DJesAZx4Uo2chCKmmDGH71aPjSETQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdOJCPCVHGnqyIIDrnlgSM9fU3JVt/hTIGE7j72Q79M=;
 b=cdbZyTI5jx+NFV0NabREL7E98I4ly2MBOYG3hs//ca9wo2L2S7q/BsH/6nIAuvMcJ7rEliATKvvZfdZKmgk5d7FsakonUCL+LyGPsHWrOxLmTWrqQuah5/hi5hN7hA4DblgRTAcTfimxhXVae/PLJitrTEJO+ML1phrxAnFElXyBAmz9AMYcv7A05D19UNzr7Ks/bpdUxLMBC6svrqAnQNKy+1IKqwpHPHDIEjnFg9vmSlq/NLEkgg8N6xYD8z7bEtCsL8U6dvKKLo1171H1JelspTZEvcD41mXomihnSTbfkjMF1sZMVLWkjXT8kk3V0BXlBaR043gpcADFoD6FQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdOJCPCVHGnqyIIDrnlgSM9fU3JVt/hTIGE7j72Q79M=;
 b=mJcN7kJxWcU9VPrpzy5YGjTRTde6A+boYgWqj6A3+EkRvaoTtWwbCpLzOwEExjhohac49XF/cm4RS9BBZcRC36ge0G1RRymbE5rLjpADyGAvJVUyVJ5AbHVlHEjPtNw5Jc5K2gs4HstQlZRnymTNDJAvMvkHqLQAAnZBQGh3t00=
Received: from SA2PR11MB5018.namprd11.prod.outlook.com (2603:10b6:806:11a::20)
 by SN6PR11MB3280.namprd11.prod.outlook.com (2603:10b6:805:bb::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.8; Sat, 9 Jan
 2021 07:55:45 +0000
Received: from SA2PR11MB5018.namprd11.prod.outlook.com
 ([fe80::95d4:6cec:fd81:5712]) by SA2PR11MB5018.namprd11.prod.outlook.com
 ([fe80::95d4:6cec:fd81:5712%6]) with mapi id 15.20.3742.008; Sat, 9 Jan 2021
 07:55:45 +0000
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
Thread-Index: AQHW4w80G3nX6IgdcUmItLJqTgp06qoclCcAgAJe1fA=
Date:   Sat, 9 Jan 2021 07:55:45 +0000
Message-ID: <SA2PR11MB50188336FD6DED870E6097EDD9AD0@SA2PR11MB5018.namprd11.prod.outlook.com>
References: <20210105025839.23169-1-mike.ximing.chen@intel.com>
 <20210105025839.23169-5-mike.ximing.chen@intel.com>
 <X/dj/NNdF0cy632k@kroah.com>
In-Reply-To: <X/dj/NNdF0cy632k@kroah.com>
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
x-ms-office365-filtering-correlation-id: b4c7800d-481d-4ca4-bb89-08d8b473f835
x-ms-traffictypediagnostic: SN6PR11MB3280:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB3280CCCCEAE0AB4514699A33D9AD0@SN6PR11MB3280.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yFHnqvIsOsdHwrLEBL4yT+DDZ6kuLg121w3Gwkzwgeki79PPoy1fBKvHKOGSsWc12E6YDI8g/VMnl6rzFHL5be+s9mLxxAoBHmDb27w8COAl+/cbXy9LCgtG3UntmUVOTxrgdDXknOoTCm3HB+fXu3QlnlIH9LDrTF31PydF3UCjvIcclmIOMhgY518Vs3xKjLa+967JdFIQq0lzX4j7FcDC2+7N6DRJoqEHsbdMosPjRvUbtIq1WcuHF8XhABSL79YyIcG5uixCgZFXSFz3bTtmeUUjL67wnj1i2hA/+phkO6ZpmwDwk9RLc8FU11LJ9p0pyedBW85YCXPA+ZYytYbL202xHv6tLC+H7VbulHOUVVOclDwkEq2A6OWz0pmt6FzlV3lnxPGCbZmdXX5XrQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5018.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(346002)(376002)(366004)(136003)(66476007)(2906002)(52536014)(8936002)(86362001)(26005)(6916009)(66446008)(4744005)(33656002)(71200400001)(186003)(5660300002)(8676002)(66556008)(76116006)(66946007)(64756008)(4326008)(55016002)(54906003)(316002)(7696005)(9686003)(478600001)(53546011)(6506007)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?7IH66ZPR+KCnLZ31OOI8FEXdFftQK7LF2JEPZAwBjsQT5Ri1jVhiPyc+CVsS?=
 =?us-ascii?Q?XpOx0HwiVkIcqF+IwYONXMg/83Yb1kmghyQE6OzJTe7IwuxNjTH1Am1mBM9I?=
 =?us-ascii?Q?Cay5ie3o4HHQLCeCQlIsMdtPJlCxx//PLghCLk0De3EkjKLd/X3MtdTFVNaF?=
 =?us-ascii?Q?t8P0RHWbUvi5f87AoVPfzoV7ctkduopfZoP9HJcgTUYiRSKBN4M771uLPHW4?=
 =?us-ascii?Q?Nmnqt/bg401ORhO1H1SYJe/KWvTdiEn4dPs9St0jzz/Kxqt2vBpNInv8ATQe?=
 =?us-ascii?Q?/epP+9l39JMI/o8z/LFb4OYz5rY9VIt6BmiLRPS7QzjmJQBJCZSt2SlQTxuG?=
 =?us-ascii?Q?gtVRthCETfLIV+kuiSmjMc7sxNFV1n9sWFqg3ZoQKKgP+6hZqYlY9CQab/0k?=
 =?us-ascii?Q?UB5DHDhINqunLiGODMbGRnjUpLTIV0v2TtKsFT+T8iyyiRq2pjtvrohK+9q9?=
 =?us-ascii?Q?CnQxKhXYsDCFcuhGq+38QKHwYeiCxdLKuAf5vz8m8/3cq/AbPzW+u01B5SDr?=
 =?us-ascii?Q?pn891omSWGtUI5b8xr7f+6TLueXP7+M9b3AOH+UDcvD/srHcvybbFgWhQ9A1?=
 =?us-ascii?Q?wgkNdqIqhK0K5KjlA2XzJsva/SieR6NG7DJo1mDNYDkw1tALFvCdpPSVwTZI?=
 =?us-ascii?Q?dBLbykcY7BeniI6q77z4SwmII9OiiTaybpQTit5A2JZ8ygPs8G8XxOM44S/C?=
 =?us-ascii?Q?tZrED8j2BbXLf4w/DIFfn//kAOl9N/cAG6OsfcIunRcBw9e8iP1/MIiRxX7p?=
 =?us-ascii?Q?cTo3zrOXDtOMHSSJiEh0LbIHJhZAemKnjB/1NMQXFU9gTUBNTbXRR1fWUEMr?=
 =?us-ascii?Q?VNUzCVJhGPVLS29PBoORo04x98M7AgS+x3UuK3ahfpUWPeN32wSIhF89UGmQ?=
 =?us-ascii?Q?kIo4t5XTG17vAfxvg7TA97M25DjdTnUF1GG6nyEDgbXMxr/I3GpZLDcWuept?=
 =?us-ascii?Q?O92DaY5KhwMb0aRWfm6jX4JRqgISgmbCxLbTDdBD4Jg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5018.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4c7800d-481d-4ca4-bb89-08d8b473f835
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2021 07:55:45.0349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gi0SOhyN9Vx1x/1lWydvrOchCE9r7fbdPiJZEbC+6IeBUsCAiH9gE2DWCGQA8gWZjjFi+Se0t61+tb6xI/GCSCfdKOttDp7lYA89VdHoE6k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3280
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Thursday, January 7, 2021 2:42 PM
> To: Chen, Mike Ximing <mike.ximing.chen@intel.com>
> Cc: linux-kernel@vger.kernel.org; arnd@arndb.de; Williams, Dan J
> <dan.j.williams@intel.com>; pierre-louis.bossart@linux.intel.com; Gage Ea=
ds
> <gage.eads@intel.com>
> Subject: Re: [PATCH v8 04/20] dlb: add device ioctl layer and first three=
 ioctls
>=20
> > +/* [7:0]: device revision, [15:8]: device version */
> > +#define DLB_SET_DEVICE_VERSION(ver, rev) (((ver) << 8) | (rev))
> > +
> > +static int
> > +dlb_ioctl_get_device_version(struct dlb *dlb __attribute__((unused)),
>=20
> We don't use __attribute__((unused)) for function variables in Linux.
> Please remove and tell whatever operating system you ported this from to
> get with the times :)
>=20
> thanks,
>=20
> greg k-h

OK. Will remove __attribute__((unused)) in the patch set.

Thanks!

Mike=20
