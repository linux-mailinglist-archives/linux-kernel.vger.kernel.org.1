Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0BF283098
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 09:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbgJEHH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 03:07:56 -0400
Received: from mail-vi1eur05on2107.outbound.protection.outlook.com ([40.107.21.107]:33120
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725870AbgJEHH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 03:07:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f61GJxY4cUiuw3VMqi0LUFHGIHfUnWkSwXKiieZcOb4vUB2EFQNW1Bt78Ie9jsKGUusbTdisw2zjgCZquZEQQgZqeLy+2QrCPuVL8tyMgfC7SyXVyljFYpPwgJFpE0pP010G79jzlt2WT48oVqBISLz+Smj/2Dwa5yh2maxReSzeQT94NfuCQ54hGK0tMg4XT10driTS1hkxJ4xTLHOR7gKmIw79hIQH1OIeiMeeh6m4eLWXkJfnnH+foUzBTIv07zLXKbuaqJ+vGVMQQpkxJgc7sQ/oR8PRlBjzSSEcX0b4hAn0Vs/Ncs8zvhmpuXRgcX7l5YUZprn9p01AoPw17g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFnel3Y4QGx/C56R9qX/Fhm7S3Ou2moxiMM4qHgPz1g=;
 b=mhdst2rcf3EHz/SOp1R6FWqsaTLUZFwTdHoKHAm8ThFfCoHkSFAb+pGkXzQOewSC9C4wIhFibCmMmqg+cdCnPBMH90+ynw4op8ZREkPAfZazv4W77F+T87ZD9iADobbjzHW/ChxN9BGuQulQQTgEiRzCrCuURKaUmEty/UC5lmjPfHWvmUnKOXbr1Jta1GHnxyfdefh+a3OE/qaxN4BC0iMOisZlA5CpQ3PZhj18axmh/Gk551Tjao0AyO5hSOoZyZXnWSUKD0i+GaljPs9SgvdYzTtQStBK0tZQnM8x+ryiQ7oVnUSNXXdyKYlY2f6PNHLeXImiafa4Ma2AyUNm8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.com; dmarc=pass action=none header.from=kontron.com;
 dkim=pass header.d=kontron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFnel3Y4QGx/C56R9qX/Fhm7S3Ou2moxiMM4qHgPz1g=;
 b=DpmXcoEXfcvj8lXApkKWTl08AjHjks3HzL3Na+XhFEuvuBN9UA+mseGe24WHuxSw3UmrwtlF5UqtJd+UqRtdkm8RMxy803+kVT29fOCjVivkLQ4SuqfPgD/fdYxIS00+4mw36PInAYdy4o5BqxgTvs7RO8KY+4pqpRXcY8+RjWY=
Received: from DB6PR1001MB1431.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:4:a9::18)
 by DB8PR10MB2955.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:e6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Mon, 5 Oct
 2020 07:07:52 +0000
Received: from DB6PR1001MB1431.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b873:915e:1cfd:162e]) by DB6PR1001MB1431.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b873:915e:1cfd:162e%6]) with mapi id 15.20.3433.044; Mon, 5 Oct 2020
 07:07:52 +0000
From:   Michael Brunner <Michael.Brunner@kontron.com>
To:     "lee.jones@linaro.org" <lee.jones@linaro.org>
CC:     "mibru@gmx.de" <mibru@gmx.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mfd: kempld-core: Mark kempld-acpi_table as
 __maybe_unused
Thread-Topic: [PATCH] mfd: kempld-core: Mark kempld-acpi_table as
 __maybe_unused
Thread-Index: AQHWl9idDQYeZ/9tfUC7Hluf7RcAM6mD5AgAgAS4vwA=
Date:   Mon, 5 Oct 2020 07:07:52 +0000
Message-ID: <b7fb20174aa7fd8a15132b6de679498fe0b18fd1.camel@kontron.com>
References: <37c55c13f9042dde06fd67c829b06765286d0580.camel@kontron.com>
         <20201002070134.GR6148@dell>
