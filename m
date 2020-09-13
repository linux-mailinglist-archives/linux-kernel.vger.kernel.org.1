Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B901C267DFF
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 07:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbgIMFM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 01:12:59 -0400
Received: from mail-eopbgr30054.outbound.protection.outlook.com ([40.107.3.54]:13294
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725806AbgIMFM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 01:12:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IdpH1+OaRvwJklpUZtKAlsRGfX8h3MNuroUNVZJNc1o0VaQur3/aScwKCW1or/DbA/1KWzjqlZqd8JCW39jBV6EKLRfpN3ymKOupOvB+aXGsgpYpBjd1q6ZItZO07heAPoJkjzM/CESPMf6GuMqEZ/0sfSaCtBRLyrjdlfclMXk6WX9Ae8XceIlRaAyDrooCRRvSmv0PvESKQ9vAy+zYWXv0du/0/MQEWJjUYTBCKbpHxOej/ZZsfzkQk52nzsc/2fbBm0jr0SyCfbkVzrwV5Kf23SvZMKMw5cIiTs6sF10qf7Y6i+xdQ5jtFcDTKu4Wj6dCBXD3730zRXLz/UVvXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bkxSwcI9U/IDPsfKFKio31quZRSNfmrNK0O9hjMCh20=;
 b=mwxw9KjbSqvMn+C0h5NwqaRHqbwGEHgbc+ItV6gI3536NqmTEBHaLrlmiC2KA6b/1siPYddakKanNX2PtZYI7L0d4VgIF4vQa3pN7Eg2Db8ZlCgpd7LA+THhLgRqvPSvPmYVPLF9LXqVzvdX1XH+1erMWeaDminBVAAL6/6vw3YDeGc+IX0DflyVB+UAN4ZQHYJGf7n0Fu2JpyRfMVYftGNd+Nodd07Nku20GaMrX8T1eflkNxOi2Lk+g6iXtPhc+bC9BAVl81083FxLdWNQ146VXYJMb6WI8AmOd19R6JlcHwAt5ZxrU0ApwXRfSIXw3A/dr/cBVCIhlmI5IlFR4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bkxSwcI9U/IDPsfKFKio31quZRSNfmrNK0O9hjMCh20=;
 b=szAd4W6PSZ5Br1h3L07HvqJKIaHsHwYrVEYfKyG7fvN/XNu7cLlrX7eZK757tMIsnve1Nl/+w6YFFyuL+wWITz0gCjuRq9ki4uxzJ/yq5Ruu+7/fpJPs28ETAeTPFaLGBlhDt7q2sjJ6xNdguM5kM2hRXr8P+rbVAoOfn9M0uQA=
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20)
 by AM6PR04MB4421.eurprd04.prod.outlook.com (2603:10a6:20b:21::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Sun, 13 Sep
 2020 05:12:52 +0000
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1023:be8d:40c:efe1]) by AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1023:be8d:40c:efe1%3]) with mapi id 15.20.3370.019; Sun, 13 Sep 2020
 05:12:52 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        Yuti Amonkar <yamonkar@cadence.com>,
        Sanket Parmar <sparmar@cadence.com>
Subject: RE: [PATCH 2/3] phy: cadence: salvo: Constify cdns_nxp_sequence_pair
Thread-Topic: [PATCH 2/3] phy: cadence: salvo: Constify cdns_nxp_sequence_pair
Thread-Index: AQHWiUYfwDwfM1ZGOUG7bkBOUjQ0SKlmBihg
Date:   Sun, 13 Sep 2020 05:12:52 +0000
Message-ID: <AM7PR04MB7157E52665722D732A4581808B220@AM7PR04MB7157.eurprd04.prod.outlook.com>
References: <20200912204639.501669-1-rikard.falkeborn@gmail.com>
 <20200912204639.501669-3-rikard.falkeborn@gmail.com>
