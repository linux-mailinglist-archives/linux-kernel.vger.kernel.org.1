Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D40FB29E13B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 02:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbgJ1V4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728652AbgJ1V4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:56:44 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E5CC0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 14:56:43 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id s9so648823wro.8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 14:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nMV8WTpIfgMxyLs6kmMDlyNBMWJzLpgMJEOl4OfLsLo=;
        b=gGrNyzOq22zTzoOScxKDbXebRNK96XuCFTdwDjGLZ5tmP4Z9prCIuVxuWcj6zTXwuR
         wcKxuqQjhsAmTNDwNtttvKFSppgACkPvWEyqAzqD79eJN25Q9h+L4abce/HxHJ41Rrd8
         8UySZOF0kYeBkqIjFPkCb6qqRM45AK9nkIqNAJxeesSXGzavj0nR3G5Nl6qLpuwm9uub
         kq1n5U5quIn1X80vll8b84eOuc57zG9lwwZvttPH/GqXNFso3YzByWyKY73pm8DHEjgN
         ZDNvNfZDKk60Vpzik2vABRLBh8coIGnGj4E+zda16WKlUO0M0Tjr/bcRiKwZH4UeJDK1
         FOhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nMV8WTpIfgMxyLs6kmMDlyNBMWJzLpgMJEOl4OfLsLo=;
        b=ZAez5w0toKWRUd0Nopf0x1N4ovgGuUTtnj5BdSrQTN1Mz4dBA4g3WpoC2jEhyzzBk+
         tTd1UwdwN4Gu/n52eYHnFiK8EFlkDX6+aWHIQ7hUw/0nXSO+Z8c/GOEcM9NXP276jwFH
         IEZE/AToLul7oVrW9flzBlR7rMKSRwoUib2EupOc6NiyCuwu5SPhBMEMbihd6UCCCbrM
         pwLGR15bqRsebbHjZVtee7OxnE0KdWz84LkvNXpYzYvMevGrH5tAAag8JGMG51106InH
         9J6PY7i8sZiTuux1/DKQO41qg0RXOIlsnwvDSAzhA1xo47e3152mnOweUKasux2lyJfJ
         OAiw==
X-Gm-Message-State: AOAM530Jfg6tsWKwO/08Wi8gdflyyuOBp2neep9+Bz/fu+pg+TWvsadx
        ChbeSp/BK40MKvBxwakVArznX8mBZgJcUSv21ckQVO2v9i4aYQ==
X-Google-Smtp-Source: ABdhPJwtvNAsoYU8P3zfh8nxPCrDoDvLGXFHV9lzFFe6NLJWfB8bR31G4JTbcICx77GWx6eIHE3hXf4JLgsOX1qN+BM=
X-Received: by 2002:a2e:b888:: with SMTP id r8mr2517651ljp.138.1603888960126;
 Wed, 28 Oct 2020 05:42:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAAnLoWnS74dK9Wq4EQ-uzQ0qCRfSK-dLqh+HCais-5qwDjrVzg@mail.gmail.com>
In-Reply-To: <CAAnLoWnS74dK9Wq4EQ-uzQ0qCRfSK-dLqh+HCais-5qwDjrVzg@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 28 Oct 2020 13:42:13 +0100
Message-ID: <CAG48ez3ZXmJ1ndEmZtoieOAm05p+5X7+HXo61LwpuiWFWGWK4w@mail.gmail.com>
Subject: Re: [seccomp] Request for a "enable on execve" mode for Seccomp filters
To:     Camille Mougey <commial@gmail.com>,
        Kees Cook <keescook@chromium.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Tycho Andersen <tycho@tycho.pizza>,
        Rich Felker <dalias@libc.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Denis Efremov <efremov@linux.com>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+luto just in case he has opinions on this

On Wed, Oct 28, 2020 at 12:18 PM Camille Mougey <commial@gmail.com> wrote:
> From my understanding, there is no way to delay the activation of
> seccomp filters, for instance "until an _execve_ call".

