Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE3F1283047
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 08:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbgJEGJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 02:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgJEGJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 02:09:03 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D6DC0613CE
        for <linux-kernel@vger.kernel.org>; Sun,  4 Oct 2020 23:08:58 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id m25so1960790oou.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Oct 2020 23:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kCBZSxC/FP29fE/Ws6xfe29g7TtwaILzV+J6xbNF83k=;
        b=E51RrDlU/B7Rz6fpeRInPIXn4HInasbvRL4pKKymd2dcQpe0efRt9JyNXxpdYUtYFo
         C41xqCZzG+S/mP7rEklopnoOtGqxdk0u2qKfB8f3gYnqlq9IsGM6btrL8nfqZ6VWOhTI
         8QoVWB4xPXht0JfzYYbf+99UvOaDcFsqvwluBd7fi/NRoXagCE3t1NkvIWG7m3Rma7WO
         hN7i62VWuaplGRCq3bGw6++KeMq5kky/quOB39Z0K+f1hYxFJpQB77VtXVgq/1bdUJZp
         Ss2p9pKB6uWDBETHkhoptk4+0lkaeA5Re750lzIT6b4xd8aeW/vO1N9GqCnJkP3SLhmh
         GA3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kCBZSxC/FP29fE/Ws6xfe29g7TtwaILzV+J6xbNF83k=;
        b=CzwlszuicYgSvNO6vyQ/O+03Ax9mzAuI6fPrAJ4dkWhzG2S+KaaU9oHtKfzwfpZ1gn
         gqxlXLpH6ZgUKzL9DDLYM1aqNytYEVwjPT+y6n2KmoKymuklKeqyNTwmp/H7NozsZDpp
         JHysd6Prey5H25KWmHv1DOdX5OFzi7TxuKviG0MNX28vBE/lJKIsd6LOGPQsRIcAS2A1
         OFwMFRtqwcH1fuEddhFL0eI3zNvx1XE6FWa/gNGfqdoLd37LF40DYRmx0+h0JUgqNcv4
         j1MWtvcvziNFpSCEFzlZeBdEzbuuCFbQtJ9IIHkFNTKYMhReQ7afS/tk0nd7Lf17+Lst
         Zgnw==
X-Gm-Message-State: AOAM531pawiH7WU+QmFUSOvhMOcX2hLK90uxdAJ3XE/H1oQSJqoapdWL
        KS0kTPb8hXyQVBbfTpmX39igI4eLCsYT4ZUgdO7Agw==
X-Google-Smtp-Source: ABdhPJyG44xZDiuFnhuykPF2hZg98nAulIycavfPf6wp1BVpHn7Jor2dZopEoCwylvw9nHLhBu+TjjZxJYNMLujruzc=
X-Received: by 2002:a4a:4845:: with SMTP id p66mr10979199ooa.68.1601878137416;
 Sun, 04 Oct 2020 23:08:57 -0700 (PDT)
MIME-Version: 1.0
References: <bug-209317-8243@https.bugzilla.kernel.org/> <bug-209317-8243-E6Z0ICootN@https.bugzilla.kernel.org/>
 <20200928111341.7eaa98a8@oasis.local.home> <67278555f143564677878cc849155393a93c018a.camel@wdc.com>
 <CAOnJCUJgzWkKixYyFCrqbNF2ONgB_RUOSTB9BhT5D0stnf=vUw@mail.gmail.com>
In-Reply-To: <CAOnJCUJgzWkKixYyFCrqbNF2ONgB_RUOSTB9BhT5D0stnf=vUw@mail.gmail.com>
From:   Zong Li <zong.li@sifive.com>
Date:   Mon, 5 Oct 2020 14:08:46 +0800
Message-ID: <CANXhq0qzi2LjYekG0yk876znrpk7tMo+-zT6wR77nhy89rm2kQ@mail.gmail.com>
Subject: Re: [Bug 209317] ftrace kernel self test failure on RISC-V on 5.8,
 regression from 5.4.0
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Alan Kao <alankao@andestech.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "bugzilla-daemon@bugzilla.kernel.org" 
        <bugzilla-daemon@bugzilla.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Atish Patra <Atish.Patra@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Atish,

I can take out some time to take a look at it together, if anyone here
fixes it or has ideas, please share the information, thanks.

On Sun, Oct 4, 2020 at 1:33 AM Atish Patra <atishp@atishpatra.org> wrote:
>
> Hi Alan and Zong,
> I initially suspected ftrace is broken between v5.6 & v5.7 as Kolin pointed out.
> I couldn't find any reason how the HSM patch is related. Zong's ftrace
> patching code was also merged in that release.
> However, I was able to reproduce the issue in the older kernel(v5.4)
> as well on both Qemu & Unleashed hardware.
> Here are the steps:
>
> mount -t debugfs none /sys/kernel/debug/
> cd /sys/kernel/debug/tracing
> echo function_graph > current_tracer
> echo function > current_tracer
>
> It works for the first time with function_graph but writing any other
> tracer crashes immediately.
> Can you take a look to check if the bug is in ftrace infrastructure code ?
>
> On Mon, Sep 28, 2020 at 10:25 AM Atish Patra <Atish.Patra@wdc.com> wrote:
> >
> > On Mon, 2020-09-28 at 11:13 -0400, Steven Rostedt wrote:
> > > On Sat, 26 Sep 2020 22:02:35 +0000
> > > bugzilla-daemon@bugzilla.kernel.org wrote:
> > >
> > > > https://bugzilla.kernel.org/show_bug.cgi?id=209317
> > > >
> > > > --- Comment #4 from Colin Ian King (colin.king@canonical.com) ---
> > > > Issue still in 5.9-rc6
> > > >
> > >
> > > Atish,
> > >
> > > As the issues bisects down to your commit, care to take a look at
> > > this.
> > > (And take ownership of this bug)
> > >
> >
> > Yes. I am already looking into this. Colin informed me about the bug
> > over the weekend.
> >
> > I couldn't change the ownership as I am not part of the editbugs group.
> > I have sent an email to helpdesk@kernel.org for access.
> >
> > > -- Steve
> >
> > --
> > Regards,
> > Atish
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
>
>
>
> --
> Regards,
> Atish
