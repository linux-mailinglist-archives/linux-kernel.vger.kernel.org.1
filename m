Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 037E92A00E3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 10:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgJ3JMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 05:12:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:38636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726078AbgJ3JMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 05:12:52 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26E4520728;
        Fri, 30 Oct 2020 09:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604049164;
        bh=OCUzmfAICPWJuNm1mt/LB7h7TgwOoUibWkeJT+4OYR8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G0rgKdRXQxFLwqRGekKK52Ux5/VvTq9LOpvhdx2ddlCLTtrrl5S0DaXIQKFK4NZs9
         von0MZ4YdKZtxyvKe7mSLcZy7B+xFKsQGraqVRs5meWJ7N2VSv6DZzZtYlbqleN0x/
         GCrqZkHz3scuwqCBTX3/YkeAd4JBGr/0XHZhQ6yQ=
Date:   Fri, 30 Oct 2020 17:12:38 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>
Subject: Re: [PATCH v1 2/3] dt-bindings: arm: fsl: add Altesco I6P board
Message-ID: <20201030091238.GQ28755@dragon>
References: <20201012072452.14021-1-o.rempel@pengutronix.de>
 <20201012072452.14021-2-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012072452.14021-2-o.rempel@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 09:24:51AM +0200, Oleksij Rempel wrote:
> Add Altus-Escon-Company BV I6P iMX6dl based board
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Doesn't apply for me.

Shawn
