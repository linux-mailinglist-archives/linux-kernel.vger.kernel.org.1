Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C972F2A93FC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 11:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgKFKTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 05:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbgKFKTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 05:19:38 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA54C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 02:19:37 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id n12so931658ioc.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 02:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5QBJe5lX3IDD/Nb41CDBzkfjHyizFuCqEuWd5FfCo5w=;
        b=iEoLJtq7cjw5AUAmZWBPG2C1HwozPkret83awGEWM+zOt9HWYKNV9i+Q/bdl9RnmHC
         vu1GtiihpxGsh3XCS97k9PQb8wFx05tk7b5PIJJnLbPoF1OXfJE34vVnQQII+0QI+t/s
         QMvPEl2ZJeiLErc9y+HDMUwZxc02WQ/5jinIcw+ZaH1vk2goAQXKV6gEWEvHeSquwGBl
         PcEMQ1zVJCRFnvIQlu07tJ5Ui+uULjtzj37mS26QnOZlD8nUe0jImjNLbLBXcgTGPFy9
         YwPFZ7bk2uqBlLzwDWbaznd4UDzh46EroOLDoIe5aMGRBfLfPa2CsegDDo/hOs/WnbOJ
         Migw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5QBJe5lX3IDD/Nb41CDBzkfjHyizFuCqEuWd5FfCo5w=;
        b=q/QLqym+FfSS/r6/34TJRC1MAIdPYGNwSJRKtxxylH/04egISSL5kDTqGXZilu50hC
         TU/l6TK5XY1ZKRdsxm0WAM72pFImQ1F5A8x6y2m1D2t+Zg7WK35g1dFJ2IkBwH8k4k3A
         PHO/a14gLRcwN7X15v3ASWWAcVEO5fIBSfxS5lCXWcpfcKQ17J1Xm2A8xBekUc3zViQT
         9SIKT/Fw4qFMzcOTOsSIfayZlqmuDCV5XnmoCdMOlJnyDcJmeyIRsHwNI0L31j7hNvP2
         0oSoWVt0nrXXHcHWk2mAH7/BEZHCbFbDLsCkKTC1pErMVSzc7HsDF+snL/MH9RJEOixm
         wXZQ==
X-Gm-Message-State: AOAM533FrhDZWssz8UYZySH+1AMZWCx6pzMMFy7bZjoC+h+9ABixjHHj
        56a2J9UZTKyneYS9ooatGlU=
X-Google-Smtp-Source: ABdhPJx4S8XxHlfO5o4Tvuvj0g1jriBVmltlNWYKqkO5TEBCOSZA1m2N5fqLXYAC8e/gGl8sCWVYdw==
X-Received: by 2002:a02:1349:: with SMTP id 70mr1020628jaz.130.1604657977371;
        Fri, 06 Nov 2020 02:19:37 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id w81sm803656ilk.38.2020.11.06.02.19.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Nov 2020 02:19:36 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 1E4FB27C005A;
        Fri,  6 Nov 2020 05:19:36 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 06 Nov 2020 05:19:36 -0500
X-ME-Sender: <xms:NyOlX7Umc1o6UCfXT_ssS6LWvP_3n4J6kOtBdkUTB0p0U8myLHhr2w>
    <xme:NyOlXzk1oOT9AgYiB84OiHvP9uDAXRMgqVEZj0Kl9znHn-yuoUY14lMyANJ56aN8t
    u-__ayDUB2CRdxElQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtledgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepvdelieegudfggeevjefhjeevueevieetjeeikedvgfejfeduheefhffggedv
    geejnecukfhppedufedurddutdejrddugeejrdduvdeinecuvehluhhsthgvrhfuihiivg
    epudenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:NyOlX3Y39L0-z03RJ36vWGjP6javzKfLo1ODkF79Cnd1VOiQeYPLDQ>
    <xmx:NyOlX2UNewSQf5MhknixbPxsAG2g89T1E5gFAArRQNkPAOkRMPrTkA>
    <xmx:NyOlX1k2zaEjEg0R7Z594kJAxbK4dZ5I5C_xCQwPtIMlb4mcR-YR9g>
    <xmx:OCOlX37pl7wl2w1WOffu2hqHae-UNpJCC9B1TyJLdH75YV11mAQYIgCQFg8>
Received: from localhost (unknown [131.107.147.126])
        by mail.messagingengine.com (Postfix) with ESMTPA id AC58C306005F;
        Fri,  6 Nov 2020 05:19:35 -0500 (EST)
Date:   Fri, 6 Nov 2020 18:19:32 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Marco Elver <elver@google.com>
Cc:     paulmck@kernel.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, kernel-team@fb.com, mingo@kernel.org,
        andreyknvl@google.com, glider@google.com, dvyukov@google.com,
        cai@lca.pw
Subject: Re: [PATCH v2] kcsan: Fix encoding masks and regain address bit
Message-ID: <20201106101932.GD3025@boqun-archlinux>
References: <20201105220302.GA15733@paulmck-ThinkPad-P72>
 <20201105220324.15808-3-paulmck@kernel.org>
 <20201106093456.GB2851373@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106093456.GB2851373@elver.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 10:34:56AM +0100, Marco Elver wrote:
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

Acked-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> ---
> v2:
> * Use WATCHPOINT_ADDR_BITS to avoid duplicating "BITS_PER_LONG-1 -
>   WATCHPOINT_SIZE_BITS" per Boqun's suggestion.
> ---
>  kernel/kcsan/encoding.h | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/kcsan/encoding.h b/kernel/kcsan/encoding.h
> index 4f73db6d1407..7ee405524904 100644
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
> +#define WATCHPOINT_SIZE_MASK	GENMASK(BITS_PER_LONG-2, WATCHPOINT_ADDR_BITS)
> +#define WATCHPOINT_ADDR_MASK	GENMASK(WATCHPOINT_ADDR_BITS-1, 0)
> +static_assert(WATCHPOINT_ADDR_MASK == (1UL << WATCHPOINT_ADDR_BITS) - 1);
> +static_assert((WATCHPOINT_WRITE_MASK ^ WATCHPOINT_SIZE_MASK ^ WATCHPOINT_ADDR_MASK) == ~0UL);
>  
>  static inline bool check_encodable(unsigned long addr, size_t size)
>  {
> -- 
> 2.29.2.222.g5d2a92d10f8-goog
> 
