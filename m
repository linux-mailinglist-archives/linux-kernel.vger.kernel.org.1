Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD480283E57
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 20:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbgJESb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 14:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbgJESb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 14:31:59 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93EA6C0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 11:31:57 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id m7so9710250oie.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 11:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4XnFMEYBigHgCV+fVeaAcl7/OtU/VYKO/+UnYZ6KE4s=;
        b=Yrzal8C//+9JYev4U13xMIp0iF4Qu+SG9pq5cGb8LrGlLgSBbQEFOGHXlRG4haURou
         d4Todi8A/INa13CMHZAyqmZdIgpHAsLwOHDLcqFNQznQzBEBHL8ZSM1Clte8ji4d6TZx
         6lkgihPPIwHlMvrBxFbg2bgQ3CklAsnA3KaP9mIwnPpmbanU+D12I8td67k4PhF8lCbi
         rC0bYDV+sqzMUHu74LoTwOyqbXTUjSCrnW9+RApoIgJBKEGcpdTuhcYmDdkAMa69KNpE
         llEsmPrkBDto1ELRfIz/L7dlTIpl3cCxlOW37pocX5n3Z+/biT9b3lJ3S8sk41Wlg6Gm
         L7qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=4XnFMEYBigHgCV+fVeaAcl7/OtU/VYKO/+UnYZ6KE4s=;
        b=KxLNmZBZI+tuwo+GlndA2MnECVtTdLG+UXtSBm0M2ZEh/exD0OJSOtqJ/OwC2wgUmG
         C78J5JV74LqqoyZxWTZE7aZQBEyq4bnGYeDeQNGAC19a1HvIQmhp7Ma3yAom9p6fspcw
         4Y8GXW6tW0MljY/svy9qHILtr53yQcSdu1KOssGYvopq6VPZR1J9zVXhvZTLuQI/m3aS
         GFGtjaYp6c/5NxuSvuM4lv/tVq2NOPUK51VUK/BALm0xpjZJHpbixQ42Pm95FuKj+1kz
         l8mM6YXd6MnWOa7SIcxwK7rtnXktbS5hDCzZKcHdM/HD+yRCMY/RZO03DC5+40VPrRbZ
         +yYg==
X-Gm-Message-State: AOAM531a4v4SRqnWsrhepLq5S/RQVciquRtFWkeATgMhCuuhiQfGkVjj
        LQc7XMbv9puP+Kgy9a8p04QzdWSuhH0P
X-Google-Smtp-Source: ABdhPJzvbPIUPxWLm0saT0hBXKv3OO0NTKt64qSAsrtuZ0CH5w6F7ca2KGeQ+INhrOgmoYbntyBrEg==
X-Received: by 2002:a54:468f:: with SMTP id k15mr419522oic.121.1601922716983;
        Mon, 05 Oct 2020 11:31:56 -0700 (PDT)
Received: from serve.minyard.net ([47.184.170.156])
        by smtp.gmail.com with ESMTPSA id g26sm133142otn.77.2020.10.05.11.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 11:31:56 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:24ea:bc45:cb5c:17a1])
        by serve.minyard.net (Postfix) with ESMTPSA id 759C7180056;
        Mon,  5 Oct 2020 18:31:54 +0000 (UTC)
Date:   Mon, 5 Oct 2020 13:31:53 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipmi_si: Fix wrong return value in try_smi_init()
Message-ID: <20201005183153.GF3038@minyard.net>
Reply-To: minyard@acm.org
References: <20201005145212.84435-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005145212.84435-1-tianjia.zhang@linux.alibaba.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 05, 2020 at 10:52:12PM +0800, Tianjia Zhang wrote:
> On an error exit path, a negative error code should be returned
> instead of a positive return value.

Thanks!  In my tree for the next release.

-corey

> 
> Fixes: 90b2d4f15ff7 ("ipmi_si: Remove hacks for adding a dummy platform devices")
> Cc: Corey Minyard <cminyard@mvista.com>
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> ---
>  drivers/char/ipmi/ipmi_si_intf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
> index 77b8d551ae7f..dd559661c15b 100644
> --- a/drivers/char/ipmi/ipmi_si_intf.c
> +++ b/drivers/char/ipmi/ipmi_si_intf.c
> @@ -1963,7 +1963,7 @@ static int try_smi_init(struct smi_info *new_smi)
>  	/* Do this early so it's available for logs. */
>  	if (!new_smi->io.dev) {
>  		pr_err("IPMI interface added with no device\n");
> -		rv = EIO;
> +		rv = -EIO;
>  		goto out_err;
>  	}
>  
> -- 
> 2.24.3 (Apple Git-128)
> 
