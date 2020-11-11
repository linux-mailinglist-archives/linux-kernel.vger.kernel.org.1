Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 074102AEDBA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 10:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgKKJ3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 04:29:04 -0500
Received: from mga01.intel.com ([192.55.52.88]:10094 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727231AbgKKJ2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 04:28:51 -0500
IronPort-SDR: SG79gvJ14/Zs5Im2foxKjfFR3QvOBbg6f1o0sfXzHegDaC9x5GQCUBCqgEQsJtzP0zdBzHTtrk
 Ea1kGB2A2Dzg==
X-IronPort-AV: E=McAfee;i="6000,8403,9801"; a="188099843"
X-IronPort-AV: E=Sophos;i="5.77,469,1596524400"; 
   d="scan'208";a="188099843"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2020 01:28:35 -0800
IronPort-SDR: D8iuSY2F0iftj79smsokn/HpPR3yKhOHNBWykvdqmtaZGvMvEnGbC1Sz2+AkG3sFNbMzSyMk6N
 DFmklwQxRe5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,469,1596524400"; 
   d="scan'208";a="473793760"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga004.jf.intel.com with ESMTP; 11 Nov 2020 01:28:35 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 11 Nov 2020 01:28:35 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 11 Nov 2020 01:28:35 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 11 Nov 2020 01:28:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J6lSgGgj+3GBUN77KZDwm7CmQeVmQ1/m4H8OUTCEgzYxLbSNTDzBl3k/D+6DwQAWs6UQ5Rz1RMLDBppAspsqDNZyzTfPIxCGhuojvq7dJMwVNpNMeOZMbQCymkLrBpuYPekCAxZykPK8g3FnFCiYwW2jPmplLmOVD3/7aSb9oAzwnIy5SQp1qVH5JaykoIZB4r38bCuBDoolr4Z3HGLYmNo3IFVez1aDVBzI69ATKpTmm98WnmQs2/TlNyAs52CMmL1NHVnpbeRN26mSWee99YsGwOqwiq9jKgNkcXv1mt3Teeuno9eTVtFTxM6MyD5SgXIC0rbj4fF86HRUhGJT+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXbWt+lyirFMOIDYd5WgYi9+IQUc4j1/BIKG97+AyPE=;
 b=V/H4Sk41gYrCM5+/Drgz2Z+k5uBXwF+vjZHIwi1SPhS4LBhpIrEwPUCHdEJs1+4Qdy2iuPX05DmlKkuZU3vBZDb/H8BYpNxX4wSMQngxpCHO2hbP5K5Ar6bHJvilFfNzKzGzQzotTiiaTMYtDZn5aSWnloPJwe/oS+zYhKotOR5XiJjIvuOVVIyfuQv1U42y+lLL+xq6T9Bx5Ms6EKam8a3Pr/schsRFrqVWXhuwZPmFidn9ZtSvyN7M3nqR7qttOebIOY8c++K+ZYzp6OaOoW21XAOTrAWtW0l5lJ1Dl4tykC9tU3156KDtJW7SJShm601juxVJvsv1khaIjxdq+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXbWt+lyirFMOIDYd5WgYi9+IQUc4j1/BIKG97+AyPE=;
 b=zi6SodlLSUssrhPXwMBalH79K07/8nwVB7CPsrhK05qjbIXClTRwaWXWuu58MD0g1GBTo51b4IVxVETRgQ6H+JrhgyV1zYSAQNPVptFMQaezJbIqMphEUQi+osIMB3oFZfFGvE7/ogDrjMvIn0nd3a/FSJ8ohNuyJgVS0fgqj5g=
Received: from DM6PR11MB3721.namprd11.prod.outlook.com (2603:10b6:5:142::10)
 by DM6PR11MB3179.namprd11.prod.outlook.com (2603:10b6:5:5e::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Wed, 11 Nov
 2020 09:28:34 +0000
Received: from DM6PR11MB3721.namprd11.prod.outlook.com
 ([fe80::5017:4139:6553:ded4]) by DM6PR11MB3721.namprd11.prod.outlook.com
 ([fe80::5017:4139:6553:ded4%6]) with mapi id 15.20.3541.025; Wed, 11 Nov 2020
 09:28:34 +0000
From:   "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     "kishon@ti.com" <kishon@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>
Subject: RE: [PATCH v2 2/2] phy: intel: Add Keem Bay USB PHY support
Thread-Topic: [PATCH v2 2/2] phy: intel: Add Keem Bay USB PHY support
Thread-Index: AQHWtkcOPVqKULsgZEi/CFIJq5XoYqm/rdgAgAL6CCA=
Date:   Wed, 11 Nov 2020 09:28:34 +0000
Message-ID: <DM6PR11MB3721899F79D7A75BBEE85C5FDDE80@DM6PR11MB3721.namprd11.prod.outlook.com>
References: <20201109031654.22443-1-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20201109031654.22443-3-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20201109114102.GY4077@smile.fi.intel.com>
In-Reply-To: <20201109114102.GY4077@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [14.1.225.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9e99ad1a-3883-44cd-3df5-08d886242953
x-ms-traffictypediagnostic: DM6PR11MB3179:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB3179C34C76EF0A873A8508A1DDE80@DM6PR11MB3179.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6Qco3kXzCT5sLvUyHKRHXzoEGEOL3PsLemY3bzuMHa7xvnn2JnpY0hhTQja0ZALRW5PloRhGKuerwdWcq9hVUU9f3mCwFZWZWqW4p/2+wEGjp3ghw0Yir/julbjijKWXp2Oe50ju0V5LyUq71PZj/Pzp1lbfPsH2b3Fyse5+RxXhsDpFu05hnVifUSPirGpbI7FUDNfRvRK++uwnTXf4gsAfjOxYs9XGwGwOfw1Y25hRvtjs1VDbFww1Koy9ke3+PYa6s9hxRuQLdkcg5DlVfnh9UUnyjb9P24udTGdmkRcAg4HN87Kt8Ae6GXfSIYbz3tF4QQbkquaRNCBwCTXSEGn+kxgpjSiDRwn0YKSQhxejZTxruLOMIPsBTLVJvu4SiN3lcpy8bbhJV1BL4s5Ejw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3721.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(396003)(366004)(136003)(76116006)(53546011)(71200400001)(66556008)(186003)(64756008)(2906002)(6916009)(33656002)(26005)(66476007)(5660300002)(52536014)(4326008)(54906003)(66446008)(7696005)(316002)(83380400001)(966005)(8676002)(6506007)(86362001)(478600001)(8936002)(55016002)(9686003)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: vLZWN1J9j0sm1MCJE/Th6lObxbCWjiwtyYaqX6Tj/ZG+/EyB+i2uHYT0wanHOkvY5wPctzcrb1MZxxk7XEfj+fJDwID717z5U8Jv/nlq8ZcR6+X2U9Wrn8yTEejJNaQmZAMRenI6ysdho82SdhMLzq55aN9wk3SBfhfRJqRu0WjZi0xO5meFChflDBOD+SsU/mCpcvkpYEMnpF89sl+yh7We3ir1F5xlBsNDKjiDKHYDUlWviyzEpiaw5Dbyivhcwl9XV0sK/J+ILLbMG9HHm4u7FH9DASWZiF23mz0GxoP2swY0lnJoIOc1+bCy6dAck1N931KQ+NJnQ8+o2NRgLrc84QR3IJlUQ9eGYzYjPr4srmtO46tEWjTNMXLbH599NSobCXav7rbv5RFZt+hRTj/Vg1xFfQLKWjqq2s6IQUuRHEdye4I+UKKwACKz3F6lsVfoOyWPDhUdnxweBXikK59MprrN4OxigjUB5OARmhyNqmMQ5yw6TZNUpgsTROzzzTQZHnX9FM2kmaqB39nvpuEJRH1uao5jNjq+ND2GPaFJG9Y5VeTmbjGHVx3RKuZupaRakBHs1j3k3IbSMKZ9GNGYl7C0j7adIduLX++i3FiMsn2h59E/ZcVtawNgQNSOs4/pWHuHKHqyvwMMxSfcw8APhG7d8MVwozJ6CxNLL1MCyvkoC3qyn323ppkNyIb3TjObgQ0lrmt7UwjyYrcTZL8ZF4+gT1JP3zC/PZvujVx1eevpun40hl9mWCRxp7yPbgK5CxRoa4cv93spFWDClcERjvCNhArZ2vVusAGeezvldOOYqJMqdHgHK6nJa89cveL+oaR3vh2tX8XeO9TT3ogqwHamA2Z+Ztrm28d7INo1Q+L5Sp8QATiZdwpYIXZdh53m3GpWe+QBUz/Z/PFqqA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3721.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e99ad1a-3883-44cd-3df5-08d886242953
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2020 09:28:34.2311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ciJBHIszJtxxgxOwLNTcWRNb1R3g6tcGWY1cbazEnNXlc4iZjsDmCn/dLIVX1Dg4kSfucL+7OaR5MsXkz8ujvp5rSL8VcKsMFZQ+R50jHcUVr0UhuIH4TNbSClKn6EIG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3179
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy.

Thanks for the review and sorry for the late reply.

> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Monday, November 9, 2020 7:41 PM
> To: Wan Mohamad, Wan Ahmad Zainie
> <wan.ahmad.zainie.wan.mohamad@intel.com>
> Cc: kishon@ti.com; vkoul@kernel.org; robh+dt@kernel.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org;
> mgross@linux.intel.com; Raja Subramanian, Lakshmi Bai
> <lakshmi.bai.raja.subramanian@intel.com>
> Subject: Re: [PATCH v2 2/2] phy: intel: Add Keem Bay USB PHY support
>=20
> On Mon, Nov 09, 2020 at 11:16:54AM +0800, Wan Ahmad Zainie wrote:
> > Add support for USB PHY on Intel Keem Bay SoC.
>=20
> ...
>=20
> > +config PHY_INTEL_KEEMBAY_USB
> > +	tristate "Intel Keem Bay USB PHY driver"
> > +	depends on ARCH_KEEMBAY || (ARM64 && COMPILE_TEST)
>=20
> > +	depends on OF && HAS_IOMEM
>=20
> Do you really need dependency to OF (yes, I see that it will be not funct=
ional,
> but still can be compile tested)?

No, I can drop OF.
I will remove in v3.

>=20
> > +	select GENERIC_PHY
> > +	select REGMAP_MMIO
> > +	help
> > +	  Choose this option if you have an Intel Keem Bay SoC.
> > +
> > +	  To compile this driver as a module, choose M here: the module
> > +	  will be called phy-keembay-usb.ko.
>=20
> ...
>=20
> > +#include <linux/bitfield.h>
> > +#include <linux/bits.h>
> > +#include <linux/clk.h>
> > +#include <linux/delay.h>
> > +#include <linux/module.h>
>=20
> > +#include <linux/of.h>
>=20
> No evidence of anything being used in this code.
> mod_devicetable.h is missed, though.

I will fix in v3. Remove of.h and add mod_devicetable.h.

>=20
> > +#include <linux/phy/phy.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regmap.h>
>=20
> ...
>=20
> > +	usleep_range(30, 50);
>=20
> Why 30-50?

I take this value from boot firmware.
There is a delay of 30us after clearing IDDQ_enable bit.
I believe the purpose is to ensure all analog blocks are powered up.

>=20
> ...
>=20
> > +	usleep_range(20, 50);
>=20
> Why these numbers?

In Keem Bay data book, under USB initialization section,
there is step that there must be a minimum 20us wait
after clock enable, before bringing PHYs out of reset.

50 is the value that I picked randomly. Is usleep_range(20, 20)
Better?

>=20
> ...
>=20
> > +	usleep_range(2, 10);
>=20
> Ditto.

Under the same section above, there is a step for 2us wait.
I believe it is for register write to go through.

>=20
> ...
>=20
> > +	usleep_range(20, 50);
>=20
> Ditto.

Under the same section above, there is a step to wait 20us
after setting SRAM load bit, before release the controller
reset.

I will add comment for those 4 delay above.

Before I proceed with v3, I would like to know if I should
use udelay(), instead of usleep_range()?
I refer to https://www.kernel.org/doc/Documentation/timers/timers-howto.txt=
.

>=20
>=20
> ...
>=20
> > +	struct device_node *np =3D dev->of_node;
>=20
> It's being used only once and it doesn't bring any benefit.

I will fix in v3. Use dev->of_node directly.

>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20

Best regards,
Zainie
