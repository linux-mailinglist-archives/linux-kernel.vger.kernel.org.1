Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8925F279298
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 22:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbgIYUrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 16:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbgIYUrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 16:47:25 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D43C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 13:47:25 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id n14so4369786pff.6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 13:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7C9Zlz0e46DAdnF/e0XanUeFYdy+9ZLUi1QSq8iLKOY=;
        b=JbKkYCXQzwQllU+mY7rBbwtyc4aKP85Fzv8l0O0aNBSQ7X0rJgDlrdkAZjBdEleUZG
         L3Hu9ElKYQMmY+7PwpY3AUnhiBgNJpvZH0KNLZPnQIGHiI/xo9FQfoi8FCrI/4osGj9P
         4Jo7IlLyZjYTLYtDH7ZYbeLb/IOF8laCZ1L34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7C9Zlz0e46DAdnF/e0XanUeFYdy+9ZLUi1QSq8iLKOY=;
        b=S66JRlNTGchjlCvb9VI8fGwzDS5rxk6Yjlyo2vjLZkVxX5hDgj2jZwayUNPuUoYpAX
         Eq8oFClaPxuhsnJAZ9r+HXlmaJ9+CLvVI6KwbCv7bsegJSbASRhTT8aX24A3KrYpnow4
         nL5mVTroJDBW422DWcuR5NIdJc3/+8qyD4/SZOfBDttEaqw3g0SEgrzJ269NxrkCGniV
         pIru7s7BCv80A80PMHdyijFcRVdNDntd56/0YoEV3f15HcFq9Pk8Gv4lUidELg3VDFFl
         gwRc3jNeI0sTzV58sU7xVyS0dhniJlzo3n3y0d4WYBH9alY5TOUU+WiOxrEhdK1JuqAx
         oQoQ==
X-Gm-Message-State: AOAM532C8ue6iRcPtLsRQ4hL/8WTCOkWUU7I+zgKa56V8iTmbtcvhml9
        Ed0RJRhAjup4IVrUv+zTq4h+Kw==
X-Google-Smtp-Source: ABdhPJwXuuaq9yCDdhG5xfeSQsX8WManjyq4C6vgn5JVdTwM5yDXqA9A3/qBkjtkvxVMDDk7ZLiRjA==
X-Received: by 2002:a63:6bc9:: with SMTP id g192mr635581pgc.236.1601066844523;
        Fri, 25 Sep 2020 13:47:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d5sm3599693pfq.72.2020.09.25.13.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 13:47:23 -0700 (PDT)
Date:   Fri, 25 Sep 2020 13:47:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Pintu Agarwal <pintu.ping@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Kernelnewbies <kernelnewbies@kernelnewbies.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        open list <linux-kernel@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>, matt@codeblueprint.co.uk,
        nico@linaro.org, Thomas Garnier <thgarnie@google.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: KASLR support on ARM with Kernel 4.9 and 4.14
Message-ID: <202009251338.D17FB071@keescook>
References: <CAOuPNLjtG_VHL1M8-=pKNNRmWQg_8oC0YG7C8H3gQcbJ+0B3=A@mail.gmail.com>
 <202009251301.A1FD183582@keescook>
 <CAMj1kXGtv84JHQfKoqOYyq=3m2w0Yuj_n4_Teo83zvdZ9kpZhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGtv84JHQfKoqOYyq=3m2w0Yuj_n4_Teo83zvdZ9kpZhw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 10:37:01PM +0200, Ard Biesheuvel wrote:
> On Fri, 25 Sep 2020 at 22:28, Kees Cook <keescook@chromium.org> wrote:
> >
> > On Fri, Sep 25, 2020 at 08:33:59PM +0530, Pintu Agarwal wrote:
> > > This is regarding the KASLR feature support on ARM for the kernel
> > > version 4.9 and 4.14.
> > >
> > > Is KASLR supported on ARM-32 Linux 4.9 and above ?
> >
> > Sorry, this feature did not yet land in upstream:
> > https://github.com/KSPP/linux/issues/3
> >
> > Here was the earlier effort:
> > https://lore.kernel.org/kernel-hardening/20170814125411.22604-1-ard.biesheuvel@linaro.org/
> >
> > > Is it dependent on CONFIG_RANDOMIZE_BASE or
> >
> > CONFIG_RANDOMIZE_BASE is what is used on other architectures to control
> > the feature.
> >
> > > /proc/sys/kernel/randomize_va_space ?
> > > Is there any relation between these two?
> >
> > No, the latter is about userspace addresses.
> >
> > > Is the changing kernel symbols (in every boot), only possible if KASLR
> > > is enabled, or there is another way it can happen?
> >
> > I think you meant kernel symbol addresses (not the symbols themselves).
> > But yes, I wouldn't expect the addresses to move if you didn't either
> > rebuild the kernel or had something else moving the kernel at boot (i.e.
> > the boot loader).
> >
> > > I have these queries because,
> > > In one of the arm-32 devices with Kernel 4.14, I observed that
> > > CONFIG_RANDOMIZE_BASE is not available.
> > > But /proc/sys/kernel/randomize_va_space is set to 2.
> > > However, I also observed that symbol addresses are changing in every boot.
> > >
> > > 1st boot cycle:
> > > [root ~]# cat /proc/kallsyms | grep "sys_open"
> > > a5b4de92 T sys_open
> > > [root@sa515m ~]#
> > >
> > > 2nd boot cycle:
> > > [root ~]# cat /proc/kallsyms | grep "sys_open"
> > > f546ed66 T sys_open
> > >
> > > So, I am wondering how this is possible without KASLR
> > > (CONFIG_RANDOMIZE_BASE) support in Kernel ?
> 
> Those addresses were obfuscated by kptr_restrict

Is that true? kptr_restrict zeros (rather than hashing) the kallsyms
view. And besides, the %p hashing was added in v4.15 (but also doesn't
touch kallsyms, which does all-or-nothing to avoid breaking stuff
like perf).

-- 
Kees Cook
