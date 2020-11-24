Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC2562C24EB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 12:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732940AbgKXLrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 06:47:16 -0500
Received: from mail-am6eur05on2076.outbound.protection.outlook.com ([40.107.22.76]:56960
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732436AbgKXLrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 06:47:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ieO4gkzm2QBoM5+yHK1/UhddKKkyRIM/otC3V5uyDLBfMXU/ERu+ejzrlFDJFzE/EZc/hjXjTmcdUM1MIUiRvFMYBYogA98DD9GwLPvrEIDsAJ9PofXdsiBEcQkBe8K/Gq0tO+fExldjSaZLG9zb4PQEGfYEntg4GPh293Q52UZOS2hZ/eLMl2gdCRAdbgAIcgAQZ8ADT2bXKVSHjOnhmZS7r8G0J4VZIdopVXD4zlqxVh2qAA0h2eKOju4nC07023m6WpS27WXjgsN69uIk1qA7S1N4yA6N/UiA0VdAJyd9SC0TpNYD7Wx9RHuNkfRj+6GLT2R7mL4xUP/PYYGv2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9k8auju+ugoWOxoLcnzWhYmxRZVEVz+VuXG6Lq2t1Vs=;
 b=Q8aPb8MwnZIudsAL0NezrW4h7FqZZiIFKqxAUBzrSWZcYn0o9GIlF+52nrKy2rHubFkYUmjpo6CnXwhPcN0Bj/pPYxlpV5Hi2WV1DQ3uvN6JGXVI1aequVJTGU0PAc5F9T6o7oDoOjVrgp7T+YZTEx9wA7a+8y4jfr5XoMi006/79DKM1K5E2uIhUZ4uPiBgSLdE3a0m6HYBDwH6jbu7KoIP2HALA/1tTe0xDUEeC1iLZC7/v5QPrZT8lKlcXvqVG7Rt4xD0BvqhnZ5gGiNRYi/nYjgK5/6VszdnqQt5MwvblatwEDMXx3DesDFxyRD+MmMcOoRp1HyIhkQ/meKLyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9k8auju+ugoWOxoLcnzWhYmxRZVEVz+VuXG6Lq2t1Vs=;
 b=c9q78SSHmN/1uXEk5feUPeudq3E4aA2lCvBorHvWzDXx9of+CMUghOfNu0m7e8cdsT0+zQa+MevouLjK3FuULbiaacil1UIpJCAW0yvXVV+Ou29GCLjywxk9PDRoGpm4kpsZcs0ejFtf0BtyfGjVesQtB8lScQj6OzQI24u0CEI=
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com (2603:10a6:10:1ec::9)
 by DB8PR04MB6716.eurprd04.prod.outlook.com (2603:10a6:10:109::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Tue, 24 Nov
 2020 11:47:10 +0000
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::c8c:888f:3e0c:8d5c]) by DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::c8c:888f:3e0c:8d5c%5]) with mapi id 15.20.3589.030; Tue, 24 Nov 2020
 11:47:10 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Roger Quadros <rogerq@ti.com>
CC:     "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "pawell@cadence.com" <pawell@cadence.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Revert "usb: cdns3: core: quit if it uses role switch
 class"
Thread-Topic: [PATCH] Revert "usb: cdns3: core: quit if it uses role switch
 class"
Thread-Index: AQHWwY7qvaWheOMvwU2q0XXgyvVqyqnW1uYAgAAxWYCAAAPXgIAAC1EAgAAUboA=
Date:   Tue, 24 Nov 2020 11:47:10 +0000
Message-ID: <20201124114641.GA9929@b29397-desktop>
References: <20201123115051.30047-1-rogerq@ti.com>
 <20201124064242.GA32310@b29397-desktop>
 <89067b6a-5b94-d7d2-b07a-f434c9e5e2bd@ti.com>
 <DBBPR04MB797982E6E190F0C0E0980F258BFB0@DBBPR04MB7979.eurprd04.prod.outlook.com>
 <bdb2b4cb-686e-9283-bc66-78808b92c349@ti.com>
