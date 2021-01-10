Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD5D2F051B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 05:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbhAJEbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 23:31:24 -0500
Received: from mga05.intel.com ([192.55.52.43]:26952 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbhAJEbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 23:31:24 -0500
IronPort-SDR: uYkpkoZXyMdyPUgKQAht1HzFoOu1keTXh+3oMVCV9Q0JcqYLhLHznH9WDUEd1hSgPQD+KmfXaz
 5CW+DoRI1mvQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9859"; a="262517881"
X-IronPort-AV: E=Sophos;i="5.79,335,1602572400"; 
   d="scan'208";a="262517881"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2021 20:30:41 -0800
IronPort-SDR: PcO+PVxkTzcjIOiNqcXan2k2ahaeDoDgFFTnkWBbzE7MNBGxfXBROE0RV45zeRtMwnUVZU/ZW1
 gZPrYWvZl0yQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,335,1602572400"; 
   d="scan'208";a="380596477"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga008.jf.intel.com with ESMTP; 09 Jan 2021 20:30:41 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 9 Jan 2021 20:30:40 -0800
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 9 Jan 2021 20:30:40 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sat, 9 Jan 2021 20:30:40 -0800
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.51) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Sat, 9 Jan 2021 20:30:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hGdZpNbafSW0bBkMg/FogV985aDzi/RR6FUQkAELdcDFbN/Blnx9YpZHqZIXjsBv+FnwRBML+GhPDHQZFoanDuPf4FhEU4AjwyQxtOHU3ugRaNJfCbrsh2XEnrAaWlQKkrY0EIQqZBgRGql6lShheEzVicjWHU/l/478LJOrrMf1XngUzRJgXMVZ4afDJtyr6WcjF0aFq6hrsL2bFFxcCA77k9l1P3/i6Db44txezUaogyTByFcWSyknGMlwqU1dMQY980YRbOUifaKHevYHbjcvLqo/Q2O0ewrxM6NxiRr+wbP6JcgGNJtdkFAI/8prHoJOl2GuRYDBy0cFVQiJJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wYeqHuSzYDKUVtswycFA1KTfOjtO6ZJ4dlW/JYC6So=;
 b=CX1cDAL4Xg0s8vjOqBtw7Yt4TSkam2bw6a3YJ07YAc7t//DR8PjsfGZ2ULBMNNyuBS/CIBORnkc2gcOc0QvhQpTDdsPJGd47M0NB7x03B8aYuDEnZ0RrN1TJHMmezR+KpB/utcmqBP6LBuYCHQ8+yHNw80uQR4eAx8UvWKpdd04jI5VBfc+UG+0vIhtAoRDuojjUwSpuliR/lThMU0uz/h0HrNsDprHRO2M9cbHFJZAwbPUP0UHMRggRcuaVweL8pa8yaczh5ViWyTR7mNVk0xuFKXb/cZCh5XQTJ4wCHvHiGNr4sxya7AsikTQa12mOGrwx8YFi9AKvhgpg3FyTZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wYeqHuSzYDKUVtswycFA1KTfOjtO6ZJ4dlW/JYC6So=;
 b=L4oOVRtXKtZOrx2Ar3cvajaJNMHvVnE3Z8UMNUXPub4QDAFmU4gOAeNLYonKRNVWroiI5XuPpLTFcGCoIviD0/868NtMfJtG19k4riBvccrYc5PGqPfnXWfkN/pb31KL87sOwPS+0wrqes+xlZHhbk3YEuDpjekMoIwTYgtpLEE=
