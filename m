Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EECF224899B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 17:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgHRPWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 11:22:09 -0400
Received: from mga06.intel.com ([134.134.136.31]:16522 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726630AbgHRPWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 11:22:06 -0400
IronPort-SDR: FP1+NxWf2bHG903CZqfw7zRP50Y3kLCDoi2bovBHYZhu5GOlSTRveS8I4pS7dwqupoJLKkgZ8B
 Im7h+xf9ugWg==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="216455440"
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; 
   d="scan'208";a="216455440"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 08:22:05 -0700
IronPort-SDR: zyfI/9Opn8PvzFCN/QekRL93Ue4l0fD1DdOQztZ2DYEigADmZOY4SS/uMYAL2xtZSCJiYRuS6N
 CDNGCguSI9Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; 
   d="scan'208";a="400523726"
Received: from unknown (HELO fmsmsx606.amr.corp.intel.com) ([10.18.84.216])
  by fmsmga001.fm.intel.com with ESMTP; 18 Aug 2020 08:22:05 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 18 Aug 2020 08:22:05 -0700
Received: from fmsmsx152.amr.corp.intel.com (10.18.125.5) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 18 Aug 2020 08:22:05 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 FMSMSX152.amr.corp.intel.com (10.18.125.5) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 18 Aug 2020 08:22:04 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 18 Aug 2020 08:22:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xy6QSo5BDcY0LX1Cibpd1+v5KNmUFrC+s6vWkoxkBmg8zSw1f2KuVlstYoT/47S/6FNCX2CFJNQQzUE26jlsB471PezVRMfQ7PqN9ocfX4cowrtjZl1vXCjLi9rLZp+dPRB8GfP2dK+LgcpkMT+AFSpSkAtvRR2me37JVoNPOY8WnP28WxukLDPXwivh/Nu2UHwIF4CRfBccSUyGQRy15GdEAiKiTrYNcXicqWg3RJC1A9KDtxmPq6wggseMP8eV416NPe+ZzaxokxiZkPkv1G4be+xsfEz7M/n/O20DNj7DSmgdSnuP5QJWCeNKaVBicwL/yN/O8iedvnHdJommWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZFoqHK3bSdmMmtUJTRyEJUiZsaYOMfkV2qOfAtvxBnI=;
 b=FLl7lHxNudo2P4iJNkLZpewXi7hD0tAOLSqU4Rcw5e/P3kMiImc/G8vMTevAHssJVkiQdu6Rnstu3G9iZaandcHwzz0Nd8Tod2K5NNMQBQqKBFwsBmNANGeUa30CeGsSRG5t43IL+lqKSSMtAARwYICzpvRc7VAUlGWdOyQ5Ta/HKsTs28uH32qfXqmEKu8v8sHF9EHU4LbhkJx4i6OAROgJmvTdQYn01kOgm4Jh4eOrRwbnZq4zTXyQch1lf7wiSnVpikjEG4Mn5lg4NI9mvRFMfhXbptsHdyW27SBJKCMEULlYNYZCRVYnTWuaWx9YMKp/FPeXYvpV3VCDAD6hZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZFoqHK3bSdmMmtUJTRyEJUiZsaYOMfkV2qOfAtvxBnI=;
 b=RxWVAYZlPCC3DvEkGmb7TXa9VPORTVpEdNd91U3qWAb6udSTGKIwkr/CBGAyQQceTvih3Gnn+hfq2zGjw0b2jw08GYpwBmNusdGmSXFSXtXBRTl8BE2UFQHRTohYXQLDAUW3nEOovknObdCXheEulywzBULlnFs/OAO7pAKiIU0=
Received: from DM6PR11MB3642.namprd11.prod.outlook.com (2603:10b6:5:138::26)
 by DM5PR11MB1643.namprd11.prod.outlook.com (2603:10b6:4:b::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.16; Tue, 18 Aug 2020 15:22:04 +0000
Received: from DM6PR11MB3642.namprd11.prod.outlook.com
 ([fe80::70a3:595c:6217:49c9]) by DM6PR11MB3642.namprd11.prod.outlook.com
 ([fe80::70a3:595c:6217:49c9%7]) with mapi id 15.20.3305.024; Tue, 18 Aug 2020
 15:22:04 +0000
From:   "Lu, Brent" <brent.lu@intel.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        =?iso-8859-2?Q?Amadeusz_S=B3awi=F1ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] ASoC: hdac_hdmi: support 'ELD' mixer
Thread-Topic: [PATCH v3] ASoC: hdac_hdmi: support 'ELD' mixer
Thread-Index: AQHWdW62iieFuR7I7U6dWD1jz848Vak99kyAgAAFG2A=
Date:   Tue, 18 Aug 2020 15:22:03 +0000
Message-ID: <DM6PR11MB36421674C19320503D26DABC975C0@DM6PR11MB3642.namprd11.prod.outlook.com>
References: <20200818004413.12852-1-brent.lu@intel.com>
 <20200818143632.16539-1-brent.lu@intel.com>
 <20200818150225.GC5337@sirena.org.uk>
In-Reply-To: <20200818150225.GC5337@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [1.164.110.173]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d19cdacf-cf2f-47b1-4f2a-08d8438a7630
x-ms-traffictypediagnostic: DM5PR11MB1643:
x-microsoft-antispam-prvs: <DM5PR11MB1643C906598A1931ADF74C0D975C0@DM5PR11MB1643.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gx68KaPa27xaXkoxN5EIT8OvJDFxr6tJ/7uKGkVvxTnEEEsOk04z9jUeMg+tPwoO1pvWAZzqyGlB0t4uKPTY2m9MAOgcWFpuCBr+zfmIOJ9H4JhNj91win4rOvYohedE0wPLlzlKved2sswseDmEt62/2idg8LXnZ6L1FGrjdfS8TCXZIjFdf+HHrq7LPHcfoNjzglakihCWRJ+pev6mxqkeSMhqu+0AdrmqAGh6aRxrEnFOy/pKTc0A/QQBdngcFOpK89rY7P0J28aWUoS9wHGatrwbGQVaA+yU7zTaQ7zHyX8pyEWYySC3fB3t3i+2PSJSd34JOq00DY6RdC6tmA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3642.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(136003)(39860400002)(396003)(4326008)(478600001)(76116006)(186003)(8676002)(558084003)(8936002)(9686003)(316002)(55016002)(7696005)(54906003)(71200400001)(66946007)(26005)(86362001)(2906002)(6506007)(64756008)(33656002)(6916009)(52536014)(66556008)(66446008)(66476007)(7416002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: jDbY7EFreWRz/2YpX+L0O7c+LLTFiNw9/Bw8Jk8Wfyjw56fBoqZdHOAuBVhdX39nViJZ93mxI0FXM/MhWEVl8ra36yJb26e5QZjvl/GsvfgVY4ZT2zXy+rNN6DvNZf1EuziNEhgT+Yry8+QI+Q5aOwznxdZ7aVxgz0PWQdUdmOgynaZ5JL5rC7ChF+iw9gKSV0vv7VZQGRLuzj9Fonl17FSLa5AnpKu3c8ff4GtqE4yvprkLP+rWodXFCNwJKAA4x0dCwEwRJJG5uSgVWPKAxES6S7hkFOP7wbMW1JiicBdUA8NOR6rvlro7BucCUR3I4DzOHafQ8Oi0JfXQxP0iFnGjS4T1XV2lGXhDAP52MMaOPae+GB1mSk41i0BaGw7syVSiOtI+j4VOWt53sipeUoxV8um2njZQ5SSb1JPUykv6VlMEGwWb2jKJ5RgmW/YJJ5HpkJgoLhammaioeFnlM4cpZlGfOPpNkNuftlmc9e7sRoCtcQdOGRxBa/3Mjb/afh9ewJKKQswxD9uE/qQS+KPpCdgTXTlpruNZCqEzzAmeAtm3p6lpjZTiHlalB5D6BfNtozKgoOihl7QiWD4VG6mhLNzDQEpqweNK7nH1ZiaUHVQerwSNVYs/5hRziOIB0knnJ7g/1twLf5l7XrKwHQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3642.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d19cdacf-cf2f-47b1-4f2a-08d8438a7630
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2020 15:22:03.8741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qUuoId8mHgliiJMsIGP3dewUB2HjPTvNVgul5cnfVQgBO+3bgDsl/EIrpWeMe8Bu7cPSNxjxzhdQqkbsEJ8IeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1643
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> Please don't send new patches in the middle of existing threads, it makes=
 it
> hard to keep track fo what is going on.

Sorry for the problem. Does it mean I should avoid using " --in-reply-to=3D=
" when
sending new patch set?


Regards,
Brent
