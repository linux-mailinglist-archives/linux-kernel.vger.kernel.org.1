Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E822327A6DD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 07:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgI1FSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 01:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbgI1FSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 01:18:22 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DFBC0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 22:18:22 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id v54so7237683qtj.7
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 22:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d2XXl28aJw72nA+d+RIQVO2h1O+NhlGZHiug4WRWF1k=;
        b=oEiMtOX4tv+N/ipnpC90sce1bwWBxfeLkQplhIHwSlJ4L+jYbuXk6MSINPxLxkd7G3
         kt8+oiLImDlatI05cMk2sZPyG/8FbuGan/9n2r/UP3j9tkrM+Jy407bpyp52NdMiULLA
         AMA2XG3c8DVxfBzLG3n/ZwmmG387wj3ettz0kGkz6ohQyReuZSyDJmq/xYCbOInJXyXG
         0U8va+W/1ZEmXA4WAo8nq7m4X8mbjl+yXYdUPc76iQ0aLiVBA50c5w6KX/f/slwlOqmv
         ZAd9k5dpvGoSTQw5mHjzgAytMCZwmPHRF7gZMyRYkN91wO/1V8nJl8/Hp8CgwsX+2aOy
         rR9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d2XXl28aJw72nA+d+RIQVO2h1O+NhlGZHiug4WRWF1k=;
        b=UczzPkghEjhtKp6IH2zxF7OSMHpl1UmmYdaT/omZtGY3P49XvF3tov+ibhVUpDMafx
         nY1nCP/FJye/PJzDiwEqtgJ/CI3Bh08C/R97Ej8nXmLb9ARnfWu9YS0VXFpYgb042sUW
         P6RvkfZ5KKZISbFCdO17jVO+9QemZJ+dC9X1xv70m8nrlZNJk3HZ9gREKxcbsG0WaesG
         gR/PeE+HDVUrpOEln1mgCIpBYAhuwkTotHo424ObMZ4NfHZXBPCUxWJA/jF66VUgqjEy
         p/Fk7CyYH6hUWilXxoZo6y9MS9/9AIwzgZnA4w2gWfx3DiZf97ASKo9tHNVUbL1t3SeA
         36og==
X-Gm-Message-State: AOAM531IzUO7on1M3uA3rUulGNXbkKCIMyXWbJTdyn0ZThGSCcvvLhry
        DCh63v5YYE0U6X+TC1Wz3QXU0yheNMyg8qbYtbNT9A==
X-Google-Smtp-Source: ABdhPJxMO4G/stod5eTtGPTKoTSY3zfvpENNDbPSHcWqQYLCucPg6GdyzDwK72U7L8F3+/Bj8mfvaSOJlhiR+mjNf0M=
X-Received: by 2002:ac8:4806:: with SMTP id g6mr12484qtq.380.1601270301549;
 Sun, 27 Sep 2020 22:18:21 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000052569205afa67426@google.com> <20200927145737.GA4746@zn.tnic>
In-Reply-To: <20200927145737.GA4746@zn.tnic>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 28 Sep 2020 07:18:10 +0200
Message-ID: <CACT4Y+Zxt3-Dj6r53mEkwv24PazPzTxQ7usV1O+RB0bk2FzO8g@mail.gmail.com>
Subject: Re: general protection fault in perf_misc_flags
To:     Borislav Petkov <bp@alien8.de>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     syzbot <syzbot+ce179bc99e64377c24bc@syzkaller.appspotmail.com>,
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

On Sun, Sep 27, 2020 at 4:57 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Sat, Sep 19, 2020 at 01:32:14AM -0700, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    92ab97ad Merge tag 'sh-for-5.9-part2' of git://git.libc.or..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1069669b900000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=cd992d74d6c7e62
> > dashboard link: https://syzkaller.appspot.com/bug?extid=ce179bc99e64377c24bc
> > compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
>
> All below is AFAICT:
>
> This compiler you're using is not some official release but some random
> commit before the v10 release:
>
> $ git show c2443155a0fb245c8f17f2c1c72b6ea391e86e81
> Author: Hans Wennborg <hans@chromium.org>
> Date:   Sat Nov 30 14:20:11 2019 +0100
>
>     Revert 651f07908a1 "[AArch64] Don't combine callee-save and local stack adjustment when optimizing for size"
> ...
>
> $ git describe c2443155a0fb245c8f17f2c1c72b6ea391e86e81
> llvmorg-10-init-10900-gc2443155a0fb
>
> The v10 release is:
>
> $ git show llvmorg-10.0.0
> tag llvmorg-10.0.0
> Tagger: Hans Wennborg <hans@chromium.org>
> Date:   Tue Mar 24 12:58:58 2020 +0100
>
> Tag 10.0.0
>
> and v10 has reached v10.0.1 in the meantime:
>
> $ git log --oneline c2443155a0fb245c8f17f2c1c72b6ea391e86e81~1..llvmorg-10.0.1 | wc -l
> 7051
>
> so can you please update your compiler and see if you can still
> reproduce with 10.0.1 so that we don't waste time chasing a bug which
> has been likely already fixed in one of those >7K commits.

+Alex, Marco,

There is suspicion that these may be caused by use of unreleased clang.
Do we use the same clang as we use for the KMSAN instance? But this is
not KMSAN machine, so I am not sure who/when/why updated it last to
this revision.
I even see we have some clang 11 version:
https://github.com/google/syzkaller/blob/master/docs/syzbot.md#crash-does-not-reproduce

Is it possible to switch to some released version for both KMSAN and KASAN now?
