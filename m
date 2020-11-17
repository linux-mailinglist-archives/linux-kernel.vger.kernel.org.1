Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97D3A2B6752
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 15:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbgKQOYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 09:24:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55831 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727952AbgKQOYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 09:24:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605623077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8MXJQ13wlrPLVjvOrheKkQMsdGs3KmerIV6Oa+JEIc8=;
        b=BOzLSVK6zTWe37V3GWDXi79QW2tJI16eJkTrOjyKZ+5s7exUlcfUG5SAqAWbRYF3jnoPVD
        TaERZWR/S4/3HZkkEWqqZYzmKJXb07chpcASFgRUDONsphhAEWC0a4SW8LOFDHHgTW5Oda
        7Z0o+06jJ9feFpBfGZ1Bwbk8bnhXk2E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-FZtIrzcwOXqEDDY_6SvFEQ-1; Tue, 17 Nov 2020 09:24:35 -0500
X-MC-Unique: FZtIrzcwOXqEDDY_6SvFEQ-1
Received: by mail-wr1-f72.google.com with SMTP id k1so12983313wrg.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 06:24:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8MXJQ13wlrPLVjvOrheKkQMsdGs3KmerIV6Oa+JEIc8=;
        b=STxGxe99HvFNri0We+WTr1ehNJQQLrL9jwCaUjPlaTxR7Jt4cjqQS7m2L78gqe5A1q
         pPl6fFgDpKL/oq6nz3/gRr22pZbqPVEdlBi9nMnzF+UCWlhFGGNB3veRnTIZYGvSPSQh
         iev1qF55MO2CG42hUg/J+qAOcXpKJrJGATep04hPV5j+uMFuO1Bf/mQI8Od8uxcv7zX9
         IiE96Tm6k9306VXVWyTa6OrusuNERjdvctUaGweC6kqNWm7sVo5pnWL/irBxceUZy/7t
         tB1GwbuwB/Nnrlh6zhLhrHlcAJryY38P3DpnPWWm3qttUX9fmLeZRbkLka14I58PBSbW
         hEVw==
X-Gm-Message-State: AOAM530LeOJdvNem1PzxitytnUOXqkKt+oRGwktBDAD9DrGHzaWcCZwt
        QX4HkK1GLfKCHQnBG1nucI9CnXW5PSae9YE4pfymZp/rTGMP8i+IyaB5mRItQFuklvHx8oYJwsd
        2z87NjdZZEvexzReCupt/WLt1
X-Received: by 2002:a7b:c5c6:: with SMTP id n6mr4871105wmk.131.1605623074685;
        Tue, 17 Nov 2020 06:24:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJydnM46ZfQJNcAZFkhGd7NjWAJ1JVIN1mUpc5vg0UqJ/iXNrwfvl7LgGewFVWVhELyVxfaDGw==
X-Received: by 2002:a7b:c5c6:: with SMTP id n6mr4871085wmk.131.1605623074442;
        Tue, 17 Nov 2020 06:24:34 -0800 (PST)
Received: from steredhat (host-79-17-248-175.retail.telecomitalia.it. [79.17.248.175])
        by smtp.gmail.com with ESMTPSA id 109sm28800836wra.29.2020.11.17.06.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 06:24:33 -0800 (PST)
Date:   Tue, 17 Nov 2020 15:24:30 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        Laurent Vivier <lvivier@redhat.com>,
        linux-kernel@vger.kernel.org, Eli Cohen <elic@nvidia.com>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH RFC 06/12] vdpa_sim: add struct vdpasim_device to store
 device properties
Message-ID: <20201117142430.qqlh5d5d6smbfxur@steredhat>
References: <20201113134712.69744-1-sgarzare@redhat.com>
 <20201113134712.69744-7-sgarzare@redhat.com>
 <20201117112305.GE131917@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201117112305.GE131917@stefanha-x1.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 11:23:05AM +0000, Stefan Hajnoczi wrote:
>On Fri, Nov 13, 2020 at 02:47:06PM +0100, Stefano Garzarella wrote:
>> Move device properties used during the entire life cycle in a new
>> structure to simplify the copy of these fields during the vdpasim
>> initialization.
>>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>>  drivers/vdpa/vdpa_sim/vdpa_sim.h     | 17 ++++++++------
>>  drivers/vdpa/vdpa_sim/vdpa_sim.c     | 33 ++++++++++++++--------------
>>  drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |  8 +++++--
>>  drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  9 +++++---
>>  4 files changed, 38 insertions(+), 29 deletions(-)
>>
>> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
>> index 6a1267c40d5e..76e642042eb0 100644
>> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
>> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
>> @@ -40,12 +40,17 @@ struct vdpasim_virtqueue {
>>  	irqreturn_t (*cb)(void *data);
>>  };
>>
>> +struct vdpasim_device {
>> +	u64 supported_features;
>> +	u32 id;
>> +	int nvqs;
>> +};
>> +
>>  struct vdpasim_init_attr {
>> -	u32		device_id;
>> -	u64		features;
>> +	struct vdpasim_device device;
>
>It's unclear to me what the exact purpose of struct vdpasim_device is.
>At least the name reminds me of struct device, which this is not.
>
>Should this be called just struct vdpasim_attr or struct
>vdpasim_dev_attr? In other words, the attributes that are needed even
>after intialization?

Yes, they are attributes that are needed even after intialization,
so I think vdpasim_dev_attr should be better.

I'll change it and I'll try to write a better commit message.

Thanks,
Stefano

