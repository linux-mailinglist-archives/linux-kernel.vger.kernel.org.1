Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA3EC27B654
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 22:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbgI1UdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 16:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbgI1UdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 16:33:00 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B028C061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 13:33:00 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x22so2191216pfo.12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 13:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=022MB5UvViutFdbXtKWJ6VGGifiGIjQGT/+f3C2X5BY=;
        b=NoPj18WgNhec0QYX9MZ8kfNwH7cnM3fgMKVS08JdvNhSGDE1UKenWD8EAY+BxLHt4N
         lhZsTYFAcHhMcpEH34DfmOyFjDAcuEsEAY1U1L2dl6oMerOBXkL6QfNBmFZOArwb5hTm
         tfiE0AnKi4fST1CL5etiJDlxNV2K16CKFAE1fM4DCkuy38u1j/tusM/mC39qyBx7G7uJ
         q68k3gsUfLXDLZkgX5OzbYz47SWrlBZ25uK8VpoHR5X8VkYD0rkI3A+Jy8JcN6VkW6oV
         IYzOYWbiaw67LWJjWoVPTzD6KkBqPxHr1FE36f3e4r7Hzxdvy2NZNw1+Wfcsr7GkOkm1
         MxwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=022MB5UvViutFdbXtKWJ6VGGifiGIjQGT/+f3C2X5BY=;
        b=UbG1AEleWZh4h8TFPF3+sS6UTZTS3w/1uS/5OtmKppkemvjTbu0n1HTV26Jp5r/tDo
         LPsPqXJ1oFJ72jeG8APWaJpMyBKgleLJ9maNN5GCIcRbrtXe1r3vI/ubW64tpPOTNlqq
         hfT8+/N0fGTAjSP1ZJdw9Gj3wPl6cJDtL9JpQatECI4HBxZGElZ0LRZFwVSAINz38nhu
         zLRTbFXX302hwt0ih8SUNfcogE9R8MDjI5SHbTww9RbcMD4FdkRV4TFTBGAH2hVhvO0w
         p5jRBlGv2fhT5JLQFwbSFoR1cCuuaW9jQe3OocClRtzZg+LB1xpsYpjA1EFbcgT5ulir
         E1Kw==
X-Gm-Message-State: AOAM533QZrEu/+5GEB2GWJh7XKQf3OqNwMAm4bzBuf4Q0SiqvO+FVb+/
        Y98vmJYwwwBO9nLyhBrSmu5dR0LIFu+qHZJHjwjuvA==
X-Google-Smtp-Source: ABdhPJwHAmE69z8mkim2n/OT/maVWQ/SLtorRPWkomU9EXgYrVJ3gp7dNXMq1AfJKujjghUPlz6AC5WclapGWhARzsA=
X-Received: by 2002:a17:902:ed11:b029:d1:f385:f4e7 with SMTP id
 b17-20020a170902ed11b02900d1f385f4e7mr1131531pld.56.1601325179369; Mon, 28
 Sep 2020 13:32:59 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000052569205afa67426@google.com> <20200927145737.GA4746@zn.tnic>
 <CACT4Y+Zxt3-Dj6r53mEkwv24PazPzTxQ7usV1O+RB0bk2FzO8g@mail.gmail.com>
In-Reply-To: <CACT4Y+Zxt3-Dj6r53mEkwv24PazPzTxQ7usV1O+RB0bk2FzO8g@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 28 Sep 2020 13:32:47 -0700
Message-ID: <CAKwvOdkdAi2PwiiS=sp0LV_3=8aVsqEJ87w8WyWbvJ==Eu_4Ag@mail.gmail.com>
Subject: Re: general protection fault in perf_misc_flags
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
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

On Sun, Sep 27, 2020 at 10:18 PM 'Dmitry Vyukov' via Clang Built Linux
<clang-built-linux@googlegroups.com> wrote:
>
> On Sun, Sep 27, 2020 at 4:57 PM Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Sat, Sep 19, 2020 at 01:32:14AM -0700, syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    92ab97ad Merge tag 'sh-for-5.9-part2' of git://git.libc.or..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=1069669b900000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=cd992d74d6c7e62
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=ce179bc99e64377c24bc
> > > compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> >
> > All below is AFAICT:
> >
> > This compiler you're using is not some official release but some random
> > commit before the v10 release:
> >
> > $ git show c2443155a0fb245c8f17f2c1c72b6ea391e86e81
> > Author: Hans Wennborg <hans@chromium.org>
> > Date:   Sat Nov 30 14:20:11 2019 +0100
> >
> >     Revert 651f07908a1 "[AArch64] Don't combine callee-save and local stack adjustment when optimizing for size"
> > ...
> >
> > $ git describe c2443155a0fb245c8f17f2c1c72b6ea391e86e81
> > llvmorg-10-init-10900-gc2443155a0fb
> >
> > The v10 release is:
> >
> > $ git show llvmorg-10.0.0
> > tag llvmorg-10.0.0
> > Tagger: Hans Wennborg <hans@chromium.org>
> > Date:   Tue Mar 24 12:58:58 2020 +0100
> >
> > Tag 10.0.0
> >
> > and v10 has reached v10.0.1 in the meantime:
> >
> > $ git log --oneline c2443155a0fb245c8f17f2c1c72b6ea391e86e81~1..llvmorg-10.0.1 | wc -l
> > 7051
> >
> > so can you please update your compiler and see if you can still
> > reproduce with 10.0.1 so that we don't waste time chasing a bug which
> > has been likely already fixed in one of those >7K commits.

Oh, shoot, sorry I didn't catch that. Good find.  My next question was
going to be if this is reproducible with a newer compiler release or
not (later emails make this sound like it's no longer considered clang
specific).

Generally we want coverage of unreleased compiler versions to ensure
we don't ship a broken release.  Once the release exists, it's of
questionable value to continue to test a pre-release version of that
branch.

This isn't the first time where we've had syzcaller reports that were
testing old releases of clang.  Maybe we can establish a process for
upgrading the toolchain under test based on some time based cadence,
or coinciding with the upstream LLVM release events?

>
> +Alex, Marco,
>
> There is suspicion that these may be caused by use of unreleased clang.
> Do we use the same clang as we use for the KMSAN instance? But this is
> not KMSAN machine, so I am not sure who/when/why updated it last to
> this revision.
> I even see we have some clang 11 version:
> https://github.com/google/syzkaller/blob/master/docs/syzbot.md#crash-does-not-reproduce
>
> Is it possible to switch to some released version for both KMSAN and KASAN now?
-- 
Thanks,
~Nick Desaulniers
