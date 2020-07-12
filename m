Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C9721C7C7
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jul 2020 08:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbgGLGtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jul 2020 02:49:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:51672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727777AbgGLGtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 02:49:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0F902070B;
        Sun, 12 Jul 2020 06:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594536547;
        bh=5hFYggtmbXm1gzSEr54Yj77nGkufnmMGvt4v1b7+Ipw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aIGs5Cp0OxptNj1SWHeexH94IqDvPPv9ejS7Vw2/TuxPR8u3vdnSFsDxkn+sSUqad
         Y4WzgEHqz2npBxJu549T6szFh9R6YQbpqr0GqVwtln1B6Ic0MoD72cWHXFmQbFMSzg
         oDEJ+gwoJbh5qA4RiiKSsg7o/fdOoFxRf/Z7Mr9I=
Date:   Sun, 12 Jul 2020 08:49:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     David Gow <davidgow@google.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Soren Brinkmann <soren.brinkmann@xilinx.com>,
        devel@driverdev.osuosl.org,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: staging: Specify IOMEM dependency for Xilinx
 Clocking Wizard driver
Message-ID: <20200712064909.GC2920853@kroah.com>
References: <20200630044518.1084468-1-davidgow@google.com>
 <159448501081.1987609.2376410636031633673@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159448501081.1987609.2376410636031633673@swboyd.mtv.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 11, 2020 at 09:30:10AM -0700, Stephen Boyd wrote:
> Quoting David Gow (2020-06-29 21:45:17)
> > The Xilinx Clocking Wizard driver uses the devm_ioremap_resource
> > function, but does not specify a dependency on IOMEM in Kconfig. This
> > causes a build failure on architectures without IOMEM, for example, UML
> > (notably with make allyesconfig).
> > 
> > Fix this by making CONFIG_COMMON_CLK_XLNX_CLKWZRD depend on CONFIG_IOMEM.
> > 
> > Signed-off-by: David Gow <davidgow@google.com>
> > ---
> 
> This driver is in the process of being destaged to drivers/clk/
> 
> Greg, should I pick this one up?

Sure, if I haven't already.

thanks,

greg k-h
