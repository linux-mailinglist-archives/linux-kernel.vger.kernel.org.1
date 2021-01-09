Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 727E02EFE20
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 07:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbhAIGS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 01:18:26 -0500
Received: from mga12.intel.com ([192.55.52.136]:53689 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725915AbhAIGS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 01:18:26 -0500
IronPort-SDR: OBMB3ajgwKmJ3tXYuTZQ8iQBBG6BQnijA/KoooKLwC9yTaxvZnxSrD6+y9mlAtbaFLbKYRvMeA
 IoKVQJULiBtg==
X-IronPort-AV: E=McAfee;i="6000,8403,9858"; a="156873367"
X-IronPort-AV: E=Sophos;i="5.79,333,1602572400"; 
   d="scan'208";a="156873367"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2021 22:17:45 -0800
IronPort-SDR: yFGdWJC34ps3kuqYZzquz1qkUYGDeXySit0OR8/e9dhu88OHUQVhJQjyXmSp/qfFs6Zh3bqgXN
 BR007qRe8QSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,333,1602572400"; 
   d="scan'208";a="423186673"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga001.jf.intel.com with ESMTP; 08 Jan 2021 22:17:45 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 8 Jan 2021 22:17:44 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 8 Jan 2021 22:17:44 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 8 Jan 2021 22:17:44 -0800
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.51) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Fri, 8 Jan 2021 22:17:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GIuoP1k6QtmnChdZ5yslMAOBtXfINYF0Yvm/U8FXeFgs1jjfkLMxJas38hJDUGKOiFt+Ar8laMAJ65Dae5I/wo09Wyv0KXznXWkoQjJ0z8Sn/iUWT2hrsULWFq3WDC5v6Ab+0/F6c0ZcDKm5UBmTGUn5el+dir2VgUWta5S5AN8kfRfStVt6N8SLoW+OMphm7a5kJ8m/YPMPmQpUT45O3dMplXRo6pBQNRTIpV4XvDC/TfstZfbWTnYC5FrARwE5R1t1RxUDZ8JhDlqD9kYoMQ4GgE7HXanRQc8oQhTw/rdWTm+nTOL6Scsbv3Tu5YwZKrwUwK0qzloyLkYGR05m0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/y0RfCHMtbfiDRjqzBu/XFMD2fHcCLXvnL2/viPVrg=;
 b=SoqPqbF1cm1Ag7Omasgfa95UiGRhH5pgWZP0Yg+XS1C4dVaZ3UsP+5NM/aKEDDC1T0ALF1sgucekk/CATiiiA+bk8SRNJ1YQ05XcvAxNfpiy+8LUfIOCov1w1Rq6G+AEwjc93lu9EZeZD9CYXR5rpWbWL9DOYdBbiZWWI3/TBuwLHbvYrwt/ol53Cehgp/wIlmIYo8yHgWUw3StdIQv7O10iXNB5tATB0DuwfsWDMykt9xVI/WPSHQUE6mhgsl22oXi3CjlTaQwILYEC944Zsw0GJBUckbGGT72oVdbEm8ZJG5ZJKBRewBRB7VteLDIPdLToC6x8XNoasDEcy9JHaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/y0RfCHMtbfiDRjqzBu/XFMD2fHcCLXvnL2/viPVrg=;
 b=NfaeIV0441TJvsMw+qc3aDvJRTabWfQIKSG2gHEeY9A3cHyd8zTF0eCcalK7CQXs6AV/qCU7tWGj8wnX9bxeIekNylsRh9id0IIjup32axTAVYsPYtdATgXOiROXo4BpCsJEh5tPSePjxMBrWiWX9RQgaKM46vflpkiyGXJa5rc=
