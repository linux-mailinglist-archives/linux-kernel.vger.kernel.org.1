Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1FC2CD961
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 15:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730868AbgLCOij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 09:38:39 -0500
Received: from mail-eopbgr80087.outbound.protection.outlook.com ([40.107.8.87]:44749
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730556AbgLCOii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 09:38:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KS13QOWn57VkHSLO3zXsRlJ8nyktYZBR89WakqJL1gzwGJrXiOHPpFQcvYD7xUjbn4pIkw2sgOlLQq4XjMGGdZ16dfYeX1sPVBp8XcYntzDGI1cZuteZ03BWrtni5Msfyxd88+/0biZF4g/eyBobsEv2pXP5dd53uzw4wNtES4Z2aD2NHmIWADENWlN09ObwZz6o5bcs6YKyfVFPoN3TjDZ6QFwDBOn+SBn7zFm+GuKouQPXH5OPQvX4lclUuBvaTf/vrGSSay982Z9QcRUGDqVS+3hXO9hat7C1hHXZtUkTM8RBtdeS7/iJhkivlWKMKsWh9rlNJEr+y8tOGwjzzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPtb5+Ep1HLDSaf9MurDJmALtr9L1ijGSnhYEt0mq0s=;
 b=VsyLOtu7MWy+cN49hfl3gHcM3wNg3SGH3MRPpiE8Gw5MFBM6WOJMzuT+rfEwLnBzCkJOJogJR6qECFxlTqQwZRaKOUMRWXXMYP64xguAFEChAvYa4NswJ+xnU8i2F0F72ehI/NRtjNO37xP1BiIp0KnjgB8iPu3GpORukBjwkjVC5NKn9IRtZMS9rX9WmdGtLQRagcU+T8L1AVCAIVwoeDfPOWF/EuV/ABxnzJ4KKQQhlKAasGyhjnIUu57LduVmlggg7bRlo33yA/66EpoX77ZyVSryIK7BQF4/ITIJXIDUU09iwdBAk61+QrQqJ3/SCocndAAqFnkhD3sZKUSmDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPtb5+Ep1HLDSaf9MurDJmALtr9L1ijGSnhYEt0mq0s=;
 b=bnBHLXrdJ02hxXIj5AOIJWNFXhWqsGQELoCWOVBVmxrY0qEfd2LSJB86kDR0c0pSWyajFNgjPR8S0/Lvih7vemlkOGMLkGXmE2UqmAYNwgE1GvD8m/MRa3p/O8uI9xVNiR+byaIknSq1zhCWcOcasG1gBYeFUmpHLGhMq94M3hA=
Received: from AM6PR10MB2807.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:aa::16)
 by AM7PR10MB3973.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:135::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Thu, 3 Dec
 2020 14:37:48 +0000
Received: from AM6PR10MB2807.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5438:1932:b075:be6c]) by AM6PR10MB2807.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5438:1932:b075:be6c%6]) with mapi id 15.20.3632.021; Thu, 3 Dec 2020
 14:37:48 +0000
From:   Adam Ward <Adam.Ward.opensource@diasemi.com>
To:     Zou Wei <zou_wei@huawei.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH -next] regulator: da9121: Mark some symbols with static
 keyword
Thread-Topic: [PATCH -next] regulator: da9121: Mark some symbols with static
 keyword
