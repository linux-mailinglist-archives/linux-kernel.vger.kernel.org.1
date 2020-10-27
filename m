Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC1429A9AA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 11:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898134AbgJ0K2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 06:28:52 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45032 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2898094AbgJ0K2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 06:28:50 -0400
Received: by mail-lj1-f196.google.com with SMTP id a5so1115816ljj.11
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 03:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SXBs8vJX4cJod5E0ma8hUPOwIJojpK61dnpKV/ODZKw=;
        b=SX3vumt+l2xFwFJ7RtGU6f2QwqvLXBNvJIBGPSr2ScNXfHRvXmCpg0n+1g5TYU5nLS
         er6t1l0zNORBj09H+ZooUZPlhEvAKaZMbyK0tHvjx0xf52Lc9zV+/VxaRuXfwO4j3DZS
         BSNoLT8j8uzFqjMddbNAbinjHbTmVWxpugf1ax7hBpEqrp2fvnzsaWEb4iG/OB2c4AIp
         FrLQX+f5C4iZYd6tWM5RnEW7S020S60vUQngFeSZlbJMHUEJWPe4WaELOPFP4YaGQrF2
         Er58dEZ1XpSNCN8LI1ddVAiSEzdRCBcuY84l0Wi5OvgFYxs5XmBA8iYYSQdbkdikXUET
         gTzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SXBs8vJX4cJod5E0ma8hUPOwIJojpK61dnpKV/ODZKw=;
        b=BiQ0sp/PB8PQW3gUbQ+wYs1qMgX5BqBffQhU+joQ63ccrddnAJ/BNbK1zI9MyJZOzN
         ksZRz6djcTqjg1ZgeXFuT6JFr7CN5iZyQPm9K9CVkVY++nzITMCZ+mDIk8DvPBm9mS4O
         PpSltIHtETjp5f4sG7124T0dKYaJAYVv7cbr3gw52ARkQms1xMo2faXq6pAndjOsl/1r
         zqfmtEIKoS4QjPPg9P1Asg0CD7URG8qsYNbJbJkWt+xscYS/Hyk6rx5MyUWA8/A2cg0y
         Lzw8oF7VXO1c4c3k47LnNnYT/f+5tdm/IMNIWTdyAOkEpWuV3jm6sm6REs8L2FqFA2ss
         TWjw==
X-Gm-Message-State: AOAM531IjmFTQHDPzO5GXDbWtYa9XaF/22mYdOMYtvwtDkxWRxrLxQ8M
        M6bRLSjwyhIh69KY6Z4tU02O89eFh2V01Qa6yAOjWQ==
X-Google-Smtp-Source: ABdhPJxJshhNft3hUOxXAULUlOUPgHVANJYgBC/Mm8PWirgk1D2JwvX0yuxEiO1qIxFs4Z4pw393eScZt+DPrsMeX1c=
X-Received: by 2002:a2e:9c84:: with SMTP id x4mr750615lji.326.1603794527981;
 Tue, 27 Oct 2020 03:28:47 -0700 (PDT)
MIME-Version: 1.0
References: <45f07f17-18b6-d187-0914-6f341fe90857@gmail.com>
 <20200930150330.GC284424@cisco> <8bcd956f-58d2-d2f0-ca7c-0a30f3fcd5b8@gmail.com>
 <20200930230327.GA1260245@cisco> <CAG48ez1VOUEHVQyo-2+uO7J+-jN5rh7=KmrMJiPaFjwCbKR1Sg@mail.gmail.com>
 <20200930232456.GB1260245@cisco> <CAG48ez2xn+_KznEztJ-eVTsTzkbf9CVgPqaAk7TpRNAqbdaRoA@mail.gmail.com>
 <CAG48ez3kpEDO1x_HfvOM2R9M78Ach9O_4+Pjs-vLLfqvZL+13A@mail.gmail.com>
 <656a37b5-75e3-0ded-6ba8-3bb57b537b24@gmail.com> <CAG48ez2Uy8=Tz9k1hcr0suLPHjbJi1qUviSGzDQ-XWEGsdNU+A@mail.gmail.com>
 <e2643168-b5d5-4d8c-947a-7895bcabc268@gmail.com>
In-Reply-To: <e2643168-b5d5-4d8c-947a-7895bcabc268@gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 27 Oct 2020 11:28:20 +0100
Message-ID: <CAG48ez2Nb95ae+XwZPYRju1KO-Ps_4R6QxN6ioUhOy2Uok=uAg@mail.gmail.com>
Subject: Re: For review: seccomp_user_notif(2) manual page
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     Tycho Andersen <tycho@tycho.pizza>,
        Sargun Dhillon <sargun@sargun.me>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian@brauner.io>,
        linux-man <linux-man@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Will Drewry <wad@chromium.org>, bpf <bpf@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andy Lutomirski <luto@amacapital.net>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Robert Sesek <rsesek@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 7:14 AM Michael Kerrisk (man-pages)
<mtk.manpages@gmail.com> wrote:
> On 10/26/20 4:54 PM, Jann Horn wrote:
> > I'm a bit on the fence now on whether non-blocking mode should use
> > ENOTCONN or not... I guess if we returned ENOENT even when there are
> > no more listeners, you'd have to disambiguate through the poll()
> > revents, which would be kinda ugly?
>
> I must confess, I'm not quite clear on which two cases you
> are trying to distinguish. Can you elaborate?

Let's say someone writes a program whose responsibilities are just to
handle seccomp events and to listen on some other fd for commands. And
this is implemented with an event loop. Then once all the target
processes are gone (including zombie reaping), we'll start getting
EPOLLERR.

If NOTIF_RECV starts returning -ENOTCONN at this point, the event loop
can just call into the seccomp logic without any arguments; it can
just call NOTIF_RECV one more time, see the -ENOTCONN, and terminate.
The downside is that there's one more error code userspace has to
special-case.
This would be more consistent with what we'd be doing in the blocking case.

If NOTIF_RECV keeps returning -ENOENT, the event loop has to also tell
the seccomp logic what the revents are.

I guess it probably doesn't really matter much.
