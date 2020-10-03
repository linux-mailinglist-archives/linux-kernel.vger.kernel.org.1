Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFF9228259C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 19:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725831AbgJCRdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 13:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgJCRdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 13:33:19 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558B3C0613D0
        for <linux-kernel@vger.kernel.org>; Sat,  3 Oct 2020 10:33:19 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id m17so4909409ioo.1
        for <linux-kernel@vger.kernel.org>; Sat, 03 Oct 2020 10:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MK5uVqASqRoyPGix1z3iLbSJV9eTUDiTtMGnbaIWbDE=;
        b=TtfeTiM6Bu8KDOBYg+UOw+aUjK4K8FSO1lNVk6VODxoFEX7bIGz4XyPR76AWYvEuoj
         KYB4bunpwahtwP/KBoROWdvDiVxUxRv0hn74b4gmAbuaI76fm/QubP643BltlIZsKUyW
         8eKAlmSUnTL8Mug9u7Kq23GJuGNcKWoUG1nQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MK5uVqASqRoyPGix1z3iLbSJV9eTUDiTtMGnbaIWbDE=;
        b=mYdK9jWcApwXsBeFlOiPKLqBAVBML24vgNHTEnF/Bm0V5ydWtW6tROTwJ9QvHZ/MKD
         DTv9qLWBmGWXD+WlbM4FLhjSPuMLhHBTflHokCGuNoFmZZsmsNe2u7NxxAeRwubZvQ34
         IIzGNWbNEriK8d3yUAlkVR7eu+uMNBDTr8fkC9zD/woOQTjBPyVVDJVH9ODnPM7QlU4p
         fe5CwyfLb/Odqw2qd6YFF/aqiB+xTEFR3/Fk1y7cg0OeWW1acXYVM2axyz/oTVN7fZKC
         Lv1xbRmUz1tpxarmB/p8JbLNBlU4SD5NJ22f3aLqg4KOUghzbXYDGhYLvvzJ9e5tm468
         YXoA==
X-Gm-Message-State: AOAM532UM4NBVImtaONyrOgQyjbCD/Rlb9VyfBNOYt49NfG+2ehOTget
        Xu0F/YkURBI+PLzI9rb6V6qcT9GJ3spdm7zKy5h8
X-Google-Smtp-Source: ABdhPJxF5XjTpqjoAoetC0Qpvrxi7mQ4ZOXBEKnuOWzzvzBGYi8KHxY9YWAPoSOX74+9heXweJg8YKy8lpzGfOA3olM=
X-Received: by 2002:a05:6602:18a:: with SMTP id m10mr5823189ioo.174.1601746398592;
 Sat, 03 Oct 2020 10:33:18 -0700 (PDT)
MIME-Version: 1.0
References: <bug-209317-8243@https.bugzilla.kernel.org/> <bug-209317-8243-E6Z0ICootN@https.bugzilla.kernel.org/>
 <20200928111341.7eaa98a8@oasis.local.home> <67278555f143564677878cc849155393a93c018a.camel@wdc.com>
In-Reply-To: <67278555f143564677878cc849155393a93c018a.camel@wdc.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Sat, 3 Oct 2020 10:33:07 -0700
Message-ID: <CAOnJCUJgzWkKixYyFCrqbNF2ONgB_RUOSTB9BhT5D0stnf=vUw@mail.gmail.com>
Subject: Re: [Bug 209317] ftrace kernel self test failure on RISC-V on 5.8,
 regression from 5.4.0
To:     Alan Kao <alankao@andestech.com>, Zong Li <zong.li@sifive.com>
Cc:     "rostedt@goodmis.org" <rostedt@goodmis.org>,
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

Hi Alan and Zong,
I initially suspected ftrace is broken between v5.6 & v5.7 as Kolin pointed out.
I couldn't find any reason how the HSM patch is related. Zong's ftrace
patching code was also merged in that release.
However, I was able to reproduce the issue in the older kernel(v5.4)
as well on both Qemu & Unleashed hardware.
Here are the steps:

mount -t debugfs none /sys/kernel/debug/
cd /sys/kernel/debug/tracing
echo function_graph > current_tracer
echo function > current_tracer

It works for the first time with function_graph but writing any other
tracer crashes immediately.
Can you take a look to check if the bug is in ftrace infrastructure code ?

On Mon, Sep 28, 2020 at 10:25 AM Atish Patra <Atish.Patra@wdc.com> wrote:
>
> On Mon, 2020-09-28 at 11:13 -0400, Steven Rostedt wrote:
> > On Sat, 26 Sep 2020 22:02:35 +0000
> > bugzilla-daemon@bugzilla.kernel.org wrote:
> >
> > > https://bugzilla.kernel.org/show_bug.cgi?id=209317
> > >
> > > --- Comment #4 from Colin Ian King (colin.king@canonical.com) ---
> > > Issue still in 5.9-rc6
> > >
> >
> > Atish,
> >
> > As the issues bisects down to your commit, care to take a look at
> > this.
> > (And take ownership of this bug)
> >
>
> Yes. I am already looking into this. Colin informed me about the bug
> over the weekend.
>
> I couldn't change the ownership as I am not part of the editbugs group.
> I have sent an email to helpdesk@kernel.org for access.
>
> > -- Steve
>
> --
> Regards,
> Atish
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



-- 
Regards,
Atish
