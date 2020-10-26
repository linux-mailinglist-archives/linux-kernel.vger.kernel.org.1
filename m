Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02E8E29968D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 20:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1792701AbgJZTOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 15:14:12 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:38098 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S367921AbgJZTLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 15:11:11 -0400
Received: by mail-yb1-f196.google.com with SMTP id b138so8587295yba.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 12:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sbt0kcqKvlNUeFuBMidUmwXRw1lkiu+9nIHexadf4S8=;
        b=dsKhFpeHkbM/UfmICNDl9Ysb1cIBkG6MAPccsxDkm3TKkkNk0VlzbSw+q3ynQHwG+f
         2j0SEDxWalqc0e/mozRcT6ZDKLCTyD0Yt9IqZr1u6fy4hLeD1YpZdYdn3fsMKY9R4IPZ
         +oIbK0tpMzENHlGICmoUKDMcKbivFq6Qk2WQvnSzf9SBIihbqALPlGn9IF9IWnfBRnKm
         5wBhrXZp8woC3NPZaAQVpmwvjAzUosU/eo4b/uyRRXwREDPOWZ2yGeOJTpd6WjnoMTv+
         u7VtfwDqtnZtqhimTbtW4WC0IoAqGpnuXJ8RmyAzUW46bVw+GtxJQIAiNMiwgL+0ZIhr
         gxBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sbt0kcqKvlNUeFuBMidUmwXRw1lkiu+9nIHexadf4S8=;
        b=ripCUdhEgXdaqgStyJYzKjHCmzqoGKykDNOFBiRBi3GOVwXnV/y/Asgq2dCEskVZEJ
         D6LBnFZ+gJzyucWSLVxXVNUEjYfU7Zqh05Ruq1Zo2WS43u5NM3gVRevf30DE9l91Gmva
         ARvcHKZmnpR7NegNQjxUy6J+aQx2gNSzNehOlf0fjWno3lc2U8ZRmtTkd+8hR7NwN5n7
         EU75lm75Kp6rGKDqf18qtqAWL4+kJ6+Xj9mGV7AdZavLd22cfOUw8HguO+bv1jYyEAvM
         s63psD20CBaFODsDuBG/MrPg3EnXH9fbw8EhCk7jZLx9u6RB0cuTG4gPAmZz+a+XJRla
         OHtA==
X-Gm-Message-State: AOAM5329GVBPVRYi/Tymz+zSFV1bRxeZ3Q9DV0WX1R23gmACmxNb1eCa
        UFEX9Njch4uUhpEcf3Fc+OvzbU9mMnenFoqbLBl1aFfCdIuooj0c
X-Google-Smtp-Source: ABdhPJyDbF/IblkFdG2sbUffPiMRY9EVz5lup4M23pIj1Lp0GRmTQ/rZQ9r8RDUK9pMa5Z26136UVQ8fibZIX+1Iwts=
X-Received: by 2002:a25:3:: with SMTP id 3mr22360900yba.412.1603739469742;
 Mon, 26 Oct 2020 12:11:09 -0700 (PDT)
