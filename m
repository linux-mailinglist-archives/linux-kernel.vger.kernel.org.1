Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83F182866FA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 20:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbgJGS1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 14:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbgJGS1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 14:27:34 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D7DC061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 11:27:33 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id g29so1942045pgl.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 11:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ymVtv9z8we+uemQdgcTTCFtg9jdtL6i9lziRYSGdqLY=;
        b=NAitLy3ro1EoqxL1Os7+jL9Cl7w2BNMBSHwH/yDLcoXfRoeeEp86f/3jFb39IdMiBm
         RU+HfWbykKLEEl4lE5juuPVoKTvNwSqCbX73CVMmo5ydjEyeueoivIk7AEQMHB9xI1Qt
         mpMQ+dOrMKV492119aCy+Cf6WRUb8O8BdowSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ymVtv9z8we+uemQdgcTTCFtg9jdtL6i9lziRYSGdqLY=;
        b=gO4WSQ+/OSnzf87Z7Fcr0ihrugYFyOW9rdPpt2EMD7hMFD2po9HNlJZNrJa3InbRRL
         VuftYKzXzA3Obu6QLX6p9xdUhEbGEWkiGPHVi48vmyP2oKogywodEmFVI7d/q40+Mqyh
         S+VOilrHrjjfSi9JvX5EORa7XFhsgAYtO+F/HfvB5aWmon54uN1j9rn9Qw/CsxykKTju
         t4ezqPvtOs8DdJRYhXxNssSP/0NNNX2ZSKmbel+NcwVpHfOO/NLi8GkwobWsk+Fu5Gi6
         C7W3iO0aE/72Y6s7OyKt5Y3s5QdLtvJQRQZsUZFfPD84uL4RZBXrroon/whiwJMC3b8T
         3iUg==
X-Gm-Message-State: AOAM533O+hJCkq8LWppnNbFliPpwvsNSmIUgkoRACkOaRhwy/fxrTSD4
        YRlLMG42AvEBHTX/TOm+S+64YC5x47Fayniy
X-Google-Smtp-Source: ABdhPJw+XHu1u6BdJzcQDAhCppN2N7kssWLj0NxjtLiUczd7SM6AB9x3LGvwuolAAvfYPbWSl3xADA==
X-Received: by 2002:a62:1d52:0:b029:152:3cf6:e2a8 with SMTP id d79-20020a621d520000b02901523cf6e2a8mr4083585pfd.46.1602095251776;
        Wed, 07 Oct 2020 11:27:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id in6sm2520124pjb.42.2020.10.07.11.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 11:27:30 -0700 (PDT)
Date:   Wed, 7 Oct 2020 11:27:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/11] drivers/misc/vmw_vmci: convert num guest
 devices counter to counter_atomic32
Message-ID: <202010071123.B54E1EA20B@keescook>
References: <cover.1602011710.git.skhan@linuxfoundation.org>
 <81f5ca6f9b0a032840d6ec0fb403d4908b9ddec9.1602011710.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81f5ca6f9b0a032840d6ec0fb403d4908b9ddec9.1602011710.git.skhan@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 06, 2020 at 02:44:41PM -0600, Shuah Khan wrote:
> counter_atomic* is introduced to be used when a variable is used as
> a simple counter and doesn't guard object lifetimes. This clearly
> differentiates atomic_t usages that guard object lifetimes.
> 
> counter_atomic* variables will wrap around to 0 when it overflows and
> should not be used to guard resource lifetimes, device usage and
> open counts that control state changes, and pm states.
> 
> atomic_t variable used to count number of vmci guest devices is used
> as just as counter and it doesn't control object lifetimes or state
> management. Overflow doesn't appear to be problem for this use.
> 
> Convert it to use counter_atomic32.
> 
> This conversion doesn't change the overflow wrap around behavior.
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>

I'm not convinced this isn't both managing lifetime and already buggy.
Specifically, I'm looking at how vmci_guest_code_active() is used --
it's being tested before making calls? Is this safe?

> ---
>  drivers/misc/vmw_vmci/vmci_guest.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/misc/vmw_vmci/vmci_guest.c b/drivers/misc/vmw_vmci/vmci_guest.c
> index cc8eeb361fcd..86ae27b05fc2 100644
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
> +static struct counter_atomic32 vmci_num_guest_devices = COUNTER_ATOMIC_INIT(0);
>  
>  bool vmci_guest_code_active(void)
>  {
> -	return atomic_read(&vmci_num_guest_devices) != 0;
> +	return counter_atomic32_read(&vmci_num_guest_devices) != 0;

Shouldn't this be "> 0" ?

>  }
>  
>  u32 vmci_get_vm_context_id(void)
> @@ -624,7 +625,7 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
>  
>  	dev_dbg(&pdev->dev, "Registered device\n");
>  
> -	atomic_inc(&vmci_num_guest_devices);
> +	counter_atomic32_inc(&vmci_num_guest_devices);
>  
>  	/* Enable specific interrupt bits. */
>  	cmd = VMCI_IMR_DATAGRAM;
> @@ -684,7 +685,7 @@ static void vmci_guest_remove_device(struct pci_dev *pdev)
>  
>  	dev_dbg(&pdev->dev, "Removing device\n");
>  
> -	atomic_dec(&vmci_num_guest_devices);
> +	counter_atomic32_dec(&vmci_num_guest_devices);

If there is a bug elsewhere and vmci_guest_remove_device() (or probe)
gets called too many times, shouldn't we protect the rest of this stack
from having vmci_num_guest_devices go negative (and therefore non-zero)?

This really seems like it should be refcount_t to me, though I have no
idea what the races between the dec() and the read() might mean in this
code generally.

-- 
Kees Cook
