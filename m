Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89EC328C0E3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 21:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391355AbgJLTHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 15:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390985AbgJLTDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 15:03:38 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE6CC0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 12:03:37 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id p15so17918151ljj.8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 12:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GgKziLMDcTgRqv21p5RhDayMhMe8Y6rVFzrXAD437ZU=;
        b=fDc71co2gOFVLzUcpAtBr6zPs37rrhhDww+NlgBfbjHS0Z5DYoxFu5G1kqvYH5iayP
         MKHUpj6u23+x4/xuSmfAJjngVwP4Cg9R4JrkEYbshJYZZSpaWsHZ5mYnZyHdoPyfAi6c
         1jhVKQJ4eK1WVCcMOJdA6wT021GDrHTaPqCMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GgKziLMDcTgRqv21p5RhDayMhMe8Y6rVFzrXAD437ZU=;
        b=Ie0lnewhaJQv6D9F7i9ITORdjWcUG8ZbiWWXJlDDknWH7PxT4Wf2Igq99AAO/leKG/
         zWnjWPz+J4zmuBjHqzNhF7lM4KducLLB8mejU81Cp3Aeh710LCV340hVJX65E/hKjw9D
         8BR/LNnRPf1dKQ0urJk3KTB+9SiQ3TWWOexK5ECSuTNifSjyCygzvIGGuGNVlXYclznF
         S3sGZjm0+zvY+BubG6+TjqWzUg964qoh/pcfHa2bT4nn6q1AnGe7EDsnNYEx72XZ/gfi
         vguZETlZvyOgFnSDD+7+BUopeH0dR44ToTxl8BY3JnY+Msd1VPgxSLpx7CJHTQklzrFw
         s2YQ==
X-Gm-Message-State: AOAM530Y46S1LFHY/28ckrO8N8lgGZUdsQf5uabo4x11gZ0GwLkasJO7
        m8OFroA1c4foMd1S4JO8Z2mQUp9pc3F/9w==
X-Google-Smtp-Source: ABdhPJwLG4f8WDFI+Ysabl5gb5u7HJ775+sbn8M6CcQ4eAp5GzQQ+xLL4oX5R04H1AUoMxiYYN9hrw==
X-Received: by 2002:a2e:a371:: with SMTP id i17mr7937121ljn.173.1602529415810;
        Mon, 12 Oct 2020 12:03:35 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id f7sm3579146lfj.0.2020.10.12.12.03.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2020 12:03:35 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id r127so19395530lff.12
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 12:03:35 -0700 (PDT)
X-Received: by 2002:a19:4186:: with SMTP id o128mr7877648lfa.148.1602529414847;
 Mon, 12 Oct 2020 12:03:34 -0700 (PDT)
MIME-Version: 1.0
References: <20201012110557.GK25311@zn.tnic> <CAHk-=wiVoLoZS1v9SCQzH4mkpz6akE3pPrHPxM2hamOXPcaW9w@mail.gmail.com>
 <CAFULd4Z1_UKN6haGbNJMi0_tGddPZcawRDfoYnLdn-Qe6UR3-Q@mail.gmail.com> <CAHk-=whbEhjSHR7D=8Q_xARd=UKHGcz750LoT1BeRdgTR+6uSw@mail.gmail.com>
In-Reply-To: <CAHk-=whbEhjSHR7D=8Q_xARd=UKHGcz750LoT1BeRdgTR+6uSw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Oct 2020 12:03:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgBHgmAoLG9A0b-2_2ZiL_OaXLyO2pbKOHm=u93NttSBQ@mail.gmail.com>
Message-ID: <CAHk-=wgBHgmAoLG9A0b-2_2ZiL_OaXLyO2pbKOHm=u93NttSBQ@mail.gmail.com>
Subject: Re: [GIT PULL] x86/asm updates for v5.10
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     Borislav Petkov <bp@suse.de>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 11:56 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I also find that clang generates code that uses the high byte
> registers, although again, that's not from any knowledge of clang
> internals, and just by looking at my kernel image disassembly.
>
> So yes, it _may_ all be just peepholes, but it's not obvious that this
> is all safe.

The clang use I find seems to be _purely_ for variations of "mov", and
only ever with the high register as a source.

So yes, that one looks very much like a peephole optimization where
clang just recognizes patterns line

     X = (y >> 8) & 0xff;

and uses a "movzbl %*h,xyz" for it.

Gcc actually seems to use high registers more, but the extended use
seems to be bit test (and set) operations that also may be simply
peepholes.

So yes, from code generation patterns it does look likely that neither
compiler actually considers the high registers to be truely
independent entities, and thus quite likely that you'd never find
concurrent mixed use.

But that really seems to be an implementation issue rather than
something we should necessarily rely on, unless we have a stronger
statement from both compiler camps..

              Linus
