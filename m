Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8506B2748A4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 20:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgIVS4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 14:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbgIVS4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 14:56:18 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D7AC061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 11:56:16 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id q4so1924068pjh.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 11:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cnGFGsoZkrOa6t5GjujR8jzlR8t5bcWa7TkXVML+mUk=;
        b=O2L3V214iyFxioMxiiYdML2mLy+EJUWoiB7UjsBo80eFO8b3p7mdlp5CR/D1X5NhZJ
         AiIHpfVGHaWORgycQeyPwyg6KdWXTWz73H7MH/m7tmjjH8i8hg2JHkYkQJegAh9xUP0Q
         UMPstres+RwijUfYzX4Pg25kW8zdN0dm+XN6k/OPi/85RjH6BvM+0wnt/cxNaU56ATjT
         bZ9W3pHCfr8Y/9k+a0ruMFWpsOP+cd4rbUv4utcpx3e4FFQ0Vn5I0Nwu4JNBfchoPRjB
         FnXMqmSqKtE1NS35E8iXE3FbIdsDAxVdBshjDfHKz2roXxm88EHFj3N6DuGtjxsNiNzR
         MvGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cnGFGsoZkrOa6t5GjujR8jzlR8t5bcWa7TkXVML+mUk=;
        b=N/IUtMdqySw42YqkWk28kFW9OlCbfQaCQ/rx3pGHYPp/1z0X6R43hbVo5oOOks4fl4
         yg/00PPKSLF/Blin/cr14hhOZr8km8fOrJVtC0XtymUXc9uiI5YYyOyeBmxM6CLMQVdm
         ovnpNJfUJ1I4p8sEwRLyGL0SirwPOqqkJEnNqKStdXDziail/AlFe/5RJEJ51E4TU+GL
         Xmyn999Mskcqo+haGdShV8df5K1lWzfvv9ZHUG5g0MaeavEtOA7Lf3TjimQya9Yiwbfz
         5gX0r7ezkc0Ask6RWJm8OhE8PnG544/dzmsMrQikwTYNfggGhwmniduqsOsqOJEJbqqn
         L20A==
X-Gm-Message-State: AOAM532eTgbe3b/D7xkTcARunAShy4RSkBHAsZBHporF3JC6RsmX7c9F
        K/3pUYx1KXMNH1U62motgGNLL8sUotSlOFyf9MOspA==
X-Google-Smtp-Source: ABdhPJzukk2vfSEOOsuuaBKNsmdttWpkQX+bPlnUwwLP8EDK+Xm51zIp4vtT+4A/Sp/I7zlOyFG6y/3NRMtmV43BhVE=
X-Received: by 2002:a17:90a:e517:: with SMTP id t23mr4735622pjy.25.1600800975989;
 Tue, 22 Sep 2020 11:56:15 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000052569205afa67426@google.com> <20200919110831.GD7462@zn.tnic>
 <CACT4Y+ZhofJhNjfav22YNVpxtH4_+3Qaut6rOiqv4MLNU5mcEg@mail.gmail.com>
 <CACT4Y+b9ZCKJkOmwbEC6sZxEQ-9g2g=-v4+X0aWv7AsrZo7utA@mail.gmail.com>
 <CAKwvOdmKcn=FNzwtBZ8z0evLz4BXgWtsoz9+QTC6GLqtNp1bXg@mail.gmail.com> <20200921221336.GN5901@zn.tnic>
In-Reply-To: <20200921221336.GN5901@zn.tnic>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 22 Sep 2020 11:56:04 -0700
Message-ID: <CAKwvOd=E11KriNqeVv2-Tvq5sQy=4vyBzDEH22D5h5LgBeFsVw@mail.gmail.com>
Subject: Re: general protection fault in perf_misc_flags
To:     Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+ce179bc99e64377c24bc@syzkaller.appspotmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 3:13 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, Sep 21, 2020 at 01:59:43PM -0700, Nick Desaulniers wrote:
> > Right, the two sequences above look almost the same, except those 4
> > bytes of zeros (the disassembler gets confused about the rest, but
> > it's the same byte sequence otherwise).  Are the two disassemblies a
> > comparison of the code at runtime vs. compile-time?
>
> Yes.
>
> > If so, how did you disassemble the runtime code?
>
> ./scripts/decodecode < /tmp/splat
>
> where /tmp/splat contains the line starting with "Code:". Make sure you
> have only one "Code:"-line, otherwise you'll see the code of the *last*
> Code: line only.

Thanks.

> > If runtime and compile time differ, I suspect some kind of runtime
> > patching.
>
> If it is, it ain't patching at the right place. :)

Yeah, but we've had this kind of bug before:
https://nickdesaulniers.github.io/blog/2020/04/06/off-by-two/
I'm sure it's not the last.

> But no, that function is pretty simple and looking at its asm, there's
> no asm goto() or alternatives in there. But that .config might add them.
> It adds a lot of calls to *ASAN helpers and whatnot.

Maybe not in this translation unit, but it's possible another TU does
have one and it miscalculates the offset; overwriting code in another
TU.

> > I wonder if we calculated the address of a static_key wrong
> > (asm goto). What function am I looking at the disassembly of?
> > perf_misc_flags() in arch/x86/events/core.c?
>
> Yes.
>
> > With this config?
> > https://syzkaller.appspot.com/x/.config?x=cd992d74d6c7e62 (though I
> > don't see _any_ asm goto in the IR for this file built with this
> > config).
>
> Right, there should be none.
>
> > If this is deterministically reproducible, I suppose we
> > could set a watchpoint on the address being overwritten?
>
> Sounds like worth a try. I'll go sleep instead, tho. :)

So I think there's an issue with "deterministically reproducible."
The syzcaller report has:
> > Unfortunately, I don't have any reproducer for this issue yet.

Following my hypothesis about having a bad address calculation; the
tricky part is I'd need to look through the relocations and try to see
if any could resolve to the address that was accidentally modified.  I
suspect objtool could be leveraged for that; maybe it could check
whether each `struct jump_entry`'s `target` member referred to either
a NOP or a CMP, and error otherwise?  (Do we have other non-NOP or CMP
targets? IDK)

This hypothesis might also be incorrect, and thus would be chasing a
red herring...not really sure how else to pursue debugging this.

> Gnight and good luck.

Ah, that's a famous quote from journalist Edward R Murrow, who helped
defeat Senator Joseph McCarthy (Murrow's show See It Now dedicated a
segment to addressing McCarthy).  Sometimes I fund uncanny parallels
between claims of what a compiler can do on LKML "without proper
regard for evidence" and McCarthyism.  Falsifiability is an
interesting trait.  That's why I try to advocate for sharing links
from godbolt.org as much as possible.
-- 
Thanks,
~Nick Desaulniers
