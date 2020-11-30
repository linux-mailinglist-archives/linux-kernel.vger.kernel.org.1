Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71DCA2C8B93
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 18:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbgK3RpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 12:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbgK3RpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 12:45:03 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699B4C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 09:44:23 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id y10so19237129ljc.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 09:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hGGnCVO25VOQfg1PzcbDjqG+MdPgry8c2i2t7+r3Ezo=;
        b=OpbVqC/70CdGr9YEoMNyq56qEVPpQmbjvAsLgtlaJoyII6eswjqe7S4biOHSMstc3n
         YUniZkwX7b1I+uUfHDRpPTPw6l9kKhL20qsHluB+J4/sDH3RuD+1IjpWNP6qBnTTMw50
         sHR3xPzr7wC9l6SkL4QQkuixNxBs9xBM105nM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hGGnCVO25VOQfg1PzcbDjqG+MdPgry8c2i2t7+r3Ezo=;
        b=dwDksDFYyvzDEmksA4GrneKTqWP+JrdsDJSf/QL1HNN7vbMAh1JwLF2KX2ixgKoaG/
         MVD9I4CuV49R9wijoz437H/s0KvK6uKJwhQLGIlFuDWV1DspflLNHDCT/Fl3Y4ZBE4XB
         M4KdHg+xFBjE8s/Tkms01laO8f+zpBnR8h20hYIPt5BeDqLnbSS3dA4YLzCJkbDwQYVt
         rDJlUONDXWDUkHKwTK2JsivxyNbUTloAGNOfFDW2SLYrPlB6mqzdfLj72PvfIjtOLock
         v30ATR8mKo0M0LNo1u00EmewyMEhEHI9AiBmhT0lRq8xIguOEjMLmOntCoJQtrSYS7ip
         Y5Rw==
X-Gm-Message-State: AOAM531KfBsApFUqoOWBNc7nABMmCQBoeWo9kSllnz2gFupaCxswwqV9
        1/blAwOS8OGdPJZobg/iDPuOvelHAnf+Sw==
X-Google-Smtp-Source: ABdhPJzwLSHTuJnto4EDbqxZmL9npdfWuLNtmqh9rVd6/tskPOY1UWwxd6WwXEiTZ/niFSNicxvxPA==
X-Received: by 2002:a2e:9d99:: with SMTP id c25mr10738424ljj.213.1606758261161;
        Mon, 30 Nov 2020 09:44:21 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id m84sm2520507lfd.46.2020.11.30.09.44.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Nov 2020 09:44:20 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id f24so19195339ljk.13
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 09:44:19 -0800 (PST)
X-Received: by 2002:a2e:50c:: with SMTP id 12mr9985564ljf.371.1606758259392;
 Mon, 30 Nov 2020 09:44:19 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a2Habmz95y+J+-4NiT5SGYhO_Fia-SHhapX-3NYRbEMmw@mail.gmail.com>
 <CAHk-=wjA2Der39e_SWZ6S-DoVCJTu-Zwf6jn2wxmGTKzNPV1Dw@mail.gmail.com> <CAD=FV=Vow5_jv=-O=f2v4_5Nb4DiOUB1sQUx6r=-y5A-6rP4hw@mail.gmail.com>
In-Reply-To: <CAD=FV=Vow5_jv=-O=f2v4_5Nb4DiOUB1sQUx6r=-y5A-6rP4hw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 30 Nov 2020 09:44:03 -0800
X-Gmail-Original-Message-ID: <CAHk-=whtySEgkH+VFy9oW8Q-+iuivGBo0hOUcee3DvrsBAQUrA@mail.gmail.com>
Message-ID: <CAHk-=whtySEgkH+VFy9oW8Q-+iuivGBo0hOUcee3DvrsBAQUrA@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: SoC fixes for v5.10, part 3
To:     Doug Anderson <dianders@chromium.org>
Cc:     Arnd Bergmann <arnd@kernel.org>, SoC Team <soc@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 9:04 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Without static assignment, maybe we could do numbering of MMC devices
> in some type of a pre-probe routine?  Is that what you're suggesting?

Yes.

So basically, the way the async probing works for say SCSI is that we
have multiple "layers of asynchroniety". We have the usual "init calls
done asynchronously", but then within the init calls themselves you
can start sub-scans asynchronously.

In order to get reliable ordering between multiple controllers, the
PCI bus is probed in order in pci_init() (or whatever), so each SCSI
controller gets called in a fixed order.

That then gets to scsi_scan_host() does that async_schedule() thing to
actually scan the SCSI buses on that host.

> If so, it seems like it might be a pretty big change to figure out how
> that ought to work (if it can be made to work).

Try to start out doing discovery synchronously, but then any extra
work (actual IO like partition scanning etc) with an "async_work()".

> Just to confirm, I assume you are specifically excluding all block
> devices attached via USB, right?

I have this memory that we tried to scan the root bus in order, just
because people will have internal USB devices that way, and it makes
it *much* easier if they show up in predetermined places.

Note that it really is only the internal devices that matter. Once you
start plugging in an external USB hug and random devices, ordering
clearly won't be reliable.

So this is not a "everything must be ordered". But people who think
that that then means "everythinbg can be random" are wrong. It's
really really inconvenient, because things like disk labels and
various device IDs are not reliable either, and can be very confusing
when two otherwise identical machines look different before you've
installed a full system on them, for example.

So you should strive very hard to make everything that is directly
connected to one SoC always come up in the same order, for example.

And storage devices are special. As Dmitry points out, it doesn't much
matter in what order something like a mouse is scanned. Who cares? If
you have multiple pointer devices, you'll either use them
interchangably, or you'll have some other way to identify them. But
storage is a _lot_ more basic than basically stateless input devices
are.

And no, disk labels really don't always exist. Never ever say "but but
but disk labels".

               Linus
