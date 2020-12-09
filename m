Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64DFB2D4C62
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 22:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgLIVBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 16:01:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbgLIVBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 16:01:52 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889B9C061794
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 13:01:12 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id b9so2060764qtr.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 13:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ExCyT+SCyEhlsRTDkdqpqOCI/2LqGwYMywiKe/9st7A=;
        b=NurNnQGxxSkfZQjGs80r0MdCe57Y8YszlEuoc2elRd+DXWUpnANMlVzzuNTwPH+FN+
         zrqk3CEFeTymZ/WhIRsmc63GudmjGSnyxwYmWSoC7rKyY2wzMZjlz/CVmZBX/VJJMIz3
         +V7G4VxJctuBUoEtBaHlhidY8aE2WRrnpXG+GwJRVVqPfdFowfLmuJm1T6YkWhhmQCVx
         7ZZCzoKpifkSTMUHpgTPNtkx7asho6Ik5kc1O3GeQRJUvA7miROIB2zSIeCZSCS+pDTA
         hyyaBCcccsB9P998NCm428ljTqSZ0zroaXp50HK7VLiXfGKPXTaFmUK1acRBz1R7/fq3
         Jw7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ExCyT+SCyEhlsRTDkdqpqOCI/2LqGwYMywiKe/9st7A=;
        b=NCJz6/3yuoQ7E3PfD6PHqf6PX+/SSz1dS7wXYsIrdiuqw6T58DR1chS8yUDur/GTcX
         IlzXCdwR5nuLcIdZWuYnAwsRgqPYd9YFO+gbAJJqtG0aVhnW8gO6MK3sMD1KNGcyXSxV
         hDmb7PT+axokg3Bpx6cCwM6Me+wjvhU8hPIRS/a7BRZHGj/zp7Pjk+suBqzWrTWu17oo
         gW4Q9tzcVBY1xA9XvMx4DF0u3+boL/7B8ewh1QRxmDtwNuaZs4HOvdoaI9Yt3inXNWdi
         SjKgiAKN++oKEN8XyMVAnKZLshIFwfXxnJzONUhh7bEIejaxQL3QIjZMm9HKpkP6TkdO
         G8Sw==
X-Gm-Message-State: AOAM533dxnELWdjRG0erffqMAAatZeMc7wmbwFAnxc6fW5FfIoiKh/Cs
        xEuu2CjvjuDpAZnSWns2IKZ/0g==
X-Google-Smtp-Source: ABdhPJyXjhK+L8ctOi5c31cd5zlhIMw/LoMHFxPJanVLeUpnUks4dOAQNYla3t3nAPX+6am0z/Nk+g==
X-Received: by 2002:aed:2ba5:: with SMTP id e34mr5353832qtd.146.1607547671626;
        Wed, 09 Dec 2020 13:01:11 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id y9sm1914394qtm.96.2020.12.09.13.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 13:01:10 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kn6aD-008OUf-U6; Wed, 09 Dec 2020 17:01:09 -0400
Date:   Wed, 9 Dec 2020 17:01:09 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Leon Romanovsky <leon@kernel.org>, Zou Wei <zou_wei@huawei.com>,
        saeedm@nvidia.com, davem@davemloft.net, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] net/mlx5_core: remove unused including
 <generated/utsrelease.h>
Message-ID: <20201209210109.GX5487@ziepe.ca>
References: <1607343240-39155-1-git-send-email-zou_wei@huawei.com>
 <20201208112226.1bb31229@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
 <20201209062100.GK4430@unreal>
 <20201209090446.7daadd13@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209090446.7daadd13@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 09:04:46AM -0800, Jakub Kicinski wrote:
> On Wed, 9 Dec 2020 08:21:00 +0200 Leon Romanovsky wrote:
> > On Tue, Dec 08, 2020 at 11:22:26AM -0800, Jakub Kicinski wrote:
> > > On Mon, 7 Dec 2020 20:14:00 +0800 Zou Wei wrote:  
> > > > Remove including <generated/utsrelease.h> that don't need it.
> > > >
> > > > Signed-off-by: Zou Wei <zou_wei@huawei.com>
> > > >  drivers/net/ethernet/mellanox/mlx5/core/en_rep.c | 1 -
> > > >  1 file changed, 1 deletion(-)
> > > >
> > > > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
> > > > index 989c70c..82ecc161 100644
> > > > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
> > > > @@ -30,7 +30,6 @@
> > > >   * SOFTWARE.
> > > >   */
> > > >
> > > > -#include <generated/utsrelease.h>
> > > >  #include <linux/mlx5/fs.h>
> > > >  #include <net/switchdev.h>
> > > >  #include <net/pkt_cls.h>  
> > 
> > Jakub,
> > 
> > You probably doesn't have latest net-next.
> > 
> > In the commit 17a7612b99e6 ("net/mlx5_core: Clean driver version and
> > name"), I removed "strlcpy(drvinfo->version, UTS_RELEASE,
> > sizeof(drvinfo->version));" line.
> > 
> > The patch is ok, but should have Fixes line.
> > Fixes: 17a7612b99e6 ("net/mlx5_core: Clean driver version and name")
> 
> Hm. Pretty sure our build bot gets a fresh copy before testing. 
> Must had been some timing issue, perhaps? Looks like the commit
> came in with the auxbus merge.

mlx5-next is in linux-next independently so people will be sending
fixes against stuff in linux-next before it hits net-next.

Jason
