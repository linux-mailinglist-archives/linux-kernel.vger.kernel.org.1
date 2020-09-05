Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9F725E60B
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Sep 2020 09:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgIEH4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Sep 2020 03:56:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:57348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbgIEH4l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 03:56:41 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96F9520760;
        Sat,  5 Sep 2020 07:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599292601;
        bh=VKJBznVEyqnXAZUg3+ali+c8AVrgwLURDP4Hs/RehYU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bFRlEFaV7RPkyvKlniWRyH+nbTjuLFHD0trTLb05YYEkkAzEgdpU/g/4ls+JpSsLr
         q8cGQDPrc3nC390ozrCAmnIrc36WKw71oT1g+lHi4j9FpYvWT8l1Qk3bmHck4VZeHg
         hry0K2Q7KYZWDXuGOvEbu58UFiBylgUKftcE/kWU=
Date:   Sat, 5 Sep 2020 15:56:36 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     fugang.duan@nxp.com
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, festevam@gmail.com,
        kernel@pengutronix.de, s.hauer@pengutronix.de
Subject: Re: [PATCH 1/1] ARM: dts: imx6sx: fix the pad QSPI1B_SCLK mux mode
 for uart3
Message-ID: <20200905075635.GP9261@dragon>
References: <20200903100521.10464-1-fugang.duan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903100521.10464-1-fugang.duan@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 03, 2020 at 06:05:21PM +0800, fugang.duan@nxp.com wrote:
> From: Fugang Duan <fugang.duan@nxp.com>
> 
> The pad QSPI1B_SCLK mux mode 0x1 is for function UART3_DTE_TX,
> correct the mux mode.
> 
> Fixes: 743636f25f1d ("ARM: dts: imx: add pin function header for imx6sx")
> Signed-off-by: Fugang Duan <fugang.duan@nxp.com>

Applied, thanks.
