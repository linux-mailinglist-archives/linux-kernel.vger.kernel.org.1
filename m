Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2F8E2D4BBD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 21:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388457AbgLIU0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 15:26:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728183AbgLIUZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 15:25:55 -0500
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE74C06179C
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 12:25:09 -0800 (PST)
Received: by mail-yb1-xb41.google.com with SMTP id a16so2539285ybh.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 12:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cg29g+SYwUL9P/RFDh0mQu7UEu1IPZckD9ZkR+iLXYo=;
        b=e7TbuW6aT92M2R580C4ND2MKdbdiOpLdwUFD3ZX37S7eZk5df0KcJ/D9juWDeY4kOF
         pwAHdRMB2FSW5qVfdj0fjH/POt4nAYNKG+xWDKCojM8KVWE3TSUajHng11kmAWDh10BQ
         MS9bK06nr8HVHcFQHhAB5UE076W3L0VHafQHk5xQk5s2fmo9TwvfzfhDrr4B3crdJhsa
         s/vW/nDZgAAQWlcvv3s0GVWDNZXOfbLCi2yFKsx9EAYyowbCyR5lfLUPuIhMBN8hwZzY
         I+F+bBcVu8m8q//rLkDA6GSXdO+0YgzuGXB70zHtvQCghfQqHST/DuptF51NFngj1OCO
         Fjxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cg29g+SYwUL9P/RFDh0mQu7UEu1IPZckD9ZkR+iLXYo=;
        b=npgBOLqE1DVFcEskSU7V7ADuA5Uoa0aRobXyyrmdSsvZyl4sfGLHlsl9bgmZiuKScJ
         Bmw7vHmZSi3WOxrr8GO6PaV4pqed8KkiHbxv7CIyfMIC0H61bwUKOS534E7ea+Joc+fb
         ISdnjoI0gu1mlnWHrqWHhLEccQVAoSfB4weOX9tguTf58o3s7NUmQxxbcmGMKj1zGh9i
         3/FPnwwKn3x/YMbgQbqu4wrzpiD74PjjCPT7Jc2Vw3Z+6wzFBfqlkQN9fx4qk0PF1RHg
         K3VW7Qm31+RBice94L8CLe2wTCmmy4qQzHpQhALG7SMTzJ0fPCKdgwfqr1cgxy93Y1zq
         kWug==
X-Gm-Message-State: AOAM5308DCqla6TKNPxYSR5D4dKs9MnMMfoAZZm86gwqU7ift1nfA9mZ
        i+kMPOJh62VgDQQUgzcek7+3q2Nworp4EYgD+IIsuw==
X-Google-Smtp-Source: ABdhPJzfeZenFgo4Y7Xmmu4IwZNqsHwT7OkCnHsoDG2nJXOTxwCgvuOcYHDcsXQLa7rZQgx8/o4g2nibdtVh656oDz8=
X-Received: by 2002:a5b:b49:: with SMTP id b9mr5753924ybr.310.1607545508131;
 Wed, 09 Dec 2020 12:25:08 -0800 (PST)
MIME-Version: 1.0
References: <20201121020232.908850-1-saravanak@google.com> <X9EUbji0tILG6PvX@kroah.com>
In-Reply-To: <X9EUbji0tILG6PvX@kroah.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 9 Dec 2020 12:24:32 -0800
Message-ID: <CAGETcx_5_=VKxbTddtG4u7p0yhCTdkr746fToPtPecEZcE1ncg@mail.gmail.com>
Subject: Re: [PATCH v2 00/17] Refactor fw_devlink to significantly improve
 boot time
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
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

On Wed, Dec 9, 2020 at 10:15 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Nov 20, 2020 at 06:02:15PM -0800, Saravana Kannan wrote:
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
> Now queued up to my tree.  Note, I had to hand-apply patches 13 and 16
> due to some reason (for 13, I have no idea, for 16 it was due to a
> previous patch applied to my tree that I cc:ed you on.)
>
> Verifying I got it all correct would be great :)

A quick diff of drivers/base/core.c between driver-core-testing and my
local tree doesn't show any major diff (only some unrelated comment
fixes). So, it looks fine.

The patch 13 conflict is probably due to having to rebase the v2
series on top of this:
https://lore.kernel.org/lkml/20201104205431.3795207-1-saravanak@google.com/

And looks like Patch 16 was handled fine.

Thanks for applying the series.

-Saravana
