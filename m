Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 105EB2FD971
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 20:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392156AbhATTUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 14:20:42 -0500
Received: from mga09.intel.com ([134.134.136.24]:6736 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390794AbhATTUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 14:20:00 -0500
IronPort-SDR: Xl3tBbgq2jYPC5DJfw72/jq04yzoERM42jKBg56KnKiiRp6KVxQVYF7Y3mFQJ9YMDOeGr/Ajnd
 c6Opfz4mO9iA==
X-IronPort-AV: E=McAfee;i="6000,8403,9870"; a="179315337"
X-IronPort-AV: E=Sophos;i="5.79,361,1602572400"; 
   d="scan'208";a="179315337"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2021 11:19:14 -0800
IronPort-SDR: DCDblG0fvbFlCXKkDyiu6P2Stwm+aivgtqF7weg1iWd1SEqgv+DURVr3uoF53pWhAalWGAacVB
 TwclZUn5vzuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,361,1602572400"; 
   d="scan'208";a="384979664"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 20 Jan 2021 11:19:13 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 20 Jan 2021 11:19:13 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 20 Jan 2021 11:19:13 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 20 Jan 2021 11:19:13 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 20 Jan 2021 11:19:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TutILTcxKO6/N9T2uShyaSFhBf06y1hRb3M30nkBBezYX3at/Eyh0g0JQdfVhfBvcD6Na+P6JE8OKRrJRU8+WtstYFauyzJPxYp6xzrri2LNRcD03z2CPcFmlaIBo2MBo+jcTNmnPqTGfwScRFxQkvINPoxcZjqPaTqUbn3w9nXajZtrDqYamF5oVX7sJ5DXKEwaDfU3yRygDhMrfenY8dyRJ6dT450QttM/pRzzGhgkBLUHeZTvIeV8yS7hLohrn11137zITEkmqAN5fDDkRkHDzxDd9tZweNAspDfLDUwK0LT/8NnXC/ZoQu1gUL8EBN55VvWzXsU5eeOaBcm2Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jm8hPAEUV4nUJ8KNptn78eWh5KSZRaZbnDamM19xYl4=;
 b=FYdGEPPZNzParBc3wWU5NoRi3rZW6NNpnmAxwDwLtFxp7gxEScLua6XvQd06KZ24QW109OP3iX9anMmw9/koMXeCgTyCuTacMxf5Aix+fBP5zjflU94YizCZ34pukou9GYK+iyYWN1pT4DKkL7fN2bEB33lFcKGdmRA7wFn6euxK4iwPjVIzoOQ6lAgrA/b1XliCk+YaeXfAr2vloBCdWXjQmI4Q6pWaDhg80fk17BEI/LDDDn+X7y86EtNJu9u5L305kzLml/l5+s07PMgw48gUmU6RGyk8Lxprh9IPSuzsJBPNOVSUyynempTxeSyVpFPrHZDctepU83e0N0VLEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jm8hPAEUV4nUJ8KNptn78eWh5KSZRaZbnDamM19xYl4=;
 b=zGSxE7FHWBYk0O6KrakwQWy+AnmREjE6EyAKdmMUXlmUBuDP0H88wheESydCrv7cT72GQgJUrLmhB6xg+Yog4pphoNwInBOByW8aCnPt0gpdykufXKHphNPS5VS2WZFADdIZTiJDQdNu0UZ5Rc+vTbbY9l37ryECihICaYc7//Q=
Received: from DM6PR11MB4250.namprd11.prod.outlook.com (2603:10b6:5:1df::18)
 by DM5PR11MB0009.namprd11.prod.outlook.com (2603:10b6:4:69::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Wed, 20 Jan
 2021 19:18:59 +0000
Received: from DM6PR11MB4250.namprd11.prod.outlook.com
 ([fe80::6da6:c2ee:aa4a:d21f]) by DM6PR11MB4250.namprd11.prod.outlook.com
 ([fe80::6da6:c2ee:aa4a:d21f%5]) with mapi id 15.20.3763.014; Wed, 20 Jan 2021
 19:18:59 +0000
From:   "Ayyathurai, Vijayakannan" <vijayakannan.ayyathurai@intel.com>
To:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
CC:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Seow, Chen Yong" <chen.yong.seow@intel.com>
Subject: RE: [PATCH v2 2/2] clocksource: Add Intel Keem Bay Timer Support
Thread-Topic: [PATCH v2 2/2] clocksource: Add Intel Keem Bay Timer Support
Thread-Index: AQHW3m7asVhecswsxk6nGZbrzXIbyqotqAuAgACyd4CAAGj/AIACPqnQ
Date:   Wed, 20 Jan 2021 19:18:59 +0000
Message-ID: <DM6PR11MB42506E32832BC24B900B40C8FBA20@DM6PR11MB4250.namprd11.prod.outlook.com>
References: <cover.1609306622.git.vijayakannan.ayyathurai@intel.com>
 <2a7038bc170e31a668995c367bbae018bf805dbe.1609306622.git.vijayakannan.ayyathurai@intel.com>
 <73330c8b-4633-4a13-b4b5-7405ff1661fe@linaro.org>
 <DM6PR11MB4250EB33E23178D211D0411DFBA30@DM6PR11MB4250.namprd11.prod.outlook.com>
 <20210119085050.GM4077@smile.fi.intel.com>
In-Reply-To: <20210119085050.GM4077@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [42.106.178.118]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cde5bee5-c025-442d-cc1f-08d8bd783d3b
x-ms-traffictypediagnostic: DM5PR11MB0009:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB0009A655074E72AFEF7B4F5EFBA20@DM5PR11MB0009.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RlvCG1bAEcAt/C4NzskkZ40IzSj5mN366M0VpAOJhJpskEl0vdTJKKUumBV+iFny2HD6fml6H5FP7MkrrJJKComMbpOeJtyUZV0JXjk11squyCftVEs5806OzOA6m3YL17+5hDj2LEKQt+Ruw8zLb5HS/bl1vazsfuh9c56TxrU4PIr/6q/mPcOkAGAUTz1ylitclpTM5Nuq60MUAO3801iOwZI/dQFfZJDIrN9gYZONpiyOrgkHsx/8M6ukIYsJIyD+RX8IKdNdYEgLbumGM/a622M29uMweCJBRj2BuLLW8cGYuPZeTUx3kZG0ry++NBsZ6FfB7mqTx+s/tIrY13vs+X+1iqsdX0HcKnNRq1qO9gk6EFdEX8vNRpS0lUzXL3SuWtKcq27AotDN4otQHg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4250.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(86362001)(52536014)(6506007)(66446008)(66556008)(71200400001)(64756008)(316002)(6916009)(8936002)(66946007)(9686003)(8676002)(66476007)(33656002)(5660300002)(2906002)(478600001)(54906003)(4326008)(83380400001)(4744005)(186003)(26005)(76116006)(55016002)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?aWEeGk0nLxIMdVYD8M+2JGpm8Q4I5EDtHsxBOxPEPBey5YjLhMTI2kKHq/jc?=
 =?us-ascii?Q?DmO4kJJ8kdutv79nN2SJxHoOFirQGqOWcqLWCkKs3F43PzzsSSraE7TuB+ry?=
 =?us-ascii?Q?ZAd/Z+bg8oor4Wnq1OMQY7Jx6mfy6ix1NglAmpQ+q8dIpUuG3FFG2HJ8pFog?=
 =?us-ascii?Q?HE4RDin4j3EtEZEn0/cqO/a3jsIrq8nUf0LJfSCPjU3b8WvBemdmMBYezAxd?=
 =?us-ascii?Q?Bo5Smkp6j/2hWvKkD0xAW8eEDCiHpo8rVdb6PkkiZyK0fCvO182sLfosczqA?=
 =?us-ascii?Q?rs0cscZDpNdam7K/+utMVBrHSiITa6hYGZjHlXoSVP8kP7flWY5QsfX2y/E+?=
 =?us-ascii?Q?1zxHv/kUxjtE/PTYCGqhpwMXDQgoZIs1s3qQ/JfsBwJQf0bGBp7Nq9xyL2nP?=
 =?us-ascii?Q?K4bYI9yHSah2rlPrOZGJ/DVqvqujyyfZi52ZL5l0S3qK9+8aDluB/hWfF3wL?=
 =?us-ascii?Q?IhUfFVRx/pj3evqDyFanRCoDHY7iHB7r5ZM9zPKwp5b1gy2wbrll6/bzlR6N?=
 =?us-ascii?Q?8Z6hpQa4Esw5TR7eThtXJZ/rJLTZ5ZknU9c8FdYXvUFc9JmMJ0/6tZ54EDOT?=
 =?us-ascii?Q?KcXU5208EfktOw6/NtIiTYJpiAUL5Sg+0xwuimOyY+wp+oTioJxNic7IP383?=
 =?us-ascii?Q?+CkqCcbOdjK6FJXpxDFeWIsA6pZUJEIGTaWxGIXqSvW7my9FEXcmeRz/VtXr?=
 =?us-ascii?Q?tnfPdSIJqHa9iHn+qgV2UDI0bYf6/I243kqkGGOnwIobJYFAElkpoFzO2HsJ?=
 =?us-ascii?Q?gMd8emo1cJ1Sk91wkD7a5UC1mFu26/Bm99/KANzx3IOLM5oB3+bRqnFFkQPq?=
 =?us-ascii?Q?Lgju92DmX7dbKGQTJloiKC6xeCJZDzwpwh3lT8YSkNPA5e9ztuQgVZBkm5mv?=
 =?us-ascii?Q?dWFkU0nahyvc4GQGEw+v4Rq9pxPwsWS3m45gq98vwkGYPKeDcJGMflEJIBSF?=
 =?us-ascii?Q?h4DIqSEl5ZtYrXI+id+4c06IobMklT/GACF43GbSoXw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4250.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cde5bee5-c025-442d-cc1f-08d8bd783d3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2021 19:18:59.2810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GevmI6h7ffKm3R86JsVlKzVrfsoujlCa1RB6+BRw2IofFG2aCpwAqsablsosmmBadIZQqH27l9buUk8Xe680tZp/2OAGU2IWrHbAFHv3PlLMpJ+4L+ClcCVAMMgq0WRO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB0009
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

> From: andriy.shevchenko@linux.intel.com
>=20
> > > > +	data.base =3D of_iomap(np, 2);
> > > > +	if (!data.base)
> > > > +		return -ENXIO;
> > > > +
> > > > +	ret =3D keembay_clocksource_init(np, &data);
> > > > +	if (ret)
> > > > +		goto exit;
> > > > +
> > > > +	ret =3D keembay_clockevent_init(np, &data);
> > >
> > > Is this missing ?
> > >
> >
> > Yes. Either case it goes to the exit path. So I thought of avoiding thi=
s error
> handling code.
>=20
> The point is that in success you probably won't call keembay_timer_cleanu=
p().
>=20

Yes. You are right, if I use this error handling code.

> > > 	if (ret)
> > > 		goto exit;
> > >
> > > 	return 0;
> > >
> > > > +exit:
> > > > +	keembay_timer_cleanup(np, &data);
> > > > +
> > > > +	return ret;
> > > > +}
>=20
Thanks,
Vijay
