Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 609152D6B70
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 00:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731901AbgLJXBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 18:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730642AbgLJXBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 18:01:23 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34789C0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 15:00:43 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id n7so5711259pgg.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 15:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zQXrB9GHmdvtRuHXM7RSGkfWQJp8dLu6UhfyqtSRnns=;
        b=oJI7rUjABIfze0dgGZkMr02FaZ9Jg88b/E/6azILua9cEMSFUPY9S96DxPyL9fxrPL
         udB81F6h5qsWBn1mWaU6OIs3oDjlDxQNZl2nf5Unsh0sh1DRxlxwlUXO0vPYPAPD9YeX
         RZcjccdsuz1XZBkTfpvqpIgSDfIkkAL2xZohx5CEIdhERACcOE6iHN+jdY7rqjoZd4Eq
         YHi0o5shX5UDJe9n1t+KDdlrP0wxeBq7ONEv7cIMvcnFPoT9FyjAVlcVYHMyHI2Kg6TB
         IsDwipXGvRU5c+/gWYiNGvaIOLzjTzOgu/VA8nANZWqF8k0nBp6P/jsFKNWyQDvCVgKK
         0YvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zQXrB9GHmdvtRuHXM7RSGkfWQJp8dLu6UhfyqtSRnns=;
        b=acXtEHyutceJ7xvT5qycMmWqznIRq4Quh+I+gRgebWpauW4aEOj8+E2miHJkV825el
         ARtvVEZdLT3r60ku18QhVfBjRfK+7H9DllZYOOH5rOmX3fUB0aXfei/HUTs8jpB3nAvO
         jjqSf4ejxpuQ+18VfFw9BphTmPeDwAVSuXgaYkU+wDBeMAOyg6wlW+TqU8zW0eG1sCiN
         GWM4KeIW+NenQATwIcFRY2YP18yVRSmIC6OEcGjyrlctJWqReOfuV/L7rGqgTswVK3hv
         Csa+KbTZ5CjWYaq2rIPBiAEDTl/Ob+g5ZqwdwQhGzjZdLA14H/JRmrjc8eCBzlpqWFat
         5gUg==
X-Gm-Message-State: AOAM532gCk9FNA0/03G9YPEOnF5GeC4U1/XSD/NOGqQJg10s43bqMNS0
        v8KQjljDWsDoBaVGH5OdL3AChhfyg8rtGMz+9pS5wQ==
X-Google-Smtp-Source: ABdhPJz0pxOCfgQlzNtv+0u+GyVi8pW0EKEaGpARy/XIY2lvHQuG2ZyvZwucRGGsuCqcNfyL98lVsF/WJiOSUtAVDtQ=
X-Received: by 2002:a63:184c:: with SMTP id 12mr1301455pgy.381.1607641242592;
 Thu, 10 Dec 2020 15:00:42 -0800 (PST)
MIME-Version: 1.0
References: <20201203223358.1269372-1-arnd@kernel.org>
In-Reply-To: <20201203223358.1269372-1-arnd@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 10 Dec 2020 15:00:30 -0800
Message-ID: <CAKwvOd=i6DFLrPAe5KihT+ZK-nFZ+L7troC300q-9Jpa=i4Fqg@mail.gmail.com>
Subject: Re: [PATCH] watchdog: coh901327: add COMMON_CLK dependency
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-watchdog@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 3, 2020 at 2:34 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> clang produces a build failure in configurations without COMMON_CLK
> when a timeout calculation goes wrong:
>
> arm-linux-gnueabi-ld: drivers/watchdog/coh901327_wdt.o: in function `coh901327_enable':
> coh901327_wdt.c:(.text+0x50): undefined reference to `__bad_udelay'

Isn't a linkage failure against __bad_udelay supposed to be
interpreted as a value too large being passed to udelay()? IIRC, this
was an issue for someone building an Apple touchpad driver with Clang
at -O3...you sent a fix for that:
https://github.com/ClangBuiltLinux/linux/issues/678,
https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git/commit/?id=fff2d0f701e6753591609739f8ab9be1c8e80ebb.

>
> Add a Kconfig dependency to only do build testing when COMMON_CLK
> is enabled.
>
> Fixes: da2a68b3eb47 ("watchdog: Enable COMPILE_TEST where possible")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/watchdog/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 8bdbd125821b..32fa6de7b820 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -631,7 +631,7 @@ config SUNXI_WATCHDOG
>
>  config COH901327_WATCHDOG
>         bool "ST-Ericsson COH 901 327 watchdog"
> -       depends on ARCH_U300 || (ARM && COMPILE_TEST)
> +       depends on ARCH_U300 || (ARM && COMMON_CLK && COMPILE_TEST)
>         default y if MACH_U300
>         select WATCHDOG_CORE
>         help
> --
> 2.27.0
>


-- 
Thanks,
~Nick Desaulniers
