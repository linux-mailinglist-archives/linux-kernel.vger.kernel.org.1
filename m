Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B902256503
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Aug 2020 08:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgH2GW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Aug 2020 02:22:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:55710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbgH2GW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 02:22:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDAC020936;
        Sat, 29 Aug 2020 06:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598682177;
        bh=RTA0q4bRMzKQsANHsZ7dyfTLiK9cKvaBNIooZBkpUFc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ddnS9IL6jqajQ43UItWlH5QVfTc64BnWlPCjw7uuPDngAgJASNwyk2p6hJgpviFYX
         j+CDxctZXt8pCoSARnlNPHwpci48u/9Ah7ezdgWWElXxkBdOpNhCpOQwda07nXg3Td
         cfcCYEeF4npNiEGPtq82cwspVWZNveIhCf6dycyc=
Date:   Sat, 29 Aug 2020 08:22:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Denis Efremov <efremov@linux.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Alex Dewar <alex.dewar90@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysfs: Add sysfs_emit to replace sprintf to PAGE_SIZE
 buffers.
Message-ID: <20200829062254.GA79296@kroah.com>
References: <a96cdf07cd136d06c3cc1e10eb884caa7498ba72.1598654887.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a96cdf07cd136d06c3cc1e10eb884caa7498ba72.1598654887.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 03:52:13PM -0700, Joe Perches wrote:
> sprintf does not know the PAGE_SIZE maximum of the temporary buffer
> used for outputting sysfs content requests and it's possible to
> overrun the buffer length.
> 
> Add a generic sysfs_emit mechanism that knows that the size of the
> temporary buffer and ensures that no overrun is done.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  fs/sysfs/file.c       | 30 ++++++++++++++++++++++++++++++
>  include/linux/sysfs.h |  8 ++++++++
>  2 files changed, 38 insertions(+)
> 
> diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
> index eb6897ab78e7..06a13bbd7080 100644
> --- a/fs/sysfs/file.c
> +++ b/fs/sysfs/file.c
> @@ -707,3 +707,33 @@ int sysfs_change_owner(struct kobject *kobj, kuid_t kuid, kgid_t kgid)
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(sysfs_change_owner);
> +
> +/**
> + *	sysfs_emit - scnprintf equivalent, aware of PAGE_SIZE buffer.
> + *	@buf:	start of PAGE_SIZE buffer.
> + *	@pos:	current position in buffer
> + *              (pos - buf) must always be < PAGE_SIZE

sysfs files are always supposed to be "one value per file", so why would
you ever need a 'pos' variable to show the location in the buffer?

This would encourage people to do things they shouldn't be doing, and it
makes the people who are doing things properly, have to constantly see
'pos' as something that maybe they should be using?

I think if you tried to convert a subsystem to use this (try USB as an
example), you would see why that parameter isn't needed.

thanks,

greg k-h