(FWIW, there are some tricks that you can use for this. In particular,
you can attach to the child with ptrace before the child runs
execve(), and then use seccomp to inject a filter after execve(), or
something like that. The disadvantage is that this is not super pretty
because it interferes with debugging of the parent process. IIRC e.g.
Ubuntu's launchd did things this way.)

> But this might be useful, especially for tools who sandbox other,
> non-cooperative, executables, such as "systemd" or "FireJail".
>
> It seems to be a caveat of seccomp specific to the system call
> _execve_. For now, some tools such as "systemd" explicitly mention
> this exception, and do not support it (from the man page):
> > Note that strict system call filters may impact execution and error han=
dling code paths of the service invocation. Specifically, access to the exe=
cve system call is required for the execution of the service binary =E2=80=
=94 if it is blocked service invocation will necessarily fail
>
> "FireJail" takes a different approach[1], with a kind of workaround:
> the project uses an external library to be loaded through LD_PRELOAD
> mechanism, in order to install filters during the loader stage.
> This approach, a bit hacky, also has several caveats:
> * _openat_, _mmap_, etc. must be allowed in order to reach the
> LD_PRELOAD mechanism, and for the crafted library to work ;

Those caveats are not specific to the LD_PRELOAD approach. Actually,
the LD_PRELOAD approach is the only one which I would expect to *not*
have that caveat. (Of course, non-executable mmap() and probably also
openat() are anyway needed for almost any real-world service to do its
job correctly.)

> * it doesn't work for static binaries.

IMO the important thing about LD_PRELOAD is that it is unreliable:
When the LD_PRELOAD library can't be opened, glibc just prints a
warning and continues execution - and an attacker may be able to cause
opening an LD_PRELOAD library to fail by opening so many files in
other processes that the global limit is reached. So you can't build
reliable security infrastructure on LD_PRELOAD. This is not a
fundamental problem though - glibc could address this.

> I only see hackish ways to restrict the use of _execve_ in a
> non-cooperative executable. These methods seem globally bypassables
> and not satisfactory from a security point of view.

You're just focusing on execve() - I think it's important to keep in
mind what happens after execve() for normal, dynamically-linked
binaries: The next step is that the dynamic linker runs, and it will
poke around in the file system with access() and openat() and fstat(),
it will mmap() executable libraries into memory, it will mprotect()
some memory regions, it will set up thread-local storage (e.g. using
arch_prctl(); even if the process is single-threaded), and so on.

The earlier you install the seccomp filter, the more of these steps
you have to permit in the filter. And if you want the filter to take
effect directly after execve(), the syscalls you'll be forced to
permit are sufficient to cobble something together in userspace that
effectively does almost the same thing as execve().

Your usecase might be better served by adding a glibc feature for
"unskippable LD_PRELOAD" paired with a constructor function, or
something along those lines.

> IMHO, a way to prepare filter and enable them only on the next
> _execve_ would have some benefit:
> * have a way to restrict _execve_ in a non-cooperative executable;

As I said above, I think glibc is a better place to deal with this -
they could e.g. add a new LD_PRELOAD_MANDATORY that means "you *have*
to preload this library, and if that's not possible because the
library can't be opened or because the execution is setuid, then you
have to treat that as a fatal error".

> * install filters atomically, ie. before the _execve_ system call
> return. That would limit racy situations,

If you say "racy", please also describe what the >=3D2 participants of
the race would be. Are you worried about a scenario where a process A
that dropped privileges becomes dumpable via execve(), and another
process B running under the same set of UIDs (but also a seccomp
filter) then attaches to A and injects code into A before A enables
its seccomp filter? That would require that the sandboxing of process
B is not strong enough to prevent it from interfering with other
processes (that's plausible if we're just externally applying a coarse
sandbox, since procfs access is sufficient for that) and that the
system is not running Yama.

I feel like Seccomp isn't the right place to address processes being
able to debug each other though - something like Yama would probably
be a better place. Or an execveat() flag that explicitly instructs the
kernel to not make the child dumpable automatically.

> and have the very firsts
> instructions of potentially untrusted binaries already subject to
> seccomp filters.

By "untrusted", do you mean "actively malicious" or "exploitable"? If
they are just exploitable, you probably don't need to apply filters
from the first instruction, only from when the buggy code actually
starts running and parsing input.
If they are actively malicious, it'd be a different story; but as far
as I know, normally even if a service has been compromised, its
executables and libraries are owned by root, and so an attacker
shouldn't be able to overwrite those.
(And you could apply a basic filter before execve and then add some
finer restrictions for things like mmap() at a later point.)

> It would also ensure there is only one thread running
> at the filter enabling time.

You're alluding to cases where library constructor functions launch
threads? Is that a thing anyone does? (And in case someone does it, we
still have TSYNC, so I don't think this would be a real problem.)

> From what I understand, there is a relative use case[2] where the
> "enable on exec" mode would also be a solution.

I can sort of see the argument for making seccomp easier to use in
this case by creating separate "prepare" and "activate" steps and
thereby reducing the complexity of plumbing the fd to the supervisor;
but I don't think execve would necessarily be the right place to
trigger the activation. Depending on the usecase, It might be better
to e.g. let glibc activate the filter directly before calling into
main(), or something like that.

> Thanks for your attention,
> C. Mougey
>
> [1]: https://github.com/netblue30/firejail/issues/3685
> [2]: https://lore.kernel.org/linux-man/202010250759.F9745E0B6@keescook/
