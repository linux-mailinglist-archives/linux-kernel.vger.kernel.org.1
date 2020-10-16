Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5C2228FCF9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 05:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394251AbgJPDj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 23:39:56 -0400
Received: from mail-mw2nam12on2061.outbound.protection.outlook.com ([40.107.244.61]:14241
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2394231AbgJPDjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 23:39:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XYiDHtEUv0N+gfjIOt44lJnNCq3i+193QMMmdLw1Ls78IIUEzCoNSrjkqsf8FRyBcb1qgBhceAMqCF+qefTqEschU89yvk/7w8p6N7DVq8OnoPK4UKX+4RUsez1WC1EEWjxzXeNq9kkLv5zqbcjjBswR+ExmDKiYcwueQxaSyKFpqifQoqjXZTZJbEV/XLt8jJZrF+E4SlPzo7meIYfNMLvC0T8COGRN/3kq9q1P9stTxPwJReiCk3MoJ2aFcSY5Cm6WuvC3SH0F/diefwDtzmasNak1qgzD93760uxSqW09GUhQSRcwh33dWNOSHkmzmBzcm+ZGoDmYVNc4bi3olg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMxOawWcXBW87v9l7Nl3JIOW2G6hhQg1LCQo6pnWmmc=;
 b=n+XD63X5e7fibSHszVi1tIgKqyiEJpH56m61tIN72InSBIrzUHZi3lAoeF0Soe/kdh9FMEWM4L2xuuLFxduHMEp7AfYVB8sQgPI1o4RGzMT604vRTVy4v+dVO0wl5MSbOYLEnRF1VoGb1wcvLbYeTETO4dFO0CwO8ywoyKXOC9YeQp9KY0lM66MIQvDTFnumuNAM3Er46F8drZcC4xP7DX8ylfFtEOzGYKyOT7uK7AR6vRHiBBNEWHIDunSiY38t4v3XzLMOxSq2yy1z0St5KEeSnIPeUb+sIxu2uXQTdgqunsj0w3VVDfduWgNUOIBO0KZ7hWpp792T7XcEPVlmgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMxOawWcXBW87v9l7Nl3JIOW2G6hhQg1LCQo6pnWmmc=;
 b=eUJCPnfOiq3dwJkcbWkxf//uni59Zdn+ezd21mrYii6a6yC6hLXt08eX22/b3p925W3tngrwZk86FhWkGob7xPBAiKkE6ebHy4g2TCHp60gLCcj6VTXEFTfMJ6dRNBFY+MS8GpULVYZJVhYU1u0gG4vF9Eqqtis0RDfdWcvjgGk=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB4555.namprd03.prod.outlook.com (2603:10b6:5:102::17)
 by DM6PR03MB4316.namprd03.prod.outlook.com (2603:10b6:5:10a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Fri, 16 Oct
 2020 03:39:51 +0000
Received: from DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38]) by DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38%7]) with mapi id 15.20.3477.020; Fri, 16 Oct 2020
 03:39:51 +0000
