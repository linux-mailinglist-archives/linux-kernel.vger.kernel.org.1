Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDC82B14D2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 04:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbgKMDq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 22:46:56 -0500
Received: from mga05.intel.com ([192.55.52.43]:6173 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726011AbgKMDqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 22:46:55 -0500
IronPort-SDR: ozH8TAbQxLoNpOwGo5IAFDWg8BV+A+VOQcR+xgkCwLbs7eSOg8w+GOWWzrf0QNEP5ibZPwDzCx
 KA6V9rwGxWlQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9803"; a="255131995"
X-IronPort-AV: E=Sophos;i="5.77,474,1596524400"; 
   d="scan'208";a="255131995"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 19:46:53 -0800
IronPort-SDR: TSpJAJPs47O0Gv8XrS7IA0lrbbqBwWenyPm2ObzikSNe9rG3vMx+4VWG83hktEITKVAmt4tIy3
 9w8gLGiOrFpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,474,1596524400"; 
   d="scan'208";a="542507528"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga005.jf.intel.com with ESMTP; 12 Nov 2020 19:46:53 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 12 Nov 2020 19:46:52 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 12 Nov 2020 19:46:50 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 12 Nov 2020 19:46:50 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Thu, 12 Nov 2020 19:46:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZlJ9eAxvfyQFBZrkcOLr+/3zF2UfZ56FvXNGUf+yph4OpmdqPvup+b2fsAi7GKrxYd2TK9vM2lORKFqvHhDEIzQ7iHDRC+T9/Ur88TZZV6G7nlXT/jpBbMBp1KGRBp/vRru6h5tljDzPPMi8B1eje8Pjt9kaAeSWB4JSVOL+vemZ4kuQDwa1JZEKbQefqYSrP7k/P3yYozxVD67rrm/XtEeIKqXLBb088y1msk4EHtQCmBHQJ2hHTq90njMklGx22FZkG2/3XV3a4O5L+jdmT50/wP8c+IDwrL3t9nMYiDx6+kVXrW3Jj58RjG9rLNaLEist62z4yDPLJx0OO1cCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEpXYZGehsNUfGrSeJeCoNFTHimBV0JyAZWGKqWuA5s=;
 b=gqU5OU++F/IBP7GRGXUfmfpUbOTKGdiaU4nRfG+KH/x/R8fsHir6sAVzZHU2xMZ0QRoO37bUbg9QwweAkRbz53BL7x521ujdh1kozaJflXXyfDlcEw36T+aHvlfhi0RLeNVo4fBUnEkzGvkuOLgee65koVrjC88y8UEqwlu1hR918e/FQVTZa4ckkVgVJG+7y3Wha7GI2VjjV36VRJJQWdlUQJuzhpt6U8odX+WnGJsoo3LfgZZpn/VKcMpq5Z8tGc3Sf8ztd/I9IgdKq/91KVe7Xd8RKeCHqO3yaXPy8e204eNf9KsFm8EcShv/z4ccDeQmMJ5UwuIfS3nOfWHPWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEpXYZGehsNUfGrSeJeCoNFTHimBV0JyAZWGKqWuA5s=;
 b=D3XOUOCuGHIzBVGaObuuGGpdqjzpt70WhtMpqq6/mSlwJBRVN8J2aUGojWPNa9ek2tkJcr/cN4Hzx8Iflh69XGkCRvaYc6L7hcQeeSpjJqWfS2Kn+afvJlZrdGFLovVPI0m508Gj3Q4D/rexcTgtwDbbg3BOCGWDhQzy0G5tgPg=
Received: from BN8PR11MB3714.namprd11.prod.outlook.com (2603:10b6:408:90::17)
 by BN8PR11MB3715.namprd11.prod.outlook.com (2603:10b6:408:85::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Fri, 13 Nov
 2020 03:46:48 +0000
Received: from BN8PR11MB3714.namprd11.prod.outlook.com
 ([fe80::213d:ddad:993c:cd50]) by BN8PR11MB3714.namprd11.prod.outlook.com
 ([fe80::213d:ddad:993c:cd50%7]) with mapi id 15.20.3541.025; Fri, 13 Nov 2020
 03:46:48 +0000
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
Subject: RE: [PATCH v3 2/2] phy: intel: Add Keem Bay USB PHY support
Thread-Topic: [PATCH v3 2/2] phy: intel: Add Keem Bay USB PHY support
Thread-Index: AQHWuNqoNSM8nZrIJk+7EJr9fv7yMKnEjqOAgADdxgA=
Date:   Fri, 13 Nov 2020 03:46:48 +0000
Message-ID: <BN8PR11MB37141DA30718CA4A3243489ADDE60@BN8PR11MB3714.namprd11.prod.outlook.com>
References: <20201112095821.27110-1-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20201112095821.27110-3-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20201112142905.GH4077@smile.fi.intel.com>
In-Reply-To: <20201112142905.GH4077@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [14.1.225.32]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c0f878ce-c016-4af9-a9ae-08d88786bfaf
x-ms-traffictypediagnostic: BN8PR11MB3715:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR11MB3715577D9754DF0646DCA93CDDE60@BN8PR11MB3715.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iyJLX/E07cEsopKLSU+y1V9vRZ4GeiKcsqd6ReKRtQSGJwS4B4iNw/hrrKwV0SMEGZcKgWoJd9WBpiEgetNUd1MAg5iVlxzeqT9o4StngfKarLws+ta8zRmdW4Lp0IREahCzmxW6jnGMCODMohAul0dSPucANJ7Dv3WuCsyxCPFrCuJlNiz9XeurUN0YQmPzl00t0PKRgRpsCb77E80i2u30XRlf9J/zPF6c7d5s8DVxtD/P99MCmSuKCxGdmqng5VB6UrM3WWbuSQaiwqPNSVgRfo8PZku/uoOTh3jBD+GZFbR9hkStvWMbwu+mJ589
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR11MB3714.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(86362001)(478600001)(6916009)(54906003)(66446008)(52536014)(66946007)(66476007)(66556008)(64756008)(316002)(71200400001)(9686003)(8936002)(186003)(76116006)(83380400001)(4326008)(53546011)(55016002)(6506007)(2906002)(8676002)(7696005)(26005)(5660300002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: IMQG0toAbHzxbqoVHkYEfITS9pcxLQN8ZJwulkOG1dO7LPFa2v7LwIov6Mvn9mQ4hmVDuaZfAI9Z/+LY0+H91lqUXu3eXgoxso1F0OyQK/Qhx3jyh84ntRLRkoBJUTM4fjtntb2w5nr72bn32WDAOZwqfqpIJc/BlPqXJLk2EtdVFJNh8ZnZ4kEHfxpW688k9jSe3/A5Qzo1sSzMmSom7uwZgAo0y5ouWsJ5FY5geMRdlfgN6KaYvH21NONVg4Sv+lWpXFhKsJmq5dK2EYA1ou/ZrKot/pfSgk+1Ss9fJE1Mtx+Hmhc0/tjweF6KV+cLCPPt4VxHpX6/c4m6pGzKw2FV80zFIGlZOpRqKDiFP48DriNPoxNUHQXUSew7uVTi69RT+6IfcVhladMlhAkRDk9JfOC0YkrE8aBzSz44JvA5QSCxBDz0m+JOReTxT9hzvSCRrDELBNIINZkR1RKFUUEZ3hifhoiDjALSS1Td17aQC+YJHkxUidLoUCqQq+LMmf8S6Cu1sA/0e6muvqtekPRr416nibSx/gRlE66R/3jko5wLt0YWvJq85EwwEAyWlM/7KDsS6dWT6Y8DFBUl+bOKi1TCFUYYN1smO3P6kSPexg3XucUpotqWA9atv+D+PnqMAGjKk1X67aITxT8bhvaMC/T9ciyWcCQoXdKugWDs0R7YADTeY0Jz26rIFWeO5MlDyGifxsenRcgFwI3YDQOup9o1daabY5UkB6S1X+92zpVfDFF1vcWGqCNET9b9qRxISicCAz8svCs57+7nk+gbSFxCYVX/x031NJ6BHgfJF+gCubWfrNR97+UU+S+yuMA87n9d0Nnd2dcw5wSLjh9ryJGeqhm/9gCuklANpHVnx6p7QgLBfq/QU0NwP93lib+W6fO6mqw3G5KHvW/HXA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR11MB3714.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0f878ce-c016-4af9-a9ae-08d88786bfaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2020 03:46:48.3193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6XrTpvrcIWnYN9xwqwjPYE+VGsmFNw32JUMjPbG+KHUQZQcw/AxV4ub2ydPwZ5MeOhTU34fY7b4EUEVcDZ8eLdW2O4RV+jXXdH+vCIX7fauZhegCSS2m2Fxn6gRMLlnQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3715
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy.

> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Thursday, November 12, 2020 10:29 PM
> To: Wan Mohamad, Wan Ahmad Zainie
> <wan.ahmad.zainie.wan.mohamad@intel.com>
> Cc: kishon@ti.com; vkoul@kernel.org; robh+dt@kernel.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org;
> mgross@linux.intel.com; Raja Subramanian, Lakshmi Bai
> <lakshmi.bai.raja.subramanian@intel.com>
> Subject: Re: [PATCH v3 2/2] phy: intel: Add Keem Bay USB PHY support
>=20
> On Thu, Nov 12, 2020 at 05:58:21PM +0800, Wan Ahmad Zainie wrote:
> > Add support for USB PHY on Intel Keem Bay SoC.
>=20
> Any elaboration here? What is this PHY (USB2 or USB3 or?.. etc)?

Yes, I can elaborate this.

>=20
> ...
>=20
> > +config PHY_INTEL_KEEMBAY_USB
> > +	tristate "Intel Keem Bay USB PHY driver"
>=20
> > +	depends on ARCH_KEEMBAY || (ARM64 && COMPILE_TEST)
>=20
> It seems other drivers that are not using ARM specific calls moved to
>=20
> 	depends on ARCH_KEEMBAY || COMPILE_TEST

I will fix in v4.

>=20
> > +	depends on HAS_IOMEM
> > +	select GENERIC_PHY
> > +	select REGMAP_MMIO
>=20
> ...
>=20
> > +#define USS_CPR_MASK		0x7f
>=20
> GENMASK() ?

I will fix in v4.

>=20
> ...
>=20
> > +static const struct regmap_config keembay_regmap_config =3D {
> > +	.reg_bits =3D 32,
> > +	.val_bits =3D 32,
> > +	.reg_stride =3D 4,
>=20
> .max_register?

It is optional. But yes, I can add,
.max_register =3D USS_USB_TIEOFFS_CONSTANTS_REG1

>=20
> > +};
>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20

Best regards,
Zainie
