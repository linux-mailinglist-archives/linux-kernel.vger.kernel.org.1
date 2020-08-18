Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 808852480BB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 10:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgHRIf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 04:35:26 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36371 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgHRIfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 04:35:25 -0400
Received: by mail-ed1-f68.google.com with SMTP id ba10so14585734edb.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 01:35:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Re0tYm6kbctMDwqCO+5SGUDDrg/VlsT4jvWgv+xl6XE=;
        b=LDM06F6gO7w+0EIMdsKR6yPlE4a5SbwrgPLY40DEqTVh4eYXHouZnBpttL+WNNiCGU
         crd+WD8lM6zhLRdKL9Sp4oJcCiifz+zT2cb/9n2Rycx3EKCIwi7OBCynET8OXinqnP0/
         YEs/EeIbz7DQ3/70rFebrYsm0cFdyfbnibD4UC6jn7/0/HoZWe/hBh1xrn5duZt/e+ZP
         F127FLaOCeHNuZ3dWFyi66O5O8qQCOXJ1IpCxFAla0GyA0xCGMtz9MqwUeT13TlhUvIx
         AYQf6wS4KM6VDOS7ByCn/ufufXl6SZdTHnTbrZC7A559BMge1sk+mLJsqdBy1bmYFI7l
         D4jg==
X-Gm-Message-State: AOAM531OqlOVuec8qJQzc4O5GsiEanAE104MiAcmVdk1wzuRVXAZHNZk
        pHHijNoJCtK9eEV3Cn4qRkAo+EAUAkE=
X-Google-Smtp-Source: ABdhPJzIrH4o40RXZtegiiMRunKQ5zMwlq5WRRWGuaMBsmsh4ImDSNJfj2QlKZuz/QstxQpxHw4SaA==
X-Received: by 2002:aa7:dd05:: with SMTP id i5mr19191093edv.324.1597739723530;
        Tue, 18 Aug 2020 01:35:23 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id eb11sm9873077edb.76.2020.08.18.01.35.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2020 01:35:22 -0700 (PDT)
Subject: Re: [PATCH] tty: ipwireless: fix error handling
To:     Tong Zhang <ztong0001@gmail.com>, jikos@kernel.org,
        dsterba@suse.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
References: <20200816074334.981915-1-ztong0001@gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <b360242d-f488-da51-9d47-36b2abdf90cd@kernel.org>
Date:   Tue, 18 Aug 2020 10:35:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200816074334.981915-1-ztong0001@gmail.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16. 08. 20, 9:43, Tong Zhang wrote:
> ipwireless_send_packet() can only return 0 on success and -ENOMEM on
> error, the caller should check non zero for error condition
> 
> Signed-off-by: Tong Zhang <ztong0001@gmail.com>
> ---
>  drivers/tty/ipwireless/network.c | 4 ++--
>  drivers/tty/ipwireless/tty.c     | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/ipwireless/network.c b/drivers/tty/ipwireless/network.c
> index cf20616340a1..b6f677f4004c 100644
> --- a/drivers/tty/ipwireless/network.c
> +++ b/drivers/tty/ipwireless/network.c
> @@ -117,7 +117,7 @@ static int ipwireless_ppp_start_xmit(struct ppp_channel *ppp_channel,
>  					       skb->len,
>  					       notify_packet_sent,
>  					       network);
> -			if (ret == -1) {
> +			if (ret != 0) {

More consistent (with the rest of the kernel), would be to check "< 0"
in all the places.

>  				skb_pull(skb, 2);
>  				return 0;
>  			}
> @@ -134,7 +134,7 @@ static int ipwireless_ppp_start_xmit(struct ppp_channel *ppp_channel,
>  					       notify_packet_sent,
>  					       network);
>  			kfree(buf);
> -			if (ret == -1)
> +			if (ret != 0)
>  				return 0;
>  		}
>  		kfree_skb(skb);
> diff --git a/drivers/tty/ipwireless/tty.c b/drivers/tty/ipwireless/tty.c
> index fad3401e604d..0230e0fd3937 100644
> --- a/drivers/tty/ipwireless/tty.c
> +++ b/drivers/tty/ipwireless/tty.c
> @@ -218,7 +218,7 @@ static int ipw_write(struct tty_struct *linux_tty,
>  	ret = ipwireless_send_packet(tty->hardware, IPW_CHANNEL_RAS,
>  			       buf, count,
>  			       ipw_write_packet_sent_callback, tty);
> -	if (ret == -1) {
> +	if (ret != 0) {
>  		mutex_unlock(&tty->ipw_tty_mutex);
>  		return 0;
>  	}
> 


-- 
js
suse labs
