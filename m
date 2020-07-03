Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5242E213788
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 11:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgGCJW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jul 2020 05:22:27 -0400
Received: from mail-am6eur05on2045.outbound.protection.outlook.com ([40.107.22.45]:17995
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725764AbgGCJW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 05:22:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nxir/xSiufsg6osO3659lrk0ziSUm4T0Gdb/ynKOZP+EibeSx92NHbmzbjPKcaqCWqa2Q7hkof24XlcdDNt/NV0do48Dy9IoQ5v+dzia0AkXA5BV14iYGGme1OGViKJ3Ug320JDgs0/886i48uIRkYIP1CzdXy6RJV7dCFWZfC1d5Qguy+L6EAZKR5xMNjXddbwzRLDZUxASTQ9hGQcqhvZGd7thRb7a6vWkcDP+idsuksbjHCwpjIYgh5uqmmfvUlb7o/CeiaFC+ZZeRoBFFz3+33hjkhw4gQeQ0l7lVD9sWSLcZZUrqeSswcWpwxxyR+RfG+oqw+V9RxkQ3WUFPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/RjNfZrm5zjI/VW69yZlNkibhiDTE4imcuaXtjxWLtI=;
 b=kOO6QuKR/xTvqE4snBO9E+sUNhZwDTsYbVWLS2BF1V1CpLtaWBrimNtEtJJ1uz9j3Jhx4f/n9cnOwxidDouktO027fwy+4SOaNGlCtmk8E4P6W82qM7YBQ4IEH8yOL2BJ1ruVFxbKn27K8V7DL1+JiayrWKZ8STgrw/HZMKQXTT/ju8rI+K6tv9t5MjReeI1FED0AnLMybUXhImGuBmER/aBTd8LBShaOKTO/GptE1QG8UxtggD/6uw4cptU4hc8v8U1MBHRNHqYvYXp9jPWOcg1uFNu1InFcFABBQaI+Oiu4CK8psN2Zfmy1jzcxQ4IZrLMpXQIJ0qZyWweT4VnRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/RjNfZrm5zjI/VW69yZlNkibhiDTE4imcuaXtjxWLtI=;
 b=akIUxIZFRCMJPLKU91XeCgZiVnK9hxv5zY8hShn6CeJWaMm+DXC8h+ji+anhVBWl9zElEg8X9obs2ovy7icRJgTgIz8Lhw+CorxTff5Pt/h2VEmgNK3M7DAwnyZlaOAKw5MZ76ZiKmrK5o3qrUHaOiy+BQZfArDNTdZhsNZeKTA=
Received: from DB6PR1001MB1096.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:4:65::9)
 by DB8PR10MB3708.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:137::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.24; Fri, 3 Jul
 2020 09:22:22 +0000
Received: from DB6PR1001MB1096.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::314b:f930:76b1:11c5]) by DB6PR1001MB1096.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::314b:f930:76b1:11c5%10]) with mapi id 15.20.3131.029; Fri, 3 Jul 2020
 09:22:22 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC:     "tiwai@suse.de" <tiwai@suse.de>,
        "broonie@kernel.org" <broonie@kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 03/11] ASoC: codecs: da7210: fix kernel-doc
Thread-Topic: [PATCH 03/11] ASoC: codecs: da7210: fix kernel-doc
Thread-Index: AQHWT9TghVap+DlSo062Q9W9x4Qzkaj1lM3g
Date:   Fri, 3 Jul 2020 09:22:22 +0000
Message-ID: <DB6PR1001MB1096A684421804D2C2927E82806A0@DB6PR1001MB1096.EURPRD10.PROD.OUTLOOK.COM>
References: <20200701182422.81496-1-pierre-louis.bossart@linux.intel.com>
 <20200701182422.81496-4-pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20200701182422.81496-4-pierre-louis.bossart@linux.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none
 header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.80.64]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4185500e-f805-498d-39c7-08d81f3297b5
