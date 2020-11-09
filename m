Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB732AC792
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 22:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731243AbgKIVqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 16:46:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729247AbgKIVqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 16:46:03 -0500
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5234CC0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 13:46:02 -0800 (PST)
Received: by mail-vs1-xe42.google.com with SMTP id t8so5846581vsr.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 13:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s1oPd4W2FaEvYEWIYKuSeYuYzB4fdXXOk8LONEHGQ2o=;
        b=Zh65Bg1EtkLr67IGCaJ6MX3EpDTPGYZjNNOgvXkdSCrzfcOKj0EzNZ+ktTEf6ohNzc
         yANDvow7Up+0ql/8sWDmGdpz3KmPzF/qlsCH8bkSO8Jd5UWtHAX2NE+UDdgz5leHUffZ
         h5b0QfGzU6Ihamqlg/QLnUu7w2oq3eH6SbzJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s1oPd4W2FaEvYEWIYKuSeYuYzB4fdXXOk8LONEHGQ2o=;
        b=tejSmf7W2n5/ZVYESQGr6wm3g551Ck1jQXCH13+0/DUxsCXF/57fR+PWRA0g3eevyI
         xumCD1RS2KQYW1lERPQ4MI5K0AENXKhwIlfo7LzdvSgtC5zsMX1oTDt3FoLGsnyhOXIx
         DSJ+tP7l1fvvyIzTSwxNHZOj8vcbOzkREJRNi8RR4zS1VQVtgs8nDEBXQ8jTQqc7HOrl
         aKoUttEmP0m3GAkatlqh42xV0FDvG9kw+Vks8mMUnvIgqEpGr6JgSz9xdLeG3IHkU9WN
         wn0C41KrE2EB2aURxZitCrgUmlW1R+y0Kw4XmdSoW7jzEooaC7FGKFIdQ8qDARM+31Nh
         a4GQ==
X-Gm-Message-State: AOAM53391hd39BCt9mmcGi+Eb1sQ4AaIX142BOprUX0t3C4oRCGenGJy
        k4fk5NGEPCaErzJ5ZjoXaqNb+/8OjS2evQ==
X-Google-Smtp-Source: ABdhPJyosZGqsJEI3LrBYvQR6CrYhvUNOzog6cYHRoexnMrCvPkcbF0S1hmWIyUM1YnFmqXpUl6JEA==
X-Received: by 2002:a67:db91:: with SMTP id f17mr9198021vsk.41.1604958361311;
        Mon, 09 Nov 2020 13:46:01 -0800 (PST)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id m14sm1394458vkk.17.2020.11.09.13.46.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 13:46:01 -0800 (PST)
Received: by mail-ua1-f49.google.com with SMTP id 91so3279415uar.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 13:46:01 -0800 (PST)
X-Received: by 2002:a9f:36a1:: with SMTP id p30mr8277416uap.64.1604957893619;
 Mon, 09 Nov 2020 13:38:13 -0800 (PST)
MIME-Version: 1.0
References: <20201104012929.3850691-1-dianders@chromium.org>
 <20201103172824.v4.1.Ied4ce10d229cd7c69abf13a0361ba0b8d82eb9c4@changeid>
 <ea8d8fa3-4e3e-3c56-cda3-c1f6b155018c@redhat.com> <CAD=FV=XLnL35Ltu0ZF2c_u262TDaJ+oZ_jiME_VUd8V+1P5Vaw@mail.gmail.com>
 <20283437-4166-b65e-c498-a650bf53cd8e@redhat.com> <CAO-hwJ+C9M8zqaiiAW2CATZtng7B9QPOMBSMts6hPUHE9PmSCQ@mail.gmail.com>
 <fd5958b8-106a-4ee8-04d1-f4eb882661e4@redhat.com>
