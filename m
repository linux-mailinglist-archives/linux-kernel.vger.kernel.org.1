Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74A3B2C5811
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 16:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391329AbgKZPY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 10:24:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48433 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391322AbgKZPY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 10:24:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606404293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=os+Q+Blp9HyEuGcQTO6G5ktoOsiuGVlsUvHpEhOMdh8=;
        b=XOy/XDKRmrIwQ6MT0/uPoTbk9BKXpVRj8ngzWnOwwbhrjG3H5opELpPSW0NpSl7v8JH+PY
        JhKWF2HWyEdx3PdfdKB2fQQpxvU1n0vS7uQzmodG+EoNSDSW2kCn8LN7ZJtq6XG8MNNIjW
        Et0RGvVdMxKtDQaPisUOIDVFtez5TrY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-pNS2itOCPjGoDZ6o4cT49w-1; Thu, 26 Nov 2020 10:24:51 -0500
X-MC-Unique: pNS2itOCPjGoDZ6o4cT49w-1
Received: by mail-wr1-f70.google.com with SMTP id 91so1435534wrk.17
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 07:24:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=os+Q+Blp9HyEuGcQTO6G5ktoOsiuGVlsUvHpEhOMdh8=;
        b=L1DoRXCotzLdkW1WjVxe6coh2ygResN2WOmOa1La3asWjssxksTmpNaZV3FYJAFfGL
         rcGJNpdYmHz6Yss67no0Ktn3q232RoREZN8SQgatLr/kVD0aP7uqlYtsTVOy81TYmS1S
         Ti2hvWfIzQYCuNgl0HlTRo+OIeErRZuHKaLOlcsD7WXmjDGgYhmVt6PZgxA3UKRHLN+H
         Gk7WzbQ5eoybZOGSeQ2XWmFm8wnIojygO6np5oyJAtDHwnbpDNncCfrR5PnvI2s14bOK
         aRXXF+vMHk1btYkj2cszQd+ELahSJMQ3tgzPu+rOtMauIgM7lzMzGXFFK6q81eLEJ4zc
         sLYQ==
X-Gm-Message-State: AOAM531vLSmsgqNPH40Ub84cFW5dL95IFV7ARsvN+fpkuZMjiQCPapUX
        97ZzLHxsxNHuvbzbAgJhoKyWG4RueXFa9Q7xxm5Vx9b3E6xbaoyAUbA0tbLlkq5Z47xvrJq1fGo
        ZGfkWLBxEwvCNy6ItgDyFEUIr
X-Received: by 2002:a1c:ddc4:: with SMTP id u187mr3993217wmg.55.1606404289360;
        Thu, 26 Nov 2020 07:24:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz9OI6f7Ith7j2DJeW7ukSH/WzE5q8wUVem/TW5/l5aphxSgk/jB9dGYbJEH7CwzfT2T2xyeA==
X-Received: by 2002:a1c:ddc4:: with SMTP id u187mr3993197wmg.55.1606404289170;
        Thu, 26 Nov 2020 07:24:49 -0800 (PST)
Received: from steredhat (host-79-17-248-175.retail.telecomitalia.it. [79.17.248.175])
        by smtp.gmail.com with ESMTPSA id b14sm9723294wrx.35.2020.11.26.07.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 07:24:48 -0800 (PST)
Date:   Thu, 26 Nov 2020 16:24:46 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     virtualization@lists.linux-foundation.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-kernel@vger.kernel.org, Laurent Vivier <lvivier@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, Eli Cohen <elic@nvidia.com>,
        Jason Wang <jasowang@redhat.com>, Oren Duer <oren@nvidia.com>,
        Shahaf Shuler <shahafs@nvidia.com>
Subject: Re: [PATCH v2 00/17] vdpa: generalize vdpa simulator
Message-ID: <20201126152446.lvf2db2u5crtv2ep@steredhat>
References: <20201126144950.92850-1-sgarzare@redhat.com>
 <751e8938-8055-511c-c339-2b55dc902944@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <751e8938-8055-511c-c339-2b55dc902944@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 05:12:30PM +0200, Max Gurtovoy wrote:
>
>On 11/26/2020 4:49 PM, Stefano Garzarella wrote:
>>This series moves the network device simulator in a new module
>>(vdpa_sim_net) and leaves the generic functions in the vdpa_sim core
>>module, allowing the possibility to add new vDPA device simulators.
>>
>>For now I removed the vdpa-blk simulator patches, since I'm still working
>>on them and debugging the iotlb issues.
>>
>>Thanks to Max that started this work! I took his patches and extended a bit.
>>
>>As Jason suggested, I simplified the "vdpa: split vdpasim to core and
>>net modules" patch, moving some changes out in small patches.
>>@Max: I put your Co-developed-by and Signed-off-by tags on these patches,
>>let me know if it is okay for you, or if there is a better way to give
>>credit to your work!
>
>Stefano,
>
>thanks for taking my initial series and bringing it to upstream level 
>and thanks Jason for your reviews.
>
>I'm ok with the tags and hopefully I'll be able to help a bit in the 
>submission in couple of weeks.

Great! :-)
I'll keep you updated.

>
>great progress !

Thanks,
Stefano

