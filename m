Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2FEE233545
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jul 2020 17:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729655AbgG3PZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jul 2020 11:25:55 -0400
Received: from mga09.intel.com ([134.134.136.24]:56272 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbgG3PZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 11:25:53 -0400
IronPort-SDR: GYL+WbT1GLgI5OVrzgOR86qKHkeNlNfMS26OClw8hmxkGuR6gOoIw+YxfxS+liNNjLOm7Xx1O3
 +kGRYhkw2Gjw==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="152842083"
X-IronPort-AV: E=Sophos;i="5.75,414,1589266800"; 
   d="scan'208";a="152842083"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2020 08:25:50 -0700
IronPort-SDR: SdwgJFATePeUW8owEyKFxzDrlB5i07Kuz19mR8V/1na2uNQFVk/4pGf4OojmNT+vrb8xShQ05W
 ch6YXUaGb87Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,414,1589266800"; 
   d="scan'208";a="465278697"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP; 30 Jul 2020 08:25:49 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 30 Jul 2020 08:25:49 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 30 Jul 2020 08:25:49 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 30 Jul 2020 08:25:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cKj1LWR9Y9U/FpK0PhXTfglDm08mU7Yc8Gt2BMDu6vKhArzexxlA1Lzxv4HTd5FeyweCEk9FkdCI1tWd0dYEErDnyX1S0OPrXp/I6P5ZSaP+Oi8MHrkhAF28H5g1UpSOwDnihxzmznqaS4nZ7UMukxlCsLYpfqkyM6549TN4jylgN5096s+L4zhq+Gr59dL4R1M9opgvmS0HClONipWU3AdpEJPhj1b8V4PQEYLwlYhS5r13S0B5Wa0SJ+yoSE5VWg2/NENF6hDtqVlUFGx47HYvTU9PstGd6WfgoHGE+5opl83KKmCS8+OBGTRXqTVproWSdaNYGCXYkxaFDRnzsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22ZMWoeRZlxD52Z5OjLWCkypAV6ESzReBe1c+AANCRY=;
 b=JGUqIHpzIN4xIzFLC+usshfhAozmcn3OMbLg0/8dGq6x5WjxrshuLAvJzLvUHqdwbLgyI/yr6GggjfnFYeiMJxcDZZyRfu294jrgF9jyvt6jX3ORm7rqbqEevnwjbe+8NsQhoAZ9KW0EmyKhZIuZZMYpGk0eSYMlZxU8O+X0G2vvMyDR640aFeuQp0KJ6uHVadwz2+PBoN8291wCyKjFr6FQaITt8XqJuvxBmgiHPn0c6JrGPmEap7wNJPEIWJ/BxXpG2TgJS3fiX0vn0wX5VyIhHKBlJqj68oJK6m56p6yhUS4JojppmP8rDBGL5eyCzpGOFxk1AmmBzpRaOwzoLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22ZMWoeRZlxD52Z5OjLWCkypAV6ESzReBe1c+AANCRY=;
 b=LfLmHrDmrnJt6BaJTLOXHNsnQd7fAAJpTGanHaib5N3uJZIlkVg0xBSVRUtrTjCbkYCtal72lCHwtFw3iIM6/BnxLFYbZKnSei+eF3B88LYdIU/KMdjM+VkQxfyfwRfYUAIqoBx1SvSVG9fHu9HJbDePF8ijxT491tdNgAr6Usk=
Received: from DM6PR11MB3642.namprd11.prod.outlook.com (2603:10b6:5:138::26)
 by DM6PR11MB3340.namprd11.prod.outlook.com (2603:10b6:5:56::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17; Thu, 30 Jul
 2020 15:25:47 +0000
Received: from DM6PR11MB3642.namprd11.prod.outlook.com
 ([fe80::f043:4bdc:ef57:1b41]) by DM6PR11MB3642.namprd11.prod.outlook.com
 ([fe80::f043:4bdc:ef57:1b41%5]) with mapi id 15.20.3239.019; Thu, 30 Jul 2020
 15:25:47 +0000
From:   "Lu, Brent" <brent.lu@intel.com>
To:     Takashi Iwai <tiwai@suse.de>
CC:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "Guennadi Liakhovetski" <guennadi.liakhovetski@linux.intel.com>,
        "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Sam McNally <sammc@chromium.org>,
        "Mark Brown" <broonie@kernel.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Daniel Stuart <daniel.stuart14@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Damian van Soelen <dj.vsoelen@gmail.com>
Subject: RE: [PATCH v2 0/2] Add period size constraint for Atom Chromebook
Thread-Topic: [PATCH v2 0/2] Add period size constraint for Atom Chromebook
Thread-Index: AQHWZkoHaHNzjDWzQkeprEz0RLpK5KkgOKMAgAAEOjA=
Date:   Thu, 30 Jul 2020 15:25:47 +0000
Message-ID: <DM6PR11MB3642280551889996960F164E97710@DM6PR11MB3642.namprd11.prod.outlook.com>
References: <1596096815-32043-1-git-send-email-brent.lu@intel.com>
 <s5h8sf1caer.wl-tiwai@suse.de>
In-Reply-To: <s5h8sf1caer.wl-tiwai@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=intel.com;
x-originating-ip: [114.25.81.97]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7ae87027-1732-4cb7-81c2-08d8349cd599
x-ms-traffictypediagnostic: DM6PR11MB3340:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB334032D3850C325E3D6A49EC97710@DM6PR11MB3340.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zif+QR2mwl0XrkHx50sDLEZltQl9HUeU8F8T/V+mL4eC+WSyfUmDY6F254n4CGIV8au9J9l7ETJQFC8EvIsxhE46sQRGnuL10jjY2BWEoVSIPpi1NepLXeAv9QCVtvIUgMz8qaIFHiRWqAfgGiJN2Nf8AeRgvScVgotQcovaOg8aNtxnKkk55+saey7tcYNRptzRul6yq585D8xhAuDlxUsDvMDSzJlUBg0dFpqpt4L8JoumIJabsGCYAeIxj6QnAuVLbKa4BU5Ax6xMdTZXSes1XIcedqqhv5jxJnoRu0TjMLieeIp+C0722i+dHkJ9l5N77pgHnFxOY559NRvLmg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3642.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(39860400002)(346002)(136003)(366004)(26005)(66446008)(64756008)(76116006)(2906002)(6916009)(7416002)(4326008)(54906003)(86362001)(316002)(478600001)(6506007)(71200400001)(7696005)(66476007)(66556008)(186003)(8676002)(33656002)(55016002)(8936002)(52536014)(66946007)(83380400001)(5660300002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: A4Za5mt2o8fPBbmIdWCqJHFwrsI3FNiSEKuE/SZjB5J0VTISn+CxhliWiKDHKMBcJc4TsFFsl4KDW+5J0aAVD3wvKB2BROkjKYhOPXikGx9DGEMH8J1RRvKJ0SkJEactHuWu7PS5VYISLYKCN6g4TRJszxetFUsILb1k7R0T/8bsIwGbvNji9JzSV4qWLWTV5gnAurJ1boBD2e7l7+9ta8nq3rn4VPILp3KpaYzBJf0NV1O/sbUbLULaG4gVwSh+NTkicW5QWCxhg1qxH0wagEUUEAFSaRFTsDeS4tmXPMJHTwHPSKHfrKxmXfUEJVrTVhpOE6kw2SQcrkEfNI6CS4fSG1puTbxmRa2YyAlVbGrJNFHPxOV7GrrIxObcQNLF7VnLcpLWOu/srBw3KFGIl8w0AbpEH1tgYcWWIzEpSKCsu/tx+ZXXrqwlJWL6hRcCDXrNRbFTm5zxkD1vbkBiH/5C6RvlvwT0RUIQX7B5DmFlHGxKvmEZmSD5KsQ5GNPOnuo2lFNyGHGLb3OUq9cL84Qi6jd9QbpOgoOLwXKYS69xA+FJhhXHrte9PPRVgFHLz0TtolvXvVEPoLwfCtFtnX5vDv8OjV8I9+iixZpjPHh8U/Cu/wh0JPQoCgCFlkMV3i2fzWZ/Md/8z9pzE9sjbw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3642.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ae87027-1732-4cb7-81c2-08d8349cd599
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2020 15:25:47.3746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5ritYdrzGPl/qNmWs1LlMk7dERHZ/3Sdvs+FQw3upJoyvWklXzaApWDLYb5F5FJUajf9/g2dDuF+zUkRgs74uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3340
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > Two different constraints are implemented: one is in platform's CPU
> > DAI to enforce period sizes which are already used in Android BSP. The
> > other is in Atom Chromebook's machine driver to use 240 as period size.
> >
> > Changes since v1:
> > -Add comma at the end of media_period_size array declaration.
>=20
> Is it a hardware restriction?  Unless it's a must for some hardware issue=
s,
> enforcing such a small period size is nothing but a drawback for a system
> without CRAS.

Hi Takashi,

This patch is cherry-picked from Chrome's branch which is originally implem=
ented
by google. They found this value works best with CRAS and these two machine
drivers are for Chromebooks. Other BSW machine drivers are untouched.


Regards,
Brent

>=20
>=20
> thanks,
>=20
> Takashi
>=20
> >
> > Brent Lu (1):
> >   ASoC: intel: atom: Add period size constraint
> >
> > Yu-Hsuan Hsu (1):
> >   ASoC: Intel: Add period size constraint on strago board
> >
> >  sound/soc/intel/atom/sst-mfld-platform-pcm.c | 15 +++++++++++++++
> > sound/soc/intel/boards/cht_bsw_max98090_ti.c | 14 +++++++++++++-
> >  sound/soc/intel/boards/cht_bsw_rt5645.c      | 14 +++++++++++++-
> >  3 files changed, 41 insertions(+), 2 deletions(-)
> >
> > --
> > 2.7.4
> >
