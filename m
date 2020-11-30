Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96FB52C80D5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 10:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbgK3JVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 04:21:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:49278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726498AbgK3JVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 04:21:18 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C435207BC;
        Mon, 30 Nov 2020 09:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606728037;
        bh=JTMsRQDp629j0dDn+/Ii7q+0c+mGzBEO4MsM2ildxw4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cIwSEEUdanV3hCJbL4T7FGDLe4qQFPXBBiErSdDQPctij3nfOIfDtojyznxtyFy/v
         7ZTnPr1mhPof1cVn/04DxOJq6SDkMcpP0yfGvxj1A9aIrmdzBVyMJnXsBva6+nYgFL
         ozEKcnHRhBk8GhLyIPd2ibIGAoUhIm1Qr/sZatY8=
Date:   Mon, 30 Nov 2020 17:20:31 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        "Y . b . Lu" <yangbo.lu@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        Ashish Kumar <Ashish.Kumar@nxp.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH v3 1/9] arm64: dts: ls1028a: fix ENETC PTP clock input
Message-ID: <20201130092030.GA4072@dragon>
References: <20201108185113.31377-1-michael@walle.cc>
 <20201108185113.31377-2-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201108185113.31377-2-michael@walle.cc>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 08, 2020 at 07:51:05PM +0100, Michael Walle wrote:
> On the LS1028A the ENETC reference clock is connected to 4th HWA output,
> see Figure 7 "Clock subsystem block diagram".
> 
> The PHC may run with a wrong frequency. ptp_qoriq_auto_config() will read
> the clock speed of the clock given in the device tree. It is likely that,
> on the reference board this wasn't noticed because both clocks have the
> same frequency. But this must not be always the case. Fix it.
> 
> Fixes: 49401003e260 ("arm64: dts: fsl: ls1028a: add ENETC 1588 timer node")
> Signed-off-by: Michael Walle <michael@walle.cc>

Applied, thanks.
