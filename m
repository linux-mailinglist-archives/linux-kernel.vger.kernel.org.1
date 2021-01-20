Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3022FD2C8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 15:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390690AbhATOfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 09:35:34 -0500
Received: from mail-oi1-f177.google.com ([209.85.167.177]:46544 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389152AbhATO3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 09:29:08 -0500
Received: by mail-oi1-f177.google.com with SMTP id q205so25127272oig.13;
        Wed, 20 Jan 2021 06:28:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zk9mjZhLDREeYKhiJgsc2oeG8Rrpq7wEhbcQ16h+YVc=;
        b=sBf8POKupvE1qtCKx+6CQg1UfZ1dHkGsi5dcKYc+kOa0ttHAjn5qmDeXMFRl6lKBU5
         Qed87N6MMpwwwOJSjRegw6kc1ReRxvasGJxPAZCbzyBDEzbLY/vCEifxpIa3O3rlVLKA
         vEwZ+S+OKKWrEghFZ93ZpIaRN1Nv6ep54PuyXvUTApSfAios7iMkUHQimLnbNxid2pUE
         5935GCQiRCr00ndZ4RTzNufNQdSdqW5pcJrSp4nxx3VDNRWpCgjd7+eWIes0+vzdM1Ed
         Ic8MkLvOuqMa+L6QPQoBWZWdeZqe9hyN4uye0rYaHT80xSTCGnCrIp8rASKllAU09VYS
         3f8Q==
X-Gm-Message-State: AOAM532qZlJ75kRpEge0upPSDK64aZrshfh4loDigDLLLRVu7ZyHCAyw
        79L7cisMmd0mspgzJ15FVLHjaTehmiv4wgiEAbU=
X-Google-Smtp-Source: ABdhPJx4JBI22mfkyjXFbNJl5635lGRtKv4WIot3WQUaJsXyI2T3UknjeCsfo78WHUo5N+9DUt/TdiV9KhWo0qmqdwU=
X-Received: by 2002:aca:4b16:: with SMTP id y22mr3020036oia.148.1611152907628;
 Wed, 20 Jan 2021 06:28:27 -0800 (PST)
MIME-Version: 1.0
References: <20201218210750.3455872-1-saravanak@google.com> <CAMuHMdUpZELgL4qUCs1VH0UUeckpTwqYLrMy2ETPzrpuUwkLnQ@mail.gmail.com>
In-Reply-To: <CAMuHMdUpZELgL4qUCs1VH0UUeckpTwqYLrMy2ETPzrpuUwkLnQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 20 Jan 2021 15:28:16 +0100
Message-ID: <CAMuHMdWEOpbh8xS9W09xudpoym8=J4UzuWTDqF3L+yDuU3k2ZQ@mail.gmail.com>
Subject: Re: [PATCH] of: property: Add device link support for interrupts
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Android Kernel Team <kernel-team@android.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravana,

On Wed, Jan 20, 2021 at 10:53 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Fri, Dec 18, 2020 at 10:11 PM Saravana Kannan <saravanak@google.com> wrote:
> > Add support for creating device links out of interrupts property.
> >
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Kevin Hilman <khilman@baylibre.com>
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
>
> Thanks for your patch!
>
> This does not seem to add all links.  I see links being created to the
> secondary interrupt controller (e61c0000 "renesas,irqc"), but not to
> the primary interrupt controller (GIC)
>
> Which is good, as the GIC driver is not a platform_driver, and thus
> creating links would break everything ;-)

of_link_to_phandle() ignores device nodes where OF_POPULATED
is set, and of_irq_init() sets that flag.  Hence the GIC is ignored.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
