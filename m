Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E79B5253D45
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 07:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgH0FkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 01:40:18 -0400
Received: from mga12.intel.com ([192.55.52.136]:10868 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725847AbgH0FkQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 01:40:16 -0400
IronPort-SDR: P9LauCFeKOSVRPm1vSmzW3PicqsrHhq4ZMPGWLAPeiJ2JQANGpmkODi2xIAsNTnBluumcPNwXf
 GUIb+PkNU5TA==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="135974290"
X-IronPort-AV: E=Sophos;i="5.76,358,1592895600"; 
   d="scan'208";a="135974290"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 22:40:13 -0700
IronPort-SDR: R66F3npc1rBXelv0H6danDO8d540DKTNjn9fo8patqsWsFF5rS1RriekNbK0aaUXIsqGN+AnJF
 Hm/9N4uqrOOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,358,1592895600"; 
   d="scan'208";a="295608552"
Received: from orsmsx601-2.jf.intel.com (HELO ORSMSX601.amr.corp.intel.com) ([10.22.229.81])
  by orsmga003.jf.intel.com with ESMTP; 26 Aug 2020 22:40:13 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 26 Aug 2020 22:39:52 -0700
Received: from orsmsx113.amr.corp.intel.com (10.22.240.9) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 26 Aug 2020 22:39:52 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX113.amr.corp.intel.com (10.22.240.9) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 26 Aug 2020 22:39:52 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 26 Aug 2020 22:39:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dcs+U4RMyofRqcP0wr5sNAdRJNhR3vaE840Lt5ZuaFExOSWoqW5mjw5lpMAQta2gmjU5+9NnUu70Wx3i8CVEXuLlQXxQXDQ0WcEZpORR28tQ6DyC9a9g1SufnYaG8OTQEEGd22817UJSugGw/1J1AUR3X+IRpLA2lMY3Z4IoJu2zHQ4i9PFOF6b2dIY6DIr/1qPuUbNOxwX0DF7U8jmQ+icPQ3pvDQpnqkgK0H1wErf/3mudQQozKg85AScn9IG5hlmSE5FfTf/VA4dif2BbjkBEjzIY605fKfHhb1yKjFM24eupfzYPIcz4cTkrv8tDAl7QNCXyJMm9nq8Mt/XRUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZUd031hx8HI2Ybi4//2wimZFd1BUfWaWaHWfc80lzsg=;
 b=a6aqStOuVMWoKjoxUEsCqilTC9KaFl7G/UPe32g3m31edJGzFb8pQV/CQ2BqspakjTSQtVHHtbGJgBAlI6gvhKY65SVhqdlaRJZ5wAt7f35SIN6w/0vw2v+jSU0imctFJsQVRwGSs1YS1XNhYqPfq7aQV1ktd02V7l1SsTsqXO55OdBomh1SdexEwOORln9iXDbZdB7jNGVRbBkLF+1EDMAEokkNUSP/BTgtgF+rCKM6pLAxJ6TQjmE/ZZWOZZC4OZCY9XR2lWMvKt14fyH2QMGfS9p/0LY+6hGWYydhyyTRnM9ncbSFvdV5d9H3F5MKsb6oKyCRIzcacbw9uo4/Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZUd031hx8HI2Ybi4//2wimZFd1BUfWaWaHWfc80lzsg=;
 b=RbB1Tq3yMTXVxwv4XpXEDui9KCAKE9p9eTjGzdtM3sxBQ8QhAqcuYbYpL9eT9q4ba+YHqlYMM1G888NvhBCiSDoR3Y3q6yZ2xN3DCdkvkDzw+kAAb5Tf5yV1+pITtzGpKvbX0vGQzU0iYUcbPk1zMdXGgPYRY90EFTQS2Bv4ADY=
Received: from MWHPR11MB1645.namprd11.prod.outlook.com (2603:10b6:301:b::12)
 by MWHPR1101MB2160.namprd11.prod.outlook.com (2603:10b6:301:5b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Thu, 27 Aug
 2020 05:39:50 +0000
Received: from MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::6dfe:feb8:25f1:ac9c]) by MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::6dfe:feb8:25f1:ac9c%7]) with mapi id 15.20.3305.032; Thu, 27 Aug 2020
 05:39:50 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>
CC:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Andy Lutomirski" <luto@amacapital.net>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>
Subject: RE: [PATCH v2 1/1] iommu/vt-d: Serialize IOMMU GCMD register
 modifications
Thread-Topic: [PATCH v2 1/1] iommu/vt-d: Serialize IOMMU GCMD register
 modifications
