Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9682AD204
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 10:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731612AbgKJJFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 04:05:47 -0500
Received: from mail-am6eur05on2046.outbound.protection.outlook.com ([40.107.22.46]:4649
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729918AbgKJJEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 04:04:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SmwARdSlB7hn7QAOG3dP7eHdd40JjfMj3Xa+AUkj86lF/i6c2sUVx/u+9kzLu98Qsmp9B+WdMdFWiLhTspr/OGMS9cie/hmuD/591TzbgsFxkSgrc8IsL5z9TpHhJiGJW9UEQB6uPHNayNT/XpgdFIPcJsd+djBv8b+jiR1UDQrnyaClKh6N8Vncm3Woh1fQjiGtLu93F85SRRrpFf+pyulZPQ6rp8LZ5PKTHss59g/bxG6hQBY+vD7H7StWNXi67IJ4meoGR7PF8MqDy/wp4k54hk6pST/7PbGsjJkump3FBdSdYHGNhLvbKlDQFhv8lgLRaPu7rJV18d/bkwPTaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDjsk7u013MgF83LT+Pset/+wwVxUPALm3raY4fbwqM=;
 b=YC2tbgqB0oRQTyBJaLaXAHIXZWuXgjFVIxPHuoXWo9ywoYZ3HnBy5sSzy8otH3YWqCsFWSGXSrEd4CqxrcnczGNHLvLKkQBa9EFhmDQGp8sktLuycnUmyts9QS/gjAYnZViuDf0bfpztWlgu7JXEGv3zCkMkCrrJLPQfPCIe2/s8hd6bLyIEZumYsqy+R/kO/tosIGdRm7VJulZx0v6WX+Yp3wWN4K0+ndp8Z1HOCm3jGL/C+3ialTBQEh7dzqj6biMWpk9Sb9XiBw9x9mrjevlc0NcCNvlbDAj2whh42WXn+EXp90/yaNnWzjgY3AwYsXwe4KzNZJGH8JC3iEnRYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDjsk7u013MgF83LT+Pset/+wwVxUPALm3raY4fbwqM=;
 b=qNZMieX9N5rGGxyKw8UKfQas8tnOn+3SLozzfhgrmKglmFqMeJ+zjLKc90BIRb+eYEJ37rqt/Ukox8pbq+CCFic/ZpWtTOtr4IzgvHNWpTC0C36+Pwxv10ESo+Uzp/H983GCsl5/FokwwpmXgchJwjydrqDfwQYNbrtvJWlAYRs=
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com (2603:10a6:10:1ec::9)
 by DB7PR04MB4492.eurprd04.prod.outlook.com (2603:10a6:5:39::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Tue, 10 Nov
 2020 09:04:29 +0000
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::c8c:888f:3e0c:8d5c]) by DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::c8c:888f:3e0c:8d5c%5]) with mapi id 15.20.3541.025; Tue, 10 Nov 2020
 09:04:29 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Pawel Laszczak <pawell@cadence.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "kurahul@cadence.com" <kurahul@cadence.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>
Subject: Re: [PATCH v2 01/10] usb: cdns3: Add support for DRD CDNSP
Thread-Topic: [PATCH v2 01/10] usb: cdns3: Add support for DRD CDNSP
Thread-Index: AQHWtDJHpjDqwoW9QUS5Pv6rgaf5tanBGHYA
Date:   Tue, 10 Nov 2020 09:04:28 +0000
Message-ID: <20201110090400.GA22481@b29397-desktop>
References: <20201106114300.1245-1-pawell@cadence.com>
 <20201106114300.1245-2-pawell@cadence.com>
In-Reply-To: <20201106114300.1245-2-pawell@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: cadence.com; dkim=none (message not signed)
 header.d=none;cadence.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2636498c-c62d-4c8a-6872-08d88557a193
