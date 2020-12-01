Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3457B2C9647
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 05:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387395AbgLAEJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 23:09:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727875AbgLAEJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 23:09:42 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9696AC0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 20:08:56 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id q137so265543iod.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 20:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=6gDQeNDsjVW40V3dfnNWDWW/t7ga5a/1+pXRyNxTnHQ=;
        b=uUaWN4gEYL7UGJU5rUxzfeR58bgG1XLU8YpONGNVOBDH5GU7B5VfilpMP3aZ/2A9wI
         KJg+jeSBfCx79emc93RdgYeU9uB+MmZq6c2zRczOw6ozhNQN7fKP/ZIKStyFaV8+Q9l6
         p9PpuidJ2jBJPfsRpzzg6OtTL5VRjG8KewM60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=6gDQeNDsjVW40V3dfnNWDWW/t7ga5a/1+pXRyNxTnHQ=;
        b=R8QW2i1VVyym7rgzwwddajT746xew7/5b0ZMf9Wz15wh9Eo0IIfxewUw9hAwQgw6YX
         Pc5c+2En1IWARDIJcFyS7OcSWeD2Uq9z3VzC9vTGno7Fq+8qvQALmM6wZshRTGvgPmFk
         a7JiMPiAgNouimb8Nn3mbk9Gv5C12wD9RsqRCLe4P5lFDlVipSZOr9UOFIMSzXdj/QFK
         npKCdjngUIe2aW/QrXwNG9AwJI5MvBewD9DKRhKiWVW20ahk3ylVpSl9W7qF4PrpV+0i
         4U23ZzimS1AqRePR2EroeJrWBGmn2Rcl6A4dGoH9emKbGimHa5KHe5zixP9CilA4fRrj
         BTzg==
X-Gm-Message-State: AOAM533v9rgW6qY7CjgUW24mesNzcVBjQC2l3TKkkDFZR8ifQTEVmljn
        JPkUQihzDLhaCAEJjM+QryRiyg==
X-Google-Smtp-Source: ABdhPJzpBvE9w0HfqjzqDOVnTn9Q6eN7nmdoBx/c3IMSCGrLwokBEsfWJFuW5JfyZinbtnQWIC23qg==
X-Received: by 2002:a5d:85c7:: with SMTP id e7mr941277ios.162.1606795735760;
        Mon, 30 Nov 2020 20:08:55 -0800 (PST)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id a16sm337978ilr.44.2020.11.30.20.08.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Nov 2020 20:08:55 -0800 (PST)
Date:   Tue, 1 Dec 2020 04:08:53 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     Tycho Andersen <tycho@tycho.pizza>
Cc:     Alban Crequy <alban@kinvolk.io>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Rodrigo Campos <rodrigo@kinvolk.io>,
        Mauricio =?iso-8859-1?Q?V=E1squez?= Bernal 
        <mauricio@kinvolk.io>
Subject: Re: SECCOMP_IOCTL_NOTIF_ADDFD race condition
Message-ID: <20201201040852.GA18751@ircssh-2.c.rugged-nimbus-611.internal>
References: <CADZs7q4sw71iNHmV8EOOXhUKJMORPzF7thraxZYddTZsxta-KQ@mail.gmail.com>
 <20201130232009.GC38675@cisco>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201130232009.GC38675@cisco>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 06:20:09PM -0500, Tycho Andersen wrote:
