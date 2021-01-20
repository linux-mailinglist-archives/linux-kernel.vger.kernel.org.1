Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05BAB2FD1A7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 14:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388931AbhATNMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 08:12:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387592AbhATM3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 07:29:46 -0500
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F79AC061575
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 04:29:06 -0800 (PST)
Received: by mail-vk1-xa2e.google.com with SMTP id a6so5602742vkb.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 04:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LGkiRBGNN2JdjxlFLrksuxrHeQXvis+imv6RymdpV/E=;
        b=CKnjOzKbKJ54oU4Gzc8G4R0Tfkkd7Yy9HElluEZqPtUTZMkyG++hkiJvuoKO7enhPM
         ihrIsgx7og7mE29YcIkUDdeIVv1HIinCyPm2cJbIH3gIfEVZo2jG/qu4WWmrHwmRx46i
         /6F/EbzTAP6JE+4g8VgfvmNKiNGn7t0qsUzCWYi8rZ+7DBc9B/XyxrCoe7jFRmZCYvwe
         O4uU9JevYgLUNIyBMBFiTRIgVPwpS5g0v9Up9k5gd97aYXSywfW9HQznbUzosVgxt+hk
         NsKm59UqAkfUxMIOE8Kxc7cMi+ITgKAckkoPwEPn9JHQqz955557pysnKQqTHvwLfKWw
         ISNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LGkiRBGNN2JdjxlFLrksuxrHeQXvis+imv6RymdpV/E=;
        b=br448hmvY3uMdshMyp8tZhxvFTMtD3zoTE/65dEl11rBhFIDD+xZZn7GcyL0FnQopj
         +4aswUZrpPQlkl4T6rUBLdtzx4zmgvjk6Wiy6yvp6CaTz1xrRcKs/KUFHOkYHD9PgvHe
         lUQ+c2MQb4Zm99jSsgpEpX95jdh7k9Pi+puezbLPvuqQ7MfeU35NtJLnZRJvSVGBa+qJ
         yw/Rayi3oxiL41p89bFWFwzyiVM3ImoRPIG7NNi1in5ymLDQsfNSy34mfp5VI9/33iPb
         QJgQPY5EBHA1+qPF7YC1blf2QPOkCMh5MVKRq/BF1tlaAumcs95ZsRBnopYS2xDSQkmD
         Npzw==
X-Gm-Message-State: AOAM533bgTEJ4xLTO1cqhjofm2Wr0CyE9JF5W2fN7kDtE6N9f8BxRtXM
        Vr4R1sRgdMlPbU363/JEkmeA44NWhlLDgoVef9DkPg==
X-Google-Smtp-Source: ABdhPJzQQmTIm3qrv9BcNhq0Gl2fu+Jv1TT29DeboHCIh/vddpzoHgp84D1h6NrjWHdH7gSCVwzYnWpl5LMlxCMbNC0=
X-Received: by 2002:a1f:3008:: with SMTP id w8mr6407778vkw.24.1611145744570;
 Wed, 20 Jan 2021 04:29:04 -0800 (PST)
MIME-Version: 1.0
References: <20210113194619.RFC.1.I8f559ecdb01ffa98d5a1ee551cb802f288a81a38@changeid>
 <20210113102536.GC16960@zn.tnic>
In-Reply-To: <20210113102536.GC16960@zn.tnic>
From:   "Anand K. Mistry" <amistry@google.com>
Date:   Wed, 20 Jan 2021 23:28:52 +1100
Message-ID: <CAATStaOf_VN4BYBccSBk2bOpgvFwzH0xW=PncnyNo+SC41GXDw@mail.gmail.com>
Subject: Re: [RFC PATCH] x86/speculation: Add finer control for when to issue IBPB
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, Anthony Steinhauser <asteinhauser@google.com>,
        tglx@linutronix.de, Joel Fernandes <joelaf@google.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Julien Thierry <jthierry@redhat.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Mark Gross <mgross@linux.intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > Signed-off-by: Anand K Mistry <amistry@google.com>
> > Signed-off-by: Anand K Mistry <amistry@chromium.org>
>
> Two SoBs by you, why?

Tooling issues probably. Not intentional.

>
> > ---
> > Background:
> > IBPB is slow on some CPUs.
> >
> > More detailed background:
> > On some CPUs, issuing an IBPB can cause the address space switch to be
> > 10x more expensive (yes, 10x, not 10%).
>
> Which CPUs are those?!

AMD A4-9120C. Probably the A6-9220C too, but I don't have one of those
machines to test with,

>
> > On a system that makes heavy use of processes, this can cause a very
> > significant performance hit.
>
> You're not really trying to convince reviewers for why you need to add
> more complexity to an already too complex and confusing code. "some
> CPUs" and "can cause" is not good enough.

On a simple ping-ping test between two processes (using a pair of
pipes), a process switch is ~7us with IBPB disabled. But with it
enabled, it increases to around 80us (tested with the powersave CPU
governor).

On Chrome's IPC system, a perftest running 50,000 ping-pong messages:
without IBPB    5579.49 ms
with IBPB        21396 ms
(~4x difference)

And, doing video playback in the browser (which is already very
optimised), the IBPB hit turns out to be ~2.5% of CPU cycles. Doing a
webrtc video call (tested using http://appr.tc), it's ~9% of CPU
cycles. I don't have exact numbers, but it's worse on some real VC
apps.

>
> > I understand this is likely to be very contentious. Obviously, this
> > isn't ready for code review, but I'm hoping to get some thoughts on the
> > problem and this approach.
>
> Yes, in the absence of hard performance data, I'm not convinced at all.

With this change, I can get a >80% reduction in CPU cycles consumed by
IBPB. A  video call on my test device goes from ~9% to ~0.80% cycles
used by IBPB. It doesn't sound like much, but it's a significant
difference on these devices.
