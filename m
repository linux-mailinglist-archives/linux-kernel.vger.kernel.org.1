Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF5125E604
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Sep 2020 09:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgIEHnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Sep 2020 03:43:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:56430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbgIEHnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 03:43:18 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4803920760;
        Sat,  5 Sep 2020 07:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599291798;
        bh=EWfsxqTHa+7T37fM05cCcX7guC4jNqfMSTCs69oRhNU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LNOxo7ox17QIkn3tmeEus40j1bu+frnBld8OL6J3mZC/YgpPbsj4nedbzBqU8qw9Q
         vEfglU3QZE91a4a4bEgRbQg+rV3en/wfmVmC1araJmeA9lMNqm1duJYfAkXTUswfeR
         7UhyT9XUV4H06ppgPZg+AK0WCo5bjwt5j7OkbbaI=
Date:   Sat, 5 Sep 2020 15:43:13 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH 3/3] clk: imx: Fix and update kerneldoc
Message-ID: <20200905074312.GM9261@dragon>
References: <20200902150244.14347-1-krzk@kernel.org>
 <20200902150244.14347-3-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902150244.14347-3-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 05:02:44PM +0200, Krzysztof Kozlowski wrote:
> Fix and add missing kerneldoc to fix compile warnings like:
> 
>   drivers/clk/imx/clk-pfd.c:27: warning: Function parameter or member 'hw' not described in 'clk_pfd'
>   drivers/clk/imx/clk-pllv3.c:53: warning: Function parameter or member 'ref_clock' not described in 'clk_pllv3'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied, thanks.
