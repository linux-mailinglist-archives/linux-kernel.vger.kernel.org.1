Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3302A692C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 17:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729676AbgKDQND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 11:13:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgKDQNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 11:13:02 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A12EC0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 08:13:02 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id c5so12561284qtw.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 08:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6XhlWy2zNDB285hOjmx7oZh3wIATZQKVDSLZhJN9BhI=;
        b=WulVKS/EA5hv7vg5+XxUdiO+k4ssrt0a+Mc8Y+aJC/N41gc0kdE3qw91bQiGabeXf+
         IQTKqAz0JDx9e6qdPxCoGk+RSgEpLdYG8mgevOcbVBWfw5aL05ua/ehIkM9clEX8yBh9
         RwLra6YemA+jQTH5bT07k/cCj/g3XBLDCBJk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6XhlWy2zNDB285hOjmx7oZh3wIATZQKVDSLZhJN9BhI=;
        b=gW0wp+4fCOJuNTbNyqhoqW1YUd26lDphOZ1A2oJqHkrH+jKS1RhsideJoD146kj3fF
         EIixxr6RRPrGY++KpWJdGJwmn68Px6ouaos8XIIW8dkaF2v/0Qms9nxXVC3h5hsDk2Fq
         wrPbJColuh4KiRv7wzxo/LqpTvj9ekJVNjwyp3yMwbHMgSEoZiHAF6mG3xpVdiEwY7uo
         QeghHovk9ZXOsjD+Dc/4YtJIPbrTA/7COQKkB63k4B26qc6Ljgm40ojJHxJyUNL5VTUG
         RKcl/SRUE0FLHr8Tt0YOe+On4jn4TF9U5ZKcaL0YezGym8moVmHWJk/+qiTSCyBxXziH
         iSzQ==
X-Gm-Message-State: AOAM531A/VewAPU/nPlGiSKt/cKr9SQPNsKUgO2wHFURIRQsrQIBqQej
        SZ6vCNMjSI8a8OnQzg7gXAvhEQqdUF2AaQ==
X-Google-Smtp-Source: ABdhPJyGHQ9FH3Pq1yscwyXCQU4Eb8xH/0yD8FSrmRqAJssp64bcQ6Mv7QW1CtHu2vQ+/tGB6xinnw==
X-Received: by 2002:ac8:594c:: with SMTP id 12mr882830qtz.224.1604506380903;
        Wed, 04 Nov 2020 08:13:00 -0800 (PST)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id p1sm2565243qkc.100.2020.11.04.08.13.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 08:13:00 -0800 (PST)
Received: by mail-yb1-f177.google.com with SMTP id f6so18528447ybr.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 08:13:00 -0800 (PST)
X-Received: by 2002:a9f:264a:: with SMTP id 68mr14432123uag.0.1604506031065;
 Wed, 04 Nov 2020 08:07:11 -0800 (PST)
MIME-Version: 1.0
References: <20201104012929.3850691-1-dianders@chromium.org>
 <20201103172824.v4.1.Ied4ce10d229cd7c69abf13a0361ba0b8d82eb9c4@changeid> <ea8d8fa3-4e3e-3c56-cda3-c1f6b155018c@redhat.com>
In-Reply-To: <ea8d8fa3-4e3e-3c56-cda3-c1f6b155018c@redhat.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 4 Nov 2020 08:06:58 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XLnL35Ltu0ZF2c_u262TDaJ+oZ_jiME_VUd8V+1P5Vaw@mail.gmail.com>
Message-ID: <CAD=FV=XLnL35Ltu0ZF2c_u262TDaJ+oZ_jiME_VUd8V+1P5Vaw@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] HID: i2c-hid: Reorganize so ACPI and OF are subclasses
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jiri Kosina <jkosina@suse.cz>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andrea Borgia <andrea@borgia.bo.it>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Aaron Ma <aaron.ma@canonical.com>,
        Jiri Kosina <jikos@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Pavel Balan <admin@kryma.net>,
        Xiaofei Tan <tanxiaofei@huawei.com>,
        You-Sheng Yang <vicamo.yang@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Nov 4, 2020 at 4:07 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> > +#include "i2c-hid.h"
