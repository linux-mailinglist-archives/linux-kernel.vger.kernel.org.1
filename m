Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBDC22C9570
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 03:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbgLACyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 21:54:38 -0500
Received: from mga04.intel.com ([192.55.52.120]:30601 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbgLACyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 21:54:37 -0500
IronPort-SDR: dtc5zLVXiXC+7wGHmQSVWZ4FmDo6H312pxI/FRhBhsUUrg0UaxfPsZqxdlC0o1q86OfLcOOtyv
 kTAaLyYTC8zA==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="170187952"
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="170187952"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 18:53:56 -0800
IronPort-SDR: /X9FE4ho7+XQqsukeX1jogu7a+lfikc6J2zhbML497lviy9KhEhgRVhShWlfLp9Q9lFXwtnxgP
 KI+RV96Tx6ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="549366530"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 30 Nov 2020 18:53:56 -0800
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 30 Nov 2020 18:53:55 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 30 Nov 2020 18:53:55 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 30 Nov 2020 18:53:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PIm7lIgGyMDAn8O4ss8DCspRY34kFZaJ5F8p8nJlOvAFonIF22V5Po9PK1WLV8TWB964uGDLODa32mOEAaOT/CmqzdfxX6S/8bpx+cU7xayLi9scshEnAcUsd4O8VW5SD7ZDjsSkACSkMSwgNbTFZxcrwunuOqXEQ5A64NKyjrTskyxgwNwa4typA29jgpyhAC5oe6uaqa8ucvDzSV2RZWLwaUAAOtU6ysBJkuW73mfIMYKdWIpSVcxdo/h4VC4lAYxmNv7JY7VHHo+C2iA+Ss9W/zqQfOHAe01r0Nt3mJErN3G7+UWKCh8QdqQuiW2KKeb9rneb658ML8MU//2Jog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iH3l9b9i5qx4cRWNhl0LBfmDOIdARY0QI6f5WKAYP/I=;
 b=iNCjTtQdlZHTKwC2DlwcfdwcvyhLEJbJENADJs0xtvjTTHAZPXo1NyUrrSsbHgO6iOi+Q39wQjB1cXzPlkXNf46Q0Gt57+wKdYjtmb/3ivRz51j8t0Y59h4RKjK1Z4DtcILL6uoCSJTCFwqsVm61AzYPrNV33Wkd44fUnnkGFiceYUS+OTwg28SgTlByGcvK13XdnLZfyGRtu9/9D9ZGD4phFPNIHQSldH2Fl0dsUMFgvDeOObMTMQ33bL1t/JwtGZ6rTSUBMO89F2hHvLD/KH4ekMqujtyrTF0HNoLjqp4hJPcIGCfUz56h0n5bXhK3ubES4NZu0nRXTiWeooB4Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iH3l9b9i5qx4cRWNhl0LBfmDOIdARY0QI6f5WKAYP/I=;
 b=d1vnUlGhoSf19DkLbGm3CQa0ghFd5Tw9UBbFm8yNMCSPAe377sKk5NEBJgcVD6mBxWMFnbv5q6DQNPfx5oqz7j7xipZdXeCDsbK1+ovWzCTATCMpGTiQFh4SIvw7x+bD1S1j6XbSeOFP4xhpg6247bbBqpzWsLC/3Dp8g3w0AR4=
Received: from DM6PR11MB3721.namprd11.prod.outlook.com (2603:10b6:5:142::10)
 by DM6PR11MB2668.namprd11.prod.outlook.com (2603:10b6:5:c7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.24; Tue, 1 Dec
 2020 02:53:26 +0000
Received: from DM6PR11MB3721.namprd11.prod.outlook.com
 ([fe80::51e0:f848:dadc:bc01]) by DM6PR11MB3721.namprd11.prod.outlook.com
 ([fe80::51e0:f848:dadc:bc01%4]) with mapi id 15.20.3611.025; Tue, 1 Dec 2020
 02:53:26 +0000
From:   "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     "kishon@ti.com" <kishon@ti.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>
Subject: RE: [PATCH v4 0/2] phy: intel: Add Keem Bay USB PHY support
Thread-Topic: [PATCH v4 0/2] phy: intel: Add Keem Bay USB PHY support
Thread-Index: AQHWvBF/Fs+HoW0qd0q8yG+/Th9nsqngh5qAgAEadwA=
Date:   Tue, 1 Dec 2020 02:53:26 +0000
Message-ID: <DM6PR11MB3721B396A85CF22987DD0F4FDDF40@DM6PR11MB3721.namprd11.prod.outlook.com>
References: <20201116120831.32641-1-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20201130100211.GL8403@vkoul-mobl>
In-Reply-To: <20201130100211.GL8403@vkoul-mobl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ef9154a-4a17-43b7-d597-08d895a4469b
x-ms-traffictypediagnostic: DM6PR11MB2668:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB266876CC9CEA63503ADBBD7FDDF40@DM6PR11MB2668.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MM829IDz5eLIab6xHolNt21Shl+PqPWQpEFQV/TChfzJ35g/ZgyVQN5+HB0f2WaeI5tYZbPCr9mSIVUAic9Z7BnXcus4lTDc3uULs2ap98si2sJ9HbLdstBY82ihxjp//6cdrgOJe+JMFiWqjO5+0lCE8hqV7MTjmUAz2aZh+U0D9cHF6ADZqLRaF6PcyBe+0Nj1tEPkbKQidxR3az2dV/a3TEeskHAin0mUCr/h32YcWrK3jpTV/89tbhJUWfXBccMA2EGGfXOD30gLsX4p+li2XXnxPqiG3vnGRzR0tUypEw5luoMv5US0+oy/vaWs0uUoRTyU/J/jjOc4jiEoKA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3721.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(8676002)(71200400001)(316002)(54906003)(86362001)(7696005)(55016002)(186003)(4326008)(478600001)(9686003)(8936002)(26005)(66446008)(83380400001)(66556008)(64756008)(53546011)(76116006)(66476007)(66946007)(33656002)(4744005)(52536014)(6506007)(5660300002)(2906002)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?uLyYWDoeTHVV3rsvoTm49p5Q+eXpndQaxCkhr0MvE5BI0b9uVkTAVzlxTygM?=
 =?us-ascii?Q?S/rEzSzD14Ddy+ni2kM/MUQoBb+PCgTwgG/ED3db9Saww4HB0L1om1w+aITl?=
 =?us-ascii?Q?VxuOhSEnWjBdcKDgjh/6LHHcGyj78Ea2vjA/xzUnX1BIseJa23p424xsdBEm?=
 =?us-ascii?Q?+3AsW/P7e8ut6WM/iiy3Wxnd4Et683MN2c6PTnV6dljNaYpxFCZscx/t+c3z?=
 =?us-ascii?Q?iKlDlBH+fnQm61NnoblCkUVo5gRd0Vuoyf96rp1SnPn42hoG01N8xc705l2K?=
 =?us-ascii?Q?5Gj24bUdyJ+U1WsKvs5Go555bxkEJlecKmi1tXyUxrovUVBUOffn+hjVH1NV?=
 =?us-ascii?Q?DI0iCKfWDPIKentJVYsyO3S8Wh3W/WMOmHa32/OjsmMWMVc0pEjcGyc4AxoH?=
 =?us-ascii?Q?vTziLLChqAKFxhVYTkNF/0XMqDpNLiNH+S+vi2RoiFkN2nuEQUd8TuWwWM75?=
 =?us-ascii?Q?Oh9+qMmiFOlTznsqEYpuWDcfnYvZGfOlAuIvXLU3K1jtUDnDy05UjhuXymwv?=
 =?us-ascii?Q?M12K/VP1FtEkbKjUuS7INmNCbkNpPZDK47wR3TWFbqBXtCBSvmS7Y4kceRhc?=
 =?us-ascii?Q?Rq02FnxjHC5KBaqeXjL85nWJ2vmpeAiii8vNDhE1cQiKw7DtVZeVDM2BDZBS?=
 =?us-ascii?Q?Bkd5F2poTYS8IZ55VtppRgP1WRLvm0XfBOR3JiQuOv3NWfF5B3+A8FzpTSXT?=
 =?us-ascii?Q?B2PAfUkrCtJEpY70ocDDIzeyt5xTDE7Mg7WjbTT0waQW9wGdEKVxtD9v1pIV?=
 =?us-ascii?Q?tpfbzstV9TDMN3PxGnD5mJXON9/3vRIBrei8J/b+E3T9PrSgSEmaPg/HCZ+v?=
 =?us-ascii?Q?tVSEB5CPVx8V6SiRt1G7raWndMkRoymsdul7CRWWlgJrZ8iLGAudNG68+5Ns?=
 =?us-ascii?Q?Afzg606Mkicjdf0V+/L7i9Apgn1DxBFIja8MaT1b/GzuT4+bp8BrrEh/tkoa?=
 =?us-ascii?Q?Yov8aE0us7dIrbMajZsn44Kmk27uDiTzk+Gp3zK8yrI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3721.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ef9154a-4a17-43b7-d597-08d895a4469b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2020 02:53:26.3169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cwyhwV6ezneEbgq+1JBLRLpMuRB0StYCfiJ87UpSLBg+x3GOQgu+TggLrqAFBd7bjonJk/K5TdUkV6mpf0INDvHAdtoXBPy/y9cDTK7+LyGvoRUzLEA8QllNCsHNQBlW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2668
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Vinod.

> -----Original Message-----
> From: Vinod Koul <vkoul@kernel.org>
> Sent: Monday, November 30, 2020 6:02 PM
> To: Wan Mohamad, Wan Ahmad Zainie
> <wan.ahmad.zainie.wan.mohamad@intel.com>
> Cc: kishon@ti.com; robh+dt@kernel.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; andriy.shevchenko@linux.intel.com;
> mgross@linux.intel.com; Raja Subramanian, Lakshmi Bai
> <lakshmi.bai.raja.subramanian@intel.com>
> Subject: Re: [PATCH v4 0/2] phy: intel: Add Keem Bay USB PHY support
>=20
> On 16-11-20, 20:08, Wan Ahmad Zainie wrote:
> > Hi.
> >
> > Intel Keem Bay USB subsystem incorporates DesignWare USB3.1
> > controller, an USB3.1 (Gen1/2) PHY and an USB2.0 PHY. It is a Dual
> > Role Device (DRD), operating as either a USB host or a USB device.
>=20
> Applied all, thanks
>=20
> --
> ~Vinod
