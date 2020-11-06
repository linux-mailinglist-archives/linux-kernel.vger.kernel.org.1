Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 044042A935C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 10:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgKFJuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 04:50:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbgKFJuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 04:50:09 -0500
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A493C0613CF;
        Fri,  6 Nov 2020 01:50:07 -0800 (PST)
Received: by mail-il1-x144.google.com with SMTP id p10so562602ile.3;
        Fri, 06 Nov 2020 01:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Xo980jxDgHwElwCLE395h1hcpqz7tSY6loYQUrMps3A=;
        b=nXWUVZfhV0+btoasoZHp+W0XUuF1dY1RydW0bCEjZfZMZechY86dZbBADBqZD7R/gP
         NkcnaZtFnMiOpXvJsZ/wQU3EyUjaLYzpGpBDcqosxFPjl6i99Vf8SA7ilr7YsQ3omeTf
         GsoZxcUeVWOvbTFznbC705BQq+A3Fki4eAhdJI1VJNqc3ynSPwRHVjZw8+UcHd429onw
         yF4ZN3e7Yj+Zk5VpaFDk8dJGkSyQeYDam1KVEB2acdyYKrj33KnhEURSTiBeOMAHNp7U
         /V1QRGjmFor/e/aG9sbrQXpfa/QnhQIjbjjVrD0Tm0RX1jHQtRInR14kLgF69656Aqea
         0Xvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Xo980jxDgHwElwCLE395h1hcpqz7tSY6loYQUrMps3A=;
        b=j3FigQfUYvAnZSwD9ImS5pgNqJIzehFMtmTKrC4Gl30IF5SqLz+ilmrg9yZ/s/yO7S
         T5d1ZUpODr9NJF2gjn6EKybFMrO0c1Wz8FFJ2731KGSmfpliMqOmtfo7GOMIN/0QbT2w
         sr0QEm/yJb2+b2cXvd5iAI/DjBX9vjpTgu3/SgGbbn3eMXSDaZbbrXCNpC74lKy7GieH
         wnU9CYQBo1ud3g25jE0i0GIejHikYj7P5TVnGopbNHg4W3mSy2Dot4uPq5YTjldJndfX
         Nr/UTp5zSx1EP8JnMRNa7igVksmplQ+sgzpvyUBTRsZuDL4VmdTExLYocQH3lQNVnbV/
         eq3A==
X-Gm-Message-State: AOAM532Fe3e6+AEfZgF4NLyAY9qEoNbDZz4yUnLhf/3UYMt+/Z6ooDKs
        AE8fSOgPGebvOXTuUfBR8oyVZsNv/l8=
X-Google-Smtp-Source: ABdhPJxZp36p6E2qRtUdnnHhjz1uk5ZO4T1LrrfvyzSUV82a53vXRt7bP0NKoshVvnHFy55uHy0/KQ==
X-Received: by 2002:a92:d449:: with SMTP id r9mr752535ilm.276.1604656206576;
        Fri, 06 Nov 2020 01:50:06 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id r14sm711209ilc.78.2020.11.06.01.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 01:50:06 -0800 (PST)
Date:   Fri, 6 Nov 2020 02:50:04 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Balbir Singh <bsingharora@gmail.com>, Tom Rix <trix@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-janitors@vger.kernel.org, linux-safety@lists.elisa.tech,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] taskstats: remove unneeded dead assignment
Message-ID: <20201106095004.GA3269193@ubuntu-m3-large-x86>
References: <20201106062210.27920-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106062210.27920-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 07:22:10AM +0100, Lukas Bulwahn wrote:
> make clang-analyzer on x86_64 defconfig caught my attention with:
> 
>   kernel/taskstats.c:120:2: warning: Value stored to 'rc' is never read \
>   [clang-analyzer-deadcode.DeadStores]
>           rc = 0;
>           ^
> 
> Commit d94a041519f3 ("taskstats: free skb, avoid returns in
> send_cpu_listeners") made send_cpu_listeners() not return a value and
> hence, the rc variable remained only to be used within the loop where
> it is always assigned before read and it does not need any other
> initialisation.
> 
> So, simply remove this unneeded dead initializing assignment.
> 
> As compilers will detect this unneeded assignment and optimize this anyway,
> the resulting object code is identical before and after this change.
> 
> No functional change. No change to object code.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Question below.

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
> applies cleanly on current master and next-20201105
> 
> Balbir, please pick this minor non-urgent clean-up patch.
> 
>  kernel/taskstats.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/taskstats.c b/kernel/taskstats.c
> index a2802b6ff4bb..bd18a7bf5276 100644
> --- a/kernel/taskstats.c
> +++ b/kernel/taskstats.c
> @@ -117,7 +117,6 @@ static void send_cpu_listeners(struct sk_buff *skb,
>  
>  	genlmsg_end(skb, reply);
>  
> -	rc = 0;
>  	down_read(&listeners->sem);
>  	list_for_each_entry(s, &listeners->list, list) {

Would it be worth moving the scope of rc into the for loop, now that it
is only used there? Looks like it used to be used in the main function
scope before commit 053c095a82cf ("netlink: make nlmsg_end() and
genlmsg_end() void") but if this is removed, it is only used to check
the return of genlmsg_unicast within the list_for_each_entry loop. Not
sure that buys us anything but I know you have done it in patches
before so I thought it was worth considering.

>  		skb_next = NULL;
> -- 
> 2.17.1
> 

Cheers,
Nathan
