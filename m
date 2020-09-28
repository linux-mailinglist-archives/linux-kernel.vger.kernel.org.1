Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A864F27B6B2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 22:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgI1UwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 16:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgI1UwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 16:52:11 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E34C061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 13:52:11 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 197so1951613pge.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 13:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E18yvgxr+dgDZ8P7S30cmV0usuEJVg+uMENH9hDolXk=;
        b=qhphk1yOGvZaci0uNcdLhvAY0Nm4YjlOFSTTt4DS11k5JYA/2/MuGen08tFXeptLsI
         zei1FfvI8M9uRJHfOApRsa4DQDWJxY9UqrTt0Q2l8+rdkA+4U6XFeEieR2QuTYbFMzJv
         0Ro8v9FHLQ/cjsnzphEYpQcTDZLz9INdl9XSCklILr/gBpXqcJle7v2XeX7tGVIMZaZ/
         BOub9/HvIlNuffP65vMlKGXzS6NrmzQcCGj6KoFRqwfui3iZ30MYxt+QMF6FKFy1WKlK
         AHcWz5DhYs7KDcu8QoVB0IYVSkXtgFrqmwEAQWr9oW8oz8tRv/LmgUPpVjHx5GK6oCAI
         EE6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E18yvgxr+dgDZ8P7S30cmV0usuEJVg+uMENH9hDolXk=;
        b=tw/dcdunFlN9GC54b6yinrlbmh35rkseDRDgJRTXq4o9bZiZNVLavyht/3iBRnISam
         3Zfxx1NBs4xW4Tct5375Q7P+WhY5YC1vUnr98QXNsnaxu7i8KjzimHkoeKKUTy/VmOu2
         zWy6JqF1Caw9E6VxcFtzFxVLx3h1DUP4HF/5/sxPhN6WIZ/0vaf2aO6c2MQuP5FL66dN
         BPhvwaaJ5tVbNiQRigW4eUo58OVIQjO+RPxkt0zQC19kPAA1ZADQlHUG2BjwUXZ/AnSo
         LU/VxrSsIkij/509K97+6f2Ksx1GnAj3vtIkLQVEdDb/LAJK6zeIgaBNMy/wsO7QF2pC
         QXAQ==
X-Gm-Message-State: AOAM530Hse/q7riFSluHM3AVU+23oalWClMfCTPGtZJfbJUqIRF4mxLN
        CeBlWnKlhQh/4TTZeG3EuPs4xhY9u/233T2IMiPJnA==
X-Google-Smtp-Source: ABdhPJyOpOvP3F8ukyvf3cS1yn54mNQ9MQiMewRhlNJLvUfcEzV4xnS29EQ/UovZfNYpkCNzjcH5Ab//ZMvyhkV3gs8=
X-Received: by 2002:a63:28c9:: with SMTP id o192mr617964pgo.381.1601326330804;
 Mon, 28 Sep 2020 13:52:10 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000052569205afa67426@google.com> <20200927145737.GA4746@zn.tnic>
 <CACT4Y+Zxt3-Dj6r53mEkwv24PazPzTxQ7usV1O+RB0bk2FzO8g@mail.gmail.com>
 <CACT4Y+ZZH76qg810RzGp6FDLTxJWVqZgkrXSxqgq7AjpPYG9XQ@mail.gmail.com>
 <20200928083819.GD1685@zn.tnic> <CACT4Y+bPFASnmFRKpQ=KY1z+RnTbGmkPU3aikzdXZpKkV03D9A@mail.gmail.com>
 <20200928085401.GE1685@zn.tnic> <CACT4Y+Z4Y6SJJ6iYBhVRiknrWBAD6gGhQXiXLhxPniDNBFJGsA@mail.gmail.com>
In-Reply-To: <CACT4Y+Z4Y6SJJ6iYBhVRiknrWBAD6gGhQXiXLhxPniDNBFJGsA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 28 Sep 2020 13:51:58 -0700
Message-ID: <CAKwvOdmTm2rVdc2JTSVVadKP3DONRcPXSE-s3tFPqHgCSieH7Q@mail.gmail.com>
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

On Mon, Sep 28, 2020 at 3:34 AM 'Dmitry Vyukov' via Clang Built Linux
<clang-built-linux@googlegroups.com> wrote:
>
> On Mon, Sep 28, 2020 at 10:54 AM Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Mon, Sep 28, 2020 at 10:40:19AM +0200, Dmitry Vyukov wrote:
> > > I meant the kernel self-corrupts itself, that just wasn't detected by
> > > KASAN, page protections, etc.
> >
> > Well, Nick already asked this but we're marking all kernel text RO early
> > during boot. So it either is happening before that or something else
> > altogether is going on.

On Sun, Sep 27, 2020 at 11:06 PM 'Dmitry Vyukov' via Clang Built Linux
<clang-built-linux@googlegroups.com> wrote:
>
> Interestingly there is a new crash, which looks similar:
>
> general protection fault in map_vdso
> https://syzkaller.appspot.com/bug?extid=c2ae01c2b1b385384a06
>
> The code is also with 4 0's:
> Code: 00 00 00 48 b8 00 00 00 00 00 fc ff df 41 57 49 89 ff 41 56 41
> 55 41 54 55 65 48 8b 2c 25 c0 fe 01 00 48 8d bd 28 04 00 00 53 <48> 00
> 00 00 00 fa 48 83 ec 10 48 c1 ea 03 80 3c 02 00 0f 85 51 02
>
> But it happened with gcc.
>
> Also I found this older one:
> general protection fault in map_vdso_randomized
> https://syzkaller.appspot.com/bug?id=8366fd024559946137b9db23b26fd2235d43b383
>
> which also has code smashed and happened with gcc:
> Code: 00 fc ff df 48 89 f9 48 c1 e9 03 80 3c 01 00 0f 85 eb 00 00 00
> 65 48 8b 1c 25 c0 fe 01 00 48 8d bb 28 04 00 00 41 2b 54 24 20 <00> 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

If this is related to vdso's, they seem mapped as `r-xp` (not `w):
$ sudo cat /proc/1/maps | grep vdso
7ffc667f5000-7ffc667f7000 r-xp 00000000 00:00 0                          [vdso]

map_vdso() in arch/x86/entry/vdso/vma.c doesn't map the VMA as
writable, but it uses VM_MAYWRITE with a comment about GDB setting
breakpoints.

So it sounds like the page protections on the vdso can be changed at
runtime (via mprotect).  Maybe syzkaller is tickling that first?

map_vdso_randomized() does call map_vdso().  Maybe if we mprotect the
vdso to be writable, it may be easier to spot the write.

-- 
Thanks,
~Nick Desaulniers
