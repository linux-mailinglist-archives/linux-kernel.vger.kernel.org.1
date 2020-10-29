Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2FA29E2C4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 03:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391237AbgJ2CiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 22:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgJ2Cge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 22:36:34 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562CCC0613CF;
        Wed, 28 Oct 2020 19:36:33 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id z24so1132834pgk.3;
        Wed, 28 Oct 2020 19:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gtLhAt4Mup4k2BLNkJakc4GXEYtihBg9S7sO53gO1+A=;
        b=qQtaHxwJ2wg3DEJQ25CvkuAtrdeU43ot7Zd+Cas6VQhX3AetkU+wJsS6xokDINFz9y
         Xz+XVMU5etexOso6voKM+YYLdMcjEvgavYY/tQ9v9x+Ymxi6Bm9XCW6U3onCDzngeCY2
         B9r2bbQQ1hr+xOlTpB4Ms1YbOp2vLmCP/KDFKjeBblSggGP/8dvj3w4l4HyivCe7sXNp
         x37q+byBBIth5+MGb2cw2r+/s9jNLtsYKeXrx5/7yJXE1yEB2bZkUvwvAw2jyKCZFFr7
         lWvBs/U7tPkbzvmoURcXGO5W0XrZ2DJR3zpYBZRYUFpaHhcMmWEdGathfit9na5N/f0w
         JqvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gtLhAt4Mup4k2BLNkJakc4GXEYtihBg9S7sO53gO1+A=;
        b=iSrPNxXt/FRN0L+o0ReYS9XYUCWOQSYBdnw+aA6Pvl2xPAYsxBxKliTaMh9y1iUR67
         w45ocLdpzEQiM1oR0bP4v29eOw+HkjwE7UeaKUH8PYeoOi7nID9L0+KhilGIV4d8RLRK
         qq8KzKvI19o5rVG81E/P4d87ykON5mmGIbZuDGmSL1fT+PPFFTSrZp5HyETKikuUdkOc
         8YA414d9gHwmOvtxqk/ABmE/MdIn867Z0pXSfZW6LSlu2DOUIHQyVfdWBTktdfIFwSMS
         kzBH3DrdhdsPzRtNyjYwr62T8SsAtKb+MKDVTqtVQj/d0WOEcURWc5esz1D/U00Ekwgk
         wZEQ==
X-Gm-Message-State: AOAM533m2kisSvFG5kd/h/VPIB6kz+oED9VawyrCXTXES8lIK9hje2q0
        etGvNG528jwy6qer21it3YI=
X-Google-Smtp-Source: ABdhPJwBBhh+QNBvdIWdax4GSBVTo6mKgDh0nMGSbWr8EvCB0z8dTZvaufW3NUylDGOKlUcVVoyWxA==
X-Received: by 2002:a17:90a:d490:: with SMTP id s16mr342476pju.185.1603938992731;
        Wed, 28 Oct 2020 19:36:32 -0700 (PDT)
Received: from Ryzen-9-3900X.localdomain (ip68-98-75-144.ph.ph.cox.net. [68.98.75.144])
        by smtp.gmail.com with ESMTPSA id b128sm661648pga.80.2020.10.28.19.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 19:36:31 -0700 (PDT)
Date:   Wed, 28 Oct 2020 19:36:30 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        kernel-janitors@vger.kernel.org, linux-safety@lists.elisa.tech
Subject: Re: [PATCH] x86/unwind: remove unneeded initialization
Message-ID: <20201029023630.GA2316@Ryzen-9-3900X.localdomain>
References: <20201028122102.24202-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028122102.24202-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 01:21:02PM +0100, Lukas Bulwahn wrote:
> make clang-analyzer on x86_64 defconfig caught my attention with:
> 
>   arch/x86/kernel/unwind_orc.c:38:7: warning: Value stored to 'mid' during
>   its initialization is never read [clang-analyzer-deadcode.DeadStores]
>           int *mid = first, *found = first;
>                ^
> 
> Commit ee9f8fce9964 ("x86/unwind: Add the ORC unwinder") introduced
> __orc_find() with this unneeded dead-store initialization.
> 
> Put the variable in local scope and initialize only once the value is
> needed to make clang-analyzer happy.
> 
> As compilers will detect this unneeded assignment and optimize this
> anyway, the resulting object code is effectively identical before and
> after this change.
> 
> No functional change. Effectively, no change to object code.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Seems fine to me.

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
> applies cleanly on current master and next-20201028
> 
> Josh, please ack.
> Ingo, Borislav, please pick this minor non-urgent clean-up patch.
> 
>  arch/x86/kernel/unwind_orc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
> index 6a339ce328e0..5c64eed08257 100644
> --- a/arch/x86/kernel/unwind_orc.c
> +++ b/arch/x86/kernel/unwind_orc.c
> @@ -35,7 +35,7 @@ static struct orc_entry *__orc_find(int *ip_table, struct orc_entry *u_table,
>  {
>  	int *first = ip_table;
>  	int *last = ip_table + num_entries - 1;
> -	int *mid = first, *found = first;
> +	int *found = first;
>  
>  	if (!num_entries)
>  		return NULL;
> @@ -47,7 +47,7 @@ static struct orc_entry *__orc_find(int *ip_table, struct orc_entry *u_table,
>  	 * ignored when they conflict with a real entry.
>  	 */
>  	while (first <= last) {
> -		mid = first + ((last - first) / 2);
> +		int *mid = first + ((last - first) / 2);
>  
>  		if (orc_ip(mid) <= ip) {
>  			found = mid;
> -- 
> 2.17.1
> 
