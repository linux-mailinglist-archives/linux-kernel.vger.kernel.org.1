Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBAD2DAE7D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 15:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729368AbgLOOCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 09:02:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729250AbgLOOBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 09:01:44 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA882C06179C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 06:01:03 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id w16so15270362pga.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 06:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A+G1WfxuzopjSGXsyyh6fV+cm5tzdzFwJFw7K7WHVUE=;
        b=sASorQfNuaBWVsxWUIUgLm7Qp2mxT+WTVUU7goR/Wivp2sk6xds760igjubEb7CoeF
         hIqVYyTgT8yRQK3bHnIVcJeuxSnlJ0VKMnNw+3evRRtPbbeukNE+VUAQp6AVGnlaM34p
         AgEdx2v7zUT83kp8zyj1HUdzy64yL2JDzMiaTsLI9l2YhhlHjV8+2LuiYVtpoGTBY8pG
         lqypksdABpZlAkrgveMN2rs6i5sT9HKrCVONAMu57N4+p76FCGZxTaxPf1Xm/FUBKDd9
         LCuuKYE6M8XZOzE2QKA8iIn2TPeHbdry7p6/pgpK5C0Kt9iNzGzLk9bBFldawchUOtWI
         W+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A+G1WfxuzopjSGXsyyh6fV+cm5tzdzFwJFw7K7WHVUE=;
        b=LIzyhv9TnI+g1RbtKrl0Qu9QhFkTPoWe5G7FvSaKtIiJNGvM4Ggwm8NJVqonQkuoq2
         rSj73Vyqg6n5wBXEI/xPqM445bAENp4V00jRa9YkHziVjmFNMgai73HBY92KeV98/H5+
         aTIHZ745tnPqoZndvT7RGrmIg39r2ThBaQRVolCMMsGZffbVa0MiEUUv9GmPXJpQzpWG
         hRriJBNfg8HW3wVEQerc8ofKjL8P5urFDHwV6xQDH23YGKX6D/OALVm7i/6hMZhkHS3P
         yERjONxt9K/0qY33Jc0YV22/IrzGphN0lh9Whr+4QEUhtFlHNbO3Jlr4m3fabudnhnve
         IErw==
X-Gm-Message-State: AOAM531VBnk/Etc4AyWBhwsEhgXTb1/HphG7LOJqNWT22/Xc0EornKdM
        95dCJ7QlTftVpgO4M/Fa+WuAzBj4nWRcFaV7ILuSgg==
X-Google-Smtp-Source: ABdhPJyMgW0OYCfeZFQyxyHm1d3EzMswdKYQjqqrPwUwc+sHW04nsTP2ZMXEKhTlhUJCCf0ucrZC/P6el8NYTUn0mqg=
X-Received: by 2002:a63:5d3:: with SMTP id 202mr23746844pgf.286.1608040863307;
 Tue, 15 Dec 2020 06:01:03 -0800 (PST)
MIME-Version: 1.0
References: <20201214191413.3164796-1-elver@google.com>
In-Reply-To: <20201214191413.3164796-1-elver@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 15 Dec 2020 15:00:52 +0100
Message-ID: <CAAeHK+x3w=rw3Jk3Zg-Q2H6iboWH3dqGvgm9ZXxsCaBGGzR9JA@mail.gmail.com>
Subject: Re: [PATCH] lkdtm: disable KASAN for rodata.o
To:     Marco Elver <elver@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14, 2020 at 8:15 PM Marco Elver <elver@google.com> wrote:
>
> Building lkdtm with KASAN and Clang 11 or later results in the following
> error when attempting to load the module:
>
>   kernel tried to execute NX-protected page - exploit attempt? (uid: 0)
>   BUG: unable to handle page fault for address: ffffffffc019cd70
>   #PF: supervisor instruction fetch in kernel mode
>   #PF: error_code(0x0011) - permissions violation
>   ...
>   RIP: 0010:asan.module_ctor+0x0/0xffffffffffffa290 [lkdtm]
>   ...
>   Call Trace:
>    do_init_module+0x17c/0x570
>    load_module+0xadee/0xd0b0
>    __x64_sys_finit_module+0x16c/0x1a0
>    do_syscall_64+0x34/0x50
>    entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> The reason is that rodata.o generates a dummy function that lives in
> .rodata to validate that .rodata can't be executed; however, Clang 11
> adds KASAN globals support by generating module constructors to
> initialize globals redzones. When Clang 11 adds a module constructor to
> rodata.o, it is also added to .rodata: any attempt to call it on
> initialization results in the above error.
>
> Therefore, disable KASAN instrumentation for rodata.o.
>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  drivers/misc/lkdtm/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/misc/lkdtm/Makefile b/drivers/misc/lkdtm/Makefile
> index c70b3822013f..1c4c7aca0026 100644
> --- a/drivers/misc/lkdtm/Makefile
> +++ b/drivers/misc/lkdtm/Makefile
> @@ -11,6 +11,7 @@ lkdtm-$(CONFIG_LKDTM)         += usercopy.o
>  lkdtm-$(CONFIG_LKDTM)          += stackleak.o
>  lkdtm-$(CONFIG_LKDTM)          += cfi.o
>
> +KASAN_SANITIZE_rodata.o                := n
>  KASAN_SANITIZE_stackleak.o     := n
>  KCOV_INSTRUMENT_rodata.o       := n
>
>
> base-commit: 2c85ebc57b3e1817b6ce1a6b703928e113a90442
> --
> 2.29.2.684.gfbc64c5ab5-goog
>

Reviewed-by: Andrey Konovalov <andreyknvl@google.com>

Thanks for taking care of this!
