Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 123301DC67F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 May 2020 07:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbgEUFJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 May 2020 01:09:50 -0400
Received: from mga11.intel.com ([192.55.52.93]:26043 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726790AbgEUFJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 01:09:49 -0400
IronPort-SDR: hMyGyMKJY9a69UqwcoELoz10bqQrnBTSsfG3FnwzWM13g2XBZQCX3m/dfJH9ISRb85iBbsW7W6
 EwFJvLb8L+Mw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2020 22:09:48 -0700
IronPort-SDR: Fy1pLO/87D1P0ovNMbJEYsN7d/Lt4ODvyz6tklh+KE3T2AjTJmejsYzPiGVKfkJu6sFCYWct6g
 vD2AmBQqYhwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,416,1583222400"; 
   d="scan'208";a="282928831"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga002.jf.intel.com with ESMTP; 20 May 2020 22:09:47 -0700
Received: from fmsmsx120.amr.corp.intel.com (10.18.124.208) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 20 May 2020 22:09:47 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx120.amr.corp.intel.com (10.18.124.208) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 20 May 2020 22:09:47 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.57) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 20 May 2020 22:09:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AxPTklkLk1byHfip+rj2a4ZraKRjxWxsMpQ8UmCaohUARvRONCF6U4XeNzQzJWmf+5yXgSP8UvRyd83dszAG9EFaYDgGOJWHNLfC+Z0T6oBrwdlDmswmn9bLbllsFFVOa6BxJuwiC04WG+z6LdVeyslDxzZfmXnE0122/A5Qsqhg9q9JTK6Uc0FXTc0hjbzuf/p34m1Re30W2YWOuN2jlVVjgxywEjCIDM3Cqwr0y13v5Pcqxe9/VagUGP7uclx/pbNOqFLyzUQ2DpNJ1yWQs9gkzJKpbWfp+ft9emXmHG37iZINqirFqVSLdJOT7zbJTe/hI1z+Aq4wBS/NOoySWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tx6kd6QW9R6VUpMe/yeToId/WpUtEaihTFi5LT+yG7E=;
 b=mBoAZ5qBFZF0PgKqKw9sGTcSLHYqB/H2qm5TcfuPKIQl6waLYDA4A13TVQKXyDPs+3VjzaJCOOJD1UnhHxrciydwbXy9X+6YWuAJ5ggU3l99lTOjW/xXm2aUFwicI+RZg1bU1cv0FT1EW7dgGhS8hVOPPApZujYCMa4rwkrTNMRXNWUKfnF1sck3Sm81MvrQzYxtQWC3adxk1WTR5CuxD+cSqJCXVsyovr6CtNMncgKm4W00SKa6+ov2Tk0FkN8/ZXmiM9y+j9QSzA3UOKHEbo8fsSYvwqp+/IteN6P1aPRZSR+DIp87yPct8SKbIFCpq6JywQTRW3p5VCvat7LiLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tx6kd6QW9R6VUpMe/yeToId/WpUtEaihTFi5LT+yG7E=;
 b=FOQ4kxLw3MIKpa/JNYgxxkU9c7bKzF/nwnlXF2oyGoCVPWExzlFCpn+T2Dl73HYJo/TDfuggKJXEMfPzutoEmmiP1eaIqLhzLYHFRuIhVWKIWd3KOC6lRLp3Mwrk88pIqzn1Q34akSw1r4LurlG8O4AWN4kmiEY+aCiksi0DEeE=
