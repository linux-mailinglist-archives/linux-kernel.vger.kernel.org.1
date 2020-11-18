Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB812B87A1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 23:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbgKRWW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 17:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgKRWWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 17:22:55 -0500
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF6BC0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 14:22:55 -0800 (PST)
Received: by mail-yb1-xb44.google.com with SMTP id s8so3197435yba.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 14:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NbP6rgwjK2EFgUMqLDaUqwoAKhSxaHXHnkBIkIlQS7Y=;
        b=nnd8aFZzuumjcZPUegkJDdKgvcR13wdzMnnSrbcsH9K12QoixI5KENwpTlvLFrrYg9
         ZumpyaUFK7l1CjZSQZOyCJGtf26MGcRcYy/BwFeU4rurjAmAAjZqZ0aE1IEYwuOyCoUH
         licHIy2+SYGzGlka42JK5k8JCLuG39nyl2aPQgDvyFPrUE++0cP4WJdU+c8wq2EQWAEm
         Nef+X99l6wlYWBG7W3apr8+dpqPynkSz4v6u95v5/PzzUxfrz+hsYu01ikky5yt1QOhM
         LUzfr96jK1WJa8B/DjwcAhKgMscIiDj3SwIR4ZDJM8NqCU2eSmeguG+YiaQQfG51wmK4
         8UFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NbP6rgwjK2EFgUMqLDaUqwoAKhSxaHXHnkBIkIlQS7Y=;
        b=P0lxgaa2NMLLGTjIgyGrzGUgACJhEBP25NUQlt4+g5MODiAgfj/xcAy3dEtsy4ioP+
         uNwBB7hfsJ7o9jqDOYHmLGpDtvXJNTTpOJNyjRsaUtdftlpVvg+UH1VvMVnmooAQmxy9
         rxDe9KY1lC6aGZyx+HiappaFWfs5DWrwoOLPomdB7I4KJCaYgXXZNng2DTsDSYrQJ9Xi
         ACvNnSmcdDcPROo7KnftcYYXk2hhUUCOcRorVLzIwNnWCTatddJnNyP7hMBel68fYjaK
         fdUNnMjSRhXrk4iZiImyZGUw+fRaPz7CzLI8erNb+srhwoxa/RhKgJCZUGwcuMFFhNBU
         nZ2A==
X-Gm-Message-State: AOAM532v9LS8BTcxDGu+BKE0NTbst75ioWezJaLN5pcW6CynC8HHIbMf
        xixof++GV76Xa6oTKjdJsbXezr7kZ3QmaQu6drYR4g==
X-Google-Smtp-Source: ABdhPJzkhQUiA5xFZo5MxKgzLPUjQHqwOptH2r0iSnpHpTG8h4LL5yF/qlQaZ2j6C0Ruw2qwl5xENcebaxw8LokNwqQ=
X-Received: by 2002:a5b:bc8:: with SMTP id c8mr11648021ybr.228.1605738174494;
 Wed, 18 Nov 2020 14:22:54 -0800 (PST)
MIME-Version: 1.0
References: <20201108082317.GA40741@kroah.com> <CADVatmN8SbZWVGf_xe_K1g7M9ArHXF8TUhYyBgQcydBF4_zp9g@mail.gmail.com>
 <20201109103703.GA1310551@kroah.com> <AM6PR04MB4966B90C0DEC71A6C86067AA80EA0@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <20201109114125.GC1769924@kroah.com> <AM6PR04MB4966F12B67C4104247E0E6A180EA0@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <20201109120512.GB1832201@kroah.com> <AM6PR04MB49668F60F74B73931C2ABBFD80EA0@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <20201109124801.GA1890488@kroah.com> <AM6PR04MB4966375933A2644C8A52119D80E10@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <X7T7TgGGgxx9j2Rl@kroah.com> <AM6PR04MB4966360584616AEEFFB9A4A780E10@AM6PR04MB4966.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB4966360584616AEEFFB9A4A780E10@AM6PR04MB4966.eurprd04.prod.outlook.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 18 Nov 2020 14:22:18 -0800
