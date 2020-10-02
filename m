Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7E10280C3E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 04:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387559AbgJBCKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 22:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbgJBCKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 22:10:00 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B057C0613D0;
        Thu,  1 Oct 2020 19:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=DjZ6KH2U/+LNCtogWNgL4pG51gI1w5nX9k7CBApXxjM=; b=GNY/Zo6cI+hacSgxQ80QujX0VQ
        evmOJENebQ/fowVeGzDXWZQp/3Q6UsJTTx/NgVg9k8z9DefIWFIetSRjmNnXPH5//5+U/e955Q0/e
        /q2ucEmTwRMkXACt0DtqCu6dokzlx+lhv3t/pNqhAkXYI5WVtJb+hA1ZOxCzWeLK3oR18PjzKsbRR
        u/CNUritmqZSlOiHWm53mjAA1NVOfS74QukndJk7EtSLILsXI01vuBbioS2qf2I7YbKoe33B0AJ29
        lh82zK6aMBpZrY3tf6N1nSGrPxmD3n1BvmKXWR+P9skqsYTf7eqYp+ufYEnIr7cO7MfyEccU7hvWz
        UGbvhl2w==;
Received: from [2601:1c0:6280:3f0::863]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOAWB-0003ge-27; Fri, 02 Oct 2020 02:09:55 +0000
Subject: Re: [RFC PATCH 22/22] x86/fpu/xstate: Introduce boot-parameters for
 control some state component support
To:     "Chang S. Bae" <chang.seok.bae@intel.com>, tglx@linutronix.de,
        mingo@kernel.org, bp@suse.de, luto@kernel.org, x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20201001203913.9125-1-chang.seok.bae@intel.com>
 <20201001203913.9125-23-chang.seok.bae@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5e9b73bf-5334-189e-753e-f1f766375024@infradead.org>
Date:   Thu, 1 Oct 2020 19:09:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201001203913.9125-23-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 10/1/20 1:39 PM, Chang S. Bae wrote:
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index a1068742a6df..742167c6f789 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5838,6 +5838,21 @@
>  			which allow the hypervisor to 'idle' the guest on lock
>  			contention.
>  
> +	xstate.enable=	[X86-64]
> +	xstate.disable=	[X86-64]
> +			The kernel is compiled with a default xstate bitmask --
> +			enabling it to use the XSAVE hardware to efficiently
> +			save and restore thread states on context switch.
> +			xstate.enable allows adding to that default mask at
> +			boot-time without recompiling the kernel just to support
> +			the new thread state. (Note that the kernel will ignore
> +			any bits in the mask that do not correspond to features
> +			that are actually available in CPUID)  xstate.disable

			                             in CPUID.)

> +			allows clearing bits in the default mask, forcing the
> +			kernel to forget that it supports the specified thread
> +			state. When a bit set for both, the kernel takes
> +			xstate.disable in a priority.

			               as a priority.


What do these bitmasks look like?  what do the bits mean?
Where does a user find this info?


thanks.
-- 
~Randy

