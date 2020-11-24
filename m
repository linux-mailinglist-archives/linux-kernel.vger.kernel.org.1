Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C88F22C2E71
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 18:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390818AbgKXR0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 12:26:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390661AbgKXR0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 12:26:19 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4D3C0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 09:26:19 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id l2so21483045qkf.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 09:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=alOzv44eGcjfpihMYnDwscb9X2R1MdOVC0kRQ9Tq8IQ=;
        b=Bp4Z1nP/zMlvdIvZ2C4wlMvQguakizmpIkzzCaxYf6u7hLlWtqGnrH+ncPOC/pEhxX
         xKdiOFLmsQxUQs/7HzqhzON9HYNprPQi+A5YhMiMHUDiDzJeaAgsNPfrZzL78Gsvy6Ck
         2qX6LzmlEtvd95ICvYx2wUmphmBcz0MUKvGRiiYPoiVrTFlwSKxvsMfSULAnmzUQRJXJ
         3FaPI+bH2VdYN8sO+NNU5WqtqoQgbeXobt8EQeLyUKOHsKmRQoWcoFSAYCSHcZ8YTwCh
         a4A28oRtPHdTjewsELKzJhtHdnx3xkqXql+uFGj3AO5En+QODaOR/FiqpX3J32LyX8OT
         3sJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=alOzv44eGcjfpihMYnDwscb9X2R1MdOVC0kRQ9Tq8IQ=;
        b=lYVTKsT1WkA/lnlXb7UErxKwLCyShnQc9YJeyrYrrRZY9byDB1Fkyye2QjCo+ojZLz
         yickiavAb6jzae94zJ5qs3Izdx3uIoPJAfUobaA+ZmRcXxKe7OJL3Z1fyt8yXVdlzrLt
         c1nrOBviacRdUwNqSrgTsSOw5qlzbsulZcGio19cO3aYFEwEe93dJF7KgkYM3wsiMCn/
         bqE8dTTiImwvnIIdCp7J/FKJzs3Hl2Ad1BII9jAnQkXiyHaq3o/MuhGabsyYqaF91iWR
         mUkpDaTo11LjiQpOuhbFIveIOOwX+OOFNCIe6BIheWaod5VYrYbEZKIcGZKCthcnMK2j
         UkRw==
X-Gm-Message-State: AOAM533aNTF9DXMaHu7pCatCgLwvIyklFJm2UXemDXq7nOS2yoApO2BG
        nSMn8+7brjryiBM9h9uKwV7bHuZAj15DfE2ERkbSpQ==
X-Google-Smtp-Source: ABdhPJxPgzZ0zSc0E/zfDctNAjzjKhUt0WBPKSQQ7LrYTHbV9PFEIpqfR37WzRpFkd+0FrI/utMKyuin1ppEewhztog=
X-Received: by 2002:a25:b090:: with SMTP id f16mr8175543ybj.466.1606238778756;
 Tue, 24 Nov 2020 09:26:18 -0800 (PST)
MIME-Version: 1.0
References: <20201121020232.908850-1-saravanak@google.com> <758a1b59-1033-b0ae-2549-84c8eeea4b11@ti.com>
In-Reply-To: <758a1b59-1033-b0ae-2549-84c8eeea4b11@ti.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 24 Nov 2020 09:25:42 -0800
Message-ID: <CAGETcx_ZSYpyi8M3T9d1vJk0FzxWoFWW6A=f-vK4jtF73SR0cw@mail.gmail.com>
Subject: Re: [PATCH v2 00/17] Refactor fw_devlink to significantly improve
 boot time
To:     Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Android Kernel Team <kernel-team@android.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 12:29 AM 'Tomi Valkeinen' via kernel-team
<kernel-team@android.com> wrote:
>
> Hi,
>
> On 21/11/2020 04:02, Saravana Kannan wrote:
> > The current implementation of fw_devlink is very inefficient because it
> > tries to get away without creating fwnode links in the name of saving
> > memory usage. Past attempts to optimize runtime at the cost of memory
> > usage were blocked with request for data showing that the optimization
> > made significant improvement for real world scenarios.
> >
> > We have those scenarios now. There have been several reports of boot
> > time increase in the order of seconds in this thread [1]. Several OEMs
> > and SoC manufacturers have also privately reported significant
> > (350-400ms) increase in boot time due to all the parsing done by
> > fw_devlink.
> >
> > So this patch series refactors fw_devlink to be more efficient. The key
> > difference now is the addition of support for fwnode links -- just a few
> > simple APIs. This also allows most of the code to be moved out of
> > firmware specific (DT mostly) code into driver core.
> >
> > This brings the following benefits:
> > - Instead of parsing the device tree multiple times (complexity was
> >   close to O(N^3) where N in the number of properties) during bootup,
> >   fw_devlink parses each fwnode node/property only once and creates
> >   fwnode links. The rest of the fw_devlink code then just looks at these
> >   fwnode links to do rest of the work.
> >
> > - Makes it much easier to debug probe issue due to fw_devlink in the
> >   future. fw_devlink=on blocks the probing of devices if they depend on
> >   a device that hasn't been added yet. With this refactor, it'll be very
> >   easy to tell what that device is because we now have a reference to
> >   the fwnode of the device.
> >
> > - Much easier to add fw_devlink support to ACPI and other firmware
> >   types. A refactor to move the common bits from DT specific code to
> >   driver core was in my TODO list as a prerequisite to adding ACPI
> >   support to fw_devlink. This series gets that done.
> >
> > Laurent and Grygorii tested the v1 series and they saw boot time
> > improvment of about 12 seconds and 3 seconds, respectively.
>
> Tested v2 on OMAP4 SDP. With my particular config, boot time to starting init went from 18.5 seconds
> to 12.5 seconds.

Thanks for testing Tomi!

-Saravana
