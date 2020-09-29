Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE29D27D36C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 18:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730522AbgI2QOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 12:14:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:57576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728672AbgI2QOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 12:14:00 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D465C2075E;
        Tue, 29 Sep 2020 16:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601396039;
        bh=yHeccch7Zh+jX/wFOgZePha44aK3VoL2GpVu4cnp6XU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Utbkk+wgGyL64xbEhjaXYCeOeJhW9K2+wQinK/V1XmR5B2CelCis9Zyigjt9m3wOq
         KlRNZH4aNsaxtqU5+e7XTw3YTHcsTOva52ohvsfX9NcqI+B6P3OEpYa2AGviB62Jch
         S9WFA5ID9D/XRZ6p+c7y9kWtmo21nbFlZ40nC95c=
Date:   Tue, 29 Sep 2020 18:14:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL]: Generic PHY fixes for v5.9
Message-ID: <20200929161405.GD1326743@kroah.com>
References: <20200928055540.GJ2968@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928055540.GJ2968@vkoul-mobl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 11:25:40AM +0530, Vinod Koul wrote:
> Hi Greg,
> 
> We have a leak fix for TI driver, please consider for v5.9
> 
> The following changes since commit ad7a7acaedcf45071c822b6c983f9c1e084041c9:
> 
>   phy: omap-usb2-phy: disable PHY charger detect (2020-08-31 14:30:59 +0530)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-fixes-2-5.9

Pulled and pushed out, thanks,.

greg k-h
