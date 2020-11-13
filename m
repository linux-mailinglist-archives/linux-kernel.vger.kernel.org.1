Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42DB52B1404
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 02:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgKMBvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 20:51:25 -0500
Received: from linux.microsoft.com ([13.77.154.182]:55838 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbgKMBvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 20:51:24 -0500
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
        by linux.microsoft.com (Postfix) with ESMTPSA id 136CC20C2884
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 17:51:24 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 136CC20C2884
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1605232284;
        bh=OOJfuTij/WDmu9nVOlF7gDSBvVsQ0moMnMR59C+JADg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=f2wnACQkuvA2/L/gOyBhxCov3/1MNgLeoajOu1D41Z2NIiHRCoJ/vTZuHK/cBmJX+
         yudUrAwjjCMhMh0EEnuRpJSMj4s74bP1HG9CkPtNj9V2fFT/iF+bpXrEZSDnYX4rY0
         yy4L1KBG5jiuBR4/7HmbfOOojA1KVk+ndpeh+ZfI=
Received: by mail-qv1-f49.google.com with SMTP id x13so3889349qvk.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 17:51:23 -0800 (PST)
X-Gm-Message-State: AOAM533TW4Ts68edeEt010uoyil/WIvk2L9KARbIoxWyNsoNsTlblMdj
        ivd20PTVKM+wMfMveRcB6JF4ff/cJmOMy3/+TGk=
X-Google-Smtp-Source: ABdhPJxJrrmk9DZyRN3Lg7DByg08WgeUz21AJ+lf2CKwfPwsXCnf3EK01N5Idzf8C54KvjRe+bPGn3WgFGa9G/WBkAg=
X-Received: by 2002:ad4:5685:: with SMTP id bc5mr223052qvb.48.1605232283117;
 Thu, 12 Nov 2020 17:51:23 -0800 (PST)
MIME-Version: 1.0
References: <20201113010739.516026-1-mcroce@linux.microsoft.com>
In-Reply-To: <20201113010739.516026-1-mcroce@linux.microsoft.com>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Fri, 13 Nov 2020 02:50:47 +0100
X-Gmail-Original-Message-ID: <CAFnufp1WrFKx1OnWqcv-sfeF=TL9jw=V0Qg+GidQJz9DEc=jzA@mail.gmail.com>
Message-ID: <CAFnufp1WrFKx1OnWqcv-sfeF=TL9jw=V0Qg+GidQJz9DEc=jzA@mail.gmail.com>
Subject: Re: [PATCH] reboot: sync documentation with current code
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 2:07 AM Matteo Croce <mcroce@linux.microsoft.com> wrote:
>
> From: Matteo Croce <mcroce@microsoft.com>
>
> The valid values accepted by /sys/kernel/reboot/type are a bit different
> that the ones used in the kernel command line.
>
> In /sys we supports 'cf9_force' and 'cf9_safe', while in the kernel command
> line 'pci' and 'q' are used.
>
> Document the right values in the sysfs documentation.
>
> Fixes: eab8da48579d ("reboot: allow to specify reboot mode via sysfs")
> Signed-off-by: Matteo Croce <mcroce@microsoft.com>
> ---
>  Documentation/ABI/testing/sysfs-kernel-reboot | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-kernel-reboot b/Documentation/ABI/testing/sysfs-kernel-reboot
> index 837330fb2511..fcc5d193c16c 100644
> --- a/Documentation/ABI/testing/sysfs-kernel-reboot
> +++ b/Documentation/ABI/testing/sysfs-kernel-reboot
> @@ -16,7 +16,8 @@ What:         /sys/kernel/reboot/type
>  Date:          November 2020
>  KernelVersion: 5.11
>  Contact:       Matteo Croce <mcroce@microsoft.com>
> -Description:   Reboot type. Valid values are: bios acpi kbd triple efi pci
> +Description:   Reboot type. Valid values are:
> +               bios acpi kbd triple efi cf9_force cf9_safe
>
>  What:          /sys/kernel/reboot/cpu
>  Date:          November 2020
> --
> 2.28.0
>

So, discard this one, I will rename 'cf9_force' to 'pci' instead.
Simpler, and coherent with the kernel cmdline.

-- 
per aspera ad upstream
