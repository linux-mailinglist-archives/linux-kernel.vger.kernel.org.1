Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD4F82EE64B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 20:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbhAGTkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 14:40:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:48038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbhAGTkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 14:40:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5878123444;
        Thu,  7 Jan 2021 19:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610048381;
        bh=yIeR/cc1ZihI1H8sybRUWdWZ3fNQ1zvVO3h6BSn/hWc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lkv5YtsfMTiwqxuDYmzfskZDf69gm6qnIp/cpZHJp7Hh30jurQLWNDw2wB4mhWc2+
         ElXdHRCRqPE4sRh+5y1ae8eBABRs9lbXsPiweaiZlkS2jCAFBoxizgNMjn6P/kZWX1
         p/vmmyWYm1Eeo46kBRwAgXjRlZnww5qGEAvuSHc8=
Date:   Thu, 7 Jan 2021 20:41:01 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mike Ximing Chen <mike.ximing.chen@intel.com>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        dan.j.williams@intel.com, pierre-louis.bossart@linux.intel.com,
        Gage Eads <gage.eads@intel.com>
Subject: Re: [PATCH v8 04/20] dlb: add device ioctl layer and first three
 ioctls
Message-ID: <X/djzcBWzwDrMmpA@kroah.com>
References: <20210105025839.23169-1-mike.ximing.chen@intel.com>
 <20210105025839.23169-5-mike.ximing.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210105025839.23169-5-mike.ximing.chen@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 04, 2021 at 08:58:23PM -0600, Mike Ximing Chen wrote:
> Introduce the dlb device ioctl layer and the first three ioctls: query
> device version, query available resources, and create a scheduling domain.
> Also introduce the user-space interface file dlb_user.h.
> 
> The device version query is designed to allow each DLB device version/type
> to have its own unique ioctl API through the /dev/dlb%d node. Each such API
> would share in common the device version command as its first command, and
> all subsequent commands can be unique to the particular device.
> 
> The hardware operation for scheduling domain creation will be added in a
> subsequent commit.
> 
> Signed-off-by: Gage Eads <gage.eads@intel.com>
> Signed-off-by: Mike Ximing Chen <mike.ximing.chen@intel.com>
> Reviewed-by: Magnus Karlsson <magnus.karlsson@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  .../userspace-api/ioctl/ioctl-number.rst      |   1 +
>  drivers/misc/dlb/Makefile                     |   2 +-
>  drivers/misc/dlb/dlb_bitmap.h                 |  32 ++++
>  drivers/misc/dlb/dlb_ioctl.c                  | 119 +++++++++++++
>  drivers/misc/dlb/dlb_ioctl.h                  |  11 ++
>  drivers/misc/dlb/dlb_main.c                   |   3 +
>  drivers/misc/dlb/dlb_main.h                   |   7 +
>  drivers/misc/dlb/dlb_pf_ops.c                 |  21 +++
>  drivers/misc/dlb/dlb_resource.c               |  63 +++++++
>  drivers/misc/dlb/dlb_resource.h               |   5 +
>  include/uapi/linux/dlb.h                      | 166 ++++++++++++++++++
>  11 files changed, 429 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/misc/dlb/dlb_ioctl.c
>  create mode 100644 drivers/misc/dlb/dlb_ioctl.h
>  create mode 100644 include/uapi/linux/dlb.h
> 
> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
> index 55a2d9b2ce33..afca043d59f8 100644
> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> @@ -241,6 +241,7 @@ Code  Seq#    Include File                                           Comments
>  'h'   00-7F                                                          conflict! Charon filesystem
>                                                                       <mailto:zapman@interlan.net>
>  'h'   00-1F  linux/hpet.h                                            conflict!
> +'h'   00-1F  uapi/linux/dlb.h                                        conflict!

Why are you taking a range that you know there is a conflict for?

