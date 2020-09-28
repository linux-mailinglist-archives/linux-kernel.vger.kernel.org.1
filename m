Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA7DC27A881
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 09:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgI1HZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 03:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgI1HZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 03:25:15 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35ADAC0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 00:25:15 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id 60so8765423otw.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 00:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jml2neKeP5LvDDGsfQfoMJWoSSFjKlccfEpIy6JbJzg=;
        b=c9tNr+0Sf8lZSRvtQbSe9kz8QQjv+dseeGRXmj2HyERSbc4Qpgay2plrHZ/88sgP/k
         YagyDPo9uMHOOUMb9j24ZOz0ygMCnywlnMKiPYfFKdXYHtTzKJqbfewERiW26eg+2IgB
         JAJSppUt8I0/oyaDaUAGv9AeJYfahhpXuSatV0jjMukn4Su7NvLG1e6I5OH00+zTrSbM
         RphdrkVsaEbAR30T0BCHX7e/ktEfr/Cg44FBtcNjnBw6S2qnbArhrEOfFnj3y/Af9/Y3
         PITAb1TOl/4Uuhq0DB5SH1nyCWuLSYyktexiZfqhNXsSoXTRL1GUjNSGjWjC9fY/OVU/
         EkLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jml2neKeP5LvDDGsfQfoMJWoSSFjKlccfEpIy6JbJzg=;
        b=Ml6bF9QXfsK/5iwX+Qx67AJ0an2H1sGiqMAYJn802+XX9qVwxVLyzkQIrmja8DE++H
         H2a0ARrLVvfsToyoL9CG97Q52oA4dih4jgwd0HHCYyyseKwUovWjbwH+oB7jyYVq5DqO
         eXkrmKLb8w7LlTdERxcioJ3HaigBAB4Y3nH/wfsHrjAAQkls7mKW6/DR/HZjbhGxZQDg
         niFu07ymL8PEVRzhzBuwEVp8mzc/RwjTypV0wT/SgCRGelV/GRN/n8/DJE07fldpkTP8
         isMSFYnjq1E7BrAWWLLouOJZYNftW4eUUKjqRDEdL0ppz9Sjbp/qT8Eeo7sOy73W1Vx2
         NRwA==
X-Gm-Message-State: AOAM5314ypm6e0vKn/Z8G/aotqSk4rD70EWDVnSoIlIGBfBKMLyBtxGl
        5MM1aekxZyG1xt1f0xoi/7IbF5CDj0OoYe3tLV0wSg==
X-Google-Smtp-Source: ABdhPJxOW6W4XCiLFCFv0Vpb67Sb416PTR6EILccVp+ZcRJczEvoAHSyG+Sc2DgGuRBVv24MDN/T1eZrnKTkq3I1hQg=
X-Received: by 2002:a9d:66a:: with SMTP id 97mr94939otn.233.1601277914299;
 Mon, 28 Sep 2020 00:25:14 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000052569205afa67426@google.com> <20200927145737.GA4746@zn.tnic>
 <CACT4Y+Zxt3-Dj6r53mEkwv24PazPzTxQ7usV1O+RB0bk2FzO8g@mail.gmail.com>
In-Reply-To: <CACT4Y+Zxt3-Dj6r53mEkwv24PazPzTxQ7usV1O+RB0bk2FzO8g@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 28 Sep 2020 09:25:03 +0200
Message-ID: <CANpmjNN9o_OUbZozzcQMHD8ynBBVeFFgp-4wK4J_U1JH=OGVsg@mail.gmail.com>
Subject: Re: general protection fault in perf_misc_flags
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Alexander Potapenko <glider@google.com>,
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

On Mon, 28 Sep 2020 at 07:18, Dmitry Vyukov <dvyukov@google.com> wrote:
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
>
> +Alex, Marco,
>
> There is suspicion that these may be caused by use of unreleased clang.
> Do we use the same clang as we use for the KMSAN instance? But this is
> not KMSAN machine, so I am not sure who/when/why updated it last to
> this revision.
> I even see we have some clang 11 version:
> https://github.com/google/syzkaller/blob/master/docs/syzbot.md#crash-does-not-reproduce

Yeah, we should replace that one as well as it wasn't yet a release-candidate.

> Is it possible to switch to some released version for both KMSAN and KASAN now?

We should probably just switch to Clang 11-rc3 or so. Then we can use
the same compiler for KMSAN and KCSAN at least.

I can package up a newer Clang.

Thanks,
-- Marco