Thread-Index: AQHWfCsR7xD31gRG1EuP3vMsSfIavKlLcGkQ
Date:   Thu, 27 Aug 2020 05:39:50 +0000
Message-ID: <MWHPR11MB164521E12E86B1681C132C0E8C550@MWHPR11MB1645.namprd11.prod.outlook.com>
References: <20200827042513.30292-1-baolu.lu@linux.intel.com>
In-Reply-To: <20200827042513.30292-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.216]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bbc4b7b7-0307-46e5-e621-08d84a4b9dd6
x-ms-traffictypediagnostic: MWHPR1101MB2160:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1101MB2160580A7AC0DF58F9935B8B8C550@MWHPR1101MB2160.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4hN7VLzpunM4tv4vAWjIYyu/fvhg62ZXbkIOLY9agOkgXQzsPtMhSHr7jpVZGeihzcE2kaNVBDnkQeJ9QAbEOQczOXxI8DQlTeVL7IdjxEuKF8MIZV+pxlSOMOPwRTQC0zJdH8u8MGL7VppjRmGudgnzO2XPZyVdEvlloOTnRKFP9xwtyRjexcU6bC3T2OE8R5DPykZUXDyrPFv5EJSp07r1kzN6kh3GCGLeD9khbs26+zJSFyY/SCI+lUMepkqo4SgKHubg5EvmrAJYrYQiMP9gcBXzpe2nXWWlfdRqPuTF1DsvxMy+FRUmNUD4Dw+QiLDqGGhRUKWu0wNFc1p/oAgfvLwu3d/fpS0dpCHxO06Ih/e6hyskOFbk9emE0nxKlRJ3CAeklKlBSAozcLd1/w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(186003)(7696005)(86362001)(33656002)(2906002)(4326008)(6506007)(54906003)(478600001)(52536014)(9686003)(8936002)(110136005)(26005)(316002)(55016002)(76116006)(66476007)(966005)(66946007)(66556008)(64756008)(66446008)(83380400001)(71200400001)(8676002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: bzFiU+jdekIm841nRDbxV2xB9LBuqIzElsS7/tFrrrnXm3PDQ00h7qL1Fvku7h/YNeQsolf0phMGq3UuRc7XHjz0yL64yPDSUJZldYvUP4Q3+pJuRHBiea1hkrd3/GV8M5pfbl2nl7VT56bgpR5M/gcBGH789NCq5RipdOw7aPjOSW9FmECfW1NVJ6t7eOXC546PI+y2aI7mqtXDrI0v+yfxLu3x49PfBin2H4r6oiQMR7OGp6hJP/vh1xXMhhuDN4O0f1wvBSaaC1coTE2zqwFklBdkkuH3wzzg9YHJIHSyQFu39j5mnmsXi6lWyGCs0c7N2c2ffSWAP6WMe1L7wPQECvNPG7hnDChbKvmbpCRxRuWcCmcVX93OoPFS9WJEciKow+j2yptuU0D2RFZAChkObJC4VbvMskQWtUa1AcPrTgvAOzJvjBthjVRBE608We4BS457sLUuO7F81kWS9ee/UgiUlHSohiRDmp0D1H5oksxq0J+PZS29+Sqgem/OtUjQ+IZe6I2yf3tuTtoJkeUIl/jS/oXqLYq01+pp/ylbocP/HnsvL1T9vVf6gJksplDtrg8ocKb5+96WYdOB21zBDhBEpauNoZlCzubjZPaJTcabiQY6IT/d/2IIEmAXFBabeS9GW8X95bGDO2SmCg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbc4b7b7-0307-46e5-e621-08d84a4b9dd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2020 05:39:50.2415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rNDfWva/9SxPh3szB+nnvRaWdC3AN2DTEN85c6X/eAmo5SmlRTvvPdOwFWxVYBCZ79bCAnoUA44vSbAeU6Bshw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2160
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Thursday, August 27, 2020 12:25 PM
>=20
> The VT-d spec requires (10.4.4 Global Command Register, GCMD_REG
> General
> Description) that:
>=20
> If multiple control fields in this register need to be modified, software
> must serialize the modifications through multiple writes to this register=
.
>=20
> However, in irq_remapping.c, modifications of IRE and CFI are done in one
> write. We need to do two separate writes with STS checking after each.
>=20
> Fixes: af8d102f999a4 ("x86/intel/irq_remapping: Clean up x2apic opt-out
> security warning mess")
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Ashok Raj <ashok.raj@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/irq_remapping.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>=20
> Change log:
> v1->v2:
>   - v1 posted here
>     https://lore.kernel.org/linux-iommu/20200826025825.2322-1-
> baolu.lu@linux.intel.com/;
>   - Add status check before disabling CFI. (Kevin)
>=20
> diff --git a/drivers/iommu/intel/irq_remapping.c
> b/drivers/iommu/intel/irq_remapping.c
> index 9564d23d094f..7552bb7e92c8 100644
> --- a/drivers/iommu/intel/irq_remapping.c
> +++ b/drivers/iommu/intel/irq_remapping.c
> @@ -507,12 +507,19 @@ static void iommu_enable_irq_remapping(struct
> intel_iommu *iommu)
>=20
>  	/* Enable interrupt-remapping */
>  	iommu->gcmd |=3D DMA_GCMD_IRE;
> -	iommu->gcmd &=3D ~DMA_GCMD_CFI;  /* Block compatibility-format
> MSIs */
>  	writel(iommu->gcmd, iommu->reg + DMAR_GCMD_REG);
> -
>  	IOMMU_WAIT_OP(iommu, DMAR_GSTS_REG,
>  		      readl, (sts & DMA_GSTS_IRES), sts);
>=20
> +	/* Block compatibility-format MSIs */
> +	sts =3D readl(iommu->reg + DMAR_GSTS_REG);

no need of this readl as the status is already three in IOMMU_WAIT_OP.

> +	if (sts & DMA_GSTS_CFIS) {
> +		iommu->gcmd &=3D ~DMA_GCMD_CFI;
> +		writel(iommu->gcmd, iommu->reg + DMAR_GCMD_REG);
> +		IOMMU_WAIT_OP(iommu, DMAR_GSTS_REG,
> +			      readl, !(sts & DMA_GSTS_CFIS), sts);
> +	}
> +
>  	/*
>  	 * With CFI clear in the Global Command register, we should be
>  	 * protected from dangerous (i.e. compatibility) interrupts
> --
> 2.17.1

