Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65C181DC522
	for <lists+linux-kernel@lfdr.de>; Thu, 21 May 2020 04:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgEUCYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 22:24:00 -0400
Received: from mga03.intel.com ([134.134.136.65]:46547 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726833AbgEUCX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 22:23:59 -0400
IronPort-SDR: uGmPsinJ16QQfdgIzopFFckkiDWBt6bYmXU2R0v20INCDzizC4gPw//ptdU/d6u0hXIMkzRsPO
 akHRuJUSc38g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2020 19:23:57 -0700
IronPort-SDR: XXWFx2rPMn2mywLuv2IQ4opdsLwYMF4rp8ODCR8ISRi9BR55nONQzNuld6jtrVDcitDepJKiEl
 wTUUv97OgYEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,416,1583222400"; 
   d="scan'208";a="300147627"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by fmsmga002.fm.intel.com with ESMTP; 20 May 2020 19:23:57 -0700
Received: from fmsmsx123.amr.corp.intel.com (10.18.125.38) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 20 May 2020 19:23:57 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx123.amr.corp.intel.com (10.18.125.38) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 20 May 2020 19:23:57 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.54) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 20 May 2020 19:23:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gledo44VJoa0SyJsTDMKOtMh7aiLxAOrZHWhuskgXMN/s/2kfqHo/LCniBaEDdF/8bLUZNNJaBYuL5ddasotki48qDuhMrKk4VRqwBJEdbi1o+JNfVscOkbY6egTnArGYW0ecntMPrWhBXA7ZffI5C6FYUaueGowwE16S5432c9OBGOQDB+G0LIsyU6xqrvpv6eSyQ2Dq8Y61THDkiLrXAH4w1sbt6Z9vEYEe6KcSx8snlxH7QHimt8edQO/tPB5Ezlu2LVpqQrcjjyWRXcbgym1j0x3WhYmWdlInaImvOXtvSUjShQrui94Tr2yR3SQxjOe0JLkv+MGr4oz58p79A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zqnpvI7ZpvTpXqF5VdWY03FRy/Fo+jtKAGOA1OPsNjc=;
 b=TVbom+yis9f9osg0qyg8m8s4W2J0aM0MU/YJNNhCq8ly0LVOsTDExoIz9FbVFs+JzgZ9LHIm/FYhzEbN2bZG5eLPOxwJazDMewsWzPhbaRBDJFmy3raAZpqcJSP1Pd46bzeZd7xL4E5iOQCsxNq4Qv2Mm4/QPT4pqLncs9St/c1RnO4aZ9IeErSJoWX6FCAwHyoJX0JgUYabfvG/KWk6q0pKifsgfzxEmqi3gHRc9bczkvTUuYZRG5B2uEdvOuJ4C53HpJAZdSFKYVr6tc72GJloUIHpu/oK0a2aSaNa7W5iosBvq/24tlI3AozKAo/CCjj7F/Ix2QyIOwmC0h6OGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zqnpvI7ZpvTpXqF5VdWY03FRy/Fo+jtKAGOA1OPsNjc=;
 b=Yjtf/Eh3V+a+qO0rvee5v6ayb715OXdcEj7dXwEjpPhpl5UBC4O2IEwKzkq06yk52HsyC8qZ38WFDSM7T1BD+hX1F71iLSLqXDLZ/nmzXTduZxNRS+mctUXQpsJvnrsnq6PPJorswd/+Hx19h2aEdKpEZMWM1ynOEEu3PF80EtE=
