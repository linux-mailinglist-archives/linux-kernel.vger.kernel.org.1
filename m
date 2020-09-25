Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D539278710
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 14:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgIYMXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 08:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727248AbgIYMXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 08:23:00 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215D3C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 05:23:00 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id e7so1610574qtj.11
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 05:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JiwHunS73dKhzMvuruWEdSZBTGiMntQmhlw2d9kKF/g=;
        b=RaEYAZyMGMIoGSW2BGdldXQO3drMp78uAOUNdZWmtOvAmvrNMB83DkVs1sU+EdK+vX
         jt/vAtjXKdHeGQxzML0VKsdyTahxAvwVtqnmJ9AZ/xT3FucZJtrqt/WtXImbKJnFuUK2
         Gk6yAT0apPA+SN1McyqgpGm5FtNhaQgMXuHZh1JVR5iPuPrfgSv9zRVY2gJFZdY9N0Lc
         n9LTpqZzss8dC5ECoDAP8f+jnuuMzR3EOUqC9VUE5zhNh/TgwO7cIjqUxLREgH+i8VMo
         n4iTygX1f89Hywqi/5v37JQUzNjH8tcq84PP0oHrIj/etA5mwcTtjGBAgWUdmh7h6a4u
         r41g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JiwHunS73dKhzMvuruWEdSZBTGiMntQmhlw2d9kKF/g=;
        b=Fpoep27Tz/Ej8QaZGA7igDp5G76hS7XaLVrgKyKM02JybLZii60ZQQwP2eVDti+BSo
         ZmDlPgtsrMm3GzUePjbRE9WA3rt6Y6k1j5rWwiAc9ukNtfwZA9qcASU6NLmDmkjNDM1+
         eNnsbUFZhP4BWGH4gsp81QuBKl+BgUBV55eu2Sa4JVDl8tgCi9OFPmmuq+l93hdYNyew
         eg+5v4spFzqVT4weho/z9Zb9vhLwpcbqeO1Utn0hrSAxfspFyzY7bvOJCikKxonuwI76
         Tlz3cMFV3iNgaa1aqDZQ72Kj+o8qwsaTZ5ZI4JGvy4S82375urwtX1kD43tvdY2k2BHM
         Pl6g==
X-Gm-Message-State: AOAM532EKfJxvXPVsV50TM347Nn1HutyXM36IIZhNQE50IM12uNxoA0K
        LtdDQqzC+CfHJGspPCrq6DyuIwQSNDJR4Zq0TUSwpQ==
X-Google-Smtp-Source: ABdhPJws0L/vacfbEcOsg6IKEchMzkUlgnq6GAfHWUrhCoS9hDF5oSiav2fAMewuaMCaa714dxufzQb39vW92/dZNeA=
X-Received: by 2002:aed:26a7:: with SMTP id q36mr4018858qtd.57.1601036578995;
 Fri, 25 Sep 2020 05:22:58 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000052569205afa67426@google.com> <20200919110831.GD7462@zn.tnic>
 <CACT4Y+ZhofJhNjfav22YNVpxtH4_+3Qaut6rOiqv4MLNU5mcEg@mail.gmail.com>
 <CACT4Y+b9ZCKJkOmwbEC6sZxEQ-9g2g=-v4+X0aWv7AsrZo7utA@mail.gmail.com>
 <CAKwvOdmKcn=FNzwtBZ8z0evLz4BXgWtsoz9+QTC6GLqtNp1bXg@mail.gmail.com>
 <20200921221336.GN5901@zn.tnic> <CAKwvOd=E11KriNqeVv2-Tvq5sQy=4vyBzDEH22D5h5LgBeFsVw@mail.gmail.com>
 <20200923090336.GD28545@zn.tnic> <CACT4Y+Y4-vqdv01ebyzhUoggUCUyvbhjut7Wvj=r4dBfyxLeng@mail.gmail.com>
 <20200923103431.GF28545@zn.tnic> <CACT4Y+ayTBwBwsnV9Kp-vMQ=hgu9-r9g4qzAfd+HdQXX95PX9g@mail.gmail.com>
In-Reply-To: <CACT4Y+ayTBwBwsnV9Kp-vMQ=hgu9-r9g4qzAfd+HdQXX95PX9g@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 25 Sep 2020 14:22:47 +0200
Message-ID: <CACT4Y+bjyAfO-TRjBHT9wR194=prH2C284Oc9akVVHR1492WZA@mail.gmail.com>
Subject: Re: general protection fault in perf_misc_flags
To:     Borislav Petkov <bp@alien8.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
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

On Wed, Sep 23, 2020 at 5:20 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Wed, Sep 23, 2020 at 12:34 PM Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Wed, Sep 23, 2020 at 11:24:48AM +0200, Dmitry Vyukov wrote:
> > > 3. Run syzkaller locally with custom patches.
> >
> > Let's say I wanna build the kernel with clang-10 using your .config and
> > run it in a vm locally. What are the steps in order to reproduce the
> > same workload syzkaller runs in the guest on the GCE so that I can at
> > least try get as close as possible to reproducing locally?
>
> It's a random fuzzing workload. You can get this workload by running
> syzkaller locally:
> https://github.com/google/syzkaller/blob/master/docs/linux/setup_ubuntu-host_qemu-vm_x86-64-kernel.md
>
> The exact clang compiler syzbot used is available here:
> https://github.com/google/syzkaller/blob/master/docs/syzbot.md#crash-does-not-reproduce

I've marked all other similar ones a dup of this one. Now you can see
all manifestations on the dashboard:
https://syzkaller.appspot.com/bug?extid=ce179bc99e64377c24bc

Another possible debugging vector on this:
The location of crashes does not seem to be completely random and
evenly spread across kernel code. I think there are many more static
branches (mm, net), but we have 3 crashes in vdso and 9 in paravirt
code + these 6 crashes in perf_misc_flags which looks a bit like an
outlier (?). What's special about paravirt/vdso?..
