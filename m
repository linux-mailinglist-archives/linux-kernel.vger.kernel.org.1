Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEE7F2DBCF6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 09:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgLPIrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 03:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbgLPIri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 03:47:38 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211C8C0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 00:46:58 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id t16so22341303wra.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 00:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=9GJhtWvkN8uUb7ynAdpBmqYLfCoza+J+r/kjTFChiOc=;
        b=wUexLWyl2AzNh1zKZK2tao7lVeXqGTPB5iui2JyWbGKuAgcMoe3fdIr+BWFLtIihxZ
         TMY311bRGX0tBlBziH6Whd8XkeBL8ql//Or01RTgyo3hwsgtzQ3rAITJyLI4dJLlHfyt
         W1dH5FJ6gfjf9e/byPX+jt+drRDNA6A2NDCm9acx6GFyK2f4HDx9y7oNKOYPID7S4gGb
         pNfdza5p2AI7f7XFoMi1rjVvx/lSxqQWa2ogujGLZeeY2zZSI2PRW3Xm9n+2rXErK/oz
         zfUIyTl3fPQj4a8VGGketE0HcN0LYBw0RE7Cq7fqL4NDMTxEA0QTu0cE/0TZvdaC6eu2
         Y/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9GJhtWvkN8uUb7ynAdpBmqYLfCoza+J+r/kjTFChiOc=;
        b=ex40u9KcVZEuXo1l/l/UNYnsGHykl/+xTo740hUvMrbte34WncOpv5XkGt+cHqEngw
         EU3LPYn9C5EEONX6LbHmxg41wH8k8TUCbkXsWfhkF4r51nND5gTioJN2ivW3yVwdvH2u
         e2gVgFUaa9h4Xuh9aE6hziXISs7UAfwlFPvmQ8Orgu4FEUAv/4/tdwRE8GXiGDFdgzIv
         B/iSo0n6Z02lVi3YH4GuFjNwROoPfgfnAROV4Etc/5Nj0cviv41AijyNej6npsy0NmeV
         ubFItGj8HZ2SbKZwVeRjJp9+0heipe2rfY0ZTdWgRE2dlayVpCOUylmmA7X91oszMHNE
         lhVQ==
X-Gm-Message-State: AOAM531QahzpCeG2Vv5aIEsAvy3BQZH5L+YZ70L2dANgsZJlsZlcIZmV
        CDcc8CwxtixdJcgymMk2MQJklg==
X-Google-Smtp-Source: ABdhPJzXjHLJD+FA7MdN6U8osxDEQIz10uhFHPIwm2rxdL6lbmTXanBlxLUQr+LeL1Rll1rXttBILg==
X-Received: by 2002:adf:a495:: with SMTP id g21mr5942641wrb.198.1608108416851;
        Wed, 16 Dec 2020 00:46:56 -0800 (PST)
Received: from dell ([91.110.221.200])
        by smtp.gmail.com with ESMTPSA id h16sm2106272wrq.29.2020.12.16.00.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 00:46:55 -0800 (PST)
Date:   Wed, 16 Dec 2020 08:46:54 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Thor Thayer <thor.thayer@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: altera-sysmgr: Fix physical address storing more
Message-ID: <20201216084654.GE4776@dell>
References: <20201203225252.1476897-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201203225252.1476897-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Dec 2020, Arnd Bergmann wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> A recent fix improved the way the resource gets passed to
> the low-level accessors, but left one warning that appears
> in configurations with a resource_size_t that is wider than
> a pointer:
> 
> In file included from drivers/mfd/altera-sysmgr.c:19:
> drivers/mfd/altera-sysmgr.c: In function 'sysmgr_probe':
> drivers/mfd/altera-sysmgr.c:148:40: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
>   148 |   regmap = devm_regmap_init(dev, NULL, (void *)res->start,
>       |                                        ^
> include/linux/regmap.h:646:6: note: in definition of macro '__regmap_lockdep_wrapper'
>   646 |   fn(__VA_ARGS__, &_key,     \
>       |      ^~~~~~~~~~~
> drivers/mfd/altera-sysmgr.c:148:12: note: in expansion of macro 'devm_regmap_init'
>   148 |   regmap = devm_regmap_init(dev, NULL, (void *)res->start,
>       |            ^~~~~~~~~~~~~~~~
> 
> I had tried a different approach that would store the address
> in the private data as a phys_addr_t, but the easiest solution
> now seems to be to add a double cast to shut up the warning.
> 
> As the address is passed to an inline assembly, it is guaranteed
> to not be wider than a register anyway.
> 
> Fixes: d9ca7801b6e5 ("mfd: altera-sysmgr: Fix physical address storing hacks")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/mfd/altera-sysmgr.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