Received: from SA2PR11MB5018.namprd11.prod.outlook.com (2603:10b6:806:11a::20)
 by SA2PR11MB5017.namprd11.prod.outlook.com (2603:10b6:806:11e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Sun, 10 Jan
 2021 04:30:38 +0000
Received: from SA2PR11MB5018.namprd11.prod.outlook.com
 ([fe80::95d4:6cec:fd81:5712]) by SA2PR11MB5018.namprd11.prod.outlook.com
 ([fe80::95d4:6cec:fd81:5712%6]) with mapi id 15.20.3742.012; Sun, 10 Jan 2021
 04:30:38 +0000
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
Thread-Index: AQHW4w80G3nX6IgdcUmItLJqTgp06qoclpeAgAJCkzCAACUKgIABRdrg
Date:   Sun, 10 Jan 2021 04:30:37 +0000
Message-ID: <SA2PR11MB50187180D63A831DD864041ED9AC0@SA2PR11MB5018.namprd11.prod.outlook.com>
References: <20210105025839.23169-1-mike.ximing.chen@intel.com>
 <20210105025839.23169-5-mike.ximing.chen@intel.com>
 <X/dmB3q6QEd2aQdG@kroah.com>
 <SA2PR11MB5018670AEC81EA93598E1212D9AD0@SA2PR11MB5018.namprd11.prod.outlook.com>
 <X/lqcaLVb+PbbmWg@kroah.com>
In-Reply-To: <X/lqcaLVb+PbbmWg@kroah.com>
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
x-ms-office365-filtering-correlation-id: 4cc85612-6482-47ad-038b-08d8b5207b00
x-ms-traffictypediagnostic: SA2PR11MB5017:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA2PR11MB50170DFC806F10BEE501A676D9AC0@SA2PR11MB5017.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TD6nJEtqUxjGKPC9u9zPffvAPPzQUTVlESOjJcd4YDzSehQ1udyR3RoqH4l6CR7NjvP3Fwn/mOnHND6scj0AUfJ/1vhER63sLog6g6qtPrMNqZJpc5rLNTtmwCAUnIF15XvUxUW2fnQiWVXGv9QNF2CL/Bis8zR6awZyz1glEO1Ksd3EGNjM6Ky8IEX6p/iL7ezWsjLBXSYA+XNI0LtvExwwJk6XHhZ4XYCenc9+27sybzLIT1V8mn4Yh3TB3575zAfs+CJzrB0RGJMLnH1GZ7lyr66980mHsKxtUSovB/Ikjz7ubITYPUvUky6MZo6D/T3ZzMtdLjoFLzQqoadx5I910r2Mit9YcrlOtLihW8ePISqwtrMN1jwzad/58JjmAf7KE2Jw7oEahUkdZBHeuw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5018.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(396003)(136003)(366004)(6506007)(53546011)(8676002)(71200400001)(186003)(5660300002)(66946007)(54906003)(2906002)(478600001)(4326008)(83380400001)(316002)(26005)(66556008)(66446008)(6916009)(33656002)(76116006)(52536014)(7696005)(64756008)(8936002)(66476007)(55016002)(86362001)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?swUx0Mt7AXtz9yXlNQct6RFKlXymrYCAVwR/RJCL/8bT4Fzrnb0p113VlMiQ?=
 =?us-ascii?Q?glqVBNM+8urh8xka0cvGT5Qkm7X3+U/A3CrH0ddVTZ9lX1F4BjyKISWFZDn+?=
 =?us-ascii?Q?ufdYtXNjCljaIqYrywbbuiElbPjlOZKNbIqmDpffDyvrnlM1zSJ63wGp1I8+?=
 =?us-ascii?Q?9c7KFgGbneKRdey5KaLEpEa79+NQw3PHowfv/HyEYM2PE9vtfJ98xP+QkstQ?=
 =?us-ascii?Q?8Wph3NKDGru1rPYgKM6a9BR8TAVrumlIR9gi6yD3K4hnxXuwjDzQjOZJhFTz?=
 =?us-ascii?Q?NvNACMTWuvh09T0pCmChE1xMbQEGSa7FP0dZRptmyOthj7RabfGYnwZutlRN?=
 =?us-ascii?Q?RdSPGUGqkBrodP4PCvGLPMPMsb6h0HZ5FGwwvAv6w4qj5nmN+dojzc+p/WEM?=
 =?us-ascii?Q?8rqDSSdq7Zd0VYb4MS2xpnaTTXbZabBD8M1fsJsZkKgtSTnypY3pCBFeGPqN?=
 =?us-ascii?Q?TfIED1eSo6RhlZQLjo6DfQAS6rFhy+DoF95ZUH9AgRThSizj84Yp1LKIrMIR?=
 =?us-ascii?Q?hafVDK6sFaTerb04AmaJ7Mkxg6KEnzi6Y0s9BDJ56k+62ag3jXYebIhHgCiB?=
 =?us-ascii?Q?BJWM1CAbHHRmYH/LEx6/lLFOIhuX6ybiktb55w7N/vZBidtTlcJ7+RowijCe?=
 =?us-ascii?Q?H0vBNCqTXw8kUp/k1R8P5xeaJoFISi7Q9r+PwXVzy65U/6NsBRZHlZeG/dks?=
 =?us-ascii?Q?17bDKi5qs+0RI17+PbnbGVAMxQ0/PCKTy+uNdym+xiU4a7gj8d0pQHJbMmBT?=
 =?us-ascii?Q?OiJEUozzEnIQkJF91sQ3gpuhXy/+uOmn4PsUN6hU7aV+u2V/txAFTWqTzbTK?=
 =?us-ascii?Q?aTbVfGcplyCUYQlOhoJpzZaC9SPcFRXIN1G8SgbNAwUkbXYS2MQ2IY8VZn7v?=
 =?us-ascii?Q?HbwENDG6VP+QPrIvV4M7WtRr6/4psfZmSkgNhUeNOe1K3oZTs/UGuTHAXXrv?=
 =?us-ascii?Q?hvd4Vx4HjFoWTxhBnIOguCozzjgQrPlITA/2wE34kNM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5018.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cc85612-6482-47ad-038b-08d8b5207b00
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2021 04:30:37.8870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g2gtbNM9VZVSZPeUS3akt+1WcYiYrDjJ9bjhao2MofuMUwgL3X6XJu9g/VcS7W9TOBTMbjVWUO0Grwy/RoI2935zKrF0vRvFVZtFJJkkmB0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5017
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Saturday, January 9, 2021 3:34 AM
> To: Chen, Mike Ximing <mike.ximing.chen@intel.com>
> Cc: linux-kernel@vger.kernel.org; arnd@arndb.de; Williams, Dan J
> <dan.j.williams@intel.com>; pierre-louis.bossart@linux.intel.com
> Subject: Re: [PATCH v8 04/20] dlb: add device ioctl layer and first three=
 ioctls
>=20
> On Sat, Jan 09, 2021 at 07:49:24AM +0000, Chen, Mike Ximing wrote:
> > > > +static int dlb_ioctl_arg_size[NUM_DLB_CMD] =3D {
> > > > +	sizeof(struct dlb_get_device_version_args),
> > > > +	sizeof(struct dlb_create_sched_domain_args),
> > > > +	sizeof(struct dlb_get_num_resources_args)
> > >
> > > That list.
> > >
> > > Ugh, no.  that's no way to write maintainable code that you will be a=
ble
> > > to understand in 2 years.
> > >
> >
> > dlb_ioctl() was implemented with switch-case and real function calls pr=
eviously.
> > We changed to the table/list implementation during a code restructure. =
I will move
> > back to the old implementation.
>=20
> Who said to change this?  And why did they say that?  Please go back to
> those developers and point them at this thread so that doesn't happen
> again...
>=20

It was my fault:(. Will  make sure it doesn't happen again.

>=20
> > > > +#define DLB_DEVICE_VERSION(x) (((x) >> 8) & 0xFF)
> > > > +#define DLB_DEVICE_REVISION(x) ((x) & 0xFF)
> > > > +
> > > > +enum dlb_revisions {
> > > > +	DLB_REV_A0 =3D 0,
> > >
> > > What is a "revision" and why do you care about it?
> >
> > This is for different revisions of hardware. Each revision of hardware =
may have a
> slight different configuration/feature.
>=20
> So what does this mean?  What are you going to do based on it?
>=20
For now, it is primarily informational to user. Different HW revision may h=
ave different features enabled. For example,  certain features may not be a=
vailable in the earlier revision A0 and A1, but are enabled in  the later r=
evisions (B0, C0, etc). User applications that depends on these features ma=
y fail on A0/A1 devices. They can check the device revision/version to conf=
irm that the failure is expected. Users can also implement workarounds to a=
void failures.=20

Thanks
Mike

