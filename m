Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73878275659
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 12:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgIWK3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 06:29:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:52284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726422AbgIWK3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 06:29:39 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCAAE23119;
        Wed, 23 Sep 2020 10:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600856978;
        bh=wHFiqSVP5wiacoZPIFyckOzrdnch7kPOpZ+Gij8UoLs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=avm7LiDgHBa4fVDvu0xyDB8Zo8qQYTiXQt8zn0xEPGYOTW52E7S89HBXc5q+w/D0b
         kxmbKuciqkuunFNzfXAB8wMcHnFNpxoXXQ8fo4wmMcWq1IihvNOuaD+DmjzEeT+YrN
         JKKkN+QyOSn8k6KIOTYIMoWzt4WL+tYdFB9aXF7E=
Date:   Wed, 23 Sep 2020 12:29:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     arnd@arndb.de, keescook@chromium.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 10/11] drivers/misc/vmw_vmci: convert num guest
 devices counter to counter_atomic
Message-ID: <20200923102957.GF3154647@kroah.com>
References: <cover.1600816121.git.skhan@linuxfoundation.org>
 <e53dcdeb280bd90e074f214f8f292e89dedb36df.1600816121.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e53dcdeb280bd90e074f214f8f292e89dedb36df.1600816121.git.skhan@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 07:43:39PM -0600, Shuah Khan wrote:
> counter_atomic is introduced to be used when a variable is used as
> a simple counter and doesn't guard object lifetimes. This clearly
> differentiates atomic_t usages that guard object lifetimes.
> 
> counter_atomic variables will wrap around to 0 when it overflows and
> should not be used to guard resource lifetimes, device usage and
> open counts that control state changes, and pm states.
> 
> atomic_t variable used to count number of vmci guest devices is used
> as just as counter and it doesn't control object lifetimes or state
> management. Overflow doesn't appear to be problem for this use.
> 
> Convert it to use counter_atomic.
> 
> This conversion doesn't change the oveflow wrap around behavior.
> 
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
>  drivers/misc/vmw_vmci/vmci_guest.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/misc/vmw_vmci/vmci_guest.c b/drivers/misc/vmw_vmci/vmci_guest.c
> index cc8eeb361fcd..2c21448af730 100644
> --- a/drivers/misc/vmw_vmci/vmci_guest.c
> +++ b/drivers/misc/vmw_vmci/vmci_guest.c
> @@ -20,6 +20,7 @@
>  #include <linux/smp.h>
>  #include <linux/io.h>
>  #include <linux/vmalloc.h>
> +#include <linux/counters.h>
>  
>  #include "vmci_datagram.h"
>  #include "vmci_doorbell.h"
> @@ -68,11 +69,11 @@ struct pci_dev *vmci_pdev;
>  static struct vmci_guest_device *vmci_dev_g;
>  static DEFINE_SPINLOCK(vmci_dev_spinlock);
>  
> -static atomic_t vmci_num_guest_devices = ATOMIC_INIT(0);
> +static struct counter_atomic vmci_num_guest_devices = COUNTER_ATOMIC_INIT(0);
>  
>  bool vmci_guest_code_active(void)
>  {
> -	return atomic_read(&vmci_num_guest_devices) != 0;
> +	return counter_atomic_read(&vmci_num_guest_devices) != 0;
>  }
>  
>  u32 vmci_get_vm_context_id(void)
> @@ -624,7 +625,7 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
>  
>  	dev_dbg(&pdev->dev, "Registered device\n");
>  
> -	atomic_inc(&vmci_num_guest_devices);
> +	counter_atomic_inc(&vmci_num_guest_devices);
>  
>  	/* Enable specific interrupt bits. */
>  	cmd = VMCI_IMR_DATAGRAM;
> @@ -684,7 +685,7 @@ static void vmci_guest_remove_device(struct pci_dev *pdev)
>  
>  	dev_dbg(&pdev->dev, "Removing device\n");
>  
> -	atomic_dec(&vmci_num_guest_devices);
> +	counter_atomic_dec(&vmci_num_guest_devices);
>  
>  	vmci_qp_guest_endpoints_exit();
>  

While this conversion looks fine to me, wow, the code does not really
seem to be doing the right thing.  So that's something to fix up
independantly of this change, not your fault at all :)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