In-Reply-To: <fd5958b8-106a-4ee8-04d1-f4eb882661e4@redhat.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 9 Nov 2020 13:38:01 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WMpEZnbFi0Qj9Voa=Hn_dzS5haQPL2G47e5Ku8OCaTqA@mail.gmail.com>
Message-ID: <CAD=FV=WMpEZnbFi0Qj9Voa=Hn_dzS5haQPL2G47e5Ku8OCaTqA@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] HID: i2c-hid: Reorganize so ACPI and OF are subclasses
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>,
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

On Mon, Nov 9, 2020 at 6:44 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 11/9/20 3:29 PM, Benjamin Tissoires wrote:
> > Hi,
> >
> > sorry for the delay. I have been heavily sidetracked and have a bunch
> > of internal deadlines coming in :/
> >
> > On Mon, Nov 9, 2020 at 12:24 PM Hans de Goede <hdegoede@redhat.com> wrote:
> >>
> >> Hi,
> >>
> >> On 11/4/20 5:06 PM, Doug Anderson wrote:
> >>> Hi,
> >>>
> >>> On Wed, Nov 4, 2020 at 4:07 AM Hans de Goede <hdegoede@redhat.com> wrote:
> >>>>
> >>>>> +#include "i2c-hid.h"
> >>>>> +
> >>>>> +struct i2c_hid_acpi {
> >>>>> +     struct i2chid_subclass_data subclass;
> >>>>
> >>>> This feels a bit weird, we are the subclass so typically we would
> >>>> be embedding a base_class data struct here ...
> >>>>
> >>>> (more remarks below, note just my 2 cents you may want to wait
> >>>> for feedback from others).
> >>>>
> >>>>> +     struct i2c_client *client;
> >>>>
> >>>> You pass this to i2c_hid_core_probe which then stores it own
> >>>> copy, why not just store it in the subclass (or even better
> >>>> baseclass) data struct ?
> >>>
> >>> My goal was to avoid moving the big structure to the header file.
> >>> Without doing that, I think you need something more like the setup I
> >>> have.  I'll wait for Benjamin to comment on whether he'd prefer
> >>> something like what I have here or if I should move the structure.
> >>
> >> Ok, if Benjamin decides to keep things this way, can you consider
> >> renaming i2chid_subclass_data to i2chid_ops ?
> >>
> >> It just feels weird to have a struct with subclass in the name
> >> embedded inside as a member in another struct, usualy the kobject model
> >> works by having the the parent/base-class struct embedded inside
> >> the subclass data struct.
> >>
> >> This also avoids the need for a callback_priv_data pointer to the ops,
> >> as the ops get a pointer to the baseclass data struct as argument and
> >> you can then use container_of to get your own subclassdata struct
> >> since that encapsulates (contains) the baseclass struct.
> >>
> >> Note the dropping of the callback_priv_data pointer only works if you
> >> do move the entire struct to the header.
> >
> > I am not sure my opinion is the best in this case. However, the one
> > thing I'd like us to do is knowing which use cases we are solving, and
> > this should hopefully help us finding the best approach:
> >
> > - use case 1: fully upstream driver (like this one)
> >    -> the OEM sets up the DT associated with the embedded devices
> >    -> the kernel is compiled with the proper flags/configs
> >   -> the device works out of the box (yay!)
> >
> > - use case 2: tinkerer in a garage
> >   -> assembly of a generic SoC + Goodix v-next panel (that needs
> > modifications in the driver)
> >   -> use of a generic (arm?) distribution
> >   -> the user compiles the new (changed) goodix driver
> >   -> the DT is populated (with overloads)
> >   -> the device works
> >   -> do we want to keep compatibility across kernel versions (not
> > recompile the custom module)
> >
> > - use case 3: Google fixed kernel
> >   -> the kernel is built once for all platforms
> >   -> OEMs can recompile a few drivers if they need, but can not touch
> > the core system
> >   -> DT/goodix specific drivers are embedded
> >   -> device works
> >   -> do we want compatibility across major versions, and how "nice" we
> > want to be with OEM?
> >
> > I understand that use case 2 should in the end become use case 1, but
> > having a possibility for casual/enthusiasts developers to fix their
> > hardware is always nice.
> >
> > So to me, having the base struct in an external header means we are
> > adding a lot of ABI and putting a lot more weight to case 1.
> >
> > Personally, I am not that much in favour of being too strict and I
> > think we also want to help these external drivers. It is true that
> > i2c-hid should be relatively stable from now on, but we can never
> > predict the future, so maybe the external header is not so much a good
> > thing (for me).
> >
> > Anyway, if we were to extract the base struct, we would need to
> > provide allocators to be able to keep forward compatibility (I think).
> >
> > Does that help a bit?
> >
> > [mode bikeshedding on]
> > And to go back to Hans' suggestion, I really prefer i2chid_ops. This
> > whole architecture makes me think of a bus, not a subclass hierarchy.
> > In the same way we have the hid bus, we could have the i2c-hid bus,
> > with separate drivers in it (acpi, of, goodix).
> >
> > Note that I don't want the i2c-hid to be converted into an actual bus,
> > but just rely on the concepts.
> > [bikeshedding off]
>
> Ok, so TL;DR: keep as is but rename subclass to i2chid_ops. That works
> for me.

Done in v5.


> >>>>> @@ -156,10 +152,10 @@ struct i2c_hid {
> >>>>>
> >>>>>       wait_queue_head_t       wait;           /* For waiting the interrupt */
> >>>>>
> >>>>> -     struct i2c_hid_platform_data pdata;
> >>>>> -
> >>>>>       bool                    irq_wake_enabled;
> >>>>>       struct mutex            reset_lock;
> >>>>> +
> >>>>> +     struct i2chid_subclass_data *subclass;
> >>>>>  };
> >>>>
> >>>> Personally, I would do things a bit differently here:
> >>>>
> >>>> 1. Just add the
> >>>>
> >>>>         int (*power_up_device)(struct i2chid_subclass_data *subclass);
> >>>>         void (*power_down_device)(struct i2chid_subclass_data *subclass);
> >>>>
> >>>> members which you put in the subclass struct here.
> >>>>
> >>>> 2. Move the declaration of this complete struct to drivers/hid/i2c-hid/i2c-hid.h
> >>>> and use this as the base-class which I described before (and store the client
> >>>> pointer here).
> >>>>
> >>>> 3. And then kzalloc both this baseclass struct + the subclass-data
> >>>> (only the bool "power_fixed" in the ACPI case) in one go in the subclass code
> >>>> replacing 2 kzallocs (+ error checking with one, simplifying the code and
> >>>> reducing memory fragmentation (by a tiny sliver).
> >>>
> >>> Sure, I'll do that if Benjamin likes moving the structure to the header.
> >>>
> >>>
> >>>> About the power_*_device callbacks, I wonder if it would not be more consistent
> >>>> to also have a shutdown callback and make i2c_driver.shutdown point to
> >>>> a (modified) i2c_hid_core_shutdown() function.
> >>>
> >>> Personally this doesn't seem cleaner to me, but I'm happy to do it if
> >>> folks like it better.  Coming up with a name for the callback would be
> >>> a bit awkward, which is a sign that this isn't quite ideal?  For the
> >>> power_up()/power_down() those are sane concepts to abstract out.  Here
> >>> we'd be abstracting out "subclass_shutdown_tail()" or something?
> >>> ...and if a subclass needs something at the head of shutdown, we'd
> >>> need to add a "subclass_shutdown_head()"?
> >>
> >> I have no real preference here either way.
> >
> > If we are using i2chid_ops, we could just have `shutdown_tail()`.
> > Basically drop any "device" or "subclass" in the op name.
> > This would lead to better code IMO: "ihid->dev_ops->shutdown()" for example
>
>
> This also works for me.

I've done this part and called the callback "shutdown_tail()", which I
think was what was agreed upon above.  If you want me to rename it to
"shutdown()" I can always send a v6.

NOTE: I haven't added a patch that makes shutdown do a "power off" by
default.  That seems like it should wait until there's a use case
showing that it helps with something.

-Doug
