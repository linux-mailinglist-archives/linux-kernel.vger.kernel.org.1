Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05A122EF50A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 16:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbhAHPnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 10:43:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:59314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727175AbhAHPnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 10:43:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E5E162368A;
        Fri,  8 Jan 2021 15:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610120561;
        bh=1zg4IPnLjLlxc2+winxLL/MViBsxRCvYpoPPe4Sbf6E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BlTz9n9xCSFP4hKveyLLwiyFU2CrozsN/3ftj5OiqdzxxfqODyZCV+52XtNDuZbRw
         Uksjp6B2Roxt76LOukJbSiMk8osWYjYpSbr+FWAkPBihYH02WtYyQfC+mq4zoCplxc
         nJSxk+mx9h6TWriRC9ZTto5a9LqrjNUzyl8XlCYU=
Date:   Fri, 8 Jan 2021 16:43:59 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     John Garry <john.garry@huawei.com>
Cc:     rafael@kernel.org, maz@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, dan.carpenter@oracle.com
Subject: Re: [PATCH] Driver core: platform: Add extra error check in
 devm_platform_get_irqs_affinity()
Message-ID: <X/h9vy/1h0E1hyN0@kroah.com>
References: <1608561055-231244-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1608561055-231244-1-git-send-email-john.garry@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 21, 2020 at 10:30:55PM +0800, John Garry wrote:
> The current check of nvec < minvec for nvec returned from
> platform_irq_count() will not detect a negative error code in nvec.
> 
> This is because minvec is unsigned, and, as such, nvec is promoted to
> unsigned in that check, which will make it a huge number (if it contained
> -EPROBE_DEFER).
> 
> In practice, an error should not occur in nvec for the only in-tree
> user, but add a check anyway.
> 
> Fixes: e15f2fa959f2 ("driver core: platform: Add devm_platform_get_irqs_affinity()")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
> I hope that this can go through either irqchip or driver/core trees, thanks!

I'll take it, thanks.

greg k-h
