Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D354529E903
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 11:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgJ2KaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 06:30:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:53390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726710AbgJ2KaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 06:30:19 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEEE320E65;
        Thu, 29 Oct 2020 10:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603967418;
        bh=RSyYaPmphqdJMDw5wjWrws7ErfCDFikjA7tANBK764Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oy1sKXjRiUj8YTTUkAgCwuuD+iAzTPCje1pvm5D7xos7OQrARyIM7vUb5Mwlvw6PZ
         4IqHW9cVjp1GllSlU1/zc518BE1kakHMX5NL2MD24f5R4J/KDwNTvRrCFGimXRm3Fp
         cK+YiDrkk0V3GUwUh0hwZbcosZZsLFRd7DAg0Xss=
Date:   Thu, 29 Oct 2020 11:31:08 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Rui Feng <rui_feng@realsil.com.cn>
Subject: Re: [PATCH v3 2/3] misc: rtsx: Add SD Express mode support for
 RTS5261
Message-ID: <20201029103108.GA3764182@kroah.com>
References: <1603936668-3363-1-git-send-email-rui_feng@realsil.com.cn>
 <CAPDyKFoKhxdx0BqcWgKr36riesEt_7qvNd8up5PrV07K+XD=fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFoKhxdx0BqcWgKr36riesEt_7qvNd8up5PrV07K+XD=fg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 10:52:53AM +0100, Ulf Hansson wrote:
> On Thu, 29 Oct 2020 at 02:57, <rui_feng@realsil.com.cn> wrote:
> >
> > From: Rui Feng <rui_feng@realsil.com.cn>
> >
> > RTS5261 support SD mode and PCIe/NVMe mode. The workflow is as follows.
> > 1.RTS5261 work in SD mode and set MMC_CAPS2_SD_EXP flag.
> > 2.If card is plugged in, Host send CMD8 to ask card's PCIe availability.
> > 3.If the card has PCIe availability and WP is not set, init_sd_express() will be invoked,
> > RTS5261 switch to PCIe/NVMe mode.
> > 4.Mmc driver handover it to NVMe driver.
> > 5.If card is unplugged, RTS5261 will switch to SD mode.
> >
> > Signed-off-by: Rui Feng <rui_feng@realsil.com.cn>
> 
> Greg, Arnd, I think I am ready to queue up this series now, may I have
> your ack to pick this one via my mmc tree?

Great, thanks for doing that:

	Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
