Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7AC27E198
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 08:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbgI3Gol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 02:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgI3Gok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 02:44:40 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DFCC061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 23:44:40 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1kNVqi-0003W7-C2; Wed, 30 Sep 2020 08:44:24 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1kNVqg-0005fd-0G; Wed, 30 Sep 2020 08:44:22 +0200
Date:   Wed, 30 Sep 2020 08:44:21 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     richard@nod.at, yi.zhang@huawei.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] ubifs: mount_ubifs: Release authentication resource
 in error handling path
Message-ID: <20200930064421.GB11648@pengutronix.de>
References: <20200929124531.941873-1-chengzhihao1@huawei.com>
 <20200929124531.941873-3-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929124531.941873-3-chengzhihao1@huawei.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 08:43:53 up 223 days, 14:14, 154 users,  load average: 0.20, 0.47,
 0.38
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 08:45:31PM +0800, Zhihao Cheng wrote:
> Release the authentication related resource in some error handling
> branches in mount_ubifs().
> 
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> Cc: <stable@vger.kernel.org>  # 4.20+
> Fixes: d8a22773a12c6d7 ("ubifs: Enable authentication support")

Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>

> ---
>  fs/ubifs/super.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
> index 9796f5df2f7f..732218ef6656 100644
> --- a/fs/ubifs/super.c
> +++ b/fs/ubifs/super.c
> @@ -1331,7 +1331,7 @@ static int mount_ubifs(struct ubifs_info *c)
>  
>  	err = ubifs_read_superblock(c);
>  	if (err)
> -		goto out_free;
> +		goto out_auth;
>  
>  	c->probing = 0;
>  
> @@ -1343,18 +1343,18 @@ static int mount_ubifs(struct ubifs_info *c)
>  		ubifs_err(c, "'compressor \"%s\" is not compiled in",
>  			  ubifs_compr_name(c, c->default_compr));
>  		err = -ENOTSUPP;
> -		goto out_free;
> +		goto out_auth;
>  	}
>  
>  	err = init_constants_sb(c);
>  	if (err)
> -		goto out_free;
> +		goto out_auth;
>  
>  	sz = ALIGN(c->max_idx_node_sz, c->min_io_size) * 2;
>  	c->cbuf = kmalloc(sz, GFP_NOFS);
>  	if (!c->cbuf) {
>  		err = -ENOMEM;
> -		goto out_free;
> +		goto out_auth;
>  	}
>  
>  	err = alloc_wbufs(c);
> @@ -1629,6 +1629,8 @@ static int mount_ubifs(struct ubifs_info *c)
>  	free_wbufs(c);
>  out_cbuf:
>  	kfree(c->cbuf);
> +out_auth:
> +	ubifs_exit_authentication(c);
>  out_free:
>  	kfree(c->write_reserve_buf);
>  	kfree(c->bu.buf);
> -- 
> 2.25.4
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
