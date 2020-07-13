Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4412021CCAB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 03:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgGMA77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jul 2020 20:59:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:54454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbgGMA76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 20:59:58 -0400
Received: from dragon (unknown [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED63E206B6;
        Mon, 13 Jul 2020 00:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594601997;
        bh=SoIcAi39IGfR/s566lC9A0LfjtruZp5fuCbVydLzwik=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=djk9YZXLbvKAevrfOPOWYZwqqgnCwWVL1uUGl6ExRQ+ydoRIfY4pauMaN8L6ll5yr
         y7FL8nTJRixIuD/R40jvd9iEhv2tbqHnOk1RxgeLVh9li7CVlioRGB/YiUc7M2nwbk
         LIk21PcZoHkqv5ettMLoIi4yzlWkYOUBJOPv/Xnw=
Date:   Mon, 13 Jul 2020 08:59:37 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [RESEND PATCH] ARM: dts: imx6sx-sdb: Add MQS support
Message-ID: <20200713005936.GP21277@dragon>
References: <1594545402-26815-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594545402-26815-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 12, 2020 at 05:16:42PM +0800, Shengjiu Wang wrote:
> Add MQS support. As the pin conflict with usdhc2, then need
> to add a separate dts.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Applied, thanks.
