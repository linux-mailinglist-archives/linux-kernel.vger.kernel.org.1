Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7243122452C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 22:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbgGQU01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jul 2020 16:26:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43006 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgGQU00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 16:26:26 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595017584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0bppecjFSahPLDC635ng21DpoqWWJcOKp7vehslPAzE=;
        b=xRW7s1sy+3Vg7McJip0MwxtT0Bfu65EjlzhApk6BtwIacjqN6ZddZnezAgoB4akZcGxpIc
        M+WRLziRYuGbYFYGc1FzX2svyxQSWkn89ReWi6epb+WKOPYYAyuscscf4EWs6P4AQ16SOy
        84erYEJY6n9pdIhAeerWPusbZuE0FSUhpHko9X3XJTz4buya44QhZOG7pPYK/0yT6BnsB2
        MXDrwwXudIehPSPy73wE2BN/FD2JjTtctYbyR0vX0OeGr9LHEJDEhzQvyt39Focs6kNHll
        yAVR6vgdq4pbko73mBnEQKYTN9HoQ/vU0yHYag9FXHxiCyWv9m9CjcS53DZ6qg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595017584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0bppecjFSahPLDC635ng21DpoqWWJcOKp7vehslPAzE=;
        b=pVZfdBBMvBG2kABvohPsK4S3d/OmKp7nvYcPLT8meov0WCZ84fSdAhvFfnnLD5CCz7kkmB
        lpsIPkzhIBu0gECw==
To:     Qinglang Miao <miaoqinglang@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marco Elver <elver@google.com>, Qian Cai <cai@lca.pw>
Cc:     linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH -next] debugobjects: Convert to DEFINE_SHOW_ATTRIBUTE
In-Reply-To: <20200716084747.8034-1-miaoqinglang@huawei.com>
References: <20200716084747.8034-1-miaoqinglang@huawei.com>
Date:   Fri, 17 Jul 2020 22:26:24 +0200
Message-ID: <87h7u5riq7.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qinglang Miao <miaoqinglang@huawei.com> writes:
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
>
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
> ---
>  lib/debugobjects.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
>
> diff --git a/lib/debugobjects.c b/lib/debugobjects.c
> index 5d2bbfc55..916a5c492 100644
> --- a/lib/debugobjects.c
> +++ b/lib/debugobjects.c
> @@ -1023,17 +1023,7 @@ static int debug_stats_show(struct seq_file *m, void *v)
>  	return 0;
>  }
>  
> -static int debug_stats_open(struct inode *inode, struct file *filp)
> -{
> -	return single_open(filp, debug_stats_show, NULL);
> -}
> -
> -static const struct file_operations debug_stats_fops = {
> -	.open		= debug_stats_open,
> -	.read_iter		= seq_read_iter,

This does not apply against mainline, so I assume this malformatted
thing comes from Christophs seq_read_iter changes in -next.

The seq_read_iter here makes no sense whatsoever if the same thing can
be achieved by using

> +DEFINE_SHOW_ATTRIBUTE(debug_stats);

and fixing it at the generic level.

Thanks,

        tglx
