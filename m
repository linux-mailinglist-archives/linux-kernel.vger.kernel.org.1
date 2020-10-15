Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDB8728EEC2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 10:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388393AbgJOIsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 04:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388282AbgJOIsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 04:48:50 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633BEC061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 01:48:50 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id d15so1603042ybl.10
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 01:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OCGpkfyXT7lalrSxx6+zXRftdaVMIWoaY7ihJlTQLBI=;
        b=Xw6YPMFSfKyv8GbppbQLPH1uhiSuiI0YHWUGxoVSB0YeYm6wzEUG7H8CnEvj5yCdrB
         P11/KyDp+DQtqqZMq7+peIkEZbViFdaTZuRYvMzqh2dBMa0ZvmbeANp9myWDwxssmsAF
         bjMRUQM0K3elK3DkMFQUOts+q8ySjqWWTzpPaEY7naWyxXP3UNQM3Zl36Zs5gY+OzVnA
         f9dlMkhEkdPB54jiImjHbKLKP034vUaqZQMaG6GOiCOocW7D81JmirEcDaURUk981ihS
         DrdaxZ+b5sWJwz9TgFm0pf7II2wbLM4cnn6Qh2SSKYlRqpGuOBP8noHXVt2Cq7DG4BEP
         me9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OCGpkfyXT7lalrSxx6+zXRftdaVMIWoaY7ihJlTQLBI=;
        b=JAGq4T67cvwFr/Y8AdlwlQdLCREaW76k28m3A+OdhCMS7d4UBSVddY0EAdBdvjaRLT
         I3PnPmf0t4nluPwk8dC9Dy4mhtM6UnGX5hAO8sB1baqTltMHyAzt+OZBESiCXCGruhzj
         bRHhSmM0dNSJYxhzEmgB5q7X0R55vvuAPF6cD4D1Poq9apoPyQj9pgcUA8U8YbnLnUay
         VNQHqRadkLc8C+f7g9EEeQjzk2LBJlIN5Y/CjWgh4oejb7lPOA1B3vMkQRy5yFGKI70p
         4nRGgDWF+MoOC3Ruf6esI1tsAsGGogajQ/VR861ANTZRWqQqUwoL/7anC3bqwvDIvV/J
         Y6Pw==
X-Gm-Message-State: AOAM530ZpihSYHWJBiJyJEf6eQC0Nx/ONkLAa5nBiJjZ2xoWB4UEBVNn
        0g0xA8EQ+v3a44Af8WNZDjRFXLWAeYbwaAfm/kkCKHc+NvqzhipN
X-Google-Smtp-Source: ABdhPJzWywG9BWdJEo12OJvVtmVGYe0NCflxSGAea2GAb9mDuTV1WWKwEr9Fioor3y0HP+FfaILfGYHL43eOiGLoQvg=
X-Received: by 2002:a25:c512:: with SMTP id v18mr4143059ybe.20.1602751729239;
 Thu, 15 Oct 2020 01:48:49 -0700 (PDT)
MIME-Version: 1.0
References: <20201014191235.7f71fcb4@xhacker.debian> <CAGETcx9PiX==mLxB9PO8Myyk6u2vhPVwTMsA5NkD-ywH5xhusw@mail.gmail.com>
 <20201015120206.41b6a454@xhacker.debian> <CAGETcx_jzF_iV5oJQ8BuDBu0b5Z8G=uL0DhA4uS5U9XLuYryjg@mail.gmail.com>
 <20201015161455.744d5041@xhacker.debian>
