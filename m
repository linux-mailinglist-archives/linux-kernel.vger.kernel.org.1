Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1A972EFE1D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 07:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbhAIGKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 01:10:03 -0500
Received: from mga03.intel.com ([134.134.136.65]:9152 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725850AbhAIGKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 01:10:03 -0500
IronPort-SDR: vCgnhn3mxPIBL4pne4M9kbiJ/TMi75IOvIYGoW07aPvWHhgAYRiJKKHDeZMhDYs2VNS8BOZTmt
 nFrAsYEy96Nw==
X-IronPort-AV: E=McAfee;i="6000,8403,9858"; a="177786731"
X-IronPort-AV: E=Sophos;i="5.79,333,1602572400"; 
   d="scan'208";a="177786731"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2021 22:09:22 -0800
IronPort-SDR: nMdbyj4cWoQ2nu3AQbRCrlFT/Gds32xvdT+KdU6EoxB1ykUyZom47CcyJNOeAdV/zPJUvVCJ83
 ZC1m8uZluxzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,333,1602572400"; 
   d="scan'208";a="423185435"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 08 Jan 2021 22:09:21 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 8 Jan 2021 22:09:21 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 8 Jan 2021 22:09:21 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 8 Jan 2021 22:09:21 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Fri, 8 Jan 2021 22:09:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZQbyHBk6SutLwI7ZSFHpYmASQBMqmRfjpy474kpyCmLvGSH2QKxf/GICN9y6VIM5mdeQcJKkn8QYOiLLFQIHBIiLBoLMueR7nW38IfWbhxlD3sNMSxmgSQF1aD3Zxg4VMtx1AL81NCrrx063AVlHqWgP6f/ixiZ/m9nTaLqYfGVYqfH0nJjMWzaCNxudYDO0Ap3Tv43YnSZJtNdskAkxYW1wKOhuZTdYtZBaB9iQ4FTiByMAlO3XSpv71W7a9EMcsMIrZocWWNRxj6sY+ZieDatCZmC+XD4Ws/3H05tuesGnpIy3fayGBq8KOT1jxLYnNMPFwAN2fS7NDhdJWiWvXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZgLr8Kz1JxoFDVUP6KXl48pzSdBYHb0TXebJrlC3kRs=;
 b=Ti/WxLOAe/8tsxMU/ds8TrzDouHtFay4socmnu5TKzUkkayZuyBLno8CX2Ts5k6pu+u3jcHX/83LA3q6citCFFXOCLFCfQ5+KrWfz3sbcmMBKOohyWkatviFf0nAHZkBPpdrubdMJGJFfc+ytdOVg3cwmFs2na5hE8c0vg8JLl4Ui4tLyWZ8t5yWmrnfdLTMgKF3r+ykPF9be6BpdkeA/Ztqq90f5SoiWXdXWel4mVmvLOcl+DA27C/LMhqNRm02xU2OPEbBQ5rq5sn3LQPDcnKjBqEY9SbMVj5tuxf7JueFvCKs/K20zgWzyIicGOhHF4DKfC0wWyVRQw9ZoM5QxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZgLr8Kz1JxoFDVUP6KXl48pzSdBYHb0TXebJrlC3kRs=;
 b=OTvYGrtqjpK2IodwDyJcY0eMcNqLZWlxRHVG2E7gXClTTk+wJad29g3+SilQ0EzCdrM6lfxUeysbfRUMHA42rROoxukQodAXVRdw+eScfQNPbya18tE61Unrh3tWDS5uPhEmohBn7GiNSPFoORDOCo94s5MVoDnRJPa0YTtSkXI=
Received: from SA2PR11MB5018.namprd11.prod.outlook.com (2603:10b6:806:11a::20)
 by SN6PR11MB2768.namprd11.prod.outlook.com (2603:10b6:805:62::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Sat, 9 Jan
 2021 06:09:18 +0000
Received: from SA2PR11MB5018.namprd11.prod.outlook.com
 ([fe80::95d4:6cec:fd81:5712]) by SA2PR11MB5018.namprd11.prod.outlook.com
 ([fe80::95d4:6cec:fd81:5712%6]) with mapi id 15.20.3742.008; Sat, 9 Jan 2021
 06:09:18 +0000
From:   "Chen, Mike Ximing" <mike.ximing.chen@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>
Subject: RE: [PATCH v8 01/20] dlb: add skeleton for DLB driver
Thread-Topic: [PATCH v8 01/20] dlb: add skeleton for DLB driver
Thread-Index: AQHW4w6fsZ61IxoEskW9sP4CiaMTeqocknsAgAI9yfA=
Date:   Sat, 9 Jan 2021 06:09:18 +0000
Message-ID: <SA2PR11MB5018C88743F2524BC8C5CE6CD9AD0@SA2PR11MB5018.namprd11.prod.outlook.com>
References: <20210105025839.23169-1-mike.ximing.chen@intel.com>
 <20210105025839.23169-2-mike.ximing.chen@intel.com>
 <X/dilO0pQI3GVh6F@kroah.com>
In-Reply-To: <X/dilO0pQI3GVh6F@kroah.com>
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
x-ms-office365-filtering-correlation-id: 7229030e-e0e0-4a25-ea6f-08d8b4651970
x-ms-traffictypediagnostic: SN6PR11MB2768:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB276835C193B7A8FAC94ADF8CD9AD0@SN6PR11MB2768.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9ExMt5rl6bzcnDw1rpYQTX+bNHQ7UbZIx+STkNqlYzH2qF8YJ4u9lZe0iGd/gn0KgJl0m8btwhpjAqDBQLASke/9Ua96ayauQNY6B8pPdXZyhp2u0tuDvXAbhdcixwxZlF8LROSgUN23qv3i/YdDHZ42zr+ZbSCztURU2RmBtdxbgOHQAMkZP7T80mSwd7SOxkG+VcLPl2wJvjSDl+UycKIU8K6/MAvoNNAc83l5RByDbGnwFMWHIIXwMpXiwfc00f1AnNqiTb7EpNLfKinXwAscOTC5/Q7W4UslvdZB9kglGi/mYeJSF5EC4fjvqSw7m8ZPsfSZs2qnIHDYBUsNzKjbBbd6o/yCcITxs+nNGEaFrK7bb3rdWFpsA8YTxHc2uEF7ZnUZ+ENziBDURdEPxA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5018.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(376002)(366004)(39860400002)(66446008)(54906003)(9686003)(76116006)(5660300002)(4326008)(316002)(66476007)(66946007)(8676002)(2906002)(52536014)(33656002)(64756008)(71200400001)(478600001)(8936002)(7696005)(86362001)(26005)(186003)(55016002)(6506007)(83380400001)(53546011)(6916009)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?9tqfc5wI0T6eGWMCNpfVAKi8xG80YHAxMoa70jW1YhKVzILYyUs1y1buen45?=
 =?us-ascii?Q?IuF/YM31kHauEbqLrqUejwpVy4XLPbFP67DfB8AE1YeY4YP/mvl5oD5nZQfn?=
 =?us-ascii?Q?9DjUrrOFAfFVbA1lUTQKnP5Uiv2n9azUnFk/4LbGZzjOsPx1MRgtDSLUSlK5?=
 =?us-ascii?Q?MNPvgEtOmjV5FkBc3AQ3SQIqpI7bDOXHQE/qmpm7cY2d/K8ADdLSQPX+xStr?=
 =?us-ascii?Q?Lk1EVTpMypYfbIKWskH4Tnyd+wQhO0ll9hD93glxF50WztXfVp3GIeIOK5z/?=
 =?us-ascii?Q?3vlL2pB3ZZEa6xy/CYP7/u0NZEQrk0ab0GxIV8j8AtSOxpraJ0Wm3rcZ58ZY?=
 =?us-ascii?Q?gh4g9Eag0P2YYygvadNwVYkqx7f/vMuHbmSn/TimceW+ZQ7sLcAZLSn6DY7h?=
 =?us-ascii?Q?cUf65f3R3lZ3zjrWUiBf2/DLJCoPlEEn/xYhQE3lBhxhNHzZxTN5b5pQWBan?=
 =?us-ascii?Q?0TGNSZkm/aUHawVqUerWlIwXy37fk5RO7OrJhrkYMghkIGki+2Av/JbwGgd4?=
 =?us-ascii?Q?02XYWqnYaOln95IP/RzCW5Iy13mwkU6dqnRiCDz8D+kD7W7W8mMgDBFnVOv2?=
 =?us-ascii?Q?7ac1m+o4mH4L8IDUYqKef9+aRWoZLt5akkdFLlZowrRsrrhuxV3H9BfpAR4d?=
 =?us-ascii?Q?swPS/u4H2d6h0MBsgMkzq5Z5zvw0l+qMaUAx4bMLkvOV2G8cykqxI2PATAwV?=
 =?us-ascii?Q?yBvCHjQREkSPDY5z9OdUQ+NdJgLx9xcUJQkQ1LgEsr1+atujG4Y3YQbBsJuk?=
 =?us-ascii?Q?fQKraBVjNZaFNdcgjbLH6reAt+r1Hbe6t/Co4PXPHFYQMSujaiqNPt6gOZHv?=
 =?us-ascii?Q?BmXgwf8j9tGJuxEChQxp5MsNfhYKUPZ4kImB5iTtAdIy0XwKBLRcSBNEyzQV?=
 =?us-ascii?Q?rdzbxoF2YPH63oa0iYqQnYR/pIFD+Ak55tfE+u9AUPTGixcuN8/m5bwdyxcH?=
 =?us-ascii?Q?RXEdHZiGk8xNbtun0mXl6Ufg1MqqunxggW7bomo6srw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5018.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7229030e-e0e0-4a25-ea6f-08d8b4651970
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2021 06:09:18.3018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 89R/xNtYLLN7CL03qlFs4ZZIRWoNgnSk8tVmmUv8iXPNZafC+ykHjl511/t15X9a4U8x6LULOIxndz4HxpF2lRDGb1QIZn2MVxtxqOdigkE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2768
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Thursday, January 7, 2021 2:36 PM
> To: Chen, Mike Ximing <mike.ximing.chen@intel.com>
> Cc: linux-kernel@vger.kernel.org; arnd@arndb.de; Williams, Dan J
> <dan.j.williams@intel.com>; pierre-louis.bossart@linux.intel.com; Gage Ea=
ds
> <gage.eads@intel.com>
> Subject: Re: [PATCH v8 01/20] dlb: add skeleton for DLB driver
>=20
> On Mon, Jan 04, 2021 at 08:58:20PM -0600, Mike Ximing Chen wrote:
> > +static int dlb_probe(struct pci_dev *pdev,
> > +		     const struct pci_device_id *pdev_id)
> > +{
> > +	struct dlb *dlb;
> > +	int ret;
> > +
> > +	dlb =3D devm_kzalloc(&pdev->dev, sizeof(*dlb), GFP_KERNEL);
> > +	if (!dlb)
> > +		return -ENOMEM;
> > +
> > +	pci_set_drvdata(pdev, dlb);
> > +
> > +	dlb->pdev =3D pdev;
> > +
> > +	spin_lock(&dlb_ids_lock);
> > +	dlb->id =3D idr_alloc(&dlb_ids,
> > +			    (void *)dlb,
> > +			    0,
> > +			    DLB_MAX_NUM_DEVICES - 1,
> > +			    GFP_KERNEL);
> > +	spin_unlock(&dlb_ids_lock);
> > +
> > +	if (dlb->id < 0) {
> > +		dev_err(&pdev->dev, "probe: device ID allocation failed\n");
> > +
> > +		ret =3D dlb->id;
> > +		goto alloc_id_fail;
> > +	}
> > +
> > +	ret =3D pcim_enable_device(pdev);
> > +	if (ret !=3D 0) {
> > +		dev_err(&pdev->dev, "pcim_enable_device() returned %d\n", ret);
> > +
> > +		goto pci_enable_device_fail;
> > +	}
> > +
> > +	ret =3D pcim_iomap_regions(pdev,
> > +				 (1U << DLB_CSR_BAR) | (1U << DLB_FUNC_BAR),
> > +				 "dlb");
> > +	if (ret !=3D 0) {
> > +		dev_err(&pdev->dev,
> > +			"pcim_iomap_regions(): returned %d\n", ret);
> > +
> > +		goto pci_enable_device_fail;
> > +	}
> > +
> > +	pci_set_master(pdev);
> > +
> > +	if (pci_enable_pcie_error_reporting(pdev))
> > +		dev_info(&pdev->dev, "[%s()] Failed to enable AER\n", __func__);
>=20
> Shouldn't that be dev_err() and you fail here?
>=20
Some of our earlier devices/platforms do not support AER.  pci_enable_pcie_=
error_reporting() fails,=20
everything else works fine. Will change to dev_err() when the old HWs are p=
hased out.

> And no need for __func__ please, the driver name and device is listed,
> that's all that is necessary.

Will remove __func__.=20
Thanks

>=20
> thanks,
>=20
> greg k-h
