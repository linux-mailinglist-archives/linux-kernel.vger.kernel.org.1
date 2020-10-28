Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C668A29E0B1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 02:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729767AbgJ1WDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729410AbgJ1WDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:03:16 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0CFC0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:03:16 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id 13so600040pfy.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bjquVTg1vMGERBSVsx8hHAMGf4NyHc67uQM/Ixwtgw8=;
        b=XrpoH18jr6+Aub7KdGNof7lm6+3iGUHCOkI5ourgPjqCfhpM3nXHbXRrtervIYc1xJ
         mEjhqg3Loymiacra4gcaRACenTlv1H1cNLD79EtxY1nFgyeIVYXfulEdBUjc3JPv2Leg
         7jRhb5cyhKQnhByykHaqPhUIhdyqAq7hbWKX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bjquVTg1vMGERBSVsx8hHAMGf4NyHc67uQM/Ixwtgw8=;
        b=Q8NNc6sXBoMWplTg6X67krLtJi/qm+DHgniQpfp+OVoUposXIx9qnhD1ssWUMO4E65
         Ov3GCH/fEKlcxD83HjXZAjUEhmjXHT7xr7vyFhFqL2qIkt+dGXoNqCle+Ypcue24ScBF
         2qziriR8CbBsCtL5OaKYRUfbpD4vShx47433JvnnnR5eRf3P117MWYnig1fIh+OFhubM
         aI7odR9k+aE/BGPcb4Md/LJQkNFuuPZ/YB0yGn5nhmjkH470SW//Hkc33HRzAWSTs1iz
         eqWYKl1OtrTeHUtp3AOXC5SsiwfJSnDoc3QlVgrpgfV7m/YO30sEH/D0pg0x+QodsH1e
         39NQ==
X-Gm-Message-State: AOAM531k9F6tOTVGRdCBY3ZfwcmSzixZP1cp/3w6em4nfbXbR+5UhI5i
        g6HXBZK6Q0wyP7hKYbTHM+Vj4g==
X-Google-Smtp-Source: ABdhPJw9MuYyE9c9Hw/BSmHWKEKyecMVNgcssyEbmUWU5u4D6ynSbMirrX11EUkNkDhnGhMeB/buxQ==
X-Received: by 2002:a17:90a:1b88:: with SMTP id w8mr953912pjc.130.1603922595791;
        Wed, 28 Oct 2020 15:03:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c10sm549509pfc.196.2020.10.28.15.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 15:03:14 -0700 (PDT)
Date:   Wed, 28 Oct 2020 15:03:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Rich Felker <dalias@libc.org>
Cc:     Jann Horn <jannh@google.com>, Camille Mougey <commial@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Tycho Andersen <tycho@tycho.pizza>,
        Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Denis Efremov <efremov@linux.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [seccomp] Request for a "enable on execve" mode for Seccomp
 filters
Message-ID: <202010281500.855B950FE@keescook>
References: <CAAnLoWnS74dK9Wq4EQ-uzQ0qCRfSK-dLqh+HCais-5qwDjrVzg@mail.gmail.com>
 <CAG48ez3ZXmJ1ndEmZtoieOAm05p+5X7+HXo61LwpuiWFWGWK4w@mail.gmail.com>
 <20201028164936.GC534@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028164936.GC534@brightrain.aerifal.cx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 12:49:36PM -0400, Rich Felker wrote:
> On Wed, Oct 28, 2020 at 01:42:13PM +0100, Jann Horn wrote:
> > +luto just in case he has opinions on this
> > 
> > On Wed, Oct 28, 2020 at 12:18 PM Camille Mougey <commial@gmail.com> wrote:
> > > From my understanding, there is no way to delay the activation of
> > > seccomp filters, for instance "until an _execve_ call".
> > > [...]
> > > I only see hackish ways to restrict the use of _execve_ in a
> > > non-cooperative executable. These methods seem globally bypassables
> > > and not satisfactory from a security point of view.
> > 
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

Oof. Yeah, that's possible, but I view it as kind of not the point of
USER_NOTIF -- I'd rather design a workable solution for the
delayed-apply case.

-- 
Kees Cook
