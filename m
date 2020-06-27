Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A556020C1FC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jun 2020 16:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbgF0OQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Jun 2020 10:16:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:36596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbgF0OQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 10:16:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19AC621655;
        Sat, 27 Jun 2020 14:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593267373;
        bh=itT5if3N84nfVPow/9kdBCYR0Rh7EMAOUqN8xHYSKug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v8caGgvguck+JKuFnoTdAvQHyPhjvsMNNzQ0Bm/uxlzL1ASM6Kofiv5YOB+LJBa/3
         dBcovb9HGZ0lwnoj4/sXMueUhdnEbBOLhyCAbdFvNVZS04hvjxItLnUGKoH5jPbbHE
         ZcqUHZvAI5l6cqz69pzRT8bDT6fIMhF+ASYAO7bQ=
Date:   Sat, 27 Jun 2020 16:16:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Jiri Slaby <jslaby@suse.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] serial: core: fix up sysrq regressions
Message-ID: <20200627141607.GA1927422@kroah.com>
References: <20200610152232.16925-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610152232.16925-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 05:22:29PM +0200, Johan Hovold wrote:
> This series fixes a few regressions introduced by the recent sysrq
> rework that went into 5.6.
> 
> The fix for the unnecessary per-character overhead probably could have
> been marked for stable but I left that decision to the maintainers as it
> is a bit intrusive (although mostly shuffling code around).

It makes sense to backport this, I'll mark it as such, thanks!

greg k-h
