Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0B827E1E9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 08:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgI3G6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 02:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbgI3G6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 02:58:23 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04CCC061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 23:58:23 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1kNW46-000517-97; Wed, 30 Sep 2020 08:58:14 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1kNW45-0006KD-2t; Wed, 30 Sep 2020 08:58:13 +0200
Date:   Wed, 30 Sep 2020 08:58:13 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     richard@nod.at, yi.zhang@huawei.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] ubifs: Don't parse authentication mount options in
 remount process
Message-ID: <20200930065813.GC11648@pengutronix.de>
References: <20200929124531.941873-1-chengzhihao1@huawei.com>
 <20200929124531.941873-2-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929124531.941873-2-chengzhihao1@huawei.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 08:57:38 up 223 days, 14:28, 154 users,  load average: 0.04, 0.15,
 0.26
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 08:45:30PM +0800, Zhihao Cheng wrote:
> There is no need to dump authentication options while remounting,
> because authentication initialization can only be doing once in
> the first mount process. Dumping authentication mount options in
> remount process may cause memory leak if UBIFS has already been
> mounted with old authentication mount options.
> 
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> Cc: <stable@vger.kernel.org>  # 4.20+
> Fixes: d8a22773a12c6d7 ("ubifs: Enable authentication support")

Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

> ---
>  fs/ubifs/super.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
> index 6f85cd618766..9796f5df2f7f 100644
> --- a/fs/ubifs/super.c
> +++ b/fs/ubifs/super.c
> @@ -1110,14 +1110,20 @@ static int ubifs_parse_options(struct ubifs_info *c, char *options,
>  			break;
>  		}
>  		case Opt_auth_key:
> -			c->auth_key_name = kstrdup(args[0].from, GFP_KERNEL);
> -			if (!c->auth_key_name)
> -				return -ENOMEM;
> +			if (!is_remount) {
> +				c->auth_key_name = kstrdup(args[0].from,
> +								GFP_KERNEL);
> +				if (!c->auth_key_name)
> +					return -ENOMEM;
> +			}
>  			break;
>  		case Opt_auth_hash_name:
> -			c->auth_hash_name = kstrdup(args[0].from, GFP_KERNEL);
> -			if (!c->auth_hash_name)
> -				return -ENOMEM;
> +			if (!is_remount) {
> +				c->auth_hash_name = kstrdup(args[0].from,
> +								GFP_KERNEL);
> +				if (!c->auth_hash_name)
> +					return -ENOMEM;
> +			}
>  			break;
>  		case Opt_ignore:
>  			break;
> -- 
> 2.25.4
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
