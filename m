Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36F13283EF3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 20:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728919AbgJESrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 14:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgJESrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 14:47:19 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48195C0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 11:47:19 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id g7so10266716iov.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 11:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FY+LqDabhhgCzF/kHUiBASBrGmAFBGdYjQoHH5CUHuk=;
        b=D8ti+2Pu9A3A7OT9eu5u8g809BBk1hASH2RdiLyOGvjrIfeX7mcLWCLc2RBZLm2PDg
         KnQUmSkt41Tk+Km3Q92kCAsB5Nw+5z1uCG42UUt59OHSQ1ga51b3ESs6fegFK8mqig2G
         8OD2rZzjxIO1M5dYgWyIhSBpB4O7EdeF656Qs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FY+LqDabhhgCzF/kHUiBASBrGmAFBGdYjQoHH5CUHuk=;
        b=U6aT4gazJW3MWCH19vhN6QCylCESv0rXIfXtyAh/6YgDi6n2tqS6wu01z8k0GnKs34
         Ghwl07D6Tmio9PEf3Y/gJO15AyZKNY1q2BOH1WffkYZWUM04BQcHetiuOVy6ndg0cw3q
         MRCs//Mphg+YYMGgggRVSsFalAAgWQ9x9bCxwk2MW3T2ZSNLgzYLlEXkQlsPbFP7x5dU
         CgJYceXbNIyYCpF3lUGJwLhNetArneB//6Fu2cEPbcLLGXun+gtWlU+Ouls7mwYE3pjD
         KcbwKurSmiVa9mOUKXKLp4Lkpp2Dt7g9Ykepl8HMt0pB4YbVwbQ3CmWMA0M3MLet2uo8
         xtzw==
X-Gm-Message-State: AOAM53273GFvoUFcIyDBwDZCdj3WLiXmFuYjzij+vy7A9yv3/J64Tls3
        qG4YKRJKyb9TbmnfJV1fncID04SdteJ3dmsxKUnpCVEvXQ4thgs=
X-Google-Smtp-Source: ABdhPJwBWJVGjbpxIiKdfK3X5F9BKCLWk5LXkXrOV6AiTriAM780Wu2t637zT39lnDE4ZAH0aldf8qHoIsKQ3RUi+Pg=
X-Received: by 2002:a5d:9842:: with SMTP id p2mr996172ios.113.1601923638595;
 Mon, 05 Oct 2020 11:47:18 -0700 (PDT)
MIME-Version: 1.0
References: <bug-209317-8243@https.bugzilla.kernel.org/> <bug-209317-8243-E6Z0ICootN@https.bugzilla.kernel.org/>
 <20200928111341.7eaa98a8@oasis.local.home> <67278555f143564677878cc849155393a93c018a.camel@wdc.com>
 <CAOnJCUJgzWkKixYyFCrqbNF2ONgB_RUOSTB9BhT5D0stnf=vUw@mail.gmail.com> <CANXhq0qzi2LjYekG0yk876znrpk7tMo+-zT6wR77nhy89rm2kQ@mail.gmail.com>
In-Reply-To: <CANXhq0qzi2LjYekG0yk876znrpk7tMo+-zT6wR77nhy89rm2kQ@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Mon, 5 Oct 2020 11:47:07 -0700
Message-ID: <CAOnJCULU7qy35vhiFcJKHFgbe+w5Gn2q_SskjjbjtM3X90uT_g@mail.gmail.com>
Subject: Re: [Bug 209317] ftrace kernel self test failure on RISC-V on 5.8,
 regression from 5.4.0
To:     Zong Li <zong.li@sifive.com>
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

On Sun, Oct 4, 2020 at 11:08 PM Zong Li <zong.li@sifive.com> wrote:
>
> Hi Atish,
>
> I can take out some time to take a look at it together, if anyone here
> fixes it or has ideas, please share the information, thanks.
>

Thanks. I observed this in case it helps.

Across kernels, the panic trace seems to point out the one of the
first two functions after patching is corrupted.
rcu_momentary_dyntick_idle or stop_machine_yield[1]

[1]https://elixir.bootlin.com/linux/v5.9-rc7/source/kernel/stop_machine.c#L213

I am suspecting nop was not replaced with the correct auipc+jalr pair?

> On Sun, Oct 4, 2020 at 1:33 AM Atish Patra <atishp@atishpatra.org> wrote:
> >
> > Hi Alan and Zong,
> > I initially suspected ftrace is broken between v5.6 & v5.7 as Kolin pointed out.
> > I couldn't find any reason how the HSM patch is related. Zong's ftrace
> > patching code was also merged in that release.
> > However, I was able to reproduce the issue in the older kernel(v5.4)
> > as well on both Qemu & Unleashed hardware.
> > Here are the steps:
> >
> > mount -t debugfs none /sys/kernel/debug/
> > cd /sys/kernel/debug/tracing
> > echo function_graph > current_tracer
> > echo function > current_tracer
> >
> > It works for the first time with function_graph but writing any other
> > tracer crashes immediately.
> > Can you take a look to check if the bug is in ftrace infrastructure code ?
> >
> > On Mon, Sep 28, 2020 at 10:25 AM Atish Patra <Atish.Patra@wdc.com> wrote:
> > >
> > > On Mon, 2020-09-28 at 11:13 -0400, Steven Rostedt wrote:
> > > > On Sat, 26 Sep 2020 22:02:35 +0000
> > > > bugzilla-daemon@bugzilla.kernel.org wrote:
> > > >
> > > > > https://bugzilla.kernel.org/show_bug.cgi?id=209317
> > > > >
> > > > > --- Comment #4 from Colin Ian King (colin.king@canonical.com) ---
> > > > > Issue still in 5.9-rc6
> > > > >
> > > >
> > > > Atish,
> > > >
> > > > As the issues bisects down to your commit, care to take a look at
> > > > this.
> > > > (And take ownership of this bug)
> > > >
> > >
> > > Yes. I am already looking into this. Colin informed me about the bug
> > > over the weekend.
> > >
> > > I couldn't change the ownership as I am not part of the editbugs group.
> > > I have sent an email to helpdesk@kernel.org for access.
> > >
> > > > -- Steve
> > >
> > > --
> > > Regards,
> > > Atish
> > > _______________________________________________
> > > linux-riscv mailing list
> > > linux-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> >
> >
> >
> > --
> > Regards,
> > Atish



-- 
Regards,
Atish
