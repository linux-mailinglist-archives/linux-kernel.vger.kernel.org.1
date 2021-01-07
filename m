Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6D92EE643
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 20:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729104AbhAGTjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 14:39:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:47954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbhAGTjp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 14:39:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3D304233CF;
        Thu,  7 Jan 2021 19:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610048344;
        bh=QXIAGs3pY4yrERUbkDGVHnZ5YsZncF7q756owJanuS8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jTDM5V7j8E5piHv9zVnQwwl/c8JGpWu04un8eycixO0yCRpRX9mNki/K78rEJAj7y
         NmuW8AqC9s1GxtUoDxEjaGzw0qOHlja1IzRpTI6qS7sJSyV1fzMIzKqGOLqeZ8+kXZ
         Nwqakv9e0E3oE4O8t0WnGdB9prxtB6ZuGi3Mw0FQ=
Date:   Thu, 7 Jan 2021 20:40:24 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mike Ximing Chen <mike.ximing.chen@intel.com>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        dan.j.williams@intel.com, pierre-louis.bossart@linux.intel.com,
        Gage Eads <gage.eads@intel.com>
Subject: Re: [PATCH v8 03/20] dlb: add resource and device initialization
Message-ID: <X/djqGBzpYg+B6dF@kroah.com>
References: <20210105025839.23169-1-mike.ximing.chen@intel.com>
 <20210105025839.23169-4-mike.ximing.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210105025839.23169-4-mike.ximing.chen@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 04, 2021 at 08:58:22PM -0600, Mike Ximing Chen wrote:
> Introduce dlb_bitmap_* functions, a thin convenience layer wrapping the
> Linux bitmap interfaces, used by the bitmaps in the dlb hardware types.

No, you created custom #defines:

> --- a/drivers/misc/dlb/dlb_hw_types.h
> +++ b/drivers/misc/dlb/dlb_hw_types.h
> @@ -5,6 +5,15 @@
>  #define __DLB_HW_TYPES_H
>  
>  #include <linux/io.h>
> +#include <linux/types.h>
> +
> +#include "dlb_bitmap.h"
> +
> +#define BITS_SET(x, val, mask)	(x = ((x) & ~(mask))     \
> +				 | (((val) << (mask##_LOC)) & (mask)))
> +#define BITS_CLR(x, mask)	((x) &= ~(mask))
> +#define BIT_SET(x, mask)        ((x) |= (mask))
> +#define BITS_GET(x, mask)       (((x) & (mask)) >> (mask##_LOC))

We have functions for this, use them, don't create custom macros for
them.  Use the Linux functions please.

thanks,

greg k-h
