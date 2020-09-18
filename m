Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 488E526EA7B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 03:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgIRBa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 21:30:26 -0400
Received: from mail-eopbgr130077.outbound.protection.outlook.com ([40.107.13.77]:54732
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726007AbgIRBa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 21:30:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZYd7scwmGQll05uA8ApqasSgS6gHveeaUIoCYGYM8n9gfXGzjMgktpw+ZEmpED7DGgYAJuKGRtnrzP3I0AWJNz+f724V53BSMx92yds/3nXkqEquQ7+iJ8N2EwxdyC2QvpIFWZt2Diwy+VA0JOzqLf8cuF32bAMlkz/ShFcPRZE16vmQ42LgnbU5XE3AP3k+knqJVKusW6WH6gDC3sTRX7qISRFNKgExZTYLyo3FbHtf8vF1VrSBUxTaZMnPTxM5CsMrfCUDuIkRPXHr7D9i3ses7+cGufpyrDgbDRzly0km0S940bh4gUDNWqiXWGw3zod6tY9xB14TTxAlVxroPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3eaCVO9dtgRH2ul06UTUSoFMMm+05fRrE6tJ3JrkngM=;
 b=mGqGZrwJI8YKW1b4s99txduoNSB354bPJpFKBhbeinr/iw5nrmKLcMH4uafupPX8m24QoGBG+h3pp7IhJDftGsRayAywgVEsUirgYCtJYFSj7BHZO1nzqmdf87ekLxfo9IKR+xNzh6MFTzHL27KSXE0Jdg/PpTxGOjw5Sdov7vtsew7LWxYgx9uT5QlfrJ/WwZxeb14sd9x2bZhx9U7aeC+VcrcO/4BuFqXoXtcowMjVXOdKlLeDAzV8xJL/D5vzU1raPTnvAnWvJlfLXY7qE358UYyBmS1sK77tnPcFaFxMShznkwFk/s8vJwFe7/jkVLXtWLn3PZsfp3FatEoQug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3eaCVO9dtgRH2ul06UTUSoFMMm+05fRrE6tJ3JrkngM=;
 b=LtUmyfVYyl9d7V6E4+ZYfVvk8Xuc5f9f5JGkJZpndy0/vtlVhWjYY+SI1T1p5cZXQQpJQrkcxwW+N/oNztz7oOKLU/q2rhxEYnwgokvtIF7/7NWvfFvQYJpLydBVnrgxNf3iGhl1q8xhwMFEiYOp7kjm+CBMnMIjZaZotmEW0Vs=
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20)
 by AM6PR04MB6437.eurprd04.prod.outlook.com (2603:10a6:20b:f3::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 18 Sep
 2020 01:30:20 +0000
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1023:be8d:40c:efe1]) by AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1023:be8d:40c:efe1%3]) with mapi id 15.20.3391.013; Fri, 18 Sep 2020
 01:30:20 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Matthias Kaehlcke <mka@chromium.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH v2 2/2] USB: misc: Add onboard_usb_hub driver
Thread-Topic: [PATCH v2 2/2] USB: misc: Add onboard_usb_hub driver
Thread-Index: AQHWjSLcz65MIHr9l0mmL9XOptmWpqltnA+A
Date:   Fri, 18 Sep 2020 01:30:20 +0000
Message-ID: <20200918012935.GA3938@b29397-desktop>
References: <20200917114600.v2.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
 <20200917114600.v2.2.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
