Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12CEB2FCCFB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 09:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbhATIyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 03:54:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35051 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725320AbhATIxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 03:53:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611132729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d4UnMNibyh8PbpucVHsdwUM+5SKhACPpSJYaybcE7KM=;
        b=T6JKHaLbyD2oh1YX+hrZviFx1PRA74Bt3ZWStHfuTttBMkAOF+1IRFH1vMoz6s3jShDWGE
        3aqE1ZHd+w3NHC8PrugH0a6n6c2gwibQVN96QsMu53p+TtQpHwWcy1GRuU62cHkspPCeMr
        +3q8HoB4gPPRD5IUkaZ01Lq8S88aLQo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-KPFHsB6EMGCBVxLiR_e4lQ-1; Wed, 20 Jan 2021 03:52:04 -0500
X-MC-Unique: KPFHsB6EMGCBVxLiR_e4lQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5so365410wmq.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 00:52:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d4UnMNibyh8PbpucVHsdwUM+5SKhACPpSJYaybcE7KM=;
        b=c1n8+Kq/6oQbPDVt7FFAFq41PXsG3MfapEkLOi3vI/4mb7kCDfuTVScj29OeeNvw31
         6VuvqmCEmOLFj2GHRsx5S4hti+V3jVeYNjDToFGIH8RGXM4w110u4sDsxI6/vYfTSWwB
         U6BvEMMwnz+1FOVcrgxNO96+95b+CnNEz7Ka6clEkgmGBnfRaRSLlAKkfTM306sJSqjG
         nRI8CWEX8VZeXBtrfDPqG1sHS9tbnXIdUEU/tLvQmrJziPwEjrfKCe3wyy3JDOZmV7ay
         CYzukYqdrBjhm0IOW8f0n5ZwXPkK6eiB8nlMsDntMknrCtz5fcYr6d7pbXQwCjAeLtJn
         2q4g==
X-Gm-Message-State: AOAM530u03uUXif0WDNqCHxk30Vb7vu16hY8jpDxPT2TglUVG9tTY/Gn
        LcyQaeJWR433YNpVO8hJcTpy2njp2kn8DaTM0hq87nHDhlmecrKSKfkKGr5bcQi7pSgVmvt3//4
        zpuhlsjxx/BTab4Qam6QIaXgM
X-Received: by 2002:a1c:7f8c:: with SMTP id a134mr3287574wmd.184.1611132723753;
        Wed, 20 Jan 2021 00:52:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy9HHKjWFC7iPFhp5YFU8NaoWOBXnOXFOBmJKdJIiIKgWhVdaqgHhBEeVM6yYHYdkW+3705MQ==
X-Received: by 2002:a1c:7f8c:: with SMTP id a134mr3287561wmd.184.1611132723632;
        Wed, 20 Jan 2021 00:52:03 -0800 (PST)
Received: from redhat.com (bzq-79-177-39-148.red.bezeqint.net. [79.177.39.148])
        by smtp.gmail.com with ESMTPSA id w23sm2532766wmi.13.2021.01.20.00.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 00:52:03 -0800 (PST)
Date:   Wed, 20 Jan 2021 03:52:00 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eli Cohen <elic@nvidia.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, lulu@redhat.com
Subject: Re: [PATCH v1] vdpa/mlx5: Fix memory key MTT population
Message-ID: <20210120035031-mutt-send-email-mst@kernel.org>
References: <20210107071845.GA224876@mtl-vdi-166.wap.labs.mlnx>
 <07d336a3-7fc2-5e4a-667a-495b5bb755da@redhat.com>
 <20210120053619.GA126435@mtl-vdi-166.wap.labs.mlnx>
 <20210120025651-mutt-send-email-mst@kernel.org>
 <20210120081154.GA132136@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120081154.GA132136@mtl-vdi-166.wap.labs.mlnx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 10:11:54AM +0200, Eli Cohen wrote:
> On Wed, Jan 20, 2021 at 02:57:05AM -0500, Michael S. Tsirkin wrote:
> > On Wed, Jan 20, 2021 at 07:36:19AM +0200, Eli Cohen wrote:
> > > On Fri, Jan 08, 2021 at 04:38:55PM +0800, Jason Wang wrote:
> > > 
> > > Hi Michael,
> > > this patch is a fix. Are you going to merge it?
> > 
> > yes - in the next pull request.
> > 
> 
> Great thanks.
> Can you send the path to your git tree where you keep the patches you
> intend to merge?

https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next

Note I often rebase it (e.g. just did).

-- 
MST