In-Reply-To: <20200912204639.501669-3-rikard.falkeborn@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: eae21424-0363-402c-1d9e-08d857a3aab6
x-ms-traffictypediagnostic: AM6PR04MB4421:
x-microsoft-antispam-prvs: <AM6PR04MB44214B5E01145FE8704CBFE88B220@AM6PR04MB4421.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5Ga3refY2wOZS71I9vVVVdhRvfz4iJe9KOQWufyNyD4vUyx2qopWIA11oKSUO11xt3m4V00x7I93RyWML8tQoCNdEFzCGrUujd3qOq/OPQKnTWCbehi3krdCpMzaRkQUrpIemDYRFn8z0JrU56CsgX+ViRXPbDHFloLXriwOt08V1tbWSlBV2jOpO46B0FVJLjb1tkDI2Gfh1UWY5tPAiHu5LMAPpltLHPts17sJV4wx12RHUBpLn0Uo6FNzDxKEDKUfK8GH8TjpMnkej55qUYiQtxCVn4N7drdLH5bdsvwIAiPpUD0EYGRDvMaFE3ztfXH47fSrfo694tESYVqUDg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7157.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(136003)(39860400002)(366004)(8936002)(8676002)(110136005)(44832011)(186003)(86362001)(2906002)(83380400001)(71200400001)(5660300002)(478600001)(4326008)(33656002)(52536014)(316002)(54906003)(55016002)(26005)(66446008)(7696005)(64756008)(66946007)(9686003)(66476007)(76116006)(66556008)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: ABXWIwpawqV6Pvd0Csuo4bLx5V5tHx083eXr3vMfYvzy+So5Hb/+byhe3xBTKTj1jFKYNuNX86tcLQKS8Lq4gY7HjeUMrQTEz6AL7buLvIl/uBM9JS/hbOBY8xIRjqbxkn+z/dPUTUC9W6G+UE2CeSpN3f2GreiyngUCaQz3s3/CcJKruznFYd6ckb2pbgpnvdho0fjfb8zcOwZFICqszFYoI3dCYjiU5HcvndG0C83nYtnCpNJ874hEvNwtP0zyJuP1huuwYVBjSHOTgxSbtupIDQGN1ILf2kh9ZxdiTRP2IwE19RvZ5k/vsULU9Biys0Z/hyhN8iK/l8PqXnMPwECU4U2/+fXC+CQqRtbHLlT6jN/nc1n5a+X4OPO5n0Yybz0pYeOnoPg4YZafX55HQi511oo7zBe5xrc47qpcW6zBumkv8maQ+/GyERnmbz9ZA4l5F3dEp4rp3dduiiQv+o7IB8b+ylSQn8s04DufZYi3hvXv3Wdjghm962L5c4QyoVonte/1gcJet0seaj6uF824Iy77F/+kFjFVuIJ3N/cE67tGNMS46YA9O0NYySkjn6ZeGk2UbzlYV1y49dmdlf7VGSS19D4inkft1/jxi3JWUk98yCK3UNh+0lpiKtTbhKNbADBrOoZEV/RmOQN3Pw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7157.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eae21424-0363-402c-1d9e-08d857a3aab6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2020 05:12:52.7765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NhhwmAzSUQdNE4lGdvm/jiYtrpekYIv76CPVmc67XAvc1a6I0pMPP5ibE0NnrMS9zYjyD+whNTcngTXk6Ratnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4421
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=20
>=20
> cdns_nxp_sequence_pair[] are never modified and can be made const to allo=
w
> the compiler to put them in read-only memory.
>=20
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>

Reviewed-by: Peter Chen <peter.chen@nxp.com>

Peter
> ---
>  drivers/phy/cadence/phy-cadence-salvo.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/phy/cadence/phy-cadence-salvo.c
> b/drivers/phy/cadence/phy-cadence-salvo.c
> index 8c33d3215f2d..88e239adc3b8 100644
> --- a/drivers/phy/cadence/phy-cadence-salvo.c
> +++ b/drivers/phy/cadence/phy-cadence-salvo.c
> @@ -97,7 +97,7 @@ struct cdns_reg_pairs {
>=20
>  struct cdns_salvo_data {
>  	u8 reg_offset_shift;
> -	struct cdns_reg_pairs *init_sequence_val;
> +	const struct cdns_reg_pairs *init_sequence_val;
>  	u8 init_sequence_length;
>  };
>=20
> @@ -126,7 +126,7 @@ static void cdns_salvo_write(struct cdns_salvo_phy
> *salvo_phy,
>   * Below bringup sequence pair are from Cadence PHY's User Guide
>   * and NXP platform tuning results.
>   */
> -static struct cdns_reg_pairs cdns_nxp_sequence_pair[] =3D {
> +static const struct cdns_reg_pairs cdns_nxp_sequence_pair[] =3D {
>  	{0x0830, PHY_PMA_CMN_CTRL1},
>  	{0x0010, TB_ADDR_CMN_DIAG_HSCLK_SEL},
>  	{0x00f0, TB_ADDR_CMN_PLL0_VCOCAL_INIT_TMR},
> @@ -217,7 +217,7 @@ static int cdns_salvo_phy_init(struct phy *phy)
>  		return ret;
>=20
>  	for (i =3D 0; i < data->init_sequence_length; i++) {
> -		struct cdns_reg_pairs *reg_pair =3D data->init_sequence_val + i;
> +		const struct cdns_reg_pairs *reg_pair =3D data->init_sequence_val + i;
>=20
>  		cdns_salvo_write(salvo_phy, reg_pair->off, reg_pair->val);
>  	}
> --
> 2.28.0

