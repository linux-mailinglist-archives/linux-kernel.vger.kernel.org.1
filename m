Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC07224E6B2
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Aug 2020 11:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgHVJd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Aug 2020 05:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgHVJd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 05:33:56 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281EEC061573
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 02:33:56 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ep8so1849429pjb.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 02:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=f/ITU1cZGgUDvEjiudQdz6h3EUGtSvKyI4oKFXx+y1Q=;
        b=LitK0/mT5IuCpiIWAiDicNbpvAZo3HRVAMjCw/Zg81L9CBwo5wKM6WuLnCROWjY3r+
         bq8RW5OH1I9VYCuee4rDUhopeZ6eCtb2p0bgUGzwetjT6BDLGTUrOstr50DSi0lwQBjx
         XN5lzkwDg3HUkBUoqXDiPsh8Zz1Nx5turQngthE/hYAEwtS1D97D4PR9tS1bDTVwRBxJ
         jR034lQ+xWHplkbLSiogS/n6BbuN1AU9vwfvPckFy/SKMipeAJKtJjqAseFqX9SmN9Hf
         XnzoXwS5GmzPzzFJ/NDK8AVj8M+twT3MxGx4fZKTA9MTh2d5h5TZX18oxjXku81RQinP
         OSgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=f/ITU1cZGgUDvEjiudQdz6h3EUGtSvKyI4oKFXx+y1Q=;
        b=hW7zr3oI3iZtb1oPX4+av7sZGM7rhJQi5KhaWrH01n/6zhltI4TOsrYcWse4R0Q/IW
         I+L5z+ar2U5W2VRFR6Ew6j21sF2ClRE+3ZbX7OMClbVrIOCj4lXrUmuo2vz5O5+wDiKV
         AMtjzJ5exBVudE2vrrccrGxfJ622xIGm+KK85e3UpKRZA3s0GhBg02h+SUF9V2hlDi5Y
         Gig0z5MpU+ayQwww+x0vlSs4sLD8TuWhMLN6rWqxoMA6vLNfnAvtzDKcmPn+9IIXBNq0
         Tsg23Ekmkv6qVDZAvdZrLZBmKrWuYgT4+RNJ/GpYLwlwfHmd+NhDLMmOUWk+CVQ7ucXg
         qLEQ==
X-Gm-Message-State: AOAM531Xq+o05s+w/5qftVBs7YraTYQumRitUbNhFAl58DWbwrrCNUTV
        hjUiAQU0MSMWs/E9js2crgK059hIqUlqLQ==
X-Google-Smtp-Source: ABdhPJxMKRhwhlb9BlNIpkSxQwo1cFEZ/Iv7GPsgOj46UaZ/jqy1JCz3gqzLtr4OHcexo9n/k3KMIQ==
X-Received: by 2002:a17:902:b193:: with SMTP id s19mr5579838plr.72.1598088834875;
        Sat, 22 Aug 2020 02:33:54 -0700 (PDT)
Received: from [192.168.10.94] (124-171-83-152.dyn.iinet.net.au. [124.171.83.152])
        by smtp.gmail.com with ESMTPSA id h5sm5501966pfk.0.2020.08.22.02.33.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2020 02:33:53 -0700 (PDT)
Subject: Re: [PATCH v1 01/10] powerpc/pseries/iommu: Replace hard-coded page
 shift
To:     Leonardo Bras <leobras.c@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Joel Stanley <joel@jms.id.au>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Brian King <brking@linux.vnet.ibm.com>,
        Murilo Fossa Vicentini <muvic@linux.ibm.com>,
        David Dai <zdai@linux.vnet.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20200817234033.442511-1-leobras.c@gmail.com>
 <20200817234033.442511-2-leobras.c@gmail.com>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
Autocrypt: addr=aik@ozlabs.ru; keydata=
 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
