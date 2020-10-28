Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9885229DB51
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 00:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389238AbgJ1Xsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 19:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733137AbgJ1WrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:47:17 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8198BC0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:47:16 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id j24so1158252ejc.11
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NzBAGEHqa0V5kiMIPWULZP2eBI9SZCrw5ZlgIsLXotw=;
        b=bsbjt67010k0XV38slZpOKb0W5naEggG0JziCyKBnMSfNQHn7W1gkena4bquwSwuWA
         9IdYEnJAiQ+3lr7rdXdJOfU+IsVFayD9Yq0hWwlGw2BNr+NU0vlY7yEfQhz3MUGLacFr
         ZEqqB8YJGzcRyxTSRukfp90YbpFu2x7qY77T0iK3ISScucQN/JvUIwfU2bFIgGhW4fZX
         lhLMH1oDcPfF8VgLX83/CGLKENpkN8Vd0kMb58R3Avy8p6adS+JiK8oIYoKVxV/qmFXX
         uXndNgQWaCvnvM8qob+E7JpHaX3h7UTZg0dtWVr12RfbVZpyuGYKy7eCFTOEgY5ETwg9
         0yag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NzBAGEHqa0V5kiMIPWULZP2eBI9SZCrw5ZlgIsLXotw=;
        b=WlqEpr7pGycUWm9gFHAB4W+w4UV2kZ8JKxlm3HsDvDcYFbgWu3tTCF8LLBE9gApkF1
         J3wJQFfGuJ4WAwIVnBL0zAexzMrRcB/TISoDxExJi2W7yZScJehuVhYWNX7VpSCIewm5
         DHAj7JNj0EBahSCCxCHJANnPvYFFOq5kgQDhm6HO8VKxlE6LHAss8MXHIfMyR7eA9v1/
         eh1SyTLhXUGmmN+PIlHroJWbrCr1JCCJq4tucCQZOofxGmZ4DeGYDdoA9KvruIHjnxww
         jz817+r1XXF5Bv1cHSOuxNkFWIbXAwOgLe38VPq4nvA2k17JQP69WUaWhxgkt3K70BtA
         t7oA==
X-Gm-Message-State: AOAM530QAXuTFH3/wF6D9FffMdeH+QkKZCAuvkxm+2mCoccVnBczVGWs
        ODeCdPwRSLGnBvTQugOvT3h3PNHo3DX2tGH8rwC8jJaIFd8=
X-Google-Smtp-Source: ABdhPJybhF4PjEmbIa2ZuM1LKe/+a7sGwFXVflJA1QF59xm0AJj0AUxss9TjY6m6zdAi07tsKtT/VVkXpEVSw+HmKp4=
X-Received: by 2002:a19:e308:: with SMTP id a8mr152828lfh.573.1603910407565;
 Wed, 28 Oct 2020 11:40:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAAnLoWnS74dK9Wq4EQ-uzQ0qCRfSK-dLqh+HCais-5qwDjrVzg@mail.gmail.com>
 <CAG48ez3ZXmJ1ndEmZtoieOAm05p+5X7+HXo61LwpuiWFWGWK4w@mail.gmail.com>
 <20201028164936.GC534@brightrain.aerifal.cx> <CAG48ez2rC1OKYMM6eG4Fyq2xvTit6t3PUY0VE8A56EAqNmEVzg@mail.gmail.com>
 <20201028175241.GD534@brightrain.aerifal.cx> <CAG48ez3aSn2HSWuO0bhrRSFr_EPqkqshspsqiDZX+aYSpHnjOA@mail.gmail.com>
 <20201028183511.GE534@brightrain.aerifal.cx>