x-ms-traffictypediagnostic: DB7PR04MB4492:
x-microsoft-antispam-prvs: <DB7PR04MB4492CD1918859E02315DDA7C8BE90@DB7PR04MB4492.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UipsO8qFb6BUh5BxI+huPoEsSt28lgrS5dyLGzcxllUM2Y5gTQuu/7iam5S7ZXcEjxwrX2917MiKKxZDLrtuo+HnocE10Y9Es1KyfmTXCyOCvmsZskmv/8BvOo6rqfIh6u/5RuX48SDyhyNcgrjhLQkIZDK2zcCHlJPRmvlKl7BMJBsL4pKJUeqdv+SWPeB0VCqBMGC22uyNsL5VGmVuskrkZp6ff7bsKHGhe3wTyVzBhhGXsJJC+UAeNYsQCAyO3US+k+BdmCEmfk0iWZuIw7Iep41l93c1j2zA8pk5c3qs+LOXIPZp8CB5+gDOvV2e
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7979.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(376002)(39860400002)(366004)(396003)(346002)(136003)(2906002)(54906003)(33716001)(316002)(53546011)(6506007)(6512007)(9686003)(4326008)(8676002)(26005)(8936002)(86362001)(478600001)(5660300002)(66446008)(33656002)(1076003)(66556008)(66476007)(71200400001)(64756008)(6916009)(76116006)(6486002)(91956017)(186003)(66946007)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 0uJ22zCHQ782qYbP1F5W6tKU/laOCfUgpNnVeocbwiNBwxaCBygBldmRLjILsIayODUXE5RzhodT6FQdO5PNstpwp2RwAonIe6qfOQbh1o7Qp2nk7ZwDuznVFnT72c08QWUPNiwLlUyFDhYL+/bO40uoGyUwE7aeJlKdIpHXuGNstu+nWXxo/2TULbbDCzclJ4+ZAMyKSX4uWs2gK9Vm3/LrMVSiVT8/Qg0Vn2C8TNpMXMalWsYrkiaNDqkGHX+xZLw7pMlUP7OGXlMovr/ZiDbuiujAHqgqOTiUwO6VE7ggnQnXyLerE47DfTOjPfBpXF3DzOfRPcD1NY1x2k8sMdtD0JPBY61mW0T8lq3JRI93rNe8vJoTygTMFTS92J+JcuuzTlYoI/vUCn3AGrHIhKiCmdkT7n1ljIw7SP7xiY00wubuCwqiQSotPquZkZ/USuAy/VjyklAEtHyzTPDX2uCzAnE8gsAM1vtHb5QURkEqt6Oos/VetdOLc5WCkyuww1yT+hMt5d/sGxALtusUMg3DY7qewH1qqK3BFHHkv/vbV2KtCxVfJdeBk8OGBl1lHbZDwm3l13VhxMeAZpV3MUBuUhGQuHUaQpHw+5KnS1+eE0Tr93TUaiLfp6JTRQBLw94s/xqhne93s0TTegg+BA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E42618A9350679448030016D2FFDF815@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7979.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2636498c-c62d-4c8a-6872-08d88557a193
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2020 09:04:29.0205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fOBcWH04GTJs6qstun9tpEfvEQMngWHScQv7NaIapjCLNsoxWReESunCf1RZQuY32C8069nsGcswAgg36xZh4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4492
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-11-06 12:42:51, Pawel Laszczak wrote:
> - * Value of the strap pins.
> + * Value of the strap pins for:
> + * CDN3:

%/CDN3/CDNS3

Peter
>   * 000 - no default configuration
>   * 010 - Controller initiall configured as Host
>   * 100 - Controller initially configured as Device
> + * CDNSP:
> + * 000 - No default configuration.
> + * 010 - Controller initiall configured as Host.
> + * 100 - Controller initially configured as Device.
>   */
>  #define OTGSTS_STRAP(p)			(((p) & GENMASK(14, 12)) >> 12)
>  #define OTGSTS_STRAP_NO_DEFAULT_CFG	0x00
>  #define OTGSTS_STRAP_HOST_OTG		0x01
>  #define OTGSTS_STRAP_HOST		0x02
>  #define OTGSTS_STRAP_GADGET		0x04
> +#define OTGSTS_CDNSP_STRAP_HOST		0x01
> +#define OTGSTS_CDNSP_STRAP_GADGET	0x02
> +
>  /* Host mode is turned on. */
> -#define OTGSTS_XHCI_READY		BIT(26)
> +#define OTGSTS_CDNS3_XHCI_READY		BIT(26)
> +#define OTGSTS_CDNSP_XHCI_READY		BIT(27)
> +
>  /* "Device mode is turned on .*/
> -#define OTGSTS_DEV_READY		BIT(27)
> +#define OTGSTS_CDNS3_DEV_READY		BIT(27)
> +#define OTGSTS_CDNSP_DEV_READY		BIT(26)
> =20
>  /* OTGSTATE- bitmasks */
>  #define OTGSTATE_DEV_STATE_MASK		GENMASK(2, 0)
> @@ -152,6 +194,8 @@ struct cdns3_otg_common_regs {
>  #define OVERRIDE_IDPULLUP		BIT(0)
>  /* Only for CDNS3_CONTROLLER_V0 version */
>  #define OVERRIDE_IDPULLUP_V0		BIT(24)
> +/* Vbusvalid/Sesvalid override select. */
> +#define OVERRIDE_SESS_VLD_SEL		BIT(10)
> =20
>  /* PHYRST_CFG - bitmasks */
>  #define PHYRST_CFG_PHYRST_A_ENABLE     BIT(0)
> @@ -170,6 +214,5 @@ int cdns3_drd_gadget_on(struct cdns3 *cdns);
>  void cdns3_drd_gadget_off(struct cdns3 *cdns);
>  int cdns3_drd_host_on(struct cdns3 *cdns);
>  void cdns3_drd_host_off(struct cdns3 *cdns);
> -int cdns3_set_mode(struct cdns3 *cdns, enum usb_dr_mode mode);
> =20
>  #endif /* __LINUX_CDNS3_DRD */
> --=20
> 2.17.1
>=20

--=20

Thanks,
Peter Chen=
