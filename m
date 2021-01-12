Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7845C2F3D3A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437947AbhALVek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 16:34:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437104AbhALVEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 16:04:07 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F18C061786
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 13:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=WsOgljZN11s48vyCDI4F4Mld1I0ggb1VBYdNIdrE2J0=; b=l3Ljf04thYjGmN+3zqr/EYdgUN
        GjCuacKqOIEjIwqrBsWV3dnEojmmuVfYBKikIZjZTgmDW+K5v+6WPEcohu46nFwzhCulbfPhdk5eH
        kE+CFG+HZv5luCPTzlVlznC20ioaa4njS8rLvh/+4qk9S3YHFI0arguODPC3KAwuW3u7SXbFuSKIo
        KSD4LcjbOQRfAUJM0ci7tDUztR2fCIrI4UxfcN9mecJl5WIARfaGYgIXI4wyV1kasKGmcYuTFi3JB
        423vL9vVpnvehuCgFZC3FzjxyYdp2siU9aB66q7lTFa6fixQ3xA28DqOoomOUJiFjZcFtfPQjYDtO
        Dtetf8yg==;
Received: from [2601:1c0:6280:3f0::79df]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kzQop-0001fP-Vt; Tue, 12 Jan 2021 21:03:12 +0000
Subject: Re: [PATCH v2 09/70] mm/mmap: Change find_vma_prev() to use maple
 tree
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
 <20210112161240.2024684-10-Liam.Howlett@Oracle.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <74b9865e-a807-cfa3-d099-ed1c5c1cea0c@infradead.org>
Date:   Tue, 12 Jan 2021 13:03:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210112161240.2024684-10-Liam.Howlett@Oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please see kernel-doc fixes below:


On 1/12/21 8:11 AM, Liam R. Howlett wrote:
> Change the implementation of find_vma_prev to use the new maple tree
> data structure.
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> ---
>  mm/mmap.c | 27 +++++++++++++++++----------
>  1 file changed, 17 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index ab1cb0efc4c65..f123f9c97dfe8 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2500,23 +2500,30 @@ struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
>  }
>  EXPORT_SYMBOL(find_vma);
>  
> -/*
> - * Same as find_vma, but also return a pointer to the previous VMA in *pprev.
> +/**
> + * find_vma_prev() - Find the VMA for a given address, or the next vma and
> + * sets %pprev to the previous VMA, if any.

    * set @pprev

> + * @mm The mm_struct to check

    * @mm: ...

> + * @addr: The address
> + * @pprev: The pointer to set to the previous VMA
> + *
> + * Returns: The VMA associated with @addr, or the next vma.
> + * May return NULL in the case of no vma at addr or above.

                 %NULL

>   */
>  struct vm_area_struct *
>  find_vma_prev(struct mm_struct *mm, unsigned long addr,


thanks.
-- 
~Randy
