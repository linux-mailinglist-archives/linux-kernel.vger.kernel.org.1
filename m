Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62C062D7E09
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 19:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405205AbgLKSYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 13:24:50 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:64967
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404841AbgLKSYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 13:24:17 -0500
X-IronPort-AV: E=Sophos;i="5.78,412,1599516000"; 
   d="scan'208";a="367393133"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2020 19:23:32 +0100
Date:   Fri, 11 Dec 2020 19:23:32 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] block: drop dead assignments in loop_init()
In-Reply-To: <20201211181236.25755-1-lukas.bulwahn@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2012111923020.2669@hadrien>
References: <20201211181236.25755-1-lukas.bulwahn@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 11 Dec 2020, Lukas Bulwahn wrote:

> Commit 8410d38c2552 ("loop: use __register_blkdev to allocate devices on
> demand") simplified loop_init(); so computing the range of the block region
> is not required anymore and can be dropped.
>
> Drop dead assignments in loop_init().
>
> As compilers will detect these unneeded assignments and optimize this,
> the resulting object code is identical before and after this change.
>
> No functional change. No change in object code.

It looks like some braces should be dropped too?

julia

>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Christoph, please ack.
>
> Jens, please pick this minor non-urgent clean-up patch on your
> block -next tree on top of Christoph's commit above.
>
>  drivers/block/loop.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index d2ce1ddc192d..eed4bc5ef5c5 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -2304,7 +2304,6 @@ MODULE_ALIAS("devname:loop-control");
>  static int __init loop_init(void)
>  {
>  	int i, nr;
> -	unsigned long range;
>  	struct loop_device *lo;
>  	int err;
>
> @@ -2343,10 +2342,8 @@ static int __init loop_init(void)
>  	 */
>  	if (max_loop) {
>  		nr = max_loop;
> -		range = max_loop << part_shift;
>  	} else {
>  		nr = CONFIG_BLK_DEV_LOOP_MIN_COUNT;
> -		range = 1UL << MINORBITS;
>  	}
>
>  	err = misc_register(&loop_misc);
> --
> 2.17.1
>
>
