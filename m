Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 369CB2BAC0B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 15:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbgKTOlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 09:41:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46346 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727897AbgKTOlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 09:41:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605883274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O1lkgsCtAW9gay4nzrsgpJCYCXHG/gdOfQ5aoMkR6+I=;
        b=TUkGMczl366J9djoxklEC+y+r3wfAu92vtP3RlKShEWi58kTYJS3em/FiSm0Lipgu9EcCI
        ll2SHsHYF+gPBhqCoD0j5vmjSSKNI8dRejlgcS2DKojY8MymGMn4rfELziXIBSMbCSlno/
        AALheBiPuFWP70zryjgjDKbK8VTwWq4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-531-aBXpNp_wNF2CFcvwAk-v3A-1; Fri, 20 Nov 2020 09:41:12 -0500
X-MC-Unique: aBXpNp_wNF2CFcvwAk-v3A-1
Received: by mail-wr1-f69.google.com with SMTP id l5so3457858wrn.18
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 06:41:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O1lkgsCtAW9gay4nzrsgpJCYCXHG/gdOfQ5aoMkR6+I=;
        b=Su7EEZDHuY+iUqL/jvR55zVZDmv8a/WCOi3Uoz1t/g7eASWnYJ8GP5/RXnbkM/E3QP
         oQ9xMpOcc+fDSVRhRnlSO78gTe8Be3bdGmusAPNdn7agk++fke6Ja8zpwbpeQq/c3zLF
         0EqWEPbVavIO3/eZRl2hbX/a0iBNT35fGFYV2UP7h4hake3GfhzWfFtrIKSEFGmLdLnT
         6Lr9XsF45khE/sYmhn5k/IZL9Z2/RTHEvgAwYAH6umOiUCWbgqdHj1qHBCDVk+/Avaw7
         qwTqESiYadWZHj4zo9mb/Zqrnyn4F2kiK++doB//DQlAaXNe2gNHBfDr1ivtdmIwTxjv
         9u9A==
X-Gm-Message-State: AOAM5307+9OdPPVeqAzZKzFXas8XpQ1rVorqqk6ASosJcGWf+qg9GZ7R
        gx1dUyHCakvHSuqlL+Xr3Y/Yts9gFr6eCCzm4KtKR1ytbAkhdqI4yx/p5L02443amAKXP3Ifqma
        TjZzyysmoEtOibuKRpac/IaY0
X-Received: by 2002:adf:f181:: with SMTP id h1mr15982313wro.267.1605883271029;
        Fri, 20 Nov 2020 06:41:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxEZQejCgLFVrq6q+ujHyBd46vdktdOw4jy0hWO52Dab1yBLPrKbw2vTOTtv2NCzaReoRni8w==
X-Received: by 2002:adf:f181:: with SMTP id h1mr15982290wro.267.1605883270766;
        Fri, 20 Nov 2020 06:41:10 -0800 (PST)
Received: from steredhat (host-79-17-248-175.retail.telecomitalia.it. [79.17.248.175])
        by smtp.gmail.com with ESMTPSA id k64sm4598406wmb.11.2020.11.20.06.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 06:41:10 -0800 (PST)
Date:   Fri, 20 Nov 2020 15:41:07 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        Laurent Vivier <lvivier@redhat.com>,
        linux-kernel@vger.kernel.org, Eli Cohen <elic@nvidia.com>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH RFC 10/12] vdpa_sim: split vdpasim_virtqueue's iov field
 in riov and wiov
Message-ID: <20201120144107.hlpkkrjdvjhvuxma@steredhat>
References: <20201113134712.69744-1-sgarzare@redhat.com>
 <20201113134712.69744-11-sgarzare@redhat.com>
 <20201117112703.GF131917@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201117112703.GF131917@stefanha-x1.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 11:27:03AM +0000, Stefan Hajnoczi wrote:
>On Fri, Nov 13, 2020 at 02:47:10PM +0100, Stefano Garzarella wrote:
>> vringh_getdesc_iotlb() manages 2 iovs for writable and readable
>> descriptors. This is very useful for the block device, where for
>> each request we have both types of descriptor.
>>
>> Let's split the vdpasim_virtqueue's iov field in riov and wiov
>> to use them with vringh_getdesc_iotlb().
>
>Is riov/wiov naming common? VIRTIO uses "in" (device-to-driver) and
>"out" (driver-to-device). Using VIRTIO terminology might be clearer.

I followed the vringh_getdesc_iotlb() attribute names, but I agree that 
"in" and "out" would be better. I lost multiple times with read/write...

I'll fix!

Thanks,
Stefano

