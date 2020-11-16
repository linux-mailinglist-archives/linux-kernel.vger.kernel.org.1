Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6036D2B44E6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 14:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbgKPNna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 08:43:30 -0500
Received: from mail-vi1eur05on2070.outbound.protection.outlook.com ([40.107.21.70]:29377
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726615AbgKPNn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 08:43:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dw6z/KdxKRkH6qqiRxqd7g8kSZsZZZouz5c0/FYW9XqzBmOjJtVfTDA3XmGATNPO9zBCE0XZy20FaxpR5YwTQxHCPbdUsR+CgZrq0jqzzc8b4mQe5FL8gV7nJGEE8snltJ290NEp5t/XVyOz52qtVyEE+74MWOtO/m48oZV+xLboFC6thFpS70PZCZKqajUrRo7Zdo2KPuFKu9LxohxCy12lCfDCnyyG6r/5ka4X10ul3OqUCMBiepVsAQDw1+9uzFHXsdqtMsCzO+vCwz1bdqAvNftTArihLPSUVL3VZSpmDvvkaA6iE/88YcGncKxdBWywa0ftwOZAOTBcGMsvPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8b6vmCpdGesgD9VsLkDt6+Dq9OBsewhJ+5h556xZImg=;
 b=MIHu1kwqbK/vCPqDcIv+Gm25BYDgGEwUIUrsumIGa4lP0NAuv0gLMJAPtuBlukBwugiBGHfbVLzxYBqy/MFxQGCdClOPk8MJLhN9JO9uE/QfEEick0C8i4jqUb3NouQu0NwSKD5aF38ICOOwbEMdCEyAh/Pz7hbJlIpCrAfyumaNtmMWbTiqTHACjDu8Gb8boFk716+M7yCOINC8aqMI9HGCiU2aIyQyAuu3iGU39rVmx8SqLEQFPnZgMJZ3iyjqL9IsMaIORaeYDNhTGRp3IF2FmmrKPC7MhEwbqfkpa1ntSTWvvUhHJIK19BllkvTXaaEZJTdNKTkUAQmfo5YbLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8b6vmCpdGesgD9VsLkDt6+Dq9OBsewhJ+5h556xZImg=;
 b=kokYgRcbAlBl22nOXC9cG4/0A0PWcOwPuQuIIl6XR4MtVZ0ba2YmJ+4U8GI6KO4z/Y+gqlbFiRkH0+DLPefDJzniq4PnUwsxRkAOXV0JWSK0eGC27wnQ1cW1DTLgN3+C0M+0LTV//t9WWgXIDcKjuO8aj1znh3N6ks5wbrcX0BM=
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com (2603:10a6:10:1ec::9)
 by DB8PR04MB6715.eurprd04.prod.outlook.com (2603:10a6:10:10d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25; Mon, 16 Nov
 2020 13:43:25 +0000
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::c8c:888f:3e0c:8d5c]) by DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::c8c:888f:3e0c:8d5c%5]) with mapi id 15.20.3564.028; Mon, 16 Nov 2020
 13:43:25 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Wesley Cheng <wcheng@codeaurora.org>
CC:     "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "jackp@codeaurora.org" <jackp@codeaurora.org>
Subject: Re: [PATCH 1/3] usb: dwc3: gadget: Introduce a DWC3 VBUS draw
 callback
Thread-Topic: [PATCH 1/3] usb: dwc3: gadget: Introduce a DWC3 VBUS draw
 callback
Thread-Index: AQHWul428/SymkiG90aqrLQfwE9+U6nKyAoA
Date:   Mon, 16 Nov 2020 13:43:25 +0000
Message-ID: <20201116134255.GD28313@b29397-desktop>
References: <20201114081247.25063-1-wcheng@codeaurora.org>
 <20201114081247.25063-2-wcheng@codeaurora.org>
In-Reply-To: <20201114081247.25063-2-wcheng@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: codeaurora.org; dkim=none (message not signed)
 header.d=none;codeaurora.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 61bc9d57-c9c2-47c3-21e8-08d88a359790
