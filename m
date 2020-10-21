Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2DDA294BBB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 13:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441954AbgJULXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 07:23:36 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:26071 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410713AbgJULX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 07:23:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1603279404;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=uVa2woxmUqKsyKgscV9FLllFGnOh09f3N0YknP9rilc=;
        b=eQY/2Pr66VRjQRhutbzKe2kTpVFgGpgvbSTUrE0H03szB8anAWlkxzk3W72Pl5Nu37
        9IC1KfI09Mmb+UiMZKnp2ZM8jmCkcIdhNDk9xQfBZgN7+tqX3Kqnz9f8ChokWIDcvNjx
        dmCqdaFdYm0a6ZIe9Cp3XcaJGTYDROVHczdLn3pZU16B5Q7ExEfDW1TVpmcpVkT7+CO+
        /C7XyK3BTvpRnMnyTSLrSbKoiXa/xSsUPVUix+14tkohQzo+XsqyROjF4JHYpuqHBaPF
        BDfIY4rUpkyV5gQfDQ1u6+OoiXBSv6ZXJ/q3dzH/Q4DQkKrWzb2LXZDDQAzqv8HmilpE
        3KRw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTGVNiOMRppw=="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
        by smtp.strato.de (RZmta 47.2.1 DYNA|AUTH)
        with ESMTPSA id D0b41cw9LBKLqvN
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Wed, 21 Oct 2020 13:20:21 +0200 (CEST)
Subject: Re: [PATCH] can: vxcan: Fix memleak in vxcan_newlink
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>, kjlu@umn.edu
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201021052150.25914-1-dinghao.liu@zju.edu.cn>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <986c27bf-29b4-a4f7-1dcd-4cb5a446334b@hartkopp.net>
Date:   Wed, 21 Oct 2020 13:20:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201021052150.25914-1-dinghao.liu@zju.edu.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21.10.20 07:21, Dinghao Liu wrote:
> When rtnl_configure_link() fails, peer needs to be
> freed just like when register_netdevice() fails.
> 
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

Btw. as the vxcan.c driver bases on veth.c the same issue can be found 
there!

At this point:
https://elixir.bootlin.com/linux/latest/source/drivers/net/veth.c#L1398

err_register_dev:
         /* nothing to do */
err_configure_peer:
         unregister_netdevice(peer);
         return err; <<<<<<<<<<<<<<<<<<<<<<<

err_register_peer:
         free_netdev(peer);
         return err;
}

IMO the return must be removed to fall through the next label and free 
the netdevice too.

Would you like so send a patch for veth.c too?

Best regards,
Oliver

> ---
>   drivers/net/can/vxcan.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
> index d6ba9426be4d..aefc5a61d239 100644
> --- a/drivers/net/can/vxcan.c
> +++ b/drivers/net/can/vxcan.c
> @@ -244,6 +244,7 @@ static int vxcan_newlink(struct net *net, struct net_device *dev,
>   
>   unregister_network_device:
>   	unregister_netdevice(peer);
> +	free_netdev(peer);
>   	return err;
>   }
>   
> 
