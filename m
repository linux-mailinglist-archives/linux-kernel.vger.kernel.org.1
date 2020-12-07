Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74C1B2D092A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 03:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbgLGC01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 21:26:27 -0500
Received: from mail-eopbgr60050.outbound.protection.outlook.com ([40.107.6.50]:18756
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726400AbgLGC00 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 21:26:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n7yGdQkAWnWCfR9pNR4FfNfOy7qLkuBn4J4nUHDvvdBu3On6qtZJ/BaSk5zmL/7iqaV/OPeWBEKMs87DemkhfQ5T+BDwRS092cFE43wdiSpHBA2Asz+RitCDSZ1gc3tS8JpCNdd1x/oggjxzadK8BIVWGZmP8TQXz5HukhJId0byHAiUFGjU/dqXoxKDRyqBr5+ewp7hRTzzCO22IhPNJypvHFrhRDXp8du0Eg9pmbmOt2YCeRkp9MNQhiuH2tlBoJ1qACzeJeR/CSbmTofQgvXXJ3+qdyWU8M+dQmu/lX4nEB/3UPf/OA84Z5NWcLGFL0bFh70XHie9ijuTgJGwuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zse4pKhjkyELOfk3Xe8LBznsfz33nMlKql3TXH41z9g=;
 b=JCEpQGdyFMwTb9K4i5RP6TA/+NAwWHJE/P75ihbevmugWr+0AmsIX2SFl0sDLQSf/33KzAGfi8njNoVLHDYE7x3Y6O8nvfZTRUSxIz0l5ykvGtsWl00deVgqoN6IcBCNz6lIoQIW6l1unU7h66P4KZEw3at7gudmY5EfsmY2SQQHSIwoI6X8bAsX838pyQ3YuN6OManycosYSXstjIqwzCbVMIxwflzZl3KxgB9NE3krfOywpnT4mWO25g9xkxMq+jGtxpLMR5d6slaTHhbQbdUV56xargX1cax639UQQfw144ReikEMD4eq30vnk/CCV/DKNZHnKTU43+IkVKo4HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zse4pKhjkyELOfk3Xe8LBznsfz33nMlKql3TXH41z9g=;
 b=Y+jPdAXUqoXVTktxtKBxj8tghcYAr+hKpv/BqF4Slx2xyO23KnaG6pAiMkszIEoi0OD7V7l+StVgm9ouUIBiNc+wS0XfW02lGceZcU07d8fG2Frga2Ra+sGK8DpDpflF4eXufp2Vvl1b4/AeBNq7exH/4Gs/UlQ12cH36oaMNEo=
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com (2603:10a6:10:1ec::9)
 by DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.18; Mon, 7 Dec
 2020 02:25:37 +0000
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::c8c:888f:3e0c:8d5c]) by DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::c8c:888f:3e0c:8d5c%5]) with mapi id 15.20.3632.023; Mon, 7 Dec 2020
 02:25:37 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Anant Thazhemadam <anant.thazhemadam@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Bin Liu <b-liu@ti.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>
Subject: RE: [PATCH 04/15] usb: misc: ehset: update to use the
 usb_control_msg_{send|recv}() API
Thread-Topic: [PATCH 04/15] usb: misc: ehset: update to use the
 usb_control_msg_{send|recv}() API
Thread-Index: AQHWxmmqKlq4UxeHFEKSHj1443IfHKnq83OA
Date:   Mon, 7 Dec 2020 02:25:37 +0000
Message-ID: <DBBPR04MB7979E6ADD92EA2E8B840B7B48BCE0@DBBPR04MB7979.eurprd04.prod.outlook.com>
References: <20201129160612.1908074-1-anant.thazhemadam@gmail.com>
 <20201129160612.1908074-5-anant.thazhemadam@gmail.com>
