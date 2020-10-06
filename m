Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95EE7284F48
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 17:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbgJFPyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 11:54:45 -0400
Received: from mail-eopbgr60097.outbound.protection.outlook.com ([40.107.6.97]:34920
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725769AbgJFPyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 11:54:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M8YcinIU4DLQ0odQaNelDnY5DfFiJ0vo4PllZ3Gat+ee8kdtwfzKD/I++1nVmZMKU2kmGn9dFmIzVDPk97lu6h5/wWJIGUyrRwJX0UXLsgCTqY9pu0yGzMFBKAD6IXB9QDwGeazIAwp/mss7ZrYms7MqTfgFBAqBlv+9WDpVhZEmah1tet/NjkoX8edAVVuyl2blvFFpvXQCyz4OdIBUO/jgpDp4bvKD8r7UrsP0O7v48w4KY0EjNAhyD7JpzUWkJWuUyDtevkdoM8GgfYhPtka97kFQYuLnQaGhOfBhGCIp2zJB5vW3FP6xssbhbGaJCebtHO3WELdTVQ8QM9t+TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2A1FlOD3q4+fcGOV5iOpJ1k2oZTbP/6qLw/WgCzYV0I=;
 b=VbtjAMvH1aXZt31FeYTyN9RryHyeEpRIfc1J0LlCqsQo/3gdvkIM0HgNBhq5PpWNyZTk5/k9RoavRyagCmacgP/Nv6IYoZc3YIgooRVetz0HjsHI/BJSyvEYoWWRaGvCNvfHT1YjqRcCEPQK8GysHLm9/22hgFUzKolRTqrlI4NtEEYKMO17aIku6WouSHYU21NmIKO8+RvRGUZNbiYHP4NY4IMs+qx392YI86wboZYXYNpmTkdwHr+PYJwLRkwFKWg97PNLWxfqYfxP9o0s602xZ0I1Ml3u87wG6ZAjcPK9RoFFBWf5kvAijawm/Jj3QNKRX1dFGqh6jv2dBdc1HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.com; dmarc=pass action=none header.from=kontron.com;
 dkim=pass header.d=kontron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2A1FlOD3q4+fcGOV5iOpJ1k2oZTbP/6qLw/WgCzYV0I=;
 b=lWOhbv6BVPappym4NmVrxzBpQzH+yUnCS2PDU4xyu+Ts2YogMfcIPZTKYL1Dx45X8hhpxPegOElrse5oxKKENSsK/cKBXSn6HgPjU4CkwXU8EPHg0E+ApqqzKHHYb0rquy3FqqQwP0NC1nvW7OAAJcmhiibr7Reph8U4BS86xmI=
Received: from DB6PR1001MB1431.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:4:a9::18)
 by DB6PR1001MB1079.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:4:5e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35; Tue, 6 Oct
 2020 15:54:40 +0000
Received: from DB6PR1001MB1431.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b873:915e:1cfd:162e]) by DB6PR1001MB1431.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b873:915e:1cfd:162e%6]) with mapi id 15.20.3433.045; Tue, 6 Oct 2020
 15:54:40 +0000
From:   Michael Brunner <Michael.Brunner@kontron.com>
To:     "lee.jones@linaro.org" <lee.jones@linaro.org>
CC:     "mibru@gmx.de" <mibru@gmx.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mfd: kempld-core: Mark kempld-acpi_table as
 __maybe_unused
Thread-Topic: [PATCH] mfd: kempld-core: Mark kempld-acpi_table as
 __maybe_unused
Thread-Index: AQHWl9idDQYeZ/9tfUC7Hluf7RcAM6mD5AgAgAS4vwCAAY4/gIAAl0YA
Date:   Tue, 6 Oct 2020 15:54:40 +0000
Message-ID: <66d77a96a488078eff1d8f0a2180941d94ce0bdb.camel@kontron.com>
References: <37c55c13f9042dde06fd67c829b06765286d0580.camel@kontron.com>
         <20201002070134.GR6148@dell>
         <b7fb20174aa7fd8a15132b6de679498fe0b18fd1.camel@kontron.com>
         <20201006065313.GW6148@dell>