Thread-Index: AQHWyWWRlQAd8rMw/0y41ez/hPS8JanlcNvg
Date:   Thu, 3 Dec 2020 14:37:48 +0000
Message-ID: <AM6PR10MB2807AEED4498B051B227E7D8ECF20@AM6PR10MB2807.EURPRD10.PROD.OUTLOOK.COM>
References: <1606994795-36182-1-git-send-email-zou_wei@huawei.com>
In-Reply-To: <1606994795-36182-1-git-send-email-zou_wei@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.80.51]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8e42157c-1486-4532-fba6-08d89799017b
x-ms-traffictypediagnostic: AM7PR10MB3973:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM7PR10MB39738449959CAF6B5A8C6146CBF20@AM7PR10MB3973.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:84;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G73v8KNTxIuZ6nMuNJcYUzHLqf03AXz5D+eB/Tnqk/bFNvwYJlY2AM9Tykknnhjgi6uo1ojX7hNEVcDCFDAQmMCA75gSYpmheeqfylewo+hQzvARavrEN0UdjqtULxtxuF1XrNCM/bruDdPasi1508fSMUK/cCRp0e8Cv2h7utxKBWlRod+bl+IYmWycyUkhtGWwoZnp7p5ZdMbCvQ7Qt09sqEFwL1LrUJuoQHIE7H3K36T7TDmEzmxrPKzcDwjk6mfrea2qmj6LsM5OsI9jbx8zwc8MovRS+cUo+oTcnrq1OzCiVD5ZV682RpaqJQyan58tas+td+FhGKl4SuZWcg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR10MB2807.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(376002)(346002)(136003)(39860400002)(478600001)(110136005)(71200400001)(33656002)(8676002)(8936002)(4326008)(83380400001)(316002)(66476007)(5660300002)(86362001)(7696005)(55016002)(9686003)(76116006)(52536014)(6506007)(53546011)(26005)(2906002)(66946007)(55236004)(66446008)(64756008)(66556008)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?afR95lgB6HZZ0P0xcNmwGFi9ij3esoV/6Yaao34+Upg5Bl+iZRMJZxYgHM+f?=
 =?us-ascii?Q?rRtnN+mpysSkIub3Zt5rjGcJAbLlko8H9FAHQf25KWUmoxpLO4NNed7raBEA?=
 =?us-ascii?Q?DpTsDdP4utQleJ2lB+N49UerlShpo1sygohC8MSyFzzI4w2RAYWfzUcJ/QuT?=
 =?us-ascii?Q?YKK/iwkehneo/UMZfVPIq1Bu5uRJRZwG+M2mB0f5n03NV1mW6doR7nUEr/iW?=
 =?us-ascii?Q?6tbottBQheEAoMv+G0siZhCHv1mPfkj62jMIld1neckWbj9XOYs22CwcnwzE?=
 =?us-ascii?Q?K/sgKzkZn7nLwUuX17uzJed0PK8lQJVFRZGyzeazQxaeGs+9A7/+wtjBz5iL?=
 =?us-ascii?Q?YC8b+UWQ+qkZzfeWMQtsUNfV1TOI29MIxiIJP5eQdYpef46tkexH0zbULt1r?=
 =?us-ascii?Q?pFpz30hk0fiwr40TxCk+MaSKmjZBlrPt+69XLaT/Agbn5YybE4NpwKq/sLkx?=
 =?us-ascii?Q?UeYhmYgHUzZC+8jqkzR/HlM1KnJMcIDysezyKzbQLEIpqke5CNw09+ze5JNc?=
 =?us-ascii?Q?yab3KlCfAxkanvziqVBzPK/TuwN1Eweoe36FR89drIdfY10pjN6+vqtmmEMC?=
 =?us-ascii?Q?bIzmACpmbQmxOHNwLHqD12TaPMaUkPPjXPbhN7hSzyxz8wQMe1aosKXkUoE9?=
 =?us-ascii?Q?dbblfrnICE3rtuQ0FnlJkKQNn1QsXWyWMbxvW7aSwLTwOCVpYrMhyCAJrume?=
 =?us-ascii?Q?m/rZEKG84zQwry9MQ4TthEmglHqrrpiK2XKRakWi+iFWyQ12XAYUelB1H7oB?=
 =?us-ascii?Q?pKk6oVZnZlld9vctTWTy29Ok0D38GDVbWtF15LqbG2MX4xvaEQNOpAqvBb5J?=
 =?us-ascii?Q?YN34EhTLy4hvpt2s/CS0VZT2nvklv5vyxyvlx6GCyB/UAv8eGwmDyvEcL34B?=
 =?us-ascii?Q?xsFETPZFmbbsT47MUDDEaqeWoFvox8CwsAuVgP9ZMpAC9jtfwMWY3MvT2Qmz?=
 =?us-ascii?Q?zHNKFxf6jaIOUYKttYwCBXamDKR6qmuO72HDQs2QHHg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR10MB2807.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e42157c-1486-4532-fba6-08d89799017b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2020 14:37:48.2478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cVLXAwqTn/WA4CXQb9yN7P65VT/k0o8K4eu1IGTCgE1jT/VexcrFv5iZCJAH1HwTvlWFPB8/Z/P+jbC/aeG9iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3973
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Adam Ward <Adam.Ward.opensource@diasemi.com>

