Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C612E2AC228
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 18:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731739AbgKIRZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 12:25:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:36638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730450AbgKIRZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 12:25:53 -0500
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F82F20E65
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 17:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604942752;
        bh=xNe6oI2+GsLqcIEH7PXY3gTJtPh82o7VvswagmdVVV8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=b0Y20zYr/D+UF0W95loXwvzpJVjddKIRGVkeJWu8G6/tWi1uiEntI2b0qKJawzaId
         wtJSV02HcGSiY/8Sye7nivPMspDC4OWUJS3g/xYbr+H2DwjYdR/HM0Au2IGcdCnadd
         cFP35bLjVT8qWlaJAMM84/5M3fEbjTFDfC3Jgfy8=
Received: by mail-ot1-f48.google.com with SMTP id n15so9696302otl.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 09:25:52 -0800 (PST)
X-Gm-Message-State: AOAM5337ITgP57eBm3voG/GR0+6VjfN7E0jx3GfOmCIncZRXuEGEi6QS
        bywnpp7tcpeM/YDGgke9njcNQzZvRMIES7Gi/Q==
X-Google-Smtp-Source: ABdhPJzBJ0DE0B+MNmd+guVogAYLuNk0LG1hBcIJKiBpSdsg6rrioupJDN668Q8u+3KwUHEo8QFqU1/l+dts7ZV5tWk=
X-Received: by 2002:a05:6830:2f8:: with SMTP id r24mr11038612ote.129.1604942751273;
 Mon, 09 Nov 2020 09:25:51 -0800 (PST)
MIME-Version: 1.0
References: <20201106150747.31273-1-broonie@kernel.org> <CAGETcx-abGAgYrHM0jm6hVkrJ5KvfhK6gCZ4Y6RY0msPJDCuQg@mail.gmail.com>
In-Reply-To: <CAGETcx-abGAgYrHM0jm6hVkrJ5KvfhK6gCZ4Y6RY0msPJDCuQg@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 9 Nov 2020 11:25:39 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKfEWY8+suK3vrtbJbgWzDkCeDV_s61dh5Xwj13cHzCUQ@mail.gmail.com>
Message-ID: <CAL_JsqKfEWY8+suK3vrtbJbgWzDkCeDV_s61dh5Xwj13cHzCUQ@mail.gmail.com>
Subject: Re: [PATCH RFC] driver core: Ensure DT devices always have fwnode set
To:     Saravana Kannan <saravanak@google.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Mentz <danielmentz@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 6, 2020 at 1:09 PM Saravana Kannan <saravanak@google.com> wrote:
>
> +Rob and Frank
>
> On Fri, Nov 6, 2020 at 7:09 AM Mark Brown <broonie@kernel.org> wrote:
> >
> > Currently the fwnode API and things that rely on it like fw_devlink will
> > not reliably work for devices created from DT since each subsystem that
> > creates devices must individually set dev->fwnode in addition to setting
> > dev->of_node, currently a number of subsystems don't do so. Ensure that
> > this can't get missed by setting fwnode from of_node if it's not
> > previously been set by the subsystem.
> >
> > Reported-by: Saravana Kannan <saravanak@google.com>
> > Signed-off-by: Mark Brown <broonie@kernel.org>
> > ---
> >
> > *Very* minimally tested.
> >
> >  drivers/base/core.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index d661ada1518f..658626bafd76 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -2864,6 +2864,10 @@ int device_add(struct device *dev)
> >         if (parent && (dev_to_node(dev) == NUMA_NO_NODE))
> >                 set_dev_node(dev, dev_to_node(parent));
> >
> > +       /* ensure that fwnode is set up */
> > +       if (IS_ENABLED(CONFIG_OF) && dev->of_node && !dev->fwnode)
> > +               dev->fwnode = of_fwnode_handle(dev->of_node);
> > +
>
> I don't think we should add more CONFIG_OF specific code in drivers/base/

It's fwnode specific code because it's fwnode that needs it...

> If you want to do this in "one common place", then I think the way to
> do this is have include/linux/of.h provide something like:
> void of_set_device_of_node(dev, of_node)
> {
>     dev->of_node = of_node;
>     dev->fw_node = &of_node->fwnode;
>    /* bunch of other housekeeping like setting OF_POPULATED and doing
> proper of_node_get() */
>    // Passing NULL for of_node could undo all the above for dev->of_node.
> }
>
> And all the subsystems that create their own device from an of_node
> should use of_set_device_of_node() to set the device's of_node. That
> way, all this is done in a consistent manner across subsystems and
> avoid all of the of_get/put() and OF_POPULATED set/clear strewn all
> over the subsystems.

Perhaps a fwnode call in device_add instead that implements the above
and anything else needed for each type of fwnode. It might even be
possible with that to get rid of most of
of_platform_device_create_pdata() and of_device_add(). IIRC, those
were pretty much copies of the core code.

That would also be less fragile than having a coccinelle script.

Rob
