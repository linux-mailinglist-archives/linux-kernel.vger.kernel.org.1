Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F29282A8C09
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 02:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732415AbgKFBXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 20:23:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730246AbgKFBXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 20:23:42 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA87C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 17:23:42 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id i21so3160622qka.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 17:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=taXWeBFo+wT7XX0MW36Hk3wvn7TPVywWpoJuQSvy99I=;
        b=nDwz7EkgrT3jew23FyqHF9A+4h1Cn341I1GrF5LCXFR0vf1G5izXMHK0l++cTzt6nO
         t47HnSI6Fyw3xCy58cFKWO3NHPmUXZZUmi2gBRQ99obAIuvC3zxiFZnKH+KKgqudETPY
         FkCZRQOzPfRg1BNHeTBHEYklE1eZoZcNWAwcIPkH7kNeCJJ46F/EGMtKpofppW08k2Bh
         uPo7Fs2fDYa3Vtd6rTtytIMm1mleWns7TJyjlpOdOuRioV8/LRWsYoobGGuQTqV5vNGf
         a+EC+2LOwDneYIXeSnizRv8qHmW0Vrw1Rsb51uLvwb5ISHBe5sbH4JpXcGs4MjO7SUZS
         Ce0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=taXWeBFo+wT7XX0MW36Hk3wvn7TPVywWpoJuQSvy99I=;
        b=HKtGDILtdPfjcYY+qXsTMqPT39/Dmz3vLzAMadzJS369zVlNejIMZDrZ5Y7rM7a5HV
         f2kWLssyZRB53smaIM5PLT/nYydqI68iD4eiL9I8z5gTMFKbVl7Y03A5zCYwr/S5LLHU
         zgLR3IZa11d7MNthU+LGp7pAnYeIY4IGfmEVnUghY6YXpXJ50JPVlhEM9KE0NQMy1Wj4
         i1aHWVLkJor47LjWst7ggZLwJvDmgw3ingym89enB7+8JKNNuSs8deqIDH0BkUWq9+Jc
         mHZ8fuNkygum6QvnUAS3FAfptuNpj5cNkIY/sYBOObljkop5X7KO80H6POx9GAnL7+Zh
         1SrQ==
X-Gm-Message-State: AOAM530nOuMmfn1hABLNyI206bRVaLjQzpRU9LttQU0EQqzbblsuVy40
        S2CzfZTqlZ5SxxqJsPtwsv0=
X-Google-Smtp-Source: ABdhPJwAW8FhnDE4V3RWPkL4nQ+6OuSliTaHElW4eouWDejC1kSGEwRKd+hccEishZCOvjJetvDf4A==
X-Received: by 2002:a37:a308:: with SMTP id m8mr5050191qke.126.1604625821246;
        Thu, 05 Nov 2020 17:23:41 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id 64sm2051768qtc.92.2020.11.05.17.23.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Nov 2020 17:23:40 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 1E1D327C0054;
        Thu,  5 Nov 2020 20:23:39 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 05 Nov 2020 20:23:39 -0500
X-ME-Sender: <xms:mqWkX5V4B4vtXh9DligBtEkbjfYxntdfcTdJVA3QjlEjqvmtQBOCAQ>
    <xme:mqWkX5lR1o-RVGZaUd4V9Nva0bbD_3Q-qEvFjqiYmEgfkTiZal9ohUwNhYpIHhOlu
    F8EkJ2HH-nLemOUAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtkedgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehg
    mhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedvleeigedugfegveejhfejveeuve
    eiteejieekvdfgjeefudehfefhgfegvdegjeenucfkphepudeijedrvddvtddrvddruddv
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvg
X-ME-Proxy: <xmx:mqWkX1aM_KmQrfn0F8bGHHmJqfY2h-GdnLYP5PdNfitJfIVZv74x3A>
    <xmx:mqWkX8VwyH6qN_nPzBJ2-AsjH1Oh-IjwK77bLgVA8X10kdgVuPmTZw>
    <xmx:mqWkXznGiBiJowNaxzmrAWvgP3B9_uykjyjpZFa80biycbL6IqUKuA>
    <xmx:m6WkX1423zDQd6I3QB1QO_tEkZGBWNvb5bsXVxM4Ub7KSA8MlbXcdyA1xhU>