In-Reply-To: <20200917114600.v2.2.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 23e6a690-4a5d-47f2-41d7-08d85b72685b
x-ms-traffictypediagnostic: AM6PR04MB6437:
x-microsoft-antispam-prvs: <AM6PR04MB6437C374310FF1319ACB61498B3F0@AM6PR04MB6437.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ybfc3YhtzTF+iIClvcqYFRBfcurU1p3omlL99riB7HGDU2kIDz7nI12v4OSseurcptw8IgyrkwOWgmg7v2SK0AhPImo8B3X6aOVks4fRK4AGk0f3HpaBu5ZFLYwtNMZStTSrGX8TtPoexgOwF1jLVzbxMnlKoVwr+fhAM3fiyc6niDg1yw977eVq7PO5mrBxYs6jBFU40+nsEI/z2kTAQZB9i/j3SKR4oaFmfAWRtSIwsujcDQUQAslEm+2aCSsyFTHN9Klmpx41tf6i3J6ykvq5715mSwHc883/XRAacv+VHp4I43LUN5NsS4wzJLpjjCasFuByEFWixMjyosVFgQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7157.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(396003)(346002)(366004)(376002)(39860400002)(136003)(316002)(44832011)(9686003)(6512007)(6506007)(33656002)(53546011)(66476007)(86362001)(91956017)(64756008)(66446008)(26005)(66946007)(8936002)(66556008)(5660300002)(33716001)(76116006)(71200400001)(4326008)(6916009)(2906002)(6486002)(186003)(83380400001)(8676002)(54906003)(7416002)(1076003)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Jy3nb0DS0D54p6qk9soTOsmh8flSq+Y/3Ct1v/hzW47Kdfvmf6VlhWWizU/05c+JcFVau1EtJsq7szEzYaTiykeCLnfHTw+wjolfETIjZpP/MDa/01VaM6rf38weWzsD48XOvvEW9vUCviJwhcOJkcuJr1uGqbXEe5cnait/Aj59RRk+F5vblGASyICpwCG0wK84ZnjKnDqxxzSzSm45iDg5q/mPx1hM6wWioo9TXFRCPgGPESbBoT+bkqq5Q+kCM0wWMYLiubKxlbEU9039l/0tdGI40SQON2VPOuihz811UPZfweznyGlf3hPREEIkTGYaCmDpfkiCN5/rR2K8ydue4ofav11oj//wtl56uHP5CjdBbg+5n3rUzwKXBxs2t/QeDMxlQV6snzNGKcINfY4Z952rqJJ4WNFekeC/iAxUhtBup4VHQDQl0iCBQkW7bEVCd8wplnBGHrG3vFOxam5Q0YjgTC7c69sxGbbzbGlUc9wjvppoC3fKD9JIpIsYjNyuH91yoNaGt2xpOtDI/haomcHGGugA38l7wpnxZ1JqRm5iiA7Kep4x8G5Cmp1Qph4V/6CrgNvYnBKHmt4nFj6TW04oFoOs1ChksOqNaHMOE8A8u3/4Rnpvypkzl0BcRfubh+CLI+gKffuXaUMfMQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C0D665A162C5084D90063F62ED633206@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7157.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23e6a690-4a5d-47f2-41d7-08d85b72685b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2020 01:30:20.6313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MA5TnHos0iOHVLWMg6jU/IT19+w55ybyOQEsyPupJi0wzn/1cq9mz8aVqQhWyDeCMRqVnNa9IGJPYYa4UV9jiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6437
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-09-17 11:46:22, Matthias Kaehlcke wrote:
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
> battery life on battery powered devices which have no requirements
> to keep the hub powered during suspend. The driver can also be
> configured to leave the hub powered when a wakeup capable USB device
> is connected when suspending, and power it off otherwise.
>=20
> Technically the driver consists of two drivers, the platform driver
> described above and a very thin USB driver that subclasses the
> generic driver. The purpose of this driver is to provide the platform
> driver with the USB devices corresponding to the hub(s) (a hub
> controller may provide multiple 'logical' hubs, e.g. one to support
> USB 2.0 and another for USB 3.x).
>=20
> Co-developed-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
> Signed-off-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>=20
> Changes in v2:
> - check wakeup enabled state of the USB controller instead of
>   using 'wakeup-source' property
> - use sysfs attribute instead of DT property to determine if
>   the hub should be powered off at all during system suspend
> - added missing brace in onboard_hub_suspend()
> - updated commit message
> - use pm_ptr for pm_ops as suggested by Alan
>=20
> Changes in v1:
> - renamed the driver to 'onboard_usb_hub'
> - single file for platform and USB driver
> - USB hub devices register with the platform device
>   - the DT includes a phandle of the platform device
> - the platform device now controls when power is turned off
> - the USB driver became a very thin subclass of the generic USB
>   driver
> - enabled autosuspend support
>=20
>  drivers/usb/misc/Kconfig           |  15 ++
>  drivers/usb/misc/Makefile          |   1 +
>  drivers/usb/misc/onboard_usb_hub.c | 329 +++++++++++++++++++++++++++++
>  3 files changed, 345 insertions(+)
>  create mode 100644 drivers/usb/misc/onboard_usb_hub.c
>=20
> diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
> index 6818ea689cd9..e941244e24e5 100644
> --- a/drivers/usb/misc/Kconfig
> +++ b/drivers/usb/misc/Kconfig
> @@ -275,3 +275,18 @@ config USB_CHAOSKEY
> =20
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called chaoskey.
> +
> +config USB_ONBOARD_HUB
> +	tristate "Onboard USB hub support"

On board HUB belongs to HUB, this driver is just for possible power and
initialization requirements for HUB which is hard-wired on board. The
configuration name USB_HUB_POWER_SUPPLY may more suitable, and at the
menu and help, you could indicate it is special for HUBs which are
hard-wired on board.

> +static ssize_t power_off_in_suspend_show(struct device *dev, struct devi=
ce_attribute *attr,
> +			   char *buf)
> +{
> +	struct onboard_hub *hub =3D dev_get_drvdata(dev);
> +
> +	return sprintf(buf, "%d\n", hub->power_off_in_suspend);
> +}
> +
> +static ssize_t power_off_in_suspend_store(struct device *dev, struct dev=
ice_attribute *attr,
> +			    const char *buf, size_t count)
> +{
> +	struct onboard_hub *hub =3D dev_get_drvdata(dev);
> +	bool val;
> +	int ret;
> +
> +	ret =3D strtobool(buf, &val);
> +	if (ret < 0)
> +		return ret;
> +
> +	hub->power_off_in_suspend =3D val;
> +
> +	return count;
> +}
> +static DEVICE_ATTR_RW(power_off_in_suspend);
> +
> +static int onboard_hub_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct onboard_hub *hub;
> +	int rc;
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
> +	dev_set_drvdata(dev, hub);
> +
> +	rc =3D sysfs_create_file(&dev->kobj, &dev_attr_power_off_in_suspend.att=
r);
> +	if (rc)
> +		return rc;

You could use dev_groups for sysfs entry management.

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

Improve the description like mentioned above.

--=20

Thanks,
Peter Chen=
