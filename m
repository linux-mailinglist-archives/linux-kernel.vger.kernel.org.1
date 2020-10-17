Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B86290F4C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 07:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411761AbgJQFeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 01:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411737AbgJQFem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 01:34:42 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02EC6C0613E7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 17:44:45 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id h9so3370358ybm.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 17:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=veccH1mLMk3vQeGZCIquG54FNKIqePqehqjlTSWaSIY=;
        b=FpdE3iQBzefbFMgkHZ61rAB00FZdRz+2WJVaSv3eMajM+LE8yNA8glNVqHsvnJvtFO
         J/nEjMIQadx7mN3otZiJ4a8yDR0rsGXoH5MnZ6Z6wnCA4WCapDSKsPiYc9KsiVOjrTKq
         2xAx+Dcjf3MfAjbzjPL0b8xg3EvivKkm5oDzbRdXYMdcUKIskxHw0AN3lxrb6KSwoNFS
         /QbuKKg75u/hK0aO3ly/nm9285fBj2hwNW146eYD364c9DMa3fSreaN+sLMZT7rD1hIv
         NeMAG8B65LLQLEbi58pq7s8ZiMhDgQwT3rlo8ILQMP4yX+9RUcUTz2BC2X6+RN5ceGYB
         6ofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=veccH1mLMk3vQeGZCIquG54FNKIqePqehqjlTSWaSIY=;
        b=HFahDXaAcVt9l32xegR5bJ+3ZLcOlLoctSaXqwW5VSFusVfzSIKb6SBndzMEwHBnig
         KK1Foa+N0kjMzxIP4LgGIbVxfWM8GZAOytbyASn6C+jHL+ZReXzB1b2NRV9YJGa2sHfp
         b3EghNE31VkDL5LNpK81qyyoFW0dRlP0xBvxg3o2VBtF3aUHUk5EA3yADFDWt6UxT+M7
         zEOqAkl86M1XGTpqHbc4wwjOqa0T/Thx/aixKKK8V3moXov+0ZW477IGDP63mnrJCsP2
         sEexrQ2imCFI4myPySpFIaxzVAzFfGKqMMFh5WNn4R3Uok8igsuE5wZo/pcwZ7moeIGL
         yKaA==
X-Gm-Message-State: AOAM530EbwAXwVzJIuNKLMQPndGx0sfTnxsZcv2I32WIqN70aNqt96pv
        kaT/93W6Zj/t7hfjzyRY8e8LAVoFjVSBALx5EkVJDQ==
X-Google-Smtp-Source: ABdhPJw/bvPTo8B6/R8m8De2FiPrOZ30WER7f8PvbqjcM0FmumZEUDFYhTt2i88NfOn6gm3Hx7h9I96yBJnF0lj69eU=
X-Received: by 2002:a25:d08e:: with SMTP id h136mr8050767ybg.20.1602895484645;
 Fri, 16 Oct 2020 17:44:44 -0700 (PDT)
MIME-Version: 1.0
References: <20201014191235.7f71fcb4@xhacker.debian> <CAGETcx9PiX==mLxB9PO8Myyk6u2vhPVwTMsA5NkD-ywH5xhusw@mail.gmail.com>
 <20201015120206.41b6a454@xhacker.debian> <CAGETcx_jzF_iV5oJQ8BuDBu0b5Z8G=uL0DhA4uS5U9XLuYryjg@mail.gmail.com>
 <20201015161455.744d5041@xhacker.debian> <CAGETcx_hORWf2HkcUP=Dj6noCUsbj9KsycZ-Hr80BUOwyZaQBg@mail.gmail.com>
 <20201015175231.1a690c21@xhacker.debian> <d3e59e01-9921-5f8b-ef12-55baef420277@arm.com>
 <20201016113925.022b1741@xhacker.debian>
