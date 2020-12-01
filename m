Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9FB72CACCA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 20:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389343AbgLATxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 14:53:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgLATxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 14:53:18 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0A9C061A04
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 11:52:12 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id w187so1822900pfd.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 11:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kzcoYsY09fyusjT5AMkIO0g0ZNMleBgaxXfiFgISUoc=;
        b=lQ28NspZkvycAtydNG7uIXTEp4U/Dwnps4lM4S5J61bTMgToT3ekHkZ4ldLrjIA+c6
         UW9jW3yc8vIEzijsZyIFGjiPHtEaWK47UltWvHnKf07dgrZEOFLyE3dqGGpbC4nreGZr
         EKw9W1WvdCGuIIclLHRSfElEoy+TtEMaYA3U8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kzcoYsY09fyusjT5AMkIO0g0ZNMleBgaxXfiFgISUoc=;
        b=mG8EgmpblHqag1lVrtfBdKs+S7fauK/GmFm+r1OCC4EzdM5T5dQfNBqkGV0xxiTZwK
         pzFjIL7S0i02a8CBDjZuLM6PyDIsmAg+L0IOfBwmx2pDVk6huDRI3XWOWsF7u/tRIgnr
         hSjKjCBXPr+o+KRVgdPGoDWOtIDrOqk86YDZb7XN4JF+ATk8eml0sO1Ah1RM0eqNaUDs
         kSvrJVSVpBo0YCt4llzYxOt8Z4IkAu/4WXdVDOlFN9F59TmuuS0zcd+EplxvTPEa/IMf
         Wf3XJ+Iu/zmAswK5F5IM6tTIxgbz/oWivf3q/YBgYO8CmToLHLH744puFn9RfPZd3yI/
         QxLg==
X-Gm-Message-State: AOAM531HwlE2WOuz3dtkPR1Ho+oQfDSuMO8EZNlqEp/uO3KfbN1R22Jj
        2BqYIYHfgbtK6uVVhw9a34sshw==
X-Google-Smtp-Source: ABdhPJzMWU5+9mu7siiwZJfzgeD0xT8seDOZ8bDgc/ZyIz6583gkbgGZeWUfMp43r8x8wLDqfQkn+A==
X-Received: by 2002:aa7:9244:0:b029:19a:b335:754b with SMTP id 4-20020aa792440000b029019ab335754bmr3946028pfp.29.1606852331387;
        Tue, 01 Dec 2020 11:52:11 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v63sm511471pfb.217.2020.12.01.11.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 11:52:10 -0800 (PST)
Date:   Tue, 1 Dec 2020 11:52:09 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        WeiXiong Liao <liaoweixiong@allwinnertech.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/9] pstore/blk: use the normal block device I/O path
Message-ID: <202012011149.5650B9796@keescook>
References: <20201016132047.3068029-1-hch@lst.de>
 <20201016132047.3068029-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016132047.3068029-9-hch@lst.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 03:20:46PM +0200, Christoph Hellwig wrote:
> Stop poking into block layer internals and just open the block device
> file an use kernel_read and kernel_write on it.  Note that this means
> the transformation from name_to_dev_t can't be used anymore, and proper
> block device file names must be used.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> [...]
> +
> +#ifdef MODULE
> +static int __init pstore_blk_init(void)
> +{
> +	return __pstore_blk_init(blkdev);
> +}
>  late_initcall(pstore_blk_init);
>  
>  static void __exit pstore_blk_exit(void)
>  {
> -	if (!psblk_bdev)
> +	if (!psblk_file)
>  		return;
>  	unregister_pstore_device(&pstore_blk_zone_ops);
> -	blkdev_put(psblk_bdev, FMODE_READ | FMODE_WRITE | FMODE_EXCL);
> +	fput(psblk_file);
>  }
>  module_exit(pstore_blk_exit);
> +#else /* MODULE */
> +/*
> + * During early boot the real root file system hasn't been mounted yet,
> + * and not device nodes are present yet.  Use the same scheme to find
> + * the device that we use for mounting the root file system.
> + */
> +void __init pstore_blk_early_init(void)
> +{
> +	const char devname[] = "/dev/pstore-blk";
> +	dev_t dev = name_to_dev_t(blkdev);
> +
> +	if (!dev)
> +		return;
> +	init_unlink(devname);
> +	init_mknod(devname, S_IFBLK | 0600, new_encode_dev(dev));
> +	__pstore_blk_init(devname);
> +}
> +#endif /* MODULE */

That the allowed naming conventions change based on _how_ pstore is
built seems very wrong to me.

While I do like the clean up to simplify the read/write activities, this
seems like totally the wrong approach here.

>  
>  /* get information of pstore/blk */
>  int pstore_blk_get_config(struct pstore_blk_config *info)
> diff --git a/include/linux/pstore_blk.h b/include/linux/pstore_blk.h
> index 0abd412a6cb3e3..7c06b9d6740e2a 100644
> --- a/include/linux/pstore_blk.h
> +++ b/include/linux/pstore_blk.h
> @@ -39,4 +39,6 @@ struct pstore_blk_config {
>   */
>  int pstore_blk_get_config(struct pstore_blk_config *info);
>  
> +void __init pstore_blk_early_init(void);
> +
>  #endif
> diff --git a/init/main.c b/init/main.c
> index 1af84337cb18d5..058cce64f70390 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -98,6 +98,7 @@
>  #include <linux/mem_encrypt.h>
>  #include <linux/kcsan.h>
>  #include <linux/init_syscalls.h>
> +#include <linux/pstore_blk.h>
>  
>  #include <asm/io.h>
>  #include <asm/bugs.h>
> @@ -1524,6 +1525,9 @@ static noinline void __init kernel_init_freeable(void)
>  		prepare_namespace();
>  	}
>  
> +	if (IS_BUILTIN(CONFIG_PSTORE_BLK))
> +		pstore_blk_early_init();
> +

I hate this being a special-case in kernel_init. For ramoops, we use:

postcore_initcall(ramoops_init);

which is much better than open coding this here.

>  	/*
>  	 * Ok, we have completed the initial bootup, and
>  	 * we're essentially up and running. Get rid of the
> -- 
> 2.28.0
> 

-- 
Kees Cook
