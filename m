Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 914552A156E
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 12:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgJaLVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 07:21:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:54534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726815AbgJaLVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 07:21:36 -0400
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1420206E3
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 11:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604143296;
        bh=q6oGz/8ItAussXOlMWUFf/4IpF/OPPKENA0njIJMVH4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iieFnTDvgylmx4N916OzF6siKBOXZ4kl8Z6VmYjLra+MxojFBw6K6LtEy3UnUuFUX
         WufN7jw2uLEhGAO6uzBeo3YbpNMftVCdkALrwGFtXxQTqwlU7RHozJU+r6grmMjHn9
         zYMcPRv9/I3+iKZBwoSDgbNBtvoNlP+hBlONidwE=
Received: by mail-ot1-f53.google.com with SMTP id 32so8039215otm.3
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 04:21:35 -0700 (PDT)
X-Gm-Message-State: AOAM532hqLvXlJiyYk4AFVr+IfdA4gsRvXd+w0zjzvHqXyJuDrzIEBSC
        wrzMvBRT2FZAel378UNBdY0tukCjao6eFT8Tal0=
X-Google-Smtp-Source: ABdhPJwZ24xggIB2UkHRly0vVNh0PcjwQRFVCIWjPURq8x2VBQofioE1tfCUJiwsfsricrUt3vxd64vx4EyE2JGyT6Y=
X-Received: by 2002:a05:6830:1f13:: with SMTP id u19mr4933279otg.108.1604143295351;
 Sat, 31 Oct 2020 04:21:35 -0700 (PDT)
MIME-Version: 1.0
References: <20201031094345.6984-1-rppt@kernel.org> <20201031103312.GI1551@shell.armlinux.org.uk>
 <CAMj1kXGPtXsq+26OTr49NXk5uZVt82++-8Ug_E-DYYYJ6WEbWw@mail.gmail.com> <20201031110350.GJ1551@shell.armlinux.org.uk>
In-Reply-To: <20201031110350.GJ1551@shell.armlinux.org.uk>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 31 Oct 2020 12:21:24 +0100
X-Gmail-Original-Message-ID: <CAMj1kXED+Ry7FEtZm-5tL5ZD2c4+nbYtCWrzQmd158+jXHNqPQ@mail.gmail.com>
Message-ID: <CAMj1kXED+Ry7FEtZm-5tL5ZD2c4+nbYtCWrzQmd158+jXHNqPQ@mail.gmail.com>
Subject: Re: [PATCH] ARM, xtensa: highmem: avoid clobbering non-page aligned
 memory reservations
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     linux-xtensa@linux-xtensa.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Chris Zankel <chris@zankel.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 Oct 2020 at 12:04, Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Sat, Oct 31, 2020 at 11:47:42AM +0100, Ard Biesheuvel wrote:
> > On Sat, 31 Oct 2020 at 11:33, Russell King - ARM Linux admin
> > <linux@armlinux.org.uk> wrote:
> > >
> > > On Sat, Oct 31, 2020 at 11:43:45AM +0200, Mike Rapoport wrote:
> > > > From: Ard Biesheuvel <ardb@kernel.org>
> > > >
> > > > free_highpages() iterates over the free memblock regions in high
> > > > memory, and marks each page as available for the memory management
> > > > system.
> > > >
> > > > Until commit cddb5ddf2b76 ("arm, xtensa: simplify initialization of
> > > > high memory pages") it rounded beginning of each region upwards and end of
> > > > each region downwards.
> > > >
> > > > However, after that commit free_highmem() rounds the beginning and end of
> > > > each region downwards, and we may end up freeing a page that is
> > > > memblock_reserve()d, resulting in memory corruption.
> > > >
> > > > Restore the original rounding of the region boundaries to avoid freeing
> > > > reserved pages.
> > > >
> > > > Fixes: cddb5ddf2b76 ("arm, xtensa: simplify initialization of high memory pages")
> > > > Link: https://lore.kernel.org/r/20201029110334.4118-1-ardb@kernel.org/
> > > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > > Co-developed-by:  Mike Rapoport <rppt@linux.ibm.com>
> > > > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > > > ---
> > > >
> > > > Max, Russell,
> > > >
> > > > Please let me know how do you prefer to take it upstream.
> > > > If needed this can go via memblock tree.
> > > >
> > > > v2: fix words order in the commit message
> > >
> > > I really don't understand what is going on here; there seems to be a
> > > total disconnect of communication between yourself and Ard. Ard has
> > > already submitted a different patch for this to the patch system
> > > already, sent yesterday.
> > >
> > > https://www.armlinux.org.uk/developer/patches/viewpatch.php?id=9021/1
> > >
> > > Please discuss between yourselves how you want to solve the problem,
> > > and then submit an agreed and tested patch to those of us upstream;
> > > please don't make it for those upstream to pick one of your patches
> > > as you are at present.
> > >
> >
> > Apologies for creating this confusion. I posted a patch and dropped it
> > into the patch system when I found the bug.
> >
> > However, only when Florian asked about a 'fixes' tag, I went back to
> > the history, and realized that the issue was introduced by Mike during
> > the most recent merge window, and affects xtensa as well.
>
> So why does Mike's patch have:
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>
> in it? It seems you haven't been directly involved in Mike's patch.
>

Because I cc'ed him on the discussion following the patch that is now
in your patch system. So he took that patch and modified it, but
retained the original S-o-b and authorship.

> There's something /really/ not right with the process behind this
> patch.
>
> > I don't have a preference which patch gets applied, though, so please
> > indicate your preference, and we will adapt accordingly.
>
> I asked for you both to come to a concensus about how you want to
> proceed, and now you're throwing it back on to me to solve your(pl)
> mis-communication issue. We haven't heard from Mike yet.
>

I am not throwing it back to you. I merely indicated that I have no
preference, and since Mike is the one who introduced this issue in the
first place, I am expecting him to drive this. And indeed, we haven't
heard from him yet.

> Clearly, I wasn't blunt and stroppy enough to be properly understood.
> Sort it out between yourselves and tell me which patch you want me to
> apply.
>

I would like you to ack this version of the patch, and disregard the
one in the patch system, so that Mike can take this one through the
memblock tree where the issue originated in the first place.
