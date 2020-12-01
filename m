Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08C952C94AB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 02:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731203AbgLABaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 20:30:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:37312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbgLABaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 20:30:14 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D2C0206F9;
        Tue,  1 Dec 2020 01:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606786174;
        bh=bn+t73NCcKbHDuxJ+TbX4uW/Gg8nVTmjkkki83n51R4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UEjV/v7LcZlAsHyw3Sn6AfwyYN2sWr5VVHkx5HFOp/a3PEIYDC/QwWMasKfhcr3h2
         Qg1vhSFa1kdBguFKJ9yg1enhPJ8xG2uscAgwzRQxR0ylCTCUgFAvFlJ4crN++IL/y8
         GJ8wFA9dQTct5XG53E7/uWXgSD+54WJvu+abnJkk=
Date:   Tue, 1 Dec 2020 09:29:28 +0800
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
Subject: Re: [PATCH v4 0/3] mainline Protonic WD3 board
Message-ID: <20201201012927.GS4072@dragon>
References: <20201117131354.30943-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117131354.30943-1-o.rempel@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 02:13:51PM +0100, Oleksij Rempel wrote:
> changes v4:
> - spell fix for "virtual"
> - change SPI CAN freq to 10MHz
> - change SPI CAN irq from IRQ_TYPE_EDGE_FALLING to IRQ_TYPE_LEVEL_LOW 
> 
> changes v3:
> - fix checkpatch varnings
> - add "virtual" to the vendor-prefixes.yaml 
> 
> changes v2:
> - fix comment: WD2 -> WD3
> 
> Oleksij Rempel (3):
>   dt-bindings: vendor-prefixes: add "virtual" prefix
>   dt-bindings: arm: fsl: add Protonic WD3 board
>   ARM: dts: add Protonic WD3 board

Applied all, thanks.
