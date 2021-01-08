Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8172EF3AE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 15:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbhAHOGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 09:06:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:43182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbhAHOGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 09:06:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6804B22A99;
        Fri,  8 Jan 2021 14:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610114761;
        bh=3jX5hXs7jiG9pGlKdnhF/TF5Ic2HHIzfttWP/hld82Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q9G0/kwesF/MXdw2x7sY0I6PyqyAp+Ndszsc99mblp4vCTP2HFCedHlLn2cZ9K2CM
         idg9Qu7/ZnxbhTbPfGZ+A3IGHn23VhNbY1G5lLhsepYECjn3YHgKKr1wquwbfGZuuo
         bo3+Sm9liGVQtdmCTLbEQIezUcuhREGGvItd+Kug=
Date:   Fri, 8 Jan 2021 15:07:19 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     zhenwei pi <pizhenwei@bytedance.com>
Cc:     arnd@arndb.de, pbonzini@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] misc: pvpanic: introduce module parameter 'events'
Message-ID: <X/hnF0W+TMj36LDN@kroah.com>
References: <20210108135223.2924507-1-pizhenwei@bytedance.com>
 <20210108135223.2924507-3-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210108135223.2924507-3-pizhenwei@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 09:52:23PM +0800, zhenwei pi wrote:
> Suggested by Paolo, add a module parameter that can be used to limit
> which capabilities the driver uses.
> 
> Finally, the pvpanic guest driver works by the limitation of both
> device capability and user setting.
> 
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>  drivers/misc/pvpanic.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/pvpanic.c b/drivers/misc/pvpanic.c
> index e1023c7b8fb0..417f1086e764 100644
> --- a/drivers/misc/pvpanic.c
> +++ b/drivers/misc/pvpanic.c
> @@ -19,6 +19,10 @@
>  #include <uapi/misc/pvpanic.h>
>  
>  static void __iomem *base;
> +static unsigned int events = PVPANIC_PANICKED | PVPANIC_CRASH_LOADED;
> +module_param(events, uint, 0644);
> +MODULE_PARM_DESC(events, "set event limitation of pvpanic device");

I do not understand you wanting a module parameter as well as a sysfs
file.  Why is this needed?  Why are you spreading this information out
across different apis and locations?

Again, adding module parameters is almost never a good idea anymore,
they are a pain to manage and use.

thanks,

greg k-h