Received: from DM6PR11MB4074.namprd11.prod.outlook.com (2603:10b6:5:5::11) by
 DM6PR11MB3514.namprd11.prod.outlook.com (2603:10b6:5:61::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.26; Thu, 21 May 2020 05:09:45 +0000
Received: from DM6PR11MB4074.namprd11.prod.outlook.com
 ([fe80::6921:e03e:b890:fd53]) by DM6PR11MB4074.namprd11.prod.outlook.com
 ([fe80::6921:e03e:b890:fd53%7]) with mapi id 15.20.3021.024; Thu, 21 May 2020
 05:09:45 +0000
From:   "Liao, Bard" <bard.liao@intel.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tiwai@suse.de" <tiwai@suse.de>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jank@cadence.com" <jank@cadence.com>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "rander.wang@linux.intel.com" <rander.wang@linux.intel.com>,
        "ranjani.sridharan@linux.intel.com" 
        <ranjani.sridharan@linux.intel.com>,
        "hui.wang@canonical.com" <hui.wang@canonical.com>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "Kale, Sanyog R" <sanyog.r.kale@intel.com>,
        "Blauciak, Slawomir" <slawomir.blauciak@intel.com>,
        "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: RE: [PATCH 2/2] soundwire: intel: transition to 3 steps
 initialization
Thread-Topic: [PATCH 2/2] soundwire: intel: transition to 3 steps
 initialization
Thread-Index: AQHWLnZHNMkaCkFFVUyGMtyK/ck+QKiw/2uAgADQzaCAACXEgIAACFgA
Date:   Thu, 21 May 2020 05:09:45 +0000
Message-ID: <DM6PR11MB407456180646DCCD9A962FC3FFB70@DM6PR11MB4074.namprd11.prod.outlook.com>
References: <20200519191903.6557-1-yung-chuan.liao@linux.intel.com>
 <20200519191903.6557-2-yung-chuan.liao@linux.intel.com>
 <20200520135425.GX374218@vkoul-mobl.Dlink>
 <DM6PR11MB4074165599273350FF7CA83EFFB70@DM6PR11MB4074.namprd11.prod.outlook.com>
 <20200521043655.GA374218@vkoul-mobl.Dlink>
In-Reply-To: <20200521043655.GA374218@vkoul-mobl.Dlink>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [220.133.4.96]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5203bd3b-8f63-4379-fc23-08d7fd452d8a
x-ms-traffictypediagnostic: DM6PR11MB3514:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB3514CED644AD391739172583FFB70@DM6PR11MB3514.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 041032FF37
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KLq3kyw8JDx9rP/+Del1VSj7A5yhrWQfLnFxhnmuMJVbey3hOM4wg22egP/OHQrkJG1ZCvvNODYLtViWzN8RJ+u+K7yvNjuR25AAaabuvDnGJuuZ73rss2iuGqF6bvEdzUakqsj9TMtfNgjCO8al5j6+glYJ3n7XMNvMMy7DUFQrBRTePI7CY/dyAmc0RbMfY1aWL9vwipbWTSB0wbMRCe4F0iRWx8o+qTmsOEsXLf7QoGugDotbwCgiR6UO5gdvEua69Z/IBrLKcwTNJxOF6WqBlIYHPyvu4XyCt8XayYY2Ws8/l4c7DnSoicoEQK/eBfJN+fZfvIHZxFwMk0oRKgc+9iyRLL1PIhMinJxfJW4Xl38Jjv/dG5FPFBNGkzqqAafYvirBUjZTgiIZxFUiY7MFJnLd050U8yRPD4lGsmCkyOB9K0b+pLid78fOKw1L
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4074.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(376002)(396003)(366004)(136003)(39860400002)(26005)(5660300002)(71200400001)(52536014)(54906003)(66946007)(64756008)(316002)(66476007)(478600001)(76116006)(86362001)(8936002)(186003)(66446008)(66556008)(4326008)(53546011)(6506007)(55016002)(8676002)(7696005)(7416002)(6916009)(33656002)(9686003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: e6eWLdwdBqYWDpknBeYtmlg4ErZIsoY9Xvv8M1lXuhwILxT3qKnpCCjOYG12u0PwO1EhlRZiKem75S9X/LoAoVJ/3yRp2ruYRBwuC4Njca7VeoFGZ2/0GUTxKoDrbgHUqSBU072eOeluEcGD/Q7XnWTSkNMTpRkBeypmRSIqkCAa7HzP2PA1Bpgd2SXKVTintDWqMuJH85FlU6RsqFjS6tj6BTAuFZgCBaurHAu5bHfEFGYlREZfFmu2xduYaTiyvjLRZv8BC18nvpqHCVvvWHFS9MkDHqBKyDQjeORKNbC/i47WJLf5egQChv4QNl41SMphKYv1R5mJLpXmAYbA/r1yRRJQVfhoPtC3YYLyuGnMDYYmS9TSe9iyejkjvyyoR62JNF1spO+iKd0i/7hJse2QHMeu+syYDwRqOxciorNjdA5QxWPNO4NihcbA0tcO/c3HYWi90fy7SWE1PtF9VzUJWWEl+kqRLsUCRJm96CE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5203bd3b-8f63-4379-fc23-08d7fd452d8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2020 05:09:45.4029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nhyGUDFzhXPasQ8ovGYyr26RQcLx5iKu6IJ4+Mpa+e/cqtUkrzuKxVk3nycNmDMkKmmC4JM1vMp5QRC29Wr9ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3514
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Vinod Koul <vkoul@kernel.org>
> Sent: Thursday, May 21, 2020 12:37 PM
> To: Liao, Bard <bard.liao@intel.com>
> Cc: Bard Liao <yung-chuan.liao@linux.intel.com>; alsa-devel@alsa-project.=
org;
> linux-kernel@vger.kernel.org; tiwai@suse.de; broonie@kernel.org;
> gregkh@linuxfoundation.org; jank@cadence.com;
> srinivas.kandagatla@linaro.org; rander.wang@linux.intel.com;
> ranjani.sridharan@linux.intel.com; hui.wang@canonical.com; pierre-
> louis.bossart@linux.intel.com; Kale, Sanyog R <sanyog.r.kale@intel.com>;
> Blauciak, Slawomir <slawomir.blauciak@intel.com>; Lin, Mengdong
> <mengdong.lin@intel.com>
> Subject: Re: [PATCH 2/2] soundwire: intel: transition to 3 steps initiali=
zation
>=20
> On 21-05-20, 02:23, Liao, Bard wrote:
> > > -----Original Message-----
> > > From: Vinod Koul <vkoul@kernel.org>
> > > Sent: Wednesday, May 20, 2020 9:54 PM
> > > To: Bard Liao <yung-chuan.liao@linux.intel.com>
> > > Cc: alsa-devel@alsa-project.org; linux-kernel@vger.kernel.org;
> > > tiwai@suse.de; broonie@kernel.org; gregkh@linuxfoundation.org;
> > > jank@cadence.com; srinivas.kandagatla@linaro.org;
> > > rander.wang@linux.intel.com; ranjani.sridharan@linux.intel.com;
> > > hui.wang@canonical.com; pierre- louis.bossart@linux.intel.com; Kale,
> > > Sanyog R <sanyog.r.kale@intel.com>; Blauciak, Slawomir
> > > <slawomir.blauciak@intel.com>; Lin, Mengdong
> > > <mengdong.lin@intel.com>; Liao, Bard <bard.liao@intel.com>
> > > Subject: Re: [PATCH 2/2] soundwire: intel: transition to 3 steps
> > > initialization
> > >
> > > On 20-05-20, 03:19, Bard Liao wrote:
> > > > From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > > >
> > > > Rather than a plain-vanilla init/exit, this patch provides 3 steps
> > > > in the initialization (ACPI scan, probe, startup) which makes it
> > > > easier to detect platform support for SoundWire, allocate required
> > > > resources as early as possible, and conversely help make the
> > > > startup() callback lighter-weight with only hardware register setup=
.
> > >
> > > Okay but can you add details in changelog on what each step would do?
> >
> > Sure. Will do.
> >
> > >
> > > > @@ -1134,25 +1142,15 @@ static int intel_probe(struct
> > > > platform_device
> > > *pdev)
> > > >
> > > >  	intel_pdi_ch_update(sdw);
> > > >
> > > > -	/* Acquire IRQ */
> > > > -	ret =3D request_threaded_irq(sdw->link_res->irq,
> > > > -				   sdw_cdns_irq, sdw_cdns_thread,
> > > > -				   IRQF_SHARED, KBUILD_MODNAME, &sdw-
> > > >cdns);
> > >
> > > This is removed here but not added anywhere else, do we have no irq
> > > after this patch?
> >
> > We use a single irq for all Intel Audio DSP events and it will be
> > requested in the SOF driver.
>=20
> And how will the irq be propagated to sdw/cdns drivers here?

We export the handler and call it on SOF driver.

>=20
> --
> ~Vinod
