Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1AEA2B1286
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 00:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgKLXN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 18:13:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:57096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725929AbgKLXNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 18:13:25 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDA7920B80;
        Thu, 12 Nov 2020 23:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605222804;
        bh=YsGxcIS4iXeKitJz/CMM3BDjlgjbCJRNlqlfpqHKCkQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1DkGrMz2weqUbDPR9Rz+sj4j9cAr1FqvSQuy9NQq5NIgjpInj3/SWnDDN+5GFQLlR
         Tjz5x9rB7ZWXHmmTxmNOL5SSXkSidk0yKXNIh9MOKi4NJCGUiG/ZurDb4nZEKi0ply
         jYNrDijIbFCJQSHbAT/7ge6MpGehi3+XaiP8htc4=
Date:   Thu, 12 Nov 2020 15:13:20 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     mcroce@linux.microsoft.com, arnd@arndb.de, keescook@chromium.org,
        linux-kernel@vger.kernel.org, linux@roeck-us.net,
        pasha.tatashin@soleen.com, pmladek@suse.com, rppt@kernel.org,
        tyhicks@linux.microsoft.com, ndesaulniers@google.com,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] reboot: Fix variable assignments in type_store
Message-Id: <20201112151320.e0153ace2f2eb5b59eabbdcb@linux-foundation.org>
In-Reply-To: <20201112035023.974748-1-natechancellor@gmail.com>
References: <20201110202746.9690-1-mcroce@linux.microsoft.com>
        <20201112035023.974748-1-natechancellor@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Nov 2020 20:50:23 -0700 Nathan Chancellor <natechancellor@gmail.com> wrote:

> Clang warns:
> 
> kernel/reboot.c:707:17: warning: implicit conversion from enumeration
> type 'enum reboot_type' to different enumeration type 'enum reboot_mode'
> [-Wenum-conversion]
>                 reboot_mode = BOOT_TRIPLE;
>                             ~ ^~~~~~~~~~~
>
> ...
>
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

This is a fairly dramatic change to the original patch, but it eyeballs
OK.

Matteo, could you please comment?  And preferably retest?

