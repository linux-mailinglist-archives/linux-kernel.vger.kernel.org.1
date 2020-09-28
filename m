Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8AE327AFBB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 16:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgI1OL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 10:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbgI1OL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 10:11:26 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E45C061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 07:11:26 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id gx22so8743772ejb.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 07:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tefr7BiFg39dwwsMVzHhoZjOTiYyT1GtzIbXqdzA3RQ=;
        b=cXl8XE2U4M1Uq5WJZJO+7kQtPfIkT7190lUQPtIRikXcIVUCIifzMHW932m5pjfAaW
         0Tb49s8LXw6flO8kvaqPRkA/68nTljoblmBx87fY2t+GKGsAJUuKE29SNGbc/E0eomfN
         GP44GTROn2cLLqVB2CTbgR6PTIW4aIfK46QKSuQ9BUDmrDjgIlS3TLD25IpWqvyibf0s
         aDIGop+wujTvC8qBgG+gIcia3TMfAxM1IMG5CvVPfkbmILuuHqMjjDarHTWmumyRToW/
         gc0NVTasRm3wnPL2oBdiB5shLfc/qm/Bq/tT8enqX0rtIFnnDvDrcisZq40p6nYb8SP+
         kpfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tefr7BiFg39dwwsMVzHhoZjOTiYyT1GtzIbXqdzA3RQ=;
        b=eSPL6yQJgACFzZ+ZQ1hHdP0wU1ace2YFi0PbNUaz1Wu/GwSKStHGLH9cNlYK7HAarv
         B/Dcft5y9ut9/uNTiux8vyCwP3RIlt9FQKkxQkHC27ZZYYOq92T7ytFhGkVoWIbTaglC
         xrxarG51cA0zH0c0DIRKiIz1pz6R3IvUuTd8oq1Ug8EIOAR0o0uSWwwTrlZa4S6p7GB/
         zTyN3Oz7zITX3EQHwLDnglSoVRAoSi2rAzXU7DIB6BeCCjeVPDaMDyi1Xoa+crYpqC1D
         ZnRtT6+NEaezaivnZ2coDhBsrNinTiJfb7s2pzZZ1hHmEtLXs1Plxwdft9WOqDqJTlVU
         EvIA==
X-Gm-Message-State: AOAM531mBDAVPEIvIJysp73loIvOOtSdTB+lFybyWYOhFP5SliffGxPz
        ZpS2HSk1Id1nXMe2enAmsCgWSIhC7tjRQRnNSXI=
X-Google-Smtp-Source: ABdhPJwRJJpw0/VWqUdH/OPHzpw/+li0Sr+sfPnK0ny3I4lyCpu0qLK2vlTmQKvyJOoIJrNZrOL4b8SI0FBQTEppbi0=
X-Received: by 2002:a17:906:e24d:: with SMTP id gq13mr1789288ejb.152.1601302285000;
 Mon, 28 Sep 2020 07:11:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLjtG_VHL1M8-=pKNNRmWQg_8oC0YG7C8H3gQcbJ+0B3=A@mail.gmail.com>
 <202009251301.A1FD183582@keescook> <CAMj1kXGtv84JHQfKoqOYyq=3m2w0Yuj_n4_Teo83zvdZ9kpZhw@mail.gmail.com>
 <202009251338.D17FB071@keescook> <CAMj1kXEWutwE-fP9bc=tsyPoTuV6J7bLzLpkZ213P9y9JszkTw@mail.gmail.com>
 <202009251647.FD8CECD4@keescook> <CAOuPNLif93a1uHhqsKFwhd35nfCnmRu_uxpB62shOEKyQ96hNw@mail.gmail.com>
 <202009260933.C603CD8@keescook> <CAOuPNLiM+ghH_7eNkAfA=jDgHrc+2_jB_n3FvYG-JMN0EiNfGA@mail.gmail.com>
In-Reply-To: <CAOuPNLiM+ghH_7eNkAfA=jDgHrc+2_jB_n3FvYG-JMN0EiNfGA@mail.gmail.com>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Mon, 28 Sep 2020 19:41:13 +0530
Message-ID: <CAOuPNLiw1FyzHq2DykRFwgG0BeaWaNymiV8_DmD=ump7P8W_ow@mail.gmail.com>
Subject: Re: KASLR support on ARM with Kernel 4.9 and 4.14
To:     Kees Cook <keescook@chromium.org>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Sep 2020 at 19:15, Pintu Agarwal <pintu.ping@gmail.com> wrote:
>
> On Sat, 26 Sep 2020 at 22:10, Kees Cook <keescook@chromium.org> wrote:
>
> > > >> I wonder if this is an Android Common kernel?
> > > It uses the below kernel for 4.14:
> > > https://gitlab.com/quicla/kernel/msm-4.14/-/tree/LE.UM.3.4.2.r1.5  (or
> > > similar branch).
> >
> > Okay, so yes. And this appears to have the hashing of %p backported. I
> > cannot, however, explain why it's showing hashed pointers instead of
> > just NULL, though.
> >
> > It might be related to these commits but they're not in that kernel:
> > 3e5903eb9cff ("vsprintf: Prevent crash when dereferencing invalid pointers")
> > 7bd57fbc4a4d ("vsprintf: don't obfuscate NULL and error pointers")
> >
> > > ==> The case where symbol addresses are changing.
> > >
> > > kptr_restrict is set to 2 by default:
> > > / # cat /proc/sys/kernel/kptr_restrict
> > > 2
> > >
> > > Basically, the goal is:
> > > * To understand how addresses are changing in 4.14 Kernel (without
> > > KASLR support)?
> > > * Is it possible to support the same in 4.9 Kernel ?
> >
> > Try setting kptr_restrict to 0 and see if the symbol addresses change? I
> > suspect Ard is correct: there's no KASLR here, just hashed pointers
> > behaving weird on an old non-stock kernel. :)
> >
>
> Okay. Thank you so much for your comments and suggestions.
> You mean to say, setting kptr_restrict to 0 may avoid changing symbol
> addresses in 4.14 ?
> And, sorry, I could not understand the thing about this "hashed pointers".
> How can I check this behavior in source code to understand better?
> Is it possible to give some reference ?
> I wanted to disable this hash pointer on 4.14 kernel and check the behavior.
> Also if possible, we would like to make this similar change on 4.9
> kernel as well.
>

Okay, I found these changes in 4.14 kernel:
https://gitlab.com/quicla/kernel/msm-4.14/-/commit/e63732dbfe017aa0dbabac9d096b5fde8afbd395

Are we talking about this?
I cound not find this in 4.9 kernel.

I will disable kptr_restrict and check or, I will enable
CONFIG_DEBUG_CONSOLE_UNHASHED_POINTERS and check.


Thanks,
Pintu
