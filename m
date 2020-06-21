Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 745EF2029B6
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jun 2020 10:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729576AbgFUI5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Jun 2020 04:57:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:44280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729535AbgFUI5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 04:57:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90D9F24873;
        Sun, 21 Jun 2020 08:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592729824;
        bh=aNokLRmz+McR+JnvgxLD0kUt51Spv/CfHrKAYcpobt8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sL36EOLJPpclspiw1an0FN767mLQWip7XGOgNOws60isiEjuBTdYI1zxVatrnsnhT
         NWdG64raeVKSkEcPuAYLVENTbUl1WoldCUdu/e6VcFh/DwID7TIADItORexhXo5utk
         SXDLl0r1U9J2hVw07KwWew1hb5siAJahlbx0SxpU=
Date:   Sun, 21 Jun 2020 10:56:56 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Denis Efremov <efremov@linux.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: Use scnprintf() instead of snprintf() in
 device show functions
Message-ID: <20200621085656.GA95977@kroah.com>
References: <20200620150529.18678-1-efremov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200620150529.18678-1-efremov@linux.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 20, 2020 at 06:05:29PM +0300, Denis Efremov wrote:
> >From Documentation/filesystems/sysfs.txt:
> - show() must not use snprintf() when formatting the value to be
>   returned to user space. If you can guarantee that an overflow
>   will never happen you can use sprintf() otherwise you must use
>   scnprintf().
> 
> The reason is that snprintf() returns the length the resulting string
> would be, assuming the data will fit into the destination array.
> scnprintf() returns the length of the string actually created in buf.
> 
> device_show_{ulong,int,bool}() functions are reference implementation
> and should respect the kernel documentation.

Ok, but you are not following that documentation below, why not?

> 
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
> 
> Actually, I don't know why snprintf() is used here initially. It looks
> safe to use sprintf().
> 
>  drivers/base/core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 67d39a90b45c..2815deb511fc 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -1472,7 +1472,7 @@ ssize_t device_show_ulong(struct device *dev,
>  			  char *buf)
>  {
>  	struct dev_ext_attribute *ea = to_ext_attr(attr);
> -	return snprintf(buf, PAGE_SIZE, "%lx\n", *(unsigned long *)(ea->var));
> +	return scnprintf(buf, PAGE_SIZE, "%lx\n", *(unsigned long *)(ea->var));

As the documentation states, these should just be sprintf(), if you
really want to change these.

As-is, these are also ok, there is no need to change.

thanks,

greg k-h
