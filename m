Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 109102B1BE4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 14:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgKMNaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 08:30:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:38876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbgKMNaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 08:30:35 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 651C82085B;
        Fri, 13 Nov 2020 13:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605274235;
        bh=TfJkZ2oHXjGcRW1STcAE522a0gfrypGFHLoxwZUnAT0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y2uJSDY/BM7HwdgOS/+gIHZSxAOdaxdhN0ZO4jkxD8hfbpk/7RtQMhIka6xqdA0J8
         EiYx/IiEyoCUeIsS0L0eYFR8leprVXwuDrdmlfnHVQwpTxQ5rMseSD/pGJzZ5KIbCq
         z7WPR8g3uwIYWooxdDe+frEwQrT3NZmZdVm4UPKw=
Date:   Fri, 13 Nov 2020 14:31:31 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>, Bin Liu <b-liu@ti.com>,
        Drew Fustini <drew@pdp7.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "usb: musb: convert to
 devm_platform_ioremap_resource_byname"
Message-ID: <X66Ks5ER2RRfUGB2@kroah.com>
References: <20201112135900.3822599-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112135900.3822599-1-geert+renesas@glider.be>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 02:59:00PM +0100, Geert Uytterhoeven wrote:
> This reverts commit 2d30e408a2a6b3443d3232593e3d472584a3e9f8.
> 
> On Beaglebone Black, where each interface has 2 children:
> 
>     musb-dsps 47401c00.usb: can't request region for resource [mem 0x47401800-0x474019ff]
>     musb-hdrc musb-hdrc.1: musb_init_controller failed with status -16
>     musb-hdrc: probe of musb-hdrc.1 failed with error -16
>     musb-dsps 47401400.usb: can't request region for resource [mem 0x47401000-0x474011ff]
>     musb-hdrc musb-hdrc.0: musb_init_controller failed with status -16
>     musb-hdrc: probe of musb-hdrc.0 failed with error -16
> 
> Before, devm_ioremap_resource() was called on "dev" ("musb-hdrc.0" or
> "musb-hdrc.1"), after it is called on "&pdev->dev" ("47401400.usb" or
> "47401c00.usb"), leading to a duplicate region request, which fails.
> 

Thanks for this, I'll go queue it up now.

greg k-h
