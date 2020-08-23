Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0028E24EA85
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Aug 2020 02:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbgHWAKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Aug 2020 20:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728434AbgHWAKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 20:10:43 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D48C061573
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 17:10:42 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id 185so5747784ljj.7
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 17:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YIkVDHiTfHwp9VvpwPx0pR6/gdoUoxP4akmJs/bN2QQ=;
        b=dTw30b2JGhzNFtqWpFzHbpuHuQK0LUZLpQyOlsdW4z28uyV5F5wMPq7Hbs/Nd5GgTW
         YG7B0STPDqSEY9nHy+oY8pAlsWAL6l6kpJPJrMqvCHOe7tgsnfSwMw4VE8LS+c1/9a+3
         QhwTZl/ANBCM7KtvK0945P6zEu/p+m0DjZil0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YIkVDHiTfHwp9VvpwPx0pR6/gdoUoxP4akmJs/bN2QQ=;
        b=nZH6OgNKbjStww90qldPHjlrPd/pV1To7MPDvu1TghiMRlv0WD5lzXHRM+Uv0HZabx
         j3Tt7Qc/+I9Yl8slvB8NWtcm41ivmzjCzVgVOCGK/KzN2gjWPRYgnXuiKuWq2Y516Q3S
         xjrwPSbSInZ+5o6K4ea9cucV6P7zUtfSTTSe0W4ulJDV2vSlkqHzmdvf4mUcCMBI+ggi
         mUItaAI0WcNK+3q5aC2TsYF5ck6EJVayUFNXi6RUPsxiYvltm4Hgawo9gIzWIFa1IT9U
         rR25SXb7qMghrDG0ODxnBQDF2ScRMlF4Cvc8a9Gsj/wl2qk9T1Iq0FhwQCg82B1Vlz8z
         bA4w==
X-Gm-Message-State: AOAM5329bf2sITZY+PoFc0ILdFlXp4AaLC5st7aL+yb43Z4xfedl6fPy
        v3OOcHen1vIUyWipMbLFnZAjaU+8ozgyRA==
X-Google-Smtp-Source: ABdhPJzB4zcQCVZFjc9fyBaKY5p6J26ezqxfXbTG6w/SKyFn6P6StNliMPRRxGHPW2gOG6ktAzlTuQ==
X-Received: by 2002:a2e:808f:: with SMTP id i15mr4850048ljg.151.1598141440051;
        Sat, 22 Aug 2020 17:10:40 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id s2sm1262623ljm.4.2020.08.22.17.10.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2020 17:10:38 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id t6so5733888ljk.9
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 17:10:37 -0700 (PDT)
X-Received: by 2002:a2e:7615:: with SMTP id r21mr4215256ljc.371.1598141437262;
 Sat, 22 Aug 2020 17:10:37 -0700 (PDT)
MIME-Version: 1.0
References: <87zh6ohm03.fsf@nanos.tec.linutronix.de> <20200821230435.GA56974@rani.riverdale.lan>
 <CAKwvOdkoB+fT9tt7vgg1R6J-NEr77EWP5X8nFat_L-HvEzWGzA@mail.gmail.com>
 <87eenzqzmr.fsf@nanos.tec.linutronix.de> <20200822035552.GA104886@rani.riverdale.lan>
 <20200822084133.GL28786@gate.crashing.org> <CA+icZUVf9a8LC2Mf0cFymYQfALWs6bVfR1v1nRbxKaLAyU6NkQ@mail.gmail.com>
 <CA+icZUWGHo3mkN4=ZYeU37p8KJhxTXS5QKcAvq_HaqTHmFkw2g@mail.gmail.com>
 <CANiq72=3iOh5Z_rboZf-_GUpBE2LUUv3yPKOVNN_XmaNswdNSw@mail.gmail.com>
 <CAHk-=whaVW4FQjdwaicLFE4kiqr18rk6V50CuU-ziUPyRFjHrg@mail.gmail.com> <20200822231055.GA1871205@rani.riverdale.lan>
In-Reply-To: <20200822231055.GA1871205@rani.riverdale.lan>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 22 Aug 2020 17:10:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=whEb2xVU7uGOFwLxPgX-U2asMu1bJQA8QUEZPrL7zWwQQ@mail.gmail.com>
Message-ID: <CAHk-=whEb2xVU7uGOFwLxPgX-U2asMu1bJQA8QUEZPrL7zWwQQ@mail.gmail.com>
Subject: Re: [PATCH] x86: work around clang IAS bug referencing __force_order
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 22, 2020 at 4:11 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> Actually, is a memory clobber required for correctness? Memory accesses
> probably shouldn't be reordered across a CRn write. Is asm volatile
> enough to stop that or do you need a memory clobber?

You do need a memory clobber if you really care about ordering wrt
normal memory references.

That said, I'm not convinced we do care here. Normal memory accesses
(as seen by the compiler) should be entirely immune to any changes we
do wrt CRx registers.

Because code that really fundamentally changes kernel mappings or
access rules is already written in low-level assembler (eg the entry
routines or bootup).

Anything that relies on the more subtle changes (ie user space
accesses etc) should already be ordered by other things - usually by
the fact that they are also "asm volatile".

But hey, maybe somebody can come up with an exception to that.

                Linus
