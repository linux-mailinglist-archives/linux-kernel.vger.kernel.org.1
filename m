Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35F722AB540
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 11:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729244AbgKIKpl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 9 Nov 2020 05:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgKIKpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 05:45:40 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA242C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 02:45:40 -0800 (PST)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1kc4g7-00083y-Eh; Mon, 09 Nov 2020 11:45:39 +0100
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1kc4g6-00040I-MX; Mon, 09 Nov 2020 11:45:38 +0100
Message-ID: <b22b651f4bc8388024c760d73caedcc647596f59.camel@pengutronix.de>
Subject: Re: [PATCH] reset: socfpga: add error handling and release
 mem-region
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Date:   Mon, 09 Nov 2020 11:45:38 +0100
In-Reply-To: <20201102195702.14496-1-dinguyen@kernel.org>
References: <20201102195702.14496-1-dinguyen@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-11-02 at 13:57 -0600, Dinh Nguyen wrote:
> In case of an error, call release_mem_region when an error happens
> during allocation of resources. Also add error handling for the case
> that reset_controller_register fails.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
>  drivers/reset/reset-socfpga.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/reset/reset-socfpga.c b/drivers/reset/reset-socfpga.c
> index bdd984296196..af9041ec37c6 100644
> --- a/drivers/reset/reset-socfpga.c
> +++ b/drivers/reset/reset-socfpga.c
> @@ -44,7 +44,7 @@ static int a10_reset_init(struct device_node *np)
>  	data->membase = ioremap(res.start, size);
>  	if (!data->membase) {
>  		ret = -ENOMEM;
> -		goto err_alloc;
> +		goto release_region;
>  	}
>  
>  	if (of_property_read_u32(np, "altr,modrst-offset", &reg_offset))
> @@ -59,7 +59,14 @@ static int a10_reset_init(struct device_node *np)
>  	data->rcdev.of_node = np;
>  	data->status_active_low = true;
>  
> -	return reset_controller_register(&data->rcdev);
> +	ret = reset_controller_register(&data->rcdev);
> +	if (ret)
> +		pr_err("unable to register device\n");
> +
> +	return 0;

Please don't return 0 if reset_controller_register() failed.

regards
Philipp