MIME-Version: 1.0
References: <20201014193615.1045792-1-michael.auchter@ni.com> <d5f8a417-8db9-9385-dfea-9512b4680124@gmail.com>
In-Reply-To: <d5f8a417-8db9-9385-dfea-9512b4680124@gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 26 Oct 2020 12:10:33 -0700
Message-ID: <CAGETcx_869kxKbgRO68Wp9Qq8vAp8fqpAe_Lkjx8vZdW9RNTsQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] Fix errors on DT overlay removal with devlinks
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Michael Auchter <michael.auchter@ni.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 2:02 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> Hi Saravana,
>
> Michael found an issue related to the removal of a devicetree node
> which involves devlinks:
>
> On 10/14/20 2:36 PM, Michael Auchter wrote:
> > After updating to v5.9, I've started seeing errors in the kernel log
> > when using device tree overlays. Specifically, the problem seems to
> > happen when removing a device tree overlay that contains two devices
> > with some dependency between them (e.g., a device that provides a clock
> > and a device that consumes that clock). Removing such an overlay results
> > in:
> >
> >   OF: ERROR: memory leak, expected refcount 1 instead of 2, of_node_get()/of_node_put() unbalanced - destroy
> >   OF: ERROR: memory leak, expected refcount 1 instead of 2, of_node_get()/of_node_put() unbalanced - destroy
> >
> > followed by hitting some REFCOUNT_WARNs in refcount.c
> >
> > In the first patch, I've included a unittest that can be used to
> > reproduce this when built with CONFIG_OF_UNITTEST [1].
> >
> > I believe the issue is caused by the cleanup performed when releasing
> > the devlink device that's created to represent the dependency between
> > devices. The devlink device has references to the consumer and supplier
> > devices, which it drops in device_link_free; the devlink device's
> > release callback calls device_link_free via call_srcu.
> >
> > When the overlay is being removed, all devices are removed, and
> > eventually the release callback for the devlink device run, and
> > schedules cleanup using call_srcu. Before device_link_free can and call
> > put_device on the consumer/supplier, the rest of the overlay removal
> > process runs, resulting in the error traces above.
>
> When a devicetree node in an overlay is removed, the remove code expects
> all previous users of the related device to have done the appropriate put
> of the device and to have no later references.
>
> As Michael described above, the devlink release callback defers the
> put_device().  The cleanup via srcu was implemented in commit
> 843e600b8a2b01463c4d873a90b2c2ea8033f1f6 "driver core: Fix sleeping
> in invalid context during device link deletion" to solve yet another
> issue.
>
>
> >
> > Patches 2 and 3 are an attempt at fixing this: call srcu_barrier to wait
> > for any pending device_link_free's to execute before continuing on with
> > the removal process.
> >
> > These patches resolve the issue, but probably not in the best way. In
> > particular, it seems strange to need to leak details of devlinks into
> > the device tree overlay code. So, I'd be curious to get some feedback or
> > hear any other ideas for how to resolve this issue.
>
> I agree with Michael that adding an indirect call of srcu_barrier(&device_links_srcu)
> into the devicetree overlay code is not an appropriate solution.

I kind of see your point too. I wonder if the srcu_barrier() should
happen inside like so:
device_del() -> device_links_purge()->srcu_barrier()

I don't know what contention the use of SRCUs in device links was
trying to avoid, but I think the srcu_barrier() call path I suggested
above shouldn't be a problem. If that fixes the issue, the best way to
know if it's an issue is to send out a patch and see if Rafael has any
problem with it :)

> Is there some other way to fix the problem that 843e600b8a2b solves without
> deferring the put_device() done by the devlink release callback?

Ok I finally got some time to look into this closely.

Even if you revert 843e600b8a2b, you'll see that device_link_free()
(which drops the reference to the consumer and supplier devices) was
scheduled to run when the SRCU clean up occurs. So I think this issue
was present even before 843e600b8a2b, but commit 843e600b8a2b just
made it more likely to hit this scenario because it introduces some
delay in dropping the ref count of the supplier and consumer by going
through the device link device's release path. So, I think this issue
isn't related to 843e600b8a2b.

As to why 843e600b8a2b had to be written to call call_srcu() from the
device link device's release path, it's a mess of dependencies/delays:
1. The device link device is part of the struct device_link. So we
can't free device_link before the device_link.link_dev refcount goes
to 0.
2. But I can't assume device_link.link_dev's refcount will go to 0 as
soon as I call put_device() on it because of
CONFIG_DEBUG_KOBJECT_RELEASE which frees up the kobject after a random
delay.
3. The use of SRCU also means I can't free device_link until the SRCU
is cleaned up.

Because of (1), (2) and (3), when the device_link_del() (or any of the
other device link deletion APIs are called) I first have to do a
put_device(device_link.link_dev) to make sure the device memory is no
longer referenced, then trigger an SRCU clean up and then in the
scheduled SRCU cleanup I can free struct device_link. And obviously,
until struct device_link is ready to be freed up, I can't drop the
reference to the supplier and consumer devices (as that old copy of
device_link could be used by some code to refer to the supplier and
consumer devices).

Hope that helps explain the SRCU and device link device release dependencies.

Also, even if this patch series is applied as is, I wonder if the
current overlay code has a bug related to CONFIG_DEBUG_KOBJECT_RELEASE
delaying the actual freeing of the device. Something to look into?

-Saravana
