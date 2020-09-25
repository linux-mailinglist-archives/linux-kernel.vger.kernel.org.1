Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 299D4279217
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 22:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbgIYUdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 16:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727015AbgIYU0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 16:26:41 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D22C0613AF
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 13:26:41 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id n14so4315398pff.6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 13:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Fvm57bum9kABDubOAKIbQd4nwdbZ7F2cf8tIZTaBPm8=;
        b=XNId8adnBwEC06gRrqP/D3oaJauLEoxwFtxl+nQG3+ll1hkht6e5jd425rRVzwvmhW
         UbA7Hm/OAXHe+FDpDbPoiyhBxaAb6pU0fEoasNt6YJMYhm1HphELCt4XTXgO+ZeYVnJn
         e+1Dhh9NOdzaJBRh00ic7DJ0oj8EBbG9YZ/PE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Fvm57bum9kABDubOAKIbQd4nwdbZ7F2cf8tIZTaBPm8=;
        b=TDdFyQTjEz5XyG7d7IYmhLPx9JjyOGphv+KM08jN47V26uIbsqr92WRUUf4JoUbY+5
         u6a71NkQ9R0gzMKet9th5vFVBvoNv8fEGj/jOXoaolgW+LV7j7D4Mj4at2vLjnPOVq8s
         UTblg6Xy2lAD07oby7/ke6JUaQhrSjrB8b0upDVfVwA8gbw+gjWBd4U2rF5G7i14mAmu
         ZTRn5YnqxEjf15hjv2fWddgh+tvlVyILembsj9eMVOgfM1En5xH1MhdGGFnkZMbwoKvI
         Lbo+h9lvUnu6XlqpPMtn6cGFHle1xzyYekaP50MuNKn+KAdq6PpZnBzQ+7H1MwHeeVEv
         YwLA==
X-Gm-Message-State: AOAM532lEMmtO/i/VKVNSXfutxL8rAAl6bMs7A/j+v+QbbYs/yTYoEqF
        0taxvsFegF5ehlaLc8v0smUVvQ==
X-Google-Smtp-Source: ABdhPJzHcUOsSX4WD1whW8SuAJtKoqgb4PqzG4KokfYygfdUFgfIAzjY6l1h6pQzMv383WEMuYRsog==
X-Received: by 2002:a65:5881:: with SMTP id d1mr542082pgu.193.1601065600492;
        Fri, 25 Sep 2020 13:26:40 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q15sm68096pje.29.2020.09.25.13.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 13:26:39 -0700 (PDT)
Date:   Fri, 25 Sep 2020 13:26:38 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Pintu Agarwal <pintu.ping@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Kernelnewbies <kernelnewbies@kernelnewbies.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        ard.biesheuvel@linaro.org, arnd@arndb.de, nico@linaro.org,
        thgarnie@google.com, marc.zyngier@arm.com,
        Mark Rutland <mark.rutland@arm.com>, tony@atomide.com,
        matt@codeblueprint.co.uk, dave.martin@arm.com
Subject: Re: KASLR support on ARM with Kernel 4.9 and 4.14
Message-ID: <202009251301.A1FD183582@keescook>
References: <CAOuPNLjtG_VHL1M8-=pKNNRmWQg_8oC0YG7C8H3gQcbJ+0B3=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOuPNLjtG_VHL1M8-=pKNNRmWQg_8oC0YG7C8H3gQcbJ+0B3=A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 08:33:59PM +0530, Pintu Agarwal wrote:
> This is regarding the KASLR feature support on ARM for the kernel
> version 4.9 and 4.14.
> 
> Is KASLR supported on ARM-32 Linux 4.9 and above ?

Sorry, this feature did not yet land in upstream:
https://github.com/KSPP/linux/issues/3

Here was the earlier effort:
https://lore.kernel.org/kernel-hardening/20170814125411.22604-1-ard.biesheuvel@linaro.org/

> Is it dependent on CONFIG_RANDOMIZE_BASE or

CONFIG_RANDOMIZE_BASE is what is used on other architectures to control
the feature.

> /proc/sys/kernel/randomize_va_space ?
> Is there any relation between these two?

No, the latter is about userspace addresses.

> Is the changing kernel symbols (in every boot), only possible if KASLR
> is enabled, or there is another way it can happen?

I think you meant kernel symbol addresses (not the symbols themselves).
But yes, I wouldn't expect the addresses to move if you didn't either
rebuild the kernel or had something else moving the kernel at boot (i.e.
the boot loader).

> I have these queries because,
> In one of the arm-32 devices with Kernel 4.14, I observed that
> CONFIG_RANDOMIZE_BASE is not available.
> But /proc/sys/kernel/randomize_va_space is set to 2.
> However, I also observed that symbol addresses are changing in every boot.
> 
> 1st boot cycle:
> [root ~]# cat /proc/kallsyms | grep "sys_open"
> a5b4de92 T sys_open
> [root@sa515m ~]#
> 
> 2nd boot cycle:
> [root ~]# cat /proc/kallsyms | grep "sys_open"
> f546ed66 T sys_open
> 
> So, I am wondering how this is possible without KASLR
> (CONFIG_RANDOMIZE_BASE) support in Kernel ?

What device is this? Is it a stock kernel?

> Similarly, with Kernel 4.9 and CONFIG_RANDOMIZE_BASE is not available
> but /proc/sys/kernel/randomize_va_space is set to 2.
> But here, the addresses are remaining same.
> 
> 1st Run:
> [root~]# cat /proc/kallsyms | grep "sys_open"
> c01ed68c T sys_open
> [root ~]#
> 
> *** reboot ***
> [root ~]# cat /proc/kallsyms | grep "sys_open"
> c01ed68c T sys_open
> 
> 
> Is there any other difference between these two kernel versions with
> respect to changing symbol addresses ?

Is the boot loader changing the base address? (What boot loader are you
using?)

-- 
Kees Cook
