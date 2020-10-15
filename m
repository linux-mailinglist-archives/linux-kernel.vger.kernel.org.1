Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB9D228EE54
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 10:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388072AbgJOIPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 04:15:17 -0400
Received: from mail-bn8nam12on2045.outbound.protection.outlook.com ([40.107.237.45]:27468
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387764AbgJOIPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 04:15:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HqyRERjinDYG6ZQ8W4P2jqcZcjViVDuxCk4l+JWsX5DfB1DNEprqnYJMA9iZI6+2OT6NDUk8CW1tefF7/lUJoFrhv0VUIwM98GUDUt1+qRNwZCS1ego58bqoM5w4hjEoeGcCEiqYUJpulAsiVbyun/4eUUeqjP0sFDM+DmlNXQQL4vP14PKV81G2kV0OSqRaxgiHRqEDRHtoIbcOvTeauwZ6sPD3rhPa24YH0RS/i6WOngH9eT0iFPKmT97hATR5AzA0RzV+s5CKLDp9ddJK277knmCeCb5We7g7AH7CFkaQ2MvsaU0Q81UUAhhecFJjMwMp35yubHi06ucdDFuO9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMdYs3IQjgX8UGFLApWXTD7kOXJXAgeLGTNDkZ2/T7c=;
 b=eGgQb5ftzlSwZCxYBEDpUCYg4Qeh3NbMeH80Zdavq9Zswl2s7d/phc6ZqenDw7vZrzYlacPd8ImVEKHTMyIG6VB42kzDKeBFoxuMlR6uU9XGtmOLiXByYsWLHJkVDxl0LSL7jHVjOQ8tnoly8Lu11c1Gs39lcGefeY4juxb9aPZdpWEWa2JfrmMHsXeC4iE2CQN8I/rQ98UI83Mf8H29D4BniUKoZc6go07W8dRpBiktbntyW16PYW753OT/UN3bYxcGaqiMQDqqjAwSza8+5GhKOFamXbdS1+/wyxuQwWFlDWrKy1AilYK6lGd4oyArzpTtEHG2H1pxhUn+b81Qdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMdYs3IQjgX8UGFLApWXTD7kOXJXAgeLGTNDkZ2/T7c=;
 b=GlREe+9I3udy2EfgQaUZ50K1IA4E1NK62Vc1IIWsDYbj3MFEv2jvsVijc3GKMYM9gph6vqBHAK8SiAIFWr1FaGOqaViqNf6RJY1RK0Zl5sTpH+/mwMSshfZtizm9qYwdgwRfmGl17CzwqAmZuQMTPCB0mJDI53i/LosElX9/tyY=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB4555.namprd03.prod.outlook.com (2603:10b6:5:102::17)
 by DS7PR03MB5622.namprd03.prod.outlook.com (2603:10b6:5:2ca::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Thu, 15 Oct
 2020 08:15:08 +0000
Received: from DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38]) by DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38%7]) with mapi id 15.20.3477.020; Thu, 15 Oct 2020
 08:15:08 +0000
