Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5582F08B6
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 18:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbhAJRXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 12:23:16 -0500
Received: from mga14.intel.com ([192.55.52.115]:2895 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726228AbhAJRXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 12:23:15 -0500
IronPort-SDR: 0qt1cDYIdK3sbvmQza598FykmCVbJxM0w6Qbv3kt+YALDD5xWA3/9kcwVgMNa2jRNIfOBN71hp
 Kocjr7YMtwiw==
X-IronPort-AV: E=McAfee;i="6000,8403,9860"; a="176992875"
X-IronPort-AV: E=Sophos;i="5.79,336,1602572400"; 
   d="scan'208";a="176992875"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2021 09:22:34 -0800
IronPort-SDR: Zp///lTGph+mZNIzoTZA8d78SxbDa5siDNh+0CYoXQB8DXs0S/fho4dDtUnniMigeQt49Fig/n
 wxivcfJDVStw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,336,1602572400"; 
   d="scan'208";a="399562013"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 10 Jan 2021 09:22:34 -0800
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 10 Jan 2021 09:22:33 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 10 Jan 2021 09:22:33 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Sun, 10 Jan 2021 09:22:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kt2aUeELlC4V5w+jyvvrjOzlauXgtie6IvJd/6zxn5RmYKM3yJXkElTJswxQ3yvwJEj1Bi6OtZBj7upwC+lfksabn87hbspnSVFZnjrIGDzqfycR1inW0HINtFitijWMW+BbUGqSCxPIQinW1p425X2wlyDSNbOdEUfqF8bg/RtbLVNjOe+mr4Lj2cllN/Yig9JuJ3NB0oAHTK48B9p8E0DMfoBKn8ySVP6Xqr3Hfai/PYkivikGhv+ye0Tcim8lmCIbb78YcZnARNonSkdSD/buwJmTTsxsqCYBHgSUplyTu7R5C50GQ6XbXwhxj6kMSjTKBCLiuqz3a3kjcQpm2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZekni9kiCrE76gR8RIC3PZLXALNSNi2F2LqA8ZdLZ8=;
 b=Ua5VHa7NGj1NwZQXafVZWhZ/XoJguiyvSjHlIIGbqbRm6VLvbVT81EP3UymX9jGm0PDTcVhG672P09fkFm9ag9qdyGBWLq65UE1S7q6enYvz4VczU78LhpYiHlo6QpY7d8ptmCL+dvKRbRYWLLIA+5SmZvqth+6cjvKCIH9H5gJR3S+2YmQzKdqH8avZNB5gNn9iYGIxzeFncEfU88Jo305PoqgqCk1clHHyZwC/R8xvjCVKG3/ctUvmvIFi7XY/jz+bqsn4yt7/vGRr5wM3XXn66F/LUdHKFynV3QKkjuv7wNBCXgPsOl8E3E2nnXgi4rjBy5I4+uyMupj6r41H7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZekni9kiCrE76gR8RIC3PZLXALNSNi2F2LqA8ZdLZ8=;
 b=W2eQeyN6IRlJN+fLVKQ+vgJt3jdgUHFR9mrUtCyPLwuSd1U+6+HNg9pcLG3ueDgbRCa5WYjVEkbj0/JSec14utOjS2aP8v5oo96HoKYv/ixenheHPTP3ORrxNlP+H3eZqpGYDH9MfD3HTzs20tSMiUMhSxN2hs0lVicRqCEvquc=
Received: from SA2PR11MB5018.namprd11.prod.outlook.com (2603:10b6:806:11a::20)
 by SN6PR11MB3230.namprd11.prod.outlook.com (2603:10b6:805:b8::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Sun, 10 Jan
 2021 17:22:32 +0000
Received: from SA2PR11MB5018.namprd11.prod.outlook.com
 ([fe80::95d4:6cec:fd81:5712]) by SA2PR11MB5018.namprd11.prod.outlook.com
 ([fe80::95d4:6cec:fd81:5712%6]) with mapi id 15.20.3742.012; Sun, 10 Jan 2021
 17:22:32 +0000
From:   "Chen, Mike Ximing" <mike.ximing.chen@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>
Subject: RE: [PATCH v8 03/20] dlb: add resource and device initialization
Thread-Topic: [PATCH v8 03/20] dlb: add resource and device initialization
Thread-Index: AQHW4w7I7403thdBpUePoKfbt2GH26ock8QAgASJHIA=
Date:   Sun, 10 Jan 2021 17:22:32 +0000
Message-ID: <SA2PR11MB5018D896774B86B57354D32ED9AC0@SA2PR11MB5018.namprd11.prod.outlook.com>
References: <20210105025839.23169-1-mike.ximing.chen@intel.com>
 <20210105025839.23169-4-mike.ximing.chen@intel.com>
 <X/djqGBzpYg+B6dF@kroah.com>
In-Reply-To: <X/djqGBzpYg+B6dF@kroah.com>
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
x-ms-office365-filtering-correlation-id: c5a471a6-d34b-48e4-f797-08d8b58c5077
x-ms-traffictypediagnostic: SN6PR11MB3230:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB32308161A8DCF6DB1F5AAEC4D9AC0@SN6PR11MB3230.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O32SlTvSq5IHtug9TciLLoXk64es697o2S2rhaJI4J08vNqU82rM5B97ayKlWPLR14fxjOiPjfK9jZJjAi41OC1kHcbJuCv/NAFPTIsKVkV+Icr3dsULZNEEwoXkmEI64D8a5pp2y4DDPylq48dVAnCEiMs3zz+Sbcy/Pq7hkyfsAq6RTvUe6zK/bZnNOU25uv/hHC621WIvoU9u0r8MOOOMFmRtsWioG+oxaQGNmbGaX1EEIt5JEHj2dnwsw4Tp/SDsgR8Bf5fqBT0c8m0XR2R6hWfy4iUrGbhuYgenSi2TWA3jWZNl6SrsyvjJTSv+GyervnT3ZbemB+H4gkQk/dsbzHCpQoXvW88JUrInTZ5QljRBCA0FtaMIUhpg4k936zmOsFQhUfCy/Puix4In6g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5018.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(39860400002)(366004)(346002)(376002)(71200400001)(4326008)(83380400001)(7696005)(76116006)(8676002)(6506007)(53546011)(55016002)(64756008)(2906002)(9686003)(316002)(66476007)(478600001)(54906003)(52536014)(6916009)(66556008)(8936002)(66446008)(26005)(66946007)(86362001)(5660300002)(186003)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?STVUh9AxVIzMfimPubBq40iytHvSjH7lAAM7mWw0Tl+Vo0QcWnUw0sIZ4Hz/?=
 =?us-ascii?Q?e4gEYOh8p6FeBG3Y2oZFyIO+ozz7dCQyAgN1J5lrEFmIpMe8tfvaNznJGVfs?=
 =?us-ascii?Q?0iF5ronsa5SXY7bFX50JYM5+HxIQQqEiddIPPAllbl8K0oUPMxbeN2nsfy61?=
 =?us-ascii?Q?bQjoGAsGCG52JnY0/mdVGuSRBfQL4mXYmFDtIkA/hnwjzMMoi9kL8EJ9FNd8?=
 =?us-ascii?Q?1Uj2nGzQi15HjZMUzcfe4oy45XcC09HINR3wUT7w5YVS4sPsxL85cESjwdHY?=
 =?us-ascii?Q?1idEZA5p5R9xURY6/lsqfBrouAYF+QEzPKSCdfHd1BNaRAAl/ocls6Uz9Djs?=
 =?us-ascii?Q?VC52fNE5/OfFSgI9L9MaXz7aCyoMz5N2kC2TFnRqduINhOtKB82uCdJqmoUv?=
 =?us-ascii?Q?tZ6s8aO1NjXocioWPIrJelZf27JO37cLk5o31H7Hgt8VOVTaM/ZJ8FLmoo9V?=
 =?us-ascii?Q?mjFZvaMBNFHX17RB4wq/3U4pVX6XjQakA8SBpv/yoJzF/WGjWgDjvYATCeS/?=
 =?us-ascii?Q?Ph53G4TAAxySINFwA3k9aUDbHN2ytUOyRa2UG+b370lWlrzGhjK57BG0OzAk?=
 =?us-ascii?Q?xG/Z6byKDgme9cVPXWjBZ6puNQ+k2u+DzN3fQG+RxGETlfbAmohnt/1dA2Rz?=
 =?us-ascii?Q?gnGiRLBT6a0esBLStxdcyZb2fUVXQKwRNuUrwEuBbXbqMr0eK8sxbPd/EXKZ?=
 =?us-ascii?Q?VZf0YhQ4/dcAEYk9hkQaHeKeY+byxoouC/CcIW3IBg3Mef57xcixwrgd3R8r?=
 =?us-ascii?Q?i0zn2MIf29JCHFu9ZOoWODqaEypXj37YqfCOnaoiXNBECicx96dbjg0Si7DW?=
 =?us-ascii?Q?WFxyWRmhUyyUtBDlDLVixxQUGehJqlFOn97AwxgJR2uo1DJyCLrej02JwRC+?=
 =?us-ascii?Q?JEpThTe47xggjknS5ygZSZf830Q8WJ3DKKklQ1LyHU8l40r8JqBFlf0TnpLP?=
 =?us-ascii?Q?Lm4PB4Xapdu5eEGJWtJgT9q2PECkwNHEs5WBQap8xog=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5018.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5a471a6-d34b-48e4-f797-08d8b58c5077
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2021 17:22:32.1729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +7IbBQcNVcMrqkPGRjPH3V3+WE9CnLa4a//ydZCmXkQq92U7Nea9oQl2V2h3+5ENaZiSFfoMMgJu6WQTASZrDLO5sZxj0BR8b0z/4ZP2K/c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3230
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Thursday, January 7, 2021 2:40 PM
> To: Chen, Mike Ximing <mike.ximing.chen@intel.com>
> Cc: linux-kernel@vger.kernel.org; arnd@arndb.de; Williams, Dan J
> <dan.j.williams@intel.com>; pierre-louis.bossart@linux.intel.com; Gage Ea=
ds
> <gage.eads@intel.com>
> Subject: Re: [PATCH v8 03/20] dlb: add resource and device initialization
>=20
> On Mon, Jan 04, 2021 at 08:58:22PM -0600, Mike Ximing Chen wrote:
> > Introduce dlb_bitmap_* functions, a thin convenience layer wrapping the
> > Linux bitmap interfaces, used by the bitmaps in the dlb hardware types.
>=20
> No, you created custom #defines:
>=20
> > --- a/drivers/misc/dlb/dlb_hw_types.h
> > +++ b/drivers/misc/dlb/dlb_hw_types.h
> > @@ -5,6 +5,15 @@
> >  #define __DLB_HW_TYPES_H
> >
> >  #include <linux/io.h>
> > +#include <linux/types.h>
> > +
> > +#include "dlb_bitmap.h"
> > +
> > +#define BITS_SET(x, val, mask)	(x =3D ((x) & ~(mask))     \
> > +				 | (((val) << (mask##_LOC)) & (mask)))
> > +#define BITS_CLR(x, mask)	((x) &=3D ~(mask))
> > +#define BIT_SET(x, mask)        ((x) |=3D (mask))
> > +#define BITS_GET(x, mask)       (((x) & (mask)) >> (mask##_LOC))
>=20
> We have functions for this, use them, don't create custom macros for
> them.  Use the Linux functions please.
>=20
> thanks,
>=20
> greg k-h

FIELD_GET(_mask, _val) and FIELD_PREP(_mask, _val) in include/linux/bitfiel=
d.h are similar to our BITS_GET() and BITS_SET().  However in our case, mas=
k##_LOC is a known constant defined in dlb_regs.h.  So we don't need to use=
 _buildin_ffs(mask) to calculate the location of mask as FIELD_GET() and FI=
ELD_PREP() do.  We can still use FIELD_GET and FIELD_PREP, but our macros a=
re a little more efficient. Would it be OK to use them?=20

Thanks
Mike
