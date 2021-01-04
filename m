Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC792EA090
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 00:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbhADXN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 18:13:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727234AbhADXN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 18:13:56 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6687C061793
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 15:13:15 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id t8so26560898iov.8
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 15:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=G+1MVqQV4yHFgTMLgTDws1RowImJf6XP6VoJRtb5S+E=;
        b=A8AMn+1UUhCRiytO8dsAJ2EE22k8/KqGTTOp23oPFa5n7oJLACVw0A/Kzht12QIDiW
         PZj2L7RZkSmERf2UvNkn+QSrjUwO92g6Np5r26/pKKZ8KXU2kpY4HjPaeD4Ud8dWsHTl
         Bf6zl/9PzFP9C1vBFFZvxOIwkbQu99UwY9Fsv70XhOhfkpAqP6s5QP/yUB4jxSSh+xm3
         h1titWMzqdHcF1ULmEJv8Lev0gaHah5lAOFcG9uoUO920QrDmZYOM3/CokGnPnA5bShr
         5TjLPEIpxeYuIh3d2sHVZo4JmIAuCcxW7nRASgBT5D7rxdF062ewVsKDf1P0uoPpCJLk
         e5DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G+1MVqQV4yHFgTMLgTDws1RowImJf6XP6VoJRtb5S+E=;
        b=RgOhz+I6KvHQR8JtpkZjxq03g0KjSVLQOhmjdOzBIGJgrFpbwt7CzWFQQdKWGsweTW
         v1RwgfXehWrP3r7XLriYIj0f8o0Zsic/fIny1WpEqnlwyighWbA8g5fXFi+GP1lHddG7
         lE/MjCg1zTM9Gch6Jt3nXxpeZnSm6+NrYSJ0ZMdHMTCoN2+o1Oow5mvMlM+ShnbM3ALe
         mmyMGaZoDyHiqROa2xDgMC3mKW4RPQ4x+KaOA2IWH9fSyu04x2Sbls+dMnjwerXism7Q
         eWH28ixRouuIoX9l8BdrFuBzd0uqc62WEGIGVHG5NSsH7ROzyKj0iakUGXoGglQVKDtb
         SIPw==
X-Gm-Message-State: AOAM533hwf7JO7p1kqz7Lq6Pz6GgKFXWXKvAG71ADVXbd239lvE55MBg
        dGw+Gizh5fOl/QA9lYx3lbYYpxeleVE=
X-Google-Smtp-Source: ABdhPJyJ/EHlu4TgUEE4Q0VJAMJNWZRECaTm1kQJaWbzP5MMGBqG7/o70hv5UM86qz0za2h9WdbALQ==
X-Received: by 2002:ac8:6651:: with SMTP id j17mr74509403qtp.176.1609798569734;
        Mon, 04 Jan 2021 14:16:09 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id f134sm37674597qke.23.2021.01.04.14.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 14:16:09 -0800 (PST)
Date:   Mon, 4 Jan 2021 15:16:07 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     trix@redhat.com
Cc:     dwmw2@infradead.org, richard@nod.at, ndesaulniers@google.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] jffs2: fix use after free in jffs2_sum_write_data()
Message-ID: <20210104221607.GA1985645@ubuntu-m3-large-x86>
References: <20201230145604.1586486-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201230145604.1586486-1-trix@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 30, 2020 at 06:56:04AM -0800, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> clang static analysis reports this problem
> 
> fs/jffs2/summary.c:794:31: warning: Use of memory after it is freed
>                 c->summary->sum_list_head = temp->u.next;
>                                             ^~~~~~~~~~~~
> 
> In jffs2_sum_write_data(), in a loop summary data is handles a node at
> a time.  When it has written out the node it is removed the summary list,
> and the node is deleted.  In the corner case when a
> JFFS2_FEATURE_RWCOMPAT_COPY is seen, a call is made to
> jffs2_sum_disable_collecting().  jffs2_sum_disable_collecting() deletes
> the whole list which conflicts with the loop's deleting the list by parts.
> 
> To preserve the old behavior of stopping the write midway, bail out of
> the loop after disabling summary collection.
> 
> Fixes: 6171586a7ae5 ("[JFFS2] Correct handling of JFFS2_FEATURE_RWCOMPAT_COPY nodes.")
> Signed-off-by: Tom Rix <trix@redhat.com>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
>  fs/jffs2/summary.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/jffs2/summary.c b/fs/jffs2/summary.c
> index be7c8a6a5748..4fe64519870f 100644
> --- a/fs/jffs2/summary.c
> +++ b/fs/jffs2/summary.c
> @@ -783,6 +783,8 @@ static int jffs2_sum_write_data(struct jffs2_sb_info *c, struct jffs2_eraseblock
>  					dbg_summary("Writing unknown RWCOMPAT_COPY node type %x\n",
>  						    je16_to_cpu(temp->u.nodetype));
>  					jffs2_sum_disable_collecting(c->summary);
> +					/* The above call removes the list, nothing more to do */
> +					goto bail_rwcompat;
>  				} else {
>  					BUG();	/* unknown node in summary information */
>  				}
> @@ -794,6 +796,7 @@ static int jffs2_sum_write_data(struct jffs2_sb_info *c, struct jffs2_eraseblock
>  
>  		c->summary->sum_num--;
>  	}
> + bail_rwcompat:
>  
>  	jffs2_sum_reset_collected(c->summary);
>  
> -- 
> 2.27.0
> 