Received: from SA2PR11MB5018.namprd11.prod.outlook.com (2603:10b6:806:11a::20)
 by SA2PR11MB4873.namprd11.prod.outlook.com (2603:10b6:806:113::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.11; Sat, 9 Jan
 2021 06:17:42 +0000
Received: from SA2PR11MB5018.namprd11.prod.outlook.com
 ([fe80::95d4:6cec:fd81:5712]) by SA2PR11MB5018.namprd11.prod.outlook.com
 ([fe80::95d4:6cec:fd81:5712%6]) with mapi id 15.20.3742.008; Sat, 9 Jan 2021
 06:17:42 +0000
From:   "Chen, Mike Ximing" <mike.ximing.chen@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        Gage Eads <gage.eads@intel.com>
Subject: RE: [PATCH v8 04/20] dlb: add device ioctl layer and first three
 ioctls
Thread-Topic: [PATCH v8 04/20] dlb: add device ioctl layer and first three
 ioctls
Thread-Index: AQHW4w80G3nX6IgdcUmItLJqTgp06qock++AgAJCwwA=
Date:   Sat, 9 Jan 2021 06:17:41 +0000
Message-ID: <SA2PR11MB5018E707664618A1B7DFA40ED9AD0@SA2PR11MB5018.namprd11.prod.outlook.com>
References: <20210105025839.23169-1-mike.ximing.chen@intel.com>
 <20210105025839.23169-5-mike.ximing.chen@intel.com>
 <X/djzcBWzwDrMmpA@kroah.com>
In-Reply-To: <X/djzcBWzwDrMmpA@kroah.com>
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
x-ms-office365-filtering-correlation-id: d488ddd2-370e-4229-53d1-08d8b46645a5
x-ms-traffictypediagnostic: SA2PR11MB4873:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA2PR11MB4873F733B0777487BF6621D3D9AD0@SA2PR11MB4873.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d0m7jkmV/4fRtZYOHS1aT8DuYT4xLPDUbR8FxjviKiGZUH13J0wvpnKhTUJYe8F0VK+Xlw/9C5OqhtzF/vxINb6bWkNHs/SXQdkZoE88zTbLS1ZsG4ISkm5rizlLVZNUF08k/VskkbKvocFPv6TOP/kLUZZQXO/heBjLYi0XHByjOhXRop/cwXiKRToiDCieu0ecxsfHfVvRHiokHINDcZ7yRSR/YkU5qejSBu75L1R1EB3HAgj3LW7QbGRLcXzRoA/9Ia1ORii9jJzADniu5fhO5Iw6+Y0pPGZt+wPVfowW4GYXL7HcZuu/npkcZTrywtJ7s/sex/m5GmF0+EBe6aaGkXWhKX/sD6AY6Xl9DSqbHcGDzhnf1UVRrdR9favHc1ezrp6w449ikqM40rRgcw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5018.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(366004)(39860400002)(346002)(66946007)(9686003)(55016002)(8676002)(66446008)(66476007)(64756008)(66556008)(8936002)(2906002)(54906003)(76116006)(186003)(316002)(52536014)(26005)(83380400001)(86362001)(6506007)(53546011)(4744005)(7696005)(5660300002)(33656002)(6916009)(478600001)(4326008)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?OIX9WVBV8y0a+zCPUA9N+9tFSXoR4lyw9wKc8J9BwQw2Y6diPDAfo0LLqcdG?=
 =?us-ascii?Q?SHWpMnxtASYyMaqymkY09QB53oilQ59+JKcrrs+ou1l6ijMhQb2vbABImrCA?=
 =?us-ascii?Q?0gFKoH7q6pWdmFzd4AQlaFksE8D57L9GRCOHwuzYgGEmCvmQ5pFHsm5EmCRY?=
 =?us-ascii?Q?h/vkaPPgr8AGRJOa2uMso//7CAC5CSJXjzvsJ/UB6CJpi/6YL/aZmWLfhZAU?=
 =?us-ascii?Q?3ksj/XKsLcj/7f5RaeECKkYQUSN4qvGejsfkkYObQp+CVc8kbpuA7xu62u6b?=
 =?us-ascii?Q?+1wmrIcURwTV0aVNaSSJXBTqMWDkVALASAFaiMkCcgo8iPioZru4wnXXBe47?=
 =?us-ascii?Q?1q8BqVySnJkaoumsFHhiI0R5/Q0FosynfIImJrZio1WR0B4/F7JL73k57AF7?=
 =?us-ascii?Q?+rxL7WeNu6tM7UlyPnWMCJy/uMkABkfLURiNdGqOBeE0Mr/R6maosT0f+HZ0?=
 =?us-ascii?Q?1HEsi/+AEAAJDFtkZOdgkZQhAyUTYMPZzlZFGe5Rydwj+TLfPWeBnj3yioYP?=
 =?us-ascii?Q?KeLotzMOJaM9TBRs6IXJHrN/ppOGWPYlcesEgc9aSBfhpYwxdhq8pKRn+Wiz?=
 =?us-ascii?Q?TgIQZaIXdUAGqUJbQduuzR5O20q++EXMygmh4HyhaNb1eOOfO4RGTV4/fs1q?=
 =?us-ascii?Q?PJr2k9YOqOvECkXQ41/9ZmYWXeksgDBCoRBjnbU6lnylDTNsY7I0Bi4v5bTv?=
 =?us-ascii?Q?tdB6l9T/02QvZzL5whSmN3eL9RXJAp8Bdyl7k32cvjGAiZinstTz9AYuaGoE?=
 =?us-ascii?Q?+H82azA874LptKayPMGtPZuLxroEH0ALQ5DnshAICpuFNZ71Tqn0jhuuA2yR?=
 =?us-ascii?Q?hGJIxgmLqcLIMK4lFzLMPOyaIpPqGgii15EtRG+FaBCJZ0TgZ1KcM1aKNpa7?=
 =?us-ascii?Q?L2GK3vyB7F4kVFVKJBCXPY2qMFb7espCrgEp3JiiOTJl6wXH/1l3w2HOvNOV?=
 =?us-ascii?Q?Qgvf+UO48N6pgoHvcmTKxBBCLbSn7Rs6NvRKZDH0IOo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5018.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d488ddd2-370e-4229-53d1-08d8b46645a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2021 06:17:41.9468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gXCMbZfRb5bMqFsMwwYYbi0NTCJ9h208TyqnE+aFYdEHtw3ZN6VO+zqPfDgDY48jebvvO9wddRSqCQkCh0GDzKLEO2M5P3pmNna9eQnvHmA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4873
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Thursday, January 7, 2021 2:41 PM
> To: Chen, Mike Ximing <mike.ximing.chen@intel.com>
> Cc: linux-kernel@vger.kernel.org; arnd@arndb.de; Williams, Dan J
> <dan.j.williams@intel.com>; pierre-louis.bossart@linux.intel.com; Gage Ea=
ds
> <gage.eads@intel.com>
> Subject: Re: [PATCH v8 04/20] dlb: add device ioctl layer and first three=
 ioctls
>=20
> > diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst
> b/Documentation/userspace-api/ioctl/ioctl-number.rst
> > index 55a2d9b2ce33..afca043d59f8 100644
> > --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> > +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> > @@ -241,6 +241,7 @@ Code  Seq#    Include File
> Comments
> >  'h'   00-7F                                                          c=
onflict! Charon filesystem
> >                                                                       <=
mailto:zapman@interlan.net>
> >  'h'   00-1F  linux/hpet.h                                            c=
onflict!
> > +'h'   00-1F  uapi/linux/dlb.h                                        c=
onflict!
>=20
> Why are you taking a range that you know there is a conflict for?

OK. We will switch to a unused magic number and range, probably 0x81 00-1F.
Thanks