Message-ID: <6232948f-033d-8322-e656-544f12c5f784@ozlabs.ru>
Date:   Sat, 22 Aug 2020 19:33:47 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817234033.442511-2-leobras.c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/08/2020 09:40, Leonardo Bras wrote:
> Some functions assume IOMMU page size can only be 4K (pageshift == 12).
> Update them to accept any page size passed, so we can use 64K pages.
> 
> In the process, some defines like TCE_SHIFT were made obsolete, and then
> removed. TCE_RPN_MASK was updated to generate a mask according to
> the pageshift used.
> 
> Most places had a tbl struct, so using tbl->it_page_shift was simple.
> tce_free_pSeriesLP() was a special case, since callers not always have a
> tbl struct, so adding a tceshift parameter seems the right thing to do.
> 
> Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
> ---
>  arch/powerpc/include/asm/tce.h         | 10 ++----
>  arch/powerpc/platforms/pseries/iommu.c | 42 ++++++++++++++++----------
>  2 files changed, 28 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/tce.h b/arch/powerpc/include/asm/tce.h
> index db5fc2f2262d..971cba2d87cc 100644
> --- a/arch/powerpc/include/asm/tce.h
> +++ b/arch/powerpc/include/asm/tce.h
> @@ -19,15 +19,9 @@
>  #define TCE_VB			0
>  #define TCE_PCI			1
>  
> -/* TCE page size is 4096 bytes (1 << 12) */
> -
> -#define TCE_SHIFT	12
> -#define TCE_PAGE_SIZE	(1 << TCE_SHIFT)
> -
>  #define TCE_ENTRY_SIZE		8		/* each TCE is 64 bits */
> -
> -#define TCE_RPN_MASK		0xfffffffffful  /* 40-bit RPN (4K pages) */
> -#define TCE_RPN_SHIFT		12
> +#define TCE_RPN_BITS		52		/* Bits 0-51 represent RPN on TCE */


Ditch this one and use MAX_PHYSMEM_BITS instead? I am pretty sure this
is the actual limit.


> +#define TCE_RPN_MASK(ps)	((1ul << (TCE_RPN_BITS - (ps))) - 1)
>  #define TCE_VALID		0x800		/* TCE valid */
>  #define TCE_ALLIO		0x400		/* TCE valid for all lpars */
>  #define TCE_PCI_WRITE		0x2		/* write from PCI allowed */
> diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
> index e4198700ed1a..8fe23b7dff3a 100644
> --- a/arch/powerpc/platforms/pseries/iommu.c
> +++ b/arch/powerpc/platforms/pseries/iommu.c
> @@ -107,6 +107,9 @@ static int tce_build_pSeries(struct iommu_table *tbl, long index,
>  	u64 proto_tce;
>  	__be64 *tcep;
>  	u64 rpn;
> +	const unsigned long tceshift = tbl->it_page_shift;
> +	const unsigned long pagesize = IOMMU_PAGE_SIZE(tbl);
> +	const u64 rpn_mask = TCE_RPN_MASK(tceshift);

Using IOMMU_PAGE_SIZE macro for the page size and not using
IOMMU_PAGE_MASK for the mask - this incosistency makes my small brain
explode :) I understand the history but maaaaan... Oh well, ok.

Good, otherwise. Thanks,

