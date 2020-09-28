Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACB927A737
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 08:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgI1GGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 02:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbgI1GGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 02:06:32 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFF9C0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 23:06:32 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id n10so7313960qtv.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 23:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QFn+0NLLcstHF4oViRUUZIB6ljirkEV5COOiFgccFNU=;
        b=b9szbW2TpSjxF/CGLqTeOgN7Z3kjewYOochBmA/DxorZGNtdZ8YWm9AOogc+xxwah3
         bIUDPlBHq5HS7O8weA7IR2vGiCjvWcN3f40RVpKh54ZxXkamH64i7kINhCiz+QYEt6y5
         o9yQsODQMxza9qxx9UIaiedP9eZo1YeLHaKIXASs7/7Hapq63GXZWbZM0bo3ELf11XgC
         IwNspin25qn0eh1uhf+vIbysvN0Kk8Vw9EoCb/lDu/S6Z+/UEj193mvCRzOiFl1W/hPy
         0aGq3n5xT4zrZvyFipnNqbytVu3gDqIAGG+fIjWJDJjQDMUX8Tkx8gZaBJ++FUBSFCQQ
         XjqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QFn+0NLLcstHF4oViRUUZIB6ljirkEV5COOiFgccFNU=;
        b=VbrI5h5FIfMX37TDIzjgKFAR8uAPP/ScYF7q4y1wpDMU9RUOXONKio2W9CK9QqTYa1
         RN+5FeWtSNEaZqtpVzktlxivemHNOZfaojzK1CDn/cGro15URyHU9lx13xOvufWkXZEf
         A8OVFyzx0fmtsVcVaWVPI6SxaQKD8XSg6i+yjLsFaXbj50l3+ajqzFu3SaBXE1jfL02/
         +4I0BDxBPTV2hZHCumKe/H1wXJNiEZoFAdPgO6EEHKj5mkSJA4a1aXkjhn72Mf1v2rgk
         /uVja+Iq/i1O8VyqI/+SO2FwSTVyr7fB3cMblNUmppxjKdtPXZ1tZ5G0Ei3DDWB04TDb
         35mQ==
X-Gm-Message-State: AOAM532b4iip9pkM7/hXhQbLD1Sd4bDcQAqC5pse/ne+WK90LFYI1jq0
        a9M/hzPt787Nv3PfmbHFJB+1iPQliodktzEE2M5Cag==
X-Google-Smtp-Source: ABdhPJwf3ysUB6d/9n01nR6drKA9FVftec0UL1LdiyDpiMui4YJ2O2DGe8LMw6ykzwnGEMs+gBd6NykvDq4SLLn/6+k=
X-Received: by 2002:ac8:4658:: with SMTP id f24mr126882qto.158.1601273191291;
 Sun, 27 Sep 2020 23:06:31 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000052569205afa67426@google.com> <20200927145737.GA4746@zn.tnic>
 <CACT4Y+Zxt3-Dj6r53mEkwv24PazPzTxQ7usV1O+RB0bk2FzO8g@mail.gmail.com>
In-Reply-To: <CACT4Y+Zxt3-Dj6r53mEkwv24PazPzTxQ7usV1O+RB0bk2FzO8g@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 28 Sep 2020 08:06:19 +0200
Message-ID: <CACT4Y+ZZH76qg810RzGp6FDLTxJWVqZgkrXSxqgq7AjpPYG9XQ@mail.gmail.com>
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

On Mon, Sep 28, 2020 at 7:18 AM Dmitry Vyukov <dvyukov@google.com> wrote:
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

Interestingly there is a new crash, which looks similar:

general protection fault in map_vdso
https://syzkaller.appspot.com/bug?extid=c2ae01c2b1b385384a06

The code is also with 4 0's:
Code: 00 00 00 48 b8 00 00 00 00 00 fc ff df 41 57 49 89 ff 41 56 41
55 41 54 55 65 48 8b 2c 25 c0 fe 01 00 48 8d bd 28 04 00 00 53 <48> 00
00 00 00 fa 48 83 ec 10 48 c1 ea 03 80 3c 02 00 0f 85 51 02

But it happened with gcc.

Also I found this older one:
general protection fault in map_vdso_randomized
https://syzkaller.appspot.com/bug?id=8366fd024559946137b9db23b26fd2235d43b383

which also has code smashed and happened with gcc:
Code: 00 fc ff df 48 89 f9 48 c1 e9 03 80 3c 01 00 0f 85 eb 00 00 00
65 48 8b 1c 25 c0 fe 01 00 48 8d bb 28 04 00 00 41 2b 54 24 20 <00> 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

I think there may be dozens older ones here:
https://syzkaller.appspot.com/upstream#moderation2
e.g. this one where code also looks strange:
https://syzkaller.appspot.com/bug?id=651c61721c822bfdcdae8bfb9320e4a9b4bd49c9

Maybe it's just a random silent memory corruption in the end?...
