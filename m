Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6950C2903FC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 13:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406312AbgJPL2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 07:28:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25245 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406067AbgJPL23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 07:28:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602847707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uncw1p8wEaEZ4da7CrqyMdu3Pcg9RwYIjaA2lxjM3PI=;
        b=SDLmcbYpoLpj9rL2a/v2ATeG/yrbjsYpg8waXYjNLbUuQ6PxRAysm3GBGJnl/jsF7CYJoE
        Po2dkmi47upUtvnXcVsLuM1GDdWeTZsDwJYV7o5mkM+SlwwXq1OQf+AYVAW0uYAFg8I6Jr
        Ak6b2AQbfMnPXAUxAcKT+EcfsH2pXXE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-A38a2nL_OHu2H5XTluhsCA-1; Fri, 16 Oct 2020 07:28:25 -0400
X-MC-Unique: A38a2nL_OHu2H5XTluhsCA-1
Received: by mail-ej1-f72.google.com with SMTP id d13so813941ejz.6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 04:28:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Uncw1p8wEaEZ4da7CrqyMdu3Pcg9RwYIjaA2lxjM3PI=;
        b=kkPg8YE4gerklQAik5dqQhxfmOQzRWLj5r6yEuUEVBPWxDk/NkNio4rTKunx+1yUoy
         MolrQtdFyCIhVHOq7ClFBCFWVWMVUuga/2no9xR88sao2pKL26mDxkGumBaUrCGr8Ipi
         COFppAm+x6vK/zbFPOEZdaszwZdTKv4Parsb3f5EJ05UVn4jALrXABHDMEIfQnSGyqzz
         sdYSMpBixdlqm6f+1aBUZwpjvE1T5FlCnkJ0fukQUJigPZyRfkT8W71ElTl2uo2yKs6z
         BUtUk6ij4CK0nGiQB0nnsaO8PrXf5Y44sUbo7HSR3ZdbOm5pFEZRt9P9VxFlCxbNkIvt
         IwAA==
X-Gm-Message-State: AOAM532SzdBT7FLEAZiT9phTNDmeSYh3RU3wU/HeRjEPdEKTbGj9nHYG
        aypzMSQnxxm53CVlZ9Bm5AcetUtpClD0cLG0hmXdkKlQAVkgGd/2a+Q2kF9xSG/dPNBUtllRvZs
        PeDPh8pVZuN2PrMkOBhcz5aKM
X-Received: by 2002:a17:907:43c6:: with SMTP id i6mr3108673ejs.207.1602847704562;
        Fri, 16 Oct 2020 04:28:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxafcuee0i5hxOgusCBNcMWWy78Vr/YlDZ8KxL6yLiWe2S8E6BQLTMsRHYg7w1v3h++iMg/pQ==
X-Received: by 2002:a17:907:43c6:: with SMTP id i6mr3108655ejs.207.1602847704363;
        Fri, 16 Oct 2020 04:28:24 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id i5sm1335818ejs.121.2020.10.16.04.28.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2020 04:28:23 -0700 (PDT)
Subject: Re: [PATCH v4] bluetooth: hci_h5: fix memory leak in h5_close
To:     Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+6ce141c55b2f7aafd1c4@syzkaller.appspotmail.com,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201007034803.7554-1-anant.thazhemadam@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <2a79ece2-c63b-a881-bc19-65b59952344f@redhat.com>
Date:   Fri, 16 Oct 2020 13:28:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201007034803.7554-1-anant.thazhemadam@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/7/20 5:48 AM, Anant Thazhemadam wrote:
> If h5_close is called when !hu->serdev, h5 is directly freed.
> However, h5->rx_skb is not freed, which causes a memory leak.
> 
> Freeing h5->rx_skb fixes this memory leak.
> 
> In case hu->serdev exists, h5->rx_skb is then set to NULL,
> since we do not want to risk a potential NULL pointer 
> dereference.
> 
> Fixes: ce945552fde4 ("Bluetooth: hci_h5: Add support for serdev enumerated devices")
> Reported-by: syzbot+6ce141c55b2f7aafd1c4@syzkaller.appspotmail.com
> Tested-by: syzbot+6ce141c55b2f7aafd1c4@syzkaller.appspotmail.com
> Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>h5_close v4
> ---
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
>  drivers/bluetooth/hci_h5.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
> index e41854e0d79a..39f9553caa5c 100644
> --- a/drivers/bluetooth/hci_h5.c
> +++ b/drivers/bluetooth/hci_h5.c
> @@ -245,11 +245,15 @@ static int h5_close(struct hci_uart *hu)
>  	skb_queue_purge(&h5->rel);
>  	skb_queue_purge(&h5->unrel);
>  
> +	kfree_skb(h5->rx_skb);
> +
>  	if (h5->vnd && h5->vnd->close)
>  		h5->vnd->close(h5);
>  
>  	if (!hu->serdev)
>  		kfree(h5);
> +	else
> +		h5->rx_skb = NULL;

Please just do this unconditionally directly after
the kfree_skb()

So after this comment has been addressed the end result should
look like this:

	skb_queue_purge(&h5->rel);
	skb_queue_purge(&h5->unrel);
	kfree_skb(h5->rx_skb);
	h5->rx_skb = NULL;

	if (h5->vnd && h5->vnd->close)
		h5->vnd->close(h5);

	if (!hu->serdev)
		kfree(h5);
 
 	return 0;

Regards,

Hans

