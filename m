Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1A041B53C8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Apr 2020 06:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgDWEpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Apr 2020 00:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725863AbgDWEpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 00:45:21 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF91DC03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 21:45:20 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id b62so5096293qkf.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 21:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FgcNagYEln4cxTYaoyyO5o5Sq32or6db/uXYJBJj2lA=;
        b=ggCh4fIpuylohzlg8lV4ATdTsUNT9NGlSXgUAVFe5MJGVxwZExEfW7uL+mLBL2PlYy
         Ysh8xkQbXabSH7JDdsLAV5Ma7NI4ZKA7SAAfJg4RWWKSCs7VCZxxFiuVvWdqpbJkYyIy
         cibCr33/w6wAyG0Jgixl6UOXEVgkT8s5UiNlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FgcNagYEln4cxTYaoyyO5o5Sq32or6db/uXYJBJj2lA=;
        b=nmXLUxO8iHJdLD1S+INchnaY9n7T+ETNT+wvI+PZBIx3kW1HWGXEaoobJkviP9ZvZv
         5xjPuYbd42BQc4liPaAsqIh09JDImbBamAACUMg1HycKN2hIaDIyrwt2jfEcHFQ0xwwZ
         VY20i0tjuvbUPCD5JyEQFc+AwdqAkJWzujwiW1DtENkMIps5uWp0zHPmdoJ3k3cEp4Cj
         4mqWrFDtVG2liFwjtDdnju6xRyRx8vSm4/FGElgyHVguFl6Gqla4bHwCjMOzRLXhd05/
         cXqlLOIiqVJbdFR9SFqCoLdhDdJmYHWtH8Cyk+dazc3VnbFTAJFwcx4esplkOtEepcon
         kxuA==
X-Gm-Message-State: AGi0PubDEF3BVKTExzzbXOqKwmJrj+droJERG1aZAu4RPuybDO1qnsfS
        +33wu3Oxgb80Wktsmu2xmgyl8nL7+ks=
X-Google-Smtp-Source: APiQypIFhTR6xwo+BMXZ267qLo+Nbh/3LKhRonSbapgGdWuRjrCTgq6HTjhDiho/X9oFeTBRrwL3Qw==
X-Received: by 2002:a37:a5c7:: with SMTP id o190mr1834297qke.5.1587617119673;
        Wed, 22 Apr 2020 21:45:19 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id t67sm916921qka.17.2020.04.22.21.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 21:45:19 -0700 (PDT)
Date:   Thu, 23 Apr 2020 00:45:18 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] fs: Use slab constructor to initialize conn objects in
 fsnotify
Message-ID: <20200423044518.GA162422@google.com>
References: <20200423044050.162093-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423044050.162093-1-joel@joelfernandes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 12:40:50AM -0400, Joel Fernandes (Google) wrote:
> While reading the famous slab paper [1], I noticed that the conn->lock
> spinlock and conn->list hlist in fsnotify code is being initialized
> during every object allocation. This seems a good fit for the
> constructor within the slab to take advantage of the slab design. Move
> the initializtion to that.
> 
>        spin_lock_init(&conn->lock);
>        INIT_HLIST_HEAD(&conn->list);
> 
> [1] https://pdfs.semanticscholar.org/1acc/3a14da69dd240f2fbc11d00e09610263bdbd.pdf
> 

The commit message could be better. Just to clarify, doing it this way is
more efficient because the object will only have its spinlock init and hlist
init happen during object construction, not object allocation.

Construction happens when slab is populated, destruction happens when slab
returns memory to Linux kernel buddy allocator. Fast path is allocation.

thanks,

 - Joel


> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
> I've only build-tested. I am not very familiar with this code, so I
> kindly request the maintainers/reviewers to take a look and see if it
> makes sense. From what I see, the ->list is always empty during
> allocation. The spinlock allocation also seems unnecesary.
> 
> 
>  fs/notify/fsnotify.c | 15 +++++++++++++--
>  fs/notify/mark.c     |  2 --
>  2 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index 46f2255800091..55ed450da3295 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -385,6 +385,14 @@ int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_is,
>  }
>  EXPORT_SYMBOL_GPL(fsnotify);
>  
> +static void fsnotify_ctor(void *addr)
> +{
> +	struct fsnotify_mark_connector *conn = addr;
> +
> +	spin_lock_init(&conn->lock);
> +	INIT_HLIST_HEAD(&conn->list);
> +}
> +
>  static __init int fsnotify_init(void)
>  {
>  	int ret;
> @@ -395,8 +403,11 @@ static __init int fsnotify_init(void)
>  	if (ret)
>  		panic("initializing fsnotify_mark_srcu");
>  
> -	fsnotify_mark_connector_cachep = KMEM_CACHE(fsnotify_mark_connector,
> -						    SLAB_PANIC);
> +	fsnotify_mark_connector_cachep =
> +		kmem_cache_create("fsnotify_mark_connector",
> +				  sizeof(struct fsnotify_mark_connector),
> +				  __alignof__(struct fsnotify_mark_connector),
> +				  SLAB_PANIC, fsnotify_ctor);
>  
>  	return 0;
>  }
> diff --git a/fs/notify/mark.c b/fs/notify/mark.c
> index 1d96216dffd19..d388e7f45e2ea 100644
> --- a/fs/notify/mark.c
> +++ b/fs/notify/mark.c
> @@ -479,8 +479,6 @@ static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
>  	conn = kmem_cache_alloc(fsnotify_mark_connector_cachep, GFP_KERNEL);
>  	if (!conn)
>  		return -ENOMEM;
> -	spin_lock_init(&conn->lock);
> -	INIT_HLIST_HEAD(&conn->list);
>  	conn->type = type;
>  	conn->obj = connp;
>  	/* Cache fsid of filesystem containing the object */
> -- 
> 2.26.1.301.g55bc3eb7cb9-goog
