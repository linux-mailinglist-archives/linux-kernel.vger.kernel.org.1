Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13F6825737B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 08:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgHaGEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 02:04:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:52900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbgHaGEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 02:04:07 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B544620707;
        Mon, 31 Aug 2020 06:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598853847;
        bh=NnBomJF+P1hXnoeqT9DRySTqDwl2STtl3QF9ZCVzzoM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S2+rh1rSWRWop5yL3AjWw91anQTqK3JTMTcf3tGTt+tVbB6O1ZZ30CXitQV7lDP8Y
         P4qCiRnSx3gA5lr2s1LHQyeivoTDFCa+hEhrse98rs+a34CyyiopIKmTf97COR82XS
         m9qBCM6ycq9nv0juFgZtaChYWlBUc6VLJa5deJjQ=
Date:   Mon, 31 Aug 2020 14:04:01 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mq: Fix TMU interrupt property
Message-ID: <20200831060401.GN4488@dragon>
References: <20200829111248.321-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200829111248.321-1-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 29, 2020 at 01:12:48PM +0200, Krzysztof Kozlowski wrote:
> "interrupt" is not a valid property.  Using proper name fixes dtbs_check
> warning:
> 
>   arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-zest.dt.yaml: tmu@30260000: 'interrupts' is a required property
> 
> Fixes: e464fd2ba4d4 ("arm64: dts: imx8mq: enable the multi sensor TMU")
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied, thanks.
