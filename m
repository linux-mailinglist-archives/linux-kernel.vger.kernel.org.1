Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6EA27CF1B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 15:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbgI2N2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 09:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728366AbgI2N2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 09:28:09 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7651AC061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 06:28:09 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id g72so4233643qke.8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 06:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H4Xu8v2b9D8UwDOHwcV+mRXvAw3A7ucBPwQFn9EiYDM=;
        b=pChmh01BoZcT4vmvwK257DST5eFUknl+gpWQyWDhLe1dJQKgXd3zUDHErRScSGFjyc
         weu+dYY509lgKO5ocKe4sGRcpSoXr2wOraKtGYsgfrYBKw6yk9vjRJLVswcMrs9dho4l
         r/hstXOeL1qKzT9/EHqw4bXSzQ+Johei+yyF8cMokxLjXgmUBTTato1xnljmdijsbAqe
         SrNx+3p72y6bm1vLXptouWCvHhrxCiuxfAILykN+BXIl96lmpivYcE18NetGFo5RqDxW
         BOSwbGy7gVjOkwOxQ73rfHgsURfMEb72CeVsikgA1x56QlEKDmWlRrP+Z/DEO7zG+fwr
         TArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H4Xu8v2b9D8UwDOHwcV+mRXvAw3A7ucBPwQFn9EiYDM=;
        b=WtoMMuqpuN9cfSF/sc1B3eRHhDa3EMg3LYWijzb/U/ydae++3BRR1QHG35KJMN3EC9
         hD/cKs0C6C1jmgXfVFav/4BlMPmD4hCE3G2dcxI2VTGHTCDbO9gnYxLnB9/qDHZFaa+6
         4fV2bA8MBxhYsoBm32vvG9fntRWNDWPgw2Rmye2q2+UVvqfjaByjMTPK36iZicgIcQez
         eDmwJSiwo3j+zAv1QHEauo2MkMTK7H2FmIcdHcEqjllhlInt9YO30HpSLO9EEQK/GepM
         /PQkKM3hI9pLbdkzppSlCzFBesly0zqaUUahzmYl9t2LUcmcOHMspSAHSYGVcYmwPF7a
         +s8w==
X-Gm-Message-State: AOAM5331TX8mrTgzZBzcUG2LzS7ZJ6YPUxZohO/IecQvrD6yegh0aglq
        I1VIE2JkXeaDHeSd1W1yHnu3RW0MaZr150db2kwhmg==
X-Google-Smtp-Source: ABdhPJyqbmGsavAB8yUFS34AXESD4CDDCuh3N4I4ZPLZclRBjfBfxDmW+LxtlSaSiPYezgHFp03PI3kFU5qrEtNS6xA=
X-Received: by 2002:a37:5684:: with SMTP id k126mr4127853qkb.43.1601386088243;
 Tue, 29 Sep 2020 06:28:08 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000052569205afa67426@google.com> <20200927145737.GA4746@zn.tnic>
 <CACT4Y+Zxt3-Dj6r53mEkwv24PazPzTxQ7usV1O+RB0bk2FzO8g@mail.gmail.com> <CAKwvOdkdAi2PwiiS=sp0LV_3=8aVsqEJ87w8WyWbvJ==Eu_4Ag@mail.gmail.com>
In-Reply-To: <CAKwvOdkdAi2PwiiS=sp0LV_3=8aVsqEJ87w8WyWbvJ==Eu_4Ag@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 29 Sep 2020 15:27:56 +0200
Message-ID: <CACT4Y+YpSKWELQb3tcnMs_mTQB5Koh_ZYFz2pCYvP4_cTvqCZQ@mail.gmail.com>
Subject: Re: general protection fault in perf_misc_flags
To:     Nick Desaulniers <ndesaulniers@google.com>
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

On Mon, Sep 28, 2020 at 10:33 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Sun, Sep 27, 2020 at 10:18 PM 'Dmitry Vyukov' via Clang Built Linux
> <clang-built-linux@googlegroups.com> wrote:
> >
> > On Sun, Sep 27, 2020 at 4:57 PM Borislav Petkov <bp@alien8.de> wrote:
> > >
> > > On Sat, Sep 19, 2020 at 01:32:14AM -0700, syzbot wrote:
> > > > Hello,
> > > >
> > > > syzbot found the following issue on:
> > > >
> > > > HEAD commit:    92ab97ad Merge tag 'sh-for-5.9-part2' of git://git.libc.or..
> > > > git tree:       upstream
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=1069669b900000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=cd992d74d6c7e62
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=ce179bc99e64377c24bc
> > > > compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> > >
> > > All below is AFAICT:
> > >
> > > This compiler you're using is not some official release but some random
> > > commit before the v10 release:
> > >
> > > $ git show c2443155a0fb245c8f17f2c1c72b6ea391e86e81
> > > Author: Hans Wennborg <hans@chromium.org>
> > > Date:   Sat Nov 30 14:20:11 2019 +0100
> > >
> > >     Revert 651f07908a1 "[AArch64] Don't combine callee-save and local stack adjustment when optimizing for size"
> > > ...
> > >
> > > $ git describe c2443155a0fb245c8f17f2c1c72b6ea391e86e81
> > > llvmorg-10-init-10900-gc2443155a0fb
> > >
> > > The v10 release is:
> > >
> > > $ git show llvmorg-10.0.0
> > > tag llvmorg-10.0.0
> > > Tagger: Hans Wennborg <hans@chromium.org>
> > > Date:   Tue Mar 24 12:58:58 2020 +0100
> > >
> > > Tag 10.0.0
> > >
> > > and v10 has reached v10.0.1 in the meantime:
> > >
> > > $ git log --oneline c2443155a0fb245c8f17f2c1c72b6ea391e86e81~1..llvmorg-10.0.1 | wc -l
> > > 7051
> > >
> > > so can you please update your compiler and see if you can still
> > > reproduce with 10.0.1 so that we don't waste time chasing a bug which
> > > has been likely already fixed in one of those >7K commits.
>
> Oh, shoot, sorry I didn't catch that. Good find.  My next question was
> going to be if this is reproducible with a newer compiler release or
> not (later emails make this sound like it's no longer considered clang
> specific).
>
> Generally we want coverage of unreleased compiler versions to ensure
> we don't ship a broken release.  Once the release exists, it's of
> questionable value to continue to test a pre-release version of that
> branch.
>
> This isn't the first time where we've had syzcaller reports that were
> testing old releases of clang.  Maybe we can establish a process for
> upgrading the toolchain under test based on some time based cadence,
> or coinciding with the upstream LLVM release events?

The current hypothesis is that this bug is not related to clang (there
are similar crashes with gcc as well).
We use unreleased versions of clang as we frequently need recent
fixes/features. And then later nobody usually has time to update, if
things work.
Based on offline discussion with Marco, we probably need to update
KMSAN and KASAN to 11 release when it's released.


> > +Alex, Marco,
> >
> > There is suspicion that these may be caused by use of unreleased clang.
> > Do we use the same clang as we use for the KMSAN instance? But this is
> > not KMSAN machine, so I am not sure who/when/why updated it last to
> > this revision.
> > I even see we have some clang 11 version:
> > https://github.com/google/syzkaller/blob/master/docs/syzbot.md#crash-does-not-reproduce
> >
> > Is it possible to switch to some released version for both KMSAN and KASAN now?
> --
> Thanks,
> ~Nick Desaulniers
