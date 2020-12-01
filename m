Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 164052CACCE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 20:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730499AbgLATyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 14:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgLATyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 14:54:05 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FEFC0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 11:53:25 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id w16so1824946pga.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 11:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XC3Qhe317OJ0hZzdeId3fLznx80xlH5FZ74wj6e7ssA=;
        b=mKrS92qaZHAPG+6fvVKnHS4z2ywO/AedRO7DikxnJsnCwQUUZ9VIPrjmsX3GOTwOq8
         cwSJBbW2PVv3AGhwjQWcliOmqMfQZkVFdiLVS1vPvdo+ruu0Bcxwh/yOYVKBOQNiVU69
         NCg0SwCiPY/HKTIABgzTwbRBJ/V7hqx7w/ZRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XC3Qhe317OJ0hZzdeId3fLznx80xlH5FZ74wj6e7ssA=;
        b=NeNjMfvketFJ4uASYAI3dkm4E5RucSsLtL5VR6pq0ltM6Ij0VFyeH/dw468d4y8+KV
         CELyx8bFTgOe/UdwvgxPhlVErHWUPIgeDuLuZraLa3H2KEvo3oWYLV4HnxaN90ebLdhk
         RNflid3tMHGrQuxPVv2fnTV9PGHqEwfeMwLOmzinffckXvjTJcsRPeOid9Pjh6kf1wlR
         BvZZZkZyun+kEM9nOGfioK/SA5j9p5tg+tbXuw6WXAolmrmoQqfvIVu61Re9qGqFbgAN
         uh0m37TWdnOEoesCmZpthAapw3OjDhtQjkF2bwbctwwhiv8SRcbylvQqudRpoE1Y5e48
         vkUw==
X-Gm-Message-State: AOAM532PnJDe4fxj+uVZ9Qiskq/sF5AA6naj4TM69bnd582Fr5qKKgw+
        GXEOEsiksmaQXPQGpiULgfDcVg==
X-Google-Smtp-Source: ABdhPJyAWvD2svwlawu1o2Yy2ggsvDEA8gd5wyehMUTF0CiGBrXYbn1xwXvZNHPD9xkh4karGRmvug==
X-Received: by 2002:a62:158:0:b029:197:c89d:33a5 with SMTP id 85-20020a6201580000b0290197c89d33a5mr4083334pfb.42.1606852405436;
        Tue, 01 Dec 2020 11:53:25 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s18sm598200pfc.5.2020.12.01.11.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 11:53:24 -0800 (PST)
Date:   Tue, 1 Dec 2020 11:53:23 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        WeiXiong Liao <liaoweixiong@allwinnertech.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 9/9] pstore/blk: don't depend on CONFIG_BLOCK
Message-ID: <202012011152.5CD7EAD@keescook>
References: <20201016132047.3068029-1-hch@lst.de>
 <20201016132047.3068029-10-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016132047.3068029-10-hch@lst.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 03:20:47PM +0200, Christoph Hellwig wrote:
> pstore-blk contains of two different layers:
> 
>  a) a tiny layer of sugar coating ontop of pstore-zone.  This part has
>     no dependencies on the block layer, and can be used e.g. by mtd
>  b) an implementation of a default fallback pstore zone backend for
>     block devices
> 
> Add an ifdef for the latter so that pstore-blk itself does not have to
> depend on CONFIG_BLOCK.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

AFAIU, this can't be done until the read/write changes from patch 8 are
adopted, so, for now, I'm not taking this either.

-Kees

> ---
>  fs/pstore/Kconfig | 2 +-
>  fs/pstore/blk.c   | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
> index e16a49ebfe546d..6eadb538316e52 100644
> --- a/fs/pstore/Kconfig
> +++ b/fs/pstore/Kconfig
> @@ -164,7 +164,7 @@ config PSTORE_ZONE
>  config PSTORE_BLK
>  	tristate "Log panic/oops to a block device"
>  	depends on PSTORE
> -	depends on BLOCK
> +	depends on BLOCK || !BLOCK
>  	select PSTORE_ZONE
>  	default n
>  	help
> diff --git a/fs/pstore/blk.c b/fs/pstore/blk.c
> index bd4eadfc9bd795..d3d25edb943cdd 100644
> --- a/fs/pstore/blk.c
> +++ b/fs/pstore/blk.c
> @@ -182,6 +182,7 @@ void unregister_pstore_device(const struct pstore_zone_ops *ops)
>  }
>  EXPORT_SYMBOL_GPL(unregister_pstore_device);
>  
> +#ifdef CONFIG_BLOCK
>  static struct file *psblk_file;
>  
>  static ssize_t psblk_generic_blk_read(char *buf, size_t bytes, loff_t pos)
> @@ -269,6 +270,7 @@ void __init pstore_blk_early_init(void)
>  	__pstore_blk_init(devname);
>  }
>  #endif /* MODULE */
> +#endif /* CONFIG_BLOCK */
>  
>  /* get information of pstore/blk */
>  int pstore_blk_get_config(struct pstore_blk_config *info)
> -- 
> 2.28.0
> 

-- 
Kees Cook