Date:   Thu, 15 Oct 2020 16:14:55 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Saravana Kannan <saravanak@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: fw_devlink on will break all snps,dw-apb-gpio users
Message-ID: <20201015161455.744d5041@xhacker.debian>
In-Reply-To: <CAGETcx_jzF_iV5oJQ8BuDBu0b5Z8G=uL0DhA4uS5U9XLuYryjg@mail.gmail.com>
References: <20201014191235.7f71fcb4@xhacker.debian>
        <CAGETcx9PiX==mLxB9PO8Myyk6u2vhPVwTMsA5NkD-ywH5xhusw@mail.gmail.com>
        <20201015120206.41b6a454@xhacker.debian>
        <CAGETcx_jzF_iV5oJQ8BuDBu0b5Z8G=uL0DhA4uS5U9XLuYryjg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY2PR06CA0023.apcprd06.prod.outlook.com
 (2603:1096:404:42::35) To DM6PR03MB4555.namprd03.prod.outlook.com
 (2603:10b6:5:102::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (124.74.246.114) by TY2PR06CA0023.apcprd06.prod.outlook.com (2603:1096:404:42::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21 via Frontend Transport; Thu, 15 Oct 2020 08:15:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab223ef3-adda-4155-ddc3-08d870e26deb
X-MS-TrafficTypeDiagnostic: DS7PR03MB5622:
X-Microsoft-Antispam-PRVS: <DS7PR03MB5622015FEA8A71E1B0A0BB3BED020@DS7PR03MB5622.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VvS+Bh23lirTAfEMXzRBER01xDFr6/g2PXEeiqOu6XPc8pd2DeMoASfF0knBocKz12B0i+GSwWjBMFzh6IuYua1qwy03/kejufjaT6SpNQqluAlw0Y3MP8jNQqtQAkuUorfZuOGGbryf70Xo5EeIBVkP9KRMdE8QboSd4CZcuhqnL3bhGOLJ/3asiFxZ6wXKJtutwwMQTre2eDAUHHYl6v6ujWV2VfjHZqRVmMT0CMxJbQ6VRYMDsVJ9vdPW8uzizMoWwP0tK85y0WJ+8G06NjT+TDqRUR/Fv+j4d0ECgAdchlz4KHu64+5JjKSnZ/XZQsT4ng6zbX6BBSUsuVfZRPOyAu3k7CMRap93up26qfwobpryXdUyWFpbjWF+3f70kJk0sk2VBRnv1IZyEp5pPoBGOJOUlCr9bfid5pTZA8aG3XXGvpEKDoXyAY80IVYzZ+K1ZREnVMG4A48CnoqbiUxxQQjlMIndXW7loSBfAa5q9f4UtMo+Zc/yYl75KNRe0JiJ690ItWGa9MN9Q9lQJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4555.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(346002)(366004)(136003)(5660300002)(52116002)(66556008)(7696005)(478600001)(66946007)(8676002)(83380400001)(966005)(66476007)(34490700002)(956004)(83080400001)(8936002)(110136005)(1076003)(54906003)(55016002)(86362001)(16526019)(6666004)(26005)(186003)(316002)(6506007)(9686003)(2906002)(4326008)(53546011)(26730200005)(19860200003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 0Hg1lVVddMeyXfO0OFYWQdQ8rHqPUgw4AnFk+BdOLLeE1ly3aErDQiSSMUjoIPT1QLoQmRyO1W/MFdFO8JZ15yRNCzcwICL5ztIYWCOTrShOocrzbnjfy3b9trbu6FKna5lx21rh3FSN2iXo2BpdiqUZG9M2A1Kong+en7TUqFWXtcFphoTrTBKlDJ28xWj6Do580SS9Xw+yDpSV9eopWDBluIERg4Q/mKT2ZM6DHOxjsc2Kf0BH6IBB8QUCOGgd8G6XZ9RJ+OIZewj12oAIp6RB0qzc2EH+9ge6bZ2ZFcAxewIYpupSCkOGYvR2iBwMwJAht+73BdvenZabiDQPIyEUMrJDWRjYHECpSm4pg8hirQhSKj+V8WshyOjs+iPmYkI6LUyg4Zfh+KUGEv7tLJ9xRSW2/PjaQjbJArn5Nt71wSi8D1olqVpUcGBusxwQmris47yrMxQyVqzFXKIzosd0S+ZuqA79AEX1AEcmx2z9vgrKUF3OFm/JZzET/oOovVWbygoBb+fWTiXrg+Ma8n1meHcAtvfJiXHYzUgV0wLyzKnqkmFoCb5MOFLBYx99QVGHdyyd1x17IUtcOWYuJSSiZW6/B+HR/KKWYqC1wOBrVCpT1wHl3hSTuE+W9F8pv3vw0kreCHjGxIrlHiagVw==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab223ef3-adda-4155-ddc3-08d870e26deb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB4555.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2020 08:15:08.4947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dqspcoujp0y+ZmKVfZzX3Cow2e5mYAGL/S13/jT4YBc9ZtYkbU6w1Snh2AJeLTbF2kdL8/6TgAdVYjwiKInemQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5622
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Oct 2020 22:04:24 -0700 Saravana Kannan wrote:

> 
> 
> On Wed, Oct 14, 2020 at 9:02 PM Jisheng Zhang
> <Jisheng.Zhang@synaptics.com> wrote:
> >
> > On Wed, 14 Oct 2020 10:29:36 -0700
> > Saravana Kannan <saravanak@google.com> wrote:
> >  
> > >
> > >
> > > On Wed, Oct 14, 2020 at 4:12 AM Jisheng Zhang
> > > <Jisheng.Zhang@synaptics.com> wrote:  
> > > >
> > > > Hi,
> > > >
> > > > If set fw_devlink as on, any consumers of dw apb gpio won't probe.
> > > >
> > > > The related dts looks like:
> > > >
> > > > gpio0: gpio@2400 {
> > > >        compatible = "snps,dw-apb-gpio";
> > > >        #address-cells = <1>;
> > > >        #size-cells = <0>;
> > > >
> > > >        porta: gpio-port@0 {
> > > >               compatible = "snps,dw-apb-gpio-port";
> > > >               gpio-controller;
> > > >               #gpio-cells = <2>;
> > > >               ngpios = <32>;
> > > >               reg = <0>;
> > > >        };
> > > > };
> > > >
> > > > device_foo {
> > > >         status = "okay"
> > > >         ...;
> > > >         reset-gpio = <&porta, 0, GPIO_ACTIVE_HIGH>;
> > > > };
> > > >
> > > > If I change the reset-gpio property to use another kind of gpio phandle,
> > > > e.g gpio expander, then device_foo can be probed successfully.
> > > >
> > > > The gpio expander dt node looks like:
> > > >
> > > >         expander3: gpio@44 {
> > > >                 compatible = "fcs,fxl6408";
> > > >                 pinctrl-names = "default";
> > > >                 pinctrl-0 = <&expander3_pmux>;
> > > >                 reg = <0x44>;
> > > >                 gpio-controller;
> > > >                 #gpio-cells = <2>;
> > > >                 interrupt-parent = <&portb>;
> > > >                 interrupts = <23 IRQ_TYPE_NONE>;
> > > >                 interrupt-controller;
> > > >                 #interrupt-cells = <2>;
> > > >         };
> > > >
> > > > The common pattern looks like the devlink can't cope with suppliers from
> > > > child dt node.  
> > >
> > > fw_devlink doesn't have any problem dealing with child devices being
> > > suppliers. The problem with your case is that the
> > > drivers/gpio/gpio-dwapb.c driver directly parses the child nodes and
> > > never creates struct devices for them. If you have a node with
> > > compatible string, fw_devlink expects you to create and probe a struct
> > > device for it. So change your driver to add the child devices as
> > > devices instead of just parsing the node directly and doing stuff with
> > > it.
> > >
> > > Either that, or stop putting "compatible" string in a node if you
> > > don't plan to actually treat it as a device -- but that's too late for
> > > this driver (it needs to be backward compatible). So change the driver
> > > to add of_platform_populate() and write a driver that probes
> > > "snps,dw-apb-gpio-port".
> > >  
> >
> > Thanks for the information. The "snps,dw-apb-gpio-port" is never used,
> > so I just sent out a series to remove it.  
> 
> I'd actually prefer that you fix the kernel code to actually use it.
> So that fw_devlink can be backward compatible (Older DT + new kernel).
> The change is pretty trivial (I just have time to do it for you).
> 

I agree the change is trivial, but it will add some useless LoCs like below.
I'm not sure whether this is acceptable.So add GPIO and DT maintainers to comment.

Hi Linus, Rob,

Could you please comment? A simple introduction of the problem:

As pointed out by Saravana, "gpio-dwapb.c driver directly parses the child
nodes and never creates struct devices for them. If you have a node with
compatible string, fw_devlink expects you to create and probe a struct
device for it", so once we set fw_devlink=on, then any users of gpio-dwapb
as below won't be probed.

device_foo {
         status = "okay"
         ...;
         reset-gpio = <&porta, 0, GPIO_ACTIVE_HIGH>;
};

The compatible string "snps,dw-apb-gpio-port" is never used, but it's in
the dt-binding since the dw gpio mainlined. I believe the every dw apb
users just copy the compatible string in to soc dtsi. So I submit a series
to remove the unused "snps,dw-apb-gpio-port" https://lkml.org/lkml/2020/10/14/1186
But this will break Older DT + new kernel with fw_devlink on. Which solution
is better?

If the following patch is acceptable, I can submit it once 5.10-rc1 is out.

thanks

diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
index 1d8d55bd63aa..b8e012e48b59 100644
--- a/drivers/gpio/gpio-dwapb.c
+++ b/drivers/gpio/gpio-dwapb.c
@@ -19,6 +19,7 @@
 #include <linux/of_address.h>
 #include <linux/of_device.h>
 #include <linux/of_irq.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
 #include <linux/reset.h>
@@ -694,6 +695,10 @@ static int dwapb_gpio_probe(struct platform_device *pdev)
 	}
 	platform_set_drvdata(pdev, gpio);
 
+	err = devm_of_platform_populate(dev);
+	if (err)
+		goto out_unregister;
+
 	return 0;
 
 out_unregister:
@@ -820,6 +825,25 @@ static struct platform_driver dwapb_gpio_driver = {
 
 module_platform_driver(dwapb_gpio_driver);
 
+static const struct of_device_id dwapb_port_of_match[] = {
+	{ .compatible = "snps,dw-apb-gpio-port" },
+	{ /* Sentinel */ }
+};
+
+static int dwapb_gpio_port_probe(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static struct platform_driver dwapb_gpio_port_driver = {
+	.driver		= {
+		.name	= "gpio-dwapb-port",
+		.of_match_table = dwapb_port_of_match,
+	},
+	.probe		= dwapb_gpio_port_probe,
+};
+module_platform_driver(dwapb_gpio_port_driver);
+
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Jamie Iles");
 MODULE_DESCRIPTION("Synopsys DesignWare APB GPIO driver");

