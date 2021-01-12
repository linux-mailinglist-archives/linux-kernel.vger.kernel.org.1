Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C537C2F39DA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 20:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406712AbhALTRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 14:17:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727474AbhALTRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 14:17:17 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50866C061786
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 11:16:37 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id 19so2903865qkm.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 11:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o1zIRVvlIdRblMLiKBkvOC2xTqqgWEYJWublDCntGKI=;
        b=Da7TPxsZbAydOXbhtG7CUOIg2Nm2ArteVZzps33I+QYA88IXOvrAcZmBfOvgKZHrW2
         5xKm4Fv17nGR2q7lW9z4dwal24qzwZvB0fa+wGXd9xUmAwIloOeTyaOiarW8n4P0VQNh
         XQ6nUtz2ZM+af8kIE4paLbqqDdM1UoHefYEcRJjyhw4JQ/M0h5SiddnSe7a+By8xuP2o
         /03u6z1c91MeNGL1yCzIA/UHTVEJBuH+GTh2XntKVLpnCWoTXMXeQE9Oc65ORn4h3otx
         9F+46jMS3FGHED3ZQEuqbG9jDWrOW9imstwH46H9sxdyewZZIeWLuiENVHhglc5mKMxN
         fcPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o1zIRVvlIdRblMLiKBkvOC2xTqqgWEYJWublDCntGKI=;
        b=EdN9ml2H2D+BDkMfjlAT5mltd1cs+1wL3RTjqldT7Lj11PAGwevROougCN1sV7w9cm
         eSh+E8dbjMTFj9PBNygWLwIvqpHVBZMtGk35ZTXe7rP0O+IiY9Ol1dp/778vKf+wCZP4
         ihtk8wDCIp5n9CjssFRDeOGoD0tgjzsvJ7eUkIRGJEbIcj5SYp3S/wuZerXtw7Qp76gz
         45CQ9kzYIHNmdBovBIsbWSHVgT4NYthgorrti7qyrZiZsnO0X8aGmU/SpE8M1bV/IImW
         gsAxmkmGiCSxlM//Aqfl/E6IR0WBWPiWHl6Lwx0jATfIl9bCEGB2es92aTBj3mCYYjPp
         BU0w==
X-Gm-Message-State: AOAM531BMiFbUM2ZEBwabkWNUVZAsFJ63JVJWIGzLa0SXr+2QYYUlJ/0
        +wQE+12I0xmsMBfxVlfGjoG4kGMc3TOWkA==
X-Google-Smtp-Source: ABdhPJwyAQWnSzB8tbSH8RaXOA8oPrFxD5dGzBKdUZCbIdUEIKw9APEZGHvyrjE5nrYO8+Sqsdh9Og==
X-Received: by 2002:a05:620a:983:: with SMTP id x3mr885878qkx.231.1610478996551;
        Tue, 12 Jan 2021 11:16:36 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id h26sm1694864qtc.81.2021.01.12.11.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 11:16:35 -0800 (PST)
Date:   Tue, 12 Jan 2021 12:16:34 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Brian Geffon <bgeffon@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] mm/mremap: fix BUILD_BUG_ON() error in get_extent
Message-ID: <20210112191634.GA1587546@ubuntu-m3-large-x86>
References: <20201230154104.522605-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201230154104.522605-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 30, 2020 at 04:40:40PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> clang cannt evaluate this function argument at compile time
> when the function is not inlined, which leads to a link
> time failure:
> 
> ld.lld: error: undefined symbol: __compiletime_assert_414
> >>> referenced by mremap.c
> >>>               mremap.o:(get_extent) in archive mm/built-in.a
> 
> Mark the function as __always_inline to avoid it.
> 
> Fixes: 9ad9718bfa41 ("mm/mremap: calculate extent in one place")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I would like to see some movement on getting this fixed in 5.11. As it
stands, this is one of three __compiletime_assert references with
CONFIG_UBSAN_UNSIGNED_OVERFLOW. If we want to keep the BUILD_BUG()
around, I think this is fine. Alternatively, turning it into a runtime
check would be fine too.

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

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
> -- 
> 2.29.2
 
