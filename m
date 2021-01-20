Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93AFC2FD795
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 18:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390091AbhATR4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 12:56:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729138AbhATRwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 12:52:39 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8EEC061575
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 09:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=+PVp3ta0WjC0TXJF4d2xbzQfNDYRHuF/qzM1UrQhb/w=; b=FjAfLsSy+2CNVXeEZwe03ra1jt
        B6QHrL6tVmursLRUvc76d9gLKVlK2YgI+kpun4cBfpiMG9k/Gon0ZV47qeqHCGLjhbEN+wDQT7GT9
        YPyVqPHgQhChPn/VfXGEYZFArkb847ZTjY0UikX5H93R1uGnChmgCixSfXDoWRx4XTwODA9KwW8+d
        m9/tdlyth1m5q9e/6qk+MUCyujVVyRO1HY5/cJ/yclrdD117cyWCkdO8LrNSTONI1kcOtpf1x0h0z
        p2ocncmN4nviDKPr9gVriFMeUmY9MaNtTRhUQxAQ5V3abodSuDDzoBrOm/qvsOK+2dH+KTRG/1MpT
        kmYC1tDQ==;
Received: from [2601:1c0:6280:3f0::9abc]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l2He8-0001SU-En; Wed, 20 Jan 2021 17:51:56 +0000
Subject: Re: [PATCH] arch: powerpc: mm: book3s64: Fixed spelling architectue
 -> architecture in line number 1061
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org,
        akpm@linux-foundation.org, rppt@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20210120142020.2623355-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <540548b6-a7b3-9a5b-67ee-17d18395ddb6@infradead.org>
Date:   Wed, 20 Jan 2021 09:51:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210120142020.2623355-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/21 6:20 AM, Bhaskar Chowdhury wrote:
> s/architectue/architecture/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

Line number in $Subject is just too much.

> ---
>  arch/powerpc/mm/book3s64/radix_pgtable.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
> index 98f0b243c1ab..8b8f1451e944 100644
> --- a/arch/powerpc/mm/book3s64/radix_pgtable.c
> +++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
> @@ -1058,7 +1058,7 @@ void radix__ptep_set_access_flags(struct vm_area_struct *vma, pte_t *ptep,
>  		 * Book3S does not require a TLB flush when relaxing access
>  		 * restrictions when the address space is not attached to a
>  		 * NMMU, because the core MMU will reload the pte after taking
> -		 * an access fault, which is defined by the architectue.
> +		 * an access fault, which is defined by the architecture.
>  		 */
>  	}
>  	/* See ptesync comment in radix__set_pte_at */
> --
> 2.30.0
> 


-- 
~Randy
"He closes his eyes and drops the goggles.  You can't get hurt
by looking at a bitmap.  Or can you?"
(Neal Stephenson: Snow Crash)
