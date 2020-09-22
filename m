Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43D4127382B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 03:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbgIVBsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 21:48:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:39494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728726AbgIVBsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 21:48:02 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E5D6239D4;
        Tue, 22 Sep 2020 01:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600739282;
        bh=nAc+cN9M4yaRmZYF2ssJCz76Svk0YYkEZwLfchoxUOw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aYTqSWWAmRLvaPqGtGaHMscFCUPvwTIy1DWs+2o3rp0mIfG+62E6WASM70jv0+64O
         DU9bGuWUvx5qId3TEtUMpswYsu5zFYamfAvJPvC4renzd/ZByj3oWgJZnCUcYsCmvS
         lr4JJrNFXBuAg31c4pacXYsHbIJWDwLnvse8IdTU=
Date:   Tue, 22 Sep 2020 09:47:56 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: dts: imx8mm-var-som-symphony: Remove unneeded
 i2c3 properties
Message-ID: <20200922014755.GO25109@dragon>
References: <20200909151755.17783-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909151755.17783-1-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 09, 2020 at 05:17:53PM +0200, Krzysztof Kozlowski wrote:
> The i2c3 clock frequency and pin configuration are already set by
> imx8mm-var-som.dtsi.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied all, thanks.
