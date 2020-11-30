Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F320D2C926B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 00:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729780AbgK3XVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 18:21:38 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:46715 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725980AbgK3XVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 18:21:31 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 1CC6DF95;
        Mon, 30 Nov 2020 18:20:20 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 30 Nov 2020 18:20:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm1; bh=t
        I8EZNYEsPiAMN7olMmJqVe6Mov/ZWJK2u1sPV7MO3s=; b=I79aUnFyRSijB9zcs
        hfErE6rmiscraJAFwpXoNxR26yWSgp0b9wwiR2whBFdJCuISZHZ51PLTksszBN2/
        rttkjkfXb/A3LloNx8iipJl9jyh8tyyeHuksgyNWjdHr/mbfPIJ2yksu+kyqxzg8
        N9Kch2dIcIFs+VVVvHGfdyv+EGE7vbpJCTO27qtb8lAuafUtFGi4+DPaPEnhSStF
        X2JX2qdjr+t1l77ziFyUpAes02wW9pJtJlPMJYM3+SW30J5ux+DMp+9iI2+/Ymrg
        Wf02EsMFWxu1eQ1q36RUbHS0EiGLHNnEfrx16zPEJdeMcNi+ztuvJ1bX1g3kasjb
        D+RoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=tI8EZNYEsPiAMN7olMmJqVe6Mov/ZWJK2u1sPV7MO
        3s=; b=bzU/wkOZ+VTxpzQa9rPEvell/HekomVRr3S1l/PtVLsDmol4zEAe90V1l
        mTlhjrKv6wQsmw5Ud2u0L3A1XT8yv1bQwrRWsjap3yMWORSPdIwGUz2TDBMga0O0
        kx2Y50Pi8eqCGVUzvrD3EMVBeo3pBy6C8zfq7gr/svwLOufMqCVe3J1Ko4bcuw3l
        39Kmnn07/TINCT2KQAAyXOU0osADDSApIrGm1CIeeRZ8i3Xxr+hc+wc/foOlNln6
        gzL+MEdy3noxqlwCiAlHYXsQYbnfaZzsc3/7ELRm8LCnSwQKfrWdpoSPt2jeWykH
        caO1ZZh6/c2Phc6jqpfC0mFK0YyFA==
X-ME-Sender: <xms:Mn7FX0YQgFeIjxzyot16chIonsupz-IgmpKIJYDfJWG-sILLDL5vjg>
    <xme:Mn7FX_bto0wgeK9QgT7OfnO7WSMsrn7vaCsh61efXF3zEfmFLE3GamrNAKAwSI1zQ
    zCQei4GcPehFLvbo-Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeiuddgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepvfihtghh
    ohcutehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrf
    grthhtvghrnhepgeefheetvdefleduteefheehkeeuudehfeettdeghfekudefkedtueel
    heejiefgnecuffhomhgrihhnpehgohhlrghnghdrohhrghdpghhithhhuhgsrdgtohhmne
    cukfhppeduvdekrddutdejrddvgedurddukeegnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepthihtghhohesthihtghhohdrphhiiiiirg
X-ME-Proxy: <xmx:Mn7FX--tv5O20lKzjngni51ybQnJag1BKdGiGJ1VBtx79v_BvSfQkw>
    <xmx:Mn7FX-o0Gf6gYdRaEsfd15-3FeVjXwAchbOkUx_aRpJjPTtwBZ7uLw>
    <xmx:Mn7FX_qHQcYp73bRqKjaJf_vwqwtuT-tYuxZZRaOQAUoClnVDfcg-w>
    <xmx:M37FXwcTyoL5ikOOZsN42QiomJD4N-5aQ4s5l4l0HfKvU_O-cDzNFg>
Received: from cisco (unknown [128.107.241.184])
        by mail.messagingengine.com (Postfix) with ESMTPA id BADF93064AA6;
        Mon, 30 Nov 2020 18:20:16 -0500 (EST)
Date:   Mon, 30 Nov 2020 18:20:09 -0500
From:   Tycho Andersen <tycho@tycho.pizza>
To:     Alban Crequy <alban@kinvolk.io>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Kees Cook <keescook@chromium.org>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Rodrigo Campos <rodrigo@kinvolk.io>,
        Mauricio =?iso-8859-1?Q?V=E1squez?= Bernal 
        <mauricio@kinvolk.io>
