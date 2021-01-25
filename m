Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 174693026CF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 16:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730018AbhAYPUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 10:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729844AbhAYO4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 09:56:50 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95461C061574
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 06:56:00 -0800 (PST)
Received: from zn.tnic (p200300ec2f09db0095810f165069682a.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:db00:9581:f16:5069:682a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1D88C1EC0572;
        Mon, 25 Jan 2021 15:55:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1611586559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Xbmme6GPysiAM30p3FHQ7t0SqIqLTadlifqkOIOeX7w=;
        b=XBDN0S9oHrd0cVkGGvg4dl7QfxlPampHCLYMp0YbMRGpN7h0eoPPcKB0EjnLeESghZo4JF
        pGgGYhLQiDzxB0l4tuX3Gb4lxhk016px6SbRptHLaJePGTfUdXvJd1xxlXUyi7nPOjHmjC
        PIB4AQbDuSHQ19k/8R6M9e0r88fjTT8=
Date:   Mon, 25 Jan 2021 15:55:58 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Baoquan He <bhe@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>, Qian Cai <cai@lca.pw>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH 2/2] x86/setup: merge several reservations of start of
 the memory
Message-ID: <20210125145558.GE23070@zn.tnic>
References: <20210115083255.12744-1-rppt@kernel.org>
 <20210115083255.12744-3-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210115083255.12744-3-rppt@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 10:32:55AM +0200, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Currently the first several pages are reserved both to avoid leaking their
> contents on systems with L1TF and to avoid corrupting BIOS memory.
> 
> Merge the two memory reservations.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/x86/kernel/setup.c | 29 +++++++++++------------------
>  1 file changed, 11 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 32cd2e790a0a..3f2fd67240f8 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -715,20 +715,6 @@ static int __init parse_reservelow(char *p)
>  
>  early_param("reservelow", parse_reservelow);
>  
> -static void __init trim_low_memory_range(void)
> -{
> -	/*
> -	 * A special case is the first 4Kb of memory;
> -	 * This is a BIOS owned area, not kernel ram, but generally
> -	 * not listed as such in the E820 table.
> -	 *
> -	 * This typically reserves additional memory (64KiB by default)
> -	 * since some BIOSes are known to corrupt low memory.  See the
> -	 * Kconfig help text for X86_RESERVE_LOW.
> -	 */
> -	memblock_reserve(0, ALIGN(reserve_low, PAGE_SIZE));
> -}
> -
>  static void __init early_reserve_memory(void)
>  {
>  	/*
> @@ -741,10 +727,18 @@ static void __init early_reserve_memory(void)
>  			 (unsigned long)__end_of_kernel_reserve - (unsigned long)_text);
>  
>  	/*
> -	 * Make sure page 0 is always reserved because on systems with
> -	 * L1TF its contents can be leaked to user processes.
> +	 * The first 4Kb of memory is a BIOS owned area, but generally it is
> +	 * not listed as such in the E820 table.
> +	 *
> +	 * Reserve the first memory page and typically some additional
> +	 * memory (64KiB by default) since some BIOSes are known to corrupt
> +	 * low memory. See the Kconfig help text for X86_RESERVE_LOW.
> +	 *
> +	 * In addition, we must make sure page 0 is always reserved because

s/we must//

Other than that:

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
