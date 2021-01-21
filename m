Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8D422FE4B7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 09:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbhAUIOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 03:14:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:51510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726811AbhAUIN5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 03:13:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E09E92395B;
        Thu, 21 Jan 2021 08:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611216793;
        bh=Jv1+7MosJtJk/47qnsHE23CojVtEBdwQu3teqjrEUG4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ych4A9+XzpZXkBsCkXP/On+u7xDemwsYafarw38F4mHDP/WP6N8atVJxSu6+bNrG7
         2uH9IAL/cEmASLMwFiLsOJAgjlLujgG+ZO29Z+a+QdatEfgTsRxPsvsFSS7Hpi2i1q
         wRvYg7Te/pec9wrDrcpwF7jDootfX4r0APyclbKk=
Date:   Thu, 21 Jan 2021 09:13:09 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dave Jiang <dave.jiang@intel.com>, vishal.l.verma@intel.com,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
Subject: Re: [PATCH 1/3] cdev: Finish the cdev api with queued mode support
Message-ID: <YAk3lVeFqnv5vzA2@kroah.com>
References: <161117153248.2853729.2452425259045172318.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161117153776.2853729.6944617921517514510.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161117153776.2853729.6944617921517514510.stgit@dwillia2-desk3.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 11:38:57AM -0800, Dan Williams wrote:
> -void cdev_del(struct cdev *p)
> +void cdev_del(struct cdev *cdev)
>  {
> -	cdev_unmap(p->dev, p->count);
> -	kobject_put(&p->kobj);
> +	cdev_unmap(cdev->dev, cdev->count);
> +	kobject_put(&cdev->kobj);

After Christoph's patch series, the kobject in struct cdev does nothing,
so I will be removing it.  So I don't think this patch set is going to
do what you want :(

thanks,

greg k-h
