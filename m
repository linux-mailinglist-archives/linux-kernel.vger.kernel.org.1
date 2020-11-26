Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84C4C2C5A71
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 18:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404403AbgKZRVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 12:21:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:55258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404388AbgKZRVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 12:21:40 -0500
Received: from localhost (82-217-20-185.cable.dynamic.v4.ziggo.nl [82.217.20.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECD4A206CA;
        Thu, 26 Nov 2020 17:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1606411298;
        bh=Ntq+SdXSf7E3TCJQBlO1tASYt8vXBVEvZQrdeacnTUs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oKhrIZaOTG1bjb/Xgt80ddDzBmnlWDDnK9TnSQR6CpMq2MneYkXy9Uwr3frOIRn8D
         SCfU2HmqtJPC+TUNxV47pRKd+MlGxQBH4omYnzB+5KEpJu6OkwUrEloYRi5zddT2uT
         U8Ckx+qZe2QZkhzcYVK05sBWoMX1/LfVfNwAYsqk=
Date:   Thu, 26 Nov 2020 18:21:33 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chanho Park <parkch98@gmail.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>
Subject: Re: [PATCH] drivers core: export symbols for device hotplug
Message-ID: <X7/kHYpgmRZ6Lwhm@kroah.com>
References: <20201126150138.159896-1-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126150138.159896-1-chanho61.park@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 27, 2020 at 12:01:38AM +0900, Chanho Park wrote:
> To support module build for cpu hotplug driver on type-1 hypervisor
> such as drivers/xen/cpu_hotplug.c, we need to export below four symbols.
> 
> lock_device_hotplug / unlock_device_hotplug
> device_online / device_offline
> 
> Signed-off-by: Chanho Park <chanho61.park@samsung.com>
> ---
>  drivers/base/core.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index d661ada1518f..1bfd0c54a778 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -1586,11 +1586,13 @@ void lock_device_hotplug(void)
>  {
>  	mutex_lock(&device_hotplug_lock);
>  }
> +EXPORT_SYMBOL_GPL(lock_device_hotplug);

Ick, really?  Anyway, where is the follow-on patch that uses this in a
module?  We need that in order to export these otherwise we will just
un-export them with no in-kernel users.

thanks,

greg k-h
