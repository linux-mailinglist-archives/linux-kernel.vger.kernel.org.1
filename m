Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B781729859F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 03:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1421515AbgJZCqP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 25 Oct 2020 22:46:15 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:2296 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1421508AbgJZCqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 22:46:15 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4CKK394fr7z13MFq;
        Mon, 26 Oct 2020 10:46:13 +0800 (CST)
Received: from dggeme753-chm.china.huawei.com (10.3.19.99) by
 dggeme703-chm.china.huawei.com (10.1.199.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Mon, 26 Oct 2020 10:46:08 +0800
Received: from dggeme753-chm.china.huawei.com ([10.7.64.70]) by
 dggeme753-chm.china.huawei.com ([10.7.64.70]) with mapi id 15.01.1913.007;
 Mon, 26 Oct 2020 10:46:09 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH] mm/swap_state: Skip meaningless swap cache readahead when
 ra_info.win == 0
Thread-Topic: [PATCH] mm/swap_state: Skip meaningless swap cache readahead
 when ra_info.win == 0
Thread-Index: AdarQQ+CRNxJgvSYT9upQi1RP9VE2Q==
Date:   Mon, 26 Oct 2020 02:46:09 +0000
Message-ID: <2cf3c4afef654fbcb625cb77ea294fe6@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.177.91]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@linux-foundation.org> wrote:
> On Fri, 9 Oct 2020 09:30:59 -0400 Miaohe Lin <linmiaohe@huawei.com> wrote:
>
>> swap_ra_info() may leave ra_info untouched in non_swap_entry() case as 
>> page table lock is not held. In this case, we have ra_info.nr_pte == 0 
>> and it is meaningless to continue with swap cache readahead. Skip such 
>> ops by init ra_info.win = 1.
>> 
>
>Looks right.  But I think it would be better to fix this in
>swap_ra_info() - make it more consistent in its return state.
>

I think modernify the struct initializer is better because it means we have to swap in one page at least.
Many thanks.

>Otherwise, let's modernify that struct initializer:
>
>--- a/mm/swap_state.c~mm-swap_state-skip-meaningless-swap-cache-readahead-when-ra_infowin-==-0-fix
>+++ a/mm/swap_state.c
>@@ -839,7 +839,9 @@ static struct page *swap_vma_readahead(s
> 	swp_entry_t entry;
> 	unsigned int i;
> 	bool page_allocated;
>-	struct vma_swap_readahead ra_info = {1,};
>+	struct vma_swap_readahead ra_info = {
>+		.win = 1,
>+	};
> 
> 	swap_ra_info(vmf, &ra_info);
> 	if (ra_info.win == 1)
>_
>
