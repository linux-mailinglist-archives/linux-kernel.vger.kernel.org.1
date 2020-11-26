Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3BE22C5504
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 14:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390100AbgKZNJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 08:09:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389760AbgKZNJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:09:47 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0242C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:09:46 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id 64so2064303wra.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=8QNZUu2Cb3lWrQ6TZfg+vI39J3foEyVGk8naM+GJ9AI=;
        b=aH1WQcBaYy4asjjBlbIWGuZmqJDEI3r9QB7qPEANzc+zwav4fWgWZGvbpNU8DSGOVg
         LTlG5tkdoAtJzI3DXJlCP7ImQY5/b1ZmZoDRYGuoQRQSURyv9vgRtg8H9TzFNcx+rPFX
         pk8jvHfjzDQaeKuXgKpMvmLWDLqD/P0+UvupQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=8QNZUu2Cb3lWrQ6TZfg+vI39J3foEyVGk8naM+GJ9AI=;
        b=kiF5v54KwPHoaw1cWB1yet2UUd+3aZXeUN8yx6RI5WxtrS/h7W25OQMf72O5sOtq+J
         iuuhKUUSfmRmO+/kyG+WnblgU/+VZTopoKdC+HLHk9mJJx8YD2s6vuoSMtq8mC6hzWtT
         4/33hJPLy5n7JkZZ5dsV1UYmkvhZdXPdhZXrImuCDPyUZ+MX1cpug97klxQcar2QjdGZ
         PdnABk5Ijmvw12MW6c3qVwJkQNJNNEY4bQkuMc7n99lEJp2BSzBmjd5j/V4PdTmbb7Ex
         5n6dJnQFUQXU2xqhK8gN5RRYsSDhg+Ip8Go9DcJXTKmi/nuRu4QtHPkkpklC7W4+My5J
         bAlQ==
X-Gm-Message-State: AOAM531J97BmelWId/GPS3Z3qSK+DK2RPMUOmk2qBtL/Y0pyxsXOh/AS
        DUidu+EW2uaj7mvLOaO+VC0ctT3GMUcCR9ZS2msOMkDOKTXF9g==
X-Google-Smtp-Source: ABdhPJx4fFNWx1/Gke8sRMXIL1e1HJpim6R8QFHoYzSOnw8kqnMXPE3V3AqD25oLsRDjC5osy/UzyaKLn83jMce05n0=
X-Received: by 2002:a5d:5604:: with SMTP id l4mr3708930wrv.127.1606396185044;
 Thu, 26 Nov 2020 05:09:45 -0800 (PST)
MIME-Version: 1.0
From:   Alban Crequy <alban@kinvolk.io>
Date:   Thu, 26 Nov 2020 14:09:33 +0100
Message-ID: <CADZs7q4sw71iNHmV8EOOXhUKJMORPzF7thraxZYddTZsxta-KQ@mail.gmail.com>
Subject: SECCOMP_IOCTL_NOTIF_ADDFD race condition
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        Kees Cook <keescook@chromium.org>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Rodrigo Campos <rodrigo@kinvolk.io>,
        =?UTF-8?Q?Mauricio_V=C3=A1squez_Bernal?= <mauricio@kinvolk.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

With the addfd feature (added in =E2=80=9Cseccomp: Introduce addfd ioctl to
seccomp user notifier=E2=80=9D, commit 7cf97b125455), the new file is
installed in the target process during the SECCOMP_IOCTL_NOTIF_ADDFD
operation and not at the end with the SECCOMP_IOCTL_NOTIF_SEND
operation. This can cause race conditions when the target process is
interrupted by a signal (EINTR) and restarted automatically.

This is more noticeable in multithreaded processes like with Golang.
In Golang 1.14:
https://golang.org/doc/go1.14
> "A consequence of the implementation of preemption is that on Unix system=
s, including Linux and macOS systems, programs built with Go 1.14 will rece=
ive more signals than programs built with earlier releases. This means that=
 programs that use packages like syscall or golang.org/x/sys/unix will see =
more slow system calls fail with EINTR errors. Those programs will have to =
handle those errors in some way, most likely looping to try the system call=
 again."

