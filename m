Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4DA29D956
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389454AbgJ1WsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733008AbgJ1WsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:48:21 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F62C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:48:20 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 184so872359lfd.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2NxpuTMIkBSZkM0mJufCFmjjTklL6oX2HIuD+SIJm2k=;
        b=ZZ8T3fdh/zfwiT8hUZ2K+wC4T6tiGmG6+WRajoysdo14KqFRyLxbxKwCQPtwr/cSMv
         PB+zVxXXUR86jN9p5Lxp+EdMLn1f+FXYaatkg/wwP+kYzJU2OksrSMXQvZ+Z96sAOJH7
         DmZiR4WAIFpRc02n8A0qEMu691V6ZCuD1e4SunrqkSwnZnKMj4ibSlgmH8MHOD818Em0
         c8d2V0iwHXjo3GqmTmXO6Z4hSHRdzzJqbqsy/sJwpQjegF9PMTosta+LcmE4Bk6Txaun
         1gIfagqK4ypG4n0pw1+eTQH5GFDIMj4u7jouHoTH49ni+SoRPhJgQt0zUn+a3jL+OV9W
         9N3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2NxpuTMIkBSZkM0mJufCFmjjTklL6oX2HIuD+SIJm2k=;
        b=pE4apTAOgHWWAAhqf1kFdC3duXNQprkq9a20pW0xnnSx0NqEW3RIdRd/6js2FSlr62
         PCiLZmTE+grCItlYM/2rH5G0yE3NwayKMLh70UCo9dbOoP3eARfJIFWBJrpgRKhnD5Rk
         euo5jOVsfSEGI21uL10vQcppm7XRzDZjSGqxn0+AhnH1pmylcHYqxPBm9fzl7RkWs13Z
         8q/ogyo1kf7aXPZho0aEJWaJt4ZnsGf51YOFeEo6URCBCicuStYIbYEL32LaW8dQRuwG
         Od8zAD+1HpUhwi5vsqxj/xGU6jUoaumkZUdb7Alt2IPqFhj7LnMvYgp7w0F3a+XxKBJo
         GQNA==
X-Gm-Message-State: AOAM531uZv9RNIKlWVtoXQw1WIzQe/o22c1SE+K/MYFN7CfpRXuhSM3T
        +VF8dYDOlOEx+w9zwa4gDiewkilY+lSJF2/Q0m9Dew5BfnE=
X-Google-Smtp-Source: ABdhPJwewA3joVUu2zr8gvOnaNcOj8uuogndiEJjNdym2R57djeXCtniHnaUSvB3QhNhulAa1K5JwtVgPv/47IcCM/g=
X-Received: by 2002:a2e:b888:: with SMTP id r8mr147310ljp.138.1603906522684;
 Wed, 28 Oct 2020 10:35:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAAnLoWnS74dK9Wq4EQ-uzQ0qCRfSK-dLqh+HCais-5qwDjrVzg@mail.gmail.com>
 <CAG48ez3ZXmJ1ndEmZtoieOAm05p+5X7+HXo61LwpuiWFWGWK4w@mail.gmail.com> <20201028164936.GC534@brightrain.aerifal.cx>
In-Reply-To: <20201028164936.GC534@brightrain.aerifal.cx>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 28 Oct 2020 18:34:56 +0100
Message-ID: <CAG48ez2rC1OKYMM6eG4Fyq2xvTit6t3PUY0VE8A56EAqNmEVzg@mail.gmail.com>
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

On Wed, Oct 28, 2020 at 5:49 PM Rich Felker <dalias@libc.org> wrote:
> On Wed, Oct 28, 2020 at 01:42:13PM +0100, Jann Horn wrote:
> > On Wed, Oct 28, 2020 at 12:18 PM Camille Mougey <commial@gmail.com> wrote:
> > You're just focusing on execve() - I think it's important to keep in
> > mind what happens after execve() for normal, dynamically-linked
> > binaries: The next step is that the dynamic linker runs, and it will
> > poke around in the file system with access() and openat() and fstat(),
> > it will mmap() executable libraries into memory, it will mprotect()
> > some memory regions, it will set up thread-local storage (e.g. using
> > arch_prctl(); even if the process is single-threaded), and so on.
> >
> > The earlier you install the seccomp filter, the more of these steps
> > you have to permit in the filter. And if you want the filter to take
> > effect directly after execve(), the syscalls you'll be forced to
> > permit are sufficient to cobble something together in userspace that
> > effectively does almost the same thing as execve().
>
> I would assume you use SECCOMP_RET_USER_NOTIF to implement policy for
> controlling these operations and allowing only the ones that are valid
> during dynamic linking. This also allows you to defer application of
> the filter until after execve. So unless I'm missing some reason why
> this doesn't work, I think the requested functionality is already
> available.

Ah, yeah, good point.

> If you really just want the "activate at exec" behavior, it might be
> possible (depending on how SECCOMP_RET_USER_NOTIF behaves when there's
> no notify fd open; I forget)

syscall returns -ENOSYS. Yeah, that'd probably do the job. (Even
though it might be a bit nicer if userspace had control over the errno
there, such that it could be EPERM instead... oh well.)
