Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660EC24EE11
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Aug 2020 18:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbgHWQHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Aug 2020 12:07:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:38702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbgHWQHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 12:07:41 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA66A20706;
        Sun, 23 Aug 2020 16:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598198861;
        bh=YQloOEt0O4We7AUVCTfNZUtWFYnW68Qic+j8RrXC9Ho=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jk84CJBYjDMsjFNzzdbRYlD9joOC+i/x8hXVy1uxeFNSEpE3/dkPZu7+sUMk0eRyB
         +YZVO67p+sCU9D3NVfHnDQYKWL1dI65WcbrIyaIMOtAn0ay0/lu41m/0dQm+xyMBar
         wM4nCjp4prPcEca8YnNZnhLgJRp/0Hk2bhnDNJ+k=
Date:   Sun, 23 Aug 2020 21:37:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     kishon@ti.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] phy: ti: j721e-wiz: Remove duplicate include
Message-ID: <20200823160737.GX2639@vkoul-mobl>
References: <20200818114721.55464-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818114721.55464-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-08-20, 19:47, YueHaibing wrote:
> Remove duplicate include file

Applied, thanks

> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/phy/ti/phy-j721e-wiz.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
> index 33c4cf0105a4..c9cfafe89cbf 100644
> --- a/drivers/phy/ti/phy-j721e-wiz.c
> +++ b/drivers/phy/ti/phy-j721e-wiz.c
> @@ -20,7 +20,6 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
>  #include <linux/reset-controller.h>
> -#include <dt-bindings/phy/phy.h>
>  
>  #define WIZ_SERDES_CTRL		0x404
>  #define WIZ_SERDES_TOP_CTRL	0x408
> -- 
> 2.17.1
> 

-- 
~Vinod
