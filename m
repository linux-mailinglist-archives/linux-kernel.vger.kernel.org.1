Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16F1926EAC5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 03:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbgIRB6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 21:58:09 -0400
Received: from mail-eopbgr70043.outbound.protection.outlook.com ([40.107.7.43]:4065
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725886AbgIRB6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 21:58:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c745mIQl3cbUJFNr2stRu0asgbbKRWG1AxatDhxK28DRbeGMdIt0v5c3daVkIisY4htRw0DhhTVE7NxOnZHeVLL0PAdOcrucAka2gBIyZsTjROwN5k6HBHb0IhrxyIXMM0ajqL5lxb16Mcf6KEkZ8qSt7xxO6is8pvwd62QW0CK0l6B18aa5xSJ8I2NP87a4XnFbUC3knhJEK9yrMo1t9Vh55952WOX/q2zpqrAWkhTsq0uYpLFfol9+HD4Y9vjuHYOtocLJnEO3F/gxU99zCeH3Kx44hF26+IQB04mrns/dfXyl3A27fZ44SJIf7KXwwPN93/rTLAMVh/WoFOCnUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLmXi1/lfA5L/Rdi8rQkrqT7LJ/6QjOSi+jO7IsYxpc=;
 b=TxVs1lp1ESYEVcmKesR+VYPjLXNLp9G+6NBTcJqVV4hxu9rDi8h8WGni+u6ByjhCuNqmB27rczsfJBHPm4ves+4ItxZ7+KUUipLZ6PTSjhsVH1JJv+i/7i9/hQS5XduEKN02uuwD170Tm+YoqnK7BytKP5dK1BxgWKDlwgQJGfaDcIKmbBc7Uk0bLu/oRhtdJHV6wm8lIogFYjm9zR08l3kiy8GK42GVd/jQcxyP00lLXYAPxlHdLWbcPAm5SimfX7bs8YPZYVrIemru0q/bw6V7LeHfMR/pE6ypCh6cBOOUaGvHVY62tq0AGyMr394v5NgG7SZoUr7pT6WNpWhUow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLmXi1/lfA5L/Rdi8rQkrqT7LJ/6QjOSi+jO7IsYxpc=;
 b=eZz6bo5oji9J3KWfjT4kqW3Y36jLs77j21AqJnbdyTOKFsXCyjipKDPs2ZsCmc+BYOsy6CVv4eb0fSFLY7IB3fpio/KQZ8qnf8c0L8DuZ8vAPNxaC0wvDb8Cj88Yj9PCnB+R6UE/vA4s85UDbDbuIXeqnXBFs5syAappVWBF55w=
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20)
 by AM6PR0402MB3543.eurprd04.prod.outlook.com (2603:10a6:209:6::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.13; Fri, 18 Sep
 2020 01:58:04 +0000
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1023:be8d:40c:efe1]) by AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1023:be8d:40c:efe1%3]) with mapi id 15.20.3391.013; Fri, 18 Sep 2020
 01:58:03 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Pawel Laszczak <pawell@cadence.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "jpawar@cadence.com" <jpawar@cadence.com>,
        "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "sudhakar.panneerselvam@oracle.com" 
        <sudhakar.panneerselvam@oracle.com>,
        "gustavoars@kernel.org" <gustavoars@kernel.org>,
        "Thinh.Nguyen@synopsys.com" <Thinh.Nguyen@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kurahul@cadence.com" <kurahul@cadence.com>
Subject: RE: [PATCH] usb: gadget: config_ep_by_speed_and_alt instead
 config_ep_by_speed.
Thread-Topic: [PATCH] usb: gadget: config_ep_by_speed_and_alt instead
 config_ep_by_speed.
Thread-Index: AQHWjMtdf7F+AIzBpUKgYQ5VAttJaqltohZA
Date:   Fri, 18 Sep 2020 01:58:03 +0000
Message-ID: <AM7PR04MB7157A29711B6889583A190698B3F0@AM7PR04MB7157.eurprd04.prod.outlook.com>
References: <20200917075857.27803-1-pawell@cadence.com>
In-Reply-To: <20200917075857.27803-1-pawell@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: cadence.com; dkim=none (message not signed)
 header.d=none;cadence.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [180.164.158.209]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8a3cf258-e45c-4cc0-8810-08d85b7647ab
