Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C202269C2C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 04:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgIOCzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 22:55:15 -0400
Received: from mail-eopbgr70082.outbound.protection.outlook.com ([40.107.7.82]:9875
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726057AbgIOCzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 22:55:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kvAJrcQPqiLEaOpeFpSlstfP3NoA8ovEiZqCtJYD1zka5fTzPaq/DoKbTQcQ4/ZqmQiVoJfjUTWG/YigxEyOFErExfOeiZj+6oIQo2PxwjZmlLNNmhccBKXe9NpqleJSe1VOVhHS4uc9WTNDvnaQPZ9I9unDqBgRqlbbNHUCX2gzHin8RkHk0TlYhA0zpVzjQVhrTgG/kctAh634bQIgdRsjOekTLaymucF+G7itojb46FPONbNcpi9AYtKx8aaIaSwlNb70PG3bBQikRSJAOIMM3PS8wbLX44VcV4fhjQtYNwah/ayhufWzUkVp9TpWkI0+gvHDuemAYUJ7IpPEGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejfxRPkrfCMErYZtnCeurYmckBPzHU/cZ1Dh+B+bZDM=;
 b=jM6UrOExzEL68C9DPOUytV/Qd4SFv0WM74u65EXgB/qYUhIooXQQyuaZ9f8aejf/xYhMF256mERkRIu9ceVmjgWVqiCQ3SrTaoFW/QJIwqEhdMLMyyVYsUIK+MmZ92Bk3CNqb6symDod05qZDwqQJQKgTReD5RNeYC0b33nnRNzDWwM2waYwf5SfgFTQnX/LVhojiNvOIMHNYdiOiiyn3+1Y6tiAAn1m7hvBXZv7ohdHgqiMkTXL5g4exunk8u020TwvKgnd5mmlAtjec3mFlj1Df1+FJURosjy/QyELKID7rchM5NK8VeaVgr4/I4W0Wfxkjw9cA+nLhwdZV03diQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejfxRPkrfCMErYZtnCeurYmckBPzHU/cZ1Dh+B+bZDM=;
 b=LUBv0/ZcpCm9G+ObRtJ7YZHYqIC8r1VA/0/zJ9Oi880j+6FUt+L2OftgS69keaEY3eoKXPtOzJZakivQ+SooyOsfnb8IzzjbbSQVK5uaxdItzRCpdZcuhHG5hrVLbJcxNTmSkPe0Xg0CYPQU2g+45PX/BfQuIg8vaC6tC3IIwK4=
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20)
 by AM6PR04MB5176.eurprd04.prod.outlook.com (2603:10a6:20b:6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Tue, 15 Sep
 2020 02:55:06 +0000
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1023:be8d:40c:efe1]) by AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1023:be8d:40c:efe1%3]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 02:55:06 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Matthias Kaehlcke <mka@chromium.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH 2/2] USB: misc: Add onboard_usb_hub driver
Thread-Topic: [PATCH 2/2] USB: misc: Add onboard_usb_hub driver
Thread-Index: AQHWisa8s1Sayn6UyUeJIx1ZNmduw6lpAX4A
Date:   Tue, 15 Sep 2020 02:55:06 +0000
Message-ID: <20200915025426.GA17450@b29397-desktop>
References: <20200914112716.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
 <20200914112716.2.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
