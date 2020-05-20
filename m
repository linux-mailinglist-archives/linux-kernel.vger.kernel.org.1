Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B35E81DA7E0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 04:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbgETCSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 22:18:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:36088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726348AbgETCSx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 22:18:53 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05C0F2070A;
        Wed, 20 May 2020 02:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589941132;
        bh=GDNAaNZP3qMwBaDYx1p3xLKPDrxahudWnRS7ySIVvIE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eYtrGcsRUrItN9pLIsFGpnLwrKeOmPDNNOPQ/CwZtX0CMIk7sTfnuiYMcFayVVSF3
         OP2lQa6b/Fte6tocvgS8QguqHJIW56U4pJgdpC05wOQ6TkeIji+1VEOWnwAMwtuw/d
         atFog8WR2+AgbI+o9lRxbK0MEocpjVl1FIPFqcv4=
Date:   Wed, 20 May 2020 10:18:47 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx6qdl-gw5910: add support for bcm4330-bt
Message-ID: <20200520021847.GP11739@dragon>
References: <1589320455-23844-1-git-send-email-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589320455-23844-1-git-send-email-tharvey@gateworks.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 02:54:15PM -0700, Tim Harvey wrote:
> The Sterling-LWB has a BCM4330 which has a UART based bluetooth
> HCI. Add support for binding to the bcm_hci driver to take care
> of handling the shutdown gpio and loading firmware.
> 
> Because the shutdown gpio is more of an enable than a regulator
> go ahead and replace the regulator with a shutdown-gpio.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied, thanks.
