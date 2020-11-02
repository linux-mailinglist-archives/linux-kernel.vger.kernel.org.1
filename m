Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2BAC2A3748
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 00:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbgKBXoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 18:44:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:35366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725841AbgKBXoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 18:44:22 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24E212225E;
        Mon,  2 Nov 2020 23:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604360661;
        bh=6dQeEHNRivKvvKfr0iWhs+r+1C8zgEBblMgxv46Uq4s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1L69nY9ar12AVu5Rp+5aFzJaXzmENXWovblmwhWeDJ6MX9ZDRacb190ijsyN85iEI
         JQKmLw16ialwO6sT22Dlxnqhw39//zaRQjv1aBW5nPTBLctabuWbWmNt4O0uTK3np1
         mpuTR2yGda/X/IH2sss2x2rufTiYRRzahT+Bp2lg=
Date:   Tue, 3 Nov 2020 07:44:16 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/2] arm64: dts: imx8mq: Configure clock rate for
 audio plls
Message-ID: <20201102234416.GX31601@dragon>
References: <1604283077-27012-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604283077-27012-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 10:11:16AM +0800, Shengjiu Wang wrote:
> Configure clock rate for audio plls. audio pll1 is used
> as parent clock for clocks that is multiple of 8kHz.
> audio pll2 is used as parent clock for clocks that is
> multiple of 11kHz.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Applied both, thanks.
