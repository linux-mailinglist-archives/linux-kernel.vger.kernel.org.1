Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF47A28CBD8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 12:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391491AbgJMKf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 06:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729241AbgJMKf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 06:35:58 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E027BC0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 03:35:57 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id y198so20343881qka.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 03:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oZff7kcW8qMLSQ7Z5nJuF5tI8xNEF6CR77sfQ6ACJ/A=;
        b=MwmtW4R1h0az/eilx2Db/6T9WrLNHgH4MUotrXunMIaURuhbB1nwAIwg5/suNSnqwJ
         3Mnks7pGFFYMSJbJvKxFy0XSrniAqnAq1iWLJU8W8ouwp9U+ovztBGXrxlcl/oYT4Smz
         BD30Igq9gDpWSBYK7WL63mxpINPilpktRbiqv5hVXxIoVp4aHn4HElPVqvg/NIrUomgL
         pcGiUAmoF1zZmQIFeM3PuAAtUVOTT5RArXKfIO+p9wPfHyCRKUTthGcVYQXvNfSMZdrq
         Z9zLdARwrPt2yxUullPwfsMoKz9Vxq4LmUZqEom0IVHlslWnkcrZgjGkO3e8jv3eI4qt
         fsqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oZff7kcW8qMLSQ7Z5nJuF5tI8xNEF6CR77sfQ6ACJ/A=;
        b=Rd2KLWmHCrggNMEqdMQf5BHaeAxSCppsMHX8lsrKxF1Wr3KYgHah9MfHa+wDI0Ewdb
         ICp3BZ+y907bDnmYecENWMGgn2sQz3ixYPsDpEsyJDHU+8V7BQtyRz2PxzL1E6/JPygf
         hJCx4BNXQGsi6EPhTLccPNBhGPTBhRehxZ2e4jcB7QvsrgR7VSVaIqaVGYiuXdmaIZEt
         wy3ZCljwf5m1iOrCdBBRghBuYn+4XZkQbQ93yUa8BEr13EWtzfSdy022RrBb1+knQpuY
         Zt0VU41u/D+LK+vhEqSfNr+JMV8I1vLQAuaJykx0MJ38rGZuTD1xxVSvymEXrMyUKEA9
         glpg==
X-Gm-Message-State: AOAM5323YWrCLy/n4DoaGD6SbLfHW3UfsD9qS6q2AipJ8bKkn4ORUeai
        Uqf2xeIizFhm7l1Egg7YJU4RvWArzl60u0TbFdcakg==
X-Google-Smtp-Source: ABdhPJytGS4oTrB1TT6L4k5jZlt5lbrhXJIjYzGiDHmv8OQfKiONAhUpWAX4jJ1wzD6FQG7sEWZXrBzNBWFHNlo5pdA=
X-Received: by 2002:a05:620a:54f:: with SMTP id o15mr13972701qko.91.1602585356785;
 Tue, 13 Oct 2020 03:35:56 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000903b5c05b1732a75@google.com> <CAK8P3a3p7Ueydagr4yshr8RKGzLivJZwEh0TxfipuHYRkN9Wcw@mail.gmail.com>
 <CACT4Y+aXuBZbvwM1xJNPhG+dHCdjt_Are=p6wRwOk-DFHEGz2Q@mail.gmail.com>
 <CAK8P3a28w8kw9MJVx_Cada3c8tQBHT0xXheS2EmGdRgT=2jp6Q@mail.gmail.com>
 <CACT4Y+ZR9LMRHHYazd7okt0HpA+WjXDpXW9VM50KM7ozd1m+bQ@mail.gmail.com> <CAK8P3a1Grz==fg5vqVSc3jGpzQa7AV1m_B0F7QYaVWJ0mnVu4w@mail.gmail.com>
In-Reply-To: <CAK8P3a1Grz==fg5vqVSc3jGpzQa7AV1m_B0F7QYaVWJ0mnVu4w@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 13 Oct 2020 12:35:45 +0200
Message-ID: <CACT4Y+ZW0Z7KzWD4sURfPLga4CcdeVaO_wxTF9=Cz_TeR=TDNA@mail.gmail.com>
Subject: Re: general protection fault in qp_release_pages
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     syzkaller <syzkaller@googlegroups.com>, rgerganov@vmware.com,
        syzbot <syzbot+f58fe4bb535845237057@syzkaller.appspotmail.com>,
        gregkh <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 11:51 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Oct 12, 2020 at 11:29 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> > On Mon, Oct 12, 2020 at 11:16 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > There is already a recorded fix for this on the dashboard:
> > >
> > > Ok, good.
> > >
> > > > https://syzkaller.appspot.com/bug?extid=f58fe4bb535845237057
> > > > VMCI: check return value of get_user_pages_fast() for errors
> > >
> > > Ah, I actually looked at linux-next, which included the fix. I had
> > > never before looked at the dashboard, good to know where to find
> > > this information.
> > >
> > > If this is something that happened to others as well, could the
> > > email report be changed to point out bugs that are already
> > > fixed in linux-next but not in mainline?
> >
> > When syzbot mails a report, it does not know about any fixes by definition.
> >
> > There is a pending feature request to notify when a fix becomes known:
> > https://github.com/google/syzkaller/issues/1574
>
> Ok, I see.
>
> > However:
> > 1. This will double the number of emails from syzbot, not sure if it
> > will be welcome.
>
> It's only doubled if you assume that all bugs get fixed, right?
> Probably good to stay hopeful on that ;-)
>
> > 2. This probably only makes sense for fixes that are auto-discovered
> > in git trees. While this one came from a user email, it was just not
> > sent to the same thread/recipients (the common problem of replying to
> > emails you did not receive). So it would not help in this case.
> > 3. There is lots of other dynamic info on the dashboard (more crashes,
> > where it happens, how frequently, when started/stopped). It's not
> > feasible to send an email for every update (there can be 100K
> > crashes), so the dashboard needed to be looked at in some cases
> > anyway.
> >
> > Do you see any potential improvements in this context?
>
> I would personally prefer the extra emails here. Usually by the
> time I decided to ignore a thread, getting more replies to it
> doesn't bother me. I understand others may feel differently here.

Just to clarify you asking for syzbot to repeat all commands sent to
it? Basically a developer sends an email "this commit fixes this bug"
and syzbot will send another email saying "this commit fixes this
bug", right? Or something else?

> Making the dashboard link more prominent, or pointing out in
> the email that it can contain newer information might help,
> though I probably would have missed that as well, as I tend
> to look at the oops output first. This was the first time I recall
> that I looked at the reproducer source, which I found very
> useful, but had probably missed in the past as well.

I am not sure this is easily solvable problem.
If we include too much information into emails (also duplicated in
each of them), even fewer people will read walls of text. So anything
added to the text will just reduce the usefulness of existing info.
If we include too little info, people will not be aware of things. And
lots of kernel developers still say "I am opening any web pages". So
we need to include e.g. the kernel config.
Adding "walls of text" to explain every bit may be the opposite effect
as well. And we have a whole lot of potential info to include, see the
"more information about syzbot" link in every email.
Ted Ts'o specially suggested the current condensed/dry format. Once
one learns what's available/where, I can see how such a format is the
most handy one.

Having said that, if you have concrete suggestions on the format that
are not over-tailored to hindsight on this particular case/person, and
that balances between having too much/little info, that's welcome.
