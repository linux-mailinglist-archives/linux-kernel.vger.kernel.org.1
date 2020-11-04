Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5A3E2A60CB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 10:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbgKDJnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 04:43:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:36838 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbgKDJnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 04:43:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 268ECAF16;
        Wed,  4 Nov 2020 09:42:58 +0000 (UTC)
Date:   Wed, 4 Nov 2020 10:42:55 +0100
From:   osalvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Rashmica Gupta <rashmica.g@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: Re: [PATCH v1 2/4] powerpc/mm: print warning in
 arch_remove_linear_mapping()
Message-ID: <20201104094255.GA4981@localhost.localdomain>
References: <20201029162718.29910-1-david@redhat.com>
 <20201029162718.29910-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029162718.29910-3-david@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 05:27:16PM +0100, David Hildenbrand wrote:
> Let's print a warning similar to in arch_add_linear_mapping() instead of
> WARN_ON_ONCE() and eventually crashing the kernel.
> 
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Rashmica Gupta <rashmica.g@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/powerpc/mm/mem.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index 8a86d81f8df0..685028451dd2 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -145,7 +145,9 @@ void __ref arch_remove_linear_mapping(u64 start, u64 size)
>  	flush_dcache_range_chunked(start, start + size, FLUSH_CHUNK_SIZE);
>  
>  	ret = remove_section_mapping(start, start + size);
> -	WARN_ON_ONCE(ret);
> +	if (ret)
> +		pr_warn("Unable to remove linear mapping for 0x%llx..0x%llx: %d\n",
> +			start, start + size, ret);

I guess the fear is to panic on systems that do have panic_on_warn (not
sure how many productions systems have this out there).
But anyway, being coherent with that, I think you should remove the WARN_ON
in hash__remove_section_mapping as well.

Besides that:

Reviewed-by: Oscar Salvador <osalvador@suse.

Not sure if the functions below that also have any sort of WARN_ON.
native_hpte_removebolted has a VM_WARN_ON, but that is on
CONFIG_DEBUG_VM so does not really matter.


-- 
Oscar Salvador
SUSE L3
