Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C80BF2B1F53
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 16:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgKMP5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 10:57:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:51032 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726503AbgKMP5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 10:57:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605283020; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rOuCTKmLpMQNXtXb2BJrqYzxdZQPyxTkqBZUS54RrzQ=;
        b=XObrq8K4gq0n6GqHKk1JRiAYe9x++ApSs/jWr/7pWJ0SsrOIkdpRlfqcaOe07SKeUtsBwL
        6c+FcCspenFZhNhCdhgSQhxuBtAf7pQe+x7+SdmSj8Gsr8lF+71Y0hSZYgigCzb0Xm6sU9
        eNa/GYAMmVM9ZHxKXhP+8jEQ89MDq4I=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CF5FBAE49;
        Fri, 13 Nov 2020 15:56:59 +0000 (UTC)
Date:   Fri, 13 Nov 2020 16:56:59 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     mcroce@linux.microsoft.com, akpm@linux-foundation.org,
        arnd@arndb.de, keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux@roeck-us.net, pasha.tatashin@soleen.com, rppt@kernel.org,
        tyhicks@linux.microsoft.com, ndesaulniers@google.com,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] reboot: Fix variable assignments in type_store
Message-ID: <20201113155659.GN1602@alley>
References: <20201110202746.9690-1-mcroce@linux.microsoft.com>
 <20201112035023.974748-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112035023.974748-1-natechancellor@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2020-11-11 20:50:23, Nathan Chancellor wrote:
> Clang warns:
> 
> kernel/reboot.c:707:17: warning: implicit conversion from enumeration
> type 'enum reboot_type' to different enumeration type 'enum reboot_mode'
> [-Wenum-conversion]
>                 reboot_mode = BOOT_TRIPLE;
>                             ~ ^~~~~~~~~~~
> kernel/reboot.c:709:17: warning: implicit conversion from enumeration
> type 'enum reboot_type' to different enumeration type 'enum reboot_mode'
> [-Wenum-conversion]
>                 reboot_mode = BOOT_KBD;
>                             ~ ^~~~~~~~
> kernel/reboot.c:711:17: warning: implicit conversion from enumeration
> type 'enum reboot_type' to different enumeration type 'enum reboot_mode'
> [-Wenum-conversion]
>                 reboot_mode = BOOT_BIOS;
>                             ~ ^~~~~~~~~
> kernel/reboot.c:713:17: warning: implicit conversion from enumeration
> type 'enum reboot_type' to different enumeration type 'enum reboot_mode'
> [-Wenum-conversion]
>                 reboot_mode = BOOT_ACPI;
>                             ~ ^~~~~~~~~
> kernel/reboot.c:715:17: warning: implicit conversion from enumeration
> type 'enum reboot_type' to different enumeration type 'enum reboot_mode'
> [-Wenum-conversion]
>                 reboot_mode = BOOT_EFI;
>                             ~ ^~~~~~~~
> kernel/reboot.c:717:17: warning: implicit conversion from enumeration
> type 'enum reboot_type' to different enumeration type 'enum reboot_mode'
> [-Wenum-conversion]
>                 reboot_mode = BOOT_CF9_FORCE;
>                             ~ ^~~~~~~~~~~~~~
> kernel/reboot.c:719:17: warning: implicit conversion from enumeration
> type 'enum reboot_type' to different enumeration type 'enum reboot_mode'
> [-Wenum-conversion]
>                 reboot_mode = BOOT_CF9_SAFE;
>                             ~ ^~~~~~~~~~~~~
> 7 warnings generated.
> 
> It seems that these assignment should be to reboot_type, not
> reboot_mode. Fix it so there are no more warnings and the code works
> properly.
> 
> Fixes: eab8da48579d ("reboot: allow to specify reboot mode via sysfs")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1197
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  kernel/reboot.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/reboot.c b/kernel/reboot.c
> index deba133a071b..8599d0d44aec 100644
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -704,19 +704,19 @@ static ssize_t type_store(struct kobject *kobj, struct kobj_attribute *attr,
>  		return -EPERM;
>  
>  	if (!strncmp(buf, BOOT_TRIPLE_STR, strlen(BOOT_TRIPLE_STR)))
> -		reboot_mode = BOOT_TRIPLE;
> +		reboot_type = BOOT_TRIPLE;
>  	else if (!strncmp(buf, BOOT_KBD_STR, strlen(BOOT_KBD_STR)))
> -		reboot_mode = BOOT_KBD;
> +		reboot_type = BOOT_KBD;
>  	else if (!strncmp(buf, BOOT_BIOS_STR, strlen(BOOT_BIOS_STR)))
> -		reboot_mode = BOOT_BIOS;
> +		reboot_type = BOOT_BIOS;
>  	else if (!strncmp(buf, BOOT_ACPI_STR, strlen(BOOT_ACPI_STR)))
> -		reboot_mode = BOOT_ACPI;
> +		reboot_type = BOOT_ACPI;
>  	else if (!strncmp(buf, BOOT_EFI_STR, strlen(BOOT_EFI_STR)))
> -		reboot_mode = BOOT_EFI;
> +		reboot_type = BOOT_EFI;
>  	else if (!strncmp(buf, BOOT_CF9_FORCE_STR, strlen(BOOT_CF9_FORCE_STR)))
> -		reboot_mode = BOOT_CF9_FORCE;
> +		reboot_type = BOOT_CF9_FORCE;
>  	else if (!strncmp(buf, BOOT_CF9_SAFE_STR, strlen(BOOT_CF9_SAFE_STR)))
> -		reboot_mode = BOOT_CF9_SAFE;
> +		reboot_type = BOOT_CF9_SAFE;
>  	else
>  		return -EINVAL;

Great catch! I guess that it has been a cut&paste mistake when writing
the code.

I feel shame that I have missed it. I think that I have even tested it
but I probably tried only mode_store() and mode_read().

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
