Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5807029E59F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 09:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387585AbgJ2H66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388297AbgJ2H6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:58:47 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2595C0613D5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:58:45 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id n5so2132119ile.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Wq5fpCHrMBuFTB2QNVd//i6YNTRAUpxgQC8MH5O1L34=;
        b=qhO9+w89SolKYFjXpeTRf+jYzx+EM6WmmH+t5IuUTSDzTgSDOt4jizcozDqzvB+2r6
         fDg0lZAANXMrgIFPoIn/eO2Sksm46UIfkBPkUXCaMHhWgN68SmmwuTx1O4MLAklFJiRm
         6b6h08vXOlFt5KwAQiMS2JfuNEU7t6vJ+wdIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Wq5fpCHrMBuFTB2QNVd//i6YNTRAUpxgQC8MH5O1L34=;
        b=k+jjemR4B9Ggl8iWQI9hC+Q5h9pzTLeEkyZOn1PPNsbau90BE5WpG2nUd4bEdjTFy3
         +rWc7geMr5r028lKeRS1YUIqQnlttWtu7EvFdiU/gQEmOzVcnfjlS156hf/52NU9mXM9
         ZxP3sqGQi+Tl4eOiuZPFPRe9nhrQ2UIGCOkrmtXv4GiLeCulQdQgj+erIjLcaJZx59O5
         s1muUXXvK91F4rwco91xVaoOPgYmFOhmyr5rlcWQhySUrko6TQYAnIP8hoyb9ZoG/lv1
         ivxglwA4rNespT6MC0CFP0adzAmlX2aDd7od8LdoN/bIH4Hgb6JHJkDyxZiyXHMn5PQb
         ZEZg==
X-Gm-Message-State: AOAM531z6GtpQV8zXFN/kIonRPsgKAb/vVJk3EgevZ4w8Re9l6y+Cyys
        ncVg9yG6D2ZcBkmR1v9zvUXwzQ==
X-Google-Smtp-Source: ABdhPJzDPNLUEv6jAgXuicT8nX3ypWo9gLOqWizDgRU/eYIev5jvY/FM/mXVNEzZ0nXi5XZD8sMK4w==
X-Received: by 2002:a92:b712:: with SMTP id k18mr2301921ili.291.1603958324936;
        Thu, 29 Oct 2020 00:58:44 -0700 (PDT)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id t2sm1572856iob.5.2020.10.29.00.58.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Oct 2020 00:58:44 -0700 (PDT)
Date:   Thu, 29 Oct 2020 07:58:42 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     Kees Cook <keescook@chromium.org>
Cc:     Camille Mougey <commial@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Rich Felker <dalias@libc.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Denis Efremov <efremov@linux.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [seccomp] Request for a "enable on execve" mode for Seccomp
 filters
Message-ID: <20201029075841.GB29881@ircssh-2.c.rugged-nimbus-611.internal>
References: <CAAnLoWnS74dK9Wq4EQ-uzQ0qCRfSK-dLqh+HCais-5qwDjrVzg@mail.gmail.com>
 <202010281503.3D1FCFE0@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202010281503.3D1FCFE0@keescook>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 03:47:27PM -0700, Kees Cook wrote:
> On Wed, Oct 28, 2020 at 12:18:47PM +0100, Camille Mougey wrote:
> > (This is my first message to the kernel list, I hope I'm doing it right)
> 
> Looks good to me! The key was CCing real people. ;)
> 
> > From my understanding, there is no way to delay the activation of
> > seccomp filters, for instance "until an _execve_ call".
> > But this might be useful, especially for tools who sandbox other,
> > non-cooperative, executables, such as "systemd" or "FireJail".
> > [...]
> > I only see hackish ways to restrict the use of _execve_ in a
> > non-cooperative executable. These methods seem globally bypassables
> > and not satisfactory from a security point of view.
> > 
> > IMHO, a way to prepare filter and enable them only on the next
> > _execve_ would have some benefit:
> > * have a way to restrict _execve_ in a non-cooperative executable;
> > * install filters atomically, ie. before the _execve_ system call
> > return. That would limit racy situations, and have the very firsts
> > instructions of potentially untrusted binaries already subject to
> > seccomp filters. It would also ensure there is only one thread running
> > at the filter enabling time.
> > 
> > From what I understand, there is a relative use case[2] where the
> > "enable on exec" mode would also be a solution.
> > 
> > Thanks for your attention,
> > C. Mougey
> > 
> > [1]: https://github.com/netblue30/firejail/issues/3685
> > [2]: https://lore.kernel.org/linux-man/202010250759.F9745E0B6@keescook/
> 
> Just to restate things already said in the thread and to try to illustrate
> with more clarity, I tend to organize my thinking about seccomp usage
> into three categories:
> 
> 1- self-confinement
> 2- launching external processes
> 	a) cooperating
> 	b) oblivious
> 
> I classify things like Chrome's complex tree of related processes and
> filters as 1, since it's all one thing together.
> 
> I think of systemd, docker, minijail, FireJail, etc all as falling into
> category 2, with some variation about how to deal with 2a or 2b. I see
> systemd as weakly covering both 2a and 2b: e.g. services are documenting
> what restrictions they want, etc. minijail has stronger 2b coverage as
> it attempts to do PRELOAD tricks (which it sounds like FireJail does
> too?) (Aside: why doesn't systemd do any self-confinement?)
> 
> We don't have much possibility for the targets in the 2a realm as far
> as cooperating over how to _manage_ confinement, but rather about simply
> expecting confinement to exist, or adding more confinement on their own.
> 
> So, what would adding delayed filters gain in the above classifications?
> 
> Both 1 and 2 would benefit from some simplification over how to apply
> filters (e.g. the referenced relative complexity of needing to pass the
> USER_NOTIF fd up to the supervisor).
> 
> Dealing with 2b is improved by allowing execve itself to be blocked.
> 
> If we turn this:
> 
> 	fork
> 	prepare & apply
> 	exec
> 
> into this:
> 
> 	fork
> 	prepare
> 	exec & apply
> 
> for 2a, this isn't too interesting since a 2a target could just give up
> execve after it launched. For 2b, though, it's pretty meaningful to gain
> further isolation of an oblivious (and assumingly untrusted) process
> (given all the hacks needed to try to cover the situation).
> 
> And to clarify, 2a would much prefer this to be able to separate
> initialization from runtime:
> 
> fork
> prepare
> exec
> other things
> apply
> 
> And just for completeness, none of this is useful at all for 1, which
> doesn't even "see" the fork from its perspective:
> 
> exec
> other things
> prepare & apply
> 
> How should 2a targets indicate they're ready? Can it be done passively
> (in the sense that libc would make some seccomp call to apply the
> delayed filters), or does it need to stay explicit? (e.g. can we turn
> a pre-untrusted-input 2b into a 2a just by having the libc make calls?)
> My instinct is that hiding it won't gain much over a "on-execve" case,
> but having an explicit call that means "I'm done initializing now" would
> be a meaningful synchronization point -- except I note that it just means
> the target could just as easily start doing its own confinement anyway,
> which means they effectively move from 2a to 1, and now we don't care
> about delayed filters any more.
> 
> So, lacking a clearer sync point, execve() does seem to stand out to me.
> 
> The other idea which was touched on in the thread was very direct
> management (e.g. ptrace) and the supervisor waits until some point and
> then forces the filters to apply on the target. What would be more
> light-weight than this? (Or rather, what kinds of things would such a
> ptracer be looking for to mark "I've started"?)
> 
> Since I've got bitmaps on my mind, what about a syscall bitmap that
> triggers the application of delayed filters? The supervisor is launching
> a daemon: mark NR_listen as the apply-point. The supervisor is launching
> something totally unknown: mark NR_execve as the apply-point.
> 
> If we did that, what happens to non-delayed filters applied between
> program start and the apply-point getting tripped?
> 
> -- 
> Kees Cook

So, I think we talked about something like this at LSS NA 2019. We have a use 
case where we want to build a syscall attenuation framework. Basically, we know 
there are some set of syscalls that all programs need, and are not problematic 
(write, read, send, recv, etc..), there are syscalls that some programs need 
(execve, connect, etc...), and there are syscalls that no program needs (reboot, 
kexec).

Upon the first time a developer starts a docker image, we want to have our
seccomp supervisor monitor for the syscalls that some programs need, and
once it "learns" what the image is doing we can prepare a filter for it
that can be evaluated purely in kernelspace.

We wanted a couple properties before embarking upon this work:

1. We still wanted to be able to capture the syscalls that are not allowed.
   This could be indicative of (a) a special program that needs access for
   good reasons (think: systemd) or (b) an attacker trying to compromise
   the system. SECCOMP_FILTER_FLAG_LOG is useful for keeping track of (b),
   but USER_NOTIF really spoils you.

2. We wanted to be able to have the supervisor shutdown / crash, and
   some default actions to be put in place for the filter.

---

I think that there may be few things that could be useful here:

A way to setup multiple filters with multiple listeners. AFAIK, the reason for 
limiting the seccomp filters to have one listener was for sanity / simplicity, 
and making the semantics clear. Now that we've matured the feature a little bit, 
I think it might make sense to add something like: 
SECCOMP_FILTER_FLAG_NEW_LISTENER_COOPERATIVE (Which allows other filters with 
the cooperative flag to be installed), and the semantics could be that if a 
specific response is set, it would terminate processing of further filters, 
whereas if SECCOMP_USER_NOTIF_FLAG_CONTINUE was set it would continue up the 
chain.

A mechanism for the thing listening on the listener FD to turn itself on or off 
and indicate that it is no longer interested in receiving notifications and to 
always continue / return an error code, or that it has taken an interest now, 
and it would like to return to handling these events. The idea of an action 
other than ENOSYS (specifically SECCOMP_USER_NOTIF_FLAG_CONTINUE) if the 
listener goes away is attractive as well, in case the supervisor crashes. EPERM 
is somewhat "cleaner" of an error code than ENOSYS (most people don't write 
handling for ENOSYS on connect).

And lastly, a mechanism that once we ran the program long enough to learn
what special syscalls it needed, we can replace (or add) a filter from
the listener fd.

This hasn't been particularly high up on my priority list (dealing with 
arguments copied from userspace is next on my list to tackle), so the above is 
mostly a brain dump of what I've thought about so far. It seems to align 
somewhat with what Camille is asking for, but I'm unsure of the "replace filter" 
or "append filter" would suit the needs as we would want it to effect every
instance of that filter, and not only descendants of the newly spawned
process (after an execve).

----

Kees,

What do you think of adding the above features^? I realize *replacing* the 
filter somewhat removes pr_set_no_new_privs, but if the supervisor was going to 
return continue (or some error) anyways, I'm not sure that it violates the 
notion of no_new_privs

^features:
1. The ability for multiple cooperative filters that use user_notif / listener
   to be installed?
2. The ability for the listener to specify some default response, and
   turn that default response off and on?
3. The ability for the supervisor to replace the filter (on the entire
   existing process tree)?
4. The ability for the supervisor to specify some default response (or even
   some fallback filter to use) in case it exits / crashes / closes
   the listener fd?