> > +
> > +struct i2c_hid_acpi {
> > +     struct i2chid_subclass_data subclass;
>
> This feels a bit weird, we are the subclass so typically we would
> be embedding a base_class data struct here ...
>
> (more remarks below, note just my 2 cents you may want to wait
> for feedback from others).
>
> > +     struct i2c_client *client;
>
> You pass this to i2c_hid_core_probe which then stores it own
> copy, why not just store it in the subclass (or even better
> baseclass) data struct ?

My goal was to avoid moving the big structure to the header file.
Without doing that, I think you need something more like the setup I
have.  I'll wait for Benjamin to comment on whether he'd prefer
something like what I have here or if I should move the structure.


> > @@ -156,10 +152,10 @@ struct i2c_hid {
> >
> >       wait_queue_head_t       wait;           /* For waiting the interrupt */
> >
> > -     struct i2c_hid_platform_data pdata;
> > -
> >       bool                    irq_wake_enabled;
> >       struct mutex            reset_lock;
> > +
> > +     struct i2chid_subclass_data *subclass;
> >  };
>
> Personally, I would do things a bit differently here:
>
> 1. Just add the
>
>         int (*power_up_device)(struct i2chid_subclass_data *subclass);
>         void (*power_down_device)(struct i2chid_subclass_data *subclass);
>
> members which you put in the subclass struct here.
>
> 2. Move the declaration of this complete struct to drivers/hid/i2c-hid/i2c-hid.h
> and use this as the base-class which I described before (and store the client
> pointer here).
>
> 3. And then kzalloc both this baseclass struct + the subclass-data
> (only the bool "power_fixed" in the ACPI case) in one go in the subclass code
> replacing 2 kzallocs (+ error checking with one, simplifying the code and
> reducing memory fragmentation (by a tiny sliver).

Sure, I'll do that if Benjamin likes moving the structure to the header.


> About the power_*_device callbacks, I wonder if it would not be more consistent
> to also have a shutdown callback and make i2c_driver.shutdown point to
> a (modified) i2c_hid_core_shutdown() function.

Personally this doesn't seem cleaner to me, but I'm happy to do it if
folks like it better.  Coming up with a name for the callback would be
a bit awkward, which is a sign that this isn't quite ideal?  For the
power_up()/power_down() those are sane concepts to abstract out.  Here
we'd be abstracting out "subclass_shutdown_tail()" or something?
...and if a subclass needs something at the head of shutdown, we'd
need to add a "subclass_shutdown_head()"?


> You may also want to consider pointing that shutdown callback to the power_off
> function in the of case (in a separate commit as that is a behavioral change).

I don't think this is the point of shutdown, but I could be corrected.
Shutdown isn't really supposed to be the same as driver remove or
anything.  IIUC the main point of shutdown is to support kexec and the
goal is to quiesce DMA transactions.  Turning off power has never been
a requirement that I was aware of.  We don't want to jam too much
stuff in shutdown or else "shutdown" becomes as slow as boot for no
good reason, right?


> > diff --git a/drivers/hid/i2c-hid/i2c-hid-of.c b/drivers/hid/i2c-hid/i2c-hid-of.c
> > new file mode 100644
> > index 000000000000..e1838cdef0aa
> > --- /dev/null
> > +++ b/drivers/hid/i2c-hid/i2c-hid-of.c
> > @@ -0,0 +1,149 @@
> > +/*
> > + * HID over I2C Open Firmware Subclass
> > + *
> > + * Copyright (c) 2012 Benjamin Tissoires <benjamin.tissoires@gmail.com>
> > + * Copyright (c) 2012 Ecole Nationale de l'Aviation Civile, France
> > + * Copyright (c) 2012 Red Hat, Inc
>
> <snip>
>
> > +MODULE_DESCRIPTION("HID over I2C OF driver");
> > +MODULE_AUTHOR("Benjamin Tissoires <benjamin.tissoires@gmail.com>");
>
> In case Benjamin misses this during his own review: I'm not sure if he
> will want to be set as AUTHOR of this, given that part of the plan is
> for someone else to be the primary point of contact for the of bits.

I can stick myself in as the author if needed.  I'll wait for
Benjamin's feedback here.


-Doug
