Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46CA62552AF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Aug 2020 03:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbgH1BrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 21:47:25 -0400
Received: from mga04.intel.com ([192.55.52.120]:39953 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbgH1BrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 21:47:24 -0400
IronPort-SDR: o23Xd0gDw8aMRSccT05P6DcSlMDqK7X/uLGjOavsRpdavUrJkahusTixcBwjFMYc8uQW9jdKuU
 7sLzn6w2y7KA==
X-IronPort-AV: E=McAfee;i="6000,8403,9726"; a="154008194"
X-IronPort-AV: E=Sophos;i="5.76,361,1592895600"; 
   d="scan'208";a="154008194"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2020 18:47:22 -0700
IronPort-SDR: VYCSw9dqJQd0W/QvpW4Mo+y/0VzFQK9PkUJG8MusNTPtunCU6kToz9LAFPx6U/qg4NkV/IRZyc
 aVLB8WJO+1JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,361,1592895600"; 
   d="scan'208";a="332392179"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga002.fm.intel.com with ESMTP; 27 Aug 2020 18:47:22 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 27 Aug 2020 18:47:17 -0700
Received: from fmsmsx124.amr.corp.intel.com (10.18.125.39) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 27 Aug 2020 18:47:17 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx124.amr.corp.intel.com (10.18.125.39) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 27 Aug 2020 18:47:17 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.48) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 27 Aug 2020 18:47:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LXneScp7a1fof8rS/23y4zz8Y1menTNPAgho/j9gYPT2zojknLtU1Sdrt7RA73Qyn6pMl70kjTEJE8dw7oMmpd2vqcDlb7J37MFDGVd2Il3zfeJ/B+JdHqdLIU6rRoSDumzDuXaIpv8tyteYnIGXwdzz9vj4UgS4TWZ13sernH9ciBox42Y3Gaj773FVOMSg3JERA7zQvSchGBLR8AHhmdYjzWxlhvrcGObgd4KhLy6poeK5jcZHeXZYZ4eNEezlFMQGBys4ZEq48HKTiJDLGUobRoAD5TbhwLAWzSUPqxqGMNMfGUowoTATyjVNipmAaCzaNPfAnSi7+Bn9/pZX7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a58rFFQ9cD77hFtgEYaW4+ObA3XRqFfAwquv5WtvHP0=;
 b=QvGNsf/4h+GTYYgQ6JYF9t0ERrWwjA/i/d2t4oLM1k/FvZCO/us/+qizdDLgJdBAi9hRTTCNnP/wSmb3x7pFGgUMWqT+bK2xGa43ZzhYNVtXKWXlVXgSx0NXLFY20m+EZ7PJTpf4c+wHwcRrvtl2pOUmxcVMgiwTQVbIscGllxkYKwaaX5dW5D8GZzXeL9jpnQ0D7Kk+JNpcDqvUqH/o5n3Y024C9epxUPzgk7aHxWXdrVic2vpKA403Lsf6hCX0sYP8mgsYIj5YYG4ze+UuwnKr8/UbvPuAxLyAUySxyGUvAPn5V7uToSp71L2fo2XdktzK93y5CkBzzSD7bvy3OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a58rFFQ9cD77hFtgEYaW4+ObA3XRqFfAwquv5WtvHP0=;
 b=HEOoN74nSRdE1Be8kkr59npw8XeSJqN/P/yL776E1Pz6/FUb9PT47xBdlyZCtPutgP+bSL9oHvYFx/dvpM0vLylpeXOfS58ICrzLh33XhdE9DqzRaDky7qWVhKAKFG6KF1aSxLLTKu7rgubAbgFHYs01z6m/McXwuaY7a6OKmdY=
