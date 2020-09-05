Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72DFC25E4FC
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Sep 2020 03:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbgIEBmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 21:42:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:35378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbgIEBmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 21:42:20 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFA5D2074A;
        Sat,  5 Sep 2020 01:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599270139;
        bh=M31V8G+N9upI9UsIjNqpNv3bGfeXks6ioPv3eGbi7pI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jA5LdXrJYkVeiRy2w/ce/WHHpxZNqG/dEJQLu+BI9WCxSdH1OC6nGfgD/nFULzlZn
         IOeqVbhbVIe0eJpCwlrvVIPCMw+ui58L8LujeQxp/9qj/ahtNs8pOH/H0PaKxYSIxx
         fluhqr8V+GDnS2zHP5RmizHVAbjbuS8Z6SJ4N2F0=
Date:   Sat, 5 Sep 2020 09:42:14 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     peng.fan@nxp.com
Cc:     sboyd@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, abel.vesa@nxp.com,
        Anson.Huang@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        laurent.pinchart@ideasonboard.com
Subject: Re: [PATCH] clk: imx: fix i.MX7D peripheral clk mux flags
Message-ID: <20200905014213.GD7508@dragon>
References: <20200828071850.24945-1-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828071850.24945-1-peng.fan@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 03:18:50PM +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> According to RM, Page 574, Chapter 5.2.6.4.3 Peripheral clock slice,
> "IP clock slices must be stopped to change the clock source.".
> 
> So we must have CLK_SET_PARENT_GATE flag to avoid glitch.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks.
