Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC61C260349
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 19:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbgIGNET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 09:04:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:53610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729363AbgIGNBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 09:01:42 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80E0F20639;
        Mon,  7 Sep 2020 13:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599483696;
        bh=UdahbKu3BTdB082i1nMSXw7zx46/R98LUElP39bIllM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lfpRj1HlHH3CSTamCvrByUagPXoW0SBh+LuVu7Vv/oSqf9uCB6wUCjCRYLoPcSG/S
         WIRjBkxznXPwzqHDzmneIv+ysiL38zyR+/dyfTvyib9eTtzez8DYSKky3x2K2jqg99
         9PTzfff6YUDvD1G4ttvAd8TAjLoAxA5ZnpoUUzP8=
Date:   Mon, 7 Sep 2020 15:01:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gage Eads <gage.eads@intel.com>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        magnus.karlsson@intel.com, bjorn.topel@intel.com
Subject: Re: [PATCH v3 01/19] dlb2: add skeleton for DLB 2.0 driver
Message-ID: <20200907130150.GE2371705@kroah.com>
References: <20200901191548.31646-1-gage.eads@intel.com>
 <20200901191548.31646-2-gage.eads@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901191548.31646-2-gage.eads@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 02:15:30PM -0500, Gage Eads wrote:
> --- /dev/null
> +++ b/drivers/misc/dlb2/dlb2_main.c
> @@ -0,0 +1,208 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2018-2020 Intel Corporation */
> +
> +#include <linux/aer.h>
> +#include <linux/cdev.h>
> +#include <linux/delay.h>
> +#include <linux/fs.h>
> +#include <linux/init.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/uaccess.h>
> +
> +#include "dlb2_main.h"
> +
> +static const char
> +dlb2_driver_copyright[] = "Copyright(c) 2018-2020 Intel Corporation";

Why have this in a string and then:

> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Copyright(c) 2018-2020 Intel Corporation");

Not use it?

It's probably not needed at all, right?

Don't you get a build warning about this when applying and building this
patch?

thanks,

greg k-h
