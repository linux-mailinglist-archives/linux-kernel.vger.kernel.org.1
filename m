Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59967277622
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 18:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbgIXQC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 12:02:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38372 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728537AbgIXQCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 12:02:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600963372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HjfyIqm+fMI2qwxuazO2r9o7hq0du7rjNYxWCh/yhH8=;
        b=GtUGW9q+zB9MgQZmrhRyJFX/kb1pme9TVP835tiFSQbMCzaXvpNOibvVaqP7HHoYYXNElU
        4FXwX77eBkJi6k6F6hU57R2nT32lsQw6YdtYRwIoA57ibkifHPZ2zaeRJdgJufgdMFPXwf
        hs77CLxAFkSaR7H95YPO8qWOhfANpAw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-92znUwHhNxePaQ1ahbyNVQ-1; Thu, 24 Sep 2020 12:02:50 -0400
X-MC-Unique: 92znUwHhNxePaQ1ahbyNVQ-1
Received: by mail-wr1-f72.google.com with SMTP id r16so1401141wrm.18
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 09:02:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HjfyIqm+fMI2qwxuazO2r9o7hq0du7rjNYxWCh/yhH8=;
        b=FtNBtoIZg/OyLek0aXEC+20jGvMCSqdsGsZZqZcUqsVDc/XLe8BusvIbt/YBoVKoDK
         qRg9vg7LavQQX3YAUiQpnWnIK8Bd5qHyv+Nj5v1710LzCDCpw93VFBiUQUrprRTcXXno
         SA/GRl0MxGktcvMQ3+Nq3woOSHbAHnvLnzPWMOpu7kMwWh7/z1+1xhU+ouzx4/2EphCu
         IMUSExoXhIt0XSozBWEHbb5XDYJfrWAT5yNi+XQnX/YGA8/aeXVt00HkPnx/oP6ONgWH
         yla4NJps2SdzuW/JQHfaLdl8Fx6zF8M3LUfsWyjDvK3tnaBzPDSKrOr0Y4SOHAYXXMwr
         OCYg==
X-Gm-Message-State: AOAM531jUPTX7m/Uhvm3AF0NpIegmBIIX9WICoSfVsj7e79oP/YZl2l9
        LvJXqXVRDlU1y//hd0+wcuy/VuTzIL9F3/9M2xq8fzdMMr4SW5eAvcU+xDvXxj5zgcAdQH57aP9
        MX3B8vGcq8rTjQrKhXWIODq3x
X-Received: by 2002:a1c:3985:: with SMTP id g127mr42195wma.32.1600963368764;
        Thu, 24 Sep 2020 09:02:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzCPrKe4Frc7EN7ceX89EofTC20FnVIrKVkqVACJHY7m+Y40fca3g0NY1X+dwbg7ouM3QMnaA==
X-Received: by 2002:a1c:3985:: with SMTP id g127mr42161wma.32.1600963368443;
        Thu, 24 Sep 2020 09:02:48 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
        by smtp.gmail.com with ESMTPSA id t6sm4065953wre.30.2020.09.24.09.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 09:02:47 -0700 (PDT)
Date:   Thu, 24 Sep 2020 12:02:43 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Eli Cohen <elic@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
        virtualization@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH v3 -next] vdpa: mlx5: change Kconfig depends to fix build
 errors
Message-ID: <20200924120217-mutt-send-email-mst@kernel.org>
References: <73f7e48b-8d16-6b20-07d3-41dee0e3d3bd@infradead.org>
 <20200918082245.GP869610@unreal>
 <20200924052932-mutt-send-email-mst@kernel.org>
 <20200924102413.GD170403@mtl-vdi-166.wap.labs.mlnx>
 <079c831e-214d-22c1-028e-05d84e3b7f04@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <079c831e-214d-22c1-028e-05d84e3b7f04@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 08:47:05AM -0700, Randy Dunlap wrote:
> On 9/24/20 3:24 AM, Eli Cohen wrote:
> > On Thu, Sep 24, 2020 at 05:30:55AM -0400, Michael S. Tsirkin wrote:
> >>>> --- linux-next-20200917.orig/drivers/vdpa/Kconfig
> >>>> +++ linux-next-20200917/drivers/vdpa/Kconfig
> >>>> @@ -31,7 +31,7 @@ config IFCVF
> >>>>
> >>>>  config MLX5_VDPA
> >>>>  	bool "MLX5 VDPA support library for ConnectX devices"
> >>>> -	depends on MLX5_CORE
> >>>> +	depends on VHOST_IOTLB && MLX5_CORE
> >>>>  	default n
> >>>
> >>> While we are here, can anyone who apply this patch delete the "default n" line?
> >>> It is by default "n".
> > 
> > I can do that
> > 
> >>>
> >>> Thanks
> >>
> >> Hmm other drivers select VHOST_IOTLB, why not do the same?
> 
> v1 used select, but Saeed requested use of depends instead because
> select can cause problems.
> 
> > I can't see another driver doing that. Perhaps I can set dependency on
> > VHOST which by itself depends on VHOST_IOTLB?
> >>
> >>
> >>>>  	help
> >>>>  	  Support library for Mellanox VDPA drivers. Provides code that is
> >>>>
> >>
> 

Saeed what kind of problems? It's used with select in other places,
isn't it?

> -- 
> ~Randy