>  
>  	proto_tce = TCE_PCI_READ; // Read allowed
>  
> @@ -117,10 +120,10 @@ static int tce_build_pSeries(struct iommu_table *tbl, long index,
>  
>  	while (npages--) {
>  		/* can't move this out since we might cross MEMBLOCK boundary */
> -		rpn = __pa(uaddr) >> TCE_SHIFT;
> -		*tcep = cpu_to_be64(proto_tce | (rpn & TCE_RPN_MASK) << TCE_RPN_SHIFT);
> +		rpn = __pa(uaddr) >> tceshift;
> +		*tcep = cpu_to_be64(proto_tce | (rpn & rpn_mask) << tceshift);
>  
> -		uaddr += TCE_PAGE_SIZE;
> +		uaddr += pagesize;
>  		tcep++;
>  	}
>  	return 0;
> @@ -146,7 +149,7 @@ static unsigned long tce_get_pseries(struct iommu_table *tbl, long index)
>  	return be64_to_cpu(*tcep);
>  }
>  
> -static void tce_free_pSeriesLP(unsigned long liobn, long, long);
> +static void tce_free_pSeriesLP(unsigned long liobn, long, long, long);
>  static void tce_freemulti_pSeriesLP(struct iommu_table*, long, long);
>  
>  static int tce_build_pSeriesLP(unsigned long liobn, long tcenum, long tceshift,
> @@ -159,6 +162,7 @@ static int tce_build_pSeriesLP(unsigned long liobn, long tcenum, long tceshift,
>  	u64 rpn;
>  	int ret = 0;
>  	long tcenum_start = tcenum, npages_start = npages;
> +	const u64 rpn_mask = TCE_RPN_MASK(tceshift);
>  
>  	rpn = __pa(uaddr) >> tceshift;
>  	proto_tce = TCE_PCI_READ;
> @@ -166,12 +170,12 @@ static int tce_build_pSeriesLP(unsigned long liobn, long tcenum, long tceshift,
>  		proto_tce |= TCE_PCI_WRITE;
>  
>  	while (npages--) {
> -		tce = proto_tce | (rpn & TCE_RPN_MASK) << tceshift;
> +		tce = proto_tce | (rpn & rpn_mask) << tceshift;
>  		rc = plpar_tce_put((u64)liobn, (u64)tcenum << tceshift, tce);
>  
>  		if (unlikely(rc == H_NOT_ENOUGH_RESOURCES)) {
>  			ret = (int)rc;
> -			tce_free_pSeriesLP(liobn, tcenum_start,
> +			tce_free_pSeriesLP(liobn, tcenum_start, tceshift,
>  			                   (npages_start - (npages + 1)));
>  			break;
>  		}
> @@ -205,10 +209,12 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
>  	long tcenum_start = tcenum, npages_start = npages;
>  	int ret = 0;
>  	unsigned long flags;
> +	const unsigned long tceshift = tbl->it_page_shift;
> +	const u64 rpn_mask = TCE_RPN_MASK(tceshift);
>  
>  	if ((npages == 1) || !firmware_has_feature(FW_FEATURE_PUT_TCE_IND)) {
>  		return tce_build_pSeriesLP(tbl->it_index, tcenum,
> -					   tbl->it_page_shift, npages, uaddr,
> +					   tceshift, npages, uaddr,
>  		                           direction, attrs);
>  	}
>  
> @@ -225,13 +231,13 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
>  		if (!tcep) {
>  			local_irq_restore(flags);
>  			return tce_build_pSeriesLP(tbl->it_index, tcenum,
> -					tbl->it_page_shift,
> +					tceshift,
>  					npages, uaddr, direction, attrs);
>  		}
>  		__this_cpu_write(tce_page, tcep);
>  	}
>  
> -	rpn = __pa(uaddr) >> TCE_SHIFT;
> +	rpn = __pa(uaddr) >> tceshift;
>  	proto_tce = TCE_PCI_READ;
>  	if (direction != DMA_TO_DEVICE)
>  		proto_tce |= TCE_PCI_WRITE;
> @@ -245,12 +251,12 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
>  		limit = min_t(long, npages, 4096/TCE_ENTRY_SIZE);
>  
>  		for (l = 0; l < limit; l++) {
> -			tcep[l] = cpu_to_be64(proto_tce | (rpn & TCE_RPN_MASK) << TCE_RPN_SHIFT);
> +			tcep[l] = cpu_to_be64(proto_tce | (rpn & rpn_mask) << tceshift);
>  			rpn++;
>  		}
>  
>  		rc = plpar_tce_put_indirect((u64)tbl->it_index,
> -					    (u64)tcenum << 12,
> +					    (u64)tcenum << tceshift,
>  					    (u64)__pa(tcep),
>  					    limit);
>  
> @@ -277,12 +283,13 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
>  	return ret;
>  }
>  
> -static void tce_free_pSeriesLP(unsigned long liobn, long tcenum, long npages)
> +static void tce_free_pSeriesLP(unsigned long liobn, long tcenum, long tceshift,
> +			       long npages)
>  {
>  	u64 rc;
>  
>  	while (npages--) {
> -		rc = plpar_tce_put((u64)liobn, (u64)tcenum << 12, 0);
> +		rc = plpar_tce_put((u64)liobn, (u64)tcenum << tceshift, 0);
>  
>  		if (rc && printk_ratelimit()) {
>  			printk("tce_free_pSeriesLP: plpar_tce_put failed. rc=%lld\n", rc);
> @@ -301,9 +308,11 @@ static void tce_freemulti_pSeriesLP(struct iommu_table *tbl, long tcenum, long n
>  	u64 rc;
>  
>  	if (!firmware_has_feature(FW_FEATURE_STUFF_TCE))
> -		return tce_free_pSeriesLP(tbl->it_index, tcenum, npages);
> +		return tce_free_pSeriesLP(tbl->it_index, tcenum,
> +					  tbl->it_page_shift, npages);
>  
> -	rc = plpar_tce_stuff((u64)tbl->it_index, (u64)tcenum << 12, 0, npages);
> +	rc = plpar_tce_stuff((u64)tbl->it_index,
> +			     (u64)tcenum << tbl->it_page_shift, 0, npages);
>  
>  	if (rc && printk_ratelimit()) {
>  		printk("tce_freemulti_pSeriesLP: plpar_tce_stuff failed\n");
> @@ -319,7 +328,8 @@ static unsigned long tce_get_pSeriesLP(struct iommu_table *tbl, long tcenum)
>  	u64 rc;
>  	unsigned long tce_ret;
>  
> -	rc = plpar_tce_get((u64)tbl->it_index, (u64)tcenum << 12, &tce_ret);
> +	rc = plpar_tce_get((u64)tbl->it_index,
> +			   (u64)tcenum << tbl->it_page_shift, &tce_ret);
>  
>  	if (rc && printk_ratelimit()) {
>  		printk("tce_get_pSeriesLP: plpar_tce_get failed. rc=%lld\n", rc);
> 

-- 
Alexey
