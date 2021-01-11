Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1A02F0B7E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 04:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbhAKDdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 22:33:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:57944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbhAKDdX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 22:33:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2873122581;
        Mon, 11 Jan 2021 03:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610335963;
        bh=GTpOx7tcslt8ycpxMT/g1qSaCr9BgFzJ+0BhCtKr62k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ELpGXqSgSPycZfr5ILg7fvxuKGle+bV3+PhVUT8HI6g9/tCTVI59LNl2WClOPm0RU
         x7NQfG9HZUwchgSAR85N0nYvysNW1VLAxQAngr4+77NGNz5GWnxCuT9wqTAi42Neb1
         PWQX8Xnu7We0lUXORH3yBc5LZ04xLWRoNxIF8fgZPkRq6RNU3smC3bsj8gPNV3fZWB
         rrZnLHiY8FEP53AJALz+AIytbhF7nJojwt4let/UWrTdocU8f+mhGwhWAEk1PNuSmi
         FFo5op2kTckl1ScP5Qu29NHavilsKkzn9vN+w5HkKXYqGQ9XkjMzd8+J3lac31QlLx
         +ig917o5ZujYA==
Date:   Mon, 11 Jan 2021 11:32:37 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>
Subject: Re: [PATCH v3 0/2] mainline Protonic MVT board
Message-ID: <20210111033236.GA28365@dragon>
References: <20210106090414.2344-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106090414.2344-1-o.rempel@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 06, 2021 at 10:04:12AM +0100, Oleksij Rempel wrote:
> changes v3:
> - use defines linux,code
> - sour out some spaces
> - move compatible to the beginning of the gpio_pca node. 
> 
> changes v2:
> - fix active level of SPI CS GPIOs
> 
> Oleksij Rempel (2):
>   dt-bindings: arm: fsl: add Protonic MVT board
>   ARM: dts: add Protonic MVT board

Applied both, thanks.
