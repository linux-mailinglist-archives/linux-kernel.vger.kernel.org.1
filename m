Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAAA42F35B6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 17:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406699AbhALQ1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 11:27:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392426AbhALQ1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 11:27:53 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2918C06179F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 08:27:12 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id r9so1884865qtp.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 08:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m/xAg8dQShPpmnR3cYTeN6zfiTB1lY9fOhPpNHe9wdA=;
        b=UvBoBNgrRhXIsFgxW5rNoV2OEMAioOY0QBYgxyqo4GAuUsWSyv6dPMsj2O4q1x/L2o
         Kg0S1XFC0OJpPnd7D30n5fRtXMVQ3d4U7s0YAoVvSksWBLYG3DCYqN/rcFhBZYzY4bIe
         7RtvZT59I7IBTA7nxAdznyhd1ZT1AJBDjvQYRSmXhTvcKvBg7HzXRoYnxCBUv7XeouJI
         t7r36ZMQBfgnQX8Cv9B50F6k34NlsHK7GwjeKQkeviaHqcSzc8OjGz3OISA79JCpkrFI
         x1R9qfE5AJGwgwiIx7+SEjWUbRxo3NGKqfcBYsX2xVuHOG/KjtnQKCANchKjhKHOdGJ1
         OraQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m/xAg8dQShPpmnR3cYTeN6zfiTB1lY9fOhPpNHe9wdA=;
        b=WhxT0DLeOiQWSDHoa7QQnwdVZ5NNVxHZOHkN+eLT1vkHR5lRqYE1RhsykYlw6bKGOD
         TfRKgXTVIpEfzCpxiLGpsmP3B9+3h4BXcwZ2ZUZ9wCn+O3ZKaX1u67Rf49XTljuCc1Ye
         25XshgVd5UHMKzaGQ9xJWJtX94TLiGdwHQV6t+ROQRHeQLM48Z0VJleIM221cSFCi1rz
         wIAYNV330WEL00QsicRxOoXZjy2bP342PS2a8iP4C+yPyOIYvJE6HBFded2KI1IiWctX
         wMu2zz6n5tP9HV+49mzn5Oh4OqiDekLMUP5qBn4vyH2zfOvRk9g+U+U42XjhKnzC33We
         Aw5w==
X-Gm-Message-State: AOAM530DXIyjTrqsxd24QqtBeqzk4LvDI6G1TvJ40zVY8mhFDip0g07A
        BHwo0gLFfQg/bAZUWNSCBeY=
X-Google-Smtp-Source: ABdhPJyWPX1vJJUtz4QEU9rQCyD4hm1OFSqtgcxjAFy5Mz5IU/QGWo+gW9hyd1hO7boop9I0zRUEFA==
X-Received: by 2002:ac8:4b48:: with SMTP id e8mr5515857qts.254.1610468831920;
        Tue, 12 Jan 2021 08:27:11 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id a22sm1508160qkl.121.2021.01.12.08.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 08:27:10 -0800 (PST)
Date:   Tue, 12 Jan 2021 09:27:09 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] ARM: fix link warning with XIP + frame-pointer
Message-ID: <20210112162709.GA3373722@ubuntu-m3-large-x86>
References: <20210112154658.850192-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112154658.850192-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 04:46:40PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When frame pointers are used instead of the ARM unwinder,
> and the kernel is built using clang with an external assembler
> and CONFIG_XIP_KERNEL, every file produces two warnings
> like:
> 
> arm-linux-gnueabi-ld: warning: orphan section `.ARM.extab' from `net/mac802154/util.o' being placed in section `.ARM.extab'
> arm-linux-gnueabi-ld: warning: orphan section `.ARM.exidx' from `net/mac802154/util.o' being placed in section `.ARM.exidx'
> 
> The same fix was already merged for the normal (non-XIP)
> linker script, with a longer description.
> 
> Fixes: c39866f268f8 ("arm/build: Always handle .ARM.exidx and .ARM.extab sections")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
>  arch/arm/kernel/vmlinux-xip.lds.S | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/kernel/vmlinux-xip.lds.S b/arch/arm/kernel/vmlinux-xip.lds.S
> index 4d0b0cd9222e..ddb70c65d525 100644
> --- a/arch/arm/kernel/vmlinux-xip.lds.S
> +++ b/arch/arm/kernel/vmlinux-xip.lds.S
> @@ -43,6 +43,10 @@ SECTIONS
>  		ARM_DISCARD
>  		*(.alt.smp.init)
>  		*(.pv_table)
> +#ifndef CONFIG_ARM_UNWIND
> +		*(.ARM.exidx) *(.ARM.exidx.*)
> +		*(.ARM.extab) *(.ARM.extab.*)
> +#endif
>  	}
>  
>  	. = XIP_VIRT_ADDR(CONFIG_XIP_PHYS_ADDR);
> -- 
> 2.29.2
> 
