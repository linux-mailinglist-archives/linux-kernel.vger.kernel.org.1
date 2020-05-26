Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A70281B0C40
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 15:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbgDTNHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 09:07:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:58978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbgDTNHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 09:07:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C77E2072B;
        Mon, 20 Apr 2020 13:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587388037;
        bh=V75EOkXxVvNKIKgafA+kN9m13NmYbnNqGbRSfqMMzxI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m6VCfRs0mzgqJbFAus3P7cNMyRgXyNL66AXmcualloYQ1c2SumxOvsirbPz9NS9DQ
         0bRBVBHOjM+3ulRnV701hxX7zlWgy0RIZtHk9+OVAnG0gzwN7t3mGIz7ZOE73E2f33
         6ik8JoGMO4/6KsyzM9SGnuYXNvZ7oislsAvr8z9k=
Date:   Mon, 20 Apr 2020 15:07:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     matthias.bgg@gmail.com, nishkadg.linux@gmail.com,
        devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: mt7621-pinctrl: Use correct pointer type
 argument for sizeof
Message-ID: <20200420130715.GA4040736@kroah.com>
References: <20200420124151.4356-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420124151.4356-1-yanaijie@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 08:41:51PM +0800, Jason Yan wrote:
> Fix the following coccicheck warning:
> 
> drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c:223:14-36: WARNING: Use
> correct pointer type argument for sizeof
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>  drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

What changed from v1?  Always put that below the --- line.

Please fix up and send a v3.

thanks,

greg k-h