x-ms-traffictypediagnostic: AM6PR0402MB3543:
x-microsoft-antispam-prvs: <AM6PR0402MB354393B2DECCCD699BFB81A68B3F0@AM6PR0402MB3543.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vOFbroLHGnyhKTQ/3osci/y0uassDI7pBQJM1F4jDYqAVLe3p/OlFTo6CB4Nb60AOJJ0OWto7roxL8mamcTKEZsKHpnFhorg+xWi65mt0vd3dLfHzrWalk7WXquYj8w3sraPMcvVY7Km7MmEWZR+NgCcuf1t6HYFxWC6yTI24KBBvC/Uvw/sEp07TjNACbcvTwsn2WB4dhKpNnXtAeDejPBy3hFAl5v6OMrz6G3XIgqY8xS3WVbPzJEkdRMWmgnYpc2YCrdmLAeAxX2HBC8fBs55zaAUE3ZfnfIjSQVm+8MSFR6pT4cyt8FiUZb3EdqjnjSsbtVyr9hGV3AYj3wY/WZxHfk8PxkaOZff34tYvWSoeoE1JMOW5iDmfBg//8l1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7157.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(366004)(346002)(376002)(186003)(71200400001)(9686003)(4326008)(66476007)(55016002)(7696005)(66946007)(7416002)(478600001)(2906002)(66556008)(64756008)(76116006)(8936002)(316002)(26005)(66446008)(83380400001)(44832011)(54906003)(110136005)(86362001)(5660300002)(6506007)(33656002)(8676002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: +Zj0XDm/DQ4Jot3ueIT3jNNC2M4jGgcPKLxH9qhJF1ax4Nw7mTh1m2n1fuTA3hQPnyIZpK5WJUN802KrSG3h4L8U2GyOhMlvzA9ErRWSvfL50cP0eLS38ZeB3OVNgKysGP5Jdvd+zNdD48le72iOnumH3KozqoT7Ua4e5RjDbNnWU5D59269XTZ6+uJyDW8GYaZ/iJ2vcs9plUNIEoaYjJxSK5gRpNY1u4/FR8NnJXjYZf4GgeE0En205JZjr4zxBbIiZP41elJZBUhOPWfGtR+6Il1Y7JUNw7HOPMj6oPlfwzO49GlcN8pCtUoWbKJbHrVMf47FNo05VnqnlVlVXptEvAjW5FweBJ7gUvUWzPD8lc7Jq1XdE2PUiaWZ7rPhcHLoP4RVtDck5yf5sSsl2CKx5oMTcX/PUwH8mZPZsn/9GyOp0BQeE4prKdeQu/vdByWd5/+8BUjG/En42q8rtj5q1hpHgBieLx5Ya5jXxIHCbDXPRrR/boedWa/mgbF3gsqPLLD3PbRR0YX8KGbSJzk0aWVOAvxmwrNC11HHvQ6kCVj0L3hgq2k40tsZkenxyVW0qQDPC6rGOQs08uSoxnDVrFUV0tRIbjBE1BFQamW7tR3tH1Rx6pbhSEYfmU78sTNCsqhRpWTdqEo51O600Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7157.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a3cf258-e45c-4cc0-8810-08d85b7647ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2020 01:58:03.8094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DMj5HW2vckRsHJy/8EMLDIvTmFIZObHVTWLv/Ti344TNybIFleQy/UTDM3A3WOzuiMP6nOZh08Oj4WnOk6rbzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3543
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=20
> Subject: [PATCH] usb: gadget: config_ep_by_speed_and_alt instead
> config_ep_by_speed.
>=20

Typo, you may indicate use config_ep_by_speed_and_alt instead of config_ep_=
by_speed

> This patch replace config_ep_by_speed with config_ep_by_speed_and_alt.
> This change allows to select proper usb_ss_ep_comp_descriptor for each
> stream capable endpoints.
>=20
> f_tcm function for SS use array of headers for both  BOT/UAS alternate
> setting:
>=20

Delete space before "BOT/UAS"