In my test, I added a seccomp policy which returns
SECCOMP_RET_USER_NOTIF on execve() and I added a sleep(2) in the
seccomp agent (using https://github.com/kinvolk/seccompagent/) between
SECCOMP_IOCTL_NOTIF_RECV and SECCOMP_IOCTL_NOTIF_SEND to make it a bit
slow to reply with SECCOMP_USER_NOTIF_FLAG_CONTINUE. I got the
following strace log going on in a loop:

[pid 2656199] execve("/bin/sh", ["sh", "-c", "sleep infinity"],
0xc000063b00 /* 11 vars */ <unfinished ...>
[pid 2656200] <... nanosleep resumed>NULL) =3D 0
[pid 2656200] epoll_pwait(7, [], 128, 0, NULL, 0) =3D 0
[pid 2656200] getpid()                  =3D 1
[pid 2656200] tgkill(1, 1, SIGURG)      =3D 0
[pid 2656199] <... execve resumed>)     =3D ? ERESTARTSYS (To be
restarted if SA_RESTART is set)
[pid 2656200] nanosleep({tv_sec=3D0, tv_nsec=3D10000000},  <unfinished ...>
[pid 2656199] --- SIGURG {si_signo=3DSIGURG, si_code=3DSI_TKILL, si_pid=3D1=
,
si_uid=3D0} ---
[pid 2656199] rt_sigreturn({mask=3D[]})   =3D 59
[pid 2656199] execve("/bin/sh", ["sh", "-c", "sleep infinity"],
0xc000063b00 /* 11 vars */ <unfinished ...>

On the seccomp agent side, the ioctl(SECCOMP_IOCTL_NOTIF_SEND) returns
ENOENT, and then it receives the same notification at the next
iteration of the loop.

The SIGURG signal is sent by the Golang runtime, causing the execve to
be interrupted, and restarted automatically, triggering the new
seccomp notification. In this example with execve, this is not a big
deal because the seccomp agent doesn't add a fd. But on a open() or
accept() syscall, I fear that the seccomp agent could install a file
descriptor without knowing that the syscall will be interrupted soon
after, but before the SECCOMP_IOCTL_NOTIF_SEND is completed.

I understand the need to have two different ioctl() to add the fd and
to reply to the seccomp notification because the seccomp agent needs
to know the fd number being assigned before specifying the return
value of the syscall with that number.

What do you think is the best way to solve this problem? Here are a few ide=
as:

- Idea 1: add a second flag for the struct seccomp_notif_resp
=E2=80=9CSECCOMP_USER_NOTIF_FLAG_RETURN_FD=E2=80=9D to instruct seccomp to =
override
the return value with the first fd to install. It would not help to
emulate recvfrom() with SCM_RIGHTS but it will solve the problem for
syscalls that return a fd because we can then implement a new ioctl
(=E2=80=9CSECCOMP_IOCTL_NOTIF_SEND_WITH_FDS=E2=80=9D?) that does the addfd =
and the
notification response in one step.

Other ideas but they cause more problems:

- Idea 2: We need some kind of transactions where the fd is sent with
the first ioctl() and installed in the fd table but marked somehow to
be closed automatically if the syscall is interrupted with EINTR
outside of the control of the seccomp agent. The new fd in the fd
table would be committed at the end if the syscall is not interrupted.
But this introduces other issues: another thread could call dup() on
the fd before it gets closed. Or another process sharing the fd table
with CLONE_FILES could do the same. Should the not-yet-committed fds
be visible in /proc/<pid>/fd/? Or inherited to new processes created
by fork()?

- Idea 3: We could add fds in a temporary location but not in the
`struct files_struct` of the target process, and only commit at
SECCOMP_IOCTL_NOTIF_SEND time. In this way, threads or processes
sharing the fd table with CLONE_FILES would not be impacted. However,
this could open new race conditions if other threads are installing
fds in the same slots in the fd table. Also, this seems quite
dangerous to add this concept of "inflight" fd for seccomp because
there are already inflight fds for SCM_RIGHT and a garbage collector
to clean circular references (net/unix/garbage.c). If we add an
inflight fd mechanism on seccomp, a malicious user could just use
SECCOMP_IOCTL_NOTIF_ADDFD to send a unix socket that has the
seccomp-fd inflight in SCM_RIGHT. Then, the malicious seccomp agent
would close(seccompFd) and we will be in a situation where both the
seccomp-fd and the unix socket are not attached to any process but
they reference each other, so they cannot be closed.

What do you think? Is there a better solution?

Cheers
Alban
