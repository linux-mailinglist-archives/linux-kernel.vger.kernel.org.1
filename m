Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9572ACB7C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 04:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731358AbgKJDDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 22:03:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:44196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729452AbgKJDDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 22:03:31 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 411552064C;
        Tue, 10 Nov 2020 03:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604977410;
        bh=Ab2R0FlhuQ/r05BExeWdW4+U5IUFA0K+l5RwGjCmAe4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H4lB7kkF1NFHBheb9k2CeWmc7xpWV2nGNGx7oUZXGFJ/9fsGlhKfE/vdAF90VitDX
         VLNBKRNbkdcRU1EO/LJBBcX6ckNG3YkddG/eoTnwgI+IgK4Hvnar90GjPgtTMsshVP
         f5h7CEDqbw3qXIQBC2Z6uLj1MORq/CkYD6Zx4wLo=
Date:   Tue, 10 Nov 2020 11:03:25 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: imx: Fix imx8mm-kontron-n801x-s.dtb target
Message-ID: <20201110030324.GY31601@dragon>
References: <20201108022321.2114430-1-natechancellor@gmail.com>
 <20201108191614.4062210-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201108191614.4062210-1-natechancellor@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 08, 2020 at 12:16:15PM -0700, Nathan Chancellor wrote:
> While running 'make dtbs_install', the following error occurs:
> 
> make[3]: *** No rule to make target 'rootfs/freescale/imx8mm-kontron-n801x-s.dts', needed by '__dtbs_install'.
> 
> It should be .dtb, not .dts.
> 
> Fixes: 8668d8b2e67f ("arm64: dts: Add the Kontron i.MX8M Mini SoMs and baseboards")
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Applied, thanks.
