Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A93B02C1F18
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 08:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730245AbgKXHqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 02:46:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730176AbgKXHqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 02:46:15 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ABC9C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 23:46:15 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1khT1f-0000Lh-NQ; Tue, 24 Nov 2020 08:46:11 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1khT1b-0008Vg-VT; Tue, 24 Nov 2020 08:46:07 +0100
Date:   Tue, 24 Nov 2020 08:46:07 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Wang ShaoBo <bobo.shaobowang@huawei.com>
Cc:     richard@nod.at, herbert@gondor.apana.org.au,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        huawei.libin@huawei.com, cj.chengjian@huawei.com
Subject: Re: [PATCH] ubifs: Fix error return code in
 ubifs_init_authentication()
Message-ID: <20201124074607.GN24489@pengutronix.de>
References: <20201124063320.1799-1-bobo.shaobowang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124063320.1799-1-bobo.shaobowang@huawei.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 08:45:36 up 278 days, 15:16, 77 users,  load average: 0.53, 0.23,
 0.18
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 02:33:20PM +0800, Wang ShaoBo wrote:
> Fix to return PTR_ERR() error code from the error handling case where
> ubifs_hash_get_desc() failed instead of 0 in ubifs_init_authentication(),
> as done elsewhere in this function.
> 
> Fixes: 49525e5eecca5 ("ubifs: Add helper functions for authentication support")
> Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
> ---
>  fs/ubifs/auth.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

> 
> diff --git a/fs/ubifs/auth.c b/fs/ubifs/auth.c
> index b93b3cd10bfd..8c50de693e1d 100644
> --- a/fs/ubifs/auth.c
> +++ b/fs/ubifs/auth.c
> @@ -338,8 +338,10 @@ int ubifs_init_authentication(struct ubifs_info *c)
>  	c->authenticated = true;
>  
>  	c->log_hash = ubifs_hash_get_desc(c);
> -	if (IS_ERR(c->log_hash))
> +	if (IS_ERR(c->log_hash)) {
> +		err = PTR_ERR(c->log_hash);
>  		goto out_free_hmac;
> +	}
>  
>  	err = 0;
>  
> -- 
> 2.17.1
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
