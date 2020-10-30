Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 599CE29F9A2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 01:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbgJ3A0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 20:26:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:48698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbgJ3A0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 20:26:08 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B87A20709;
        Fri, 30 Oct 2020 00:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604017568;
        bh=PVuEUx7OxZu9aTr2T26kbiAfiPfZsT0Ot66Xi+NQ36U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LzJWYWIdswRdY1du3F68J/VmtQSOkCd3gCs8gaaSayxtBn/7Vgb7+W6riddb1vJA2
         UTfLxdv7tAivslQ5oyLUpEGQGZzued5iUyNlk1xAKgsoD8RRrVJlmgx018y7Egeu/B
         QO9U2Yhesn13qNJ9yaEmhc0k3i3tOVWMQ+F4Ij1g=
Date:   Fri, 30 Oct 2020 08:26:01 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Adam Ford <aford173@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Peter Chen <peter.chen@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] arm64: dts: imx8mm-var-som: fix missing PMIC's
 interrupt line pull-up
Message-ID: <20201030002601.GW28755@dragon>
References: <20200927165947.7317-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200927165947.7317-1-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 27, 2020 at 06:59:42PM +0200, Krzysztof Kozlowski wrote:
> The PMIC's interrupt is level low and should be pulled up.  The PMIC's
> device node had pinctrl-0 property but it lacked pinctrl-names which
> is required to apply the pin configuration.  The actual problem in DTS
> was pointed out by Felix Radensky from Variscite.
> 
> Reported-by: Felix Radensky <felix.r@variscite.com>
> Fixes: 5f67317bd967 ("arm64: dts: imx8mm: correct interrupt flags")
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied all, thanks.
