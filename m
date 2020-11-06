Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF8EA2A8DBE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 04:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgKFDtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 22:49:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgKFDtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 22:49:11 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FAC2C0613CF;
        Thu,  5 Nov 2020 19:49:11 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id h15so721qkl.13;
        Thu, 05 Nov 2020 19:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0oV6zTD6LpNnhkp+52mi6F8NkFZ6auhC3pOPfDEuyUc=;
        b=fG4iOMhyr9cocSQ20LTNCxxvAKTuWBVN19dLyiJ78lvLIXovaDI3ePjfr2NZCbP5k6
         c6Q0fDft8snMx0gJMcFx3tIziwybETFm2dl5NmLga/xI4rvxBYhMJRSnFlw3VLs5NTsS
         Etj+wgefTjFH+SaqG01qz7ZoK66TByB2k/ELHqZ8CvJ4M90d0MSQQGwsqhwHyP0Q6dL2
         Tq6EVuK74i/MyExDbUycscfPB5cln1r2h9IBDMp9jFfmZUZyRprpqbRrHGqpTgk+Cljp
         Y2luUT+bOQ29IkU6H++bv0/j6TnEwpFBDl41ZOfCkKVs+ieY+lbaNxIMJYp0s2NBgeJL
         Eh0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0oV6zTD6LpNnhkp+52mi6F8NkFZ6auhC3pOPfDEuyUc=;
        b=M2R3nikqGFR+fzTZrGBecnRtH+VJu6CcWOIEhTb6tatAb8sehQcPSWF8YzSSociVBO
         LGHHbS0VQNNntkJk66kNAeNnHJAgfFmlMSrqOAftfj1qSfmIqvIstHd4eWKRw//PND6y
         xVSX4glWONxW5gcuB4MciPbuvne7Co1cgvpwkzLCSGn5bQfpw48iYVIBg3XxahgcaoU/
         NwKwaOpdxMHNYaejFXGak66X/Qgah27HUSePnrOmX2WnDvhDCqbcvsT8MoqGyEP3N2M7
         UWWr7fBlxg5MwlizCzVgPhp0xddZ6RKpodEy33rZ52pNW5LYmUwQe0L0fNv9SZYgB7UV
         hisA==
X-Gm-Message-State: AOAM530yYo8z1PPTAEpkBbARKZvV6Qs5k5/326Lp41lZw94jykIYJ9Z+
        aUGWH2ezYS7IezJqVrcatS4=
X-Google-Smtp-Source: ABdhPJwV0oKBetot7vcJ05DTzplrUKh7nudzJXyD7DhYY7l1sfliTEVHDDHjshfYM70xIQhGpn2paQ==
X-Received: by 2002:a37:4796:: with SMTP id u144mr5356208qka.235.1604634550544;
        Thu, 05 Nov 2020 19:49:10 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id u2sm10411qtw.40.2020.11.05.19.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 19:49:09 -0800 (PST)
Date:   Thu, 5 Nov 2020 20:49:08 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        kernel-janitors@vger.kernel.org, linux-safety@lists.elisa.tech
Subject: Re: [PATCH] printk: remove unneeded dead-store assignment
Message-ID: <20201106034908.GA2143960@ubuntu-m3-large-x86>
References: <20201106034005.18822-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106034005.18822-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 04:40:05AM +0100, Lukas Bulwahn wrote:
> make clang-analyzer on x86_64 defconfig caught my attention with:
> 
>   kernel/printk/printk_ringbuffer.c:885:3: warning:
>   Value stored to 'desc' is never read [clang-analyzer-deadcode.DeadStores]
>                 desc = to_desc(desc_ring, head_id);
>                 ^
> 
> Commit b6cf8b3f3312 ("printk: add lockless ringbuffer") introduced
> desc_reserve() with this unneeded dead-store assignment.
> 
> As discussed with John Ogness privately, this is probably just some minor
> left-over from previous iterations of the ringbuffer implementation. So,
> simply remove this unneeded dead assignment to make clang-analyzer happy.
> 
> As compilers will detect this unneeded assignment and optimize this anyway,
> the resulting object code is identical before and after this change.
> 
> No functional change. No change to object code.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
> applies cleanly on current master and next-20201105
> 
> John, please ack.
> Petr, please pick this minor non-urgent clean-up patch.
> 
>  kernel/printk/printk_ringbuffer.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
> index 6b1525685277..74e25a1704f2 100644
> --- a/kernel/printk/printk_ringbuffer.c
> +++ b/kernel/printk/printk_ringbuffer.c
> @@ -882,8 +882,6 @@ static bool desc_reserve(struct printk_ringbuffer *rb, unsigned long *id_out)
>  	head_id = atomic_long_read(&desc_ring->head_id); /* LMM(desc_reserve:A) */
>  
>  	do {
> -		desc = to_desc(desc_ring, head_id);
> -
>  		id = DESC_ID(head_id + 1);
>  		id_prev_wrap = DESC_ID_PREV_WRAP(desc_ring, id);
>  
> -- 
> 2.17.1
> 