In-Reply-To: <20201129160612.1908074-5-anant.thazhemadam@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [180.164.155.184]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1c71ff6b-0600-49bb-78e5-08d89a576233
x-ms-traffictypediagnostic: DB6PR0402MB2760:
x-microsoft-antispam-prvs: <DB6PR0402MB276015A4A34724872C07085C8BCE0@DB6PR0402MB2760.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ziaNYl8MwenZFQNOhY5Wp/NYqMvcXCMyfQtStOJiBGwAzrYudLeTSCUR+cCqTc89BY7181GWAnWkHs6EWVV3xOEL1vW7R4domjXhDXUgPTxkbJS7acGS4KtJ/ROJVBIwa9+HdmnYY/UI8y5a36pROQ8/4MdUpTWLjDciBcqR8NqiaNrn+EBor8w2n4FOkTMh/g4HGIcAVtbh69F62a7jgIF78vWVim9ox03CiHWDncC6Cxq8ldg2CG9PirCf3Clfpzn/AgYBXzmJzm1iMzk9kmqqbArw8KD5F1mtVty3H7CAnZtzodG5vVmx0P0OFf0heaOFqTF/ESlq1uHBlutwSw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7979.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(136003)(346002)(396003)(376002)(76116006)(478600001)(8676002)(4326008)(110136005)(55016002)(5660300002)(44832011)(316002)(83380400001)(54906003)(7696005)(33656002)(6506007)(66446008)(52536014)(2906002)(186003)(66946007)(66556008)(26005)(15650500001)(8936002)(86362001)(71200400001)(9686003)(66476007)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?3e8bci1IV8Vi+2jOwEFn5zrt3UmSsFapwB0L9T7inKMs5vzH82wu7miQ0vlv?=
 =?us-ascii?Q?ZcDmPpY6N7kU+i9m9BEkyrky60hjYYhaWPqupJGMWYY6iXbKz7u15gG3XZJB?=
 =?us-ascii?Q?KPuJwxS/eHWmEPDUFVeMq1zwFkLl+clC/ye7az1r59ykshN29T1nd8SJhM/a?=
 =?us-ascii?Q?Lsu5E/bOjIGJpxHFyGmvN/3boKIvYTEkrC6A8QLP4mv0sRsymLGwhuRsivV/?=
 =?us-ascii?Q?bLuJLXuU623Hh0EItsNti2VnVWXkN/q3zz51+BaUD6azg6HvbxOYv+heE0SQ?=
 =?us-ascii?Q?mXQ8on3G7q93IUxYZQnltGeJf1ISOCl7QfYwcMSL/ED1F1sZK5bK2gRRrFL0?=
 =?us-ascii?Q?Pj/KMosSO5g9ASp3aEUWTKCAb9Z5X9DqiVbdbedlil/DSgKaPHkSi1nkremy?=
 =?us-ascii?Q?IKMF2PN9nisJRknPpeQ9tKRIhQdrsaryfSRc2fGYusX2WOSJZZWxqMUUB8td?=
 =?us-ascii?Q?+8USP2kzBWc4rBUhQNj1HcSlXPobf4oHXgiRfQZL8zxTXSqt4hFSyDoNVD2G?=
 =?us-ascii?Q?OjtEl4nFPkaM9Cep3uk7uo6ueGKH3v1CyTgtOCzhQKSfgMmz2xPCK4/+jhsP?=
 =?us-ascii?Q?tzz/lX5m0t3Wy+NM4bXmuCelDH1Fq8SAwh6dkez4RbN3d7f03FEDdS+DRvlF?=
 =?us-ascii?Q?Q41moFYMVmg6hfIpIhI8cS8Drd7O3tw6H8G3GdlAK7nJjJi2Z0bXFlgqV7bT?=
 =?us-ascii?Q?JiaL/7yRjbv2pGeJfopXDPqsjYBDolT1G9wE9d9jo2j9GODp00h13c5y2Z3z?=
 =?us-ascii?Q?fo7SZoqhYCFm7adDwlq097GJKys6ifrTLKhvfy3KktrY6cX3qflgd4kw6MUN?=
 =?us-ascii?Q?HJM96UuHskPV+JrHj1oVgjs/2z60ruVvUn7SmDXATLUFS1/Xk4TMDh8of98a?=
 =?us-ascii?Q?S/95kA087SO26P2SaPWYc77TryNQpK8gf5VEhkUOUYAyjpmoZ7gnQaSI45K/?=
 =?us-ascii?Q?QRPqVzdfokQk7BW2oIZ+z8GSzC2wB4cVl6dcO8HpAzI=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7979.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c71ff6b-0600-49bb-78e5-08d89a576233
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2020 02:25:37.1943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fLb4Ratk3MubXpNx3u0wGjtCgRXnS53FpjENsB7rmerlzaTnvt/UaCkNjxK0HxjlZkPtB1EYcXOWuTdTG+E3bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2760
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=20
>=20
> The newer usb_control_msg_{send|recv}() API are an improvement on the
> existing usb_control_msg() as it ensures that a short read/write is treat=
ed as
> an error, data can be used off the stack, and raw usb pipes need not be c=
reated
> in the calling functions.
> For this reason, instances of usb_control_msg() have been replaced with
> usb_control_msg_{recv|send}() appropriately.
>=20
> Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>