In-Reply-To: <20200914112716.2.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1e4ba19f-b2ed-4ba2-ae0a-08d85922c09c
x-ms-traffictypediagnostic: AM6PR04MB5176:
x-microsoft-antispam-prvs: <AM6PR04MB51765E096C377FFCC92922728B200@AM6PR04MB5176.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xJUyS3Yc8N6RYtEnNjHScmR7lTqcdy71S97er/VCvVKcfSu2NWSwpIwdH45CV3mcATG5FLNP0Ss4koZAedSHB4EqYnvyWAWIIkO/L7luFO15jIauR1AgyAvGdxspssTbzPGf/wFhwBZ1IToWuz9vDgElA4GX80pXoAJaIbXWjfWSi7EFodN0VNrl3cnijpb48KVIgcbW6p1mzQEmFopk1Evb5QCZaEQpUzwlz09AtdY1FPSuo2wu/FNcWaNC4BXETTwUcQx40ftTP4qcgNHdqD/Ex7H8GpOAnmfhgrcmOhoHDmr2bOI+XmkAcab/JHj8MH02qc6I/4oxOuA7ndCViw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7157.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(136003)(396003)(366004)(346002)(376002)(39860400002)(6486002)(316002)(66446008)(91956017)(76116006)(66946007)(66476007)(66556008)(64756008)(53546011)(71200400001)(6916009)(5660300002)(6506007)(6512007)(9686003)(26005)(186003)(2906002)(7416002)(8676002)(1076003)(478600001)(8936002)(44832011)(33656002)(33716001)(83380400001)(86362001)(54906003)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: JQf7qxdYPE1BEVdK3aQKQPAycekxUbkEsTj5Tj6zRjbWFY1hLk+ddlqS1GCtmQD61xq+1zF5O+uFvHHwJ1RrplWHnpj8+3sIjAUHglyQtbtL4R3guPd2fPkM5mxKHGfAYJHzRJkkOGS81E1JWx1dm/MzULVUymkCqm4fGntAJTUyHQZp+TupMrppjMfYrXiRLD/sVWBu9Cq2Mw1UXYYXxlLvPLbwcWu58Zk0h8RhTPvXYXacG1NpbcFTvEhUuXZnxOxAyF92YB0zkB7wEd6mwGLncus+0A8twjcw/9Km883XgyxhxXiHl9SAfmI4LEfqRpo9yLjCfhQ1W0fJencFrm6TOthTLxGkELGoVUgYeoCd0xJtKMpN1Sk/l5OLmTRAT1wAeOsu654BCJXyfzkUyqUNbaJIkaaIIms6ELMCN/Vk1bihyiQmCCg80UG2d6icxV6Q9ZJqk/xPTgkls1S9E5kKYJ4UT1H7IxDOyWR3Cuqx2wuFmVuRZEu4TbUXqhbMA3pWpRoEs0poX/upU94CS9HJi2U8ePMyQpwO7IeWTFHRfMgKC9HXApi1wA6a5dBTGPbYQSfUYSR4KfXHvv5oLOrYELU09E1GgTLN9QZy9ZpDJ+QW7WnRd8r7koPUKwNH5kzlKB4BJNNKIulXXONIyw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F9F810C307D8AE40A49811D0D15D9038@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7157.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e4ba19f-b2ed-4ba2-ae0a-08d85922c09c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2020 02:55:06.6785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MTTc7nPjJ788KBNeQQwK4vHJByjoFCyozpFpIaxdFiRLmVFFsGyfIDe+VBcxa2Gr9yH3DdFSpX6Q0dY5L12x+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5176
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-09-14 11:27:49, Matthias Kaehlcke wrote:
> The main issue this driver addresses is that a USB hub needs to be
> powered before it can be discovered. For onboard hubs this is often
> solved by supplying the hub with an 'always-on' regulator, which is
> kind of a hack. Some onboard hubs may require further initialization
> steps, like changing the state of a GPIO or enabling a clock, which
> requires further hacks. This driver creates a platform device
> representing the hub which performs the necessary initialization.
> Currently it only supports switching on a single regulator, support
> for multiple regulators or other actions can be added as needed.
> Different initialization sequences can be supported based on the
> compatible string.
>=20
> Besides performing the initialization the driver can be configured
> to power the hub off during system suspend. This can help to extend
> battery life on battery powered devices, which have no requirements
> to keep the hub powered during suspend. The driver can also be
> configured to leave the hub powered when a wakeup capable USB device
> is connected when suspending, and keeping it powered otherwise.
>=20
> Technically the driver consists of two drivers, the platform driver
> described above and a very thin USB driver that subclasses the
> generic hub driver. The purpose of this driver is to provide the
> platform driver with the USB devices corresponding to the hub(s)
> (a hub controller may provide multiple 'logical' hubs, e.g. one
> to support USB 2.0 and another for USB 3.x).

I agree with Alan, you may change this driver to apply for generic
onboard USB devices.

