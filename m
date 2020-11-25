Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53FE92C3967
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 07:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgKYG6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 01:58:52 -0500
Received: from mail-eopbgr70055.outbound.protection.outlook.com ([40.107.7.55]:19955
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726810AbgKYG6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 01:58:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QM02kHF0BlRfVCUKUWXTMmVIoNLHLkiPDTnAo3LPxF3emqk7uJ8C6jFXvROy9j6HFnkZ/YDBxrmzc873w9JranjvOQN8Ngy30wKPsXcTSi7aRb+yN8Awl4HgNV58h0zNT9rANeIMgHpuHwq5WzU4zojkHXhOb5+qnZDlzBA51vN6K9uOnWiT/VQqTc8Ui7RdCgNEGzCXy7dWQm1Us53xykXDuZUjwORPAqzhOZs0QO4xxPcNYg7Hg7PQNod1Z2WphXUAusIjOz4yjuqbGntlFVMWUEA9PJ1AahidrvmCBHqikBD3w2T2qyLzS+N25Xyf3l503ADnjaVp6SFPQW11jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WgPSuw5DFrd0bmpaXNrFfUEVpPCf0EzAS5zypmXjK/g=;
 b=iDt08gOigneN0lOVXUWIcMY0UMRKPvD+i/eKIEV7mn8pUFJF5T96EtYsvXjvw/jqwm4upFQNtr/Gs8rPfuoa7Sd602TBhefDnkEdkN7K3r9NIjDWj5tXv25NQl+Fz4nLVjGNsuJq+43nvdnpYeqSJiyJN4nWAF7Z4xGlsY2q0/MEnsd+WguPBUxpI/GGnSHFX9+0bXq/4Sc4BBA1OpFm1AQ38U5BpUWCWDj4fyfb+S6q0haGxfNbMkV5A7rLRX6wrKIsJcc4/tZhdu4OjZnWl/4T+DIVwOKenBIXtafrauvxC4gxolnnp0pAryuJeCFBNbtt+R7Qv5e6JYS20pk2dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WgPSuw5DFrd0bmpaXNrFfUEVpPCf0EzAS5zypmXjK/g=;
 b=Xy76I2kD5ojb97/ocyQ4QpSfTpbfOWCl6UZPzoLahrzAISfZ24s1A5lbbjxYJNC1cwzOdcVM8qvPB2Zvb3wHUBz7LK8YWh3GPeKOLHXwmsFAPIIbkb5jnkdNC2gBtSpkn78ozc7MizuE2f/EL5TukNXw5sH0Ak3Y0uFr5mxRqW4=
Received: from VI1PR0402MB3871.eurprd04.prod.outlook.com
 (2603:10a6:803:16::14) by VI1PR04MB5887.eurprd04.prod.outlook.com
 (2603:10a6:803:e8::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.28; Wed, 25 Nov
 2020 06:58:48 +0000
Received: from VI1PR0402MB3871.eurprd04.prod.outlook.com
 ([fe80::607d:cbc4:9191:b324]) by VI1PR0402MB3871.eurprd04.prod.outlook.com
 ([fe80::607d:cbc4:9191:b324%5]) with mapi id 15.20.3589.028; Wed, 25 Nov 2020
 06:58:48 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Diana Madalina Craciun <diana.craciun@nxp.com>,
        Cristian Sovaiala <cristian.sovaiala@freescale.com>
Subject: Re: [PATCH] bus: fsl-mc: added missing fields to
 dprc_rsp_get_obj_region structure
Thread-Topic: [PATCH] bus: fsl-mc: added missing fields to
 dprc_rsp_get_obj_region structure
Thread-Index: AQHWwlKrhkkTQ0CtQEmepYUhDibtPanYbDKA
Date:   Wed, 25 Nov 2020 06:58:48 +0000
Message-ID: <20201125065847.xrirmlmctpx2yrns@skbuf>
References: <20201124111200.1391-1-laurentiu.tudor@nxp.com>
In-Reply-To: <20201124111200.1391-1-laurentiu.tudor@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [188.25.2.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1fe9a481-6c7c-4d93-a9f0-08d8910f8f25
x-ms-traffictypediagnostic: VI1PR04MB5887:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB5887AFF62EEE74AE891F350BE0FA0@VI1PR04MB5887.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wh5f4CLqEnnJNe2XebiX3KU2YyEl3NrYcJmx8RUNrSPMIgg7iyVuYhXZY+3sjbCB0cqAMyrYp1ACuESwhCfM/DmqaQwOo2CNus89XiaXe1YklHU8PG9yUFvTMIT41dglb9RxqIrvX9r2nn0T6scAz1RzR0NB0KOcbAwT2dOccvYKRWyGJCUQCleHyIFdxi4MrVqY7VpkF0LjELsB3dTlphJcMSwssgRIQw7h6dJU5qvYM7o2N+XQP2gu+E+sHQIYo8whA3JYF7p3eg2qtqZ7Y1Ed7yrLOa7DHnfxiTkTUdYbLTg9WCX+4stw5zFrLnCJEeTzWAZyfqWss92Ckm55ww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3871.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(346002)(366004)(376002)(136003)(39860400002)(396003)(83380400001)(478600001)(86362001)(6506007)(66446008)(76116006)(6862004)(64756008)(8676002)(44832011)(54906003)(107886003)(33716001)(2906002)(5660300002)(6512007)(6636002)(66946007)(1076003)(186003)(71200400001)(316002)(8936002)(66556008)(9686003)(6486002)(26005)(66476007)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?RNlDHOyfUKSiP/2b/uc3gpQoZt2PTK8IwtmtnH/24KnEJ348nLSsLh5jAf/g?=
 =?us-ascii?Q?2Qof16PqYuSeV3eEJZwuHmaL/gFpQiDgQ2N85huTPgkJ5bWf26Q0zeRaSPgD?=
 =?us-ascii?Q?OeIse++SNH1AMWbAt0TFSlIkKcGLJNZ6yI9Kq0NF6I+Fkxl9r1C8OVf6vTSn?=
 =?us-ascii?Q?HjTNc47fmrdxO9S5T9lHYpBmXOSpl68KPU7FAM8e7wrqoi+x57+Innitw46j?=
 =?us-ascii?Q?YfYMfo1Avmp020g4cJNM3JvT8wLvI/ka4wEcyyR4W55ecBaC2New+F87rdq8?=
 =?us-ascii?Q?Ln2kx86VhV3uiRVMZ9jV0nI1hYLsPVJ2vBOrDGREwlWbTfQoujrH0LwiPetP?=
 =?us-ascii?Q?j667P30eWNPvCjUrrImpoVS3FCezgKQ0/Ws5Uyl3zw9hxZSPrg3PE+uPAbv7?=
 =?us-ascii?Q?qcvW+/FZ1Ec4RFbpPb3h/E7x+nMJsq+WturnCotGde0zpAvkFFNdSaK1NKU5?=
 =?us-ascii?Q?85g3xnM5rXdiG6JQFEw9pO32GEuaupxLEpKYhpJ1x82ET2ET6jnWAvEtb+xn?=
 =?us-ascii?Q?P8JsLh6eUnxuIGFSi/CAGu4SKDnsszh0XxH9+wxCWAvsCYgHw9gIdOFGflb4?=
 =?us-ascii?Q?xzXhZOU4fsJV921xCO7TgxQ0b2xinB2UCPJUY/kq9BWONewK4pfyCk0y1SK/?=
 =?us-ascii?Q?PL/OwdXoS7BnSwChl4lpGpok+bQH732uClLc2vs/bVqcyHSSyJXBv94L8Nw5?=
 =?us-ascii?Q?Jo6uIbrDkTEF+WbfZhLBUDoyE3Lc8nNuSIDYWr1Ff1KG3ZBv4ur5TIqL9vej?=
 =?us-ascii?Q?jyM2bog7n9QZRkXJszNhB/8MR/tfLJOzByqRPl+Cz8eoXruZ4DJ2PYANtIUL?=
 =?us-ascii?Q?wn4GiXhGldT+Pss+IOIHd83JYAjhOzv7zikqun4jObbWBdBQuxdoynHNYHGi?=
 =?us-ascii?Q?sRVrwn7B6eviYisslTq9CERziTeplaIlsbwv0sEyMygLWm12uiwYtQv9lbtc?=
 =?us-ascii?Q?w4/BbHbTORY5Ws7/i/gA/ekZyrAm6jKz3bK6+Ba36d3GhGcqfrQkDIiXwHPb?=
 =?us-ascii?Q?GKoV?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8D233EE265FD1B43A79A318AF40FDD7C@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3871.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fe9a481-6c7c-4d93-a9f0-08d8910f8f25
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2020 06:58:48.4122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sPvBCHN0690vHNMgi/wPMtXSY56UQC48AQjvBm9MA/kLMm2IccF3HzrtpW696O5eYmj8bR/EoRpJhW3XABpvyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5887
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 01:12:00PM +0200, laurentiu.tudor@nxp.com wrote:
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>=20
> 'type' and 'flags' fields were missing from dprc_rsp_get_obj_region
> structure therefore the MC Bus driver was not receiving proper flags
> from MC like DPRC_REGION_CACHEABLE.
>=20
> Signed-off-by: Cristian Sovaiala <cristian.sovaiala@freescale.com>
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>

> ---
>  drivers/bus/fsl-mc/dprc.c           | 2 ++
>  drivers/bus/fsl-mc/fsl-mc-private.h | 5 +++--
>  2 files changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/bus/fsl-mc/dprc.c b/drivers/bus/fsl-mc/dprc.c
> index 57b097caf255..27b0a01bad9b 100644
> --- a/drivers/bus/fsl-mc/dprc.c
> +++ b/drivers/bus/fsl-mc/dprc.c
> @@ -576,6 +576,8 @@ int dprc_get_obj_region(struct fsl_mc_io *mc_io,
>  	rsp_params =3D (struct dprc_rsp_get_obj_region *)cmd.params;
>  	region_desc->base_offset =3D le64_to_cpu(rsp_params->base_offset);
>  	region_desc->size =3D le32_to_cpu(rsp_params->size);
> +	region_desc->type =3D rsp_params->type;
> +	region_desc->flags =3D le32_to_cpu(rsp_params->flags);
>  	if (dprc_major_ver > 6 || (dprc_major_ver =3D=3D 6 && dprc_minor_ver >=
=3D 3))
>  		region_desc->base_address =3D le64_to_cpu(rsp_params->base_addr);
>  	else
> diff --git a/drivers/bus/fsl-mc/fsl-mc-private.h b/drivers/bus/fsl-mc/fsl=
-mc-private.h
> index 85ca5fdee581..c932387641fa 100644
> --- a/drivers/bus/fsl-mc/fsl-mc-private.h
> +++ b/drivers/bus/fsl-mc/fsl-mc-private.h
> @@ -211,12 +211,13 @@ struct dprc_cmd_get_obj_region {
> =20
>  struct dprc_rsp_get_obj_region {
>  	/* response word 0 */
> -	__le64 pad;
> +	__le64 pad0;
>  	/* response word 1 */
>  	__le64 base_offset;
>  	/* response word 2 */
>  	__le32 size;
> -	__le32 pad2;
> +	u8 type;
> +	u8 pad2[3];
>  	/* response word 3 */
>  	__le32 flags;
>  	__le32 pad3;
> --=20
> 2.17.1
> =
