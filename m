Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFF9275662
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 12:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgIWKbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 06:31:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:53940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726419AbgIWKba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 06:31:30 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA8BA20C56;
        Wed, 23 Sep 2020 10:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600857090;
        bh=LWSvDR9lFDlLJfxRInCbfAQl5Wyo0uA+EsI/NgHdtew=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PpMb6o+xcCBhOWFuDyndXFsO47dUy4mGoVbD8Uj6Yt2p4SmJAoh0mU2BzEf7kzYCM
         uPG6a4sBEVmbQDvK7kWRsX0c4NECghaHBjpQx9WhByIyWfxdcGdd28YBlK2E84D4g/
         3aOgNTu8sJlHmQZV8Ha6ElBkz64izzjG/ZW3zoY8=
Date:   Wed, 23 Sep 2020 12:31:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     johannes@sipsolutions.net, rafael@kernel.org,
        keescook@chromium.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 04/11] drivers/base/devcoredump: convert devcd_count
 to counter_atomic
Message-ID: <20200923103149.GH3154647@kroah.com>
References: <cover.1600816121.git.skhan@linuxfoundation.org>
 <651bc1a1e1cbf5e2a1b9f60118d5c163b93eeb43.1600816121.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <651bc1a1e1cbf5e2a1b9f60118d5c163b93eeb43.1600816121.git.skhan@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 07:43:33PM -0600, Shuah Khan wrote:
> counter_atomic is introduced to be used when a variable is used as
> a simple counter and doesn't guard object lifetimes. This clearly
> differentiates atomic_t usages that guard object lifetimes.
> 
> counter_atomic variables will wrap around to 0 when it overflows and
> should not be used to guard resource lifetimes, device usage and
> open counts that control state changes, and pm states.
> 
> devcd_count is used to track dev_coredumpm device count and used in
> device name string. It doesn't guard object lifetimes, device usage
> counts, device open counts, and pm states. There is very little chance
> of this counter overflowing. Convert it to use counter_atomic.
> 
> This conversion doesn't change the oveflow wrap around behavior.
> 
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
>  drivers/base/devcoredump.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
> index e42d0b514384..d719424d1e0b 100644
> --- a/drivers/base/devcoredump.c
> +++ b/drivers/base/devcoredump.c
> @@ -16,6 +16,7 @@
>  #include <linux/slab.h>
>  #include <linux/fs.h>
>  #include <linux/workqueue.h>
> +#include <linux/counters.h>
>  
>  static struct class devcd_class;
>  
> @@ -255,7 +256,7 @@ void dev_coredumpm(struct device *dev, struct module *owner,
>  				   void *data, size_t datalen),
>  		   void (*free)(void *data))
>  {
> -	static atomic_t devcd_count = ATOMIC_INIT(0);
> +	static struct counter_atomic devcd_count = COUNTER_ATOMIC_INIT(0);
>  	struct devcd_entry *devcd;
>  	struct device *existing;
>  
> @@ -286,7 +287,7 @@ void dev_coredumpm(struct device *dev, struct module *owner,
>  	device_initialize(&devcd->devcd_dev);
>  
>  	dev_set_name(&devcd->devcd_dev, "devcd%d",
> -		     atomic_inc_return(&devcd_count));
> +		     counter_atomic_inc_return(&devcd_count));
>  	devcd->devcd_dev.class = &devcd_class;
>  
>  	if (device_add(&devcd->devcd_dev))
> -- 
> 2.25.1
> 

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
