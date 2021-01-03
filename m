Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0A12E8959
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 00:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbhABXaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jan 2021 18:30:24 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:47780 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbhABXaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jan 2021 18:30:23 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 6BD7429A95;
        Sat,  2 Jan 2021 18:29:41 -0500 (EST)
Date:   Sun, 3 Jan 2021 10:29:39 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     "David S. Miller" <davem@davemloft.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
cc:     Michael Schmitz <schmitzmic@gmail.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] ide/falconide: Fix module unload
In-Reply-To: <63369c9b96673442a4bd653fe92acda99172123a.1605847196.git.fthain@telegraphics.com.au>
Message-ID: <alpine.LNX.2.23.453.2101031017290.12@nippy.intranet>
References: <63369c9b96673442a4bd653fe92acda99172123a.1605847196.git.fthain@telegraphics.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This patch was sent in September and subsequently resent in November. I've 
since learned that the maintainer has been ill. What's the best way 
forward for fixes like this?

Regards,
Finn

On Fri, 20 Nov 2020, Finn Thain wrote:

> Unloading the falconide module results in a crash:
> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000000
> Oops: 00000000
> Modules linked in: falconide(-)
> PC: [<002930b2>] ide_host_remove+0x2e/0x1d2
> SR: 2000  SP: 00b49e28  a2: 009b0f90
> d0: 00000000    d1: 009b0f90    d2: 00000000    d3: 00b48000
> d4: 003cef32    d5: 00299188    a0: 0086d000    a1: 0086d000
> Process rmmod (pid: 322, task=009b0f90)
> Frame format=7 eff addr=00000000 ssw=0505 faddr=00000000
> wb 1 stat/addr/data: 0000 00000000 00000000
> wb 2 stat/addr/data: 0000 00000000 00000000
> wb 3 stat/addr/data: 0000 00000000 00018da9
> push data: 00000000 00000000 00000000 00000000
> Stack from 00b49e90:
>         004c456a 0027f176 0027cb0a 0027cb9e 00000000 0086d00a 2187d3f0 0027f0e0
>         00b49ebc 2187d1f6 00000000 00b49ec8 002811e8 0086d000 00b49ef0 0028024c
>         0086d00a 002800d6 00279a1a 00000001 00000001 0086d00a 2187d3f0 00279a58
>         00b49f1c 002802e0 0086d00a 2187d3f0 004c456a 0086d00a ef96af74 00000000
>         2187d3f0 002805d2 800de064 00b49f44 0027f088 2187d3f0 00ac1cf4 2187d3f0
>         004c43be 2187d3f0 00000000 2187d3f0 800b66a8 00b49f5c 00280776 2187d3f0
> Call Trace: [<0027f176>] __device_driver_unlock+0x0/0x48
>  [<0027cb0a>] device_links_busy+0x0/0x94
>  [<0027cb9e>] device_links_unbind_consumers+0x0/0x130
>  [<0027f0e0>] __device_driver_lock+0x0/0x5a
>  [<2187d1f6>] falconide_remove+0x12/0x18 [falconide]
>  [<002811e8>] platform_drv_remove+0x1c/0x28
>  [<0028024c>] device_release_driver_internal+0x176/0x17c
>  [<002800d6>] device_release_driver_internal+0x0/0x17c
>  [<00279a1a>] get_device+0x0/0x22
>  [<00279a58>] put_device+0x0/0x18
>  [<002802e0>] driver_detach+0x56/0x82
>  [<002805d2>] driver_remove_file+0x0/0x24
>  [<0027f088>] bus_remove_driver+0x4c/0xa4
>  [<00280776>] driver_unregister+0x28/0x5a
>  [<00281a00>] platform_driver_unregister+0x12/0x18
>  [<2187d2a0>] ide_falcon_driver_exit+0x10/0x16 [falconide]
>  [<000764f0>] sys_delete_module+0x110/0x1f2
>  [<000e83ea>] sys_rename+0x1a/0x1e
>  [<00002e0c>] syscall+0x8/0xc
>  [<00188004>] ext4_multi_mount_protect+0x35a/0x3ce
> Code: 0029 9188 4bf9 0027 aa1c 283c 003c ef32 <265c> 4a8b 6700 00b8 2043 2028 000c 0280 00ff ff00 6600 0176 40c0 7202 b2b9 004c
> Disabling lock debugging due to kernel taint
> 
> This happens because the driver_data pointer is uninitialized.
> Add the missing platform_set_drvdata() call. For clarity, use the
> matching platform_get_drvdata() as well.
> 
> Cc: Michael Schmitz <schmitzmic@gmail.com>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Fixes: 5ed0794cde593 ("m68k/atari: Convert Falcon IDE drivers to platform drivers")
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reviewed-by: Michael Schmitz <schmitzmic@gmail.com>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> ---
> This patch was tested using Aranym.
> ---
>  drivers/ide/falconide.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ide/falconide.c b/drivers/ide/falconide.c
> index dbeb2605e5f6..607c44bc50f1 100644
> --- a/drivers/ide/falconide.c
> +++ b/drivers/ide/falconide.c
> @@ -166,6 +166,7 @@ static int __init falconide_init(struct platform_device *pdev)
>  	if (rc)
>  		goto err_free;
>  
> +	platform_set_drvdata(pdev, host);
>  	return 0;
>  err_free:
>  	ide_host_free(host);
> @@ -176,7 +177,7 @@ static int __init falconide_init(struct platform_device *pdev)
>  
>  static int falconide_remove(struct platform_device *pdev)
>  {
> -	struct ide_host *host = dev_get_drvdata(&pdev->dev);
> +	struct ide_host *host = platform_get_drvdata(pdev);
>  
>  	ide_host_remove(host);
>  
> 