In-Reply-To: <20201015161455.744d5041@xhacker.debian>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 15 Oct 2020 01:48:13 -0700
Message-ID: <CAGETcx_hORWf2HkcUP=Dj6noCUsbj9KsycZ-Hr80BUOwyZaQBg@mail.gmail.com>
Subject: Re: fw_devlink on will break all snps,dw-apb-gpio users
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15, 2020 at 1:15 AM Jisheng Zhang
<Jisheng.Zhang@synaptics.com> wrote:
>
> On Wed, 14 Oct 2020 22:04:24 -0700 Saravana Kannan wrote:
>
> >
> >
> > On Wed, Oct 14, 2020 at 9:02 PM Jisheng Zhang
> > <Jisheng.Zhang@synaptics.com> wrote:
> > >
> > > On Wed, 14 Oct 2020 10:29:36 -0700
> > > Saravana Kannan <saravanak@google.com> wrote:
> > >
> > > >
> > > >
> > > > On Wed, Oct 14, 2020 at 4:12 AM Jisheng Zhang
> > > > <Jisheng.Zhang@synaptics.com> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > If set fw_devlink as on, any consumers of dw apb gpio won't probe.
> > > > >
> > > > > The related dts looks like:
> > > > >
> > > > > gpio0: gpio@2400 {
> > > > >        compatible = "snps,dw-apb-gpio";
> > > > >        #address-cells = <1>;
> > > > >        #size-cells = <0>;
> > > > >
> > > > >        porta: gpio-port@0 {
> > > > >               compatible = "snps,dw-apb-gpio-port";
> > > > >               gpio-controller;
> > > > >               #gpio-cells = <2>;
> > > > >               ngpios = <32>;
> > > > >               reg = <0>;
> > > > >        };
> > > > > };
> > > > >
> > > > > device_foo {
> > > > >         status = "okay"
> > > > >         ...;
> > > > >         reset-gpio = <&porta, 0, GPIO_ACTIVE_HIGH>;
> > > > > };
> > > > >
> > > > > If I change the reset-gpio property to use another kind of gpio phandle,
> > > > > e.g gpio expander, then device_foo can be probed successfully.
> > > > >
> > > > > The gpio expander dt node looks like:
> > > > >
> > > > >         expander3: gpio@44 {
> > > > >                 compatible = "fcs,fxl6408";
> > > > >                 pinctrl-names = "default";
> > > > >                 pinctrl-0 = <&expander3_pmux>;
> > > > >                 reg = <0x44>;
> > > > >                 gpio-controller;
> > > > >                 #gpio-cells = <2>;
> > > > >                 interrupt-parent = <&portb>;
> > > > >                 interrupts = <23 IRQ_TYPE_NONE>;
> > > > >                 interrupt-controller;
> > > > >                 #interrupt-cells = <2>;
> > > > >         };
> > > > >
> > > > > The common pattern looks like the devlink can't cope with suppliers from
> > > > > child dt node.
> > > >
> > > > fw_devlink doesn't have any problem dealing with child devices being
> > > > suppliers. The problem with your case is that the
> > > > drivers/gpio/gpio-dwapb.c driver directly parses the child nodes and
> > > > never creates struct devices for them. If you have a node with
> > > > compatible string, fw_devlink expects you to create and probe a struct
> > > > device for it. So change your driver to add the child devices as
> > > > devices instead of just parsing the node directly and doing stuff with
> > > > it.
> > > >
> > > > Either that, or stop putting "compatible" string in a node if you
> > > > don't plan to actually treat it as a device -- but that's too late for
> > > > this driver (it needs to be backward compatible). So change the driver
> > > > to add of_platform_populate() and write a driver that probes
> > > > "snps,dw-apb-gpio-port".
> > > >
> > >
> > > Thanks for the information. The "snps,dw-apb-gpio-port" is never used,
> > > so I just sent out a series to remove it.
> >
> > I'd actually prefer that you fix the kernel code to actually use it.
> > So that fw_devlink can be backward compatible (Older DT + new kernel).
> > The change is pretty trivial (I just have time to do it for you).
> >
>
> I agree the change is trivial, but it will add some useless LoCs like below.

It's not useless if it preserves backward compatibility with DT.

> I'm not sure whether this is acceptable.So add GPIO and DT maintainers to comment.
>
> Hi Linus, Rob,
>
> Could you please comment? A simple introduction of the problem:
>
> As pointed out by Saravana, "gpio-dwapb.c driver directly parses the child
> nodes and never creates struct devices for them. If you have a node with
> compatible string, fw_devlink expects you to create and probe a struct
> device for it", so once we set fw_devlink=on, then any users of gpio-dwapb
> as below won't be probed.
>
> device_foo {
>          status = "okay"
>          ...;
>          reset-gpio = <&porta, 0, GPIO_ACTIVE_HIGH>;
> };
>
> The compatible string "snps,dw-apb-gpio-port" is never used, but it's in
> the dt-binding since the dw gpio mainlined. I believe the every dw apb
> users just copy the compatible string in to soc dtsi. So I submit a series
> to remove the unused "snps,dw-apb-gpio-port" https://lkml.org/lkml/2020/10/14/1186
> But this will break Older DT + new kernel with fw_devlink on. Which solution
> is better?
>
> If the following patch is acceptable, I can submit it once 5.10-rc1 is out.
>
> thanks
>
> diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
> index 1d8d55bd63aa..b8e012e48b59 100644
> --- a/drivers/gpio/gpio-dwapb.c
> +++ b/drivers/gpio/gpio-dwapb.c
> @@ -19,6 +19,7 @@
>  #include <linux/of_address.h>
>  #include <linux/of_device.h>
>  #include <linux/of_irq.h>
> +#include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/property.h>
>  #include <linux/reset.h>
> @@ -694,6 +695,10 @@ static int dwapb_gpio_probe(struct platform_device *pdev)
>         }
>         platform_set_drvdata(pdev, gpio);
>
> +       err = devm_of_platform_populate(dev);
> +       if (err)
> +               goto out_unregister;
> +
>         return 0;
>
>  out_unregister:
> @@ -820,6 +825,25 @@ static struct platform_driver dwapb_gpio_driver = {
>
>  module_platform_driver(dwapb_gpio_driver);
>
> +static const struct of_device_id dwapb_port_of_match[] = {
> +       { .compatible = "snps,dw-apb-gpio-port" },
> +       { /* Sentinel */ }
> +};
> +
> +static int dwapb_gpio_port_probe(struct platform_device *pdev)
> +{
> +       return 0;

No, I'm not asking to do a stub/dummy probe. Move the stuff you do
inside device_for_each_child_node{} and dwapb_gpio_add_port() into
this probe function. Those two pieces of code together are effectively
"probing" a separate gpio controller for each of the child nodes. So
just create a real struct device (like we do for every other
"compatible" DT node) and probe each of them properly using the device
driver core.

-Saravana

> +}
> +
> +static struct platform_driver dwapb_gpio_port_driver = {
> +       .driver         = {
> +               .name   = "gpio-dwapb-port",
> +               .of_match_table = dwapb_port_of_match,
> +       },
> +       .probe          = dwapb_gpio_port_probe,
> +};
> +module_platform_driver(dwapb_gpio_port_driver);
> +
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Jamie Iles");
>  MODULE_DESCRIPTION("Synopsys DesignWare APB GPIO driver");
>
