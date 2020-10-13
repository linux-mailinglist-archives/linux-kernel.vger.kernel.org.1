Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C475E28C9A3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 10:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732597AbgJMIA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 04:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727744AbgJMIA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 04:00:57 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934B0C0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 01:00:57 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id h19so5354862qtq.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 01:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aOSW/1jV9ZZDliFDchN5ythzau0PJIohS37hifeg2cA=;
        b=QwEpEUhoL3acpkNjITABK3w5YblrZUfGwaJfaubolbYOWYMaqZkEwfqh7LWJmJsj5G
         duqTu7n/zGF0AQgeKWOvAfQWPEx765pNarDuFIUIUHRaOQt0hHhrOf1IQpTzZ7Wj/tgR
         9M/kJ6NWvQwAckqUWugo9tEEgTJb81p3YYUv4gkv4u77FnXvcTSVJ6dOxVnyYruFCZI7
         dpudqTg6WIL9oDYDpbX/Xn0pkLL88E9ot/XBxAiHEdGoNlcgZfCzRXgLgxYTkeFCB9jr
         9TRfw2joYIewqQgWNaZzqRWOC4jzlMlShPaNZjdI0yV2Nkn3L41L2Go/vEqGJbBAucQU
         GpYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aOSW/1jV9ZZDliFDchN5ythzau0PJIohS37hifeg2cA=;
        b=Fih2yykt0lkqELkbmqGLv7VPsczsd4YzDWnO8DuEhtSTj+f/76dTZ03jIKXx8juOA4
         Z3QleCI89vj7s26jWr/lDhAC0gClANZAyzb9bV2TWuRaHKH304Doghj3PUhSGCt80REP
         RsZxGe97A6O9fjCv53cpyXDUX7MWNa1TY/sw4yT2vuF0Mo3ok10d02i8RDzobj26TGzi
         gGMO8RLs/hznrcGZ2P3LOHQza1Figr/ETNMh9uBYBrC5QUEe1l7tanjDlnBiKcBQ48hh
         ZKJXcYwseq8mzFaknL2GmdC120I1nV/W1TgNs+5fj6QbbB+jOPlox0MvuCbTnYiNJoQE
         d+og==
X-Gm-Message-State: AOAM531BlIVnj8TiV/9T4P6cFcxUCZamQtAQ+x3vp/W7wtUwn0RFyg7U
        L8yTyW9FK2R+PEkzZ4tG1pGEynrGsVEcWoYfgrE=
X-Google-Smtp-Source: ABdhPJzRP6bSj3kFy5Xoesv9MmSSP7edjHByw13zwwdgvEZllKBgoj2wjPqRszuzT9v6Q9wmTTKH53Q95cjTPGyPGBU=
X-Received: by 2002:ac8:7a87:: with SMTP id x7mr13678287qtr.51.1602576056782;
 Tue, 13 Oct 2020 01:00:56 -0700 (PDT)
MIME-Version: 1.0
References: <20201012110557.GK25311@zn.tnic> <CAHk-=wiVoLoZS1v9SCQzH4mkpz6akE3pPrHPxM2hamOXPcaW9w@mail.gmail.com>
 <CAFULd4Z1_UKN6haGbNJMi0_tGddPZcawRDfoYnLdn-Qe6UR3-Q@mail.gmail.com>
 <CAHk-=whbEhjSHR7D=8Q_xARd=UKHGcz750LoT1BeRdgTR+6uSw@mail.gmail.com>
 <CAHk-=wgBHgmAoLG9A0b-2_2ZiL_OaXLyO2pbKOHm=u93NttSBQ@mail.gmail.com>
 <CAFULd4bHpJQau5kw8J93B2Xu1J_tYhShG6eWP88vRvhwxRZmdQ@mail.gmail.com>
 <CAHk-=wg2hkPc049k01fxZ0p0K3QSABi0O0uN-NHoqLa0yz-DJw@mail.gmail.com>
 <CAFULd4YQ5dNPU5mFuT9GHNH8-UVdcHLz7NYnvPi=kmhaUk1mcw@mail.gmail.com> <CAHk-=whnq+JmKsRwCbUnpZm4ZJLgaiX-KSFMkp7OeeE-RXwRGg@mail.gmail.com>
In-Reply-To: <CAHk-=whnq+JmKsRwCbUnpZm4ZJLgaiX-KSFMkp7OeeE-RXwRGg@mail.gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Tue, 13 Oct 2020 10:00:45 +0200
Message-ID: <CAFULd4axRbk4rT_+xuwjWv2J0+TP-qKjNK+QaivOGFdJ3aL+vg@mail.gmail.com>
Subject: Re: [GIT PULL] x86/asm updates for v5.10
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Borislav Petkov <bp@suse.de>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 10:57 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Oct 12, 2020 at 1:22 PM Uros Bizjak <ubizjak@gmail.com> wrote:
> >
> > No, this fact is not documented, although there are close to zero
> > chances it will ever change. High registers are independent from their
> > 8bit lowparts, but they still clobber corresponding 16bit, 32bit and
> > 64bit representations. I guess this limitation is so severe that the
> > compiler writers will be more than happy to document that %ah and %al
> > can't be independent.
>
> Ok, if we can get that agreed upon (and the clang people too), then I
> have no concerns about the patch.

The GCC's development documentation says:

--cut here--
         When storing to a normal 'subreg' that is smaller than a
         block, the other bits of the referenced block are usually left
         in an undefined state.  This laxity makes it easier to
         generate efficient code for such instructions.  To represent
         an instruction that preserves all the bits outside of those in
         the 'subreg', use 'strict_low_part' or 'zero_extract' around
         the 'subreg'.
--cut here--

REG is divided into individually-addressable blocks in which each block has:

              REGMODE_NATURAL_SIZE (M2)

bytes.  Usually the value is 'UNITS_PER_WORD'; that is, most targets
usually treat each word of a register as being independently
addressable.

The 'block' is 32bits for i386 or 64bits for x86_64. When asm is
writing to %al, this effectively means that other bits of a register
are left in an undefined state. Please note that 'strict_low_part' and
'zero_extract' are internal representations, not available in asm
statements.

> Just so that we don't have any nasty surprises in the future where
> some clever compiler change ends up breaking this (very rare)
> exception case.

IMO the above documents that write to a partial register clobbers the
entire register.

Uros.