x-ms-traffictypediagnostic: DB8PR04MB6715:
x-microsoft-antispam-prvs: <DB8PR04MB67158CBDFB6EF0ED3CC699538BE30@DB8PR04MB6715.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qyHgjgGi+Z+k1n7TlaUyy15nuTY05U1InLfhEt146ojlEbax70zxS+TgP+ODMES9D3wBMJMFhi5T10ofisLINr5XsXu+lNYifj2ijftiJ5nltlusH8Hspw0VEqOWg2Dn+TQDJd3C2GZCWiZUKRRIzB3w0iXMPUutUH917XtzTQ5R82gE239fQ1z7fX8//oV4xX26Vvrr9mr8VqIGTv8ZHeGg96p6ewzOTsqzybmKEK32D1hNGkheUyskaRDthog9HIfsAi5NH8qoF4QrSJfMy2B0GKlmjqXX5bXVur7juw23NKtsyHNhY34NDPAwzJCNyPgrZ91cbOM4YKMl1iWddA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7979.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(376002)(39860400002)(396003)(366004)(136003)(346002)(71200400001)(6506007)(6512007)(44832011)(86362001)(54906003)(26005)(8936002)(8676002)(91956017)(316002)(6486002)(53546011)(1076003)(9686003)(66446008)(186003)(2906002)(478600001)(33656002)(64756008)(83380400001)(66556008)(33716001)(76116006)(4326008)(66946007)(6916009)(5660300002)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 6tdOlqJ30xhNwJfhrmK5srWaStUpbF9I91jIkOFrpLbVikmRkDoruXRmCgSqhnAvuNRoBsnLXNeW46yPS6q6/UWUqOI+5sXB9RfzeTxvyge1FBfrUj7lCSl7Gj03s+Orn7InZRp4SGPT/uUt3BWg+xQenWp2ST0RERCpWQBT5cG7l4NQGLV5Njk1gNsuEKHXc+wZZPN/t+116I0eCH7AXsJdm7HxXo6f1Kz3lELA2KCoLD3WwNu7GGNMSriDtpip0qstb3sBKcixI3USynNvYkN85rXJGeCWfsbHHPKQN8jWZqEWBA0elsKn57rYD3DiUlJsmlZ/8COhKbcWFuUK8M9WZrzKQIMb6rRmfgENJmfQfOdezTWCBvaUzGjiA/TVBT784O3BUVHVOQxqrHzWcvY17AoJKc8tZ5NEHt2zVkFWqPs6KHKghjvlAoomXcsfwmjbYPK2wZiekmmDdv4QXPHAYiat2Gw2XR+yetuoylQKHlRrdm814tjqN1ZmavDK01z1MYP8HTMlY/wMFIXxDzYLwiDPxS7KtF9dscefzuPUzBwO8gPA5e5WQNvUhB3nbEWRrofXfFJC/VPk4sUbb6Ph/TnQwa2/nD20N2lPQPi0YqO9EQXUTwCC3a/ySLNBemEbpHhORUnAmA04cHNzCw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C7154BF661943241BCD2F83977331297@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7979.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61bc9d57-c9c2-47c3-21e8-08d88a359790
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2020 13:43:25.1270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ONqsbbIO9MjStpOf14CIDJP3+A7RzvLbjsMRUoaMobHN/zTgumtVhVDCL1ZK+I1cGEam8r6O7Ri2Uwj35igsXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6715
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-11-14 00:12:45, Wesley Cheng wrote:
> Some devices support charging while in device mode.  In these situations,
> the USB gadget will notify the DWC3 gadget driver to modify the current
> based on the enumeration and device state.  The usb_phy_set_power() API
> will allow external charger entities to adjust the charge current through
> the notifier block.
>=20
> Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
> ---
>  drivers/usb/dwc3/gadget.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index c145da1d8ba5..69122f66978e 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -2387,6 +2387,16 @@ static void dwc3_gadget_set_speed(struct usb_gadge=
t *g,
>  	spin_unlock_irqrestore(&dwc->lock, flags);
>  }
> =20
> +static int dwc3_gadget_vbus_draw(struct usb_gadget *g, unsigned int mA)
> +{
> +	struct dwc3		*dwc =3D gadget_to_dwc(g);
> +
> +	if (dwc->usb2_phy)
> +		return usb_phy_set_power(dwc->usb2_phy, mA);
> +
> +	return 0;
> +}
> +
>  static const struct usb_gadget_ops dwc3_gadget_ops =3D {
>  	.get_frame		=3D dwc3_gadget_get_frame,
>  	.wakeup			=3D dwc3_gadget_wakeup,
> @@ -2396,6 +2406,7 @@ static const struct usb_gadget_ops dwc3_gadget_ops =
=3D {
>  	.udc_stop		=3D dwc3_gadget_stop,
>  	.udc_set_speed		=3D dwc3_gadget_set_speed,
>  	.get_config_params	=3D dwc3_gadget_config_params,
> +	.vbus_draw		=3D dwc3_gadget_vbus_draw,
>  };
> =20

Reviewed-by: Peter Chen <peter.chen@nxp.com>

--=20

Thanks,
Peter Chen=
