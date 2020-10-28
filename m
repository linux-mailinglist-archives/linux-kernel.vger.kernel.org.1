Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A000F29DB90
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389380AbgJ2AAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 20:00:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:37076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389368AbgJ2AAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 20:00:06 -0400
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A181E208C7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603929604;
        bh=OmN8vgKewQg9DdpzKeNqxxoP39UtEU/hbWDtA/HryW0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cpCHnTr6YQ87BhN5ztDtXudsOlZ7k/obgesU/+f7r1QzKpdZxrvxYeOeJc3/xqF8n
         aNngE6RhZjWZ7N/vXrN/e09anmuPJf/FG96ikI7D0STmCTUnCSQ94FgDGxuSehA8bG
         zFY4LtIkClK01umtpgGen7BgWo/sk6MA7ctEF0is=
Received: by mail-wr1-f47.google.com with SMTP id w14so868819wrs.9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 17:00:04 -0700 (PDT)
X-Gm-Message-State: AOAM531v7c6HPdBikiYtnRQ5NbNKP8qsi5vZ+yVFpgdo8OGmZJhpBkz4
        E84ffM9rkLs9W4db2QaHh2YmrqP9bYyMt8B7mQPndA==
X-Google-Smtp-Source: ABdhPJxzZRfR2IbCKTC6XexD852gfBXCoM4aPLjMQ5cACmZbhocSWAOtBNKUGAAuf5xo95vfzTm6RLQFp9HlnRkTYRs=
X-Received: by 2002:adf:e9c6:: with SMTP id l6mr1973798wrn.257.1603929603069;
 Wed, 28 Oct 2020 17:00:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAAnLoWnS74dK9Wq4EQ-uzQ0qCRfSK-dLqh+HCais-5qwDjrVzg@mail.gmail.com>
 <202010281503.3D1FCFE0@keescook>
In-Reply-To: <202010281503.3D1FCFE0@keescook>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 28 Oct 2020 16:59:51 -0700
X-Gmail-Original-Message-ID: <CALCETrUGz0OZqDpex3boMQWQSfh2jEyBLPv-smQA5a0-Rz=tgg@mail.gmail.com>
Message-ID: <CALCETrUGz0OZqDpex3boMQWQSfh2jEyBLPv-smQA5a0-Rz=tgg@mail.gmail.com>
Subject: Re: [seccomp] Request for a "enable on execve" mode for Seccomp filters
To:     Kees Cook <keescook@chromium.org>
Cc:     Camille Mougey <commial@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Rich Felker <dalias@libc.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Denis Efremov <efremov@linux.com>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 3:47 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Oct 28, 2020 at 12:18:47PM +0100, Camille Mougey wrote:
> > (This is my first message to the kernel list, I hope I'm doing it right)
>
> 1- self-confinement
> 2- launching external processes
>         a) cooperating
>         b) oblivious

I remain quite unconvinced that delayed filters will solve a real
problem.  As you described, 2a could just confine itself.  There's an
obvious synchronization point -- sd_notify().  I bet sd_notify() could
be rigged up to apply externally-supplied filters, or sd_notify()
could interact with user notifiers to get some assistance.

2b is nasty.  In an ideal world, we would materialize a fully formed
process with filters installed.  The problem is that processes don't
generally come fully formed.  Almost all interesting processes are
dynamically linked, and they get to specify their own dynamic linkers.
Even if we limit ourselves to a known dynamic linker, we would want to
make sure that the dynamic linker is hardened against various escape
techniques.  For dynamic linking, we would probably want to start out
with one set of privileges (loading libraries) and then switch.

I have an alternative suggestion to try to address some of the above:
allow a notifier to run in a mode in which it can replace the BPF
program outright.  This would be something like:

if (fork() != 0)
  return;  // do parent stuff

// Start up.  Set a BPF program that directs pretty much everything at
the listener.
int fd = seccomp(..., SECCOMP_FILTER_FLAG_NEW_LISTENER |
SECCOMP_FILTER_FLAG_ALLOW_REPLACEMENT, ...);

// Set up other things if needed.

execve();

Now, in the parent, once the child is ready for its final filters:

// Replace the filter on *all* processes using the filter to which
we're attached.
// I think the locking for this should be straightforward.
// Optional flag here to remove the ALLOW_REPLACEMENT flag, but it's
not really necessary
// since we're about to close() the listener.
ioctl(fd, SECCOMP_IOCTL_NOTIF_REPLACE_FILTER, new_filter);

// Call recv in a loop to drain and handle notifications.
for (...) {
  ioctl(fd, SECCOMP_IOCTL_NOTIF_RECV, ...);
  ...
}

close(fd);

And now we're done.  We can make the synchronization point be anything we like.


What do you all think?  For people who really want
delay-until-execve(), this can emulate it efficiently.
