Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D94228EFA9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 11:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730917AbgJOJxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 05:53:33 -0400
Received: from mail-dm6nam12on2060.outbound.protection.outlook.com ([40.107.243.60]:8928
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727165AbgJOJxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 05:53:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ivDdqpIxOnOE6NK3HDV0VtIJhFt5y4wOacxkw4Hg/zS+9hvihKeVYUXw+3Y5XqIRFeH2A2ov2F8/MKvVulQUWz2fe/SNL+vcGFVPRPHW/ZAxX9MJghDd+7ywMocmKPgux17/3hi1uulpby/hSIPWnSP3UV/QCou72N6CJC8wxBK24sA9rs+Zs+hG1Y12GEim1yoa/VMXzCJBs9VNMkLTlavlIhFOYMZ/MTB4Q6Wyze82kL7FmBVjZOVvZw0jMRZBOultFSF/AHS7wlRhrp3rNEevoKAQKeVOO8t6jcFsTqLBZ8GdMhrE3BWaUkJ+5hEZge20N1RBJsLqcDCbapvleQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HHumXpQ0o5mQ+oFFL7itAWG2l0hEaRL1Nk072g7yLqE=;
 b=KkK1E+k1jMRo6lmqNKZhWHKZ8ZghkaoCXalBNHRUp97XQ0CRkaXiPbBWMKmsdtqGFkheQxjQCA/m9I8GjvMaQ/DNkCCtwNPmvf/oxNUiimxLSh8wuoj3kHYKf8o6nLdU5K+aaou8culN8ID+kIp+VRCqgRBnpfv0b+TX+NLMukckzlRWqyqttkwq/A5Ond89MXRlItWMLKfxLM8ag8qW6I6Fo1RS/nVOwfESpB5L2/6YHPddeTFWChdiaYT99puX577u+9AlhvbcFxERRjxw3t5fH1SuDzzTKZdxWEGo/oQe43p4tjinKyw48KlREGqbW0pofQyn9HK3jZAeWHZPJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HHumXpQ0o5mQ+oFFL7itAWG2l0hEaRL1Nk072g7yLqE=;
 b=a2ajhsuuXA3stmYCiGdd6n3QWW0uV3zU12zmu5e8jkA57Qxc2BiEaC8IPdxso8Rb6ZU3LhRAyuehy6+vRpFFE7ElDawubijmJJBlBwI71g49/V22ZAnHtzs0cqFQ4Q99clIYqHYreArgUZOaiOca5Q5xDDn6HqXyaRuwJzo5zTE=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB4555.namprd03.prod.outlook.com (2603:10b6:5:102::17)
 by DS7PR03MB5558.namprd03.prod.outlook.com (2603:10b6:5:2c3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Thu, 15 Oct
 2020 09:53:29 +0000
Received: from DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38]) by DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38%7]) with mapi id 15.20.3477.020; Thu, 15 Oct 2020
 09:53:29 +0000