In-Reply-To: <bdb2b4cb-686e-9283-bc66-78808b92c349@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9f4a897b-2303-4730-ba7d-08d8906ead87
x-ms-traffictypediagnostic: DB8PR04MB6716:
x-microsoft-antispam-prvs: <DB8PR04MB67166D8D52C25820A78855F68BFB0@DB8PR04MB6716.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F0RY7qJ/LD7RpjJiUkjW3xdecYgVsL/gTha77aFFXZmdR6HR8NbmvK+4Rn8J7FSJb4DL/6KwgdfVBGPWontaEZf7kXzIci0cZoJsD6Mh2Q+vq2+apf+Hh3lWdEGNuMs5pvy4BuC6EvI4X9+pR+zY7HBlSq+uR5wtcXmadWwOjEZXEXAozQaXWjDwIETTP0QasYFnVLbWIOiyvWQYHa3a8I/nqhe6GThsv7286w2wtBF2LV2U4BV+TDzFwSVKyE5zt45uSQCZuWLXOp0HINjwJjMADsZ0CwRHFV2E4IQ1CtsiWn/LjXRp46w1mrxYoOG1vyrw4rIQyZ1pJvNB2L0fcg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7979.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(346002)(396003)(39860400002)(376002)(136003)(366004)(33716001)(26005)(33656002)(53546011)(6506007)(478600001)(6486002)(8936002)(1076003)(4326008)(316002)(2906002)(5660300002)(6512007)(66946007)(8676002)(9686003)(83380400001)(66476007)(66556008)(44832011)(76116006)(66446008)(6916009)(64756008)(71200400001)(54906003)(86362001)(186003)(91956017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Oa8ct7DP1FMkf1XFD7npEA//mLs/d3Fb2s7LBR/52+UvEfSc7oGKR0QKVraPEcb0yDRuxqp3Z7eA1cx+PfoExgdTRo3PriuKdVM9DMv2wPcBjx6w6yOkHotTy3ILCoTpI97NJ9HWZio0BUOH74AfC4jYcCD6DWYDxrGUQZ2s9ltYBq7gJLrgA8IDTkVv2VNRdEdrq5ShSn5+aERqeAsAw0+RVVEAp2/7M2xcjfmQ1QyB81wHLnOFcv2WnadS0Aa+Gya2l9ilA5Szq6GvyCLFvzwLlmXVs6Orn0eDbz/037xQ7WP8tCgAt/2OSg7BbMxU61ryeV7BdR+pJkHsIqJpOSdJmShz77CbaW9eKk45V9ip+kfvygf7DjKi4wetetAyLPPPx1IKE8XQTX9RjlkL/ZwG2P8mnsob97d5kfZbByBApZFUjSI12PSs71K+5j9ENybkQrk+twbAfSQbnCj/myKlI8vATq4AEQ5qaCkeYBC0pQK458IJmGbYMYxQW2P5nheeld9B2/6ejCt8urC2UiYtxdlW1rhrcfi/91xi/jylR3vB2RDXPKVmK8PIFJO5K10pIOiDAxDgHF/DP2rLGntgpv52wLTwoNqMVtPt/2TPyIoDHRmbeom+iK4j7sPwFMmmi0FUpYqKuMJEg+z+N/Tc8xZ3+l8oNu0EaDV8+dk23q5KP+nlyCbAhBGnd2SPUDnu+k1UtCuu7XOkmCWHL0MUglX1NClfXM1NIZxGkpHDLwH1N83AarhC0zqBuDTy2LdMoNCnYsPqEb/Xt2D+nGsmAvKO8wEDb5UKPTvy0VJ2wKjkHdoDIKDxMekd/a67K+G3ozatK1a7fozqninbTWIaVbEQzv0OFK2U3+Nhp05OKtySPdMrhBOKI+rr1E047XGQrK7aweQwUYt0wL4gnQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A97FDE914E60C64FACA826C0FA1CE657@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7979.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f4a897b-2303-4730-ba7d-08d8906ead87
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2020 11:47:10.4374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ly4yRfeB7HfUhHEj2OlmrKW9cp9YlI6o7urtc6TPfAuQCkzNZLu99DerajpPM1EvBv6TZ9/E6nohrAzdQn62mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-11-24 12:33:34, Roger Quadros wrote:
> > > >=20
> > > > I am sorry about that. Do you use role switch /sys entry, if you ha=
ve
> > > > used, I prefer using "usb-role-switch" property at dts to judge if =
SoC
> > > > OTG signals or external signals for role switch. If you have not us=
ed
> > > > it, I prefer only setting cdns->role_sw for role switch use cases.
> > > >=20
> > >=20
> > > We use both hardware role switch and /sys entries for manually forcin=
g a
> > > certain role.
> > >=20
> > > We do not set any "usb-role-switch" property at DTS.
> > >=20
> > > Currently cdns->role_sw is being always set by driver irrespective of=
 any DT
> > > property, so this patch is clearly wrong and needs to be reverted.
> > >=20
> > > What do you think?
> > >=20
> >=20
> > Could you accept below fix?
> >=20
> > diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
> > index 2e469139769f..fdd52e87a7b2 100644
> > --- a/drivers/usb/cdns3/core.c
> > +++ b/drivers/usb/cdns3/core.c
> > @@ -280,8 +280,8 @@ int cdns3_hw_role_switch(struct cdns3 *cdns)
> >          enum usb_role real_role, current_role;
> >          int ret =3D 0;
> >=20
> > -       /* Depends on role switch class */
> > -       if (cdns->role_sw)
> > +       /* quit if switch role through external signals */
> > +       if (device_property_read_bool(cdns->dev, "usb-role-switch"))
> >                  return 0;
> >=20
> >          pm_runtime_get_sync(cdns->dev);
>=20
> Although this will fix the issue I don't think this is making the driver =
to behave
> as expected with usb-role-switch property.
>=20
> Now, even if usb-role-switch property is not present the driver will stil=
l register
> the role switch driver.
>=20
> I think we need to register the role switch driver only if usb-role-switc=
h property
> is present. We would also need to set the default role if role-switch-def=
ault-mode is present.
>=20
> How about the following? It still doesn't handle role-switch-default-mode=
 property though.
>=20

Roger, you said you also use /sys entries (I suppose it means through role
switch class) to do role switch, with your change, there will be no /sys
entry for role switch.

Peter

> > > We use both hardware role switch and /sys entries for manually forcin=
g a
> > > certain role.




> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
> index 4c1445cf2ad0..986b56a9940c 100644
> --- a/drivers/usb/cdns3/core.c
> +++ b/drivers/usb/cdns3/core.c
> @@ -532,11 +532,13 @@ static int cdns3_probe(struct platform_device *pdev=
)
>  	if (device_property_read_bool(dev, "usb-role-switch"))
>  		sw_desc.fwnode =3D dev->fwnode;
> -	cdns->role_sw =3D usb_role_switch_register(dev, &sw_desc);
> -	if (IS_ERR(cdns->role_sw)) {
> -		ret =3D PTR_ERR(cdns->role_sw);
> -		dev_warn(dev, "Unable to register Role Switch\n");
> -		goto err3;
> +	if (device_property_read_bool(cdns->dev, "usb-role-switch")) {
> +		cdns->role_sw =3D usb_role_switch_register(dev, &sw_desc);
> +		if (IS_ERR(cdns->role_sw)) {
> +			ret =3D PTR_ERR(cdns->role_sw);
> +			dev_warn(dev, "Unable to register Role Switch\n");
> +			goto err3;
> +		}
>  	}
>  	if (cdns->wakeup_irq) {
>=20
>=20
>=20
> cheers,
> -roger
> --=20
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

--=20

Thanks,
Peter Chen=
