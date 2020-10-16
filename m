Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2145290682
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 15:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408405AbgJPNqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 09:46:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56139 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2408396AbgJPNqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 09:46:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602855971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NBkmfVKFUnX5xElt1PEiALSx4k9GdQ5Cn3Wc4nFWM/A=;
        b=b3Xhtr1NGlqysJjp6nE3vF491oaAE/CSRlbUtNo6cobNyZYHJTZD9qcGQwZ5qk9n4DQ0pn
        X+mDw2Nbd2dTVjyRdyRWlsoAWkeUIhPS1QzlKxEaPbDDPtjwNjSmDunIzoRURRGBgLeqCH
        XqAew/w/MMV6bcpoOmL9rMz6wnOpArI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-6mx76JHpO5eEJWe8fsWmig-1; Fri, 16 Oct 2020 09:46:06 -0400
X-MC-Unique: 6mx76JHpO5eEJWe8fsWmig-1
Received: by mail-ed1-f70.google.com with SMTP id t4so1137659edv.7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 06:46:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NBkmfVKFUnX5xElt1PEiALSx4k9GdQ5Cn3Wc4nFWM/A=;
        b=H8/yIfWePJoywDyc4006DoTP0cA6nbGIQY4qVR/zXAHYqJsT0t1rK0hI9uFGT3Fkz7
         g5F/LCZ1vOM6hGqaB1QqepRHFJyV/s+DuLFWrSCFmx+qG7LISr0kxAHOsneVI7E3N7W6
         5zenrjyCadXAGQecMZac/XCPq8TkvpeXnYANUDvgJAzeiC+SNSZyuS2LvDGfK+xrgYYZ
         dW9dd5XdZDOXCxX2Uvr1fsuX9Jc04PGRRkzntPPQ/dtxBdIOA2Wz44iElKwLqxNRjU4+
         xWsGRtUW/r+pfc5A5qy4eqDy9mz5IEmNoLdpXDvZ2zYSZCjbKXm7d5fhHVCksS3WtdsF
         0J9A==
X-Gm-Message-State: AOAM531AF4o8RZv8HzrXmNqxG6auI60jLLk6MgzjF+bJwc5qmuBVnVHq
        qG+JS2nbqvcWYafCn+S2QQAVRWoxuluWL0emTnNbaxMOY7lwSwEAITpysE9ZhR7UNkLi2ZYgEhO
        kj05gJK+gFlArcGqulo8LEpdx
X-Received: by 2002:aa7:d7c1:: with SMTP id e1mr4082419eds.4.1602855965773;
        Fri, 16 Oct 2020 06:46:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyoTKG3QkQnEG+dV1fqpaabEFbYfbCMpVfWd6lV/nX6eaobQnpr0Pvxj+wUvOMcqXuRRZkm+A==
X-Received: by 2002:aa7:d7c1:: with SMTP id e1mr4082398eds.4.1602855965625;
        Fri, 16 Oct 2020 06:46:05 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id ck19sm1639662ejb.99.2020.10.16.06.46.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2020 06:46:04 -0700 (PDT)
Subject: Re: [PATCH v5] bluetooth: hci_h5: fix memory leak in h5_close
To:     Anant Thazhemadam <anant.thazhemadam@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+6ce141c55b2f7aafd1c4@syzkaller.appspotmail.com
References: <20201016131447.32107-1-anant.thazhemadam@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <df841745-8537-c21e-2a2d-b9c5c2dae800@redhat.com>
Date:   Fri, 16 Oct 2020 15:46:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201016131447.32107-1-anant.thazhemadam@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/16/20 3:14 PM, Anant Thazhemadam wrote:
> When h5_close() is called, h5 is directly freed when !hu->serdev.
> However, h5->rx_skb is not freed, which causes a memory leak.
> 
> Freeing h5->rx_skb and setting it to NULL, fixes this memory leak.
> 
> Fixes: ce945552fde4 ("Bluetooth: hci_h5: Add support for serdev enumerated devices")
> Reported-by: syzbot+6ce141c55b2f7aafd1c4@syzkaller.appspotmail.com
> Tested-by: syzbot+6ce141c55b2f7aafd1c4@syzkaller.appspotmail.com
> Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>

Patch looks good to me now:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
> Changes in v5:
> 	* Set h5->rx_skb = NULL unconditionally - to improve code
> 	  readability
> 	* Update commit message accordingly
> 
> Changes in v4:
> 	* Free h5->rx_skb even when hu->serdev
> 	(Suggested by Hans de Goede <hdegoede@redhat.com>)
> 	* If hu->serdev, then assign h5->rx_skb = NULL
> 
> Changes in v3:
> 	* Free h5->rx_skb when !hu->serdev, and fix the memory leak
> 	* Do not incorrectly and unnecessarily call serdev_device_close()
> 
> Changes in v2:
> 	* Fixed the Fixes tag
> 
> 
>  drivers/bluetooth/hci_h5.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
> index e41854e0d79a..0ef253136b06 100644
> --- a/drivers/bluetooth/hci_h5.c
> +++ b/drivers/bluetooth/hci_h5.c
> @@ -245,6 +245,9 @@ static int h5_close(struct hci_uart *hu)
>  	skb_queue_purge(&h5->rel);
>  	skb_queue_purge(&h5->unrel);
>  
> +	kfree_skb(h5->rx_skb);
> +	h5->rx_skb = NULL;
> +
>  	if (h5->vnd && h5->vnd->close)
>  		h5->vnd->close(h5);
>  
> 

