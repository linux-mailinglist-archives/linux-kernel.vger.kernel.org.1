Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 725582D4081
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 12:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730310AbgLILAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 06:00:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25637 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728392AbgLILAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 06:00:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607511516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CgtH182QZzc921P4YWhD7Eorh+vwR+HI0Yw44CrRtXQ=;
        b=PL6b+CBYjAn1sM/TC5hhGhBGNLXBTr+ewSBSe5soHOBjpV2c6qYnvXib5CH4mI++6vvyvF
        AfbUe01dU2gHd0LZYLkcS812WIL2D3Bg+UZFslDA+v6f12ouHgPf0AAKRqRuF9UjGtJHtK
        QQwZr7U5U8BKExSZDh7DpoHtB9PGNQE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-544-C2Ht6tyKO-Gknfkj0UCP6Q-1; Wed, 09 Dec 2020 05:58:34 -0500
X-MC-Unique: C2Ht6tyKO-Gknfkj0UCP6Q-1
Received: by mail-wm1-f71.google.com with SMTP id f12so411069wmf.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 02:58:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=CgtH182QZzc921P4YWhD7Eorh+vwR+HI0Yw44CrRtXQ=;
        b=fwUFXS3DIyiaG71Jjj7rVKOqGIWYdEufJ/632Qo1ZaDvFGYMUMuaR94zUC6vG/2UM9
         0k6/NWGAW617Uw8wB1Igr9PCAXmoYKNKQ63AAStBMRhAoDwLxgctSRn7IGAZSsSCz3wT
         HxrMUFOA7gbRJy8utt3i9lZd6dHBqf7YaFZzLc2QNcnW6D7G1Re9E98cTZzN/gXHaQT0
         cpUspFEJLqvwaaAJBIWjsnIZR5RznooFcDb+jb2nJVSPhbx7HcksB2hYEOdU4nilGLcq
         oxI+G4gPc2lGRqz45hzWc4MzZwYuQgzgjHQbEj32SUtXVWZwqwThSXiR8kUyRb0GhXZM
         pn1Q==
X-Gm-Message-State: AOAM530YZ3M51t4FOjhPnNZiKXBEnbs4srvdlfixojECgEjtYsjfiTOE
        TAccHX83J7N9FeBAWD3mzXlcj9u4VegBQnpYudp9hkAi3L8dHS1XondAuu3GPRWxkCv13R7xc4e
        LGCi1ZyaJCKvkAHlEk0p/V4/F
X-Received: by 2002:a1c:f715:: with SMTP id v21mr2176959wmh.2.1607511513089;
        Wed, 09 Dec 2020 02:58:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJylVz5XgOq9GoSUV1WCVxh13tyn/JWweRYpU6YEyg62wzZGma1ZTEe30MQA34D+nNxhUwSVyQ==
X-Received: by 2002:a1c:f715:: with SMTP id v21mr2176936wmh.2.1607511512924;
        Wed, 09 Dec 2020 02:58:32 -0800 (PST)
Received: from steredhat (host-79-24-227-66.retail.telecomitalia.it. [79.24.227.66])
        by smtp.gmail.com with ESMTPSA id 35sm2621611wro.71.2020.12.09.02.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 02:58:32 -0800 (PST)
Date:   Wed, 9 Dec 2020 11:58:29 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, Oren Duer <oren@nvidia.com>,
        Laurent Vivier <lvivier@redhat.com>,
        linux-kernel@vger.kernel.org, Max Gurtovoy <mgurtovoy@nvidia.com>,
        Shahaf Shuler <shahafs@nvidia.com>, Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH v3 05/19] vdpa_sim: remove the limit of IOTLB entries
Message-ID: <20201209105829.6l6ie7xqp2eycds6@steredhat>
References: <20201203170511.216407-1-sgarzare@redhat.com>
 <20201203170511.216407-6-sgarzare@redhat.com>
 <d7b00b70-9785-db1f-1e42-7b9172b7ad90@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d7b00b70-9785-db1f-1e42-7b9172b7ad90@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 12:00:07PM +0800, Jason Wang wrote:
>
>On 2020/12/4 上午1:04, Stefano Garzarella wrote:
>>The simulated devices can support multiple queues, so this limit
>>should be defined according to the number of queues supported by
>>the device.
>>
>>Since we are in a simulator, let's simply remove that limit.
>>
>>Suggested-by: Jason Wang <jasowang@redhat.com>
>>Acked-by: Jason Wang <jasowang@redhat.com>
>>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>
>
>Rethink about this, since simulator can be used by VM, so the 
>allocation is actually guest trigger-able when vIOMMU is enabled.
>
>This means we need a limit somehow, (e.g I remember swiotlb is about 
>64MB by default). Or having a module parameter for this.
>
>Btw, have you met any issue when using 2048, I guess it can happen 
>when we run several processes in parallel?
>

No, I didn't try with the limit.
This came from the reviews to Max's patches.

Anyway I can add a module parameter to control that limit, do you think 
is better to set a limit per queue (the parameter per number of queues), 
or just a value for the entire device?

Thanks,
Stefano

