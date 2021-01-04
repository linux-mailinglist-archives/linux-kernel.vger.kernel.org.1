Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF2A72EA0F0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 00:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbhADXfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 18:35:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727728AbhADXfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 18:35:32 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FD9C061574
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 15:34:52 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id w79so25095898qkb.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 15:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=X97uCJbbPtgQJjHkz/WOFp2vCTZb6uVs/5ruurICYkw=;
        b=ULBNjuLdpqWAZ2CmB4BzlMaaWd3wivYDUqf55ArdZL2bND/xzqNk6lG+FiPOQ3Cog7
         8OWR2FOxNEmVvPShnwuw404/xjOdmYxarDoSwJ5MY1ZE15lsrphO2R+j9eTpWKU92j+x
         uh9AqedpJvOh9AcrGi4jrr1n4V6JVblSeFnH+jRy19l0aDor/DRyet4C7CjxNvL/awm8
         nhvCtaZfZbX9RMKvN/6jVUCEJOoM+KPJb4MVDSDNj1A+m99pgBRygkdHC3Ymff2D1VFH
         r4yidWA26S7SANyIzmpf46wpvzaHPhDCTyZNRobFlFog5Tpt2v1Azok1+G7bLBrW1wPo
         7+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X97uCJbbPtgQJjHkz/WOFp2vCTZb6uVs/5ruurICYkw=;
        b=R8OVPCcgW2jxtyPr2o0dmSczjhf8E7YoTvMjWsWMKaIgsX67DxGwbTUpHItxt1p/c9
         938eAEfNjU4+PcYPj+Z1y9zeCKd2zP/l2q87a834PtXjPIN2UMS74dGKytbLy/7vhSGt
         pCgqd3qSLu+xeIh3El20UKrujokeSSPyFmczmqMojbWJgCDwDA6tRVqSkYTVgNILs2i6
         m+bBdr0piZubPihv3Ht244+955GgeIYUWsZINt+NYlf6lCJwOF1PG8Viy5xlMGc19Qin
         PlvizCvBfP9q6lFQrcLAZ2AG2oZLXC8hMDo23JzLkdRvfX2gTFey9EFARHT54yxgJJM5
         wCjw==
X-Gm-Message-State: AOAM5336Axe5n/U4RefYbP1FUXbFbaupbHrUA2kEXLRUpa6wUctnT1Kj
        NLICQ/4Pr5b7M8V8BXSguhw=
X-Google-Smtp-Source: ABdhPJyTaA/4opdvLbW70FT+gxV6Bugiw2rykz38pBk31F7LC9wVf7OVz9/puIBVkWXDPMDPTLLe5A==
X-Received: by 2002:a37:b4b:: with SMTP id 72mr74113122qkl.48.1609803291325;
        Mon, 04 Jan 2021 15:34:51 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id a22sm37751757qkl.121.2021.01.04.15.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 15:34:50 -0800 (PST)
Date:   Mon, 4 Jan 2021 16:34:49 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Marco Elver <elver@google.com>, Arnd Bergmann <arnd@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        George Popescu <georgepope@android.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] ubsan: disable unsigned-integer-overflow sanitizer with
 clang
Message-ID: <20210104233449.GA3382424@ubuntu-m3-large-x86>
References: <20201230154749.746641-1-arnd@kernel.org>
 <CANpmjNNGmbgg_pFMC6X_6vZcj53jy7PsNyZAC88rOQC5zrOiFw@mail.gmail.com>
 <20210104223336.GA2562866@ubuntu-m3-large-x86>
 <20210104153333.4b6c7ae49edc4182d53bd17f@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210104153333.4b6c7ae49edc4182d53bd17f@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 04, 2021 at 03:33:33PM -0800, Andrew Morton wrote:
> On Mon, 4 Jan 2021 15:33:36 -0700 Nathan Chancellor <natechancellor@gmail.com> wrote:
> 
> > > > +++ b/lib/Kconfig.ubsan
> > > > @@ -122,6 +122,8 @@ config UBSAN_SIGNED_OVERFLOW
> > > >
> > > >  config UBSAN_UNSIGNED_OVERFLOW
> > > >         bool "Perform checking for unsigned arithmetic overflow"
> > > > +       # clang hugely expands stack usage with -fsanitize=object-size
> > > 
> > > This is the first time -fsanitize=object-size is mentioned. Typo?
> > 
> > Copy and paste issue from CONFIG_UBSAN_OBJECT_SIZE
> 
> This?

Correct.

> --- a/lib/Kconfig.ubsan~ubsan-disable-unsigned-integer-overflow-sanitizer-with-clang-fix
> +++ a/lib/Kconfig.ubsan
> @@ -122,7 +122,7 @@ config UBSAN_SIGNED_OVERFLOW
>  
>  config UBSAN_UNSIGNED_OVERFLOW
>  	bool "Perform checking for unsigned arithmetic overflow"
> -	# clang hugely expands stack usage with -fsanitize=object-size
> +	# clang hugely expands stack usage with -fsanitize=unsigned-integer-overflow
>  	depends on !CC_IS_CLANG
>  	depends on $(cc-option,-fsanitize=unsigned-integer-overflow)
>  	help
> _
> 

Cheers,
Nathan