In-Reply-To: <20201016113925.022b1741@xhacker.debian>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 16 Oct 2020 17:44:08 -0700
Message-ID: <CAGETcx9jCN8H1Sfuhz5F9bgNbb1V7AHpThjaxRLOEcZf+JKcbw@mail.gmail.com>
Subject: Re: fw_devlink on will break all snps,dw-apb-gpio users
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15, 2020 at 8:39 PM Jisheng Zhang
<Jisheng.Zhang@synaptics.com> wrote:
>
> On Thu, 15 Oct 2020 15:08:33 +0100
> Robin Murphy <robin.murphy@arm.com> wrote:
>
> >
> >
> > On 2020-10-15 10:52, Jisheng Zhang wrote:
> > > On Thu, 15 Oct 2020 01:48:13 -0700
> > > Saravana Kannan <saravanak@google.com> wrote:
> > >
> > >> On Thu, Oct 15, 2020 at 1:15 AM Jisheng Zhang
> > >> <Jisheng.Zhang@synaptics.com> wrote:
> > >>>
> > >>> On Wed, 14 Oct 2020 22:04:24 -0700 Saravana Kannan wrote:
> > >>>
> > >>>>
> > >>>>
> > >>>> On Wed, Oct 14, 2020 at 9:02 PM Jisheng Zhang
> > >>>> <Jisheng.Zhang@synaptics.com> wrote:
> > >>>>>
> > >>>>> On Wed, 14 Oct 2020 10:29:36 -0700
> > >>>>> Saravana Kannan <saravanak@google.com> wrote:
> > >>>>>
> > >>>>>>
> > >>>>>>
> > >>>>>> On Wed, Oct 14, 2020 at 4:12 AM Jisheng Zhang
> > >>>>>> <Jisheng.Zhang@synaptics.com> wrote:
> > >>>>>>>
> > >>>>>>> Hi,
> > >>>>>>>
> > >>>>>>> If set fw_devlink as on, any consumers of dw apb gpio won't probe.
> > >>>>>>>
> > >>>>>>> The related dts looks like:
> > >>>>>>>
> > >>>>>>> gpio0: gpio@2400 {
> > >>>>>>>         compatible = "snps,dw-apb-gpio";
> > >>>>>>>         #address-cells = <1>;
> > >>>>>>>         #size-cells = <0>;
> > >>>>>>>
> > >>>>>>>         porta: gpio-port@0 {
> > >>>>>>>                compatible = "snps,dw-apb-gpio-port";
> > >>>>>>>                gpio-controller;
> > >>>>>>>                #gpio-cells = <2>;
> > >>>>>>>                ngpios = <32>;
> > >>>>>>>                reg = <0>;
> > >>>>>>>         };
> > >>>>>>> };
> > >>>>>>>
> > >>>>>>> device_foo {
> > >>>>>>>          status = "okay"
> > >>>>>>>          ...;
> > >>>>>>>          reset-gpio = <&porta, 0, GPIO_ACTIVE_HIGH>;
> > >>>>>>> };
> > >>>>>>>
> > >>>>>>> If I change the reset-gpio property to use another kind of gpio phandle,
> > >>>>>>> e.g gpio expander, then device_foo can be probed successfully.
> > >>>>>>>
> > >>>>>>> The gpio expander dt node looks like:
> > >>>>>>>
> > >>>>>>>          expander3: gpio@44 {
> > >>>>>>>                  compatible = "fcs,fxl6408";
> > >>>>>>>                  pinctrl-names = "default";
> > >>>>>>>                  pinctrl-0 = <&expander3_pmux>;
> > >>>>>>>                  reg = <0x44>;
> > >>>>>>>                  gpio-controller;
> > >>>>>>>                  #gpio-cells = <2>;
> > >>>>>>>                  interrupt-parent = <&portb>;
> > >>>>>>>                  interrupts = <23 IRQ_TYPE_NONE>;
> > >>>>>>>                  interrupt-controller;
> > >>>>>>>                  #interrupt-cells = <2>;
> > >>>>>>>          };
> > >>>>>>>
> > >>>>>>> The common pattern looks like the devlink can't cope with suppliers from
> > >>>>>>> child dt node.
> > >>>>>>
> > >>>>>> fw_devlink doesn't have any problem dealing with child devices being
> > >>>>>> suppliers. The problem with your case is that the
> > >>>>>> drivers/gpio/gpio-dwapb.c driver directly parses the child nodes and
> > >>>>>> never creates struct devices for them. If you have a node with
> > >>>>>> compatible string, fw_devlink expects you to create and probe a struct
> > >>>>>> device for it. So change your driver to add the child devices as
> > >>>>>> devices instead of just parsing the node directly and doing stuff with
> > >>>>>> it.
> > >>>>>>
> > >>>>>> Either that, or stop putting "compatible" string in a node if you
> > >>>>>> don't plan to actually treat it as a device -- but that's too late for
> > >>>>>> this driver (it needs to be backward compatible). So change the driver
> > >>>>>> to add of_platform_populate() and write a driver that probes
> > >>>>>> "snps,dw-apb-gpio-port".
> > >>>>>>
> > >>>>>
> > >>>>> Thanks for the information. The "snps,dw-apb-gpio-port" is never used,
> > >>>>> so I just sent out a series to remove it.
> > >>>>
> > >>>> I'd actually prefer that you fix the kernel code to actually use it.
> > >>>> So that fw_devlink can be backward compatible (Older DT + new kernel).
> > >>>> The change is pretty trivial (I just have time to do it for you).
> > >>>>
> > >>>
> > >>> I agree the change is trivial, but it will add some useless LoCs like below.
> > >>
> > >> It's not useless if it preserves backward compatibility with DT.
> > >>
> > >>> I'm not sure whether this is acceptable.So add GPIO and DT maintainers to comment.
> > >>>
> > >>> Hi Linus, Rob,
> > >>>
> > >>> Could you please comment? A simple introduction of the problem:
> > >>>
> > >>> As pointed out by Saravana, "gpio-dwapb.c driver directly parses the child
> > >>> nodes and never creates struct devices for them. If you have a node with
> > >>> compatible string, fw_devlink expects you to create and probe a struct
> > >>> device for it", so once we set fw_devlink=on, then any users of gpio-dwapb
> > >>> as below won't be probed.
> > >>>
> > >>> device_foo {
> > >>>           status = "okay"
> > >>>           ...;
> > >>>           reset-gpio = <&porta, 0, GPIO_ACTIVE_HIGH>;
> > >>> };
> > >>>
> > >>> The compatible string "snps,dw-apb-gpio-port" is never used, but it's in
> > >>> the dt-binding since the dw gpio mainlined. I believe the every dw apb
> > >>> users just copy the compatible string in to soc dtsi. So I submit a series
> > >>> to remove the unused "snps,dw-apb-gpio-port"
> > >>> But this will break Older DT + new kernel with fw_devlink on. Which solution
> > >>> is better?
> > >>>
> > >>> If the following patch is acceptable, I can submit it once 5.10-rc1 is out.
> > >>>
> > >>> thanks
> > >>>
> > >>> diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
> > >>> index 1d8d55bd63aa..b8e012e48b59 100644
> > >>> --- a/drivers/gpio/gpio-dwapb.c
> > >>> +++ b/drivers/gpio/gpio-dwapb.c
> > >>> @@ -19,6 +19,7 @@
> > >>>   #include <linux/of_address.h>
> > >>>   #include <linux/of_device.h>
> > >>>   #include <linux/of_irq.h>
> > >>> +#include <linux/of_platform.h>
> > >>>   #include <linux/platform_device.h>
> > >>>   #include <linux/property.h>
> > >>>   #include <linux/reset.h>
> > >>> @@ -694,6 +695,10 @@ static int dwapb_gpio_probe(struct platform_device *pdev)
> > >>>          }
> > >>>          platform_set_drvdata(pdev, gpio);
> > >>>
> > >>> +       err = devm_of_platform_populate(dev);
> > >>> +       if (err)
> > >>> +               goto out_unregister;
> > >>> +
> > >>>          return 0;
> > >>>
> > >>>   out_unregister:
> > >>> @@ -820,6 +825,25 @@ static struct platform_driver dwapb_gpio_driver = {
> > >>>
> > >>>   module_platform_driver(dwapb_gpio_driver);
> > >>>
> > >>> +static const struct of_device_id dwapb_port_of_match[] = {
> > >>> +       { .compatible = "snps,dw-apb-gpio-port" },
> > >>> +       { /* Sentinel */ }
> > >>> +};
> > >>> +
> > >>> +static int dwapb_gpio_port_probe(struct platform_device *pdev)
> > >>> +{
> > >>> +       return 0;
> > >>
> > >> No, I'm not asking to do a stub/dummy probe. Move the stuff you do
> > >> inside device_for_each_child_node{} and dwapb_gpio_add_port() into
> > >> this probe function. Those two pieces of code together are effectively
> > >> "probing" a separate gpio controller for each of the child nodes. So
> > >> just create a real struct device (like we do for every other
> > >> "compatible" DT node) and probe each of them properly using the device
> > >> driver core.
> > >
> > > Then I believe the modifications are non-trivial. Maybe Linus and Rob
> > > can comment which way is better, fix the dts or modify the gpio-dwapb.c.
> > > Personally, I prefer fixing dts, because this doesn't remove or modify
> > > any used properties or compatible string, it just removes the unused
> > > compatible string.
> >
> > You appear to be assuming that:
> >
> > A) There a no consumers of DTBs and DT bindings other than Linux.
> > B) No Linux user ever updates their kernel image without also updating
> > their DTB.
> >
> > I can assure you that, in general, neither of those hold true. Hacking
>
> Just my humble opinion, this is fixing rather than hacking DTs.
>
> > DTs to work around internal implementation details in Linux is rarely if
> > ever a good or even viable idea.
> >
>
> I got your opinion. So it looks like modify the dwapb gpio driver is
> avoidable. I will submit patch to do so once 5.10-rc1 is out.
>
> But the device link also introduces below warning for all dw-apb-gpio users:
>
> [    0.016113] OF: /soc/apb@f7e80000/gpio@0800/gpio-port@1: could not find phandle
> [    0.016197] OF: /soc/apb@f7e80000/gpio@0c00/gpio-port@1: could not find phandle
> [    0.016464] OF: /soc/apb@f7e80000/gpio@2400/gpio-port@0: could not find phandle
> [    0.016697] OF: /soc/apb@f7fc0000/gpio@8000/gpio-port@4: could not find phandle
> [    0.017054] OF: /soc/apb@f7e80000/gpio@0800/gpio-port@1: could not find phandle
> [    0.017128] OF: /soc/apb@f7e80000/gpio@0c00/gpio-port@1: could not find phandle

To clarify, this warning doesn't break any functionality. It's just
fw_devlink not being happy that a property ends in -gpios but doesn't
follow the -gpios format.

You can do both of these then?
1. Update the dwapb gpiodriver so that the older DT still works.

2. Update the DT to not use snps,nr-gpios so that going forward, we
won't be using a deprecated property and causing this warning. Older
DT + newer kernel will have this warning, but that's not the end of
the world.

-Saravana