> -----Original Message-----
> From: Zou Wei <zou_wei@huawei.com>
> Sent: 03 December 2020 11:27
> To: Support Opensource <Support.Opensource@diasemi.com>;
> lgirdwood@gmail.com; broonie@kernel.org
> Cc: linux-kernel@vger.kernel.org; Zou Wei <zou_wei@huawei.com>
> Subject: [PATCH -next] regulator: da9121: Mark some symbols with static
> keyword
>=20
> Fix the following sparse warnings:
>=20
> drivers/regulator/da9121-regulator.c:55:21: warning: symbol
> 'da9121_10A_2phase_current' was not declared. Should it be static?
> drivers/regulator/da9121-regulator.c:63:21: warning: symbol
> 'da9121_6A_2phase_current' was not declared. Should it be static?
> drivers/regulator/da9121-regulator.c:71:21: warning: symbol
> 'da9121_5A_1phase_current' was not declared. Should it be static?
> drivers/regulator/da9121-regulator.c:79:21: warning: symbol
> 'da9121_3A_1phase_current' was not declared. Should it be static?
> drivers/regulator/da9121-regulator.c:151:32: warning: symbol
> 'status_event_handling' was not declared. Should it be static?
>=20
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> ---
>  drivers/regulator/da9121-regulator.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/regulator/da9121-regulator.c b/drivers/regulator/da9=
121-
> regulator.c
> index 3ead6a1..893512c 100644
> --- a/drivers/regulator/da9121-regulator.c
> +++ b/drivers/regulator/da9121-regulator.c
> @@ -52,7 +52,7 @@ struct da9121_range {
>  	int reg_max;
>  };
>=20
> -struct da9121_range da9121_10A_2phase_current =3D {
> +static struct da9121_range da9121_10A_2phase_current =3D {
>  	.val_min =3D  7000000,
>  	.val_max =3D 20000000,
>  	.val_stp =3D  1000000,
> @@ -60,7 +60,7 @@ struct da9121_range da9121_10A_2phase_current =3D {
>  	.reg_max =3D 14,
>  };
>=20
> -struct da9121_range da9121_6A_2phase_current =3D {
> +static struct da9121_range da9121_6A_2phase_current =3D {
>  	.val_min =3D  7000000,
>  	.val_max =3D 12000000,
>  	.val_stp =3D  1000000,
> @@ -68,7 +68,7 @@ struct da9121_range da9121_6A_2phase_current =3D {
>  	.reg_max =3D 6,
>  };
>=20
> -struct da9121_range da9121_5A_1phase_current =3D {
> +static struct da9121_range da9121_5A_1phase_current =3D {
>  	.val_min =3D  3500000,
>  	.val_max =3D 10000000,
>  	.val_stp =3D   500000,
> @@ -76,7 +76,7 @@ struct da9121_range da9121_5A_1phase_current =3D {
>  	.reg_max =3D 14,
>  };
>=20
> -struct da9121_range da9121_3A_1phase_current =3D {
> +static struct da9121_range da9121_3A_1phase_current =3D {
>  	.val_min =3D 3500000,
>  	.val_max =3D 6000000,
>  	.val_stp =3D  500000,
> @@ -148,7 +148,7 @@ struct status_event_data {
>   *
>   * GPIO0/1/2 are not configured for use by default, so should not be see=
n.
>   */
> -const struct status_event_data status_event_handling[] =3D {
> +static const struct status_event_data status_event_handling[] =3D {
>  	DA9xxx_STATUS(0, 0, SG, 0, "Handled E_SG\n"),
>  	DA9121_STATUS(0, 0, TEMP_CRIT,
> (REGULATOR_EVENT_OVER_TEMP|REGULATOR_EVENT_DISABLE), NULL),
>  	DA9121_STATUS(0, 0, TEMP_WARN,
> REGULATOR_EVENT_OVER_TEMP, NULL),
> --
> 2.6.2

