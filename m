Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 256192EA0FB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 00:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbhADXhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 18:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbhADXhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 18:37:32 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE202C06179E
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 15:36:50 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id q22so17314146pfk.12
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 15:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7vAfgGhGy3ZASCGh1dtgdS9kLlepR0AtWowcM6gy574=;
        b=r5VJryTB7PQuBJEhYTa/NxNNzPQB6QKUEmSYB6A1QxfENBP/UjehLl+7U6FdMkL5zp
         SO7VV6QNbkIINMAY9WYnL6ybC5HeWuZ0uJh1P8wN9aD4mKaCuex0CbZv1RYgrcnNib8z
         alxdqQsC7lvcUrDdVpp2oLrycKHubePozNkH21mNbfgQgp8xrkHm9TShu9EEZ9u82YOF
         UpHJ9LW0uTXPYi1At/5vcU2GdhESjAbpSm/RLcrLrGVGtJXEOOzjzqIFgfWLXRsMnEYl
         dzj4wWdAQCZ0TBnASGolT6u00eMtJNIRCDDzUir36eH2NB/9BO9HArUx8w4wbsDq9P8G
         6jXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7vAfgGhGy3ZASCGh1dtgdS9kLlepR0AtWowcM6gy574=;
        b=KjvUF+3e2kM1obYwLh0GVLqwT4IbgihABfVrSfa3924eR2QWj/ijeEFmZeM3kOIipx
         nhrQw88Un2n2uSzmVPMkh6E/lKZ64iZPe+1ZOhD76mTe5nBKJbHs2Uy3vBgeRa/sgZH7
         yQCZiOmqwUG6L7fA6bCXuROr0DCVX8EAaPUCiSY1f91aYxMSPbn5F9nuTgxlGlq+ujFz
         hj3pGOdSIBOaKTvwOahNbHxNwAixs6GS0vMj0J0tJ8Nv56oCO73i76+TYEo5gYW8XVYp
         8NJ/FnOwwTCgAbHOZOvbTHCk+BmWRtIgmVPP+4cH/b3y045FXAkyrWNbCqpwhwLbJNR2
         ZE6A==
X-Gm-Message-State: AOAM533AmS+R08pdbRCN8g6awyQeS4+QeBatUCOnwkPMSeFY/MYdVYw2
        MZvkhts+VO49ui+Hesh963NN2s3M8oVJLw==
X-Google-Smtp-Source: ABdhPJyIclj68K5QfxqicR04obaRI1e5dSn9+H+B81tPmNDCZLG0WiK1wFXmmWQkAeogXjp98+pZNA==
X-Received: by 2002:a0c:b64e:: with SMTP id q14mr53155701qvf.52.1609799796403;
        Mon, 04 Jan 2021 14:36:36 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id n66sm38105504qkn.136.2021.01.04.14.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 14:36:35 -0800 (PST)
Date:   Mon, 4 Jan 2021 15:36:34 -0700
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
Message-ID: <20210104223634.GB2562866@ubuntu-m3-large-x86>
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
> 

I am in agreement with Vlastimil, I would rather see the BUILD_BUG()
dropped or converted into BUG() instead of papering over with
__always_inline. For what it's worth, I only see this build failure
with CONFIG_UBSAN_UNSIGNED_OVERFLOW, which you proposed disabling:

https://lore.kernel.org/lkml/20201230154749.746641-1-arnd@kernel.org/

Cheers,
Nathan