> static struct usb_descriptor_header *uasp_ss_function_desc[] =3D {
>         (struct usb_descriptor_header *) &bot_intf_desc,
>         (struct usb_descriptor_header *) &uasp_ss_bi_desc,
>         (struct usb_descriptor_header *) &bot_bi_ep_comp_desc,
>         (struct usb_descriptor_header *) &uasp_ss_bo_desc,
>         (struct usb_descriptor_header *) &bot_bo_ep_comp_desc,
>=20
>         (struct usb_descriptor_header *) &uasp_intf_desc,
>         (struct usb_descriptor_header *) &uasp_ss_bi_desc,
>         (struct usb_descriptor_header *) &uasp_bi_ep_comp_desc,
>         (struct usb_descriptor_header *) &uasp_bi_pipe_desc,
>         (struct usb_descriptor_header *) &uasp_ss_bo_desc,
>         (struct usb_descriptor_header *) &uasp_bo_ep_comp_desc,
>         (struct usb_descriptor_header *) &uasp_bo_pipe_desc,
>         (struct usb_descriptor_header *) &uasp_ss_status_desc,
>         (struct usb_descriptor_header *) &uasp_status_in_ep_comp_desc,
>         (struct usb_descriptor_header *) &uasp_status_pipe_desc,
>         (struct usb_descriptor_header *) &uasp_ss_cmd_desc,
>         (struct usb_descriptor_header *) &uasp_cmd_comp_desc,
>         (struct usb_descriptor_header *) &uasp_cmd_pipe_desc,
>         NULL,
> };
>=20
> The first 5 descriptors are associated with BOT alternate setting, and ot=
hers
> are associated  with UAS.
>=20

delete space before "with UAS"

After fixing above typo, you could add my:

Reviewed-by: Peter Chen <peter.chen@nxp.com>

Peter

> During handling UAS alternate setting f_tcm driver invokes
> config_ep_by_speed and this function sets incorrect companion endpoint
> descriptor in usb_ep object.
>=20
> Instead setting ep->comp_desc to uasp_bi_ep_comp_desc function in this ca=
se
> set ep->comp_desc to bot_uasp_ss_bi_desc.
>=20
> And in result it uses the descriptor from BOT alternate setting instead U=
AS.
>=20
> Finally, it causes that controller driver during enabling endpoints detec=
t that
> just enabled endpoint for bot.
>=20
> Signed-off-by: Jayshri Pawar <jpawar@cadence.com>
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
>  drivers/usb/gadget/function/f_tcm.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/usb/gadget/function/f_tcm.c
> b/drivers/usb/gadget/function/f_tcm.c
> index 184165e27908..410fa89eae8f 100644
> --- a/drivers/usb/gadget/function/f_tcm.c
> +++ b/drivers/usb/gadget/function/f_tcm.c
> @@ -392,12 +392,12 @@ static void bot_set_alt(struct f_uas *fu)
>=20
>  	fu->flags =3D USBG_IS_BOT;
>=20
> -	config_ep_by_speed(gadget, f, fu->ep_in);
> +	config_ep_by_speed_and_alt(gadget, f, fu->ep_in, USB_G_ALT_INT_BBB);
>  	ret =3D usb_ep_enable(fu->ep_in);
>  	if (ret)
>  		goto err_b_in;
>=20
> -	config_ep_by_speed(gadget, f, fu->ep_out);
> +	config_ep_by_speed_and_alt(gadget, f, fu->ep_out,
> USB_G_ALT_INT_BBB);
>  	ret =3D usb_ep_enable(fu->ep_out);
>  	if (ret)
>  		goto err_b_out;
> @@ -852,21 +852,21 @@ static void uasp_set_alt(struct f_uas *fu)
>  	if (gadget->speed >=3D USB_SPEED_SUPER)
>  		fu->flags |=3D USBG_USE_STREAMS;
>=20
> -	config_ep_by_speed(gadget, f, fu->ep_in);
> +	config_ep_by_speed_and_alt(gadget, f, fu->ep_in, USB_G_ALT_INT_UAS);
>  	ret =3D usb_ep_enable(fu->ep_in);
>  	if (ret)
>  		goto err_b_in;
>=20
> -	config_ep_by_speed(gadget, f, fu->ep_out);
> +	config_ep_by_speed_and_alt(gadget, f, fu->ep_out,
> USB_G_ALT_INT_UAS);
>  	ret =3D usb_ep_enable(fu->ep_out);
>  	if (ret)
>  		goto err_b_out;
>=20
> -	config_ep_by_speed(gadget, f, fu->ep_cmd);
> +	config_ep_by_speed_and_alt(gadget, f, fu->ep_cmd,
> USB_G_ALT_INT_UAS);
>  	ret =3D usb_ep_enable(fu->ep_cmd);
>  	if (ret)
>  		goto err_cmd;
> -	config_ep_by_speed(gadget, f, fu->ep_status);
> +	config_ep_by_speed_and_alt(gadget, f, fu->ep_status,
> +USB_G_ALT_INT_UAS);
>  	ret =3D usb_ep_enable(fu->ep_status);
>  	if (ret)
>  		goto err_status;
> --
> 2.17.1

