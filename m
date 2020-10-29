Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39AA529E4A7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730456AbgJ2Hkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727682AbgJ2HYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:24:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61C9C0613B5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 22:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=jsHMSO6I0PKQ5HkHdXagl2pTqyDNokSH65F0LTeWvY4=; b=mXAnRCk2UCBp/9zBc78X08NTnp
        l8uLH46V+u+f31/yUfUKPmThKD+C5D+fWfxUHIjgmETdscvBzLp6uL440GcLkpJ9VWFA9ws414A8E
        nEM0ANjz4AYnBpOP1lUTBc7rWdyeOPYnDLdHECD5QXA1ReuBi+ohe30rvf9dg9ks83laWtSX4O3qp
        cADYRK1kl4ouvYUIcBt8JCMZZ4K+/5ukUlGUMOwiPZxwvKQIPzYUQGcmrMPb1WxwvfWnyLOoHFiPt
        qpSpDxvwNKLGRNYVoeQhvxl7Yf8Cb3A6PRAAfVoOFsQ8vfnX1M+dgV7GsTWaJwiQ6Kj7NJpGCgXl/
        G6/WdGLg==;
Received: from [2601:1c0:6280:3f0::507c]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kY0GX-0001aX-V6; Thu, 29 Oct 2020 05:14:27 +0000
Subject: Re: [PATCH RFC v2 4/4] Documentation: Change doc for
 split_lock_detect parameter
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Christopherson Sean J <sean.j.christopherson@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
References: <20201028202804.3562179-1-fenghua.yu@intel.com>
 <20201028202804.3562179-5-fenghua.yu@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1bb9d2f7-e20d-a0d9-c94f-328e1dc83323@infradead.org>
Date:   Wed, 28 Oct 2020 22:14:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201028202804.3562179-5-fenghua.yu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/20 1:28 PM, Fenghua Yu wrote:
> Since #DB for bus lock detect changes the split_lock_detect parameter,
> update the documentation for the changes.
> 
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
>  .../admin-guide/kernel-parameters.txt         | 47 +++++++++++++++----
>  1 file changed, 39 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 526d65d8573a..51312484c2b6 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5044,27 +5044,58 @@
>  	spia_peddr=
>  
>  	split_lock_detect=
> -			[X86] Enable split lock detection
> +			[X86] Enable split lock detection or bus lock detection
>  
>  			When enabled (and if hardware support is present), atomic
>  			instructions that access data across cache line
> -			boundaries will result in an alignment check exception.
> +			boundaries will result in an alignment check exception
> +			for split lock detection or an debug exception for
> +			bus lock detection.
>  
>  			off	- not enabled
>  
> -			warn	- the kernel will emit rate limited warnings
> -				  about applications triggering the #AC
> -				  exception. This mode is the default on CPUs
> -				  that supports split lock detection.
> +			warn	- Default mode.
>  
> -			fatal	- the kernel will send SIGBUS to applications
> -				  that trigger the #AC exception.
> +				  If split lock detection is enabled in
> +				  hardware, the kernel will emit rate limited
> +				  warnings about applications triggering the #AC
> +				  exception.
> +
> +				  If bus lock detection is enabled in hardware,
> +				  the kernel will emit rate limited warnings
> +				  about applications triggering the #DB
> +				  exception.
> +
> +				  Default behavior is from bus lock detection
> +				  if both features are enabled in hardware.
> +
> +			fatal	- If split lock detection is enabled in
> +				  hardware, the kernel will send SIGBUS to
> +				  applications that trigger the #AC exception.
> +
> +				  If bus lock detection is enabled in hardware,
> +				  the kernel will send SIGBUS to application
> +				  that trigger the #DB exception.
> +
> +				  Default behavior is from split lock detection
> +				  if both are enabled in hardware.
> +

Hi,
This appears to have quite a bit of duplicated lines....

> +			ratelimit:N
> +				  Set rate limit to N bus locks per second
> +				  for bus lock detection. 0 < N <= HZ/2 and
> +				  N is approximate. Only applied to non root
> +				  user.
> +
> +				  N/A for split lock detection.
>  
>  			If an #AC exception is hit in the kernel or in
>  			firmware (i.e. not while executing in user mode)
>  			the kernel will oops in either "warn" or "fatal"
>  			mode.
>  
> +			#DB exception for bus lock is triggered only when
> +			CPL > 0.
> +
>  	srbds=		[X86,INTEL]
>  			Control the Special Register Buffer Data Sampling
>  			(SRBDS) mitigation.
> 


-- 
~Randy

