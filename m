Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECB31DA7EA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 04:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbgETCVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 22:21:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:37688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726938AbgETCVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 22:21:23 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77F1E2075F;
        Wed, 20 May 2020 02:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589941283;
        bh=mAwTctuHf09OxNHi2gNbrD3yitZssxXU6ldaR1VHUTw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H+t/vJ9r4Rfa+vyqCdkuBONcR2LEcDmnDS+s8/5DkK1HAbvTo8nbX4oRmVxG26VMW
         sgR3xmNY4y5/0dmHkGdEXC/JWtRJlqQB/DmXbtsTkbqqpBpY+pdTuthH9l4d+e0UMh
         7y/30I4GQ+sQ7h8DNyrlUGIs+PfsxgqOCVeYB8Uc=
Date:   Wed, 20 May 2020 10:21:18 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH 1/2] ARM: dts: imx6qdl: Use nvmem interface to get fuse
 data
Message-ID: <20200520022117.GR11739@dragon>
References: <1589418528-26410-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589418528-26410-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 09:08:47AM +0800, Anson Huang wrote:
> Although ocotp clock is always ON for i.MX6QDL, OCOTP can be
> accessed directly, but since i.MX6QDL nvmem interface is supported,
> and fsl,tempmon-data is deprecated, use it instead of getting fuse
> data by reading ocotp directly, this makes all i.MX6 SoCs aligned.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied both, thanks.
