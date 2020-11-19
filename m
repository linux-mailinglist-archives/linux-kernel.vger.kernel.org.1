Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 383342B97B9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 17:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbgKSQWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 11:22:49 -0500
Received: from mail-eopbgr70080.outbound.protection.outlook.com ([40.107.7.80]:61234
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725877AbgKSQWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 11:22:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yv+XQKzwa1xCA2yd6r2Q2T8XZFk+GfH4uSlwU0e9y1W+BmdazRMhC8AkZWCyzfw/Oe+VFdhFkU2f2klHNDgjHfdRft3FAWJcfp5Pwfn7JvR7KamnFf1PemOPmBMNsGRPV6Q/4gp4zn+GErHluFOZRGDNjT2zBgqrctg3eKFqZJ0d/2O/3XL0ItChHWp0Q/WPEsM2E8hlXrRgvvPsnDo7wL8UIUE5dHILb4aJvCL0rfXceoiFo1unVmx290MKmNum/dr8gH5LYZTLFmebTbw1MrosR5TmWejidICTHyZnlhS6SP4SvkIJlAQ6713Q7kwyvJmsmBGqxZQfNvqNWq//jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xk8PqfV29i4MMVarWkzfSNBN2Se8XqxJqn1s4iSK1ZI=;
 b=DiySKbotiX2elSvbbB7aB/ZFRKRkd/iMs/B2nAdZyPYqGm04gH+r5uJX+8EMfdLgB0nfJK1D0cjkx/uTxG/xZk5ICl0t1nUT3LVg2268q44HZ3gQAvj+u7z7vQzeCdhgn3mE3cwRVWfzK2aMztJkDdb95itvL0+j907G1BILaQWwHN0JVqcZlhCOK4EHAkkNd2ES9WeN3ZLEcaFVvn2kg1vGuETtHFMiM7aIzelH+9qcHwihLBQ/B/pVklqWgEiSDWImi7IKR1oM5g3ckwQUt8Lhir9x779GCGj3Kezxg3PbrBDVSUV3pR/C/HjiS/CzegQPJrRVezPxmothv9s8JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xk8PqfV29i4MMVarWkzfSNBN2Se8XqxJqn1s4iSK1ZI=;
 b=cQydBVBVjGSmF4mjQP5LJNjZ7eX63KuP30HVkTYoKYak50HEPbxemQDFaPJ6Yq8LN5a5lqE4FLAdCEg/LiEEMscgHF24zEHoi82ndrRHMhjf4XaztN6y8s6D6fy+sZJ7HteerGDpnO2Z5/HCcYiwDzQE7gDZ+BI4ZooxRDx9K2U=
Received: from VI1PR0401MB2272.eurprd04.prod.outlook.com
 (2603:10a6:800:31::12) by VI1PR0402MB3488.eurprd04.prod.outlook.com
 (2603:10a6:803:10::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Thu, 19 Nov
 2020 16:22:42 +0000
Received: from VI1PR0401MB2272.eurprd04.prod.outlook.com
 ([fe80::91f8:d96b:f238:7962]) by VI1PR0401MB2272.eurprd04.prod.outlook.com
 ([fe80::91f8:d96b:f238:7962%8]) with mapi id 15.20.3564.028; Thu, 19 Nov 2020
 16:22:42 +0000
From:   Viorel Suman <viorel.suman@nxp.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Lee Jones <lee.jones@linaro.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH] ASoC: ak4458: use reset control instead of reset gpio
Thread-Topic: [RFC PATCH] ASoC: ak4458: use reset control instead of reset
 gpio
Thread-Index: AQHWvGa/ULTQkQTG3EuXXoMLDy7cbKnMmESAgAAFAkCAAS01AIAB0Nww
Date:   Thu, 19 Nov 2020 16:22:42 +0000
Message-ID: <VI1PR0401MB22726479D60E9B603A6848BC92E00@VI1PR0401MB2272.eurprd04.prod.outlook.com>
References: <20201116222036.343635-1-viorel.suman@oss.nxp.com>
 <20201117173901.GH5142@sirena.org.uk>
 <VI1PR0401MB2272061C958E91FCAA239EB892E20@VI1PR0401MB2272.eurprd04.prod.outlook.com>
 <20201118115500.GB4827@sirena.org.uk>
In-Reply-To: <20201118115500.GB4827@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [5.12.106.221]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cbcbb8a8-0449-43b9-ddb0-08d88ca7574e
x-ms-traffictypediagnostic: VI1PR0402MB3488:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB3488D8FABD80725CD1C757E592E00@VI1PR0402MB3488.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pc0Jeef4/GH8fHcFK5TJJOTm8dgTXXee6uSpv+0Yxk1/N5fAURwnlqhaDOpFl5yS8vmPzUWRdmT/OJTGRn46hGiVblFtRtYduEzAme10kD8Mp7u4Cdv5ekoOHLfMUuXYqGN1YuMmfsvFHD63myKfLrLU5Q+ODISl4pPRg0KAfug0utN+84xX2doPBOYiElDXWMI+HeSqHIXNP2zeGNYEEhFtZGFs5uL6GwKcjOTN2gaaWIprRIilGltYIvpmH4MgmnrIAUrC63iemrzkf3kpNfaw9qqZ8gEOoqE2pW75RxRxK2OzVaNwXU/JUe6HjyUQ7bfjLB8eQ9ioElRa/mUo0Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2272.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(52536014)(186003)(6916009)(5660300002)(316002)(7696005)(66476007)(66556008)(6506007)(54906003)(8936002)(66446008)(76116006)(8676002)(64756008)(66946007)(33656002)(71200400001)(7416002)(478600001)(86362001)(4326008)(44832011)(9686003)(83380400001)(26005)(2906002)(55016002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: ajCQr1+QtKyGwfATxXxSYUbDDew2BWqqFT7NufKBMA0NRUBAzys8AXlHv8MXcSQL8g5Pphq436UweVJ5pY5F1Uar4aeMWKzxgWn86wQBdcv+I5XTPlAZ4MvfxuKaufT8kFhiYPn0xvbsgWJv7E2pNRDDRyCHdNMpP6DOphjUiGfA8LXYejEMrwFrb+AXuDlI82sXrEKP9wFpaFXB7raJGNgU6AZKjWjY6B4k7gKev/Dq0WTyhkFTCR3vT0zdhVv8qeaWInVGuEHWcxmBYDabcDOI9wOYVFK+w3ys5df57vMgdgIzjRRd3+dvM5Oo04A29znfZLkbhQrfcCnt4RgPsyF7i4I1HrQ7H2LK+hz+xNHHEFncKf0Du+lYA2TxAvHFAfLxFu5XJgjhKH2uvWh+/B+xpLIR+hMJTttTOVTxo7GnxTb81B7KFciUvsm5Vgu4/sT5n/4R1hE8FjwscevCP6SQEazPo4hX+HUwKNXaMl9f6GrzKGF34Lsc3Gd79+sor1rz2DKn3olwm4jewRXq18L/WK8fcksg9aGMKfAf4cdSxqeCZWknYXxuuOxKNJcpiWaGSiLv6wfd/LYdrJuwR3gOQCH6KOFirIgAPbMF9NVxNyFAhweI6BpwlCeQYToj1gFu2biIixhEqB30Fu2fwg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2272.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbcbb8a8-0449-43b9-ddb0-08d88ca7574e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2020 16:22:42.3159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QkwHbC6JzOGw7zTdaFXnPb6ra//b1w33aLgwd1KlIfxr/hcY+inoR6y7hXozcRSg7+4tB8pWbPfzkUiAxBd5mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3488
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Nov 17, 2020 at 06:17:36PM +0000, Viorel Suman wrote:
> > > On Tue, Nov 17, 2020 at 12:20:36AM +0200, Viorel Suman (OSS) wrote:
>=20
> > > One thing I'm not clear on is if there's some way to ensure that we
> > > don't have different instances of the device resetting each other wit=
hout
> them noticing?
> > > Shouldn't be an issue in practice for the use here.
>=20
> > The way to ensure that we don't have different instances of the device
> > resetting each other is to rely on the way the "shared" reset is handle=
d by
> reset API:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +	ak4458->reset =3D devm_reset_control_get_optional_shared(ak4458-
> >dev, NULL);
> > +	if (IS_ERR(ak4458->reset))
> > +		return PTR_ERR(ak4458->reset);
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Flip side of that then, how do we know when a reset has actually happened=
?

I don't see how this can be achieved - I'd imagine some "shared" reset
framework notification mechanism calling back all "listeners" in the moment
the assert/deassert actually happened, there is no such mechanism currently
implemented.

In this specific case the GPIO purpose is to just to power on/off all codec=
s.
In my view with this approach it's enough to know that all codecs will be
powered on the first _deassert_ call and will be powered off on the last
_assert_ call.

/Viorel=20