In-Reply-To: <20201002070134.GR6148@dell>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.4-0ubuntu1 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=kontron.com;
x-originating-ip: [195.243.149.94]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af943da7-a77c-492f-b98b-08d868fd605b
x-ms-traffictypediagnostic: DB8PR10MB2955:
x-microsoft-antispam-prvs: <DB8PR10MB2955A643AE8C006FE2ACA022E30C0@DB8PR10MB2955.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4z6n15U2bpnM579sizF/m0iuc5xC5vF/Nou4VR4gfg8h5auhDZxc7LdxC6qTC4XRLnIZsIwUipvUkeHfbFO4jSTxDcunUK8ZpHIoDkvHBcf7Xppfxmc/6knY1sROcIx6sdtD/rp+Vfhe5LDDtWkmEjphS+sLR72il0hp8N1sAFnxd85X6BtPW4RwEyXoAa1rd0WeacO1Yb21L4UkncIC9e6KufjMkc8NVAnfBk3bpFRB6taKXa1QRNO5pEpKkTIHtu9ttgPgZWS7AdEnakUuRVW1Pd8eDM9Lsg6oaoJSJuwZGMmz3FX0fAMYt2pp7x3/OtpU95I+ReKDoA3JuvFvJw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR1001MB1431.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(136003)(346002)(376002)(39850400004)(8676002)(6512007)(478600001)(8936002)(186003)(26005)(6916009)(2906002)(83380400001)(91956017)(5660300002)(54906003)(2616005)(316002)(36756003)(6486002)(71200400001)(66476007)(66556008)(66446008)(64756008)(86362001)(66946007)(76116006)(6506007)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 3jvU/kXGDz3kw54T7sEYF61N9/cej0NptJ3G9vCcxG3KWW0qzfarhtJr15dnkprZhm8iDIHeMNRp0kPyTaEHpoBI6m9EUR9ft1JSjN4wXWK5y5XwORZlwILqqrWm98A+ytafA7PqBr1jg2ilXk4XpTg+3lHJkedKJA5m5f+4yXq+TxsqKVW2Nll8eevmaeP3Yk6Ng4cw05k3YZdW8i63xGsWlNPNUY0FBtvmsiQWex2zutLt6P2Bc9P5PO4gQ6d3vvPdpZmmufZnqTckF8cafGFtJOWTYsBz46UpEuY1hN5tcW7u/nlUKpSXKfugERh0Wjf8jbIRRWcNEIbPFtPplDFM/6i9gaaCGjGWD+ODkcrK6irvNjRUn6wqSTDykTdOpLTkLWvduNX61OXt8w/hVcCbstqBTTvBP7w071r70L8osCWrPsnP5iqfbi5NQXOkWV3KE7C4z81OTStaF3rPdEiTSCH9EYJxR0T8aA9+C8oTAr51r+O2N5Jgxkuq3q9XJMIu2mz8LcM69XR17tZk2/iOsedtccWof68ztmQovJmwFJsCJAvgSZP45J5TuxnF/9floOu/1G/iaGdM4fIo6kHp/N4AR8yKBdfv9z7YdV87fMuYqOVgf1v7HlAM177jD8V86j7N/SHIZhZtLTacMg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-15"
Content-ID: <A997409E7AB53842B1C25905A336EE8D@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: kontron.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR1001MB1431.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: af943da7-a77c-492f-b98b-08d868fd605b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2020 07:07:52.4464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZEw2qwYsyRhhRkkf7OlezDeoXqP4vxK/yIeEhVh+cw+yUxZIrdpy/5Qte54Ucsx1Xwg23YekPdll/5Ur9KA09Qh0mJpdTsIVsRQDEehT0Sk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB2955
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-10-02 at 08:01 +0100, Lee Jones wrote:
> On Thu, 01 Oct 2020, Michael Brunner wrote:
>=20
> > The Intel 0-DAY CI Kernel Test Service reports an unused variable
> > warning when compiling with clang for PowerPC:
> >=20
> > > > drivers/mfd/kempld-core.c:556:36: warning: unused variable
> > > > 'kempld_acpi_table' [-Wunused-const-variable]
> >    static const struct acpi_device_id kempld_acpi_table[] =3D {
> >=20
> > The issue can be fixed by marking kempld_acpi_table as
> > __maybe_unused.
> >=20
> > Fixes: e8299c7313af ("[PATCH] mfd: Add ACPI support to Kontron PLD
> > driver")
> >=20
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Michael Brunner <michael.brunner@kontron.com>
> > ---
> >  drivers/mfd/kempld-core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/mfd/kempld-core.c b/drivers/mfd/kempld-core.c
> > index 1dfe556df038..273481dfaad4 100644
> > --- a/drivers/mfd/kempld-core.c
> > +++ b/drivers/mfd/kempld-core.c
> > @@ -553,7 +553,7 @@ static int kempld_remove(struct platform_device
> > *pdev)
> >  	return 0;
> >  }
> > =20
> > -static const struct acpi_device_id kempld_acpi_table[] =3D {
> > +static const struct acpi_device_id __maybe_unused
> > kempld_acpi_table[] =3D {
> >  	{ "KEM0001", (kernel_ulong_t)&kempld_platform_data_generic },
> >  	{}
> >  };
>=20
> This is not the right fix.  Better just to compile it out completely
> in these circumstances.  I already have a fix for this in soak.

Ok - thank you for the other fix you submitted!

But just out of curiosity - in process/coding-style.rst is written that
__maybe_unused should be preferred over wrapping in preprocessor
conditionals, if a function or variable may potentially go unused in a
particular configuration. So why is my patch not the right one here? At
least in my tests it seemed to solve the issue.

Thanks,
  Michael