Subject: Re: SECCOMP_IOCTL_NOTIF_ADDFD race condition
Message-ID: <20201130232009.GC38675@cisco>
References: <CADZs7q4sw71iNHmV8EOOXhUKJMORPzF7thraxZYddTZsxta-KQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADZs7q4sw71iNHmV8EOOXhUKJMORPzF7thraxZYddTZsxta-KQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Nov 26, 2020 at 02:09:33PM +0100, Alban Crequy wrote:
> Hi,
> 
> With the addfd feature (added in “seccomp: Introduce addfd ioctl to
> seccomp user notifier”, commit 7cf97b125455), the new file is
> installed in the target process during the SECCOMP_IOCTL_NOTIF_ADDFD
> operation and not at the end with the SECCOMP_IOCTL_NOTIF_SEND
> operation. This can cause race conditions when the target process is
> interrupted by a signal (EINTR) and restarted automatically.
> 
> This is more noticeable in multithreaded processes like with Golang.
> In Golang 1.14:
> https://golang.org/doc/go1.14
> > "A consequence of the implementation of preemption is that on Unix systems, including Linux and macOS systems, programs built with Go 1.14 will receive more signals than programs built with earlier releases. This means that programs that use packages like syscall or golang.org/x/sys/unix will see more slow system calls fail with EINTR errors. Those programs will have to handle those errors in some way, most likely looping to try the system call again."
> 
> In my test, I added a seccomp policy which returns
> SECCOMP_RET_USER_NOTIF on execve() and I added a sleep(2) in the
> seccomp agent (using https://github.com/kinvolk/seccompagent/) between
> SECCOMP_IOCTL_NOTIF_RECV and SECCOMP_IOCTL_NOTIF_SEND to make it a bit
> slow to reply with SECCOMP_USER_NOTIF_FLAG_CONTINUE. I got the
> following strace log going on in a loop:
> 
> [pid 2656199] execve("/bin/sh", ["sh", "-c", "sleep infinity"],
> 0xc000063b00 /* 11 vars */ <unfinished ...>
> [pid 2656200] <... nanosleep resumed>NULL) = 0
> [pid 2656200] epoll_pwait(7, [], 128, 0, NULL, 0) = 0
> [pid 2656200] getpid()                  = 1
> [pid 2656200] tgkill(1, 1, SIGURG)      = 0
> [pid 2656199] <... execve resumed>)     = ? ERESTARTSYS (To be
> restarted if SA_RESTART is set)
> [pid 2656200] nanosleep({tv_sec=0, tv_nsec=10000000},  <unfinished ...>
> [pid 2656199] --- SIGURG {si_signo=SIGURG, si_code=SI_TKILL, si_pid=1,
> si_uid=0} ---
> [pid 2656199] rt_sigreturn({mask=[]})   = 59
> [pid 2656199] execve("/bin/sh", ["sh", "-c", "sleep infinity"],
> 0xc000063b00 /* 11 vars */ <unfinished ...>
> 
> On the seccomp agent side, the ioctl(SECCOMP_IOCTL_NOTIF_SEND) returns
> ENOENT, and then it receives the same notification at the next
> iteration of the loop.
> 
> The SIGURG signal is sent by the Golang runtime, causing the execve to
> be interrupted, and restarted automatically, triggering the new
> seccomp notification. In this example with execve, this is not a big
> deal because the seccomp agent doesn't add a fd. But on a open() or
> accept() syscall, I fear that the seccomp agent could install a file
> descriptor without knowing that the syscall will be interrupted soon
> after, but before the SECCOMP_IOCTL_NOTIF_SEND is completed.
> 
> I understand the need to have two different ioctl() to add the fd and
> to reply to the seccomp notification because the seccomp agent needs
> to know the fd number being assigned before specifying the return
> value of the syscall with that number.
> 
> What do you think is the best way to solve this problem? Here are a few ideas:
> 
> - Idea 1: add a second flag for the struct seccomp_notif_resp
> “SECCOMP_USER_NOTIF_FLAG_RETURN_FD” to instruct seccomp to override
> the return value with the first fd to install. It would not help to
> emulate recvfrom() with SCM_RIGHTS but it will solve the problem for
> syscalls that return a fd because we can then implement a new ioctl
> (“SECCOMP_IOCTL_NOTIF_SEND_WITH_FDS”?) that does the addfd and the
> notification response in one step.
> 
> Other ideas but they cause more problems:
> 
> - Idea 2: We need some kind of transactions where the fd is sent with
> the first ioctl() and installed in the fd table but marked somehow to
> be closed automatically if the syscall is interrupted with EINTR
> outside of the control of the seccomp agent. The new fd in the fd
> table would be committed at the end if the syscall is not interrupted.
> But this introduces other issues: another thread could call dup() on
> the fd before it gets closed. Or another process sharing the fd table
> with CLONE_FILES could do the same. Should the not-yet-committed fds
> be visible in /proc/<pid>/fd/? Or inherited to new processes created
> by fork()?
> 
> - Idea 3: We could add fds in a temporary location but not in the
> `struct files_struct` of the target process, and only commit at
> SECCOMP_IOCTL_NOTIF_SEND time. In this way, threads or processes
> sharing the fd table with CLONE_FILES would not be impacted. However,
> this could open new race conditions if other threads are installing
> fds in the same slots in the fd table. Also, this seems quite
> dangerous to add this concept of "inflight" fd for seccomp because
> there are already inflight fds for SCM_RIGHT and a garbage collector
> to clean circular references (net/unix/garbage.c). If we add an
> inflight fd mechanism on seccomp, a malicious user could just use
> SECCOMP_IOCTL_NOTIF_ADDFD to send a unix socket that has the
> seccomp-fd inflight in SCM_RIGHT. Then, the malicious seccomp agent
> would close(seccompFd) and we will be in a situation where both the
> seccomp-fd and the unix socket are not attached to any process but
> they reference each other, so they cannot be closed.
> 
> What do you think? Is there a better solution?

Idea 1 sounds best to me, but maybe that's because it's the way I
originally did the fd support that never landed :)

But here's an Idea 4: we add a way to remotely close an fd (I don't
see that the current infra can do this, but perhaps I didn't look hard
enough), and then when you get ENOENT you have to close the fd. Of
course, this can't be via seccomp, so maybe it's even more racy.

Tycho
