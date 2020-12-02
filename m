Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A79CA2CC2B8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 17:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730156AbgLBQs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 11:48:56 -0500
Received: from mga12.intel.com ([192.55.52.136]:6553 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726525AbgLBQsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 11:48:55 -0500
IronPort-SDR: OTeoJEdKnE9aml0LUj+akan2BnmIoAEvJzUjpwSf00g3Ve/5DWMbNzbLBsvg1buvsEPotSKtKt
 bHn1T6Vt4rwg==
X-IronPort-AV: E=McAfee;i="6000,8403,9823"; a="152300430"
X-IronPort-AV: E=Sophos;i="5.78,387,1599548400"; 
   d="scan'208";a="152300430"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 08:48:15 -0800
IronPort-SDR: LW+GNXE1PK1lbBmE/XJPW6XE3FxEyvAUPnrfphJaIxInoxr/qlx/qqZvtR+nlXj+1L01kDm+uL
 RHTXe5drV9kQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,387,1599548400"; 
   d="scan'208";a="481622518"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga004.jf.intel.com with ESMTP; 02 Dec 2020 08:48:14 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 2 Dec 2020 08:48:14 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 2 Dec 2020 08:48:14 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 2 Dec 2020 08:48:14 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 2 Dec 2020 08:48:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iyHc2HhLyf8vOUIWFZ/SmA6dXmzyLyebCWolDNgumT93vb8Q57yaqjAUXmDSOg10r5wskOK/yistcsI2CqLAiBzoXBXcANemo5QYjDrcMWn4fK57W5y9iqb00msTTcszxAw/HnuclpR2lJwbqFVcLzncRD2WrWh7gN6kymWbhVrIrrLEJFASq/Xu4wjLPEA0WP88ErSyxnQLFLoygLNmYY7naCeKUJRrzoGJwr3wMq38fq5Ur4D/X6DfhLJ5gUfTGlJ/ScU94UWAu3i8U1XZsFqJfsmueedeR/KAKI7iOzilC5bl3jwvfinSiGX4oszaxH+0Pit9KP4v7h7HgZ3WOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OeLXN68Qfyf+3C+0ap4LMnINDouLCSbWf1V2qpfrkHE=;
 b=XLbTmmMoTH+3+vg5fnAHv7ZKgafAgig+S2o0NnaG9GXZC+XG/LL0/cfaWH2WC/sxSg5QHBD/5SGros77NgioXtwzbOfMfA7aXB6+XpRkBtpKMi4zHIh6ITqBtBXRZySMmmv1IKe5lYJ0DS4Q9PQeoQ9IMttzzUWyAPz+MNkPV09huWj9HM1jtdBV8RkfgFnpTUBSp6UHxzGuCh1EFxp3VZZbcyzw6Z8woFyT/S6Y5yfD7kfQBAskQIYFf/RAndI65JIUQifb8RH0pWLxfDYPjVwtwrRFUANQ11WFmfoZnGfeC3pwGCSn31+CVSuzaEHZLk7eGGXNtfPt/z9bD7R1eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OeLXN68Qfyf+3C+0ap4LMnINDouLCSbWf1V2qpfrkHE=;
 b=tfc9h2ocizysKWTqIfcppvlB0jWHqeWLz5cwo5U9G8pt63zwv267x1yii3iYOkA7I/8P0lUef0oShBdUaQd8zE5c70PhioadLnNd0GImFLyX9YL8Iyfpb0hnbQ2WBTHE+8crU4hAnR6hRG+Ljt7Kq6O0Dzn4Y5FD0PRXFKFsqvI=
Received: from CY4PR11MB1781.namprd11.prod.outlook.com (2603:10b6:903:124::13)
 by CY4PR11MB1432.namprd11.prod.outlook.com (2603:10b6:910:5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Wed, 2 Dec
 2020 16:48:11 +0000
Received: from CY4PR11MB1781.namprd11.prod.outlook.com
 ([fe80::8135:848d:4e4:8f26]) by CY4PR11MB1781.namprd11.prod.outlook.com
 ([fe80::8135:848d:4e4:8f26%4]) with mapi id 15.20.3611.031; Wed, 2 Dec 2020
 16:48:11 +0000
From:   "Thokala, Srikanth" <srikanth.thokala@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "Gretzinger, Adam R" <adam.r.gretzinger@intel.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: RE: [PATCH 07/22] misc: xlink-pcie: lh: Add PCIe EPF driver for Local
 Host
Thread-Topic: [PATCH 07/22] misc: xlink-pcie: lh: Add PCIe EPF driver for
 Local Host
Thread-Index: AQHWx22d6aqnbjZ6n0eG4MdNx3hqvqniB4SAgAH+B5A=
Date:   Wed, 2 Dec 2020 16:48:11 +0000
Message-ID: <CY4PR11MB1781526711BF249557D298EF85F30@CY4PR11MB1781.namprd11.prod.outlook.com>
References: <20201130230707.46351-1-mgross@linux.intel.com>
 <20201130230707.46351-8-mgross@linux.intel.com> <X8YYPxK9gnTvubTJ@kroah.com>
In-Reply-To: <X8YYPxK9gnTvubTJ@kroah.com>
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
x-originating-ip: [171.76.107.214]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 83b3012e-1a25-482a-dc1d-08d896e20e34
x-ms-traffictypediagnostic: CY4PR11MB1432:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR11MB1432D025A4698296C5A2058185F30@CY4PR11MB1432.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lbCq/yW/vJ9nE1dh5iwfqrltIHIeHSmu3qhm6ypqhXdSUfQQ7l/NbTXk4OnNk1X+4ShrZ2yY6AVh9E0G69rgkiIRdIa7J7peVqjfh0AhNFFa/hpYWBJ+fCXmk2A0EfGO9SQODo8bpzp0OaeOLCa0RZm9zMrWlEtuL75jD6aCpvjx+h3BMKIoqLNBRtHR8nRvszZQcKJI7uZnGfHiCuaRpEGrnH01PDjXOoaaJk3JKu3lXi+LzJ6bWqLx4wNzudxld0rRAET1hMhiz7GEjTdQh97FZt/QEuzknHeqBWmfup/+R1vt0VsW/3fSVvWli3nK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1781.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(39860400002)(376002)(136003)(66946007)(66476007)(53546011)(478600001)(26005)(83380400001)(186003)(33656002)(8936002)(52536014)(86362001)(64756008)(5660300002)(71200400001)(66556008)(66446008)(9686003)(55016002)(6506007)(54906003)(2906002)(76116006)(110136005)(8676002)(4326008)(316002)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?TcC5N9O6KdDkUTYntMUoSO9ig0GKtQVtMUcBk7l36lVNAXse7rokVb8OU2vA?=
 =?us-ascii?Q?gtaW0VITuk0Qv00yulxylNXhgzjqln7xSgW2T0u12/AWPJRQSBcstXNBHDgZ?=
 =?us-ascii?Q?FJ3ob+MLS7jvrpohPIr9UZXXlXaamxEtCoe9dKmsUuU7PkvVP+qcKcZoHD0m?=
 =?us-ascii?Q?T8EpPsOyk80AznVfzQnXraVcaxYswOI34gx4hbyM/4Qxb0bVRIxktxUrnTqw?=
 =?us-ascii?Q?tgrbHU1woc//qhgfepbkExgpmKrA6mcRapsGpfNvh86Jnf13h647AyO1e6Ie?=
 =?us-ascii?Q?fmUFBGGqkjKnWO4K7arXcIkScRLmeAYATjZ9x9IKzNnSq5cvxtLSwSTGbDM8?=
 =?us-ascii?Q?Ha6Aon+rLWezizvPfx+3qB1BgmJQ/wpQVksbV64MTQz3U66TZh2k1mK16G81?=
 =?us-ascii?Q?yJtXgGzyM2i563/z56N42FBPHkcB7asEfDLghbu5DnZroL9srku5QyhQi5kS?=
 =?us-ascii?Q?39QaBmPChPS1mErAMrtJHSWbb3mmPeHvSsQpKVmayj4QCwaz45OK4ueoD+kE?=
 =?us-ascii?Q?8/Hg9c1C40GOPLguSzoYnQD16BoIvxS96E5CBP2+CjlDYUvNiegmxIyp0jKS?=
 =?us-ascii?Q?fNNUkPaWzyMDjuMwI+yBbO5JR8YJVI+0mB64I3ngX5Or23+WtdkbQ/L28ybf?=
 =?us-ascii?Q?9/nDYXuIksH6gsuGz3qxDgrEm3W/niP9PEaFYYmVrOKBDAjhy44lVgJRM0cJ?=
 =?us-ascii?Q?1WOs0h1kZYI0TaTtvyDUsxMLnDLt8YyUMKp9H9Pg84UpwQHNzzymxn7OU4yp?=
 =?us-ascii?Q?dkYcAz7ZCjuaD/vjLmPGeNqFGAAsD/0N/cXtUYzICkpmv1xP7d5VPziuZDNm?=
 =?us-ascii?Q?CTBV9e2etVHEdiaqR7E1YPTy4V5YlVBFCdrnnjx78ZHG1FCmhQVLeFJTRF8Z?=
 =?us-ascii?Q?wP/5wHbrZ8sqJXNbVPrwX4yoYqq+T54ZpkKLHjSYLB0Cpv0ng0fvDQIy8Rly?=
 =?us-ascii?Q?EnDhkpWSUC0njNMot9j8ufpRSznI8zzyUAvJSsaabKQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1781.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83b3012e-1a25-482a-dc1d-08d896e20e34
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2020 16:48:11.7076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: of9Rxk+gw81eRH0VxHyR6yjBi6keJrHcd1/lu4GUvV0lBF9Fq4cbKGdJPNlu+Xv35FKCfNXOl4bd5D75vZUant9bSte1hLjUKdecoSWLUxU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1432
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> -----Original Message-----
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Tuesday, December 1, 2020 3:48 PM
> To: mgross@linux.intel.com
> Cc: linux-kernel@vger.kernel.org; markgross@kernel.org; Gretzinger, Adam =
R
> <adam.r.gretzinger@intel.com>; Thokala, Srikanth
> <srikanth.thokala@intel.com>; Derek Kiernan <derek.kiernan@xilinx.com>;
> Dragan Cvetic <dragan.cvetic@xilinx.com>; Arnd Bergmann <arnd@arndb.de>
> Subject: Re: [PATCH 07/22] misc: xlink-pcie: lh: Add PCIe EPF driver for
> Local Host
>=20
> On Mon, Nov 30, 2020 at 03:06:52PM -0800, mgross@linux.intel.com wrote:
> > +#define XPCIE_VERSION_MAJOR 0
> > +#define XPCIE_VERSION_MINOR 5
> > +#define XPCIE_VERSION_BUILD 0
> > +#define _TOSTR(X) #X
> > +#define _VERSION(A, B, C) _TOSTR(A) "." _TOSTR(B) "." _TOSTR(C)
> > +#define XPCIE_DRIVER_VERSION \
> > +	_VERSION(XPCIE_VERSION_MAJOR, XPCIE_VERSION_MINOR,
> XPCIE_VERSION_BUILD)
> > +
> > +struct xpcie_version {
> > +	u8 major;
> > +	u8 minor;
> > +	u16 build;
> > +} __packed;
>=20
> Now that the driver will be in the tree, there is no need for this
> structure or these fields, right?  It will just be the version of the
> kernel.  Otherwise something like this will never be correct, given
> stable kernel releases and enterprise kernel releases, and loads of
> other messy backported trees.  Just stick to the kernel release number
> please, that's the only sane thing.
>=20

Sure, I agree. I will fix it in my v2.

thanks!
Srikanth

> thanks,
>=20
> greg k-h
