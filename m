Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A461F1710
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jun 2020 12:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729431AbgFHK6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jun 2020 06:58:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:50204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbgFHK6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 06:58:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FB442076A;
        Mon,  8 Jun 2020 10:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591613878;
        bh=0YKlIh3ZdkaZQyvIZ6bMpKP2/ZB7PrcvF6YsMTRXw00=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tn/RyYxfyGlVekUygXilwadLavzVGZtEITW19EAHhsJdVsIheX2HXiop+gwQuHthi
         ErpCVLl/cuaPBcv7yY5FWyDiM5rgBM/+8UAyzjHeUdFafBsZ4QsK7oTUT7hrNDRYqs
         BN4YXZwYSYR9813nfJQb3T837g7FVF019RU7BMZw=
Date:   Mon, 8 Jun 2020 12:57:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     matthias.bgg@kernel.org
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        gene.chen.richtek@gmail.com, lee.jones@linaro.org,
        Matthias Brugger <mbrugger@suse.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 1/2] drivers: base: Warn if driver name is not present
Message-ID: <20200608105756.GB295073@kroah.com>
References: <20200608095217.21162-1-matthias.bgg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200608095217.21162-1-matthias.bgg@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 08, 2020 at 11:52:16AM +0200, matthias.bgg@kernel.org wrote:
> From: Matthias Brugger <mbrugger@suse.com>
> 
> If we pass a driver without a name, we end up in a NULL pointer
> derefernce.

That's a very good reason not to have a driver without a name :)

What in-kernel driver does this?

> Check for the name before trying to register the driver.
> As we don't have a driver name to point to in the error message, we dump
> the call stack to make it easier to detect the buggy driver.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> ---
>  drivers/base/driver.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/base/driver.c b/drivers/base/driver.c
> index 57c68769e157..40fba959c140 100644
> --- a/drivers/base/driver.c
> +++ b/drivers/base/driver.c
> @@ -149,6 +149,12 @@ int driver_register(struct device_driver *drv)
>  	int ret;
>  	struct device_driver *other;
>  
> +	if (!drv->name) {
> +		pr_err("Driver has no name.\n");
> +		dump_stack();
> +		return -EINVAL;

Ick, no, an oops-traceback for doing something dumb like this should be
all that we need, right?

How "hardened" do we need to make internal apis anyway?  What's the odds
that if this does trigger, the driver author would even notice it?

thanks,

greg k-h
