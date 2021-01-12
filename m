Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0EB72F2633
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 03:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbhALCUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 21:20:20 -0500
Received: from mail-co1nam11on2051.outbound.protection.outlook.com ([40.107.220.51]:23617
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726644AbhALCUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 21:20:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JMvG2X5cTz/kmquomXY5bRU5P332gKYDZHkUoThju44Os0ODMvotjy6LKpDtoTaA/d2NfDLbEBOYiFdXLebXgjHWcbFr3jyfBYT4jrLLa00zYtPN4hlh8BB9akkrU3ZsS8fayOyIimgfRD5tA0ATlZUwAX6C+tSsiSz38pIBNM3p3x3xrFPcPlESAgTg+IsiOVHJbzPfosyEWKdNny46Q1IpdpmFi0eWW+fmf5aIERW+t5sBgG48rr/IwIGJuX9j9MefnxDzdkT+f+F4la3L7z+UN15v1pzBJc4G4BAQ4gjKZoGAvhImRo8q/PrPWaG+cNk9hGiqdOzcViROuvhHcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RvnbVaR+CAtpErVhwcDu1IapoFg+rApuJsL292tz7U0=;
 b=E2Ppj8tvmh6SZb8rVke/l/687+PxV4bB32L6S/47an6XJG7QHdo5H7XP6c7LPyJpU7TAX5DLX/hozaWfnWDKMfL0XI+JXPdBvydMkkwtAQA8mzXmbHfRptSNLKRAVzaIdYxiBwKU4AJ6yaTGQG4uPLEqauWRZbllrWR0ddMtl6gWpybP2PDohKPgpd1zXD+dOfXQgzNc5/f2Ro2/W6tvL5eKWkrCxXWSR7TXai4cNT4Eu7L7lMF6q3i+B+H7oPrO+M3/s9NkHm5ftLPfth3VVSbqBJBuet3sezeEy3899/IknHJF8mJxfCXJeTLc/WiHKXERrgQ2lLTA5zDdTW3BSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RvnbVaR+CAtpErVhwcDu1IapoFg+rApuJsL292tz7U0=;
 b=d3xEAxwv68dpzot8nNff5QSvz0UpINxr7/GN7ny4Wkx/1tmk5DxHoZ6g1F8t9RVBkxPxwOdt8Qea6a+hyq5rvAnL/s3KLwnj5JLletwm9dNEe+5185/t70NJN+mN4T/pq57J+warl3MBBblhrpY8r3hzf6GxaTPLuS3n41wqImk=
Received: from SJ0PR11MB5072.namprd11.prod.outlook.com (2603:10b6:a03:2db::18)
 by SJ0PR11MB5135.namprd11.prod.outlook.com (2603:10b6:a03:2db::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Tue, 12 Jan
 2021 02:19:33 +0000
Received: from SJ0PR11MB5072.namprd11.prod.outlook.com
 ([fe80::4934:bf21:e093:8c3e]) by SJ0PR11MB5072.namprd11.prod.outlook.com
 ([fe80::4934:bf21:e093:8c3e%6]) with mapi id 15.20.3742.012; Tue, 12 Jan 2021
 02:19:32 +0000
From:   "Li, Meng" <Meng.Li@windriver.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Hao, Kexin" <Kexin.Hao@windriver.com>
Subject: RE: [PATCH] Revert "mfd: syscon: Don't free allocated name for
 regmap_config"
Thread-Topic: [PATCH] Revert "mfd: syscon: Don't free allocated name for
 regmap_config"
Thread-Index: AQHW3L4VVKvkFiqdnk+AKM0UyG6tXaojWRJA
Date:   Tue, 12 Jan 2021 02:19:32 +0000
Message-ID: <SJ0PR11MB50721C1BA31F2D624E7C63EEF1AA0@SJ0PR11MB5072.namprd11.prod.outlook.com>
References: <20201228020624.4821-1-Meng.Li@windriver.com>
In-Reply-To: <20201228020624.4821-1-Meng.Li@windriver.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
x-originating-ip: [60.247.85.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ba05ae3-a1f4-4aae-af88-08d8b6a07fc6
x-ms-traffictypediagnostic: SJ0PR11MB5135:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR11MB5135EAEE7F336B172D79B69EF1AA0@SJ0PR11MB5135.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fmQ8uUm3xHa/8mxuLgtWsZcskIlErIYfJyMxxKFWH5H+ekopWVfLDaSzKeNG1JgeA8Tam3SgRs3ybDXC2+0rQfiekGOquqlqw1lCpehhkth04Fn19mDLqWHELmPIfvdy1ZlVg9CceSHsF9eDA5bAsXkYDWcywT+D5zg4IN2b/clWG1vm69GmBotBwTFAC3Ka39qL/Mm77txFvlNN6Yyc0dLbMXyY8kaNlkaS8VnlltLEH8FH74afv8E4wZJwrG+A0WlJlsyiajnZt7Ua969eSkabn8chEYg006o0YheKtgEeDJZFDlKYdU8P747nENN6rbdF1A5MyvUxU7SmX66YFNuqiKjR94FRBBK6M9l0/D3Peguz1C0nJvcgKMBC+eUl7NavRhvqDf/iHfZJO3C43Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5072.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39850400004)(346002)(366004)(376002)(396003)(9686003)(186003)(66446008)(83380400001)(107886003)(316002)(64756008)(66476007)(66946007)(55016002)(52536014)(5660300002)(8936002)(76116006)(33656002)(6916009)(8676002)(71200400001)(26005)(6506007)(7696005)(478600001)(2906002)(54906003)(66556008)(4326008)(86362001)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?rLEPWCxSBXXsSyWip4FL8qTQ1PqpIo94KldmFC6ZnkzZcgPYkUkjsgiJFdz3?=
 =?us-ascii?Q?4lxoJZUvJHip09cmzHdWkA+JOWwedsPhVEPnsuy58xiZo331sRON/y3k3aR0?=
 =?us-ascii?Q?V2kKKK/OibXdl1TDDLIjEYrTxODm21ZDXub1s4lBEh6AwMbTuC5+Gr66S7tj?=
 =?us-ascii?Q?zPPqGRva2oUri5iiMWrYVn4MZ8XAwiS+njDg4T0I9+t1JfO86WF4eBCZqclX?=
 =?us-ascii?Q?UwooiWqwGIlxtRR3ioS+GZZbSrz38mFYc6UQvI/f1PInkrnQct1fL2zKkc00?=
 =?us-ascii?Q?X98bLDNXYfRIabzKxHIYb7EaJNqrsxPIDMeirx0TXIRV53RlSSPgXjMZrJvb?=
 =?us-ascii?Q?sKUKyj6NINhAMnNYf7RbDWaiObbpCNI6MquD5eNtftue5PfGmyGCpiwuSy97?=
 =?us-ascii?Q?G99S49cHPGxEHUYUaaA2H/996tbmQv2Xj+eF0ysVVD405X7//6vUEG1YhWux?=
 =?us-ascii?Q?z6ZaxmZDCRB2FAe6MyCPD1o0hFL1+rlJsw34ZIqphnrPvHuiPfQ3ZYRLXY0y?=
 =?us-ascii?Q?BhN2dn0lwgpmb1HncFCykQ8Zna2TCuuqzpOPUSr4Muoknykho3uey7s8bB6n?=
 =?us-ascii?Q?xTG4hQv29DpYjZ19mDSGwO8bHUcyfLr90F5BShPpJ6FhOBClQNyC0KcBKQZC?=
 =?us-ascii?Q?c1wIQAGnU4pLFHNjckicYlAoEd7t8OHey7XJco71bb2/M0wrtca+F8tWe40O?=
 =?us-ascii?Q?ObZAMCe6osSXQOcYC0K5BGvfKq5M290/xSPdNCRZP6aAJk/Df2MsYXph9/Lt?=
 =?us-ascii?Q?f9FOPs1tKjGZgOG0F0tJqlLBzKMqfhppM61If0m5wyk0aVbp0UQ5VqAVuB5Z?=
 =?us-ascii?Q?itu3qE1huoEFwLYg0z6v4YDM/HLHTKOMEisSq9p/inIQrkdJvugFt3nZEUaY?=
 =?us-ascii?Q?LQO2IrU5j9ePKESgnZwf6xVYLYBzP4q3TfhyUjMRP4QLfgjdxRXAcFm36IGn?=
 =?us-ascii?Q?ngUCRO+NGGjkIrCjctN44UtrCnt/pzJVKkDYfk+QiFc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5072.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ba05ae3-a1f4-4aae-af88-08d8b6a07fc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2021 02:19:32.6390
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fvyza7oiEjLuy/C26tMn0V1eQ/sYneBZrODRsec2hQLibeDttXQC1JO2AjhSviNs/KYKxXUvHpxC3L+1T1yFAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5135
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Is there any comment on this patch?

Thanks,
Limeng

> -----Original Message-----
> From: Li, Meng <Meng.Li@windriver.com>
> Sent: Monday, December 28, 2020 10:06 AM
> To: linux-kernel@vger.kernel.org
> Cc: lee.jones@linaro.org; arnd@arndb.de; Hao, Kexin
> <Kexin.Hao@windriver.com>; Li, Meng <Meng.Li@windriver.com>
> Subject: [PATCH] Revert "mfd: syscon: Don't free allocated name for
> regmap_config"
>=20
> From: Limeng <Meng.Li@windriver.com>
>=20
> This reverts commit 529a1101212a785c5df92c314b0e718287150c3b.
>=20
> The reverted patch moves the memory free to error path, but introduce a
> memory leak. There is another commit 94cc89eb8fa5("regmap: debugfs:
> Fix handling of name string for debugfs init delays") fixing this debugfs=
 init
> issue from root cause. With this fixing, the name field in struct
> regmap_debugfs_node is removed. When initialize debugfs for syscon driver=
,
> the name field of struct regmap_config is not used anymore. So, revert th=
is
> patch directly to avoid memory leak.
>=20
> Fixes: 529a1101212a("mfd: syscon: Don't free allocated name for
> regmap_config")
> Cc: stable@vger.kernel.org
> Signed-off-by: Meng Li <Meng.Li@windriver.com>
> ---
>  drivers/mfd/syscon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c index
> ca465794ea9c..df5cebb372a5 100644
> --- a/drivers/mfd/syscon.c
> +++ b/drivers/mfd/syscon.c
> @@ -108,6 +108,7 @@ static struct syscon *of_syscon_register(struct
> device_node *np, bool check_clk)
>  	syscon_config.max_register =3D resource_size(&res) - reg_io_width;
>=20
>  	regmap =3D regmap_init_mmio(NULL, base, &syscon_config);
> +	kfree(syscon_config.name);
>  	if (IS_ERR(regmap)) {
>  		pr_err("regmap init failed\n");
>  		ret =3D PTR_ERR(regmap);
> @@ -144,7 +145,6 @@ static struct syscon *of_syscon_register(struct
> device_node *np, bool check_clk)
>  	regmap_exit(regmap);
>  err_regmap:
>  	iounmap(base);
> -	kfree(syscon_config.name);
>  err_map:
>  	kfree(syscon);
>  	return ERR_PTR(ret);
> --
> 2.17.1

