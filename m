Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B73BC22C40D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 13:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbgGXLJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 07:09:18 -0400
Received: from mga12.intel.com ([192.55.52.136]:29530 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbgGXLJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 07:09:17 -0400
IronPort-SDR: AgMrKdqNAGASAFpNxphRpPUsYb1u1nPAk/saO7i6+ZDJA6aZrRVjFIl5ZXp22703KWxNFZwBSh
 Tm4ym8TFnuLw==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="130252265"
X-IronPort-AV: E=Sophos;i="5.75,390,1589266800"; 
   d="scan'208";a="130252265"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2020 04:09:15 -0700
IronPort-SDR: AIzhvAkMGQMrHg0t7Ah39BHlPeSG96o8fx2l781tO1yBvfU1xpT8ORc6/kzxM1yzuteUUK2TOH
 YeWL/qsZin9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,390,1589266800"; 
   d="scan'208";a="272557362"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP; 24 Jul 2020 04:09:15 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 24 Jul 2020 04:09:15 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 24 Jul 2020 04:09:15 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Fri, 24 Jul 2020 04:09:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NvLT6/iBgOlnFdd7uBidPztt/2xPjUPYjn/qAiE2hAW5mRFSY341z37CbMpnCPQHCGYHDAJn3/acecvrG9GfymsTfc41crknVeM0Ga1ebKxZnhsM2drLmWn6cVQwVdUbLYaVFrQ3uvLqycuuD4CuvT2g6ftqeSo27/e71YwQX6UWKe0ZtKzjOYg/sEYQmMgGSuRaVytCyNjr78WJNCvTN609Qf7HLZhyBfktCaCVKA8dMpTMFG/JE5aUeDn0apAgBmPo+BtZI3y8nK3vyXzGx8ohe0wlLfa2dyvvb3JOK7PEioD6a3WOMAsXRp6nfUBwm0Bwt09Ibmb8e+7LbzImcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zqLU98Rjo7jYEICPOowq6Q8ebczwvfNMtGQLG7WHtds=;
 b=NQab+W5HmkHbgyInCcLrq946C9M/CZmL7vRuuPiLu6BuVRGBminBOJM27WoJ9zH5vQUB2e9Xsccp9u4VNAW+/Q3G0Dcxjh4DJEPE/g6JSF23zyTEPgR9cAgIWfUN8gzs/r5vZ1wFMpJkRqccEKv+BlKf74c+Ib68UK1v86lFJPMyOTuAY9Q2DM5TiiaaLXU1CEDVXt+1lT1EOTwkCmoxz6AiWNwC/cqv3tC8VIOv8e/2yW/a/luXxzPADSiCW95WbmKrWRreM1w3A+YsTkzToUYtoMcGFqIJYyZ8HjvDfXiSYpJrAexPQxbuTgF3rtG5ayyE6IdpgvSzsJRYBGhcdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zqLU98Rjo7jYEICPOowq6Q8ebczwvfNMtGQLG7WHtds=;
 b=NXS8/o8JY5aBjDW6OnXEaULCXRvAH4wryFrSZrb+9bgk2IXT3GpEHz7bDoQRRfpKuueU7wQUISsqM77fnDOvDu2l133+ywbOgEn3lT95Df0n3Q0g2ddv2tFhUFN1nImsv69J0F1pYdk45QBxi9RLdtY1L3/cnSf4/05ubfe0K5M=
Received: from DM6PR11MB4074.namprd11.prod.outlook.com (2603:10b6:5:5::11) by
 DM6PR11MB4363.namprd11.prod.outlook.com (2603:10b6:5:14f::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.23; Fri, 24 Jul 2020 11:09:12 +0000
Received: from DM6PR11MB4074.namprd11.prod.outlook.com
 ([fe80::5522:cd19:e298:b343]) by DM6PR11MB4074.namprd11.prod.outlook.com
 ([fe80::5522:cd19:e298:b343%7]) with mapi id 15.20.3216.026; Fri, 24 Jul 2020
 11:09:12 +0000
From:   "Liao, Bard" <bard.liao@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
CC:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "vinod.koul@linaro.org" <vinod.koul@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tiwai@suse.de" <tiwai@suse.de>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "jank@cadence.com" <jank@cadence.com>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "rander.wang@linux.intel.com" <rander.wang@linux.intel.com>,
        "ranjani.sridharan@linux.intel.com" 
        <ranjani.sridharan@linux.intel.com>,
        "hui.wang@canonical.com" <hui.wang@canonical.com>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "Kale, Sanyog R" <sanyog.r.kale@intel.com>,
        "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: RE: [PATCH] soundwire: master: enable pm runtime
Thread-Topic: [PATCH] soundwire: master: enable pm runtime
Thread-Index: AQHWYVvU0QhHa7TpV02Bs2JfnPPzd6kWZxaAgAAheaA=
Date:   Fri, 24 Jul 2020 11:09:12 +0000
Message-ID: <DM6PR11MB40743347C935B5B24F278A59FF770@DM6PR11MB4074.namprd11.prod.outlook.com>
References: <20200723134902.26290-1-yung-chuan.liao@linux.intel.com>
 <20200724083201.GB3977020@kroah.com>
In-Reply-To: <20200724083201.GB3977020@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=intel.com;
x-originating-ip: [220.133.4.96]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c882f2e2-377c-4234-d11c-08d82fc1fedb
x-ms-traffictypediagnostic: DM6PR11MB4363:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB43630030E4841FE9733177C3FF770@DM6PR11MB4363.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jv9R5R/950FPRXwraTeDpRJUgleRcy3CzOAQ0oL3XtWb0bOsHP/ast4tZbEPGDmafpr2T/8pzBb0aoFu5jlUXt3TV405rIrQYM1NxvF5SkV/jjjmy6MwTl2eKiczlNZeSISXNQ/LjKW0rSMwvyruoLgNgueZbu40IjSr1JobCSmcj8wWBCR5sTatEwd1CGbsF4Ii8KlFBCRDOETnD4u4bjs6R4v9M4bgU3L3hMoy1vNvi9MFjtgipfbM7fBEKrNI797W4DJw92aW4os+TkhGDu5ITD4c3X1sa/0tRiGW/exr5FM0eHPGZDENHtrB5o1ZyiL4VyLNJDELt28ssXRw0Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4074.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(346002)(136003)(39860400002)(376002)(396003)(26005)(66946007)(5660300002)(55016002)(9686003)(66446008)(66556008)(478600001)(66476007)(53546011)(7416002)(110136005)(6506007)(54906003)(7696005)(64756008)(4326008)(76116006)(186003)(8676002)(86362001)(33656002)(8936002)(52536014)(83380400001)(2906002)(316002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 43kK/ahEdZovd45dEV5VXMNpsP10u/k2goW42hZayCib96RYE5nRvYhfYnYGVRFHFF1IPaKSivDwqOlGTED3wiN9XszXDefpuIgtG3dyMdatoK7vLJjlmPtQzU6uLHB+VzHKBB7QlzvLj5kYtJ/2AuZsiBMBJp3O5pKW5ja4Gmj/jFskPCS72VG7J3nNqJbBGTp7Lh/LN/yRXDSRU8VgMPA6nwf9fJtHPqHK24PRYLxYSVlKrHanc5K9s7NEmI8xF7wavlj0s9crs6jROxaAKEc7hHLEma/kVIM+4XkHl7FbjvCtJWiaD5nyyplAx8MkyeVZiXAZLbDB1kuRl53QGt5k15POF69R8T900QeW4XyvDVAHQssAeqV0l7eSbkJ6AcgVfqrGZL6KS5qM7G8t4WT2H2FmG4gWsFFJ5842ZQWp7JOWnuZGQf9RUhR/+cpqd/bg/nIJaJgoPiWbRZqB9setk+K1C6rGkEnB3F4V5oY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4074.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c882f2e2-377c-4234-d11c-08d82fc1fedb
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2020 11:09:12.2608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tdkVzL+sYK/U85oisB9UWwPELw6GRHWZPV4pSVXpGiJv72jo1i36hemEp8BfkxuCbMq/Rt/RVZzcICNX9g1f1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4363
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Friday, July 24, 2020 4:32 PM
> To: Bard Liao <yung-chuan.liao@linux.intel.com>
> Cc: alsa-devel@alsa-project.org; vkoul@kernel.org; vinod.koul@linaro.org;
> linux-kernel@vger.kernel.org; tiwai@suse.de; broonie@kernel.org;
> jank@cadence.com; srinivas.kandagatla@linaro.org;
> rander.wang@linux.intel.com; ranjani.sridharan@linux.intel.com;
> hui.wang@canonical.com; pierre-louis.bossart@linux.intel.com; Kale, Sanyo=
g
> R <sanyog.r.kale@intel.com>; Lin, Mengdong <mengdong.lin@intel.com>;
> Liao, Bard <bard.liao@intel.com>
> Subject: Re: [PATCH] soundwire: master: enable pm runtime
>=20
> On Thu, Jul 23, 2020 at 09:49:02PM +0800, Bard Liao wrote:
> > We should enable pm runtime.
>=20
> Because why?

The hierarchy of soundwire devices is platform device -> M device -> S
device. A S device is physically attached on the platform device. So the
platform device should be resumed when a S device is resumed. As the
bridge of platform device and S device, we have to implement runtime pm
on M driver. We have set runtime pm ops in M driver already, but still
need to enable runtime pm.

>=20
> Please read the documentation about how to write good changelog
> comments...

Sure. I will update the changelog in next version. Thanks for the advice.

>=20
> greg k-h
