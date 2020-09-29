Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6723127BE5A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 09:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbgI2HsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 03:48:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52188 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725774AbgI2HsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 03:48:07 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601365686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8xO7rZy5t133U8JIyK4JzoQDnu4pz1aGJERQ/woAzd8=;
        b=Wk2EeMrFjSuzNCsB1QhjRVI4H/X4sLt0kQ181LeDpIU1TD1BJwW5LJ/HeZ8Jr4b7Sj60sB
        52dlehXltzBHtGWfyc2xMuXpiGHHMlJeK+krhHRGv5NGPSIkG1g7auu70KBT9kA0BaLIlP
        7Jycih53fMJOCDWYisKM5FKwgLtvacw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-A-q09_GuMY28IAoHCtK7Ew-1; Tue, 29 Sep 2020 03:48:03 -0400
X-MC-Unique: A-q09_GuMY28IAoHCtK7Ew-1
Received: by mail-wr1-f70.google.com with SMTP id s8so1379566wrb.15
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 00:48:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8xO7rZy5t133U8JIyK4JzoQDnu4pz1aGJERQ/woAzd8=;
        b=RnlmLhooRN+WudcYTr8HQfIPtQZHBtRii3qkc1YrYvd+dD2vanKCcVFEt54y8InG/l
         +ZcK4VQBB/8S/ycADDjkPwGpD9/q7gqJPpLFQhQ7SCkrwBxWy247Befp0nnunbeHB++e
         7tUk5bpttYCYyhRtP6MK6Ss1fu6MY3cDudo/FihZ9wo89jkpovE3vKJGkvZSYKwObplx
         XTVO7soHYlyA4qJvZR5ZwRu4s3RZiLjSU4ouKNuCcnJNBH2wKEUzjTGpDFgNiiHAP0ME
         bxCRJIw5iWm5cByja67uunVYV0uKllL9nQBYsUz9H4kLG7jm4z1RNFz3lNqAY1iSm9la
         m5Qw==
X-Gm-Message-State: AOAM532Ph+6A+Obz7wlHY+D33FU/oBm9VSV8iDx98vpTxVsJiDebRqI0
        GbRDNmStH4SXpnwE8rJpcS633dt8D1v7/b7cgSMScC9nYzIPC3MzH2aocDJKRNAIOiNAuI3YP8L
        qzr8Arkg1O1rrnyP5M4NTsX4R
X-Received: by 2002:a1c:6a11:: with SMTP id f17mr2845848wmc.143.1601365682572;
        Tue, 29 Sep 2020 00:48:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzy9cvP6BH1Mw0CQeNnVZeFoeM27Cd6X6OrMih1YP8wEj9eAKG/lzVukmjjG2bhZg1Xt9CE+Q==
X-Received: by 2002:a1c:6a11:: with SMTP id f17mr2845808wmc.143.1601365681993;
        Tue, 29 Sep 2020 00:48:01 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
        by smtp.gmail.com with ESMTPSA id 70sm4346876wme.15.2020.09.29.00.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 00:48:01 -0700 (PDT)
Date:   Tue, 29 Sep 2020 03:47:58 -0400
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
Message-ID: <20200929034636-mutt-send-email-mst@kernel.org>
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

OK I went over the history. v1 selected VHOST, that as the issue I think.
A later version switched to VHOST_IOTLB, that is ok to select.

> > I can't see another driver doing that. Perhaps I can set dependency on
> > VHOST which by itself depends on VHOST_IOTLB?
> >>
> >>
> >>>>  	help
> >>>>  	  Support library for Mellanox VDPA drivers. Provides code that is
> >>>>
> >>
> 
> 
> -- 
> ~Randy

