Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74186256E12
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Aug 2020 15:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbgH3NQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Aug 2020 09:16:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:34418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728911AbgH3NQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 09:16:33 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29E29206FA;
        Sun, 30 Aug 2020 13:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598793393;
        bh=QIHti4fzrTTRrC5YYUzy/q6isrvYJdx1GM7ladRfNJ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jKEKPVozdfekayquSnLbBLcpBcnTWd0G6yjBQkQA5ROqOimHdYy8WESq8cx1IvDAc
         dhwJwg5SRhkQlJmtAr324K42ZYHmKr4bSe64DwTSDwPGvZwRQ2gBw41DO83L+lhoYe
         nm+k3HO2xw+OBn4myJdvO4aoNaECiCanoEoiJeHU=
Date:   Sun, 30 Aug 2020 21:16:28 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Adam Ford <aford173@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mm-beacon-baseboard: Correct LED default
 state
Message-ID: <20200830131627.GM32096@dragon>
References: <20200824071546.10050-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824071546.10050-1-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 09:15:46AM +0200, Krzysztof Kozlowski wrote:
> There is no LED default state "none".  leds-gpio driver maps it to
> "off", so correct them to fix dtbs_check warnings like:
> 
>   arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dt.yaml:
>     leds: led0:default-state:0: 'none' is not one of ['on', 'off', 'keep']
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied, thanks.