x-ms-traffictypediagnostic: DB8PR10MB3708:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR10MB3708DA541F6FC8EF81236B64A76A0@DB8PR10MB3708.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 045315E1EE
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v+7RMbUeJ27r6Tw74e34Tgsb5e8KIZWSAVzLxUsU1M/x+IDSnGHASnWLxy5H9bi0b3yrEwxw8ljsnJDUPs3X2IBAvgvDRIafDlfi2AeqrvhHb0Z/9nk8kLD70D4/WxxKGHPt4qOPTVEpRdyJ1u7IneLAOCamngTvEr7YcmY4YaDi1ct9qdKNATT+0l5JhtuR3X1ZXKvoKwlnMgA6hx2gv3Mt5EZTjNyYXIXbFC77hfdkblS0PaZpB67sX50slsT9CzRYBuzJFcBHCTZysTSekx56t9cBCko20F07daSMxy4z5usuMFjRcB8AMpLkJ70woxSfuO5MCD7yLgpRQ6bmAg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR1001MB1096.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(396003)(346002)(366004)(376002)(76116006)(9686003)(55016002)(66946007)(66476007)(64756008)(66556008)(66446008)(7696005)(5660300002)(86362001)(4326008)(71200400001)(8936002)(52536014)(8676002)(186003)(26005)(83380400001)(55236004)(33656002)(2906002)(53546011)(478600001)(316002)(110136005)(6506007)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: vfxorgX75V/P/yynzfKpMCcZ+iUCxIMNs2aqhJbH2TRkicZT2FkzLcU1EfcHWgW6vV84EUzTt/O7KlOg4/u5ox1gvVRLphNUyK63WZ6tHOQuBZkJ57avIhb5FldF3gFMHzvwXWokBvGvpvuAV1HVbtjviKOdpEHNpw6vn5Y40sziuTfKw13AwxjCRQj1p/G688QvmfEVZ3LW/CThd5yCgnImRijNHBfkeadlhtHaJgvLLn1DzcqGwO4pqfzeJ43/G4auv4n8QX9Xjvmwo/TjROXActqhpCOtZK93RLmmAw3IVa/pJ3xZM2UNMMhOlDZ2zlLshKlocgp2QLlxSrG5fEc0EAQENI0SY/GXQK0qpRml1K8OexGxGw+DnmVcxzZAQm1G33al9TSBeaj7isNDajLWHji842o4SlzYKX9cjM5UWWZCRPC+CdWwXWd75aTEM6UEqEYR7t3xHnjfPwvIj8RCy1aigz9CU70k+VbZHR8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR1001MB1096.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4185500e-f805-498d-39c7-08d81f3297b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2020 09:22:22.5887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xS46iFpq2h7NOI4/kP6UqYendlG99v4bkokl81wWRNthlOk4B8uh2WQNR/ZWH//SwC7o3Y/uFx1/IENme7VC5yvtJSME96zDrIfg2Wpn+Os=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3708
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01 July 2020 19:24, Pierre-Louis Bossart wrote:

> Fix W=3D1 warning, the kernel-doc syntax was probably from Doxygen?
>=20
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com=
>

So is the issue that the Kernel warning mechanism doesn't like Doxygen synt=
ax?
If so then:

Acked-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>

> ---
>  sound/soc/codecs/da7210.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>=20
> diff --git a/sound/soc/codecs/da7210.c b/sound/soc/codecs/da7210.c
> index 0c99dcf242e4..2bb727dd3a20 100644
> --- a/sound/soc/codecs/da7210.c
> +++ b/sound/soc/codecs/da7210.c
> @@ -971,14 +971,16 @@ static int da7210_set_dai_sysclk(struct snd_soc_dai
> *codec_dai,
>=20
>  /**
>   * da7210_set_dai_pll	:Configure the codec PLL
> - * @param codec_dai	: pointer to codec DAI
> - * @param pll_id	: da7210 has only one pll, so pll_id is always zero
> - * @param fref		: MCLK frequency, should be < 20MHz
> - * @param fout		: FsDM value, Refer page 44 & 45 of datasheet
> - * @return int		: Zero for success, negative error code for error
> + * @codec_dai: pointer to codec DAI
> + * @pll_id: da7210 has only one pll, so pll_id is always zero
> + * @source: clock source
> + * @fref: MCLK frequency, should be < 20MHz
> + * @fout: FsDM value, Refer page 44 & 45 of datasheet
>   *
>   * Note: Supported PLL input frequencies are 12MHz, 13MHz, 13.5MHz, 14.4=
MHz,
>   *       19.2MHz, 19.6MHz and 19.8MHz
> + *
> + * Return: Zero for success, negative error code for error
>   */
>  static int da7210_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
>  			      int source, unsigned int fref, unsigned int fout)
> --
> 2.25.1

