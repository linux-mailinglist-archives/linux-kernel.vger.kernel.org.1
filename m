Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F085127A088
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 12:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgI0Ktd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 06:49:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:33534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbgI0Ktd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 06:49:33 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1ED922207;
        Sun, 27 Sep 2020 10:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601203772;
        bh=v4wAp7TzaBv/3e5/khjeQZDvyg7WNSfGVz/rTmLXXzw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=odY2GbJ5RysIyCg+t7hIMFcIecjtxeXEYzr+W0Xj0uOK5yPBlnOMRkbBOiDgsTf0z
         5lWS25WxC79wTv2oOtsPQqADWF8t7+bKWBmtWYG374WlfuKwoZa/AukPbiXwOz2V8i
         NA9KWn1DfWGGKa+Yu7rLOGMmvAj7+ta4g/XYtTck=
Date:   Sun, 27 Sep 2020 12:49:43 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     shuo.a.liu@intel.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Yakui Zhao <yakui.zhao@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fengwei Yin <fengwei.yin@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: [PATCH v4 02/17] x86/acrn: Introduce acrn_{setup,
 remove}_intr_handler()
Message-ID: <20200927104943.GF88650@kroah.com>
References: <20200922114311.38804-1-shuo.a.liu@intel.com>
 <20200922114311.38804-3-shuo.a.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922114311.38804-3-shuo.a.liu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 07:42:56PM +0800, shuo.a.liu@intel.com wrote:
> From: Shuo Liu <shuo.a.liu@intel.com>
> 
> The ACRN Hypervisor builds an I/O request when a trapped I/O access
> happens in User VM. Then, ACRN Hypervisor issues an upcall by sending
> a notification interrupt to the Service VM. HSM in the Service VM needs
> to hook the notification interrupt to handle I/O requests.
> 
> Notification interrupts from ACRN Hypervisor are already supported and
> a, currently uninitialized, callback called.
> 
> Export two APIs for HSM to setup/remove its callback.
> 
> Originally-by: Yakui Zhao <yakui.zhao@intel.com>
> Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
> Reviewed-by: Zhi Wang <zhi.a.wang@intel.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Sean Christopherson <sean.j.christopherson@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Fengwei Yin <fengwei.yin@intel.com>
> Cc: Zhi Wang <zhi.a.wang@intel.com>
> Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
> Cc: Yu Wang <yu1.wang@intel.com>
> Cc: Reinette Chatre <reinette.chatre@intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  arch/x86/include/asm/acrn.h |  8 ++++++++
>  arch/x86/kernel/cpu/acrn.c  | 16 ++++++++++++++++
>  2 files changed, 24 insertions(+)
>  create mode 100644 arch/x86/include/asm/acrn.h
> 
> diff --git a/arch/x86/include/asm/acrn.h b/arch/x86/include/asm/acrn.h
> new file mode 100644
> index 000000000000..ff259b69cde7
> --- /dev/null
> +++ b/arch/x86/include/asm/acrn.h
> @@ -0,0 +1,8 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_X86_ACRN_H
> +#define _ASM_X86_ACRN_H
> +
> +void acrn_setup_intr_handler(void (*handler)(void));
> +void acrn_remove_intr_handler(void);
> +
> +#endif /* _ASM_X86_ACRN_H */
> diff --git a/arch/x86/kernel/cpu/acrn.c b/arch/x86/kernel/cpu/acrn.c
> index 0b2c03943ac6..42e88d01ccf9 100644
> --- a/arch/x86/kernel/cpu/acrn.c
> +++ b/arch/x86/kernel/cpu/acrn.c
> @@ -9,7 +9,11 @@
>   *
>   */
>  
> +#define pr_fmt(fmt) "acrn: " fmt

Why is this needed, if you are not adding pr_* calls in this patch?

thanks,

greg k-h
