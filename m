Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3F772E9424
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 12:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbhADLfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 06:35:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:36340 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbhADLfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 06:35:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9BDC8ACAF;
        Mon,  4 Jan 2021 11:34:30 +0000 (UTC)
To:     Arnd Bergmann <arnd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Brian Geffon <bgeffon@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
References: <20201230154104.522605-1-arnd@kernel.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm/mremap: fix BUILD_BUG_ON() error in get_extent
Message-ID: <ac2a03bf-b3e0-a25a-d7bb-99fb55287387@suse.cz>
Date:   Mon, 4 Jan 2021 12:34:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201230154104.522605-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The subject should say BUILD_BUG()

On 12/30/20 4:40 PM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> clang cannt evaluate this function argument at compile time
> when the function is not inlined, which leads to a link
> time failure:
> 
> ld.lld: error: undefined symbol: __compiletime_assert_414
>>>> referenced by mremap.c
>>>>               mremap.o:(get_extent) in archive mm/built-in.a
> 
> Mark the function as __always_inline to avoid it.

Not sure if it's the ideal fix, maybe just convert it to BUG() instead?
Functions shouldn't really have BUILD_BUG depending on parameters and rely on
inlining to make it work...

> Fixes: 9ad9718bfa41 ("mm/mremap: calculate extent in one place")

I think it's rather this one that introduces the BUILD_BUG() ?
c49dd3401802 ("mm: speedup mremap on 1GB or larger regions")

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  mm/mremap.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/mremap.c b/mm/mremap.c
> index c5590afe7165..1cb464a07184 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -336,8 +336,9 @@ enum pgt_entry {
>   * valid. Else returns a smaller extent bounded by the end of the source and
>   * destination pgt_entry.
>   */
> -static unsigned long get_extent(enum pgt_entry entry, unsigned long old_addr,
> -			unsigned long old_end, unsigned long new_addr)
> +static __always_inline unsigned long get_extent(enum pgt_entry entry,
> +			unsigned long old_addr, unsigned long old_end,
> +			unsigned long new_addr)
>  {
>  	unsigned long next, extent, mask, size;
>  
> 

