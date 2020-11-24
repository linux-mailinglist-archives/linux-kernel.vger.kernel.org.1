Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD5752C1F0E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 08:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730195AbgKXHn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 02:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbgKXHn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 02:43:56 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D21C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 23:43:56 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1khSzP-0008VX-5r; Tue, 24 Nov 2020 08:43:51 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1khSzO-0008M5-GP; Tue, 24 Nov 2020 08:43:50 +0100
Date:   Tue, 24 Nov 2020 08:43:50 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Wang ShaoBo <bobo.shaobowang@huawei.com>
Cc:     richard@nod.at, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, huawei.libin@huawei.com,
        cj.chengjian@huawei.com
Subject: Re: [PATCH] bdi: Fix error return code in alloc_wbufs()
Message-ID: <20201124074350.GM24489@pengutronix.de>
References: <20201115082343.35645-1-bobo.shaobowang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201115082343.35645-1-bobo.shaobowang@huawei.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 08:42:29 up 278 days, 15:12, 76 users,  load average: 0.14, 0.16,
 0.16
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 15, 2020 at 04:23:43PM +0800, Wang ShaoBo wrote:
> Fix to return PTR_ERR() error code from the error handling case instead
> fo 0 in function alloc_wbufs(), as done elsewhere in this function.
> 
> Fixes: 6a98bc4614de ("ubifs: Add authentication nodes to journal")
> Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
> ---
>  fs/ubifs/super.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Prefix for this patch should be "ubifs:" rather than "bdi:". With this:

Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

> 
> diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
> index cb3acfb7dd1f..dacbb999ae34 100644
> --- a/fs/ubifs/super.c
> +++ b/fs/ubifs/super.c
> @@ -838,8 +838,10 @@ static int alloc_wbufs(struct ubifs_info *c)
>  		c->jheads[i].wbuf.jhead = i;
>  		c->jheads[i].grouped = 1;
>  		c->jheads[i].log_hash = ubifs_hash_get_desc(c);
> -		if (IS_ERR(c->jheads[i].log_hash))
> +		if (IS_ERR(c->jheads[i].log_hash)) {
> +			err = PTR_ERR(c->jheads[i].log_hash);
>  			goto out;
> +		}
>  	}
>  
>  	/*
> -- 
> 2.25.1
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
