Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58AD3273B08
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 08:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729461AbgIVGlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 02:41:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:47220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729222AbgIVGlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 02:41:06 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39915208A9;
        Tue, 22 Sep 2020 06:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600756866;
        bh=fpjEKO0HEwKVPJVEg6fnVWA4DnHuAPPahJEOFfNsJ+8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YDz5fyaWjfQOOxQBPCsSpHZgxRgTp3lFkibp1h73W9J+tF4HpTSnSdTl9bJZglV15
         QRbPkzsPTDR7oVY+STeBfOULnE24qqLWKkzFYPylSv0R+5gJbFwPtZTI4/6GLF0lXj
         lzgJZbvqm0Uem9hzkyBpix4oXzvRvEw+nVGFpzAc=
Date:   Tue, 22 Sep 2020 14:40:59 +0800
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
        Jacky Bai <ping.bai@nxp.com>, Robin Gong <yibin.gong@nxp.com>,
        Peter Chen <peter.chen@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tim Harvey <tharvey@gateworks.com>
Subject: Re: [PATCH v2 1/4] ARM: dts: imx6qdl-gw5xxx: correct interrupt flags
Message-ID: <20200922064058.GE25109@dragon>
References: <20200917185449.5687-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917185449.5687-1-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 08:54:46PM +0200, Krzysztof Kozlowski wrote:
> GPIO_ACTIVE_x flags are not correct in the context of interrupt flags.
> These are simple defines so they could be used in DTS but they will not
> have the same meaning:
> 1. GPIO_ACTIVE_HIGH = 0 = IRQ_TYPE_NONE
> 2. GPIO_ACTIVE_LOW  = 1 = IRQ_TYPE_EDGE_RISING
> 
> Correct the interrupt flags, assuming the author of the code wanted same
> logical behavior behind the name "ACTIVE_xxx", this is:
>   ACTIVE_LOW  => IRQ_TYPE_LEVEL_LOW
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied all, thanks.
