Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 488CA29E2BF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 03:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404456AbgJ2CiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 22:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404439AbgJ2ChT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 22:37:19 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A6EC0613D1;
        Wed, 28 Oct 2020 19:37:18 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id x13so1118526pgp.7;
        Wed, 28 Oct 2020 19:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6XRUpzLiGuEo7PmpLXwl6+IIfCCFqx3XPv+eOFg52rM=;
        b=HuHr7lUi/XoZQNR8Nvwne0y+X9Y+XBP606LI3k20mieA7XVQIeIq73NEYxr+bDDgvi
         fnn1bIS0zlOhEs6bIn7T4dYsGFi/sqbfRnZV4WuK/Az64S7W7wbOrQudn1NM+v9Zn1Ia
         FP+aBs9Y0mI/T8pw7WVPb6yQz3LPEuVr2H5MoL85yBTNkeB5cPCIl3WC47z+XU8UGagN
         5hmWpRPCrwtEJSjDnu9J6yJg7gzMZbRRkeu+qL/YONDiVu+OPA2yA7F7/ghWLQBKFpEc
         cFzUp88lx69s0EosKkBIgMcU/0IvcJuZD/KZ3MiBQZZPbt9QxZINDHHSMxPgSYLW4Dbf
         pM+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6XRUpzLiGuEo7PmpLXwl6+IIfCCFqx3XPv+eOFg52rM=;
        b=SMdG4Tfk7J2vVWon6T7u9P4zHsDS+it+zJbxKFYgdehWW43NzJeLIRlXA5WPnTFPSk
         lnwp2+8RDOTOSKDCN6Q4uLxo1i5EuyPagPLbr1owb8qPjaahW1Dod/aKQkTB+XCV/h7B
         zvaNcBe/+LtO0GzIFJmhfgiiWl8Ik3ZNIKFzOwdk8dFkAoNK6GWUvYsJUFE740El6lzt
         mPEqLvR5y+NbH0KVrM0gY1YVU/AOjFr0BaALRwdNq64gI/RUVgUf+M2Z6f//K36Jx7rc
         g4MazTUEIUo6VNqyXgOsuFdDOt/Fz10SVrPRFnbmJa+aDVnXvESJvUi8YF684+hSPhaF
         1jTQ==
X-Gm-Message-State: AOAM531y90IbOCnyiZgtlNynS1q1Vk3GLTVs+d5gPZIe7TV0/KYCPrh3
        BtAHpjRHyWWl8X+M0Y1EAWU=
X-Google-Smtp-Source: ABdhPJygJB0qYgQJ4lfS6ccFAjSDgo8hbidulS36ztazwLHYfjvZx9a5cEqkQFGvVBt1kWlNdlycTw==
X-Received: by 2002:a65:689a:: with SMTP id e26mr2046138pgt.136.1603939037979;
        Wed, 28 Oct 2020 19:37:17 -0700 (PDT)
Received: from Ryzen-9-3900X.localdomain (ip68-98-75-144.ph.ph.cox.net. [68.98.75.144])
        by smtp.gmail.com with ESMTPSA id f71sm895705pfa.155.2020.10.28.19.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 19:37:17 -0700 (PDT)
Date:   Wed, 28 Oct 2020 19:37:16 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     David Airlie <airlied@linux.ie>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-safety@lists.elisa.tech
Subject: Re: [PATCH] agp: amd64: remove unneeded initialization
Message-ID: <20201029023716.GB2316@Ryzen-9-3900X.localdomain>
References: <20201028133106.5420-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028133106.5420-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 02:31:06PM +0100, Lukas Bulwahn wrote:
> make clang-analyzer on x86_64 defconfig caught my attention with:
> 
>   drivers/char/agp/amd64-agp.c:336:2: warning: \
>   Value stored to 'i' is never read [clang-analyzer-deadcode.DeadStores]
>           i = 0;
>           ^
> 
> Remove this unneeded initialization to make clang-analyzer happy.
> 
> Commit a32073bffc65 ("x86_64: Clean and enhance up K8 northbridge access
> code") refactored cache_nbs() and introduced this unneeded dead-store
> initialization.
> 
> As compilers will detect this unneeded assignment and optimize this anyway,
> the resulting binary is identical before and after this change.
> 
> No functional change. No change in binary code.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Seems obvious :)

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
> applies cleanly on current master and next-20201028
> 
> David, please pick this minor non-urgent clean-up patch.
> 
>  drivers/char/agp/amd64-agp.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/char/agp/amd64-agp.c b/drivers/char/agp/amd64-agp.c
> index b40edae32817..0413b3136541 100644
> --- a/drivers/char/agp/amd64-agp.c
> +++ b/drivers/char/agp/amd64-agp.c
> @@ -333,7 +333,6 @@ static int cache_nbs(struct pci_dev *pdev, u32 cap_ptr)
>  	if (!amd_nb_has_feature(AMD_NB_GART))
>  		return -ENODEV;
>  
> -	i = 0;
>  	for (i = 0; i < amd_nb_num(); i++) {
>  		struct pci_dev *dev = node_to_amd_nb(i)->misc;
>  		if (fix_northbridge(dev, pdev, cap_ptr) < 0) {
> -- 
> 2.17.1
> 
