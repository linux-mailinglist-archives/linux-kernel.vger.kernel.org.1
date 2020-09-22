Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B55D7273AE3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 08:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbgIVG20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 02:28:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:42684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728603AbgIVG20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 02:28:26 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A7B223A34;
        Tue, 22 Sep 2020 06:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600756106;
        bh=HscVOOp+KLBjfMSoOu4ckBdI6IuOBLqG4IhGjEQuIhE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MwWzqQS1FGmg+cEozW4/p5iiOS6TsrOpHb9YOPWvSaUf7adAVCWXwxjX/jHJ1qzvt
         zD6X3CjSl3Kzy35UnS4x2zCebeYgLoCs9PzIE+SfdbUFrDt80Sxyi58BUsI9DtldO2
         B5u0idPbeNYmUFdPtDTo+DIOmPxnMWYi9fCPGZ4w=
Date:   Tue, 22 Sep 2020 14:28:20 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mm-var-som-symphony: fix ptn5150
 interrupts
Message-ID: <20200922062819.GD25109@dragon>
References: <20200917184131.2087-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917184131.2087-1-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 08:41:31PM +0200, Krzysztof Kozlowski wrote:
> Conversion of int-gpios into interrupts property requires also
> interrupt-parent and uses different flags.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied, thanks.