Message-ID: <CAGETcx-zaHa8DXocLsZ==MAZNCtGvuLcvDMLnjHGfd-KOoK+0A@mail.gmail.com>
Subject: Re: [PATCH RESEND] driver core: export device_is_bound() to fix build failure
To:     Aisheng Dong <aisheng.dong@nxp.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 7:40 AM Aisheng Dong <aisheng.dong@nxp.com> wrote:
>
> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Sent: Wednesday, November 18, 2020 6:46 PM
> >
> > On Wed, Nov 18, 2020 at 10:23:42AM +0000, Aisheng Dong wrote:
> > > Hi Greg,
> > >
> > > > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > Sent: Monday, November 9, 2020 8:48 PM
> > > >
> > > > On Mon, Nov 09, 2020 at 12:26:55PM +0000, Aisheng Dong wrote:
> > > > > > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > > Sent: Monday, November 9, 2020 8:05 PM
> > > > > >
> > > > > > On Mon, Nov 09, 2020 at 11:55:46AM +0000, Aisheng Dong wrote:
> > > > > > > > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > > > > Sent: Monday, November 9, 2020 7:41 PM
> > > > > > > >
> > > > > > > > On Mon, Nov 09, 2020 at 10:57:05AM +0000, Aisheng Dong wrote:
> > > > > > > > > Hi Greg,
> > > > > > > > >
> > > > > > > > > > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > > > > > > Sent: Monday, November 9, 2020 6:37 PM
> > > > > > > > > > Subject: Re: [PATCH RESEND] driver core: export
> > > > > > > > > > device_is_bound() to fix build failure
> > > > > > > > > >
> > > > > > > > > > On Mon, Nov 09, 2020 at 10:14:46AM +0000, Sudip
> > > > > > > > > > Mukherjee
> > > > wrote:
> > > > > > > > > > > Hi Greg,
> > > > > > > > > > >
> > > > > > > > > > > On Sun, Nov 8, 2020 at 8:23 AM Greg Kroah-Hartman
> > > > > > > > > > > <gregkh@linuxfoundation.org> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Sat, Nov 07, 2020 at 10:47:27PM +0000, Sudip
> > > > > > > > > > > > Mukherjee
> > > > wrote:
> > > > > > > > > > > > > When CONFIG_MXC_CLK_SCU is configured as 'm' the
> > > > > > > > > > > > > build fails as it is unable to find device_is_bound(). The error
> > being:
> > > > > > > > > > > > > ERROR: modpost: "device_is_bound"
> > > > > > [drivers/clk/imx/clk-imx-scu.ko]
> > > > > > > > > > > > >       undefined!
> > > > > > > > > > > > >
> > > > > > > > > > > > > Export the symbol so that the module finds it.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Fixes: 77d8f3068c63 ("clk: imx: scu: add two cells
> > > > > > > > > > > > > binding
> > > > > > > > > > > > > support")
> > > > > > > > > > > > > Signed-off-by: Sudip Mukherjee
> > > > > > > > > > > > > <sudipm.mukherjee@gmail.com>
> > > > > > > > > > > > > ---
> > > > > > > > > > > > >
> > > > > > > > > > > > > resending with the Fixes: tag.
> > > > > > > > > > > > >
> > > > > > > > > > > > >  drivers/base/dd.c | 1 +
> > > > > > > > > > > > >  1 file changed, 1 insertion(+)
> > > > > > > > > > > > >
> > > > > > > > > > > > > diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> > > > > > > > > > > > > index 148e81969e04..a796a57e5efb 100644
> > > > > > > > > > > > > --- a/drivers/base/dd.c
> > > > > > > > > > > > > +++ b/drivers/base/dd.c
> > > > > > > > > > > > > @@ -353,6 +353,7 @@ bool device_is_bound(struct
> > > > > > > > > > > > > device
> > > > > > > > > > > > > *dev)
> > > > > > {
> > > > > > > > > > > > >       return dev->p &&
> > > > > > > > > > > > > klist_node_attached(&dev->p->knode_driver);
> > > > > > > > > > > > >  }
> > > > > > > > > > > > > +EXPORT_SYMBOL(device_is_bound);
> > > > > > > > > > > >
> > > > > > > > > > > > EXPORT_SYMBOL_GPL() please, like all the other
> > > > > > > > > > > > exports in this
> > > > file.
> > > > > > > > > > > >
> > > > > > > > > > > > Also, wait, no, don't call this, are you sure you
> > > > > > > > > > > > are calling it in a race-free way?  And what
> > > > > > > > > > > > branch/tree is the above
> > > > > > commit in?
> > > > > > > > > > >
> > > > > > > > > > > I have not checked fully but since it is being called
> > > > > > > > > > > from
> > > > > > > > > > > probe() I assume the lock will be held at that time.
> > > > > > > > > >
> > > > > > > > > > probe() should never call this function as it makes no
> > > > > > > > > > sense at all at that point in time.  The driver should be fixed.
> > > > > > > > >
> > > > > > > > > Would you suggest if any other API we can use to allow the
> > > > > > > > > driver to know whether another device has been probed?
> > > > > > > >
> > > > > > > > There is none, sorry, as that just opens up way too many problems.
> > > > > > > >
> > > > > > > > > For imx scu driver in question, it has a special
> > > > > > > > > requirement that it depends on scu power domain driver.
> > > > > > > > > However, there're a huge number
> > > > > > > > > (200+) of power domains for each device clock, we can't
> > > > > > > > > define them all in DT
> > > > > > > > for a single clock controller node.
> > > > > > > > >
> > > > > > > > > That's why we wanted to use device_is_bound() before to
> > > > > > > > > check if scu power domain is ready or not to support defer probe.
> > > > > > > >
> > > > > > > > Use the device link functionality for this type of thing,
> > > > > > > > that is what it was created for.
> > > > > > > >
> > > > > > >
> > > > > > > Thanks for the suggestion. I will check it how to use.
> > > > > > > BTW, I wonder if dev_driver_string() could be an optional
> > > > > > > solution which seems a more simple way?
> > > > > >
> > > > > > Also, how do you really know you even have a valid pointer to
> > > > > > that other device structure?  How are you getting access to that?
> > > > > >
> > > > >
> > > > > The rough idea is as follows. Not sure if those APIs are safe
> > > > > enough as there're many users In kernel.
> > > > >
> > > > > pd_np = of_find_compatible_node(NULL, NULL, "fsl,scu-pd"); pd_dev
> > > > > = of_find_device_by_node(pd_np); if (!pd_dev ||
> > > > > !dev_driver_string(&pd_dev->dev) ||
> > > > >    strcmp(dev_driver_string(&pd_dev->dev), "imx-scu-pd")) {
> > > > >         of_node_put(pd_np);
> > > > >         return -EPROBE_DEFER;
> > > > > }
> > > >
> > > > Ick, again, no, don't do that, you can not guarantee "names" of
> > > > devices anywhere in the system, sorry.
> > >
> > > I tried to understand how to use devlink for this case by diving deep
> > > into the devlink code, however, it looked to me there're a few limitations on
> > the current devlink usage.
> >
> > Adding Saravana, who wrote that code to help explain it.
> >
> > > We can't create driver presence dependency link in consumer's probe
> > > function while the supplier driver is still not probed or even not created yet.
> > > (we're the later case that supplier device scu-pd may be created after scu-clk
> > device).
> >
> > Sounds like your DT is set up backwards?
>
> Yes, the dts is like below:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/freescale/imx8qxp.dtsi?h=v5.10-rc4
>         scu {
>                 compatible = "fsl,imx-scu";
>                 mbox-names = "tx0",
>                              "rx0",
>                              "gip3";
>                 mboxes = <&lsio_mu1 0 0
>                           &lsio_mu1 1 0
>                           &lsio_mu1 3 3>;
>
>                 clk: clock-controller {
>                         compatible = "fsl,imx8qxp-clk";
>                         #clock-cells = <1>;
>                         clocks = <&xtal32k &xtal24m>;
>                         clock-names = "xtal_32KHz", "xtal_24Mhz";
>                 };
>
>                 pd: imx8qx-pd {
>                         compatible = "fsl,imx8qxp-scu-pd";
>                         #power-domain-cells = <1>;
>                 };
>                 ...
>
> Clk and pd devices under scu node are propagated by scu driver in DT order.
> If moving pd node before clk node can also address this issue.

I can bet the DT maintainers are going to NACK a DT node reordering.
The ordering of DT nodes should not matter for correctness.

>
> >
> > > The kernel doc Documentation/driver-api/device_link.rst also mentioned
> > > this limitation and the suggested solution is:
> > > "The onus is thus on the consumer to check presence of the supplier
> > > after adding the link, and defer probing on non-presence."
> > >
> > > Then the question is , back again, , how to check the presense of
> > > other device driver if we can't use device_is_bound() API in module?
> >
> > Your driver should not care, as you can't get direct access to it, so don't try to
> > ask the driver core about it as that is racy and not viable.
> >
> > If your driver needs resources that it can not get at this point in time, just return
> > from probe with a defer error.  That way it will be called again after other
> > drivers load.
> >
>
> Referring to above dts snippet, you can see the problem here is that there're no power
> domain property in clock-controller node which cause the clock driver unable to use the
> Normal/standard way to acquire PD resources and return a EPROBE_DEFFER if failed like

_THIS_ is your main problem. If you add the power domain property,
your problem would be solved. Earlier in the thread you said:

> For imx scu driver in question, it has a special requirement that it depends on scu power
> domain driver. However, there're a huge number (200+) of power domains for each device
> clock, we can't define them all in DT for a single clock controller node.

But this just seems like an arbitrary position you are taking and then
digging yourself into a hole.

Does the clock controller actually depend on the power domain? If it
does, then list it in DT. If it doesn't and the real dependency is one
of the consumer devices that consume the clock provided by this clock
controller, then your clock controller should not be waiting/deferring
probe on this power domain. Leave that to the actual device that
depends on the power domain.

What are you even achieving by not listing the power domain in the DT
node of the clock controller if you are then going to have the clock
controller block on the power domain having probed?

> Other resources, e.g. irq, gpio and etc.
> That's the main reason we use device_is_bound() in clock driver to check if PD driver
> has been probed.
>
> And of_genpd_add_device() we used in scu clk driver does not support EPROBE_DEFER
> and in order to maintainer the backwards compatibility of imx_clk_scu_alloc_dev() API,
> We also can't return PROBE_DEFER. All those are special reasons which made things complicated
> and un-easy to address in standard way.

This seems to be talking about some out of tree code? So can't really
help you without seeing the code. And I don't understand what backward
compatibility you are trying to maintain within kernel code. That's
not something we try to or need to do. Just fix up the users.

> Maybe the simplest solution is justing move scu pd node above scu clk node which is also make
> Sense because it can save a huge number of defer probes.

This is 100% going to get rejected upstream. Even if you reorder the
DT nodes, there's no guarantee that your power domain device would get
probed before the clock driver.

Long story short, either

* Don't care about the power domain in your clock driver.

Or,

* List the power domain in the clock controller's DT node and then use
the normal APIs to get the power domain. And defer like any other
driver if you can't get the power domain.

-Saravana
