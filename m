Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4FF6303B03
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 12:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404672AbhAZLCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 06:02:49 -0500
Received: from mail-eopbgr1400102.outbound.protection.outlook.com ([40.107.140.102]:43267
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730451AbhAZE20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 23:28:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C+KdxTXt8UouqcTKtbdATMi0myBQobxV9rzkVVl9PGdRnU9LOU6f9ECBSPCGp7k3RQrAonbfOIm7YUCUUHNNFjm/EA+5rqL5r57Y4KnkW/bgji2U8G8Spi76HDfBLwjQlOrX7yIbQTwS9Qnug0/Ek2zj+AmhtF6C7ol6wUWWF8DjO/31zWWXlCXxbgFo+C4oPnJAr1YksU5EldIaWq2IsOBFIeL1ucrpN5jSBhyrw8onWpPe+7LXjhN1H7oYdcjvB3Lycwf2nzA6TrxfwvVK9QaMl8SAcM0cmPYLonMttJAIehDBn0halFc8xyfKac0WcqoQY4uN0SpnHphSU2zvYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95ndQ62AB92fhY5rEBCpak+qyCtxNaVtker4PgIp7a8=;
 b=AasdITerrQOOrbybsrOzxKO00FBV3UNnWadiF/yzGpaJ/xC7B4b+vnlJw8mJkU3WrE3ybfajzRxgSBk/u5aHLlVX9Jua7fx9V3lYHBTIdoHMGV1RGGJZCi8xtjNIvRQpNHO0sMQC6l/A6r53P3HUO+ydHmbtRnL3xLfxzONqxYWLvcYM5qUucUsazCddg0zDEzZAqlwY0TvRkhJZJHu4tbRgtQdhnJLamQ6Db6hpzaJgsEph9xSyACQ2vcrCo8xxOT+8hDgFkDbhqk+PAV2wZuS65Zn6GrVNem2/upKEpLxwe1dSJv1R8Cx2v+iFvFGlqFzlMAtc2grMGb2IABXY8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95ndQ62AB92fhY5rEBCpak+qyCtxNaVtker4PgIp7a8=;
 b=qjEmtFxUVBHHYtTE0riw+W30oyCNDdYAvpG9ZuBcAjAkK+bjI/g1Ma7/HrjplDSB+ibKu33j3gBVEAQJme0kTX/F/TBqnxi9HbO76ml1pc7odvs0McpqnI2rkuRoDQhIh9Ib5jCEMneGIbYdS3cvfrWgWuxG0gYPzolUUvQ6Uuk=
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com (2603:1096:404:d5::22)
 by TYAPR01MB2958.jpnprd01.prod.outlook.com (2603:1096:404:85::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.16; Tue, 26 Jan
 2021 04:27:37 +0000
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::2023:7ed1:37c3:8037]) by TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::2023:7ed1:37c3:8037%5]) with mapi id 15.20.3784.017; Tue, 26 Jan 2021
 04:27:37 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     =?iso-8859-1?Q?Pali_Roh=E1r?= <pali@kernel.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
CC:     Peter Chen <peter.chen@nxp.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jun Li <jun.li@nxp.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] usb: host: xhci-plat: fix support for
 XHCI_SKIP_PHY_INIT quirk
Thread-Topic: [PATCH v2] usb: host: xhci-plat: fix support for
 XHCI_SKIP_PHY_INIT quirk
Thread-Index: AQHW2UemNB5r1TTib029sWHXFxYWcaoFwTaAgCCRuICAAoBBAIAPxLcAgADnsXA=
Date:   Tue, 26 Jan 2021 04:27:37 +0000
Message-ID: <TY2PR01MB369295E3D3BF6D5700EC50CCD8BC0@TY2PR01MB3692.jpnprd01.prod.outlook.com>
References: <20201221150903.26630-1-pali@kernel.org>
 <20201223161847.10811-1-pali@kernel.org>
 <20201224055836.GB27629@b29397-desktop>
 <20210113232057.niqamgsqlaw7gojw@pali>
 <88b48c61-65e4-cc24-d90d-5fba92f05f27@linux.intel.com>
 <20210125142028.th4sscs27arhihm2@pali>
