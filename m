Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACC9127FE24
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 13:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731818AbgJALJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 07:09:28 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:24199 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731628AbgJALJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 07:09:28 -0400
X-Greylist: delayed 352 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Oct 2020 07:09:26 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1601550566;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=c7VtTMHN+fLkd5l+o+GivpKjyV0twYrb7Z/MtzLKgmQ=;
        b=s0XcBXxjOoO4IpnFdaFqZ8NzliaK6I08ZzFiZDGCvcdo238BbuAl6b3FuX0/J74F3C
        FV36JicfC0r7X30FMvq+ANYMR8WMFqD/lZESUAJaKfOoOwtf6vZvWZxrliFJ8SQNySej
        ZXiYW+t+nF9Z6aOqcPIWV+Ix7XyQArwPHJJ4/hrSHeynzZ/wgc/7Z6jqzjsF4WuNdEjY
        81TiMZI5+n/0lPwseY0BZGDIePOFAbh7eivbPdhay5LW8id/W1bdSOfapXb3Oo6f0wXz
        5aveTCzeLkmz1074K/uT7AeDgi21D2Jhqc4JSHtH4aMGn6avsp+Fo9iQD7eqCX313lhE
        YCNw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTEVR/J89pzV0="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.177]
        by smtp.strato.de (RZmta 47.1.9 DYNA|AUTH)
        with ESMTPSA id R06c13w91B3M2wM
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Thu, 1 Oct 2020 13:03:22 +0200 (CEST)
Subject: Re: [PATCH] can: raw: add missing error queue support
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
References: <20200926162527.270030-1-mailhol.vincent@wanadoo.fr>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <12294bf5-c791-8dea-617c-20f2b812c1b0@hartkopp.net>
Date:   Thu, 1 Oct 2020 13:03:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200926162527.270030-1-mailhol.vincent@wanadoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26.09.20 18:24, Vincent Mailhol wrote:
> Error queue are not yet implemented in CAN-raw sockets.
> 
> The problem: a userland call to recvmsg(soc, msg, MSG_ERRQUEUE) on a
> CAN-raw socket would unqueue messages from the normal queue without
> any kind of error or warning. As such, it prevented CAN drivers from
> using the functionalities that relies on the error queue such as
> skb_tx_timestamp().
> 
> SCM_CAN_RAW_ERRQUEUE is defined as the type for the CAN raw error
> queue. SCM stands for "Socket control messages". The name is inspired
> from SCM_J1939_ERRQUEUE of include/uapi/linux/can/j1939.h.
> 
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

Thanks Vincent!

> ---
>   include/uapi/linux/can/raw.h | 3 +++
>   net/can/raw.c                | 4 ++++
>   2 files changed, 7 insertions(+)
> 
> diff --git a/include/uapi/linux/can/raw.h b/include/uapi/linux/can/raw.h
> index 6a11d308eb5c..3386aa81fdf2 100644
> --- a/include/uapi/linux/can/raw.h
> +++ b/include/uapi/linux/can/raw.h
> @@ -49,6 +49,9 @@
>   #include <linux/can.h>
>   
>   #define SOL_CAN_RAW (SOL_CAN_BASE + CAN_RAW)
> +enum {
> +	SCM_CAN_RAW_ERRQUEUE = 1,
> +};
>   
>   /* for socket options affecting the socket (not the global system) */
>   
> diff --git a/net/can/raw.c b/net/can/raw.c
> index 94a9405658dc..98abab119136 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c
> @@ -804,6 +804,10 @@ static int raw_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
>   	noblock =  flags & MSG_DONTWAIT;
>   	flags   &= ~MSG_DONTWAIT;
>   
> +	if (flags & MSG_ERRQUEUE)
> +		return sock_recv_errqueue(sk, msg, size,
> +					  SOL_CAN_RAW, SCM_CAN_RAW_ERRQUEUE);
> +
>   	skb = skb_recv_datagram(sk, flags, noblock, &err);
>   	if (!skb)
>   		return err;
> 
