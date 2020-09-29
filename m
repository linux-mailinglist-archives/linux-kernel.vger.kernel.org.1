Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEA9427CB3A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 14:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732713AbgI2MZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 08:25:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:38420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732695AbgI2MZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 08:25:28 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38DB92075F;
        Tue, 29 Sep 2020 12:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601382327;
        bh=vdV0cPfcuBlzJ8bZGMb5ArwZmErrYSk6dciDVr0yxG8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GNW/wMNW3TBN29OzymiX57VJRFRzW7OLdpBHVaye5aH28MC5iShFP1/0cs6qOpdfD
         lNpxyZqB0D8A2oYtBtcGvl9QQ1m+At3IeSWTeNisGEOyX6FyWnc3p5z3zqsmyBKh3N
         bwSnucX9F8d1YVo/3wYWDo6uIoajDWtEUQz2q5Iw=
Date:   Tue, 29 Sep 2020 14:25:33 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     poeschel@lemonage.de
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] driver core: Remove double assignment
Message-ID: <20200929122533.GA1193271@kroah.com>
References: <20200929115808.2815382-1-poeschel@lemonage.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929115808.2815382-1-poeschel@lemonage.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 01:58:08PM +0200, poeschel@lemonage.de wrote:
> From: Lars Poeschel <poeschel@lemonage.de>
> 
> This removes an assignment in device_add. It assigned the parent
> kobject to the kobject of the  new device. This is not necessary,
> because the call to kobject_add a few lines later also does this same
> assignment.
> 
> Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
> ---
>  drivers/base/core.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index bb5806a2bd4c..03b5396cd192 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -2847,8 +2847,6 @@ int device_add(struct device *dev)
>  		error = PTR_ERR(kobj);
>  		goto parent_error;
>  	}
> -	if (kobj)
> -		dev->kobj.parent = kobj;
>  
>  	/* use parent numa_node */
>  	if (parent && (dev_to_node(dev) == NUMA_NO_NODE))
> @@ -2856,7 +2854,7 @@ int device_add(struct device *dev)
>  
>  	/* first, register with generic layer. */
>  	/* we require the name to be set before, and pass NULL */
> -	error = kobject_add(&dev->kobj, dev->kobj.parent, NULL);
> +	error = kobject_add(&dev->kobj, kobj, NULL);

That's very subtle, and might not really be correct for all users, have
you checked?

Anyway, I'd rather leave this as-is if possible, as we know this works
correctly, and it is not going to save any time/energy to remove that
assignment, right?

thanks,

greg k-h
