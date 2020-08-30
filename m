Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7A2256B13
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Aug 2020 03:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728577AbgH3BsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Aug 2020 21:48:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:36082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728246AbgH3BsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 21:48:15 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF5EF2075B;
        Sun, 30 Aug 2020 01:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598752095;
        bh=1I+i4+rqm6zHc0ewvJJgaTnjDlBAflw6Oqwa52XKff4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2YurlhNJCa9iIM15ZMV65NscbeITb0UGSnkdx/DVijbHRV7oMqQtOlTwLkuod1564
         6c+jb76ZPJnFczepai09WKVO/F6tWGuamgZ3d3HooXDOUHfbUYbyYCkBercgKRnPuG
         BAoBRLorP3CuK2W9LG35RiiDsj2+jbufXB1g7MNM=
Date:   Sun, 30 Aug 2020 09:48:10 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx6q-kontron-samx6i: Remove old
 fsl,spi-num-chipselects
Message-ID: <20200830014810.GD32096@dragon>
References: <20200823084920.3723-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200823084920.3723-1-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 23, 2020 at 10:49:20AM +0200, Krzysztof Kozlowski wrote:
> The property "fsl,spi-num-chipselects" is gone since commit 790739c4417c
> ("dt-bindings: spi: Convert imx cspi to json-schema").
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied, thanks.