In-Reply-To: <20201006065313.GW6148@dell>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.4-0ubuntu1 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=kontron.com;
x-originating-ip: [195.243.149.94]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b325f385-d803-432b-ee8a-08d86a1022cc
x-ms-traffictypediagnostic: DB6PR1001MB1079:
x-microsoft-antispam-prvs: <DB6PR1001MB10794F821D0389A1E2776ED1E30D0@DB6PR1001MB1079.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y95p0Lxr43HtCtL6O05poM1+hL/k2tbPeBhFlTZQok9d4S5pqi4XY+nCSUbSwgWqvpZgE9Y+BVwZZwamATY2Xa8ZqyzfpPu+Ojag5RZXi7b2fjLgGkmIkp93pSb4an5MMV2iatBDxABLarE6PokniR+dfbW2SCuvdWNTsXBKb18vTmZGEptvxCyUyTKQSJKm7g9nO3eor+5jb9U5QMo6M0Np5osPsX5rlwtvhhQ4zJfXHz/tiR676CrrfsXPT2WKaig4Twg+uEJ7us0TG6S/020A4CPZNU6hx1xQQvow3h7lpm+/6L/lRvJfkh78tKRHyzqMdDwqEzJoM5u0v6Z9Hw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR1001MB1431.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(396003)(39860400002)(136003)(66946007)(6486002)(91956017)(66446008)(66476007)(76116006)(66556008)(64756008)(5660300002)(2616005)(2906002)(6916009)(71200400001)(8676002)(6512007)(86362001)(4326008)(186003)(8936002)(478600001)(316002)(54906003)(6506007)(26005)(36756003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: D1OXepxlIRyorp7fWZKX5NaB7COht8BfIc1sCDPaMKdoRaRQJwcwPmlHVgoB8yisBtej5k6SlEO9KBWrws3qCiMUNaV/IKD6FicBXmewD2uz9LuVbP5kzZdiHLTKs5CmcrCmuXGisvDSAwy+Hw4sxj57qel4JuIscF+RAw+e3WUGhyzZDNxIR2mROk/ys//wng/an3Dw4cICYWXR2Ybt5voUpgkyDUTcShb6hoedtm43lvOaziYJ+U/x5CIcUWIZ79QVgk8JRGQ1a2hN8USZWPK1UjEIu8cZkVu8TgP23GUxlM7icuY1x/3p/L0vCsWDSkZDkAAeJvHS8KgPxbz37AH5CJe9l0bZjrT3P49mQLHpqvH53Fbd2NO6n8Idy/HOhy12WlI3Yk7lEjIgZA0EpR70+K+tGGCM3fiUeBL2U8W+9nvEP6MqQT0stTHnTxfJtghVJ1fD+g/JG/VPB1Ic84HfV3aMqRtMKBzPjHyVwLzxS+5dga/26K8g4gh6N3AyYSjsj3KirHpf5lo60Aq/R8VhkqAEco1QOLOza6AZ/x5uOiNFSoIaySGbbDZKsj0bwcHot49ZqBA9jSez30GniV8FMzkYlDBXYfpKFrQjVwzP81L8N3Ui2ULunpobVb2Gcyn6aZ/H0Pca0v1imvfbNg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-15"
Content-ID: <2028BC151365904AABF62C178FFF78FD@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: kontron.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR1001MB1431.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b325f385-d803-432b-ee8a-08d86a1022cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2020 15:54:40.7982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6ninzlkI8SvZGUqDe96g3MbxGJiRMAgBJ5fmPaBz+ohUKGagPZC3j5sNxtLHXwWh7t/V75yqyAITLN6rIFUt8boQ+cCCu8VCZe2Vewqwu/c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR1001MB1079
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-10-06 at 07:53 +0100, Lee Jones wrote:
> On Mon, 05 Oct 2020, Michael Brunner wrote:
>=20
> > On Fri, 2020-10-02 at 08:01 +0100, Lee Jones wrote:
> > > On Thu, 01 Oct 2020, Michael Brunner wrote:
> > >=20
> > > > The Intel 0-DAY CI Kernel Test Service reports an unused variable
> > > > warning when compiling with clang for PowerPC:
> > > >=20
> > > > > > drivers/mfd/kempld-core.c:556:36: warning: unused variable
> > > > > > 'kempld_acpi_table' [-Wunused-const-variable]
> > > >    static const struct acpi_device_id kempld_acpi_table[] =3D {
> > > >=20
> > > > The issue can be fixed by marking kempld_acpi_table as
> > > > __maybe_unused.
> > > >=20
> > > > Fixes: e8299c7313af ("[PATCH] mfd: Add ACPI support to Kontron PLD
> > > > driver")
> > > >=20
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > Signed-off-by: Michael Brunner <michael.brunner@kontron.com>
> > > > ---
> > > >  drivers/mfd/kempld-core.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/drivers/mfd/kempld-core.c b/drivers/mfd/kempld-core.c
> > > > index 1dfe556df038..273481dfaad4 100644
> > > > --- a/drivers/mfd/kempld-core.c
> > > > +++ b/drivers/mfd/kempld-core.c
> > > > @@ -553,7 +553,7 @@ static int kempld_remove(struct platform_device
> > > > *pdev)
> > > >  	return 0;
> > > >  }
> > > > =20
> > > > -static const struct acpi_device_id kempld_acpi_table[] =3D {
> > > > +static const struct acpi_device_id __maybe_unused
> > > > kempld_acpi_table[] =3D {
> > > >  	{ "KEM0001", (kernel_ulong_t)&kempld_platform_data_generic },
> > > >  	{}
> > > >  };
> > >=20
> > > This is not the right fix.  Better just to compile it out completely
> > > in these circumstances.  I already have a fix for this in soak.
> >=20
> > Ok - thank you for the other fix you submitted!
> >=20
> > But just out of curiosity - in process/coding-style.rst is written that
> > __maybe_unused should be preferred over wrapping in preprocessor
> > conditionals, if a function or variable may potentially go unused in a
> > particular configuration. So why is my patch not the right one here? At
> > least in my tests it seemed to solve the issue.
>=20
> It's a bone of contention for sure.  In these kinds of scenarios
> (i.e. ACPI and OF tables) it is way more common to wrap them:
>=20
> $ git grep -B3 'acpi_device_id\|of_device_id' | grep 'CONFIG_ACPI\|CONFIG=
_OF' | wc -l
> 596
> $ git grep -B3 'acpi_device_id\|of_device_id' | grep __maybe_unused | wc =
-l
> 63
>=20
> Parsing them out completely, also has the benefit of saving space,
> reducing the size of the finalised binary.

Doesn't the compiler remove it anyway? At least in my test I didn't see
a difference in the resulting object files.
Doing a crosscheck, by adding __attribute__((used)) to the definition
of kempld_acpi_table, the object file size increased and
kempld_acpi_table showed up in the symbol table.

Nevertheless, I don't want to start a discussion. I am fine with using
the preprocessor. Just wanted to make sure I understand the technical
implications of both solutions.
Thank you for your time!

Best regards,
  Michael



