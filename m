Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD6553029E3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 19:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbhAYSSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 13:18:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbhAYSSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 13:18:13 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBA4C061574
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 10:17:33 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id x78so14190113ybe.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 10:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4UgfSq/n1ql/Do9D6Jo7BzaTBGVTWyY0jEicOlOVjXE=;
        b=vyYC77QEyy2JqHl/3ma7KFOshuDU3DbYoWiJTBQW6WEpstXoJ6tXnGqcTBL4DImCoC
         JmQ5glms1DWfUStnRURxP/rm6XLswOmv5LskNbItPXoM/s0bK7rtITwDB0UYTRuUDpiU
         qbi47UdTa7dWGrN9Lt9BRvHgImRSMNrIRszTys8w1NgH1fY5kLlz7NxeWXcWfjSRkLnS
         RGHyJY0psoFiJsq5IMh/+gyzriVBCR4iFD9smDtuvDHQBl0ufPKZqQUEcKs/E4ZqJKxG
         4Rpur5+YpNR7NyTpwEksNTgtvTReyBcbvkQjk8MNWeXhw34ijwavuE26uc8AnaXh0FlU
         +bbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4UgfSq/n1ql/Do9D6Jo7BzaTBGVTWyY0jEicOlOVjXE=;
        b=rXZ06T8jzjWQtyp+U/RBKKe/iGDeqtPoJ+7zr9DBrkW7ClTcMCwPYnMMUYmia+6hi0
         odz2B95HmbDN9yzr7X7CuOPtZLn6QZ9rtayipvTpyTD+08uCmzgZl68YF9JeUEm1SwBT
         d1z2IoyHLpPet2/o7cJVJXJjJUkNq5h1r9we2uhiXdjZXZmIOeDsPmtUBN0kJj6QmQDf
         JDgM6XNr5u+eFgamLJprueFXKUoHgSpC7/CB0+C1HPIp3bDK8hGcrjuvcAYT3yn80xQf
         cJoCShKVPQL4CIc+PHTz5zBnAeb0P33JB9nL8SR7DbHQi1KaW5gIuWrh5nqFD/SEK9i4
         p2KA==
X-Gm-Message-State: AOAM530OImR6pjCZIlV7s1ulD3irCTgt6teiQh6nW59ZCVqaS/D5yHub
        eBHSp5JxrEW0AK8IuO5NTpb2WvKM2PyMeGUV1yJf7Q==
X-Google-Smtp-Source: ABdhPJxwNlnduYSv8Um5ub1gO+NgDSg6d2LF97CW0Bdm4cN1tEDOlYglbyujP0XhVaA5O17ZiWXos4ggg4kU+WJbyCk=
X-Received: by 2002:a05:6902:1025:: with SMTP id x5mr2610382ybt.96.1611598652034;
 Mon, 25 Jan 2021 10:17:32 -0800 (PST)
MIME-Version: 1.0
References: <20201218031703.3053753-1-saravanak@google.com>
 <20201218031703.3053753-6-saravanak@google.com> <6ca35fea-3c67-127d-2190-a34c0318a5a3@microchip.com>
In-Reply-To: <6ca35fea-3c67-127d-2190-a34c0318a5a3@microchip.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 25 Jan 2021 10:16:55 -0800
Message-ID: <CAGETcx-sZC4nKi9VKYUgaBnH4Kf3FraKEe+CMXxm_-DWjz9t5w@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] driver core: Set fw_devlink=on by default
To:     Tudor.Ambarus@microchip.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Kevin Hilman <khilman@baylibre.com>,
        John Stultz <john.stultz@linaro.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Marc Zyngier <maz@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Nicolas.Ferre@microchip.com, Ludovic.Desroches@microchip.com,
        alexandre.belloni@bootlin.com, Claudiu.Beznea@microchip.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 9:05 AM <Tudor.Ambarus@microchip.com> wrote:
>
> Hi, Saravana,
>
> On 12/18/20 5:17 AM, Saravana Kannan wrote:
> > Cyclic dependencies in some firmware was one of the last remaining
> > reasons fw_devlink=on couldn't be set by default. Now that cyclic
> > dependencies don't block probing, set fw_devlink=on by default.
> >
> > Setting fw_devlink=on by default brings a bunch of benefits (currently,
> > only for systems with device tree firmware):
> > * Significantly cuts down deferred probes.
> > * Device probe is effectively attempted in graph order.
> > * Makes it much easier to load drivers as modules without having to
> >   worry about functional dependencies between modules (depmod is still
> >   needed for symbol dependencies).
> >
> > If this patch prevents some devices from probing, it's very likely due
> > to the system having one or more device drivers that "probe"/set up a
> > device (DT node with compatible property) without creating a struct
> > device for it.  If we hit such cases, the device drivers need to be
> > fixed so that they populate struct devices and probe them like normal
> > device drivers so that the driver core is aware of the devices and their
> > status. See [1] for an example of such a case.
> >
> > [1] - https://lore.kernel.org/lkml/CAGETcx9PiX==mLxB9PO8Myyk6u2vhPVwTMsA5NkD-ywH5xhusw@mail.gmail.com/
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
>
> next-20210125 fails to boot on at91 sama5d2 platforms. No output is
> seen, unless earlyprintk is enabled.
>
> I have bisected this to commit e590474768f1cc04 ("driver core: Set
> fw_devlink=on by default").
>
> I've attached a log that I'm seeing on a sama5d2_xplained (sama5_defconfig
> and arch/arm/boot/dts/at91-sama5d2_xplained.dts). I enabled the
> following logs:
> 1. The ones in device_links_check_suppliers()
> 2. The ones in device_link_add()
> 3. initcall_debug=1
>
> There seem to be some probe fails due to the pmc supplier not being ready:
> calling  at_xdmac_init+0x0/0x18 @ 1
> platform f0010000.dma-controller: probe deferral - supplier f0014000.pmc not ready
> platform f0004000.dma-controller: probe deferral - supplier f0014000.pmc not ready
> initcall at_xdmac_init+0x0/0x18 returned -19 after 19531 usecs
>
> calling  udc_driver_init+0x0/0x18 @ 1
> platform 300000.gadget: probe deferral - supplier f0014000.pmc not ready
> initcall udc_driver_init+0x0/0x18 returned -19 after 7524 usecs
>
> There are others too. I'm checking them.

Thanks Tudor. I'll look into this within a few days. I'm also looking
into coming up with a more generic solution.

-Saravana
