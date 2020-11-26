Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2902C2C5D0E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 21:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390474AbgKZU07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 15:26:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:50840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389990AbgKZU07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 15:26:59 -0500
Received: from localhost (82-217-20-185.cable.dynamic.v4.ziggo.nl [82.217.20.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4666621D7F;
        Thu, 26 Nov 2020 20:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1606422417;
        bh=JH/syPloWMdQoz1M8toLDzL0YvzdJcH8lBurTBaqNIQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KI58rQYPWhccqi6Ue+uLuhVvhh0heinfk57KGGVpgXNaSKfDDAtKmpKdDAhpHLXZD
         Q5FFAxRQFrxmTrVQefefzZqG44upae3IxtN0hiD045RtCjVbhCalN2E0MY3ns+p4jH
         OFc3MzDZSKp5hZszGPco5x7LvZZB+YQfn+6b1BQ8=
Date:   Thu, 26 Nov 2020 21:26:50 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     mgross@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, adam.r.gretzinger@intel.com,
        markgross@kernel.org, Seamus Kelly <seamus.kelly@intel.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 22/22] xlink-core: factorize xlink_ioctl function by
 creating sub-functions for each ioctl command
Message-ID: <X8APikiYF4+C3PjC@kroah.com>
References: <20201125184349.29686-1-mgross@linux.intel.com>
 <20201125184349.29686-23-mgross@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201125184349.29686-23-mgross@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 10:43:49AM -0800, mgross@linux.intel.com wrote:
> From: Seamus Kelly <seamus.kelly@intel.com>
> 
> Refactor the too large IOCTL function to call helper functions.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Mark Gross <mgross@linux.intel.com>
> Signed-off-by: Seamus Kelly <seamus.kelly@intel.com>

<snip>

What are these random patch sets that don't seem to be showing up on
lore.kernel.org and I don't get the full series, nor any understanding
what is going on?

Are you sending only partial sets out for some reason?

thanks,

greg k-h