Received: from DM6PR11MB4074.namprd11.prod.outlook.com (2603:10b6:5:5::11) by
 DM5PR11MB1787.namprd11.prod.outlook.com (2603:10b6:3:112::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24; Fri, 28 Aug 2020 01:47:15 +0000
Received: from DM6PR11MB4074.namprd11.prod.outlook.com
 ([fe80::a061:bd5e:c46a:fa40]) by DM6PR11MB4074.namprd11.prod.outlook.com
 ([fe80::a061:bd5e:c46a:fa40%3]) with mapi id 15.20.3305.032; Fri, 28 Aug 2020
 01:47:15 +0000
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
        "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: RE: [PATCH 07/11] soundwire: intel: Only call sdw stream APIs for the
 first cpu_dai
Thread-Topic: [PATCH 07/11] soundwire: intel: Only call sdw stream APIs for
 the first cpu_dai
Thread-Index: AQHWdWzjed4H7siPVEC/M4NN62YhKalKMLkAgAKcpAA=
Date:   Fri, 28 Aug 2020 01:47:14 +0000
Message-ID: <DM6PR11MB407494AEF6D05EFF627CFAFBFF520@DM6PR11MB4074.namprd11.prod.outlook.com>
References: <20200818024120.20721-1-yung-chuan.liao@linux.intel.com>
 <20200818024120.20721-8-yung-chuan.liao@linux.intel.com>
 <20200826094636.GB2639@vkoul-mobl>
In-Reply-To: <20200826094636.GB2639@vkoul-mobl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [220.133.4.96]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cc3de138-b36c-45c5-eb23-08d84af44a3a
x-ms-traffictypediagnostic: DM5PR11MB1787:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB17873C1F1E52208AB5F6084EFF520@DM5PR11MB1787.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YzvWGBQg5R326JeGIhv9bpeD2fBuNNzDabfm/elgEhsOq85J/OGj9Y5fnXty1g1xIE2RlF6fCg8x8ONk8qDU3lP95vo6fw9RhbIUtC6MSNm0BaYke7B5GaH90ygkEu0davxMDMNi3X2dl1A/VHf1VAvQewHNQsE0Z2enKNqskNleiZ4WhOooRL26WZJywQVkt/YTNf7pNM78KepKczbcmDe3AVtJ7GqEmIuv6rjv+dXzrSBcE54AW6T37dhtibhK6BaOnmzzJImOk9kMOopcOp3cIJosOYTr8u2NzAYARy1/9xidgk3j36lpuFFiYw6vSjHoCK7CSqummaXqkZYd3g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4074.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(136003)(39860400002)(396003)(346002)(53546011)(8676002)(6506007)(110136005)(7696005)(316002)(478600001)(54906003)(55016002)(52536014)(9686003)(5660300002)(8936002)(2906002)(7416002)(71200400001)(66946007)(186003)(33656002)(4326008)(26005)(86362001)(83380400001)(76116006)(64756008)(66476007)(66556008)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: z9aaQikUMUHwOoW059L8avh/Cp7CeLXstl5OueEo1nuNaxeXLmba52Ug9RMdtti5apatM2KbbbIhxyLozQT1FjGpf3ApdF+7rNECqaNIVP5WtR2VB1wPywLiVszT8x99JHYU2RZGNguLRb5+B/xTwSYi9+ayV3zUpkIP18wy5ab4Ip5qTwKYzuRz1o75+fimDrBM7WSgyP69z5fS6N4aCmUrvjLUqMYtOo85UIZEjeP0FTINEy83F0B9G5fDCJkpkYo/QNIqWltcDcdTsrz9AgFsQDk4PzI2UBRZyACYS+FWatPP2mGDfwlaRuOjHiOlxsnCWiMyAI2D2jzwZbdxWv/h4xdLDoyZ6WlFgg95PtrKTZuds8tb87QuVP/sTfsxprAtHGrL6dKsGs7sDVQAKV1S5ltmWnd5cq8YP3IGPqDZcrX9gI4mHseyQKyJpjJCrloaLRSUeu7tM5vCM0+X6gQsyWOmqo/WZ0fJazCY6lSRzIx6Ouw0JInJcsYWQKx/dMxYpvY3Y9WFPQeH8FVZ+mo9RcPck9OPQI5X9gL2WRqOBDcFjrxW5fN3ovN7jEQe9jCcCYzF+KwmO3Gafwz6sXtvmShLPoo6Ms+clc8WaZJk4Um0/Lo6/zdkftJYraCAvDzPO5kKbnvusDSjjg97ZQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4074.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc3de138-b36c-45c5-eb23-08d84af44a3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2020 01:47:14.9406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fUcCTMgnXmj6qXhuXPbSRvU9+R5i0A/JliW5CT2zDRgB7aYU6R5KIueTU0LhK5qpufh1EGkowNYKUsiZR1brmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1787
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Vinod Koul <vkoul@kernel.org>
> Sent: Wednesday, August 26, 2020 5:47 PM
> To: Bard Liao <yung-chuan.liao@linux.intel.com>
> Cc: alsa-devel@alsa-project.org; linux-kernel@vger.kernel.org; tiwai@suse=
.de;
> broonie@kernel.org; gregkh@linuxfoundation.org; jank@cadence.com;
> srinivas.kandagatla@linaro.org; rander.wang@linux.intel.com;
> ranjani.sridharan@linux.intel.com; hui.wang@canonical.com; pierre-
> louis.bossart@linux.intel.com; Kale, Sanyog R <sanyog.r.kale@intel.com>; =
Lin,
> Mengdong <mengdong.lin@intel.com>; Liao, Bard <bard.liao@intel.com>
> Subject: Re: [PATCH 07/11] soundwire: intel: Only call sdw stream APIs fo=
r
> the first cpu_dai
>=20
> On 18-08-20, 10:41, Bard Liao wrote:
> > We should call these APIs once per stream. So we can only call it when
> > the dai ops is invoked for the first cpu dai.
> >
> > Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> > Reviewed-by: Pierre-Louis Bossart
> > <pierre-louis.bossart@linux.intel.com>
> > Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> > ---
> >  drivers/soundwire/intel.c | 45
> > +++++++++++++++++++++++++++++++++------
> >  1 file changed, 39 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
> > index 89a8ad1f80e8..7c63581270fd 100644
> > --- a/drivers/soundwire/intel.c
> > +++ b/drivers/soundwire/intel.c
> > @@ -941,11 +941,13 @@ static int intel_hw_params(struct
> > snd_pcm_substream *substream,  static int intel_prepare(struct
> snd_pcm_substream *substream,
> >  			 struct snd_soc_dai *dai)
> >  {
> > +	struct snd_soc_pcm_runtime *rtd =3D substream->private_data;
> > +	struct snd_soc_dai *first_cpu_dai =3D asoc_rtd_to_cpu(rtd, 0);
> >  	struct sdw_cdns *cdns =3D snd_soc_dai_get_drvdata(dai);
> >  	struct sdw_intel *sdw =3D cdns_to_intel(cdns);
> >  	struct sdw_cdns_dma_data *dma;
> >  	int ch, dir;
> > -	int ret;
> > +	int ret =3D 0;
> >
> >  	dma =3D snd_soc_dai_get_dma_data(dai, substream);
> >  	if (!dma) {
> > @@ -985,7 +987,13 @@ static int intel_prepare(struct
> snd_pcm_substream *substream,
> >  			goto err;
> >  	}
> >
> > -	ret =3D sdw_prepare_stream(dma->stream);
> > +	/*
> > +	 * All cpu dais belong to a stream. To ensure sdw_prepare_stream
> > +	 * is called once per stream, we should call it only when
> > +	 * dai =3D first_cpu_dai.
> > +	 */
> > +	if (first_cpu_dai =3D=3D dai)
> > +		ret =3D sdw_prepare_stream(dma->stream);
>=20
> Hmmm why not use the one place which is unique in the card to call this,
> hint machine dais are only called once.

Yes, we can call it in machine driver. But, shouldn't it belong to platform
level? The point is that if we move the stuff to machine driver, it will
force people to implement these stuff on their own Intel machine driver.

>=20
> ~Vinod
