Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCFB1279248
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 22:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbgIYUhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 16:37:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:47826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729096AbgIYUhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 16:37:13 -0400
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD50822211
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 20:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601066232;
        bh=WZbwT2IHsLPVib9LWqjiQ9VL5NAX2HL7HRcoYiVNWkw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qNb+YYrX1jzXjp9FjsAl2BzlcqEssgXd1+vfLdR4Xy44/ZcEKjpTebtcmPhIR1H14
         qDu+TTbe/P+cWMxj4asNU+S7SegNTtpQqbd6Hlro7NTGLUHUaDM1UjbykZJgEMz5f3
         AEWddnez0BlRcuPJXCE4x3QDSn8sKiuW2OWoAzXo=
Received: by mail-oo1-f53.google.com with SMTP id w25so1064500oos.10
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 13:37:12 -0700 (PDT)
X-Gm-Message-State: AOAM531S0NtHkGxAeAulVH37Zo8Jmxn4XgtP6MsRyz4JU905VrUqdqFK
        tGd9tvEBpuAdLZrKktbJFRACGxe20kJcw7rrV8U=
X-Google-Smtp-Source: ABdhPJy5yn+k2qTffdPEkwz81q4jfUywaUdKX4eyqIezGZqX1pvY0kQk58CIUkInD4MoUX3cSwW3s41Wr8o4wcTAQO8=
X-Received: by 2002:a4a:4910:: with SMTP id z16mr2063269ooa.41.1601066231895;
 Fri, 25 Sep 2020 13:37:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLjtG_VHL1M8-=pKNNRmWQg_8oC0YG7C8H3gQcbJ+0B3=A@mail.gmail.com>
 <202009251301.A1FD183582@keescook>
In-Reply-To: <202009251301.A1FD183582@keescook>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 25 Sep 2020 22:37:01 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGtv84JHQfKoqOYyq=3m2w0Yuj_n4_Teo83zvdZ9kpZhw@mail.gmail.com>
Message-ID: <CAMj1kXGtv84JHQfKoqOYyq=3m2w0Yuj_n4_Teo83zvdZ9kpZhw@mail.gmail.com>
Subject: Re: KASLR support on ARM with Kernel 4.9 and 4.14
To:     Kees Cook <keescook@chromium.org>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Sep 2020 at 22:28, Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Sep 25, 2020 at 08:33:59PM +0530, Pintu Agarwal wrote:
> > This is regarding the KASLR feature support on ARM for the kernel
> > version 4.9 and 4.14.
> >
> > Is KASLR supported on ARM-32 Linux 4.9 and above ?
>
> Sorry, this feature did not yet land in upstream:
> https://github.com/KSPP/linux/issues/3
>
> Here was the earlier effort:
> https://lore.kernel.org/kernel-hardening/20170814125411.22604-1-ard.biesheuvel@linaro.org/
>
> > Is it dependent on CONFIG_RANDOMIZE_BASE or
>
> CONFIG_RANDOMIZE_BASE is what is used on other architectures to control
> the feature.
>
> > /proc/sys/kernel/randomize_va_space ?
> > Is there any relation between these two?
>
> No, the latter is about userspace addresses.
>
> > Is the changing kernel symbols (in every boot), only possible if KASLR
> > is enabled, or there is another way it can happen?
>
> I think you meant kernel symbol addresses (not the symbols themselves).
> But yes, I wouldn't expect the addresses to move if you didn't either
> rebuild the kernel or had something else moving the kernel at boot (i.e.
> the boot loader).
>
> > I have these queries because,
> > In one of the arm-32 devices with Kernel 4.14, I observed that
> > CONFIG_RANDOMIZE_BASE is not available.
> > But /proc/sys/kernel/randomize_va_space is set to 2.
> > However, I also observed that symbol addresses are changing in every boot.
> >
> > 1st boot cycle:
> > [root ~]# cat /proc/kallsyms | grep "sys_open"
> > a5b4de92 T sys_open
> > [root@sa515m ~]#
> >
> > 2nd boot cycle:
> > [root ~]# cat /proc/kallsyms | grep "sys_open"
> > f546ed66 T sys_open
> >
> > So, I am wondering how this is possible without KASLR
> > (CONFIG_RANDOMIZE_BASE) support in Kernel ?
>

Those addresses were obfuscated by kptr_restrict
