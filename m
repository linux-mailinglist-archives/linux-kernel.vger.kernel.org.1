Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 453A027E236
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 09:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbgI3HKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 03:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728318AbgI3HKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 03:10:12 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE5EC061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 00:10:11 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1kNWFT-0006AC-Pv; Wed, 30 Sep 2020 09:09:59 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1kNWFQ-0007gN-8r; Wed, 30 Sep 2020 09:09:56 +0200
Date:   Wed, 30 Sep 2020 09:09:56 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     richard@nod.at, yi.zhang@huawei.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] ubifs: Fix a memleak after dumping authentication
 mount options
Message-ID: <20200930070956.GD11648@pengutronix.de>
References: <20200929124531.941873-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929124531.941873-1-chengzhihao1@huawei.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:00:32 up 223 days, 14:31, 154 users,  load average: 0.56, 0.23,
 0.27
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 08:45:29PM +0800, Zhihao Cheng wrote:
> Fix a memory leak after dumping authentication mount options in error
> handling branch.
> 
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> Cc: <stable@vger.kernel.org>  # 4.20+
> Fixes: d8a22773a12c6d7 ("ubifs: Enable authentication support")

Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>

I wonder if patches like in this series should really go to stable. There's
always the risk of regressions, and there's not much to win in fixing
such low probability, low frequency memory holes.

Sascha

> ---
>  fs/ubifs/super.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
> index a2420c900275..6f85cd618766 100644
> --- a/fs/ubifs/super.c
> +++ b/fs/ubifs/super.c
> @@ -1141,6 +1141,18 @@ static int ubifs_parse_options(struct ubifs_info *c, char *options,
>  	return 0;
>  }
>  
> +/*
> + * ubifs_release_options - release mount parameters which have been dumped.
> + * @c: UBIFS file-system description object
> + */
> +static void ubifs_release_options(struct ubifs_info *c)
> +{
> +	kfree(c->auth_key_name);
> +	c->auth_key_name = NULL;
> +	kfree(c->auth_hash_name);
> +	c->auth_hash_name = NULL;
> +}
> +
>  /**
>   * destroy_journal - destroy journal data structures.
>   * @c: UBIFS file-system description object
> @@ -1650,8 +1662,7 @@ static void ubifs_umount(struct ubifs_info *c)
>  	ubifs_lpt_free(c, 0);
>  	ubifs_exit_authentication(c);
>  
> -	kfree(c->auth_key_name);
> -	kfree(c->auth_hash_name);
> +	ubifs_release_options(c);
>  	kfree(c->cbuf);
>  	kfree(c->rcvrd_mst_node);
>  	kfree(c->mst_node);
> @@ -2219,6 +2230,7 @@ static int ubifs_fill_super(struct super_block *sb, void *data, int silent)
>  out_unlock:
>  	mutex_unlock(&c->umount_mutex);
>  out_close:
> +	ubifs_release_options(c);
>  	ubi_close_volume(c->ubi);
>  out:
>  	return err;
> -- 
> 2.25.4
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