In-Reply-To: <20201028183511.GE534@brightrain.aerifal.cx>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 28 Oct 2020 19:39:41 +0100
Message-ID: <CAG48ez0EQjngqowakx_RCUWasXqOwLPbQhGR05x+nQOCWMhyYQ@mail.gmail.com>
Subject: Re: [seccomp] Request for a "enable on execve" mode for Seccomp filters
To:     Rich Felker <dalias@libc.org>
Cc:     Camille Mougey <commial@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Tycho Andersen <tycho@tycho.pizza>,
        Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Denis Efremov <efremov@linux.com>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 7:35 PM Rich Felker <dalias@libc.org> wrote:
> On Wed, Oct 28, 2020 at 07:25:45PM +0100, Jann Horn wrote:
> > On Wed, Oct 28, 2020 at 6:52 PM Rich Felker <dalias@libc.org> wrote:
> > > On Wed, Oct 28, 2020 at 06:34:56PM +0100, Jann Horn wrote:
> > > > On Wed, Oct 28, 2020 at 5:49 PM Rich Felker <dalias@libc.org> wrote:
> > > > > On Wed, Oct 28, 2020 at 01:42:13PM +0100, Jann Horn wrote:
> > > > > > On Wed, Oct 28, 2020 at 12:18 PM Camille Mougey <commial@gmail.com> wrote:
> > > > > > You're just focusing on execve() - I think it's important to keep in
> > > > > > mind what happens after execve() for normal, dynamically-linked
> > > > > > binaries: The next step is that the dynamic linker runs, and it will
> > > > > > poke around in the file system with access() and openat() and fstat(),
> > > > > > it will mmap() executable libraries into memory, it will mprotect()
> > > > > > some memory regions, it will set up thread-local storage (e.g. using
> > > > > > arch_prctl(); even if the process is single-threaded), and so on.
> > > > > >
> > > > > > The earlier you install the seccomp filter, the more of these steps
> > > > > > you have to permit in the filter. And if you want the filter to take
> > > > > > effect directly after execve(), the syscalls you'll be forced to
> > > > > > permit are sufficient to cobble something together in userspace that
> > > > > > effectively does almost the same thing as execve().
> > > > >
> > > > > I would assume you use SECCOMP_RET_USER_NOTIF to implement policy for
> > > > > controlling these operations and allowing only the ones that are valid
> > > > > during dynamic linking. This also allows you to defer application of
> > > > > the filter until after execve. So unless I'm missing some reason why
> > > > > this doesn't work, I think the requested functionality is already
> > > > > available.
> > > >
> > > > Ah, yeah, good point.
> > > >
> > > > > If you really just want the "activate at exec" behavior, it might be
> > > > > possible (depending on how SECCOMP_RET_USER_NOTIF behaves when there's
> > > > > no notify fd open; I forget)
> > > >
> > > > syscall returns -ENOSYS. Yeah, that'd probably do the job. (Even
> > > > though it might be a bit nicer if userspace had control over the errno
> > > > there, such that it could be EPERM instead... oh well.)
> > >
> > > EPERM is a major bug in current sandbox implementations, so ENOSYS is
> > > at least mildly better, but indeed it should be controllable, probably
> > > by allowing a code path for the BPF to continue with a jump to a
> > > different logic path if the notify listener is missing.
> >
> > I guess we might be able to expose the listener status through a bit /
> > a field in the struct seccomp_data, and then filters could branch on
> > that. (And the kernel would run the filter twice if we raced with
> > filter detachment.) I don't know whether it would look pretty, but I
> > think it should be doable...
>
> I was thinking the race wouldn't be salvagable, but indeed since the
> filter is side-effect-free you can just re-run it if the status
> changes between start of filter processing and the attempt at
> notification. This sounds like it should work.
>
> I guess it's not possible to chain two BPF filters to do this, because
> that only works when the first one allows? Or am I misunderstanding
> the multiple-filters case entirely? (I've never gotten that far with
> programming it.)

I'm not sure if I'm understanding the question correctly...
At the moment you basically can't have multiple filters with notifiers.
The rule with multiple filters is always that all the filters get run,
and the actual action taken is the most restrictive result of all of
them.
