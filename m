Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5166529E27F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 03:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgJ1VfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:35:25 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43012 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbgJ1VfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:35:20 -0400
Received: by mail-wr1-f67.google.com with SMTP id g12so591115wrp.10
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 14:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=z0bo9p/MHEtnqQo3sYgSNQdn7CC7jYK4NuW7gro8gUQ=;
        b=EjigtYeY5Z4vpwcIl4MJFuY9I6ZyMqhUA1zVC5c+gjfE4oPozccC6kfD6777IpAlGO
         mc7jYs3S+C4MqN5J7lJCxxzJ0WrohShRPgXDyhbAkadQVZUvER7XMM+Ubx0s9JmQnFVd
         tmfWRuYNN3zXDTJsgfnnNky6CXlsMAufYHZHfDQW0XT3L7x+M4Y8Ghdo6aO8wkcupmCG
         qxourfq8Nw66DL49D1ZJeijEs/lS2IJ50yqkXGEkxcKA8/CBeod3gjAm1aMKgB9Cyyos
         yPKmK/QQJ8B2IjkdMT+dkwfD0dRbXNsmOq4MAnD2232N9us6chr6eum9moM9/jjJz7jH
         hNJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=z0bo9p/MHEtnqQo3sYgSNQdn7CC7jYK4NuW7gro8gUQ=;
        b=fB2z1YbRMHvLwSyzjVuXvvyOvphTN2j9R2WFAO/0Ns6n+BkLdMJH0A8VPGksk7HOja
         LJgIFzyREamh8j1bskGMivSkDzFhoxOa6F/bw2e8QfbhgeHMLYKMDSQJnL1Uhda1PmCT
         uHE4Nb8L433nu9kQQtht4ESVlgxZ0AcQTbJG6ym7ezf6qtONeRv5lDw4O0h0ZwnarKKH
         XhaLvPcUFgx6gcdclctlog8CXj5fmg5Uea9hMK+2W8RW0VKE9800jhz+4hQ1B7ISCKTa
         AwbZFlCJ3kTvZJeAsn7gKUzZK5QBIcpF3lmYEkVAXWQJ2Csz9+/sWFuwzPVyc21AFLW/
         QGYQ==
X-Gm-Message-State: AOAM531T0xQtMJWYQkK0aBbRE5TwRi/LwRPdPbnYIlYwF4ECKu3w/X/7
        dmL8v2LI2OV1SZJL4mBX/1xWmdPAbCu3Rb/+y5oWfSjEpg==
X-Google-Smtp-Source: ABdhPJzWkjUo+wzmC+Aid/66YzC6oFHXQvvnXtV3qjYBPDSYSSuo3+DRnzB3mjF3mxvZfHNxyDT1fLGdC7mZRjuKEig=
X-Received: by 2002:a17:906:2894:: with SMTP id o20mr6822049ejd.221.1603883932463;
 Wed, 28 Oct 2020 04:18:52 -0700 (PDT)
MIME-Version: 1.0
From:   Camille Mougey <commial@gmail.com>
Date:   Wed, 28 Oct 2020 12:18:47 +0100
Message-ID: <CAAnLoWnS74dK9Wq4EQ-uzQ0qCRfSK-dLqh+HCais-5qwDjrVzg@mail.gmail.com>
Subject: [seccomp] Request for a "enable on execve" mode for Seccomp filters
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Rich Felker <dalias@libc.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Denis Efremov <efremov@linux.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

(This is my first message to the kernel list, I hope I'm doing it right)

From my understanding, there is no way to delay the activation of
seccomp filters, for instance "until an _execve_ call".
But this might be useful, especially for tools who sandbox other,
non-cooperative, executables, such as "systemd" or "FireJail".

It seems to be a caveat of seccomp specific to the system call
_execve_. For now, some tools such as "systemd" explicitly mention
this exception, and do not support it (from the man page):
> Note that strict system call filters may impact execution and error handl=
ing code paths of the service invocation. Specifically, access to the execv=
e system call is required for the execution of the service binary =E2=80=94=
 if it is blocked service invocation will necessarily fail

"FireJail" takes a different approach[1], with a kind of workaround:
the project uses an external library to be loaded through LD_PRELOAD
mechanism, in order to install filters during the loader stage.
This approach, a bit hacky, also has several caveats:
* _openat_, _mmap_, etc. must be allowed in order to reach the
LD_PRELOAD mechanism, and for the crafted library to work ;
* it doesn't work for static binaries.

I only see hackish ways to restrict the use of _execve_ in a
non-cooperative executable. These methods seem globally bypassables
and not satisfactory from a security point of view.

IMHO, a way to prepare filter and enable them only on the next
_execve_ would have some benefit:
* have a way to restrict _execve_ in a non-cooperative executable;
* install filters atomically, ie. before the _execve_ system call
return. That would limit racy situations, and have the very firsts
instructions of potentially untrusted binaries already subject to
seccomp filters. It would also ensure there is only one thread running
at the filter enabling time.

From what I understand, there is a relative use case[2] where the
"enable on exec" mode would also be a solution.

Thanks for your attention,
C. Mougey

[1]: https://github.com/netblue30/firejail/issues/3685
[2]: https://lore.kernel.org/linux-man/202010250759.F9745E0B6@keescook/
