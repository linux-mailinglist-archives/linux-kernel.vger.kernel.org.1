Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05DFA25E5AF
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Sep 2020 08:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgIEGNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Sep 2020 02:13:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:47862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbgIEGNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 02:13:43 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E892208DB;
        Sat,  5 Sep 2020 06:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599286423;
        bh=gF8z6IMg04Hohcdpu5CQHq7CjyqhOzXb2nz5Nbkx1o4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=achJHD1BwLksR8o/3miSjDGfRBwoIDvs4LWt4X1743GTvJxhe2NpLD9tGmHdHBuap
         VhvwptGRzDRwALRMnI8x06RVKtiC0LpmKbvCWr4cN8ufUaf4ZZJsXFrmJKXS3048VR
         FlR/QGQKpLqrzk6LgGtWPMa7daEsg7N/cGOJTSHQ=
Date:   Sat, 5 Sep 2020 14:13:37 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Han Xu <han.xu@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 09/19] arm64: dts: imx8mm-evk: Align pin configuration
 group names with schema
Message-ID: <20200905061336.GC9261@dragon>
References: <20200828164750.10377-1-krzk@kernel.org>
 <20200828164750.10377-10-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828164750.10377-10-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 06:47:40PM +0200, Krzysztof Kozlowski wrote:
> Device tree schema expects pin configuration groups to end with 'grp'
> suffix, otherwise dtbs_check complain with a warning like:
> 
>     ... do not match any of the regexes: 'grp$', 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied #9 ~ #19, thanks.
