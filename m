Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFF42B42BA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 12:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729039AbgKPLYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 06:24:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41142 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726837AbgKPLYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 06:24:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605525842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FiZvfqwgppxhW4IM8Jvu0efXIHNIgO+wWL8qCIoswbY=;
        b=HcQpGxmYIHSg/2hSJze7IzBxyKnt8eMYLqqpVFDd6ENsjEUoy/5iCURLA9od3khhag1d23
        f9z4qefyTGO0V2hilvOCDgE9IQ6vlv8nNp5+KOAM/wesBZ/BKJ3g6TDw0/aemMPOsXiokM
        HdNZpi7P+Kmp7d16z97z/Yw8cfhNFbE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-cuW9dXP_MbKz55fgBdQfzQ-1; Mon, 16 Nov 2020 06:24:00 -0500
X-MC-Unique: cuW9dXP_MbKz55fgBdQfzQ-1
Received: by mail-wr1-f71.google.com with SMTP id y2so11059094wrl.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 03:23:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FiZvfqwgppxhW4IM8Jvu0efXIHNIgO+wWL8qCIoswbY=;
        b=hI1144VleDvVlioJHD1AZKd0ajI+rxhrqNBg27BgwgCGC+BOnc/nSXSGY4Y1osAWXj
         m7y6wP8dpBpN4HPKIl7j7aMZLzM7fIRncIQQvbJc/zCCG1WvtnYG8JpkswR/3dMbzGS1
         W/EE+ZeUBU96/vkgOx4KChQOdRHEOpkkdCLT+3v2pzX2++h1qrEbOshND7DL7GNzhsEO
         v1xRZ1xQGNopbDtzAZdSzaN94s/fBvUrv7a1z9+kgYDyr7M7bn9L1DOblII5GZhgsqS8
         R3hjqyEgQDi8LdakbEwQSg7BnjzFbiqnsS4O8EdTpZbHlX8ejkV4gRZqvt3x/IjXFxvT
         EMaA==
X-Gm-Message-State: AOAM532NuWj3yQIo+oh/z92A64izuY7H+dluet81i0Gs96wj2PZ1u43p
        4mAZkGxo2Yp3vWhYOxcOWbUooyxyoR63OYyS2qSb2+KfUAmfjosoL9VlZbrFD26RxQQWaNEHG/U
        LUMsQOlI4uFy/e+r+v1LTwDv5
X-Received: by 2002:a1c:7e8e:: with SMTP id z136mr15456806wmc.46.1605525838885;
        Mon, 16 Nov 2020 03:23:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyijXaCLKiuQIior2uUCDA8Exwaq67YsE7tAtnwOjZ8JmrvdfkGFcynUP8JyWVK9HRHnhbfFA==
X-Received: by 2002:a1c:7e8e:: with SMTP id z136mr15456793wmc.46.1605525838718;
        Mon, 16 Nov 2020 03:23:58 -0800 (PST)
Received: from steredhat (host-79-17-248-175.retail.telecomitalia.it. [79.17.248.175])
        by smtp.gmail.com with ESMTPSA id g131sm20177257wma.35.2020.11.16.03.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 03:23:58 -0800 (PST)
Date:   Mon, 16 Nov 2020 12:23:55 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Laurent Vivier <lvivier@redhat.com>,
        linux-kernel@vger.kernel.org, Eli Cohen <elic@nvidia.com>,
        Jason Wang <jasowang@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH RFC 12/12] vdpa_sim_blk: implement ramdisk behaviour
Message-ID: <20201116112355.vo6blezyrfh7kltl@steredhat>
References: <20201113134712.69744-1-sgarzare@redhat.com>
 <20201113134712.69744-13-sgarzare@redhat.com>
 <20201116045029-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201116045029-mutt-send-email-mst@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 04:50:43AM -0500, Michael S. Tsirkin wrote:
>On Fri, Nov 13, 2020 at 02:47:12PM +0100, Stefano Garzarella wrote:
>> The previous implementation wrote only the status of each request.
>> This patch implements a more accurate block device simulator,
>> providing a ramdisk-like behavior.
>>
>> Also handle VIRTIO_BLK_T_GET_ID request, always answering the
>> "vdpa_blk_sim" string.
>
>Maybe an ioctl to specify the id makes more sense.

I agree that make sense to make it configurable from the user, but I'm 
not sure an ioctl() is the best interface with this device simulator.

Maybe we can use a module parameter as in the net simulator or even 
better using the new vdpa management tool recently proposed (I need to 
check better how we can extend it).

What do you think?

Thanks,
Stefano

