Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5D829DEE8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403804AbgJ2A5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 20:57:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:60534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731602AbgJ1WRf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:35 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1CA7223FB;
        Wed, 28 Oct 2020 07:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603870257;
        bh=fmzg6AwoMrtGBVkHOGirrALJEKcbNE7b887tYnXCob8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p7Yv0xKjT2MH1Su7qF6uLU8vIvWT9cYWojvc1V6c7AeoAOynoxogxWnMiuKTiTy8U
         4XtfC1Eq8utvqEagfKEIgp7li33A9MXJJBWF9Pl72kaIrdtrvpcFjYTLLqOkTYFmnB
         NXbIHiifCPNJf0HGhtJiCAwvprUyHxI1wpDpD6fs=
Date:   Wed, 28 Oct 2020 15:30:52 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com
Subject: Re: [PATCH] ARM: dts: imx6q-icore-ofcap10: Use 10.1" Ampire panel
 compatible
Message-ID: <20201028073051.GM9880@dragon>
References: <20200828160302.329179-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828160302.329179-1-jagan@amarulasolutions.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 09:33:02PM +0530, Jagan Teki wrote:
> Adding display timings directly on device tree files make it difficult
> to maintain as a same copy of timings may exist on different files or
> panel-simple driver.
> 
> We have a panel-simple driver for this particular usage so supporting
> on this driver will help to use the same timings on any device tree
> files if the board mounted on a similar vendor display.
> 
> Engicam C.TOUCH OF 10.1" LCD board uses Ampire 10.1" TFT LCD and
> it has supported by panel-simple already, so simply use that binding.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

Applied, thanks.