Received: from DM6PR11MB4074.namprd11.prod.outlook.com (2603:10b6:5:5::11) by
 DM6PR11MB2538.namprd11.prod.outlook.com (2603:10b6:5:be::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.26; Thu, 21 May 2020 02:23:55 +0000
Received: from DM6PR11MB4074.namprd11.prod.outlook.com
 ([fe80::6921:e03e:b890:fd53]) by DM6PR11MB4074.namprd11.prod.outlook.com
 ([fe80::6921:e03e:b890:fd53%7]) with mapi id 15.20.3021.024; Thu, 21 May 2020
 02:23:55 +0000
From:   "Liao, Bard" <bard.liao@intel.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
CC:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
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
Thread-Index: AQHWLnZHNMkaCkFFVUyGMtyK/ck+QKiw/2uAgADQzaA=
Date:   Thu, 21 May 2020 02:23:54 +0000
Message-ID: <DM6PR11MB4074165599273350FF7CA83EFFB70@DM6PR11MB4074.namprd11.prod.outlook.com>
References: <20200519191903.6557-1-yung-chuan.liao@linux.intel.com>
 <20200519191903.6557-2-yung-chuan.liao@linux.intel.com>
 <20200520135425.GX374218@vkoul-mobl.Dlink>
In-Reply-To: <20200520135425.GX374218@vkoul-mobl.Dlink>
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
x-ms-office365-filtering-correlation-id: 46d36b78-8975-445d-02fb-08d7fd2e02ac
x-ms-traffictypediagnostic: DM6PR11MB2538:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB25382F048C0B408BA865A6B0FFB70@DM6PR11MB2538.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 041032FF37
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WXZiB/S/UtJrnjbkTHcALZDy6Q6yW4QBCPGBvDPlwtLmJfs6llSHYMiXFzcIkPpGg6JcRgJtadjZOSfGAtv2X5w2oKryCELfGzJ+Dgz0YFfa4+32NSlfzCdxXuZKsSP6iCeb1/QwMDZvZQ7AcrY9FF4KLFu5x4EmqzthQYCz25lFTYrmmS+VL2pAoR0svOcXXC+0ZHuM64OKk+lOz5iuHMeV4T9l+XXFXIMAAJIfqDaDqYxD5fG7I1/zY64cycMf4v2QhMyJkGe13BiU06bFPnikNeLwcg8LgObj2TuyXLv9QpHNEWKjvAoSH46ZtHGmfxogqeLZk2hJZ0h9FDvMVOz86RSZ052tr7CUTkk6Oi1b93UtWA4kne1IiaFdrXckU4sSNB0uVekMoRlEkoJkXX6S+Fu3n61NDGJJKELTVrfddpfNjw7o1swhQSLtUrv2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4074.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(136003)(366004)(346002)(396003)(376002)(55016002)(8676002)(9686003)(33656002)(53546011)(4326008)(6506007)(7696005)(2906002)(7416002)(54906003)(86362001)(52536014)(66446008)(71200400001)(8936002)(26005)(5660300002)(110136005)(64756008)(66946007)(66556008)(186003)(66476007)(316002)(76116006)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: wspCy47vlrKfndXxWSRWubOv0XRFzgblHqWh4y23dfdhHfbFjtB5QMzOBBZiZmsqhW+WT2bn5xMacfSY1wEEyeQeUCKBoaxXnrKXV78pLbLL2x2b0SaCU5QqaAY/shUzB8UJ0Phm7QmeSEYOlbG5LzZDUgghJw6O5VvByAISrsSiI+Zg5+vsqHpxxAyt2VXQCJYtiR6Wi5I1LMAD7+jDbEM5XC1/4e4XRfn2fRopSkcrtaieiE602UAb70ya+s/AbTjuM0I+B83HQ5mlKToHeSYPvTslW4luew7fU98QWNOu24kBqkNFkE4qZazkNAhjxrsdsyYFDRMQVJYtElBmRPHhOZuXpCl1QE6TlP0niMw+4QOfPyFVe3anvjNqFTxG7sLTmny+MwNSEL/0WAwOY6OmWLqrapK/1gC26bX7/8JNqfAwmMG/KD3lqvJTZzQcByTaxik8XT0SloC+ua9xAz6qFUe5MbV8s3BEE8+5qpw=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 46d36b78-8975-445d-02fb-08d7fd2e02ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2020 02:23:54.9466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vT/uAdZrwjqBMvsgTuUi87AecQzzROMjz6ensNWjJv4BJypsP1VLzgVzt0Eq+JQzT0JfmBBWUqcRVsikF0SSRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2538
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Vinod Koul <vkoul@kernel.org>
> Sent: Wednesday, May 20, 2020 9:54 PM
> To: Bard Liao <yung-chuan.liao@linux.intel.com>
> Cc: alsa-devel@alsa-project.org; linux-kernel@vger.kernel.org; tiwai@suse=
.de;
> broonie@kernel.org; gregkh@linuxfoundation.org; jank@cadence.com;
> srinivas.kandagatla@linaro.org; rander.wang@linux.intel.com;
> ranjani.sridharan@linux.intel.com; hui.wang@canonical.com; pierre-
> louis.bossart@linux.intel.com; Kale, Sanyog R <sanyog.r.kale@intel.com>;
> Blauciak, Slawomir <slawomir.blauciak@intel.com>; Lin, Mengdong
> <mengdong.lin@intel.com>; Liao, Bard <bard.liao@intel.com>
> Subject: Re: [PATCH 2/2] soundwire: intel: transition to 3 steps initiali=
zation
>=20
> On 20-05-20, 03:19, Bard Liao wrote:
> > From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> >
> > Rather than a plain-vanilla init/exit, this patch provides 3 steps in
> > the initialization (ACPI scan, probe, startup) which makes it easier to
> > detect platform support for SoundWire, allocate required resources as
> > early as possible, and conversely help make the startup() callback
> > lighter-weight with only hardware register setup.
>=20
> Okay but can you add details in changelog on what each step would do?

Sure. Will do.

>=20
> > @@ -1134,25 +1142,15 @@ static int intel_probe(struct platform_device
> *pdev)
> >
> >  	intel_pdi_ch_update(sdw);
> >
> > -	/* Acquire IRQ */
> > -	ret =3D request_threaded_irq(sdw->link_res->irq,
> > -				   sdw_cdns_irq, sdw_cdns_thread,
> > -				   IRQF_SHARED, KBUILD_MODNAME, &sdw-
> >cdns);
>=20
> This is removed here but not added anywhere else, do we have no irq
> after this patch?

We use a single irq for all Intel Audio DSP events and it will
be requested in the SOF driver.

>=20
> > @@ -1205,5 +1201,5 @@ static struct platform_driver sdw_intel_drv =3D {
> >  module_platform_driver(sdw_intel_drv);
> >
> >  MODULE_LICENSE("Dual BSD/GPL");
> > -MODULE_ALIAS("platform:int-sdw");
> > +MODULE_ALIAS("sdw:intel-sdw");
>=20
> it is still a platform device, so does sdw: tag make sense?
> This is used by modprobe to load the driver!

Will fix it

>=20
> > +/**
> > + * sdw_intel_probe() - SoundWire Intel probe routine
> > + * @res: resource data
> > + *
> > + * This creates SoundWire Master and Slave devices below the controlle=
r.
>=20
> I dont think the comment is correct, this is done in intel_master_probe
> which is platform device probe...

Thanks. Will fix it.

>=20
> > + * All the information necessary is stored in the context, and the res
> > + * argument pointer can be freed after this step.
> > + */
> > +struct sdw_intel_ctx
> > +*sdw_intel_probe(struct sdw_intel_res *res)
> > +{
> > +	return sdw_intel_probe_controller(res);
> > +}
> > +EXPORT_SYMBOL(sdw_intel_probe);
>=20
> I guess this would be called by SOF driver, question is when..?

Will document it, thanks.

>=20
> > +/**
> > + * sdw_intel_startup() - SoundWire Intel startup
> > + * @ctx: SoundWire context allocated in the probe
> > + *
> > + */
> > +int sdw_intel_startup(struct sdw_intel_ctx *ctx)
> > +{
> > +	return sdw_intel_startup_controller(ctx);
> > +}
> > +EXPORT_SYMBOL(sdw_intel_startup);
>=20
> when is this called, pls do document that

Will document it, thanks.

>=20
> --
> ~Vinod