Received: from localhost (unknown [167.220.2.126])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2426F32801F2;
        Thu,  5 Nov 2020 20:23:38 -0500 (EST)
Date:   Fri, 6 Nov 2020 09:23:35 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org, elver@google.com,
        andreyknvl@google.com, glider@google.com, dvyukov@google.com,
        cai@lca.pw
Subject: Re: [PATCH kcsan 3/3] kcsan: Fix encoding masks and regain address
 bit
Message-ID: <20201106012335.GA3025@boqun-archlinux>
References: <20201105220302.GA15733@paulmck-ThinkPad-P72>
 <20201105220324.15808-3-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105220324.15808-3-paulmck@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

On Thu, Nov 05, 2020 at 02:03:24PM -0800, paulmck@kernel.org wrote:
> From: Marco Elver <elver@google.com>
> 
> The watchpoint encoding masks for size and address were off-by-one bit
> each, with the size mask using 1 unnecessary bit and the address mask
> missing 1 bit. However, due to the way the size is shifted into the
> encoded watchpoint, we were effectively wasting and never using the
> extra bit.
> 
> For example, on x86 with PAGE_SIZE==4K, we have 1 bit for the is-write
> bit, 14 bits for the size bits, and then 49 bits left for the address.
> Prior to this fix we would end up with this usage:
> 
> 	[ write<1> | size<14> | wasted<1> | address<48> ]
> 
> Fix it by subtracting 1 bit from the GENMASK() end and start ranges of
> size and address respectively. The added static_assert()s verify that
> the masks are as expected. With the fixed version, we get the expected
> usage:
> 
> 	[ write<1> | size<14> |             address<49> ]
> 
> Functionally no change is expected, since that extra address bit is
> insignificant for enabled architectures.
> 
> Signed-off-by: Marco Elver <elver@google.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  kernel/kcsan/encoding.h | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/kcsan/encoding.h b/kernel/kcsan/encoding.h
> index 4f73db6..b50bda9 100644
> --- a/kernel/kcsan/encoding.h
> +++ b/kernel/kcsan/encoding.h
> @@ -37,14 +37,12 @@
>   */
>  #define WATCHPOINT_ADDR_BITS (BITS_PER_LONG-1 - WATCHPOINT_SIZE_BITS)
>  
> -/*
> - * Masks to set/retrieve the encoded data.
> - */
> -#define WATCHPOINT_WRITE_MASK BIT(BITS_PER_LONG-1)
> -#define WATCHPOINT_SIZE_MASK                                                   \
> -	GENMASK(BITS_PER_LONG-2, BITS_PER_LONG-2 - WATCHPOINT_SIZE_BITS)
> -#define WATCHPOINT_ADDR_MASK                                                   \
> -	GENMASK(BITS_PER_LONG-3 - WATCHPOINT_SIZE_BITS, 0)
> +/* Bitmasks for the encoded watchpoint access information. */
> +#define WATCHPOINT_WRITE_MASK	BIT(BITS_PER_LONG-1)
> +#define WATCHPOINT_SIZE_MASK	GENMASK(BITS_PER_LONG-2, BITS_PER_LONG-1 - WATCHPOINT_SIZE_BITS)
> +#define WATCHPOINT_ADDR_MASK	GENMASK(BITS_PER_LONG-2 - WATCHPOINT_SIZE_BITS, 0)
> +static_assert(WATCHPOINT_ADDR_MASK == (1UL << WATCHPOINT_ADDR_BITS) - 1);

Nit:

Since you use the static_assert(), why not define WATCHPOINT_ADDR_MASK
as:

#define WATCHPOINT_ADDR_MASK (BIT(WATCHPOINT_SIZE_BITS) - 1)

Besides, WATCHPOINT_SIZE_MASK can also be defined as:

#define WATCHPOINT_SIZE_MASK GENMASK(BITS_PER_LONG - 2, WATCHPOINT_SIZE_BITS)

Regards,
Boqun

> +static_assert((WATCHPOINT_WRITE_MASK ^ WATCHPOINT_SIZE_MASK ^ WATCHPOINT_ADDR_MASK) == ~0UL);
>  
>  static inline bool check_encodable(unsigned long addr, size_t size)
>  {
> -- 
> 2.9.5
> 
