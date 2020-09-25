Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC78279509
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 01:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729721AbgIYXsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 19:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729629AbgIYXrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 19:47:47 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6694C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 16:47:46 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id z18so4770419pfg.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 16:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Io7hz4IuqZtEpaytzAzCxwSUam0CFx9DS3tqLdxn+Xk=;
        b=Vp5m6tCDtyV4W/JH0g4qWcc327nWVydhooFj9uwSpVAY0st4EEXpvloPDbNDLUzEge
         ywH/h1AoxE8vmj64+7NIXyeLfN4EvN1QEEZ1xgXXA/m9O9RMBN8i2YkTSTw3fwHOZvAq
         g0p+zzkkPf8d2ui3sxADVxcXOjMUhtNwsWnSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Io7hz4IuqZtEpaytzAzCxwSUam0CFx9DS3tqLdxn+Xk=;
        b=MdUnmCAu2usmxPyics6h75lQLuG5c8JJ47y5/Rs5bptDXcqUYxfms3RTBMbUrvAYGm
         26umslOWd28GgovyofQ2ZvdL924Lw0kFESY0Wt/+d4cRIN98ndd+reBOCb0vayo2am1s
         NYxiHQXQmCA7atNQexI4ZUsR67WJtKqcmtosKlD/HvICRTbFn9DMigpWnF5Cx8iqYwbw
         pnz3J1kBOI/APKDYmSA6XOyoeTYShHyCtA+C3NdGeFIUbyflEacUsfTbSHzodaOKMQvj
         fmUnvCw/t3Mn3L2GeC1KLHdva4KS/8g2y7Qhb92TL7So5Nv9MJZKCLRiz4HCMsjnNq3O
         JQOQ==
X-Gm-Message-State: AOAM533w9CWeqAiDaiOHb/qIVTg3XXtwI2XhKm54kYo+iYqrtZZN0S1O
        4qIzodsex26akcX17FPNz4MWHw==
X-Google-Smtp-Source: ABdhPJxEslujd3tp9T1ofdE6n0YODMisS2U8S0qulVyj48Ul/uxdH4vlyBD4bOXB2UljyUZYhZqVDA==
X-Received: by 2002:aa7:93a2:0:b029:142:2501:39f4 with SMTP id x2-20020aa793a20000b0290142250139f4mr838077pff.67.1601077666482;
        Fri, 25 Sep 2020 16:47:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q5sm3603706pfb.184.2020.09.25.16.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 16:47:45 -0700 (PDT)
Date:   Fri, 25 Sep 2020 16:47:44 -0700
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
Message-ID: <202009251647.FD8CECD4@keescook>
References: <CAOuPNLjtG_VHL1M8-=pKNNRmWQg_8oC0YG7C8H3gQcbJ+0B3=A@mail.gmail.com>
 <202009251301.A1FD183582@keescook>
 <CAMj1kXGtv84JHQfKoqOYyq=3m2w0Yuj_n4_Teo83zvdZ9kpZhw@mail.gmail.com>
 <202009251338.D17FB071@keescook>
 <CAMj1kXEWutwE-fP9bc=tsyPoTuV6J7bLzLpkZ213P9y9JszkTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEWutwE-fP9bc=tsyPoTuV6J7bLzLpkZ213P9y9JszkTw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 11:09:10PM +0200, Ard Biesheuvel wrote:
> On Fri, 25 Sep 2020 at 22:47, Kees Cook <keescook@chromium.org> wrote:
> >
> > On Fri, Sep 25, 2020 at 10:37:01PM +0200, Ard Biesheuvel wrote:
> > > On Fri, 25 Sep 2020 at 22:28, Kees Cook <keescook@chromium.org> wrote:
> > > >
> > > > On Fri, Sep 25, 2020 at 08:33:59PM +0530, Pintu Agarwal wrote:
> > > > > This is regarding the KASLR feature support on ARM for the kernel
> > > > > version 4.9 and 4.14.
> > > > >
> > > > > Is KASLR supported on ARM-32 Linux 4.9 and above ?
> > > >
> > > > Sorry, this feature did not yet land in upstream:
> > > > https://github.com/KSPP/linux/issues/3
> > > >
> > > > Here was the earlier effort:
> > > > https://lore.kernel.org/kernel-hardening/20170814125411.22604-1-ard.biesheuvel@linaro.org/
> > > >
> > > > > Is it dependent on CONFIG_RANDOMIZE_BASE or
> > > >
> > > > CONFIG_RANDOMIZE_BASE is what is used on other architectures to control
> > > > the feature.
> > > >
> > > > > /proc/sys/kernel/randomize_va_space ?
> > > > > Is there any relation between these two?
> > > >
> > > > No, the latter is about userspace addresses.
> > > >
> > > > > Is the changing kernel symbols (in every boot), only possible if KASLR
> > > > > is enabled, or there is another way it can happen?
> > > >
> > > > I think you meant kernel symbol addresses (not the symbols themselves).
> > > > But yes, I wouldn't expect the addresses to move if you didn't either
> > > > rebuild the kernel or had something else moving the kernel at boot (i.e.
> > > > the boot loader).
> > > >
> > > > > I have these queries because,
> > > > > In one of the arm-32 devices with Kernel 4.14, I observed that
> > > > > CONFIG_RANDOMIZE_BASE is not available.
> > > > > But /proc/sys/kernel/randomize_va_space is set to 2.
> > > > > However, I also observed that symbol addresses are changing in every boot.
> > > > >
> > > > > 1st boot cycle:
> > > > > [root ~]# cat /proc/kallsyms | grep "sys_open"
> > > > > a5b4de92 T sys_open
> > > > > [root@sa515m ~]#
> > > > >
> > > > > 2nd boot cycle:
> > > > > [root ~]# cat /proc/kallsyms | grep "sys_open"
> > > > > f546ed66 T sys_open
> > > > >
> > > > > So, I am wondering how this is possible without KASLR
> > > > > (CONFIG_RANDOMIZE_BASE) support in Kernel ?
> > >
> > > Those addresses were obfuscated by kptr_restrict
> >
> > Is that true? kptr_restrict zeros (rather than hashing) the kallsyms
> > view. And besides, the %p hashing was added in v4.15 (but also doesn't
> > touch kallsyms, which does all-or-nothing to avoid breaking stuff
> > like perf).
> >
> 
> Ah yes, good point. But it does look suspiciously like they are being
> mangled in a similar way.
> 
> For a 3/1 split ARM kernel of the typical size, all kernel virtual
> addresses start with 0xc0, and given that the kernel is located at the
> start of the linear map, those addresses cannot change even if you
> move the kernel around in physical memory.

I wonder if this is an Android Common kernel? I think there was %p
hashing in there before v4.15, but with a different implementation...

-- 
Kees Cook
