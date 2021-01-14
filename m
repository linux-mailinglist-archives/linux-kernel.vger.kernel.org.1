Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7072F68FD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 19:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbhANSHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 13:07:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbhANSHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 13:07:45 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE94C061574
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 10:07:05 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id b8so3323278plx.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 10:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aCkCkIm7M/V3aGjrSdpkfleCJSzQcdZs8yV7RPXbePM=;
        b=K/M2Fo8B44jLooZGdYkru1sOnkiQtv6dp75doN8uGV6BKLnJA6w84N7yHV5f9TfM+H
         bBdfYmg+sQuEG6GXOjB3fF/JiwIqnbVajxDEcL5M+63ZKOyFtJPT0eKkqrVgZJgGYeJK
         sfMClc2nGr01vZJbDkqDw+5ZhwCIi2nRZMWPuiI6VxCsNzFC4hICz6+DpxxISFhkrono
         G/iRRKQMdPOuz9AU5S5Voow4LwmR8fkmOyjL0kCSmFumT/0NF/Ft41TbboYyYgnwlsPf
         jLUA2ELI76MIHProf3sgiVBjL3IqzTMuMdsS0rifJpGopbSnBDuFAiy6nBJanKl8qi0S
         7+1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aCkCkIm7M/V3aGjrSdpkfleCJSzQcdZs8yV7RPXbePM=;
        b=my80/9dwcZ+sDvVHjKX2FR9J1Vv4Y/mi8lRI1Cic5deNJWyYMuqp2cnKruRq2POIqv
         9iBxYni4297TCGd65cAVEdd539Ct4B8bbdVkdzjp9IdHwHW4CRXtvp4/tIv0pxeyXgfL
         H0V64pm60Vru0lrCNGlu2gf4OzdPveCOkPRMyI1HqCPN3kXZo34vPJxoUqFy9AwGULce
         ayUbk2vLMWjrOj4g5D6+2rciSpKEhGUnpqxHcnBWxtqrCXsqwbEDy007Ds8eUpqyqUNL
         bojAQYoqJV20PpbXYGJzjmAi/Ye+rL71/fBE0qKnFhi7QGYOXuqXoiqK4OpY9LMLm9Td
         XE0w==
X-Gm-Message-State: AOAM5315AqwAGMFg2voWANd4qDHt/BHs6QJZ6/ek38Gcy3maqIh0qkTU
        bgVBBE7qd55ShM1ISysPeyIAzijEjAZQjozXtIRQnA==
X-Google-Smtp-Source: ABdhPJx2foYAxYogJLKcrBZsfkDGuwgYD4tZTN9CIVtRZpbcsf42aQ7eKvh+41k5lutAisVHdKTTUw/bfGSPUEHd20c=
X-Received: by 2002:a17:902:9b84:b029:dd:f952:db30 with SMTP id
 y4-20020a1709029b84b02900ddf952db30mr8634534plp.56.1610647624919; Thu, 14 Jan
 2021 10:07:04 -0800 (PST)
MIME-Version: 1.0
References: <0000000000004a33a005b8b8eaab@google.com> <20210112194058.GA200254@ubuntu-m3-large-x86>
 <CACT4Y+YFZf=BnCQJQUYwG-UpaYKG97VD-XWpEdXoR3ZnOxH5NQ@mail.gmail.com> <CACT4Y+Z-f+r_Bm5RD+ZFrspHdVrDrzPgEB_9_uACa_8o4vz7aw@mail.gmail.com>
In-Reply-To: <CACT4Y+Z-f+r_Bm5RD+ZFrspHdVrDrzPgEB_9_uACa_8o4vz7aw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 14 Jan 2021 10:06:54 -0800
Message-ID: <CAKwvOdmBGNK0iVCAGc=7oKx9k1fE1C6y7G9S+hCYLmdu5kaKLQ@mail.gmail.com>
Subject: Re: upstream build error (12)
To:     Dmitry Vyukov <dvyukov@google.com>, Marco Elver <elver@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        syzbot <syzbot+76880518931d755473cf@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 4:38 AM 'Dmitry Vyukov' via Clang Built Linux
<clang-built-linux@googlegroups.com> wrote:
>
> On Thu, Jan 14, 2021 at 12:32 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Tue, Jan 12, 2021 at 8:41 PM Nathan Chancellor
> > <natechancellor@gmail.com> wrote:
> > >
> > > Would it be possible for clang-built-linux@googlegroups.com to be CC'd
> > > when there is a build error and the compiler is clang? Especially if
> > > clang is hitting an assertion.
> >
> > Hi Nathan,
> >
> > I am adding functionality to CC specific emails on build errors on
> > specific instances:
> > https://github.com/google/syzkaller/pull/2388
>
> I've updated configs to CC clang-built-linux@googlegroups.com. This
> should take effect on the next build failure (hopefully).

Thanks Dmitry, (and thanks Marco for updating syzbot's clang).

Marco, can you update:
https://github.com/google/syzkaller/blob/master/docs/syzbot.md#crash-does-not-reproduce

I wasn't able to reproduce the reported compiler crash with ToT llvm
and the reported config, so I assume it was a mid-release of llvm-11
bug that has since been fixed.  Do we need to report to syzbot to
close the issue? I did a quick skim of
https://github.com/google/syzkaller/blob/master/docs/syzbot.md, but it
looks like communication with syzbot is based on commit messages?
--
Thanks,
~Nick Desaulniers
