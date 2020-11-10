Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11D372ACB58
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 03:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729874AbgKJCzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 21:55:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:42742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727311AbgKJCzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 21:55:50 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA40C206ED;
        Tue, 10 Nov 2020 02:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604976949;
        bh=4ZuOgP2PG3VtfYqTVc8LgcKtv1OdmBmrbgi2dZj79jI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qek1Hxz34FDbIUzMp9wSQwHhGBs3V7/YKnsygSRqe/4/dwsDTIDam1PMrVpT5L1LR
         PUR2uA83yHow7v/2dzLqiXhQIBLgmS64z6D0kZkHza0UsrIVSmVEiJVg0VnWf5m9W+
         cQ5H+tRqDOHakQc8axVqTeVDTWmp6gNMEU5dfGa0=
Date:   Tue, 10 Nov 2020 10:55:42 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        krzk@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 1/3] dt-bindings: arm: fsl: Add
 beacon,imx8mn-beacon-kit
Message-ID: <20201110025542.GX31601@dragon>
References: <20201107144811.1977108-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201107144811.1977108-1-aford173@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 07, 2020 at 08:48:08AM -0600, Adam Ford wrote:
> Add beacon,imx8mn-beacon-kit to list of compatible options.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied all, thanks.
