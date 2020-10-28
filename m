Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3343829DB78
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 00:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387927AbgJ1Xsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 19:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388132AbgJ1Wra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:47:30 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379B4C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:47:30 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id e7so654850pfn.12
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8dsDQVIrTeiVaQn0+YikICoRD6YYLVo8eieDDGEHOmw=;
        b=BMnrYLP/FlDv1guYf4LJrT7iwl+32rOeCT86qzOC2OzfoHWRg+kGtGUYLd1xse6q7g
         IU5AhRc8sLKygI6ouJGbH4XVm6z4/FgouaUO/XWkmU74jGQJZ5lj3Ph8BN0qsgxANvkG
         EMjZ1edi+YxqQg2i3WFaI3lnlwKMjoHslfyng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8dsDQVIrTeiVaQn0+YikICoRD6YYLVo8eieDDGEHOmw=;
        b=X6cN2JNjCyKMG2mC5XNMXlPDgTffEBBk1xmantB7VLzTu0x0jJxBSSPQp8REUxEYSh
         pDu9BLW+tfQD4Py60X8piRGyMHBt6jHtGvZgPCSX8KYsEoUKsC02/XitSQ6EyNVZ/SNY
         KdYS+okL3htKY9TvaZYJfC0w+DR/0Rcw0hjkXN7IX+Zy57OLoNzEMVplmsnFKGoTwdLc
         kCWiwrgUufPPPXtcntNP+7A0+Tne7i+FK6e22F15R7mjzPY0mh5BW89QieP9SDN33p+i
         0ze1FJsGiLNUCyF/OQnkVvs+4BmaUa1Z95jJaKeyeFKCj1VUEYvbng6UG0Zls+UQmqKu
         K2qQ==
X-Gm-Message-State: AOAM532sxkwtxc+f6QGuUIYEARmP3C+CudB1Tgn7H6jCaavRIZpdyKdG
        VnGJaLEFblIWpMf3PBwbn4ZDBQ==
X-Google-Smtp-Source: ABdhPJyLt4RLkTl/dHh/LdmLUj+G3F41wfCLO/YktcnEoezHfkHtkCejY5sv6XOaEPogLZraAwE1+A==
X-Received: by 2002:a17:90b:148c:: with SMTP id js12mr1081593pjb.175.1603925249626;
        Wed, 28 Oct 2020 15:47:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z20sm609909pfk.199.2020.10.28.15.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 15:47:28 -0700 (PDT)
Date:   Wed, 28 Oct 2020 15:47:27 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Camille Mougey <commial@gmail.com>
Cc:     lkml <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Rich Felker <dalias@libc.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Denis Efremov <efremov@linux.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [seccomp] Request for a "enable on execve" mode for Seccomp
 filters
Message-ID: <202010281503.3D1FCFE0@keescook>
References: <CAAnLoWnS74dK9Wq4EQ-uzQ0qCRfSK-dLqh+HCais-5qwDjrVzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAnLoWnS74dK9Wq4EQ-uzQ0qCRfSK-dLqh+HCais-5qwDjrVzg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 12:18:47PM +0100, Camille Mougey wrote:
> (This is my first message to the kernel list, I hope I'm doing it right)

Looks good to me! The key was CCing real people. ;)

> From my understanding, there is no way to delay the activation of
> seccomp filters, for instance "until an _execve_ call".
> But this might be useful, especially for tools who sandbox other,
> non-cooperative, executables, such as "systemd" or "FireJail".
> [...]
> I only see hackish ways to restrict the use of _execve_ in a
> non-cooperative executable. These methods seem globally bypassables
> and not satisfactory from a security point of view.
> 
> IMHO, a way to prepare filter and enable them only on the next
> _execve_ would have some benefit:
> * have a way to restrict _execve_ in a non-cooperative executable;
> * install filters atomically, ie. before the _execve_ system call
> return. That would limit racy situations, and have the very firsts
> instructions of potentially untrusted binaries already subject to
> seccomp filters. It would also ensure there is only one thread running
> at the filter enabling time.
> 
> From what I understand, there is a relative use case[2] where the
> "enable on exec" mode would also be a solution.
> 
> Thanks for your attention,
> C. Mougey
> 
> [1]: https://github.com/netblue30/firejail/issues/3685
> [2]: https://lore.kernel.org/linux-man/202010250759.F9745E0B6@keescook/

Just to restate things already said in the thread and to try to illustrate
with more clarity, I tend to organize my thinking about seccomp usage
into three categories:

1- self-confinement
2- launching external processes
	a) cooperating
	b) oblivious

I classify things like Chrome's complex tree of related processes and
filters as 1, since it's all one thing together.

I think of systemd, docker, minijail, FireJail, etc all as falling into
category 2, with some variation about how to deal with 2a or 2b. I see
systemd as weakly covering both 2a and 2b: e.g. services are documenting
what restrictions they want, etc. minijail has stronger 2b coverage as
it attempts to do PRELOAD tricks (which it sounds like FireJail does
too?) (Aside: why doesn't systemd do any self-confinement?)

We don't have much possibility for the targets in the 2a realm as far
as cooperating over how to _manage_ confinement, but rather about simply
expecting confinement to exist, or adding more confinement on their own.

So, what would adding delayed filters gain in the above classifications?

Both 1 and 2 would benefit from some simplification over how to apply
filters (e.g. the referenced relative complexity of needing to pass the
USER_NOTIF fd up to the supervisor).

Dealing with 2b is improved by allowing execve itself to be blocked.

If we turn this:

	fork
	prepare & apply
	exec

into this:

	fork
	prepare
	exec & apply

for 2a, this isn't too interesting since a 2a target could just give up
execve after it launched. For 2b, though, it's pretty meaningful to gain
further isolation of an oblivious (and assumingly untrusted) process
(given all the hacks needed to try to cover the situation).

And to clarify, 2a would much prefer this to be able to separate
initialization from runtime:

fork
prepare
exec
other things
apply

And just for completeness, none of this is useful at all for 1, which
doesn't even "see" the fork from its perspective:

exec
other things
prepare & apply

How should 2a targets indicate they're ready? Can it be done passively
(in the sense that libc would make some seccomp call to apply the
delayed filters), or does it need to stay explicit? (e.g. can we turn
a pre-untrusted-input 2b into a 2a just by having the libc make calls?)
My instinct is that hiding it won't gain much over a "on-execve" case,
but having an explicit call that means "I'm done initializing now" would
be a meaningful synchronization point -- except I note that it just means
the target could just as easily start doing its own confinement anyway,
which means they effectively move from 2a to 1, and now we don't care
about delayed filters any more.

So, lacking a clearer sync point, execve() does seem to stand out to me.

The other idea which was touched on in the thread was very direct
management (e.g. ptrace) and the supervisor waits until some point and
then forces the filters to apply on the target. What would be more
light-weight than this? (Or rather, what kinds of things would such a
ptracer be looking for to mark "I've started"?)

Since I've got bitmaps on my mind, what about a syscall bitmap that
triggers the application of delayed filters? The supervisor is launching
a daemon: mark NR_listen as the apply-point. The supervisor is launching
something totally unknown: mark NR_execve as the apply-point.

If we did that, what happens to non-delayed filters applied between
program start and the apply-point getting tripped?

-- 
Kees Cook