Reviewed-by: Peter Chen <peter.chen@nxp.com>

Peter

> ---
>  drivers/usb/misc/ehset.c | 70 ++++++++++++++++++----------------------
>  1 file changed, 31 insertions(+), 39 deletions(-)
>=20
> diff --git a/drivers/usb/misc/ehset.c b/drivers/usb/misc/ehset.c index
> 2752e1f4f4d0..068f4fae2965 100644
> --- a/drivers/usb/misc/ehset.c
> +++ b/drivers/usb/misc/ehset.c
> @@ -30,48 +30,42 @@ static int ehset_probe(struct usb_interface *intf,
>=20
>  	switch (test_pid) {
>  	case TEST_SE0_NAK_PID:
> -		ret =3D usb_control_msg(hub_udev, usb_sndctrlpipe(hub_udev, 0),
> -					USB_REQ_SET_FEATURE, USB_RT_PORT,
> -					USB_PORT_FEAT_TEST,
> -					(USB_TEST_SE0_NAK << 8) | portnum,
> -					NULL, 0, 1000);
> +		ret =3D usb_control_msg_send(hub_udev, 0, USB_REQ_SET_FEATURE,
> +					   USB_RT_PORT, USB_PORT_FEAT_TEST,
> +					   (USB_TEST_SE0_NAK << 8) | portnum,
> +					   NULL, 0, 1000, GFP_KERNEL);
>  		break;
>  	case TEST_J_PID:
> -		ret =3D usb_control_msg(hub_udev, usb_sndctrlpipe(hub_udev, 0),
> -					USB_REQ_SET_FEATURE, USB_RT_PORT,
> -					USB_PORT_FEAT_TEST,
> -					(USB_TEST_J << 8) | portnum,
> -					NULL, 0, 1000);
> +		ret =3D usb_control_msg_send(hub_udev, 0, USB_REQ_SET_FEATURE,
> +					   USB_RT_PORT, USB_PORT_FEAT_TEST,
> +					   (USB_TEST_J << 8) | portnum, NULL, 0,
> +					   1000, GFP_KERNEL);
>  		break;
>  	case TEST_K_PID:
> -		ret =3D usb_control_msg(hub_udev, usb_sndctrlpipe(hub_udev, 0),
> -					USB_REQ_SET_FEATURE, USB_RT_PORT,
> -					USB_PORT_FEAT_TEST,
> -					(USB_TEST_K << 8) | portnum,
> -					NULL, 0, 1000);
> +		ret =3D usb_control_msg_send(hub_udev, 0, USB_REQ_SET_FEATURE,
> +					   USB_RT_PORT, USB_PORT_FEAT_TEST,
> +					   (USB_TEST_K << 8) | portnum, NULL, 0,
> +					   1000, GFP_KERNEL);
>  		break;
>  	case TEST_PACKET_PID:
> -		ret =3D usb_control_msg(hub_udev, usb_sndctrlpipe(hub_udev, 0),
> -					USB_REQ_SET_FEATURE, USB_RT_PORT,
> -					USB_PORT_FEAT_TEST,
> -					(USB_TEST_PACKET << 8) | portnum,
> -					NULL, 0, 1000);
> +		ret =3D usb_control_msg_send(hub_udev, 0, USB_REQ_SET_FEATURE,
> +					   USB_RT_PORT, USB_PORT_FEAT_TEST,
> +					   (USB_TEST_PACKET << 8) | portnum,
> +					   NULL, 0, 1000, GFP_KERNEL);
>  		break;
>  	case TEST_HS_HOST_PORT_SUSPEND_RESUME:
>  		/* Test: wait for 15secs -> suspend -> 15secs delay -> resume */
>  		msleep(15 * 1000);
> -		ret =3D usb_control_msg(hub_udev, usb_sndctrlpipe(hub_udev, 0),
> -					USB_REQ_SET_FEATURE, USB_RT_PORT,
> -					USB_PORT_FEAT_SUSPEND, portnum,
> -					NULL, 0, 1000);
> +		ret =3D usb_control_msg_send(hub_udev, 0, USB_REQ_SET_FEATURE,
> +					   USB_RT_PORT, USB_PORT_FEAT_SUSPEND,
> +					   portnum, NULL, 0, 1000, GFP_KERNEL);
>  		if (ret < 0)
>  			break;
>=20
>  		msleep(15 * 1000);
> -		ret =3D usb_control_msg(hub_udev, usb_sndctrlpipe(hub_udev, 0),
> -					USB_REQ_CLEAR_FEATURE, USB_RT_PORT,
> -					USB_PORT_FEAT_SUSPEND, portnum,
> -					NULL, 0, 1000);
> +		ret =3D usb_control_msg_send(hub_udev, 0,
> USB_REQ_CLEAR_FEATURE,
> +					   USB_RT_PORT, USB_PORT_FEAT_SUSPEND,
> +					   portnum, NULL, 0, 1000, GFP_KERNEL);
>  		break;
>  	case TEST_SINGLE_STEP_GET_DEV_DESC:
>  		/* Test: wait for 15secs -> GetDescriptor request */ @@ -80,11
> +74,10 @@ static int ehset_probe(struct usb_interface *intf,
>  		if (!buf)
>  			return -ENOMEM;
>=20
> -		ret =3D usb_control_msg(dev, usb_rcvctrlpipe(dev, 0),
> -					USB_REQ_GET_DESCRIPTOR, USB_DIR_IN,
> -					USB_DT_DEVICE << 8, 0,
> -					buf, USB_DT_DEVICE_SIZE,
> -					USB_CTRL_GET_TIMEOUT);
> +		ret =3D usb_control_msg_recv(dev, 0, USB_REQ_GET_DESCRIPTOR,
> +					   USB_DIR_IN, USB_DT_DEVICE << 8, 0,
> +					   buf, USB_DT_DEVICE_SIZE,
> +					   USB_CTRL_GET_TIMEOUT, GFP_KERNEL);
>  		kfree(buf);
>  		break;
>  	case TEST_SINGLE_STEP_SET_FEATURE:
> @@ -100,11 +93,10 @@ static int ehset_probe(struct usb_interface *intf,
>  			break;
>  		}
>=20
> -		ret =3D usb_control_msg(hub_udev, usb_sndctrlpipe(hub_udev, 0),
> -					USB_REQ_SET_FEATURE, USB_RT_PORT,
> -					USB_PORT_FEAT_TEST,
> -					(6 << 8) | portnum,
> -					NULL, 0, 60 * 1000);
> +		ret =3D usb_control_msg_send(hub_udev, 0, USB_REQ_SET_FEATURE,
> +					   USB_RT_PORT, USB_PORT_FEAT_TEST,
> +					   (6 << 8) | portnum, NULL, 0,
> +					   60 * 1000, GFP_KERNEL);
>=20
>  		break;
>  	default:
> @@ -112,7 +104,7 @@ static int ehset_probe(struct usb_interface *intf,
>  			__func__, test_pid);
>  	}
>=20
> -	return (ret < 0) ? ret : 0;
> +	return ret;
>  }
>=20
>  static void ehset_disconnect(struct usb_interface *intf)
> --
> 2.25.1

