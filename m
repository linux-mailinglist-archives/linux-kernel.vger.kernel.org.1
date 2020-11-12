Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0EBF2B0409
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 12:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbgKLLjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 06:39:23 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:60909 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727234AbgKLLjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 06:39:16 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20201112113903euoutp01bcfbd0500f8a4906553730071b0c69fe~Gv77bboZz2277822778euoutp01G
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 11:39:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20201112113903euoutp01bcfbd0500f8a4906553730071b0c69fe~Gv77bboZz2277822778euoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1605181143;
        bh=KNn2oTOmhAiI70iC6w/bjPzCQzE+7NHDV4qdTqLZNms=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=VpnmGhjvWpsOk9lSTl1B84l9MKdPyjiHSf/F8bzaGdwhSGu0WW39owIZQU18WPrpo
         Q9vXJS2zRfQRC7OM+A9Mun+Bmvin7mljXvuaPsx7gsAokGGInGpYct7iYj6pfZx0Nx
         bOsGjmnlB+cHF3KyNt7V6TFSDCu6O8YU5fQontFs=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201112113851eucas1p1c1506386b2a79a4f2f38f29f7ed33d1d~Gv7wNx_SL0043700437eucas1p1O;
        Thu, 12 Nov 2020 11:38:51 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id B6.D4.27958.BCE1DAF5; Thu, 12
        Nov 2020 11:38:51 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20201112113851eucas1p296c130142450daf91d5903362db53daa~Gv7vuN5KZ0788907889eucas1p2n;
        Thu, 12 Nov 2020 11:38:51 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201112113851eusmtrp1eae424a7370ee355e7b2542ca8077c42~Gv7vtlLZb1044010440eusmtrp1r;
        Thu, 12 Nov 2020 11:38:51 +0000 (GMT)
X-AuditID: cbfec7f2-f15ff70000006d36-2e-5fad1ecbc3c1
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 4F.B5.16282.ACE1DAF5; Thu, 12
        Nov 2020 11:38:51 +0000 (GMT)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201112113850eusmtip2a3d8df1d6711f2e5939e822ee4c5e6d7~Gv7vNe7C62890328903eusmtip2A;
        Thu, 12 Nov 2020 11:38:50 +0000 (GMT)
Subject: Re: [PATCH] mm/highmem: Take kmap_high_get() properly into account
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     vtolkm@googlemail.com, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <94783ef1-7b1c-d657-d7ee-cd6a91504efc@samsung.com>
Date:   Thu, 12 Nov 2020 12:38:50 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <87y2j6n8mj.fsf@nanos.tec.linutronix.de>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRmVeSWpSXmKPExsWy7djP87qn5dbGG7xdLW8xZ/0aNotpFycx
        W1zeNYfN4t6a/6wWx3sPMFls3jSV2eLFPzkHdo+nEyaze2xeoeWx6dMkdo93586xe5yY8ZvF
        4/MmuQC2KC6blNSczLLUIn27BK6MHxuvMhYsEKr4dauNuYHxGF8XIyeHhICJxNeul+wgtpDA
        CkaJv5MDuxi5gOwvjBKX3hxngXA+M0r0fWtkgumYfuUCM0RiOaNE8+kVUM57Rokjq1ezgFQJ
        C3hLXDvRzwhiiwj4Szxr7gcbxSywDajo23KwIjYBQ4mut11sIDavgJ3E6d0/wFawCKhKLNxy
        kxXEFhVIktj69RFUjaDEyZlPgHo5ODgFTCW+b4oECTMLyEtsfzuHGcIWl7j1ZD4TyC4JgTsc
        Etca+pghznaROH/6NQuELSzx6vgWdghbRuL05B4WiIZmRomH59ayQzg9jBKXm2YwQlRZS9w5
        94sNZDOzgKbE+l36IKaEgKPErr8JECafxI23ghA38ElM2jadGSLMK9HRJgQxQ01i1vF1cFsP
        XrjEPIFRaRaSx2Yh+WYWkm9mIaxdwMiyilE8tbQ4Nz212DAvtVyvODG3uDQvXS85P3cTIzAR
        nf53/NMOxrmvPuodYmTiYDzEKMHBrCTCq+ywJl6INyWxsiq1KD++qDQntfgQozQHi5I476rZ
        QCmB9MSS1OzU1ILUIpgsEwenVAPT9JOBV/c85O6ufPhp3vZ/Fje7Jh45aafzvCz9W2HdEpnV
        Ada/36wtbvPL+14jYRNitLJKzeDBw3mFe+WXX8s0bzm/du5Bhpj5zGcWs7nNY3/GPyGq/kyg
        7OmZ7lsY4oUnnHA1E2sUdpz099WN54uT65UX5gW+VFdceS39Qecjns0L9lmf0thTsN66U3ya
        +vYbgrET7hcpbzLnWal/2F32ms69aeGeTeLSTJsfPgnQiZ/BEsasz89ztzs0ze7qRLO6B3am
        LX7v7I02F0flGTYssPH+ITDf1yjvoOV1s8gv6xat9jfPTNa97VxWyKs2z/7J+ZT2vs0uIimZ
        pZIS58/+3/5B8cTa63IbjQyO/XRWYinOSDTUYi4qTgQA00QvO7MDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRmVeSWpSXmKPExsVy+t/xe7qn5dbGG7wKsZizfg2bxbSLk5gt
        Lu+aw2Zxb81/VovjvQeYLDZvmsps8eKfnAO7x9MJk9k9Nq/Q8tj0aRK7x7tz59g9Tsz4zeLx
        eZNcAFuUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2C
        XsaPjVcZCxYIVfy61cbcwHiMr4uRk0NCwERi+pULzF2MXBxCAksZJfbtn8YEkZCRODmtgRXC
        Fpb4c62LDcQWEnjLKPFggSGILSzgLXHtRD8jiC0i4CvR1LuAFWQQs8A2RokXV39BNZhINP94
        CjaUTcBQoustxCBeATuJ07t/gMVZBFQlFm65CbZMVCBJ4mNLAxNEjaDEyZlPWLoYOTg4BUwl
        vm+KBAkzC5hJzNv8kBnClpfY/nYOlC0ucevJfKYJjEKzkHTPQtIyC0nLLCQtCxhZVjGKpJYW
        56bnFhvpFSfmFpfmpesl5+duYgTG3bZjP7fsYFz56qPeIUYmDsZDjBIczEoivMoOa+KFeFMS
        K6tSi/Lji0pzUosPMZoCvTORWUo0OR8Y+Xkl8YZmBqaGJmaWBqaWZsZK4rwmR4CaBNITS1Kz
        U1MLUotg+pg4OKUamOzjlC8KMdz0/x0xsfHXVq3A+sydDYr9rlfMuST/Z0uXnDntwB1w/op+
        T/ZHHrW6S0djlVg/1e5pnmAQ0rqJ6cGFZSrahy8WqPszX5s7o8za+KP0G4n+LXul7rZZdF3n
        7tm773DVwuRlkXU3fmRXTDu8LPprj970+TKLvI9Fchrsrl5iWh9SOzNEa53d8q+Hpb7mtd1n
        /yd+K1HygufxWwVNi8JfZ776tF3FseVPURPzn8rHMn3ZAjPdllyx9r92zXTpZ0OeC8fz1z07
        62dzO2je63da3K9uL3VVS9n8Y9a+nFLVuk7WsO+8Dpbi75ZcPFq+e0Vi0Kbu6LKVj5WOL3+6
        SPbduUamOLPOwpAz05VYijMSDbWYi4oTAV/Ndw1EAwAA
