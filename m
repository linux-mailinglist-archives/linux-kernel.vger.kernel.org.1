Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5F1B29FFE1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 09:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbgJ3I1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 04:27:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:46908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbgJ3I1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 04:27:10 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D01F8206DC;
        Fri, 30 Oct 2020 08:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604044901;
        bh=m/I0g8nLgsECY4ZvHHYuCAIFMJHMN+Gt07qTXP5pasA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dJ697EdvFRj0eH1gCS3UiqJcIQQnSfjBpwTYd0MxFO0qBf/q+tWrZO31jNoBd9ZrL
         JjrHKi8T+pwNRLuTFihOiOre88+GNbzJLwWFzrS3zQBI3uNl2OQuAmXWv/eE50n0oM
         7T8wYVnYWStUZqazjcRf3c71wPo/TB4CT1dMRMo0=
Date:   Fri, 30 Oct 2020 16:01:36 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mm-beacon-som: Add QSPI NOR flash support
Message-ID: <20201030080135.GL28755@dragon>
References: <20201007142409.235234-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007142409.235234-1-aford173@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 09:24:08AM -0500, Adam Ford wrote:
> imx8mm-beacon-som has a Quad-SPI NOR flash connected to the FlexSPI bus.
> 
> This patch enables the FlexSPI bus and configures it to work with the
> flash part.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

Applied, thanks.