> Hi,
> 
> On Thu, Nov 26, 2020 at 02:09:33PM +0100, Alban Crequy wrote:
> > Hi,
> > 
> > With the addfd feature (added in “seccomp: Introduce addfd ioctl to
> > seccomp user notifier”, commit 7cf97b125455), the new file is
> > installed in the target process during the SECCOMP_IOCTL_NOTIF_ADDFD
> > operation and not at the end with the SECCOMP_IOCTL_NOTIF_SEND
> > operation. This can cause race conditions when the target process is
> > interrupted by a signal (EINTR) and restarted automatically.
> > 
> > This is more noticeable in multithreaded processes like with Golang.
> > In Golang 1.14:
> > https://golang.org/doc/go1.14
> > > "A consequence of the implementation of preemption is that on Unix systems, including Linux and macOS systems, programs built with Go 1.14 will receive more signals than programs built with earlier releases. This means that programs that use packages like syscall or golang.org/x/sys/unix will see more slow system calls fail with EINTR errors. Those programs will have to handle those errors in some way, most likely looping to try the system call again."
> > 
> > In my test, I added a seccomp policy which returns
> > SECCOMP_RET_USER_NOTIF on execve() and I added a sleep(2) in the
> > seccomp agent (using https://github.com/kinvolk/seccompagent/) between
> > SECCOMP_IOCTL_NOTIF_RECV and SECCOMP_IOCTL_NOTIF_SEND to make it a bit
> > slow to reply with SECCOMP_USER_NOTIF_FLAG_CONTINUE. I got the
> > following strace log going on in a loop:
> > 
> > [pid 2656199] execve("/bin/sh", ["sh", "-c", "sleep infinity"],
> > 0xc000063b00 /* 11 vars */ <unfinished ...>
> > [pid 2656200] <... nanosleep resumed>NULL) = 0
> > [pid 2656200] epoll_pwait(7, [], 128, 0, NULL, 0) = 0
> > [pid 2656200] getpid()                  = 1
> > [pid 2656200] tgkill(1, 1, SIGURG)      = 0
> > [pid 2656199] <... execve resumed>)     = ? ERESTARTSYS (To be
> > restarted if SA_RESTART is set)
> > [pid 2656200] nanosleep({tv_sec=0, tv_nsec=10000000},  <unfinished ...>
> > [pid 2656199] --- SIGURG {si_signo=SIGURG, si_code=SI_TKILL, si_pid=1,
> > si_uid=0} ---
> > [pid 2656199] rt_sigreturn({mask=[]})   = 59
> > [pid 2656199] execve("/bin/sh", ["sh", "-c", "sleep infinity"],
> > 0xc000063b00 /* 11 vars */ <unfinished ...>
> > 
> > On the seccomp agent side, the ioctl(SECCOMP_IOCTL_NOTIF_SEND) returns
> > ENOENT, and then it receives the same notification at the next
> > iteration of the loop.
> > 
> > The SIGURG signal is sent by the Golang runtime, causing the execve to
> > be interrupted, and restarted automatically, triggering the new
> > seccomp notification. In this example with execve, this is not a big
> > deal because the seccomp agent doesn't add a fd. But on a open() or
> > accept() syscall, I fear that the seccomp agent could install a file
> > descriptor without knowing that the syscall will be interrupted soon
> > after, but before the SECCOMP_IOCTL_NOTIF_SEND is completed.
> > 
> > I understand the need to have two different ioctl() to add the fd and
> > to reply to the seccomp notification because the seccomp agent needs
> > to know the fd number being assigned before specifying the return
> > value of the syscall with that number.
> > 
> > What do you think is the best way to solve this problem? Here are a few ideas:
> > 
> > - Idea 1: add a second flag for the struct seccomp_notif_resp
> > “SECCOMP_USER_NOTIF_FLAG_RETURN_FD” to instruct seccomp to override
> > the return value with the first fd to install. It would not help to
> > emulate recvfrom() with SCM_RIGHTS but it will solve the problem for
> > syscalls that return a fd because we can then implement a new ioctl
> > (“SECCOMP_IOCTL_NOTIF_SEND_WITH_FDS”?) that does the addfd and the
> > notification response in one step.
> > 
> > Other ideas but they cause more problems:
> > 
> > - Idea 2: We need some kind of transactions where the fd is sent with
> > the first ioctl() and installed in the fd table but marked somehow to
> > be closed automatically if the syscall is interrupted with EINTR
> > outside of the control of the seccomp agent. The new fd in the fd
> > table would be committed at the end if the syscall is not interrupted.
> > But this introduces other issues: another thread could call dup() on
> > the fd before it gets closed. Or another process sharing the fd table
> > with CLONE_FILES could do the same. Should the not-yet-committed fds
> > be visible in /proc/<pid>/fd/? Or inherited to new processes created
> > by fork()?
> > 
> > - Idea 3: We could add fds in a temporary location but not in the
> > `struct files_struct` of the target process, and only commit at
> > SECCOMP_IOCTL_NOTIF_SEND time. In this way, threads or processes
> > sharing the fd table with CLONE_FILES would not be impacted. However,
> > this could open new race conditions if other threads are installing
> > fds in the same slots in the fd table. Also, this seems quite
> > dangerous to add this concept of "inflight" fd for seccomp because
> > there are already inflight fds for SCM_RIGHT and a garbage collector
> > to clean circular references (net/unix/garbage.c). If we add an
> > inflight fd mechanism on seccomp, a malicious user could just use
> > SECCOMP_IOCTL_NOTIF_ADDFD to send a unix socket that has the
> > seccomp-fd inflight in SCM_RIGHT. Then, the malicious seccomp agent
> > would close(seccompFd) and we will be in a situation where both the
> > seccomp-fd and the unix socket are not attached to any process but
> > they reference each other, so they cannot be closed.
> > 
> > What do you think? Is there a better solution?
> 
> Idea 1 sounds best to me, but maybe that's because it's the way I
> originally did the fd support that never landed :)
> 
> But here's an Idea 4: we add a way to remotely close an fd (I don't
> see that the current infra can do this, but perhaps I didn't look hard
> enough), and then when you get ENOENT you have to close the fd. Of
> course, this can't be via seccomp, so maybe it's even more racy.
> 
> Tycho

I've actually been looking into this problem a little bit more since
Alban pointed it out.

It actually seems like the problem has been made significant worse
recently since Golang introduced asynchronous preemption:

https://medium.com/a-journey-with-go/go-asynchronous-preemption-b5194227371c

> The asynchronous preemption is triggered based on a time condition. When a 
> goroutine is running for more than 10ms, Go will try to preempt it.

Unfortunately, this means that if the "kernel" (or our seccomp manager
processs) takes more than 10ms to handle the request, the request
will likely be EINTR'd, and this will trigger a preemption loop.

This in turn can actually lead to a forever race, or a massive performance
regression, as the seccomp notifier process can take ~10ms easily.

Tracking preemptions / "resumptions" is a pain.

I've been waiting to comment as Eric's patches are in progress:
https://lore.kernel.org/lkml/CAHk-=wge0oJ3fbmNfVek101CO7hg1UfUHnBgxLB3Jmq6-hWLug@mail.gmail.com/

I think that either allocating something in the fdtable and marking it as to be 
allocated in the near future is the best option, the reason is it solves the 
problem of handling interrupted syscalls even if you're adding more than one FD.

The other idea, and to help avoid the messiness of the Golang problem is being 
able to block signals and mark the child as ignoring some set of signals from
the manager.

I'm curious if Al, or Christian knows why allocation and usage requiring a
userspace ping-pong might not be good.