X-CMS-MailID: 20201112113851eucas1p296c130142450daf91d5903362db53daa
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201112113851eucas1p296c130142450daf91d5903362db53daa
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201112113851eucas1p296c130142450daf91d5903362db53daa
References: <87y2j6n8mj.fsf@nanos.tec.linutronix.de>
        <CGME20201112113851eucas1p296c130142450daf91d5903362db53daa@eucas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On 12.11.2020 11:59, Thomas Gleixner wrote:
> kunmap_local() warns when the virtual address to unmap is below
> PAGE_OFFSET. This is correct except for the case that the mapping was
> obtained via kmap_high_get() because the PKMAP addresses are right below
> PAGE_OFFSET.
>
> Cure it by skipping the WARN_ON() when the unmap was handled by
> kunmap_high().
>
> Fixes: 298fa1ad5571 ("highmem: Provide generic variant of kmap_atomic*")
> Reported-by: vtolkm@googlemail.com
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

This fixes the issue I've reported here: 
https://lore.kernel.org/dri-devel/c07bae0c-68dd-2693-948f-00e8a50f3053@samsung.com/ 
Thanks!

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
>   mm/highmem.c |   19 +++++++++++++------
>   1 file changed, 13 insertions(+), 6 deletions(-)
>
> --- a/mm/highmem.c
> +++ b/mm/highmem.c
> @@ -426,12 +426,15 @@ static inline void *arch_kmap_local_high
>   #endif
>   
>   /* Unmap a local mapping which was obtained by kmap_high_get() */
> -static inline void kmap_high_unmap_local(unsigned long vaddr)
> +static inline bool kmap_high_unmap_local(unsigned long vaddr)
>   {
>   #ifdef ARCH_NEEDS_KMAP_HIGH_GET
> -	if (vaddr >= PKMAP_ADDR(0) && vaddr < PKMAP_ADDR(LAST_PKMAP))
> +	if (vaddr >= PKMAP_ADDR(0) && vaddr < PKMAP_ADDR(LAST_PKMAP)) {
>   		kunmap_high(pte_page(pkmap_page_table[PKMAP_NR(vaddr)]));
> +		return true;
> +	}
>   #endif
> +	return false;
>   }
>   
>   static inline int kmap_local_calc_idx(int idx)
> @@ -491,10 +494,14 @@ void kunmap_local_indexed(void *vaddr)
>   
>   	if (addr < __fix_to_virt(FIX_KMAP_END) ||
>   	    addr > __fix_to_virt(FIX_KMAP_BEGIN)) {
> -		WARN_ON_ONCE(addr < PAGE_OFFSET);
> -
> -		/* Handle mappings which were obtained by kmap_high_get() */
> -		kmap_high_unmap_local(addr);
> +		/*
> +		 * Handle mappings which were obtained by kmap_high_get()
> +		 * first as the virtual address of such mappings is below
> +		 * PAGE_OFFSET. Warn for all other addresses which are in
> +		 * the user space part of the virtual address space.
> +		 */
> +		if (!kmap_high_unmap_local(addr))
> +			WARN_ON_ONCE(addr < PAGE_OFFSET);
>   		return;
>   	}
>   
>
>
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

