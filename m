Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEAE2A3778
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 01:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbgKCAHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 19:07:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:38404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725910AbgKCAHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 19:07:04 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 942EC21556;
        Tue,  3 Nov 2020 00:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604362023;
        bh=GzuDDXWY8aoG90EgJn5PYz9hpehIy8YNVnQqPK2pNA0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ea2GOEo3eP1OAYFF4fm3vrCCV7slEw9Bf8Im0CNQFkIf/x78yF+i+qTnHv4hg/+4T
         roNJmJet1bYgMTJNzhTASIm5KXOyZsyiR3Xw6oJYfrtT5nAvY9alYEiKlzjP7ly5aw
         vdtl87sehivFTUXmoCrCq656BZ0va/m0tNTv73GQ=
Date:   Tue, 3 Nov 2020 08:06:57 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     peng.fan@nxp.com
Cc:     sboyd@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        abel.vesa@nxp.com, kernel@pengutronix.de, linux-imx@nxp.com,
        Anson.Huang@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        aisheng.dong@nxp.com
Subject: Re: [PATCH V3] clk: imx8m: fix bus critical clk registration
Message-ID: <20201103000657.GA31601@dragon>
References: <1604229834-25594-1-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604229834-25594-1-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 01, 2020 at 07:23:54PM +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> noc/axi/ahb are bus clk, not peripheral clk.
> Since peripheral clk has a limitation that for peripheral clock slice,
> IP clock slices must be stopped to change the clock source.
> 
> However if the bus clk is marked as critical clk peripheral, the
> assigned clock parent operation will fail.
> 
> So we added CLK_SET_PARENT_GATE flag to avoid glitch.
> 
> And add imx8m_clk_hw_composite_bus_critical for bus critical clock usage
> 
> Fixes: 936c383673b9e ("clk: imx: fix composite peripheral flags")
> Reviewed-by: Abel Vesa <abel.vesa@nxp.com>
> Reported-by: Abel Vesa <abel.vesa@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Do you want this be picked up as a fix for 5.10-rc or non-critical stuff
for -next?

Shawn
