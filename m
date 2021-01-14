Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED8362F6B96
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 20:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730264AbhANTzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 14:55:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbhANTze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 14:55:34 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6717AC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 11:54:54 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id b24so6368054otj.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 11:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/SuJMUWVOi8e1e2W8L0m+9Q9z4tau/lW1SPqWZ+fTKM=;
        b=Ql0fQZzKudSAhdA0CI4dbCMC8Z8UbIE4TgV+t2l0ROTQBEqe4wojrRKiDeAzriahuG
         JA7Z76tsVytkVeUpcDx/Dv/qX3yXS7cYW3fL9zTsCiYgfo/rnoKExJ1qUVUGZWw+NtRP
         fkWRprDWcN/+Mic6bX+o65swo+vIarp0GgTMjMLFXvJ/J9A7StJ3umjsLZIIqlSyUTY/
         qulUfMeyjQBnCfUp+20Fzbvw/+XcfZ6PEvpJeGzbGW/ujIBRXUA6zW0bgdmGBwOBuFSO
         CCFHvjerD7xrQA6AwMj/8rcpvkwaWmF+H5s+Qc5ZpFMJV2gUVCuoJQLRpgKjwm65YM1b
         2TCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/SuJMUWVOi8e1e2W8L0m+9Q9z4tau/lW1SPqWZ+fTKM=;
        b=MdBpdLW3hfQTlaFYbXIhyf8Oh8KYJn1WAxNCN0W4Fsnb4y38cH8cqyNTL+ey8ggUyf
         /Ld3f5NrSKT8bIDN+LlS577xMKhE9MK1nAvOKSygFdTjEzJxVgzyyPDC/WrH9qKiNyk+
         WnR85DJXrLfcevnGQBavr85XbXCJxNJJcVu4/xz6IUpu9H3aL1e8vYXMhcLHiMqotzre
         gzMa39hrOuPm8AOtBYA5+OeDtATPJuLlQs7k8l0VROApRFDYoMPCRMGfEDJk9itiQIQy
         TTgy5SGVyrQWzW3On/PONknYdPnhhQBWKu+jUmjVmNzT11Fb958v+jvBH+j/KEeNj6vj
         1DSA==
X-Gm-Message-State: AOAM533609naaKDsOO6zcsf1yfJ1FGVgv3cC1LYknHTTlgoxWDONWEVR
        oGxZNiRSKzdNtMiP2tfd7ZHq/NzEraMHNHNDICUyig==
X-Google-Smtp-Source: ABdhPJyGMoiavQ4kURubCDjavlDtKAm6koB678nF+gelqrQ7MvvW4FCmaIJ8ym0zJHbl5hc+phrhTSZPIzsWeZr99p8=
X-Received: by 2002:a05:6830:2413:: with SMTP id j19mr5923004ots.251.1610654093639;
 Thu, 14 Jan 2021 11:54:53 -0800 (PST)
MIME-Version: 1.0
References: <0000000000004a33a005b8b8eaab@google.com> <20210112194058.GA200254@ubuntu-m3-large-x86>
 <CACT4Y+YFZf=BnCQJQUYwG-UpaYKG97VD-XWpEdXoR3ZnOxH5NQ@mail.gmail.com>
 <CACT4Y+Z-f+r_Bm5RD+ZFrspHdVrDrzPgEB_9_uACa_8o4vz7aw@mail.gmail.com> <CAKwvOdmBGNK0iVCAGc=7oKx9k1fE1C6y7G9S+hCYLmdu5kaKLQ@mail.gmail.com>
In-Reply-To: <CAKwvOdmBGNK0iVCAGc=7oKx9k1fE1C6y7G9S+hCYLmdu5kaKLQ@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 14 Jan 2021 20:54:42 +0100
Message-ID: <CANpmjNMmObBWzHqcQ2VHru2Tdu8k0KOkVUE2upPitsOh3OoF3Q@mail.gmail.com>
Subject: Re: upstream build error (12)
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        syzbot <syzbot+76880518931d755473cf@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jan 2021 at 19:07, Nick Desaulniers <ndesaulniers@google.com> wrote:
> On Thu, Jan 14, 2021 at 4:38 AM 'Dmitry Vyukov' via Clang Built Linux
> <clang-built-linux@googlegroups.com> wrote:
> >
> > On Thu, Jan 14, 2021 at 12:32 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> > >
> > > On Tue, Jan 12, 2021 at 8:41 PM Nathan Chancellor
> > > <natechancellor@gmail.com> wrote:
> > > >
> > > > Would it be possible for clang-built-linux@googlegroups.com to be CC'd
> > > > when there is a build error and the compiler is clang? Especially if
> > > > clang is hitting an assertion.
> > >
> > > Hi Nathan,
> > >
> > > I am adding functionality to CC specific emails on build errors on
> > > specific instances:
> > > https://github.com/google/syzkaller/pull/2388
> >
> > I've updated configs to CC clang-built-linux@googlegroups.com. This
> > should take effect on the next build failure (hopefully).
>
> Thanks Dmitry, (and thanks Marco for updating syzbot's clang).
>
> Marco, can you update:
> https://github.com/google/syzkaller/blob/master/docs/syzbot.md#crash-does-not-reproduce

We have:

> compiler:       clang version 11.0.0 (https://github.com/llvm/llvm-project.git ca2dcbd030eadbf0aa9b660efe864ff08af6e18b)

Which is in the list of compilers:
https://storage.googleapis.com/syzkaller/clang-11-prerelease-ca2dcbd030e.tar.xz

> I wasn't able to reproduce the reported compiler crash with ToT llvm
> and the reported config, so I assume it was a mid-release of llvm-11
> bug that has since been fixed.  Do we need to report to syzbot to
> close the issue? I did a quick skim of
> https://github.com/google/syzkaller/blob/master/docs/syzbot.md, but it
> looks like communication with syzbot is based on commit messages?

Given we this is likely due to a prerelease compiler, we can just use:

#syz invalid

^^ it should pick this up.

Thanks,
-- Marco
