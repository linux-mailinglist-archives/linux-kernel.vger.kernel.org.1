Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF7B29FA0A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 01:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgJ3Ax4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 20:53:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:47954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbgJ3Axz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 20:53:55 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 356F92071A;
        Fri, 30 Oct 2020 00:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604019234;
        bh=ixHLV+fTwgMb8a/A6LIZCJqI/IPGrhbe30MM63wcufk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D97yxmsL5pkX3olIRWOoeBUigdpVDYyFOw9IsG7ZFP1XY5RiVz3udmXPd9p4yLKvL
         +KXs0obrSD41O4wc/ikIoHfjVaMXmGZ6MijnT3/NUUrI8DGByMQ691oRbzz4yTet8U
         TKLueECjfKvRDeKpv7InbnmEyi7mylvqmHHSroro=
Date:   Fri, 30 Oct 2020 08:53:48 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jacky Bai <ping.bai@nxp.com>
Subject: Re: [PATCH 1/3] arm64: dts: imx8mm: adjust GIC CPU mask to match
 number of CPUs
Message-ID: <20201030005347.GB28755@dragon>
References: <20200929084015.7178-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929084015.7178-1-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 10:40:13AM +0200, Krzysztof Kozlowski wrote:
> i.MX 8M Mini has four Cortex-A CPUs, not six.  Using higher value is
> harmless but adjust it to match real HW.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied all, thanks.
