Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0C02D0CF5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 10:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgLGJZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 04:25:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:49922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725550AbgLGJZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 04:25:21 -0500
Date:   Mon, 7 Dec 2020 10:25:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607333081;
        bh=2q1JWMGI3ZSMyphTucU0zjAkEMx2H0EkBdhOlS7Sbw4=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=xBjTlhDH16+iHhZ9EEDWAV7poGvwUnuYRV3LV8jkJU4DW6LH7v5+2yi7zUDdDZmYg
         ME3x/v4jMr1yc4a85Reo0ISBSczqhb/mKC1uOVmdWoufQc23M541msPtL1UVI7+Nsw
         wsQbzcKhlG2apmiQxWVlUYlj7Km+TJ/fEFFG7M4U=
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL]: soundwire updates for v5.11-rc1
Message-ID: <X831CycpWQAbG2Tz@kroah.com>
References: <20201207050247.GC8403@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207050247.GC8403@vkoul-mobl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 10:32:47AM +0530, Vinod Koul wrote:
> Hello Greg,
> 
> Please pull to receive updates for v5.11 as detailed below:
> 
> The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:
> 
>   Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-5.11-rc1

Pulled and pushed out, thnaks.

greg k-h
