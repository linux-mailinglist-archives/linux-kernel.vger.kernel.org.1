Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B795276D7F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 11:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgIXJbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 05:31:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25095 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726185AbgIXJbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 05:31:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600939862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4Cn5Bd+L14KVOkBy3I0zvESfB5G1klOhcdE8jhSzxAk=;
        b=NbHKp+70R7aVHTKadrGNKMo8rpprlxwoxnzYrZ+UKl3TEEw3r8bKeKvFjEaM979a/Wfyx9
        QYI9wmJsgv6KOndv8Ir46+Ibz3SoEfJtrIklx+0nJwii/+dLOPPgSRcTh/hiOu3YA3/0xT
        AtKvm53CtfuEo0KiEia3AjjGWJiFlYM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-fHaSojn_P-O1Se7jBOlnrg-1; Thu, 24 Sep 2020 05:31:01 -0400
X-MC-Unique: fHaSojn_P-O1Se7jBOlnrg-1
Received: by mail-wr1-f71.google.com with SMTP id b2so997175wrs.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 02:31:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4Cn5Bd+L14KVOkBy3I0zvESfB5G1klOhcdE8jhSzxAk=;
        b=Vxaq8l4oIji5L4K7bQVin3LS4LTK9uX4p0S6NSeO/31vIfD0pWOsJ71o81EalNqpJw
         629M/joywG1Vi/K/Js5ZDxa2Z0V5mp/lvrvXH7BRs1+Qd/D66JXKngTf+8FJNw/9ace4
         FI1w6TaQHFIRM1AWoWEs7/gk816DKyv+spRo8It7oft7VLBrPN/As2bWH+Wy506LzXUs
         kw5JYjjg7dpivJH5B8Smser0fotlyx0/OlsUHGjdL5yImzARjVQMjIWFfoZr4Xd3hwPD
         EBd9p6wCuMhCFqNpCJh/QIeSJbPXV2adDJb3xZgBeiLReEETlPBsxA2FNRulfrmOxZTG
         wTvw==
X-Gm-Message-State: AOAM5300KXflR3iI8v6uxdUr9kXLovl56y2R/A+Gu0MRE4uDmwp65C5d
        qLIvEXXa6MKIxwD22BYP2p7F0uK+7ZnXYc1AGLMY+Nva2rm6ipcgRZTGSsIVVPvcCivyV7GfcCp
        MBt1uDdgUryvGh0nI9VG/m/mx
X-Received: by 2002:adf:dfc9:: with SMTP id q9mr4019265wrn.400.1600939859786;
        Thu, 24 Sep 2020 02:30:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyzNr9iTqIQuESzVSCPAV8Mwoq5mFq1pIRj7KbtcjUI1Z0WuhkhVRABCz6hVxbGoGui7GYmBg==
X-Received: by 2002:adf:dfc9:: with SMTP id q9mr4019248wrn.400.1600939859611;
        Thu, 24 Sep 2020 02:30:59 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
        by smtp.gmail.com with ESMTPSA id p11sm2641023wma.11.2020.09.24.02.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 02:30:58 -0700 (PDT)
Date:   Thu, 24 Sep 2020 05:30:55 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Leon Romanovsky <leonro@nvidia.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        virtualization@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        Saeed Mahameed <saeedm@nvidia.com>, Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH v3 -next] vdpa: mlx5: change Kconfig depends to fix build
 errors
Message-ID: <20200924052932-mutt-send-email-mst@kernel.org>
References: <73f7e48b-8d16-6b20-07d3-41dee0e3d3bd@infradead.org>
 <20200918082245.GP869610@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918082245.GP869610@unreal>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 11:22:45AM +0300, Leon Romanovsky wrote:
> On Thu, Sep 17, 2020 at 07:35:03PM -0700, Randy Dunlap wrote:
> > From: Randy Dunlap <rdunlap@infradead.org>
> >
> > drivers/vdpa/mlx5/ uses vhost_iotlb*() interfaces, so add a dependency
> > on VHOST to eliminate build errors.
> >
> > ld: drivers/vdpa/mlx5/core/mr.o: in function `add_direct_chain':
> > mr.c:(.text+0x106): undefined reference to `vhost_iotlb_itree_first'
> > ld: mr.c:(.text+0x1cf): undefined reference to `vhost_iotlb_itree_next'
> > ld: mr.c:(.text+0x30d): undefined reference to `vhost_iotlb_itree_first'
> > ld: mr.c:(.text+0x3e8): undefined reference to `vhost_iotlb_itree_next'
> > ld: drivers/vdpa/mlx5/core/mr.o: in function `_mlx5_vdpa_create_mr':
> > mr.c:(.text+0x908): undefined reference to `vhost_iotlb_itree_first'
> > ld: mr.c:(.text+0x9e6): undefined reference to `vhost_iotlb_itree_next'
> > ld: drivers/vdpa/mlx5/core/mr.o: in function `mlx5_vdpa_handle_set_map':
> > mr.c:(.text+0xf1d): undefined reference to `vhost_iotlb_itree_first'
> >
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > Cc: Jason Wang <jasowang@redhat.com>
> > Cc: virtualization@lists.linux-foundation.org
> > Cc: Saeed Mahameed <saeedm@nvidia.com>
> > Cc: Leon Romanovsky <leonro@nvidia.com>
> > Cc: netdev@vger.kernel.org
> > ---
> > v2: change from select to depends on VHOST (Saeed)
> > v3: change to depends on VHOST_IOTLB (Jason)
> >
> >  drivers/vdpa/Kconfig |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > --- linux-next-20200917.orig/drivers/vdpa/Kconfig
> > +++ linux-next-20200917/drivers/vdpa/Kconfig
> > @@ -31,7 +31,7 @@ config IFCVF
> >
> >  config MLX5_VDPA
> >  	bool "MLX5 VDPA support library for ConnectX devices"
> > -	depends on MLX5_CORE
> > +	depends on VHOST_IOTLB && MLX5_CORE
> >  	default n
> 
> While we are here, can anyone who apply this patch delete the "default n" line?
> It is by default "n".
> 
> Thanks

Hmm other drivers select VHOST_IOTLB, why not do the same?


> >  	help
> >  	  Support library for Mellanox VDPA drivers. Provides code that is
> >