Date:   Thu, 15 Oct 2020 17:52:31 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: fw_devlink on will break all snps,dw-apb-gpio users
Message-ID: <20201015175231.1a690c21@xhacker.debian>
In-Reply-To: <CAGETcx_hORWf2HkcUP=Dj6noCUsbj9KsycZ-Hr80BUOwyZaQBg@mail.gmail.com>
References: <20201014191235.7f71fcb4@xhacker.debian>
        <CAGETcx9PiX==mLxB9PO8Myyk6u2vhPVwTMsA5NkD-ywH5xhusw@mail.gmail.com>
        <20201015120206.41b6a454@xhacker.debian>
        <CAGETcx_jzF_iV5oJQ8BuDBu0b5Z8G=uL0DhA4uS5U9XLuYryjg@mail.gmail.com>
        <20201015161455.744d5041@xhacker.debian>
        <CAGETcx_hORWf2HkcUP=Dj6noCUsbj9KsycZ-Hr80BUOwyZaQBg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY2PR02CA0067.apcprd02.prod.outlook.com
 (2603:1096:404:e2::31) To DM6PR03MB4555.namprd03.prod.outlook.com
 (2603:10b6:5:102::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (124.74.246.114) by TY2PR02CA0067.apcprd02.prod.outlook.com (2603:1096:404:e2::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21 via Frontend Transport; Thu, 15 Oct 2020 09:53:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 196fffab-9cc2-47a2-296b-08d870f02aff
X-MS-TrafficTypeDiagnostic: DS7PR03MB5558:
X-Microsoft-Antispam-PRVS: <DS7PR03MB5558A1A6B7E31DC424309E36ED020@DS7PR03MB5558.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +PbrdHHzoWiPC+ie/N41ONJ73Tci1vkjodI2OI96G0YAAp3Wr9n/kvislyPl4b9bI4Jnpo+9Tf4RuH5odlI+V1NlDPsVn0j19ok4VEh3DTUT/yss5fEo5LspocUqQmC71Su6WRgYOAjitKOge5ctUPU0/mde1Ex9GOsplAs7OtHmIWmFsNnCSN5/5IDcal008QSr8OoRDseqyg63kJY7WQliBxV33hmnnWGp2UvaLXUnLW54cXilS0GU7zGBmXrof/ZpMe9ciYSyXUhA1VJ8nZ2QZOaStJzaWeADoOMN7UgRtueujRvzeaiaML9stfb4DKSalwu0szSJ7O/z7E8mkvfg27vqtesW2u6/8rTBaNEQx02dn/rEm0GaVm6gp2pN+otVqDIbmQ0N8AX2W4z9DRLrmi5xPUv138xISPB8Lok5+Shkq/Tfr+LfR7niZekO4sWiDK0v3nTVpkZOl6acEjUPuFLFX6lgg+2MeqZM8B1sG5bKVUO+YURueit8o2sLTRgWgoORKWInkreiQpm5HQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4555.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(86362001)(186003)(6666004)(66946007)(966005)(4326008)(478600001)(8676002)(5660300002)(54906003)(83080400001)(316002)(7696005)(52116002)(16526019)(26005)(9686003)(66476007)(66556008)(8936002)(55016002)(956004)(1076003)(2906002)(6916009)(83380400001)(53546011)(6506007)(34490700002)(26730200005)(19860200003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: uc9tGDV+SzAr68XCg8tfv47WetZ+y7x8eP9hAhcehpjJt+Kq923F1aZy/A3c9PMwtrsM9uqc9iGpP1drUPM75PcHAp/KKMViF/TX1g9OF2ELxp4qwRKCI7eEmO4V8Ges2DDbhcEzKaXQ6QHJX35I+BdpBZLVyGBN2v8MKjR9Ozld1WfEyOuiR+dvFq8WTrxfKDKZIxQGLypbFqVJvEd0WfZ/ayMbQYZ7/uqKJNslS9UWMmvo5MW47XHSCIo82xrtcLiNo5Kr1dg9LVjczTvsLL549WKLpIi9yp6PZIw7Jdrlsbgepyrw0/lh5d++6kOGGXBRP3wPAgF4Zus5DJjOarSgWmG6mSk2MkwFAT2JcurprgoYS/52co+38lKciIc4mpcaxjkytXR0qoE9oqHCHaGBBBA6Sb4ScsvYF2ehi/ScD1k6aET2eXosCzxIcTGx0IzHGZNyNosoGVOOlY6TbY+1c2+X1qro3ExQDyr/hNcYBFwA1hnMyyb+X4WWNSOblhGsRbBIBVGeaaPc2lE5ZFnmqQX40blhNaIeYj0MOWMbXLsKATg3qe5T8L4XXDxxSZqTpA3ly0+VwtaaSJNP3rTwKHwuucgXND+zLLWaIrotbs17LFgyPKi+WZxutxKr0c3uKDTwOwFlqOzRDb40sQ==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 196fffab-9cc2-47a2-296b-08d870f02aff
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB4555.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2020 09:53:29.1311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: olr7r7ucKVQzxHW21nZZX69plgbwsT0rn7Redy6sxBymGA8Z5Rb9boYnMmYg3FaG85aI6Ic6nRk8J13YQGAVlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5558
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Oct 2020 01:48:13 -0700
Saravana Kannan <saravanak@google.com> wrote:

> On Thu, Oct 15, 2020 at 1:15 AM Jisheng Zhang
> <Jisheng.Zhang@synaptics.com> wrote:
> >
> > On Wed, 14 Oct 2020 22:04:24 -0700 Saravana Kannan wrote:
> >  
> > >
> > >
> > > On Wed, Oct 14, 2020 at 9:02 PM Jisheng Zhang
> > > <Jisheng.Zhang@synaptics.com> wrote:  
> > > >
> > > > On Wed, 14 Oct 2020 10:29:36 -0700
> > > > Saravana Kannan <saravanak@google.com> wrote:
> > > >  
> > > > >
> > > > >
> > > > > On Wed, Oct 14, 2020 at 4:12 AM Jisheng Zhang
> > > > > <Jisheng.Zhang@synaptics.com> wrote:  
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > If set fw_devlink as on, any consumers of dw apb gpio won't probe.
> > > > > >
> > > > > > The related dts looks like:
> > > > > >
> > > > > > gpio0: gpio@2400 {
> > > > > >        compatible = "snps,dw-apb-gpio";
> > > > > >        #address-cells = <1>;
> > > > > >        #size-cells = <0>;
> > > > > >
> > > > > >        porta: gpio-port@0 {
> > > > > >               compatible = "snps,dw-apb-gpio-port";
> > > > > >               gpio-controller;
> > > > > >               #gpio-cells = <2>;
> > > > > >               ngpios = <32>;
> > > > > >               reg = <0>;
> > > > > >        };
> > > > > > };
> > > > > >
> > > > > > device_foo {
> > > > > >         status = "okay"
> > > > > >         ...;
> > > > > >         reset-gpio = <&porta, 0, GPIO_ACTIVE_HIGH>;
> > > > > > };
> > > > > >
> > > > > > If I change the reset-gpio property to use another kind of gpio phandle,
> > > > > > e.g gpio expander, then device_foo can be probed successfully.
> > > > > >
> > > > > > The gpio expander dt node looks like:
> > > > > >
> > > > > >         expander3: gpio@44 {
> > > > > >                 compatible = "fcs,fxl6408";
> > > > > >                 pinctrl-names = "default";
> > > > > >                 pinctrl-0 = <&expander3_pmux>;
> > > > > >                 reg = <0x44>;
> > > > > >                 gpio-controller;
> > > > > >                 #gpio-cells = <2>;
> > > > > >                 interrupt-parent = <&portb>;
> > > > > >                 interrupts = <23 IRQ_TYPE_NONE>;
> > > > > >                 interrupt-controller;
> > > > > >                 #interrupt-cells = <2>;
> > > > > >         };
> > > > > >
> > > > > > The common pattern looks like the devlink can't cope with suppliers from
> > > > > > child dt node.  
> > > > >
> > > > > fw_devlink doesn't have any problem dealing with child devices being
> > > > > suppliers. The problem with your case is that the
> > > > > drivers/gpio/gpio-dwapb.c driver directly parses the child nodes and
> > > > > never creates struct devices for them. If you have a node with
> > > > > compatible string, fw_devlink expects you to create and probe a struct
> > > > > device for it. So change your driver to add the child devices as
> > > > > devices instead of just parsing the node directly and doing stuff with
> > > > > it.
> > > > >
> > > > > Either that, or stop putting "compatible" string in a node if you
> > > > > don't plan to actually treat it as a device -- but that's too late for
> > > > > this driver (it needs to be backward compatible). So change the driver
> > > > > to add of_platform_populate() and write a driver that probes
> > > > > "snps,dw-apb-gpio-port".
> > > > >  
> > > >
> > > > Thanks for the information. The "snps,dw-apb-gpio-port" is never used,
> > > > so I just sent out a series to remove it.  
> > >
> > > I'd actually prefer that you fix the kernel code to actually use it.
> > > So that fw_devlink can be backward compatible (Older DT + new kernel).
> > > The change is pretty trivial (I just have time to do it for you).
> > >  
> >
> > I agree the change is trivial, but it will add some useless LoCs like below.  
> 
> It's not useless if it preserves backward compatibility with DT.
> 
> > I'm not sure whether this is acceptable.So add GPIO and DT maintainers to comment.
> >
> > Hi Linus, Rob,
> >
> > Could you please comment? A simple introduction of the problem:
> >
> > As pointed out by Saravana, "gpio-dwapb.c driver directly parses the child
> > nodes and never creates struct devices for them. If you have a node with
> > compatible string, fw_devlink expects you to create and probe a struct
> > device for it", so once we set fw_devlink=on, then any users of gpio-dwapb
> > as below won't be probed.
> >
> > device_foo {
> >          status = "okay"
> >          ...;
> >          reset-gpio = <&porta, 0, GPIO_ACTIVE_HIGH>;
> > };
> >
> > The compatible string "snps,dw-apb-gpio-port" is never used, but it's in
> > the dt-binding since the dw gpio mainlined. I believe the every dw apb
> > users just copy the compatible string in to soc dtsi. So I submit a series
> > to remove the unused "snps,dw-apb-gpio-port" https://lkml.org/lkml/2020/10/14/1186
> > But this will break Older DT + new kernel with fw_devlink on. Which solution
> > is better?
> >
> > If the following patch is acceptable, I can submit it once 5.10-rc1 is out.
> >
> > thanks
> >
> > diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
> > index 1d8d55bd63aa..b8e012e48b59 100644
> > --- a/drivers/gpio/gpio-dwapb.c
> > +++ b/drivers/gpio/gpio-dwapb.c
> > @@ -19,6 +19,7 @@
> >  #include <linux/of_address.h>
> >  #include <linux/of_device.h>
> >  #include <linux/of_irq.h>
> > +#include <linux/of_platform.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/property.h>
> >  #include <linux/reset.h>
> > @@ -694,6 +695,10 @@ static int dwapb_gpio_probe(struct platform_device *pdev)
> >         }
> >         platform_set_drvdata(pdev, gpio);
> >
> > +       err = devm_of_platform_populate(dev);
> > +       if (err)
> > +               goto out_unregister;
> > +
> >         return 0;
> >
> >  out_unregister:
> > @@ -820,6 +825,25 @@ static struct platform_driver dwapb_gpio_driver = {
> >
> >  module_platform_driver(dwapb_gpio_driver);
> >
> > +static const struct of_device_id dwapb_port_of_match[] = {
> > +       { .compatible = "snps,dw-apb-gpio-port" },
> > +       { /* Sentinel */ }
> > +};
> > +
> > +static int dwapb_gpio_port_probe(struct platform_device *pdev)
> > +{
> > +       return 0;  
> 
> No, I'm not asking to do a stub/dummy probe. Move the stuff you do
> inside device_for_each_child_node{} and dwapb_gpio_add_port() into
> this probe function. Those two pieces of code together are effectively
> "probing" a separate gpio controller for each of the child nodes. So
> just create a real struct device (like we do for every other
> "compatible" DT node) and probe each of them properly using the device
> driver core.

Then I believe the modifications are non-trivial. Maybe Linus and Rob
can comment which way is better, fix the dts or modify the gpio-dwapb.c.
Personally, I prefer fixing dts, because this doesn't remove or modify
any used properties or compatible string, it just removes the unused
compatible string.

Thanks


> 
> > +}
> > +
> > +static struct platform_driver dwapb_gpio_port_driver = {
> > +       .driver         = {
> > +               .name   = "gpio-dwapb-port",
> > +               .of_match_table = dwapb_port_of_match,
> > +       },
> > +       .probe          = dwapb_gpio_port_probe,
> > +};
> > +module_platform_driver(dwapb_gpio_port_driver);
> > +
> >  MODULE_LICENSE("GPL");
> >  MODULE_AUTHOR("Jamie Iles");
> >  MODULE_DESCRIPTION("Synopsys DesignWare APB GPIO driver");
> >  

