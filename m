Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6B772B0C2C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 19:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgKLSCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 13:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbgKLSC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 13:02:28 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5031AC0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 10:02:28 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id r7so6150953qkf.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 10:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cwRfKaiAyvcKH2C/Ff9JVLU4RFzNHu2s5Gzo1tJCQz0=;
        b=uptdd8k18O0JneVelP6Se9IBq4FNsWkDeN0zC6APItTKK3NRlLYKOvIyRjGg/Ist6U
         bQyQu50D9qLtXOs4gzKOBgI3m49v9h6Cm3zFHxuPuUoL+A5b/xMFXJ09Ofa6ECsGcOqO
         4JwI1/FI8hE63InVi9JMLP4NPxZyeneHOi9NN6kjTLukdBb/Yd4hu1rKKJsfZfes5tmt
         XA+lXrnwHW1nD/K/Na1cMqyG1/SVgBLUlOW89SpYwQt15jUTuLzXOQnOdLgDdcaD7/Y9
         iJgWlBe2WjCiF0MdvQUxPL8zzBO7J+0ySfSnIE8zkYnI29HR9/+AH1zC+ZXF+6JDBFg3
         uh8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cwRfKaiAyvcKH2C/Ff9JVLU4RFzNHu2s5Gzo1tJCQz0=;
        b=cBSb3nooyediA0nvGz+htred5SaNZKaom2x5dgTtNFMOzh2CUSgvJsxCocZiYOe73X
         n4oA1yiFEg97R5cYqn1FipoQJQLnNY+sv0qbrJCfWLdI5MLtmUty2OSwyefof+boJZMT
         iO1w/cU+JG6+MUG1SuFp9hd/lPdeOc3O8Hp1w07umFhISmq3vfQ6mjTiu5JLYumsGfwH
         xq9mimJekJ3Wfd/F3PCwEbxGUbMGWS6nPqNVi2KPrddLdgqHIVJzy/eg5yhaQvfkSl5E
         Jwi2X4bM/MNHy9zEGSXkUqEhzzLRetXvHDKjEDLTpDXEFs99KaOrOlmtjG9af1aWZnfV
         MVPw==
X-Gm-Message-State: AOAM532VIzkVhlHb0VGUslFmdeDTMKzK72gsAUB+ux2My1OuHU+WvUFj
        2o+tmsdetk1OSuDe8CbPIlc=
X-Google-Smtp-Source: ABdhPJxQcjdx9LvQKhfxBG5f0jiXNsTvjR+RCQFpMPtzAzYmPdt5hBUSTQcUeKymRwR3RGYaZIMG2A==
X-Received: by 2002:a37:a943:: with SMTP id s64mr959191qke.15.1605204147414;
        Thu, 12 Nov 2020 10:02:27 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id r19sm4973529qtm.4.2020.11.12.10.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 10:02:26 -0800 (PST)
Date:   Thu, 12 Nov 2020 11:02:25 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Rob Herring <robherring2@gmail.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        clang-built-linux@googlegroups.com, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "dm cache: fix arm link errors with inline"
Message-ID: <20201112180225.GC934688@ubuntu-m3-large-x86>
References: <20201111024140.1483879-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111024140.1483879-1-ndesaulniers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 06:41:40PM -0800, 'Nick Desaulniers' via Clang Built Linux wrote:
> This reverts commit 43aeaa29573924df76f44eda2bbd94ca36e407b5.
> 
> Since
> commit 0bddd227f3dc ("Documentation: update for gcc 4.9 requirement")
> the minimum supported version of GCC is gcc-4.9. It's now safe to remove
> this code.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/427
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
>  drivers/md/dm-cache-target.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/md/dm-cache-target.c b/drivers/md/dm-cache-target.c
> index 9644424591da..4bc453f5bbaa 100644
> --- a/drivers/md/dm-cache-target.c
> +++ b/drivers/md/dm-cache-target.c
> @@ -712,10 +712,6 @@ static bool block_size_is_power_of_two(struct cache *cache)
>  	return cache->sectors_per_block_shift >= 0;
>  }
>  
> -/* gcc on ARM generates spurious references to __udivdi3 and __umoddi3 */
> -#if defined(CONFIG_ARM) && __GNUC__ == 4 && __GNUC_MINOR__ <= 6
> -__always_inline
> -#endif
>  static dm_block_t block_div(dm_block_t b, uint32_t n)
>  {
>  	do_div(b, n);
> -- 
> 2.29.2.222.g5d2a92d10f8-goog
> 
