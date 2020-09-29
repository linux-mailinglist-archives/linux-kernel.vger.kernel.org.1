Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDC627BC1F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 06:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725767AbgI2EgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 00:36:17 -0400
Received: from mail-eopbgr80080.outbound.protection.outlook.com ([40.107.8.80]:39529
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725306AbgI2EgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 00:36:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rp5hYd4v7pt70Wbr8Xiq5/GY0pLGF+zDez3u19M1v/jg2zj8vKWX7qMC4jmbuNMym7gpdfvW0EiPvZng5FNpLe7cry/Mqju1hQC/8W/gFYsu1U1yHA3mowyyDlKFgBqNy3ofAqdKa6fVXad1rmkwASHxcz4tEU5ENZKdmFWYsWcTMVTSZ7/IozJ/ylrEd2598EZoZqLNKfRKfMFHV6/wwNmbhQiHFjX+UO4WvLllNlnSMRhqI5QV6QuebMAQhgu7fz73ud5bd7whNwaNkp2hn5XkylEWQFXmLJMJKzgKZP/oyyQZQ5A/221tnURifpODjBy1drMDRQ3pG1G0xJLw1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EsLGuqV7U1FJNJq1DhhZJt5/ylQ0F2kI29EP99U8pNk=;
 b=aIBDWUsKbyf7jieIJJ+N5crXXy7QdnnG4sQtcMJY/A9wnG8bra9KaEfXDhLItLzI7Cg6WvEsHKE2OFtn9qBND3Am/H2m260JrljwESpS2JPb0nRPvXj3gDH1ufcNuKqlT3B+sSICA8VgIO4a90RXR/1B7m2cFNDaobMTEkF6Fo54byGiuPVQGjb/ZDNrD6sNhZjfIUOmT3H5H/+ufLMYt3X6Z8noOx56Fxd2audo3MQPuLkchpjQaEuSfpd0lk8zbo8BALBOP4ci0hxt5C+vIlX38wJ6n98hTZGRS4uhWSq7ZeUIGqoV6+TAQ8h0T6uXR73I1cc3XrnOIvvwdNo4TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EsLGuqV7U1FJNJq1DhhZJt5/ylQ0F2kI29EP99U8pNk=;
 b=MHzyqIypd7buXorXCb1d+VGlIyYRitWLTBA00ZB8h7gWJpJxm853H/UlBuYMQE/5sxbJ9ER1oG3uAq+dErJj5Q1F6RNwqpV76HZrMbmUtZnefxh3mTB4H9sGJeboXuSK01BSyPtPg/MO2OWJkr4DGZ+D/jk4L5aQ6TBncyzkjXE=
Received: from AM8PR04MB7300.eurprd04.prod.outlook.com (2603:10a6:20b:1c7::12)
 by AM0PR04MB5443.eurprd04.prod.outlook.com (2603:10a6:208:119::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.25; Tue, 29 Sep
 2020 04:36:12 +0000
Received: from AM8PR04MB7300.eurprd04.prod.outlook.com
 ([fe80::ad01:9b1c:3b4b:3a77]) by AM8PR04MB7300.eurprd04.prod.outlook.com
 ([fe80::ad01:9b1c:3b4b:3a77%7]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 04:36:12 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Pawel Laszczak <pawell@cadence.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "jpawar@cadence.com" <jpawar@cadence.com>,
        "kurahul@cadence.com" <kurahul@cadence.com>,
        "sparmar@cadence.com" <sparmar@cadence.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "chunfeng.yun@mediatek.com" <chunfeng.yun@mediatek.com>,
        "yanaijie@huawei.com" <yanaijie@huawei.com>
Subject: Re: [PATCH 5/8] usb: cdns3: Changed type of gadget_dev in cdns
 structure
Thread-Topic: [PATCH 5/8] usb: cdns3: Changed type of gadget_dev in cdns
 structure
Thread-Index: AQHWlZOfv2py0oF9mkmHy9/gJKGhyql/CKoA
Date:   Tue, 29 Sep 2020 04:36:12 +0000
Message-ID: <20200929043508.GC9076@b29397-desktop>
References: <20200928122741.17884-1-pawell@cadence.com>
 <20200928122741.17884-6-pawell@cadence.com>
In-Reply-To: <20200928122741.17884-6-pawell@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: cadence.com; dkim=none (message not signed)
 header.d=none;cadence.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: db64688f-1d5b-41da-e743-08d8643131ee
x-ms-traffictypediagnostic: AM0PR04MB5443:
x-microsoft-antispam-prvs: <AM0PR04MB5443D2719F6B1C3469E4DEBA8B320@AM0PR04MB5443.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z5W1dzTkWuKxzW+3GYtQ82O7Fj6SKJkdZdV5izu2Iui2/0u6a9ROugJ78Z62Y+GNrFk2/wxNHYlq9P8sVxRUmR2LtCujgOt92JA2D5c+83zB4Es2TQ/24eepMudOfzaAH1fIFNqindWSmqNEQOKJV9gthacogROEskChnRvzlzXVgfle4VRz/klSLuOryi+rHZbasoWMM+Doux4p71aqfY9P3+M/aH0x2SmDEWIJS0zzHxBgcp0x1une9MVqlJHTqbytZmifHDeaJpLT93DQMCD3PXkGejo9ct52cLeaopTz6rcKUfP0G7+SMmOef2CAHmtVSbO83M7eOAbXX4xdvMi5p9GTwMLHahWbyljwAzikhbSmICYVGD+gZxXsoV8Z
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7300.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(39860400002)(366004)(396003)(136003)(346002)(376002)(83380400001)(54906003)(71200400001)(33716001)(7416002)(9686003)(6512007)(8936002)(2906002)(5660300002)(66476007)(66556008)(6486002)(66446008)(64756008)(6916009)(53546011)(26005)(76116006)(66946007)(91956017)(186003)(6506007)(316002)(8676002)(33656002)(478600001)(1076003)(86362001)(44832011)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: AA8nYS5QDt6/3jvTzxapCF9w/EXLLO+onRrc0bc0jpMDqEHyqd9F54BLl7LIpPZvb62Dph81gt736C9fSoE+WjdEkfEL++/dye4g5a33WnE2JF8OcpDm7WfFeJkSX3HPcieQtrooVpgDskh0eISPQEEDs9kT5p5PdCTbt0plPVAg8BdTht0beEFZJAy7HTFvVJmWUQd+61Zjvrhs0nMbXiT5J5wTbezc14iJ8jqP/dbehZdXpEXXGyN2IiB6Jbbd6I+mgHcYB1nQfo7fY4hx91irMMHaiQ13hCLuU45Xn8P5a5MQ47PWd1zyIA17tIl3erVGspjJKvtR33X5q3oXdrbbg4F5Yl1CJyBpsIpbrNpCvOORYVtsMGOz2a0v5UP567XObTwhbPm27pLvqDujJyMiTzrNs6XYPf3tdF94ABANBchQAuugfGxKiEUHiazZoZNgRDjBSkzKpxG1NKQuufZtw2UNMN0Bb6/z1tTSYAAb2VYZtzFRtlaOxmEw8C55boERFdvXxcx73fmtMdqmM+Cx7E+CgR1YfYlvNdWuLJo0Nb4R0BlZxX8IksHRjEF3DMwdndgNPXZsO1XwAwNOe2glmaZ6beEYwxXdqUpQ8Cyq/KfTFy307iJlg8FgA1Rkfvz7jFGqF89kBYH/kh+IPg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <388014B0FD69F847BA54C946059BAAAD@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7300.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db64688f-1d5b-41da-e743-08d8643131ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2020 04:36:12.5466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dfwEn560Wd3mHFMAu5HpZeuGa/o6muIYtlxf+U45+QByEkT+BSeZ8dqLkOxdBV9OjVABI26qmYdcBB32/zw6EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5443
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-09-28 14:27:38, Pawel Laszczak wrote:
> Patch changes the type for gadget_dev pointer in cdns structure from
> pointer to cdns3_device structure to void pointer.
> This filed is in reusable code and after this change it will be used to
> point to both cdns3_device or cdnsp_device objects.
>=20
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
>  drivers/usb/cdns3/core.h   | 4 ++--
>  drivers/usb/cdns3/gadget.c | 6 ++++++
>  2 files changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
> index 0c6e14683b36..267923904a37 100644
> --- a/drivers/usb/cdns3/core.h
> +++ b/drivers/usb/cdns3/core.h
> @@ -55,7 +55,7 @@ struct cdns_role_driver {
>   * @roles: array of supported roles for this controller
>   * @role: current role
>   * @host_dev: the child host device pointer for cdns core
> - * @gadget_dev: the child gadget device pointer for cdns3 core
> + * @gadget_dev: the child gadget device pointer
>   * @usb2_phy: pointer to USB2 PHY
>   * @usb3_phy: pointer to USB3 PHY
>   * @mutex: the mutex for concurrent code at driver
> @@ -87,7 +87,7 @@ struct cdns {
>  	struct cdns_role_driver	*roles[USB_ROLE_DEVICE + 1];
>  	enum usb_role			role;
>  	struct platform_device		*host_dev;
> -	struct cdns3_device		*gadget_dev;
> +	void				*gadget_dev;
>  	struct phy			*usb2_phy;
>  	struct phy			*usb3_phy;
>  	/* mutext used in workqueue*/
> diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
> index 26f68182e65e..f9cbc84bbfb8 100644
> --- a/drivers/usb/cdns3/gadget.c
> +++ b/drivers/usb/cdns3/gadget.c
> @@ -3177,7 +3177,9 @@ static int __cdns3_gadget_init(struct cdns *cdns)
>  static int cdns3_gadget_suspend(struct cdns *cdns, bool do_wakeup)
>  {
>  	struct cdns3_device *priv_dev =3D cdns->gadget_dev;
> +	unsigned long flags;
> =20
> +	spin_lock_irqsave(&priv_dev->lock, flags);

unrelated changes?

>  	cdns3_disconnect_gadget(priv_dev);
> =20
>  	priv_dev->gadget.speed =3D USB_SPEED_UNKNOWN;
> @@ -3186,6 +3188,7 @@ static int cdns3_gadget_suspend(struct cdns *cdns, =
bool do_wakeup)
> =20
>  	/* disable interrupt for device */
>  	writel(0, &priv_dev->regs->usb_ien);
> +	spin_unlock_irqrestore(&priv_dev->lock, flags);
> =20
>  	return 0;
>  }
> @@ -3193,11 +3196,14 @@ static int cdns3_gadget_suspend(struct cdns *cdns=
, bool do_wakeup)
>  static int cdns3_gadget_resume(struct cdns *cdns, bool hibernated)
>  {
>  	struct cdns3_device *priv_dev =3D cdns->gadget_dev;
> +	unsigned long flags;
> =20
>  	if (!priv_dev->gadget_driver)
>  		return 0;
> =20
> +	spin_lock_irqsave(&priv_dev->lock, flags);

ditto

>  	cdns3_gadget_config(priv_dev);
> +	spin_unlock_irqrestore(&priv_dev->lock, flags);
> =20
>  	return 0;
>  }
> --=20
> 2.17.1
>=20

--=20

Thanks,
Peter Chen=