> +static int onboard_hub_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct onboard_hub *hub;
> +
> +	hub =3D devm_kzalloc(dev, sizeof(*hub), GFP_KERNEL);
> +	if (!hub)
> +		return -ENOMEM;
> +
> +	hub->vdd =3D devm_regulator_get(dev, "vdd");
> +	if (IS_ERR(hub->vdd))
> +		return PTR_ERR(hub->vdd);
> +
> +	hub->dev =3D dev;
> +	mutex_init(&hub->lock);
> +	INIT_LIST_HEAD(&hub->udev_list);
> +
> +	hub->cfg.power_off_in_suspend =3D of_property_read_bool(dev->of_node, "=
power-off-in-suspend");
> +	hub->cfg.wakeup_source =3D of_property_read_bool(dev->of_node, "wakeup-=
source");

Do you really need these two properties? If the device (and its children
if existed) has wakeup enabled, you keep power in suspend, otherwise,
you could close it, any exceptions?

Peter


> +
> +	dev_set_drvdata(dev, hub);
> +
> +	return onboard_hub_power_on(hub);
> +}
> +
> +static int onboard_hub_remove(struct platform_device *pdev)
> +{
> +	struct onboard_hub *hub =3D dev_get_drvdata(&pdev->dev);
> +
> +	return onboard_hub_power_off(hub);
> +}
> +
> +static const struct of_device_id onboard_hub_match[] =3D {
> +	{ .compatible =3D "onboard-usb-hub" },
> +	{ .compatible =3D "realtek,rts5411" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, onboard_hub_match);
> +
> +static struct platform_driver onboard_hub_driver =3D {
> +	.probe =3D onboard_hub_probe,
> +	.remove =3D onboard_hub_remove,
> +#ifdef CONFIG_PM
> +	.suspend =3D onboard_hub_suspend,
> +	.resume =3D onboard_hub_resume,
> +#endif
> +	.driver =3D {
> +		.name =3D "onboard-usb-hub",
> +		.of_match_table =3D onboard_hub_match,
> +	},
> +};
> +
> +/************************** USB driver **************************/
> +
> +#define VENDOR_ID_REALTEK	0x0bda
> +
> +static struct onboard_hub *_find_onboard_hub(struct device *dev)
> +{
> +	const phandle *ph;
> +	struct device_node *np;
> +	struct platform_device *pdev;
> +
> +	ph =3D of_get_property(dev->of_node, "hub", NULL);
> +	if (!ph) {
> +		dev_err(dev, "failed to read 'hub' property\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	np =3D of_find_node_by_phandle(be32_to_cpu(*ph));
> +	if (!np) {
> +		dev_err(dev, "failed find device node for onboard hub\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	pdev =3D of_find_device_by_node(np);
> +	of_node_put(np);
> +	if (!pdev)
> +		return ERR_PTR(-EPROBE_DEFER);
> +
> +	return dev_get_drvdata(&pdev->dev);
> +}
> +
> +static int onboard_hub_usbdev_probe(struct usb_device *udev)
> +{
> +	struct device *dev =3D &udev->dev;
> +	struct onboard_hub *hub;
> +
> +	/* ignore supported hubs without device tree node */
> +	if (!dev->of_node)
> +		return -ENODEV;
> +
> +	hub =3D _find_onboard_hub(dev);
> +	if (IS_ERR(hub))
> +		return PTR_ERR(dev);
> +
> +	dev_set_drvdata(dev, hub);
> +
> +	onboard_hub_add_usbdev(hub, udev);
> +
> +	return 0;
> +}
> +
> +static void onboard_hub_usbdev_disconnect(struct usb_device *udev)
> +{
> +	struct onboard_hub *hub =3D dev_get_drvdata(&udev->dev);
> +
> +	onboard_hub_remove_usbdev(hub, udev);
> +
> +	put_device(hub->dev);
> +}
> +
> +static const struct usb_device_id onboard_hub_id_table[] =3D {
> +	{ .idVendor =3D VENDOR_ID_REALTEK,
> +	  .idProduct =3D 0x0411, /* RTS5411 USB 3.0 */
> +	  .match_flags =3D USB_DEVICE_ID_MATCH_DEVICE },
> +	{ .idVendor =3D VENDOR_ID_REALTEK,
> +	  .idProduct =3D 0x5411, /* RTS5411 USB 2.0 */
> +	  .match_flags =3D USB_DEVICE_ID_MATCH_DEVICE },
> +	{},
> +};
> +
> +MODULE_DEVICE_TABLE(usb, onboard_hub_id_table);
> +
> +static struct usb_device_driver onboard_hub_usbdev_driver =3D {
> +
> +	.name =3D "onboard-usb-hub",
> +	.probe =3D onboard_hub_usbdev_probe,
> +	.disconnect =3D onboard_hub_usbdev_disconnect,
> +	.generic_subclass =3D 1,
> +	.supports_autosuspend =3D	1,
> +	.id_table =3D onboard_hub_id_table,
> +};
> +
> +/************************** Driver (de)registration ********************=
******/
> +
> +static int __init onboard_hub_init(void)
> +{
> +	int rc;
> +
> +	rc =3D platform_driver_register(&onboard_hub_driver);
> +	if (rc)
> +		return rc;
> +
> +	return usb_register_device_driver(&onboard_hub_usbdev_driver, THIS_MODU=
LE);
> +}
> +device_initcall(onboard_hub_init);
> +
> +static void __exit onboard_hub_exit(void)
> +{
> +	usb_deregister_device_driver(&onboard_hub_usbdev_driver);
> +	platform_driver_unregister(&onboard_hub_driver);
> +}
> +module_exit(onboard_hub_exit);
> +
> +MODULE_AUTHOR("Matthias Kaehlcke <mka@chromium.org>");
> +MODULE_DESCRIPTION("Onboard USB Hub driver");
> +MODULE_LICENSE("GPL v2");
> --=20
> 2.28.0.618.gf4bc123cb7-goog
>=20

--=20

Thanks,
Peter Chen=