In-Reply-To: <20210125142028.th4sscs27arhihm2@pali>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=renesas.com;
x-originating-ip: [240f:60:5f3e:1:c9e2:7ecf:2fa4:438b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dfcb6716-de2c-4420-fd63-08d8c1b2b615
x-ms-traffictypediagnostic: TYAPR01MB2958:
x-microsoft-antispam-prvs: <TYAPR01MB29585ECD16FC1FA80ECE653DD8BC0@TYAPR01MB2958.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z0JE0f0n/L7wuhHzL0YROSgfEU6RJH8rSsCH5PPXkn9y6nfYqqT3eD0r/YshE054HA1YHqxo53B/N1Bdi0XhM7vDLEA8IzgdAg0DzetV9ozNkcwoeI+smN4N43xgtxx77+Y/bBg28qE69ohsoiEQEtHaCF43IMQuU29RayFExkd7qh5mAgxYRdSqQ4iROrS8sbvVYaPPnSOPgC2eTHsyvPYtIU4Tb0cED9KhHT8mhinMKRyqYzILMJfZIIz8H67kE2NEs9OxRTRnULAnvi3+6OtS3b6BoCFWb9FkV0jjVH/OkAtsZr/sacPTplt9BGScos6tyahhYYbodkT3vyDvGsjCv9M3iMo4lrhYRsFhFlWTouO2nAspTGyktZQi/SqScS1p6wr97TbbaNFl2LLxvg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3692.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(39860400002)(136003)(396003)(376002)(71200400001)(7696005)(186003)(55016002)(110136005)(5660300002)(8936002)(316002)(86362001)(76116006)(54906003)(2906002)(33656002)(8676002)(6506007)(52536014)(66946007)(9686003)(53546011)(478600001)(4326008)(66446008)(66476007)(64756008)(83380400001)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?3gvGBxyWNh3zTUdaXmH8d2qcWSLt4lREL+YsKebvxyHzYK+Y5moVwQOBZd?=
 =?iso-8859-1?Q?CgOovU9tq7MBVcbgQUCRMVqh26GIEP5V14hfrILOqmlx0t2Y7fflwMDTKu?=
 =?iso-8859-1?Q?LaMHCFyYdbfsrO68N8NOWSACrFdLYEUrK3Pwj1mbhu9+aBMYqGmVCXT6Fl?=
 =?iso-8859-1?Q?39vItfKhFr4X+QNc3wKfL+DZqr44ju1ey4NWKaFoBZOKHbUWwNuQSj6fa3?=
 =?iso-8859-1?Q?/EQTVYUw6M8x4gD7sbHh/bRSTCS6KTBxWbDMH6jQ7AEpoJJf0pPap5kr/X?=
 =?iso-8859-1?Q?fu03e9vSJ84SmJDj7ehfOICA7/PremxqEg5P+BFF8QxLwre/VCgNtf0Z71?=
 =?iso-8859-1?Q?7Av5jEFIbbq0b4Rx1SB6/Ne4pJRFM2Kv4LU93VFMGxiKA95Iun/UHqut4b?=
 =?iso-8859-1?Q?D6bqh87LWdJ1WLsUUIt4C/hWk91Hq3O+Tiw+zeQLsC7IYsZyrt9GELO4C6?=
 =?iso-8859-1?Q?Xzb2ws6nZl40oVuj8OIx6tbuM+LMeQEnVKA5qNRnxH3/oWq4aSxaIHazA1?=
 =?iso-8859-1?Q?mSfXdb2Gk9HZAjqV1DfE8Co2C13hpX0RtvKjG7ROLN87Ie50TZ7N7yi9HT?=
 =?iso-8859-1?Q?E77ApqrE0U2QsGX8J752zCcfeM+aBRhmcO5zo+N6T15RVXGMdI1F0Mcadx?=
 =?iso-8859-1?Q?dvN4ebDvMlmqtFaSOgacPpTMizYrAKhb4LYEuUooeP+fyQXO8n4QQvnsMl?=
 =?iso-8859-1?Q?XpIvt2tWMCp2iP9zWyRE9JDidvrax2JSAbvrFSRQirUpTgrleQjccdzFx7?=
 =?iso-8859-1?Q?V+THim6ud/AVDIgy5Wc9cji1+M4Y3LE98uQ4ZK7s5WVQXhE9oidv8vVRwH?=
 =?iso-8859-1?Q?tItXx2sxDnTuujAl4+dPfBN7ZatpCB5nKZBtqpXha0TydV0pkqwOlY5+r2?=
 =?iso-8859-1?Q?S8N3QLzPVdplG6MOcGWooXIkqkOi05oIeNHwYFhodguZhfs4e42vf75JPs?=
 =?iso-8859-1?Q?iZ3tuE+fw92hxsb1pLEBcfk3drNQ9fwKeCoALBrkmahnBySqqNNZ+UT3UW?=
 =?iso-8859-1?Q?YB8pzrOlZY6BwQuIZ2cU8iXbaS6IN/kuo1yyDwE+mapYMzFaBNueYgeWSw?=
 =?iso-8859-1?Q?xvqmc8zD98ujb5oDBLXy5zWKm+Rag2yIpUFF1Tm8CBUXCUvstado7Y0sWb?=
 =?iso-8859-1?Q?UHlZ1+SAoYdwMvecXJ4CnN6IRVe7s=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3692.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfcb6716-de2c-4420-fd63-08d8c1b2b615
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2021 04:27:37.4599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E2j6KO9aoIxkHX3h3XcNfyZZA6tqkAhxzYbS9HSZAnJS2cdoKPDDVMxnr2PK7YlKJqoqQ3X59VTsIx04qvPv47txNLIMqhOM8yBF8WPWy5zgSSUHy2i48Ino/9B60xUg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2958
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pali,

> From: Pali Roh=E1r, Sent: Monday, January 25, 2021 11:20 PM
> On Friday 15 January 2021 15:32:30 Mathias Nyman wrote:
> > On 14.1.2021 1.20, Pali Roh=E1r wrote:
> > > On Thursday 24 December 2020 05:59:05 Peter Chen wrote:
> > >> On 20-12-23 17:18:47, Pali Roh=E1r wrote:
> > >>> Currently init_quirk callbacks for xhci platform drivers are called
> > >>> xhci_plat_setup() function which is called after chip reset complet=
es.
> > >>> It happens in the middle of the usb_add_hcd() function.
> > >>>
> > >>> But XHCI_SKIP_PHY_INIT quirk is checked in the xhci_plat_probe() fu=
nction
> > >>> prior calling usb_add_hcd() function. Therefore this XHCI_SKIP_PHY_=
INIT
> > >>> currently does nothing as prior xhci_plat_setup() it is not set.
> > >>>
> > >>> Quirk XHCI_SKIP_PHY_INIT is only setting hcd->skip_phy_initializati=
on value
> > >>> which really needs to be set prior calling usb_add_hcd() as this fu=
nction
> > >>> at its beginning skips PHY init if this member is set.
> > >>>
> > >>> This patch fixes implementation of the XHCI_SKIP_PHY_INIT quirk by =
calling
> > >>> init_quirk callbacks (via xhci_priv_init_quirk()) prior checking if
> > >>> XHCI_SKIP_PHY_INIT is set. Also checking if either xhci->quirks or
> > >>> priv->quirks contains this XHCI_SKIP_PHY_INIT quirk.
> > >>>
> > >>> Signed-off-by: Pali Roh=E1r <pali@kernel.org>
> > >>>
> > >>> ---
> > >>> Changes in v2:
> > >>> * Check also xhci->quirks as xhci_priv_init_quirk() callbacks are s=
etting xhci->quirks
> > >>> * Tested with "usb: host: xhci: mvebu: make USB 3.0 PHY optional fo=
r Armada 3720" patch
> > >>> * Removed Fixes: line
> > >>> ---
> > >>>  drivers/usb/host/xhci-plat.c | 16 ++++++++--------
> > >>>  1 file changed, 8 insertions(+), 8 deletions(-)
> > >>>
> > >>> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-p=
lat.c
> > >>> index 4d34f6005381..0eab7cb5a767 100644
> > >>> --- a/drivers/usb/host/xhci-plat.c
> > >>> +++ b/drivers/usb/host/xhci-plat.c
> > >>> @@ -89,13 +89,6 @@ static void xhci_plat_quirks(struct device *dev,=
 struct xhci_hcd *xhci)
> > >>>  /* called during probe() after chip reset completes */
> > >>>  static int xhci_plat_setup(struct usb_hcd *hcd)
> > >>>  {
> > >>> -	int ret;
> > >>> -
> > >>> -
> > >>> -	ret =3D xhci_priv_init_quirk(hcd);
> > >>> -	if (ret)
> > >>> -		return ret;
> > >>> -
> > >>>  	return xhci_gen_setup(hcd, xhci_plat_quirks);
> > >>>  }
> > >>>
> > >>> @@ -330,7 +323,14 @@ static int xhci_plat_probe(struct platform_dev=
ice *pdev)
> > >>>
> > >>>  	hcd->tpl_support =3D of_usb_host_tpl_support(sysdev->of_node);
> > >>>  	xhci->shared_hcd->tpl_support =3D hcd->tpl_support;
> > >>> -	if (priv && (priv->quirks & XHCI_SKIP_PHY_INIT))
> > >>> +
> > >>> +	if (priv) {
> > >>> +		ret =3D xhci_priv_init_quirk(hcd);
> > >>> +		if (ret)
> > >>> +			goto disable_usb_phy;
> > >>> +	}
> > >>> +
> > >>> +	if ((xhci->quirks & XHCI_SKIP_PHY_INIT) || (priv && (priv->quirks=
 & XHCI_SKIP_PHY_INIT)))
> > >>>  		hcd->skip_phy_initialization =3D 1;
> > >>
> > >> I am not sure if others agree with you move the position of
> > >> xhci_priv_init_quirk, Let's see Mathias opinion.
> > >
> > > Hello! Do you have an opinion how to handle this issue? As currently =
it
> > > is needed for another patch which is fixing issue/regression in xhci-=
mvebu:
> > >
<snip>
> > >
> >
> > I can see the benefit in this.
> > In the xhci-plat case usb_create_hcd and usb_add_hcd are separate steps=
, and
> > we could both copy the xhci_plat_priv .quirks and run the .init_qurks b=
efore
> > adding the hcd.
> > I guess the current way is inherited from pci case where the earliest p=
lace
> > to do this after hcd is created is the hcd->driver->reset callback (whi=
ch is
> > set to xhci_pci_setup() or xhci_plat_setup()).
> >
> > xhci-rcar.c is using the .init_quirk to load firmware, we need to check=
 with
> > them if this change is ok. (added Yoshihiro Shimoda to cc)
>=20
> Yoshihiro, is this change OK?
>=20
> Can we move forward? I really need to now how to handle regression in
> xhci-mvebu driver. And one option is with this patch...

Thank you for asking me about this topic. I tested the patch, but unfortuna=
tely,
this patch is possible to break a rcar platform because a phy initializatio=
n is
needed before the firmware loading if the platform uses the phy. (Note that
upstream code (salvator-common.dtsi) doesn't use the phy for xhci. But,
if we use the phy on other board with this patch, the xhci will not work.)

So, I think we need to add a new function pointer for your case.

Best regards,
Yoshihiro Shimoda

> > Their firmware would be loaded before phy parts are initialized, usb bu=
s
> > registered, or roothub device allocated.
> >
> > Thanks
> > -Mathias
