Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE212A9369
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 10:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbgKFJvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 04:51:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbgKFJvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 04:51:49 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADDCC0613CF;
        Fri,  6 Nov 2020 01:51:49 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id q1so557486ilt.6;
        Fri, 06 Nov 2020 01:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mc9+iPglmE3qdIFo4WRNtRliEo4jSzg+7hnP+M7PZTA=;
        b=ExjoaigZHr1iLek2ntbaZ9zo9ZO327KqtbfjA9/R1+56ie74Ywo3Yw7OYI8gHfUNE3
         h5TYu5HhbkJAFAjHaM3PRneI16uRXn1mCqacMPs6A5oS0ImgQ7Oeb3+gkyuYLDbognRF
         WczLwrRArtAODg7+J8DKcsKo9u+0XKkHEtEwEhhhpayGAfdFefE/mN+ORsFCJt2AkxK0
         BQOgi9+vfjxpAoYUMxTcXHTa1fipjPr/jXl4bG4y6FtpYWvBqqcVOiC88kUVleRO4dGl
         KD6oZrrXxnTrdiBkwzsQH93IdCA4ROqqHgGPwzI+c0mgLfFiou7lUQsZ2V5Lj/5X+d/E
         G5Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mc9+iPglmE3qdIFo4WRNtRliEo4jSzg+7hnP+M7PZTA=;
        b=BgGFMLIqBoWSXDY9y7qcfqmRvwTxXzOHkWleFIQdJZGJ+XPbVUyRcHvVIKid4Vt6c6
         bwHl1Sw6MiSVgJZwX5qXJLUvAD/457QN5D9CEdsLVgofcwKv6/6GU5L5UT0EDNNpoVcg
         2JSoeaWcKoebJyW/8kiTutl/yX9+7rZO8AQoOmc3VYzv5QqFU0kxBxSPlf81u1s/MO1o
         RBXLl0Nete5xKIf7UD3E9bOa+AW4DlRajxd8kOj/JBuWeIvIJjv277huDOmKF2cwCZSh
         h6EWlKZkVmETe6/4SsgepVm5ccnjG1lihIVjgpPn0m9PfAS7/uZILSM574L6BOWEPBSV
         GFbQ==
X-Gm-Message-State: AOAM532+9DEcgSvzDWmI8TkKMOJ3E4z68adNtDtyCv+atCFVxbS+0WJQ
        AHG98BP8J405zMatebsX2of7U52uTjM=
X-Google-Smtp-Source: ABdhPJyD9utqj/Aul5/LelRYf7I0nxuWizINITvfinG5j/d04iFDD8pBVqDZE7QMv02cwp43jCR6Zg==
X-Received: by 2002:a92:ba14:: with SMTP id o20mr781162ili.76.1604656309005;
        Fri, 06 Nov 2020 01:51:49 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id m10sm697502ilg.77.2020.11.06.01.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 01:51:48 -0800 (PST)
Date:   Fri, 6 Nov 2020 02:51:46 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Tom Rix <trix@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-janitors@vger.kernel.org, linux-safety@lists.elisa.tech,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: remove unneeded dead-store initialization
Message-ID: <20201106095146.GA3269500@ubuntu-m3-large-x86>
References: <20201106094820.30167-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106094820.30167-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 10:48:20AM +0100, Lukas Bulwahn wrote:
> make clang-analyzer on x86_64 defconfig caught my attention with:
> 
>   drivers/clk/clk.c:423:19:
>   warning: Value stored to 'parent' during its initialization is never read
>   [clang-analyzer-deadcode.DeadStores]
>           struct clk_core *parent = ERR_PTR(-ENOENT);
>                            ^
> 
> Commit fc0c209c147f ("clk: Allow parents to be specified without string
> names") introduced clk_core_fill_parent_index() with this unneeded
> dead-store initialization.
> 
> So, simply remove this unneeded dead-store initialization to make
> clang-analyzer happy.
> 
> As compilers will detect this unneeded assignment and optimize this anyway,
> the resulting object code is identical before and after this change.
> 
> No functional change. No change to object code.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Indeed, parent is always assigned a new value before that one is read.

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
> applies cleanly on current master and next-20201106
> 
> Stephen, Michael, please pick this minor non-urgent clean-up patch.
> 
>  drivers/clk/clk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index f83dac54ed85..ba35bf35bcd3 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -420,7 +420,7 @@ static struct clk_core *clk_core_get(struct clk_core *core, u8 p_index)
>  static void clk_core_fill_parent_index(struct clk_core *core, u8 index)
>  {
>  	struct clk_parent_map *entry = &core->parents[index];
> -	struct clk_core *parent = ERR_PTR(-ENOENT);
> +	struct clk_core *parent;
>  
>  	if (entry->hw) {
>  		parent = entry->hw->core;
> -- 
> 2.17.1
> 
