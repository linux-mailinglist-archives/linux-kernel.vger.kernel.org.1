Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26F0A290579
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 14:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407863AbgJPMq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 08:46:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38398 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407835AbgJPMqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 08:46:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602852363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7wF22TtTg52My8GhCH0JEYZmjtj4vDtDc64Kh1Nwbn8=;
        b=Q9aH34y8gGbejbvleKT6vXY9lbBca1XGinD/2Us08zh/jfwmPlOZrmXr5LkYwaNYQIS/B9
        TYcfsN+gpT2Ox6+oqabvzbXvAYIzTiDR2nXo2PAZvyNYl9YkcSVAFmd2M/yfGCX/AKC/VZ
        b5uO4Ei3TjCAEi82TrE/vxiewJevxD4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-paHSCaWdPyexwK0cGcLYug-1; Fri, 16 Oct 2020 08:46:02 -0400
X-MC-Unique: paHSCaWdPyexwK0cGcLYug-1
Received: by mail-ej1-f70.google.com with SMTP id z18so933532eji.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 05:46:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7wF22TtTg52My8GhCH0JEYZmjtj4vDtDc64Kh1Nwbn8=;
        b=ILhMFPN8bZHZrtLTBf7D5tP5SgBtroMxaOgIEpvcOaGaOZw+n8rThnmmOgZl1341hP
         q2CpPN1HA+08sfL2Kwp2QIT6uRKSnNxcA1N2XtitNb9iV+Eh9G4HhsksZi9L/AsEZkaT
         pNOaPl4vXbYBMmm0i4cZDOkQ8pZkqUJWQ5P032kQ9zL3ZAs9JXODwWl6HYB0HmsxegE+
         oapJHB/A08+p4kVd3WWRWnwK0RjAF6OPcp2sZCdTOXMTdspgL8VlwU/9B3wfDzBeLGus
         Twifk91tmEb4r2fcUR/U4fAXKQ1zdYJT4pAEPyw8/Nad++wXUxMLjyPFCkpRfjOEgsTa
         1Xjg==
X-Gm-Message-State: AOAM530wtRIEmZ7ig15fn6lv9KES7g25Oc/RV7qav31GGr6HhTSMHrhB
        P0BD6FF8JqtwVO7PxKHilBoDvvn9iq89V13tQvJIRrUc5hQqiOF9yG/rWdVl5fGnimKWUWSZBz0
        oUftHqGEFL4jbCwmrqWRxShPZ
X-Received: by 2002:a50:a452:: with SMTP id v18mr3558750edb.143.1602852360550;
        Fri, 16 Oct 2020 05:46:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxugyAIP9+8mi74NlTjuPZGUD97J50mq+5lrgMH6SXx3HSGmqYhS1uys0MlOWVLz+5l4KUX+g==
X-Received: by 2002:a50:a452:: with SMTP id v18mr3558722edb.143.1602852360301;
        Fri, 16 Oct 2020 05:46:00 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id t25sm1345815edt.24.2020.10.16.05.45.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2020 05:45:59 -0700 (PDT)
Subject: Re: [PATCH v4] bluetooth: hci_h5: fix memory leak in h5_close
To:     Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+6ce141c55b2f7aafd1c4@syzkaller.appspotmail.com,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201007034803.7554-1-anant.thazhemadam@gmail.com>
 <2a79ece2-c63b-a881-bc19-65b59952344f@redhat.com>
 <dfa15c3a-6081-1072-8c73-ecebc983643d@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <d07b1280-7b5f-f0fd-2892-a89a95712c9b@redhat.com>
Date:   Fri, 16 Oct 2020 14:45:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <dfa15c3a-6081-1072-8c73-ecebc983643d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/16/20 1:55 PM, Anant Thazhemadam wrote:
> 
> Hi,
> 
> On 16/10/20 4:58 pm, Hans de Goede wrote:
>> Hi,
>>
>> On 10/7/20 5:48 AM, Anant Thazhemadam wrote:
>>> If h5_close is called when !hu->serdev, h5 is directly freed.
>>> However, h5->rx_skb is not freed, which causes a memory leak.
>>>
>>> Freeing h5->rx_skb fixes this memory leak.
>>>
>>> In case hu->serdev exists, h5->rx_skb is then set to NULL,
>>> since we do not want to risk a potential NULL pointer 
>>> dereference.
>>>
>>> Fixes: ce945552fde4 ("Bluetooth: hci_h5: Add support for serdev enumerated devices")
>>> Reported-by: syzbot+6ce141c55b2f7aafd1c4@syzkaller.appspotmail.com
>>> Tested-by: syzbot+6ce141c55b2f7aafd1c4@syzkaller.appspotmail.com
>>> Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>h5_close v4
>>> ---
>>> Changes in v4:
>>> 	* Free h5->rx_skb even when hu->serdev
>>> 	(Suggested by Hans de Goede <hdegoede@redhat.com>)
>>> 	* If hu->serdev, then assign h5->rx_skb = NULL
>>>
>>> Changes in v3:
>>> 	* Free h5->rx_skb when !hu->serdev, and fix the memory leak
>>> 	* Do not incorrectly and unnecessarily call serdev_device_close()
>>>
>>> Changes in v2:
>>> 	* Fixed the Fixes tag
>>>
>>>  drivers/bluetooth/hci_h5.c | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
>>> index e41854e0d79a..39f9553caa5c 100644
>>> --- a/drivers/bluetooth/hci_h5.c
>>> +++ b/drivers/bluetooth/hci_h5.c
>>> @@ -245,11 +245,15 @@ static int h5_close(struct hci_uart *hu)
>>>  	skb_queue_purge(&h5->rel);
>>>  	skb_queue_purge(&h5->unrel);
>>>  
>>> +	kfree_skb(h5->rx_skb);
>>> +
>>>  	if (h5->vnd && h5->vnd->close)
>>>  		h5->vnd->close(h5);
>>>  
>>>  	if (!hu->serdev)
>>>  		kfree(h5);
>>> +	else
>>> +		h5->rx_skb = NULL;
>> Please just do this unconditionally directly after
>> the kfree_skb()
> 
> Could you also please tell me why this might be necessary?
> The pointer value stored at h5->rx_skb would be freed anyways when we free h5 (since rx_skb is
> essentially a member of the structure that h5 points to).

It is necessary in the path where the struct h5 points to is not
free-ed and it is cleaner to just always do it then, as you
indicate yourself 

> Also since we're performing the *if* check, the *else* condition wouldn't exactly be taxing either,
> right?

For the computer it is not taxing, but for a human reading the code
and trying to understand the flow it makes things extra complicated
unnecessarily.

> Is there some performance metric that I'm missing where unconditionally setting it to NULL
> in this manner would be better? (I couldn't find any resources that had any similar analysis
> performed :/ )
> Or is this in interest of code readability?

Yes, it is in interest of code readability?

> Also, how about we introduce a h5 = NULL, after freeing h5 when !hu->serdev?

That is not necessary, there is no reason to have that in either code path.

Regards,

Hans

