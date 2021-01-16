Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDF502F89F2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 01:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbhAPAbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 19:31:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbhAPAbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 19:31:14 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A0BC061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 16:30:33 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id x4so6008234vsp.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 16:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0Jf/tBlgSo7njTLcYONKJ4fnQXzrotU5gExIq7Q4HCA=;
        b=Mk7jAlm9R4Dx1yNSstOGOGwukUn8HmaCbD0VeZMFDq6mZC1Q7j2KGURMzexp8+j5a2
         GdvBoSz0GsMRb8rNZwB3kD861gMApP62njxLt2eS6+dAVu39Owd8+RuRzByOfbpZgYJ0
         MQXHbFz5dihR/T8GwQ0Cs0Tg/UozlRzEPItFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Jf/tBlgSo7njTLcYONKJ4fnQXzrotU5gExIq7Q4HCA=;
        b=Kykmb+Q2JiDi4Fnb5d2jOowOsJPk1zhWci77ARXXK4u2tvUbfrHz2x03VDcaKHuOqk
         xHLbnIeh+oQeZND++YeLmZG4b3dHuVON1a/yW+iwRF8+0rMQcMy1Ao5Iz5bUE6q8lrTB
         8mckwz7osoMQW9ZJ1Obic/8EZ190PRSRtEwh07yN7D3FnnkXc+OvY+HqMvYjw/v5oywB
         1G2B+M8zCoSC4Vef/tjmjQBPw9yReHnRln+q7ufiuRFA4nL6JaWUySWUIU6C6KMuoRvb
         SA7XYBozKA2wOePuztYX3aW730Q2qEAsURePquPvl7EX/lE3A3GLPspDGC1cY9+KG8OU
         cNGg==
X-Gm-Message-State: AOAM533kZtYXXDo3WrldR27sUgiYh40cTal2HnHvnmEuZ4S4PkOGg2qm
        +YwgMPVMyJPmqg3GoHZ4529eXvTZqKMLspMFli56IQ==
X-Google-Smtp-Source: ABdhPJyBu2Z7ZHAxu1l0LdssZG86cDWAMnjenjBfvdg5OdnCPzJyJ0/tzwpWlJljD7zQ8r6WLQ1a+Qtv0ZlLzo7+rHc=
X-Received: by 2002:a67:6b46:: with SMTP id g67mr12380691vsc.60.1610757033183;
 Fri, 15 Jan 2021 16:30:33 -0800 (PST)
MIME-Version: 1.0
References: <20210115114544.1830068-1-qperret@google.com> <20210115114544.1830068-3-qperret@google.com>
 <20210115173015.GA1496104@robh.at.kernel.org>
In-Reply-To: <20210115173015.GA1496104@robh.at.kernel.org>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Sat, 16 Jan 2021 08:30:21 +0800
Message-ID: <CANMq1KDD5KMsa=bXzxcp-0PXYvFz9zf2jdjvZJ4faatqJMfgwQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] of/fdt: Make sure no-map does not remove already
 reserved regions
To:     Rob Herring <robh@kernel.org>
Cc:     Quentin Perret <qperret@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        KarimAllah Ahmed <karahmed@amazon.de>, kernel-team@android.com,
        Frank Rowand <frowand.list@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 16, 2021 at 1:30 AM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, 15 Jan 2021 11:45:44 +0000, Quentin Perret wrote:
> > From: Nicolas Boichat <drinkcat@chromium.org>
> >
> > If the device tree is incorrectly configured, and attempts to
> > define a "no-map" reserved memory that overlaps with the kernel
> > data/code, the kernel would crash quickly after boot, with no
> > obvious clue about the nature of the issue.
> >
> > For example, this would happen if we have the kernel mapped at
> > these addresses (from /proc/iomem):
> > 40000000-41ffffff : System RAM
> >   40080000-40dfffff : Kernel code
> >   40e00000-411fffff : reserved
> >   41200000-413e0fff : Kernel data
> >
> > And we declare a no-map shared-dma-pool region at a fixed address
> > within that range:
> > mem_reserved: mem_region {
> >       compatible = "shared-dma-pool";
> >       reg = <0 0x40000000 0 0x01A00000>;
> >       no-map;
> > };
> >
> > To fix this, when removing memory regions at early boot (which is
> > what "no-map" regions do), we need to make sure that the memory
> > is not already reserved. If we do, __reserved_mem_reserve_reg
> > will throw an error:
> > [    0.000000] OF: fdt: Reserved memory: failed to reserve memory
> >    for node 'mem_region': base 0x0000000040000000, size 26 MiB
> > and the code that will try to use the region should also fail,
> > later on.
> >
> > We do not do anything for non-"no-map" regions, as memblock
> > explicitly allows reserved regions to overlap, and the commit
> > that this fixes removed the check for that precise reason.
> >
> > [ qperret: fixed conflicts caused by the usage of memblock_mark_nomap ]
> >
> > Fixes: 094cb98179f19b7 ("of/fdt: memblock_reserve /memreserve/ regions in the case of partial overlap")
> > Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> > Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> > Signed-off-by: Quentin Perret <qperret@google.com>
> > ---
> >  drivers/of/fdt.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >

Thanks for picking up this old patch Quentin ,-)

> Applied, thanks!
