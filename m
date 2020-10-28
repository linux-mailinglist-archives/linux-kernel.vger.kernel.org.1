Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B54BB29D90B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388975AbgJ1Wio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388950AbgJ1WiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:38:22 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1022C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:38:21 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id s9so732255wro.8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QS4EnFX6AmlcEUTn4kjwTeWHhMAjTaD3XA3AGB+7TY0=;
        b=KZ3UwAfj5i+27klN0a4tHXuGvuCSU0mg8fvYSBx4qvDhaq/mwBMAWFYqRVtNV+ESBQ
         +9O9IfocZjEAQPwma+h6htQNL+WIcAGDhMvJvO4FMvd61nvKItJvYP9x6XJLuLMonnQt
         galgbj3msWdda+NdxziyuM1YkzYG4mxjWMpvAz5Nl8ZgpkGDyYUplIfCfNSk1BwSB3jI
         +MIjJchtbYHFovczUlnObt3lkaqAR3xoLfxl7RZoK/RsXTMISUmd4ICm4KU8pNjBqg8n
         YD7F3VrRPi5T+IDEh6iOqu9J5weC6Cuh7MrmEPwZB/yMAqC9rIIeZbX3gSRRV4zB4Gp8
         Ap8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QS4EnFX6AmlcEUTn4kjwTeWHhMAjTaD3XA3AGB+7TY0=;
        b=GswvPkpLfPAVhvWEKKzjafEOtpzlJ/U5hIVYow0R6XEeEd2Q87yARMknGeRJQpo5x6
         ELY91SoSkycfMEd+r2TQXxoM3vzCH1M07DrET+vv9hXkP0Zj0QdBWKDQKQhoZUfEG34I
         lR2DCUXzkd136HP3ggVBWD/H53QC06873ijXDH9kn28YdzaEtHx1SFNvGU19jJvQuUsa
         oKrwKVLvIpgwcUXOL/6/y71ugNL7kqN8hk/7HZ79LF8JYDH0/d7UqyruxwAW+QHnIXOC
         EEEvM3MoylNeeprQTwbVRoHW+XklP3G1Et9LeFnENTeUZvCSEiAqyH0D/YpH8hLGqnuX
         ACYw==
X-Gm-Message-State: AOAM531IutS7jmMeHkakxAlfM1LSSx1yhnQo6YwvdPeK9n+NVujKPmO2
        ml7JDNMU9XWDwFRCGjOhytkNbx3fvaRmZBiMzOgbhvO+vuLCLA==
X-Google-Smtp-Source: ABdhPJxHeQx42vWevxKl0pyFupw1sDxgg0bsKu6fbUvbZv9x+8XzfjcO/vcFqEOvd8dYTQpPYAE2MDDCFnBN+ztrQ9I=
X-Received: by 2002:a19:c357:: with SMTP id t84mr154089lff.34.1603909572173;
 Wed, 28 Oct 2020 11:26:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAAnLoWnS74dK9Wq4EQ-uzQ0qCRfSK-dLqh+HCais-5qwDjrVzg@mail.gmail.com>
 <CAG48ez3ZXmJ1ndEmZtoieOAm05p+5X7+HXo61LwpuiWFWGWK4w@mail.gmail.com>
 <20201028164936.GC534@brightrain.aerifal.cx> <CAG48ez2rC1OKYMM6eG4Fyq2xvTit6t3PUY0VE8A56EAqNmEVzg@mail.gmail.com>
 <20201028175241.GD534@brightrain.aerifal.cx>
In-Reply-To: <20201028175241.GD534@brightrain.aerifal.cx>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 28 Oct 2020 19:25:45 +0100
Message-ID: <CAG48ez3aSn2HSWuO0bhrRSFr_EPqkqshspsqiDZX+aYSpHnjOA@mail.gmail.com>
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

On Wed, Oct 28, 2020 at 6:52 PM Rich Felker <dalias@libc.org> wrote:
> On Wed, Oct 28, 2020 at 06:34:56PM +0100, Jann Horn wrote:
> > On Wed, Oct 28, 2020 at 5:49 PM Rich Felker <dalias@libc.org> wrote:
> > > On Wed, Oct 28, 2020 at 01:42:13PM +0100, Jann Horn wrote:
> > > > On Wed, Oct 28, 2020 at 12:18 PM Camille Mougey <commial@gmail.com> wrote:
> > > > You're just focusing on execve() - I think it's important to keep in
> > > > mind what happens after execve() for normal, dynamically-linked
> > > > binaries: The next step is that the dynamic linker runs, and it will
> > > > poke around in the file system with access() and openat() and fstat(),
> > > > it will mmap() executable libraries into memory, it will mprotect()
> > > > some memory regions, it will set up thread-local storage (e.g. using
> > > > arch_prctl(); even if the process is single-threaded), and so on.
> > > >
> > > > The earlier you install the seccomp filter, the more of these steps
> > > > you have to permit in the filter. And if you want the filter to take
> > > > effect directly after execve(), the syscalls you'll be forced to
> > > > permit are sufficient to cobble something together in userspace that
> > > > effectively does almost the same thing as execve().
> > >
> > > I would assume you use SECCOMP_RET_USER_NOTIF to implement policy for
> > > controlling these operations and allowing only the ones that are valid
> > > during dynamic linking. This also allows you to defer application of
> > > the filter until after execve. So unless I'm missing some reason why
> > > this doesn't work, I think the requested functionality is already
> > > available.
> >
> > Ah, yeah, good point.
> >
> > > If you really just want the "activate at exec" behavior, it might be
> > > possible (depending on how SECCOMP_RET_USER_NOTIF behaves when there's
> > > no notify fd open; I forget)
> >
> > syscall returns -ENOSYS. Yeah, that'd probably do the job. (Even
> > though it might be a bit nicer if userspace had control over the errno
> > there, such that it could be EPERM instead... oh well.)
>
> EPERM is a major bug in current sandbox implementations, so ENOSYS is
> at least mildly better, but indeed it should be controllable, probably
> by allowing a code path for the BPF to continue with a jump to a
> different logic path if the notify listener is missing.

I guess we might be able to expose the listener status through a bit /
a field in the struct seccomp_data, and then filters could branch on
that. (And the kernel would run the filter twice if we raced with
filter detachment.) I don't know whether it would look pretty, but I
think it should be doable...
