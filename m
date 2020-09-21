Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 567E42726BF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 16:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbgIUOPH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 21 Sep 2020 10:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727229AbgIUOPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 10:15:05 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1377C061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 07:15:05 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1kKMau-0000CD-8Z; Mon, 21 Sep 2020 16:15:04 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1kKMar-0000oz-T0; Mon, 21 Sep 2020 16:15:01 +0200
Message-ID: <b883059e51c97d34196a1ad15bbec66a89283c8e.camel@pengutronix.de>
Subject: Re: [Re-send][PATCH] gpu/ipu-v3:reduce protected code area in ipu
 idmac get/put
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Bernard <bernard@vivo.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
Date:   Mon, 21 Sep 2020 16:15:01 +0200
In-Reply-To: <AN*ApwBwDVasgemZb6*hx4qM.1.1600686717774.Hmail.bernard@vivo.com>
References: <AN*ApwBwDVasgemZb6*hx4qM.1.1600686717774.Hmail.bernard@vivo.com>
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

Hi Bernard,

On Mon, 2020-09-21 at 19:11 +0800, Bernard wrote:
> This change will speed-up a bit these ipu_idmac_get &
> ipu_idmac_put processing and there is no need to protect
> kzalloc & kfree.

I don't think that will be measurable, the channel lock is very unlikely
to be contended. It might make more sense to replace the list walk with
a bitfield.

> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> ---
>  drivers/gpu/ipu-v3/ipu-common.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/ipu-v3/ipu-common.c b/drivers/gpu/ipu-v3/ipu-common.c
> index b3dae9ec1a38..8b3a57864c2e 100644
> --- a/drivers/gpu/ipu-v3/ipu-common.c
> +++ b/drivers/gpu/ipu-v3/ipu-common.c
> @@ -267,29 +267,30 @@ EXPORT_SYMBOL_GPL(ipu_rot_mode_to_degrees);
>  struct ipuv3_channel *ipu_idmac_get(struct ipu_soc *ipu, unsigned num)
>  {
>  	struct ipuv3_channel *channel;
> +	struct ipuv3_channel *entry;
>  
>  	dev_dbg(ipu->dev, "%s %d\n", __func__, num);
>  
>  	if (num > 63)
>  		return ERR_PTR(-ENODEV);
>  
> +	channel = kzalloc(sizeof(*channel), GFP_KERNEL);
> +	if (!channel)
> +		return ERR_PTR(-ENOMEM);
> +
> +	channel->num = num;
> +	channel->ipu = ipu;
> +
>  	mutex_lock(&ipu->channel_lock);
>  
> -	list_for_each_entry(channel, &ipu->channels, list) {
> -		if (channel->num == num) {
> +	list_for_each_entry(entry, &ipu->channels, list) {
> +		if (entry->num == num) {
> +			kfree(channel);
>  			channel = ERR_PTR(-EBUSY);
>  			goto out;

This leaks the channel memory allocated above.

>  		}
>  	}
> 
> -	channel = kzalloc(sizeof(*channel), GFP_KERNEL);
> -	if (!channel) {
> -		channel = ERR_PTR(-ENOMEM);
> -		goto out;
> -	}
> -
> -	channel->num = num;
> -	channel->ipu = ipu;
>  	list_add(&channel->list, &ipu->channels);
>  
>  out:
> @@ -308,9 +309,10 @@ void ipu_idmac_put(struct ipuv3_channel *channel)
>  	mutex_lock(&ipu->channel_lock);
>  
>  	list_del(&channel->list);
> -	kfree(channel);
>  
>  	mutex_unlock(&ipu->channel_lock);
> +
> +	kfree(channel);
>  }
>  EXPORT_SYMBOL_GPL(ipu_idmac_put);

regards
Philipp
