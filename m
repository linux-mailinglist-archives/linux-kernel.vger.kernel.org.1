Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06F3427EF33
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 18:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731291AbgI3Q3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 12:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3Q3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 12:29:40 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B92FC061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 09:29:39 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id q5so2025515qkc.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 09:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JY0B2dX8EdNzyATXC+SxwmmN5kC9QsWUQGW5TuYSORs=;
        b=MThnJ+rhumDXS1ZLsDOZ+uKc2/OXzs+dnTOMT1+OO/9TWRDP1g1lp1CDbXA7SjFK1w
         H3xW/CnUY86XbIVAiYT25jOajftlryNyXpvOgAyCxcdLhjYloHoSfVnJpY/+l1vdqJP1
         MVkcm06LwOVqgkj/gMUMDRBYBdXLKxM8Dgj3NEz+aeNb5xIvskXINGKmJ3qs5I5USZie
         NSKh08MZQnZMyV/LrzgFchhjPkdy4m6FCBscLaqw/xuC5bJucT8EiDEZBBHgof8pEvO1
         0MiFEEDN1OtDZsHJs6Ah2SnmiwCd0/bTA7CNJTz5glgIHhc3P/Vpn/M1Yli5yPKQowNS
         CDDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JY0B2dX8EdNzyATXC+SxwmmN5kC9QsWUQGW5TuYSORs=;
        b=avH6FcPH3ftp8RAW82DuCHiKGG6Yz92ENskYnXUnWm6r09dPktUb2C1/v7FAiXM6eZ
         nEvUzXNkapop9c9Gt8jxt1pKA6AFoKIr2TBcjiiMCsFOFTtfcrQOpil5JOHHIqxEkpAK
         IDasLkcqr6pugJBNwW/prJ7jgnDulDKV285eG0LHMR5Jj7+ItSH6/yU68TtD1h4fFiGi
         lPAbr2jQcwJ2QHvLkYvpIuVAjdkw/7j4sqCk3W9dRjUlHWbatx0r2rmQIlHqb/Hzkvq4
         Qe4aUt9LdLI4KDkmGHFtOARfVMKd6dKRDt3TO8mrt1vwT9Wtb+XdwEMY2ZSDXkC77Mg4
         MXOw==
X-Gm-Message-State: AOAM530UE1fXtQGGw1r/jNaRF6gcvGzrHZ+l9WXuD8pMt3OJuiuWSFeV
        vh74g7RFyT+lElmMHHKuJrpl54yi5RDR19mA8HFai14iOVQbYg==
X-Google-Smtp-Source: ABdhPJyaeEh3TQvllo5L56bOkb/doAinZo32EZaQ1AQwl/Gae7WYD8Zb0RLpM3UwlzjZTDfKEB+zFyGYLUCRpyRhpuQ=
X-Received: by 2002:a37:9c4f:: with SMTP id f76mr3481549qke.250.1601483378431;
 Wed, 30 Sep 2020 09:29:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200927145737.GA4746@zn.tnic> <CACT4Y+Zxt3-Dj6r53mEkwv24PazPzTxQ7usV1O+RB0bk2FzO8g@mail.gmail.com>
 <CACT4Y+ZZH76qg810RzGp6FDLTxJWVqZgkrXSxqgq7AjpPYG9XQ@mail.gmail.com>
 <20200928083819.GD1685@zn.tnic> <CACT4Y+bPFASnmFRKpQ=KY1z+RnTbGmkPU3aikzdXZpKkV03D9A@mail.gmail.com>
 <20200928085401.GE1685@zn.tnic> <CACT4Y+Z4Y6SJJ6iYBhVRiknrWBAD6gGhQXiXLhxPniDNBFJGsA@mail.gmail.com>
 <20200928202353.GI1685@zn.tnic> <20200929083336.GA21110@zn.tnic>
 <CACT4Y+bfKwoZe3SC-BKJkOET1GxGp9tCpLzkae8q1sjWYnmgmw@mail.gmail.com>
 <20200930161711.GH6810@zn.tnic> <CACT4Y+Zc7kD431Aed49U4R6cqzWGAWqEXevnheRHKQRQoEnh7w@mail.gmail.com>
In-Reply-To: <CACT4Y+Zc7kD431Aed49U4R6cqzWGAWqEXevnheRHKQRQoEnh7w@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 30 Sep 2020 18:29:26 +0200
Message-ID: <CACT4Y+ZKp9z90a9xF5cC-X5_7D8zZOoB+337Hh1rt5PysLfbJw@mail.gmail.com>
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

On Wed, Sep 30, 2020 at 6:23 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> > Hi,
> >
> > one more thing I just spotted. The default install of syzkaller here
> > runs the guest with this on the kernel command line:
> >
> > 2020/09/30 17:56:18 running command: qemu-system-x86_64 []string{"-m", "2048",
> > "-smp", "2", "-display", ... "-append", "earlyprintk=serial oops=panic ...
> >  nmi_watchdog=panic panic_on_warn=1 panic=1 ftrace_dump_on_oops=orig_cpu rodata=n
> >                                                                         ^^^^^^^^^^
> >
> > which basically leaves guest kernel's memory RW and it gets caught
> > immediately on vm boot by CONFIG_DEBUG_WX.
> >
> > This pretty much explains why kernel text can get corrupted with a stray
> > pointer write or so. So what's the use case for rodata=n?
> >
> > [    2.478136] Kernel memory protection disabled.
> >                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
>
> Ha!
>
> Here is the answer:
> https://github.com/google/syzkaller/blob/master/tools/create-gce-image.sh#L189
>
> # rodata=n: mark_rodata_ro becomes very slow with KASAN (lots of PGDs)
>
> I have some vague memory that there was some debug double checking
> that pages are indeed read-only and that debug check was slow, but it
> was always executed without rodata=n.


I don't see this is still the case. Diff between 2 boots:

[   11.985152][    T1] Freeing unused kernel image (initmem) memory: 3432K
[   11.986129][    T1] Write protecting the kernel read-only data: 147456k
[   11.990863][    T1] Freeing unused kernel image (text/rodata gap)
memory: 2012K
[   11.992797][    T1] Freeing unused kernel image (rodata/data gap)
memory: 1324K
[   11.993895][    T1] Run /sbin/init as init process

[   11.910396][    T1] Freeing unused kernel image (initmem) memory: 3432K
[   11.911277][    T1] Kernel memory protection disabled.
[   11.911984][    T1] Run /sbin/init as init process

Was it fixed at some point? Was it backported to stable?
