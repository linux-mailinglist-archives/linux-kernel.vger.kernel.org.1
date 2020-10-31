Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0622A134C
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 04:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgJaDOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 23:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgJaDOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 23:14:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C12EC0613D5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 20:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=xKg3bvRfjO+hVfAntABAmIoALIljpwZhYJgN8iqjgYA=; b=aMELdpF92QUAb08HVZf7rKsx1F
        XZ0SIEwMaL9S91XJOlBgunKiOLMahA742K3nP2rPdKs9chUYx6FFcfVLwghmAMFnyGtJ25VbFcdWY
        cQyIYhRzGrGPOpCBBogBifvw7GTU/kmbuVNxBv9wEObqelFuDnFsEaIZIhXrO9LTJU/2dT/CvS0+Z
        8mORo76Jd/v2LZerjthQmS0dstAGPiJqB6su+knkkugD2DNwav1J1LEpMFShHyQsFJZYElE/rUjOZ
        3wA3EjKTVS/X3VVSYqIU6OaMz+vW1G3wuiDGbZH1i9O4RkCP0FVNBdWP4XzYR9zoGVDDq0P4vHOjt
        XLTpTw/g==;
Received: from [2601:1c0:6280:3f0::371c]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYhLR-0006tZ-7f; Sat, 31 Oct 2020 03:14:30 +0000
Subject: Re: [PATCH RFC v3 4/4] Documentation/admin-guide: Change doc for
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
References: <20201031002714.3649728-1-fenghua.yu@intel.com>
 <20201031002714.3649728-5-fenghua.yu@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ed101622-11f8-0b98-76ad-6c100a2574da@infradead.org>
Date:   Fri, 30 Oct 2020 20:14:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201031002714.3649728-5-fenghua.yu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/30/20 5:27 PM, Fenghua Yu wrote:
> Since #DB for bus lock detect changes the split_lock_detect parameter,
> update the documentation for the changes.
> 
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
> Change Log:
> - Simplify the documentation (Randy).
> 
>  .../admin-guide/kernel-parameters.txt         | 28 +++++++++++++++----
>  1 file changed, 23 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 526d65d8573a..ee419ce659f5 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5044,27 +5044,45 @@
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
> +			for split lock detection or a debug exception for
> +			bus lock detection.
>  
>  			off	- not enabled
>  
>  			warn	- the kernel will emit rate limited warnings

				                       rate-limited

>  				  about applications triggering the #AC
> -				  exception. This mode is the default on CPUs
> -				  that supports split lock detection.
> +				  exception or the #DB exception. This mode is
> +				  the default on CPUs that supports split lock

				                           support

> +				  detection or bus lock detection. Default
> +				  behavior is from #DB if both features are

I would say			           is by #DB

> +				  enabled in hardware.
>  
>  			fatal	- the kernel will send SIGBUS to applications
> -				  that trigger the #AC exception.
> +				  that trigger the #AC exception or the #DB
> +				  exception. Default behavior is from #AC

and				                              is by #AC

> +				  if both features are enabled in hardware.
> +
> +			ratelimit:N -
> +				  Set rate limit to N bus locks per second
> +				  for bus lock detection. 0 < N <= HZ/2 and
> +				  N is approximate. Only applied to non root

				                                    non-root

> +				  user.

				  users.

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

thanks.
-- 
~Randy

