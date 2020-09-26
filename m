Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11256279B06
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 18:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729919AbgIZQkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 12:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728504AbgIZQkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 12:40:45 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27C5C0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 09:40:45 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id n14so5814540pff.6
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 09:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7e0Ffrwn9v4gwzlKso2h5MvGkrn/JrEHZKg5opwz4OY=;
        b=ktDKhvAEHwe8lJt6SyzjuD8ysDLH+ZaxKivr7vSNNqfjlMbAkjrRKcjx9FQhBSRv2g
         avVO6We7wuZu3KPJ1xtiaUSR48eerv6COZCBFaITK0GSQ8hc3sJGryngsQzidOm+8D5k
         K9RV5zZ17LXhsmdQkw6qPdp9sxLwH/NiksOMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7e0Ffrwn9v4gwzlKso2h5MvGkrn/JrEHZKg5opwz4OY=;
        b=rnI5RG/vXlh55c/UXwekuDHHzAEOEzkn3nQRJiPCOQjOH4sRvWml4oVhCFNz67gdGh
         htmooQILAC+XVkPJai96vf3xN0G+HC0JOyIj9xLMinLigTujgrcvVpn5dAiuRcARxKqV
         46cH9O0VijsYeVHJAHsdQgqoLuCxeKpP1+nfIRYOq6sUgZPcvTrlrli1LU6f/ffv4W5l
         lmtdHtZc03i+EmJLlqT6GHRWDIlLlSlDxs6S1JRLN+b21QuBX11zDmf2BQ+3MxJkHmjA
         ME1/p1MA8oZkjOHYV56mwwEguxa3jiRQV/IhfI93r1QjmkO89/AFeslVEmO5yXYBIxZj
         8PLg==
X-Gm-Message-State: AOAM531rOUt01GPbb2hzbU/oEGkJZHkSrYyIC5yW24eaJM+bYJveGlGj
        NipV+7+Yhng+STtwtAlNrhpKRQ==
X-Google-Smtp-Source: ABdhPJxEv3B43fDRIw9oQj67xt/6OOVTGXX9ohHp1ciUHnbEei28ePC/Ydj30i0xIBeY58/VxlmDhQ==
X-Received: by 2002:a63:5043:: with SMTP id q3mr3179390pgl.293.1601138445354;
        Sat, 26 Sep 2020 09:40:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h1sm2216562pji.52.2020.09.26.09.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2020 09:40:44 -0700 (PDT)
Date:   Sat, 26 Sep 2020 09:40:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Pintu Agarwal <pintu.ping@gmail.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Kernelnewbies <kernelnewbies@kernelnewbies.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        open list <linux-kernel@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>, matt@codeblueprint.co.uk,
        nico@linaro.org, Thomas Garnier <thgarnie@google.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: KASLR support on ARM with Kernel 4.9 and 4.14
Message-ID: <202009260933.C603CD8@keescook>
References: <CAOuPNLjtG_VHL1M8-=pKNNRmWQg_8oC0YG7C8H3gQcbJ+0B3=A@mail.gmail.com>
 <202009251301.A1FD183582@keescook>
 <CAMj1kXGtv84JHQfKoqOYyq=3m2w0Yuj_n4_Teo83zvdZ9kpZhw@mail.gmail.com>
 <202009251338.D17FB071@keescook>
 <CAMj1kXEWutwE-fP9bc=tsyPoTuV6J7bLzLpkZ213P9y9JszkTw@mail.gmail.com>
 <202009251647.FD8CECD4@keescook>
 <CAOuPNLif93a1uHhqsKFwhd35nfCnmRu_uxpB62shOEKyQ96hNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOuPNLif93a1uHhqsKFwhd35nfCnmRu_uxpB62shOEKyQ96hNw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 26, 2020 at 01:28:02PM +0530, Pintu Agarwal wrote:
> On Sat, 26 Sep 2020 at 05:17, Kees Cook <keescook@chromium.org> wrote:
> > >
> > > For a 3/1 split ARM kernel of the typical size, all kernel virtual
> > > addresses start with 0xc0, and given that the kernel is located at the
> > > start of the linear map, those addresses cannot change even if you
> > > move the kernel around in physical memory.
> >
> > I wonder if this is an Android Common kernel? I think there was %p
> > hashing in there before v4.15, but with a different implementation...
> >
> 
> Hi,
> Thank you all for all your reply and comments so far!
> Here are some follow-up replies.
> 
> >> What device is this? Is it a stock kernel?
> This is a Qualcomm Snapdragon Automotive board one with Linux Kernel
> 4.9 and one with 4.14.
> 
> >> Is the boot loader changing the base address? (What boot loader are you
> >> using?)
> Ohh I did not knew that the bootloader can also change the base address.
> I think it uses UEFI.
> How to check if bootloader is doing this ?
> BTW, both 4.9 board and 4.14 board, uses same bootloader.
> 
> >> I wonder if this is an Android Common kernel?
> It uses the below kernel for 4.14:
> https://gitlab.com/quicla/kernel/msm-4.14/-/tree/LE.UM.3.4.2.r1.5  (or
> similar branch).

Okay, so yes. And this appears to have the hashing of %p backported. I
cannot, however, explain why it's showing hashed pointers instead of
just NULL, though.

It might be related to these commits but they're not in that kernel:
3e5903eb9cff ("vsprintf: Prevent crash when dereferencing invalid pointers")
7bd57fbc4a4d ("vsprintf: don't obfuscate NULL and error pointers")

> ==> The case where symbol addresses are changing.
> 
> kptr_restrict is set to 2 by default:
> / # cat /proc/sys/kernel/kptr_restrict
> 2
> 
> Basically, the goal is:
> * To understand how addresses are changing in 4.14 Kernel (without
> KASLR support)?
> * Is it possible to support the same in 4.9 Kernel ?

Try setting kptr_restrict to 0 and see if the symbol addresses change? I
suspect Ard is correct: there's no KASLR here, just hashed pointers
behaving weird on an old non-stock kernel. :)

-- 
Kees Cook
