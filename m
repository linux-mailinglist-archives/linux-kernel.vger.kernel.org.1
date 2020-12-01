Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 391B82CAE57
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 22:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbgLAVZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 16:25:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:48298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbgLAVZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 16:25:32 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AC1020870;
        Tue,  1 Dec 2020 21:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1606857892;
        bh=a8TmdnafpKPz2vYTHBuzMrTq/A5YQubPVsJ7OheAx+8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Je8esLdICMSn6zhB2GK75o97wv3RooQh62AkF+yT2slmCk1PlyCMzz3C8Wz4BwZAa
         mSdu3CuUqKg+jom1EqryCwUjSorsizbVazjwNiVeWiayKII9VfCSV9tat1UuOjAt2K
         LX3gsFmaAiw0Bf6jy7KtdexbawJHGMxs+C+i6eRg=
Date:   Tue, 1 Dec 2020 22:26:03 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Zou Wei <zou_wei@huawei.com>, rajan.vaja@xilinx.com,
        jolly.shah@xilinx.com, tejas.patel@xilinx.com,
        manish.narani@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v2] firmware: xilinx: Mark pm_api_features_map with
 static keyword
Message-ID: <X8a067jdynVt3Lvg@kroah.com>
References: <1606823513-121578-1-git-send-email-zou_wei@huawei.com>
 <65ea30eb-2595-4af8-09c2-6d352b9be509@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65ea30eb-2595-4af8-09c2-6d352b9be509@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 01:03:59PM +0100, Michal Simek wrote:
> 
> 
> On 01. 12. 20 12:51, Zou Wei wrote:
> > Fix the following sparse warning:
> > 
> > drivers/firmware/xilinx/zynqmp.c:32:1: warning: symbol 'pm_api_features_map' was not declared. Should it be static?
> > 
> > Signed-off-by: Zou Wei <zou_wei@huawei.com>
> > ---
> >  drivers/firmware/xilinx/zynqmp.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> > index d08ac82..fd95ede 100644
> > --- a/drivers/firmware/xilinx/zynqmp.c
> > +++ b/drivers/firmware/xilinx/zynqmp.c
> > @@ -29,7 +29,7 @@
> >  #define PM_API_FEATURE_CHECK_MAX_ORDER  7
> >  
> >  static bool feature_check_enabled;
> > -DEFINE_HASHTABLE(pm_api_features_map, PM_API_FEATURE_CHECK_MAX_ORDER);
> > +static DEFINE_HASHTABLE(pm_api_features_map, PM_API_FEATURE_CHECK_MAX_ORDER);
> >  
> >  /**
> >   * struct pm_api_feature_data - PM API Feature data
> > 
> 
> The patch is good but I am missing fixed tag to get it to LTS.

Why is this needed for any stable kernel release?  It's a sparse
warning, no one trips across those in stable kernels...

thanks,

greg k-h
