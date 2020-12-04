Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79E242CE91D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 09:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbgLDH71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 02:59:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36915 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728659AbgLDH70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 02:59:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607068680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3sUPOaWynCO3O/eLMCxguMEiANw6aKWhiDzAUiGP1rs=;
        b=EiuzwSzZ5DIcw3nXWMjqk00JMz3NDIOxI4OBR02kBPjjZm8hKUaEKDhL4IpLwoj+GgCiXu
        XM+kl+eDiDIFnr4Glfp7RKZcgeZ3No5IR/YvqcarbwBD78ciWHxC9ew5uFlYZCIj8/d8GI
        RIk41I4Ge1uKEq1NEOdTZ0YSaaZDuKM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-mywxpT0cOZS-UCo3RiuCvQ-1; Fri, 04 Dec 2020 02:57:58 -0500
X-MC-Unique: mywxpT0cOZS-UCo3RiuCvQ-1
Received: by mail-ed1-f71.google.com with SMTP id u18so2027840edy.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 23:57:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3sUPOaWynCO3O/eLMCxguMEiANw6aKWhiDzAUiGP1rs=;
        b=B3jN2Rf/fRhoZ5wyjdz4dh2N6FwGqO55j/qO7z7hjPYRG7l4XQcnYx/bnSEMZz5QOA
         O5Kj5HTJV6wPoejAJaGsl+S6TSAAvKGdsR2SiMoqXqbxTb89xwckPrMaiimlEdJ+TSHe
         uhqLVYTf0kvA+ivGKpomqd1asv4SdNeupL34sEK0d8OW0qfdWWlwMvx2W2Z5zDXhPnrG
         ERFZFXTjk3AZF73cvFdB1/dtj7vQyaTke99X+EqEnZ4uySFCYLXxhr/4xZVZa0XyjXLk
         grx6TcsyKzWUHFaLCTiqGI/7Fhk9Czt93AHZ8SeffNAqjA7nOzocXPoGiiuzT+uuhcIq
         67Zg==
X-Gm-Message-State: AOAM530PQTXstEp4inp2M2t/KlnGD1Ui1xoxgLsiOJ1Z3byLnOgeivXO
        uJBnEaY52gxyGXzHAk9I0qetQlLc4cBDQBle/q/xizcGFShxRfU6p+KufyA03iEpglmHJBbmXUL
        KxJKfNBduB9wxtyF9+uvFXnyT
X-Received: by 2002:a17:906:770d:: with SMTP id q13mr5749768ejm.409.1607068677145;
        Thu, 03 Dec 2020 23:57:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy9ydI+gk0GU597+caEbXF5t7mw+FzxHkXerBBLJn8KhsajbxWOv0eqvKpNN41S0NFeDV0DoA==
X-Received: by 2002:a17:906:770d:: with SMTP id q13mr5749761ejm.409.1607068676971;
        Thu, 03 Dec 2020 23:57:56 -0800 (PST)
Received: from steredhat (host-79-17-248-175.retail.telecomitalia.it. [79.17.248.175])
        by smtp.gmail.com with ESMTPSA id x16sm2504133ejo.104.2020.12.03.23.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 23:57:56 -0800 (PST)
Date:   Fri, 4 Dec 2020 08:57:53 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     virtualization@lists.linux-foundation.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, Oren Duer <oren@nvidia.com>,
        Jason Wang <jasowang@redhat.com>,
        Laurent Vivier <lvivier@redhat.com>,
        linux-kernel@vger.kernel.org, Max Gurtovoy <mgurtovoy@nvidia.com>,
        Shahaf Shuler <shahafs@nvidia.com>, Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH v3 02/19] vdpa_sim: remove unnecessary headers inclusion
Message-ID: <20201204075753.et4zauuc5w7aj2cn@steredhat>
References: <20201203170511.216407-1-sgarzare@redhat.com>
 <20201203170511.216407-3-sgarzare@redhat.com>
 <7e55ab39-afdd-f47b-55ec-a2bec4ab4cec@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <7e55ab39-afdd-f47b-55ec-a2bec4ab4cec@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Thu, Dec 03, 2020 at 09:37:48AM -0800, Randy Dunlap wrote:
>On 12/3/20 9:04 AM, Stefano Garzarella wrote:
>> Some headers are not necessary, so let's remove them to do
>> some cleaning.
>>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>
>Hi,
>What makes you say that some of these are unnecessary?
>
>Please use Rule #1 from Documentation/process/submit-checklist.rst:
>
>1) If you use a facility then #include the file that defines/declares
>   that facility.  Don't depend on other header files pulling in ones
>   that you use.
>
>
>so just because it will compile without these headers being explictly
>#included does not mean that you should remove them.

Thanks for the clarification. I tried to follow this rule already 
pointed out by Jason, but of course I missed the __init and __exit 
macros...

I'll check better for the next version!

>
>
>> ---
>> v3:
>> - avoided to remove some headers with structures and functions directly
>>   used (device.h, slab.h, virtio_byteorder.h)[Jason]
>> ---
>>  drivers/vdpa/vdpa_sim/vdpa_sim.c | 10 ----------
>>  1 file changed, 10 deletions(-)
>>
>> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> index 6a90fdb9cbfc..b08f28d20d8d 100644
>> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> @@ -7,20 +7,10 @@
>>   *
>>   */
>>
>> -#include <linux/init.h>
>
>above is used by __init and __exit.
>
>>  #include <linux/module.h>
>>  #include <linux/device.h>
>> -#include <linux/kernel.h>
>> -#include <linux/fs.h>
>> -#include <linux/poll.h>
>
>Looks OK to remove poll.h.
>
>>  #include <linux/slab.h>
>> -#include <linux/sched.h>
>
>Might be OK for sched.h.
>
>> -#include <linux/wait.h>
>
>Might be OK for wait.h.
>
>> -#include <linux/uuid.h>
>> -#include <linux/iommu.h>
>>  #include <linux/dma-map-ops.h>
>> -#include <linux/sysfs.h>
>> -#include <linux/file.h>
>>  #include <linux/etherdevice.h>
>>  #include <linux/vringh.h>
>>  #include <linux/vdpa.h>
>>
>
>I didn't check the others.
>

Thanks,
Stefano