Date:   Fri, 16 Oct 2020 11:39:25 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: fw_devlink on will break all snps,dw-apb-gpio users
Message-ID: <20201016113925.022b1741@xhacker.debian>
In-Reply-To: <d3e59e01-9921-5f8b-ef12-55baef420277@arm.com>
References: <20201014191235.7f71fcb4@xhacker.debian>
        <CAGETcx9PiX==mLxB9PO8Myyk6u2vhPVwTMsA5NkD-ywH5xhusw@mail.gmail.com>
        <20201015120206.41b6a454@xhacker.debian>
        <CAGETcx_jzF_iV5oJQ8BuDBu0b5Z8G=uL0DhA4uS5U9XLuYryjg@mail.gmail.com>
        <20201015161455.744d5041@xhacker.debian>
        <CAGETcx_hORWf2HkcUP=Dj6noCUsbj9KsycZ-Hr80BUOwyZaQBg@mail.gmail.com>
        <20201015175231.1a690c21@xhacker.debian>
        <d3e59e01-9921-5f8b-ef12-55baef420277@arm.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY2PR0101CA0038.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::24) To DM6PR03MB4555.namprd03.prod.outlook.com
 (2603:10b6:5:102::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (124.74.246.114) by TY2PR0101CA0038.apcprd01.prod.exchangelabs.com (2603:1096:404:8000::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21 via Frontend Transport; Fri, 16 Oct 2020 03:39:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17f5abfa-e4b8-42dd-466b-08d871852334
X-MS-TrafficTypeDiagnostic: DM6PR03MB4316:
X-Microsoft-Antispam-PRVS: <DM6PR03MB431667F20D8B2755186EBA08ED030@DM6PR03MB4316.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CVEkpr4OwHM93zA3giGQmR0ydTUqBgMFjDzg0ktHvnV9g4/6l6FdqHW6m6BRQrE3ZgD66kpjJRX4V948dwthtU2ZZNvGmtsNWyKWLP8TWE3IESw+pRxe11nEe6jewnt4C6YFSzr/krzLmJtiPGIG/CMEvjW9RYUSocURW9k35Qe3Dl1bqsONPpLKaiA+zcjy1FJQ0u9lzE0Kk+BHld+kmASK/oWCABYjiAdLzurD7b0I+FAK+3+0cGRvjaBDYyfRuIo3kTdMogfNgS5hCuADMksD05DurGTvv8YZIKN4nKD7rPs3Kt6vl+A0R2ZluevXVqglJKlnQLte2btQx7541NZR87gn2aefUX73SYqbqIqlX8tlRdkHorTHuajL40yCS3UhKmfi6GoxrKXi3h3j7jWX0bojUfu0G1a0HDhm+Cdmt/lHugujxBwoklAJWHmU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4555.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(366004)(136003)(39860400002)(4326008)(8676002)(2906002)(6916009)(55016002)(52116002)(1076003)(16526019)(186003)(83380400001)(6666004)(7696005)(6506007)(7416002)(34490700002)(54906003)(316002)(956004)(86362001)(26005)(5660300002)(53546011)(9686003)(66946007)(4001150100001)(66556008)(478600001)(8936002)(66476007)(26730200005)(19860200003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: mMK3+NZMX0KPVJlFY8iPT1HO+Y1l9iTIwdTBR1Zx7rJWTJldbvSjx9Grx0NC63E6Xb0LhyO4+3Ylrl6/4r1Bcrja1PoSiz/VtJkfaZuKZX88YmAphYqv9Td3okv00ACcAd+Ji5ThxSOtI9JqZqs4N1W3K4lFkBrJMdKKZ/PSWhaupts9DEevSuXtLTKuJRAfU6vbKKlSDUHwKN5ABAurATtWsOI2SV1Igj0poXreqL4uKGJ8Ev873tKCYjSxvQDbNGeE/zi05HKuch4qkUmD7kqqrOXCQWqkiSw7KiNNpPI/WuNVSPYNa9EXaBVy5/5kX4fmHMDI+jAhMTeu9qZBQqXJvlQ6tuaaIG/K55DWOf0jvjBOWY2BMACIyHT78FZ0n3otDWBgZnHxj48ZaMyK9TcG+/1EzMzm6fKB31EzU08v6rLlnH7wSR/ByTUZh0cSrOqfE6qrCKt27syFrjNcBgT06kLaAd+stlxW2YuY+YiLUvCaIJO9KzmlDY4gH1lJfZywrDWtpjNh/3/Um3c3KR1tROOhlaB8f5uMTvB389zu88kjex7ifVsCCPEV237Go54kyufC24+eqtotFKP46EdRKfvMRGxuTe3SocO1CKiu1Cg68g6yCF6SVuP6DY1ovcqSXtBXQHfX/bn8r6EH5Q==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17f5abfa-e4b8-42dd-466b-08d871852334
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB4555.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 03:39:51.1820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QpjMsTlcvanTGlBrcngNKN+Qp1coJRLQKQboJR2xgJPyMFNZbtR/XXywuYN42mOBycCmplXi5d39hR1zdKyB/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4316
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Oct 2020 15:08:33 +0100
Robin Murphy <robin.murphy@arm.com> wrote:

> 
> 
> On 2020-10-15 10:52, Jisheng Zhang wrote:
> > On Thu, 15 Oct 2020 01:48:13 -0700
> > Saravana Kannan <saravanak@google.com> wrote:
> >  
> >> On Thu, Oct 15, 2020 at 1:15 AM Jisheng Zhang
> >> <Jisheng.Zhang@synaptics.com> wrote:  
> >>>
> >>> On Wed, 14 Oct 2020 22:04:24 -0700 Saravana Kannan wrote:
> >>>  
> >>>>
> >>>>
> >>>> On Wed, Oct 14, 2020 at 9:02 PM Jisheng Zhang
> >>>> <Jisheng.Zhang@synaptics.com> wrote:  
> >>>>>
> >>>>> On Wed, 14 Oct 2020 10:29:36 -0700
> >>>>> Saravana Kannan <saravanak@google.com> wrote:
> >>>>>  
> >>>>>>
> >>>>>>
> >>>>>> On Wed, Oct 14, 2020 at 4:12 AM Jisheng Zhang
> >>>>>> <Jisheng.Zhang@synaptics.com> wrote:  
> >>>>>>>
> >>>>>>> Hi,
> >>>>>>>
> >>>>>>> If set fw_devlink as on, any consumers of dw apb gpio won't probe.
> >>>>>>>
> >>>>>>> The related dts looks like:
> >>>>>>>
> >>>>>>> gpio0: gpio@2400 {
> >>>>>>>         compatible = "snps,dw-apb-gpio";
> >>>>>>>         #address-cells = <1>;
> >>>>>>>         #size-cells = <0>;
> >>>>>>>
> >>>>>>>         porta: gpio-port@0 {
> >>>>>>>                compatible = "snps,dw-apb-gpio-port";
> >>>>>>>                gpio-controller;
> >>>>>>>                #gpio-cells = <2>;
> >>>>>>>                ngpios = <32>;
> >>>>>>>                reg = <0>;
> >>>>>>>         };
> >>>>>>> };
> >>>>>>>
> >>>>>>> device_foo {
> >>>>>>>          status = "okay"
> >>>>>>>          ...;
> >>>>>>>          reset-gpio = <&porta, 0, GPIO_ACTIVE_HIGH>;
> >>>>>>> };
> >>>>>>>
> >>>>>>> If I change the reset-gpio property to use another kind of gpio phandle,
> >>>>>>> e.g gpio expander, then device_foo can be probed successfully.
> >>>>>>>
> >>>>>>> The gpio expander dt node looks like:
> >>>>>>>
> >>>>>>>          expander3: gpio@44 {
> >>>>>>>                  compatible = "fcs,fxl6408";
> >>>>>>>                  pinctrl-names = "default";
> >>>>>>>                  pinctrl-0 = <&expander3_pmux>;
> >>>>>>>                  reg = <0x44>;
> >>>>>>>                  gpio-controller;
> >>>>>>>                  #gpio-cells = <2>;
> >>>>>>>                  interrupt-parent = <&portb>;
> >>>>>>>                  interrupts = <23 IRQ_TYPE_NONE>;
> >>>>>>>                  interrupt-controller;
> >>>>>>>                  #interrupt-cells = <2>;
> >>>>>>>          };
> >>>>>>>
> >>>>>>> The common pattern looks like the devlink can't cope with suppliers from
> >>>>>>> child dt node.  
> >>>>>>
> >>>>>> fw_devlink doesn't have any problem dealing with child devices being
> >>>>>> suppliers. The problem with your case is that the
> >>>>>> drivers/gpio/gpio-dwapb.c driver directly parses the child nodes and
> >>>>>> never creates struct devices for them. If you have a node with
> >>>>>> compatible string, fw_devlink expects you to create and probe a struct
> >>>>>> device for it. So change your driver to add the child devices as
> >>>>>> devices instead of just parsing the node directly and doing stuff with
> >>>>>> it.
> >>>>>>
> >>>>>> Either that, or stop putting "compatible" string in a node if you
> >>>>>> don't plan to actually treat it as a device -- but that's too late for
> >>>>>> this driver (it needs to be backward compatible). So change the driver
> >>>>>> to add of_platform_populate() and write a driver that probes
> >>>>>> "snps,dw-apb-gpio-port".
> >>>>>>  
> >>>>>
> >>>>> Thanks for the information. The "snps,dw-apb-gpio-port" is never used,
> >>>>> so I just sent out a series to remove it.  
> >>>>
> >>>> I'd actually prefer that you fix the kernel code to actually use it.
> >>>> So that fw_devlink can be backward compatible (Older DT + new kernel).
> >>>> The change is pretty trivial (I just have time to do it for you).
> >>>>  
> >>>
> >>> I agree the change is trivial, but it will add some useless LoCs like below.  
> >>
> >> It's not useless if it preserves backward compatibility with DT.
> >>  
> >>> I'm not sure whether this is acceptable.So add GPIO and DT maintainers to comment.
> >>>
> >>> Hi Linus, Rob,
> >>>
> >>> Could you please comment? A simple introduction of the problem:
> >>>
> >>> As pointed out by Saravana, "gpio-dwapb.c driver directly parses the child
> >>> nodes and never creates struct devices for them. If you have a node with
> >>> compatible string, fw_devlink expects you to create and probe a struct
> >>> device for it", so once we set fw_devlink=on, then any users of gpio-dwapb
> >>> as below won't be probed.
> >>>
> >>> device_foo {
> >>>           status = "okay"
> >>>           ...;
> >>>           reset-gpio = <&porta, 0, GPIO_ACTIVE_HIGH>;
> >>> };
> >>>
> >>> The compatible string "snps,dw-apb-gpio-port" is never used, but it's in
> >>> the dt-binding since the dw gpio mainlined. I believe the every dw apb
> >>> users just copy the compatible string in to soc dtsi. So I submit a series
> >>> to remove the unused "snps,dw-apb-gpio-port" 
> >>> But this will break Older DT + new kernel with fw_devlink on. Which solution
> >>> is better?
> >>>
> >>> If the following patch is acceptable, I can submit it once 5.10-rc1 is out.
> >>>
> >>> thanks
> >>>
> >>> diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
> >>> index 1d8d55bd63aa..b8e012e48b59 100644
> >>> --- a/drivers/gpio/gpio-dwapb.c
> >>> +++ b/drivers/gpio/gpio-dwapb.c
> >>> @@ -19,6 +19,7 @@
> >>>   #include <linux/of_address.h>
> >>>   #include <linux/of_device.h>
> >>>   #include <linux/of_irq.h>
> >>> +#include <linux/of_platform.h>
> >>>   #include <linux/platform_device.h>
> >>>   #include <linux/property.h>
> >>>   #include <linux/reset.h>
> >>> @@ -694,6 +695,10 @@ static int dwapb_gpio_probe(struct platform_device *pdev)
> >>>          }
> >>>          platform_set_drvdata(pdev, gpio);
> >>>
> >>> +       err = devm_of_platform_populate(dev);
> >>> +       if (err)
> >>> +               goto out_unregister;
> >>> +
> >>>          return 0;
> >>>
> >>>   out_unregister:
> >>> @@ -820,6 +825,25 @@ static struct platform_driver dwapb_gpio_driver = {
> >>>
> >>>   module_platform_driver(dwapb_gpio_driver);
> >>>
> >>> +static const struct of_device_id dwapb_port_of_match[] = {
> >>> +       { .compatible = "snps,dw-apb-gpio-port" },
> >>> +       { /* Sentinel */ }
> >>> +};
> >>> +
> >>> +static int dwapb_gpio_port_probe(struct platform_device *pdev)
> >>> +{
> >>> +       return 0;  
> >>
> >> No, I'm not asking to do a stub/dummy probe. Move the stuff you do
> >> inside device_for_each_child_node{} and dwapb_gpio_add_port() into
> >> this probe function. Those two pieces of code together are effectively
> >> "probing" a separate gpio controller for each of the child nodes. So
> >> just create a real struct device (like we do for every other
> >> "compatible" DT node) and probe each of them properly using the device
> >> driver core.  
> >
> > Then I believe the modifications are non-trivial. Maybe Linus and Rob
> > can comment which way is better, fix the dts or modify the gpio-dwapb.c.
> > Personally, I prefer fixing dts, because this doesn't remove or modify
> > any used properties or compatible string, it just removes the unused
> > compatible string.  
> 
> You appear to be assuming that:
> 
> A) There a no consumers of DTBs and DT bindings other than Linux.
> B) No Linux user ever updates their kernel image without also updating
> their DTB.
> 
> I can assure you that, in general, neither of those hold true. Hacking

Just my humble opinion, this is fixing rather than hacking DTs.

> DTs to work around internal implementation details in Linux is rarely if
> ever a good or even viable idea.
> 

I got your opinion. So it looks like modify the dwapb gpio driver is
avoidable. I will submit patch to do so once 5.10-rc1 is out.

But the device link also introduces below warning for all dw-apb-gpio users:

[    0.016113] OF: /soc/apb@f7e80000/gpio@0800/gpio-port@1: could not find phandle
[    0.016197] OF: /soc/apb@f7e80000/gpio@0c00/gpio-port@1: could not find phandle
[    0.016464] OF: /soc/apb@f7e80000/gpio@2400/gpio-port@0: could not find phandle
[    0.016697] OF: /soc/apb@f7fc0000/gpio@8000/gpio-port@4: could not find phandle
[    0.017054] OF: /soc/apb@f7e80000/gpio@0800/gpio-port@1: could not find phandle
[    0.017128] OF: /soc/apb@f7e80000/gpio@0c00/gpio-port@1: could not find phandle

Previously, it seems that the solution would be

    "let's mark the "snps,nr-gpios" property as
    deprecated and add the generic "ngpios" property support with the same
    purpose as the deprecated one. That and the errors log above shall
    motivate the platform developer to *convert* the DW APB GPIO DT-nodes to
    using the standard number of GPIOs property"

as commit 7569486d79ae8ec4 ("gpio: dwapb: Add ngpios DT-property support")
said, the "can't break old DTs" also apply here, it means we need to fix
the warning in device link code rather than fix DTs. Any comments?

Thanks
