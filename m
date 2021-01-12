Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B906D2F3D34
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437911AbhALVej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 16:34:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437100AbhALVCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 16:02:17 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1ACC061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 13:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=uIIB/9cfeqlWr6Lp0d8MywbmP5I2scIpmOMhS14mfRc=; b=xcoDKMZVEJVI7SUFyi62vnfvj/
        y/b1lKn+mWml4KUwIa4X1tFp/Hpivd9ChUzwYmsGZaHRurcT/KeKX+4Pou6rCUOczBA0d1AxFtkL6
        kn6eRxX8KZSEIHG4doeSHNVDru1gFjDF+O31pCCsNQXCzl6bqnsBUDDSaLdd/5FcwAqu3VjjlFVEF
        o+5wsR3pvBpXdxOAFGMuyq33qcqdig6vQcQzImdm/Z7e5G1j8VYCW50bnXyVl4OsNI9qKXzOKuuar
        MbzpMbFTym0L2yf9PhW+Ld3sSPn9smWQX5Ty8/nPtavx0MHsjVR8NF4Hb3pmLVvRDbU8AJTEhyIwR
        xbWs31LA==;
Received: from [2601:1c0:6280:3f0::79df]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kzQmv-0000zn-3T; Tue, 12 Jan 2021 21:01:13 +0000
Subject: Re: [PATCH v2 08/70] mm/mmap: Change find_vma() to use the maple tree
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@google.com>, Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jerome Glisse <jglisse@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <20210112161240.2024684-1-Liam.Howlett@Oracle.com>
 <20210112161240.2024684-9-Liam.Howlett@Oracle.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <cf85f917-4f91-8757-8f4f-e8ac5e57a793@infradead.org>
Date:   Tue, 12 Jan 2021 13:01:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210112161240.2024684-9-Liam.Howlett@Oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Please adjust the kernel-doc to be correct :)

On 1/12/21 8:11 AM, Liam R. Howlett wrote:
> Start using the maple tree to find VMA entries in an mm_struct.
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> ---
>  mm/mmap.c | 29 +++++++++++------------------
>  1 file changed, 11 insertions(+), 18 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 65789b188c380..ab1cb0efc4c65 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2474,10 +2474,17 @@ get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
>  
>  EXPORT_SYMBOL(get_unmapped_area);
>  
> -/* Look up the first VMA which satisfies  addr < vm_end,  NULL if none. */
> +/**
> + * find_vma() - Find the VMA for a given address, or the next vma.  May return
> + * NULL in the case of no vma at addr or above

      %NULL

> + * @mm The mm_struct to check

    * @mm: ...

> + * @addr: The address
> + *
> + * Returns: The VMA assoicated with addr, or the next vma.

                       associated

> + * May return NULL in the case of no vma at addr or above.

                 %NULL

> + */
>  struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
>  {


thanks.
-- 
~Randy

