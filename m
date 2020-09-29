Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC7FF27CF28
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 15:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729723AbgI2NaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 09:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728695AbgI2NaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 09:30:11 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C51C061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 06:30:11 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id k25so3493889qtu.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 06:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oQxzCBvncWwKEr1jaMROUiPcwtGNmTTNLCla3c+790M=;
        b=NvwRZopyBlKls40E7kZsnYwKZAhkWrrRZMJy/6GUk2JWOfE60HMcBTffGv0/OYPqFW
         Uf8slR2/IQw6IwEMK1i7nxHsMOogmwOByPcDcoP2GBUhti1qA0IPt3EAG3MZxxZUasnm
         ZEbVOBQh/+1UToDPCMsB9LPoIZrDpvZpOZA5sxucB5dcRU/eZpmPzzuAIEbK2rkzdt5j
         lW1nH/zyUoC3VB5cEmOVVijv2c3RUrP5PdultzLrM6KjhPf9rJXymiWvafxNnix0HEcQ
         tEvgC28UcTCvSaSuBhe/zJIrNGrO72A21x5sxoFps10HUPbMKd3zN9hwcZgOTBVNz7N2
         43uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oQxzCBvncWwKEr1jaMROUiPcwtGNmTTNLCla3c+790M=;
        b=BhNvwreYt2Rle+O3Ct6x1i65BDjyrMtzFv0E6BZ+X/zeD+7f3sulnpsdsjciXLSm3a
         VhVyIyJoajm5YCSJRBY4qmSoKC9LSLtlHNrm9wYhRWBGG7m2vAiaUBiV1YJq4iIw4o/K
         sNEIAvHf3eRHUylSFws/SPeO9MO1HvxqPLRi76MeUQI6O/s+EHzyitr7BZSZdXZFfZOy
         XIbcbO9vYY6Bn5GGP/Ss/m4/ZJv7PrsLhd6ELKVAOG9s3jqL+40sAlKvlJtMH9k7SsI9
         DjEHRvs/VS38Rssf5Qp9hTKiGZWkoEiVoNQv0t2x2fMOHDMj7d9jwfPN8JtAc3mDz9j1
         bQGQ==
X-Gm-Message-State: AOAM532NL5b+V8rmIMHBblLHRLyBsCQJy/vY0Y4y5muV1jkzPNtGiJ+L
        F84SlYegugZO/y0JfiSQUDK7vP0d92gqBS5MvnkuCQ==
X-Google-Smtp-Source: ABdhPJy3IQHtfKJCwtFWnYd3yfT0lHuxKJ6jRqQ78UhIwpmVJo4dB/xQ/DQrFYYvrQuukEPWMX/O/jo8w+EZ00n3FtE=
X-Received: by 2002:aed:26a7:: with SMTP id q36mr3232229qtd.57.1601386209826;
 Tue, 29 Sep 2020 06:30:09 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000052569205afa67426@google.com> <20200927145737.GA4746@zn.tnic>
 <CACT4Y+Zxt3-Dj6r53mEkwv24PazPzTxQ7usV1O+RB0bk2FzO8g@mail.gmail.com>
 <CACT4Y+ZZH76qg810RzGp6FDLTxJWVqZgkrXSxqgq7AjpPYG9XQ@mail.gmail.com>
 <20200928083819.GD1685@zn.tnic> <CACT4Y+bPFASnmFRKpQ=KY1z+RnTbGmkPU3aikzdXZpKkV03D9A@mail.gmail.com>
 <20200928085401.GE1685@zn.tnic> <CACT4Y+Z4Y6SJJ6iYBhVRiknrWBAD6gGhQXiXLhxPniDNBFJGsA@mail.gmail.com>
 <20200928202353.GI1685@zn.tnic> <20200929083336.GA21110@zn.tnic>
In-Reply-To: <20200929083336.GA21110@zn.tnic>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 29 Sep 2020 15:29:58 +0200
Message-ID: <CACT4Y+bfKwoZe3SC-BKJkOET1GxGp9tCpLzkae8q1sjWYnmgmw@mail.gmail.com>
Subject: Re: general protection fault in perf_misc_flags
To:     Borislav Petkov <bp@alien8.de>
Cc:     Alexander Potapenko <glider@google.com>,
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
        clang-built-linux <clang-built-linux@googlegroups.com>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 10:33 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, Sep 28, 2020 at 10:23:53PM +0200, Borislav Petkov wrote:
> > 2020/09/28 22:21:01 VMs 3, executed 179, corpus cover 11792, corpus signal 10881, max signal 19337, crashes 0, repro 0
>
> Ok, so far triggered two things:
>
> WARNING in f2fs_is_valid_blkaddr        1       2020/09/29 10:27        reproducing
> WARNING in reiserfs_put_super           1       2020/09/28 22:42
>
> you've probably seen them already.
>
> Anyway, next question. Let's say I trigger the corruption: is there a
> way to stop the guest VM which has triggered it so that I'm able to
> examine it with gdb?
>
> What about kdump? Can I dump the guest memory either with kdump or
> through the qemu monitor (I believe there's a command to dump memory) so
> that it can be poked at?
>
> Because as it is, we don't have a reproducer and as I see it, the fuzzing simply
> gets restarted:
>
> 2020/09/29 10:27:03 vm-3: crash: WARNING in f2fs_is_valid_blkaddr
> ...
> 2020/09/29 10:27:05 loop: phase=1 shutdown=false instances=1/4 [3] repro: pending=0 reproducing=1 queued=1
> 2020/09/29 10:27:05 loop: starting instance 3
>
> so it would be good to be able to say, when a vm encounters a crash, it
> should be stopped immediately so that the guest can be examined through
> qemu's gdb interface, i.e.,
>
> -gdb tcp::<portnum>
>
> or so?

Currently there is no such feature. I think some people did it because
something similar was mentioned on the mailing IIRC, but I don't know
how they did it, probably with some local code changes.
