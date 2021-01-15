Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5F0B2F8496
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387509AbhAOSjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbhAOSjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:39:08 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDFFC0613C1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:38:27 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id b64so12616706qkc.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lpbx5IuXtyrVJCLCdm7CWpFGzxLbsst3nNSrDQhdHIs=;
        b=FinYw/4W+EFazsX3IViQ+0YbMzK1U7X95ughL7z8odtwPvAuWrnTVovnSbtPJxfJf0
         EzxFWoyVEBIIUvbYZdkF/LF2iNJfbQg+l+b1nejyUxvp5EXTpCPcdo+FVVLeO029T2zs
         tmYRaRBOEA21WO5fdfK4COrO/jFfFWSO5bzaAjCoJO/obgPDDXonH23GiST5JZngPA9d
         0rqE6Qts0LpwLpoYNvQqDGR/1h+ZH17qxPHESuiTOZrxFhxQuKjEKjcFtMCU4GPoKkTX
         KHKd0QQXw4KUnhB0LOwlcomeNxazLN86wtDyEmu62mbGLkWVkm0GY0Comd7eb5Do/Su1
         0Z7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lpbx5IuXtyrVJCLCdm7CWpFGzxLbsst3nNSrDQhdHIs=;
        b=Fj2cPMpZdq6pBnTCfVgEOZLOv2Hg9G2N8MP2mGscUvayWy1JhvRKo+jCQs1eR6i/+J
         03qqQurXoOxWvUirtAWh5rvcZP6s48y5A/Tr158ViSTeO11FYwMY0gq/ndvV4oxrdnYn
         NMbgM+LbGyjsV/Vv8do3QUNEhEt71awKxB0W3EgiSjMLPgQYLqpSRnbKpU+lX5D1q0VR
         b7PMB/LRPlLnJ3ZbwCd8HUnAL1FDaalEGXYWZvEZewVSG++CwM5DnzYhvQ1BEKbeKGD7
         S3jvbIwJRwkbbtnmPEwMLcyDERyxeA8rqEEoNqZVGThzDrdOa6nDlJ4txrC2ZZbjyC0s
         sn3A==
X-Gm-Message-State: AOAM533GukreOKQZZ1Y1vodvuN4LXOeuK71kW82lmH/NAY7G7hrUh74+
        0RC9tSCy16QgVG/451XoO/A=
X-Google-Smtp-Source: ABdhPJyEaIYbbejrIsurOuz1H4ibfoHcwE+61DLn4g4+QdBFDKpIWpnOmjkLy6bOMu16CxJyCanMmA==
X-Received: by 2002:a37:74c5:: with SMTP id p188mr14103185qkc.263.1610735907129;
        Fri, 15 Jan 2021 10:38:27 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id c62sm5404885qkf.34.2021.01.15.10.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 10:38:26 -0800 (PST)
Date:   Fri, 15 Jan 2021 11:38:24 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Richard Weinberger <richard@nod.at>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Zhihao Cheng <chengzhihao1@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Wang Hai <wanghai38@huawei.com>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] ubifs: replay: Fix high stack usage, again
Message-ID: <20210115183824.GA2641750@ubuntu-m3-large-x86>
References: <20210114213020.4108485-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210114213020.4108485-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 10:30:11PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> An earlier commit moved out some functions to not be inlined by gcc, but
> after some other rework to remove one of those, clang started inlining
> the other one and ran into the same problem as gcc did before:
> 
> fs/ubifs/replay.c:1174:5: error: stack frame size of 1152 bytes in function 'ubifs_replay_journal' [-Werror,-Wframe-larger-than=]
> 
> Mark the function as noinline_for_stack to ensure it doesn't happen
> again.
> 
> Fixes: f80df3851246 ("ubifs: use crypto_shash_tfm_digest()")
> Fixes: eb66eff6636d ("ubifs: replay: Fix high stack usage")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
>  fs/ubifs/replay.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ubifs/replay.c b/fs/ubifs/replay.c
> index 79801c9a5b87..0f8a6a16421b 100644
> --- a/fs/ubifs/replay.c
> +++ b/fs/ubifs/replay.c
> @@ -559,7 +559,9 @@ static int is_last_bud(struct ubifs_info *c, struct ubifs_bud *bud)
>  }
>  
>  /* authenticate_sleb_hash is split out for stack usage */
> -static int authenticate_sleb_hash(struct ubifs_info *c, struct shash_desc *log_hash, u8 *hash)
> +static int noinline_for_stack
> +authenticate_sleb_hash(struct ubifs_info *c,
> +		       struct shash_desc *log_hash, u8 *hash)
>  {
>  	SHASH_DESC_ON_STACK(hash_desc, c->hash_tfm);
>  
> -- 
> 2.29.2
> 
