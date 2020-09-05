Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7251E25E612
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Sep 2020 10:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgIEIFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Sep 2020 04:05:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:59182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbgIEIFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 04:05:36 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 388852087C;
        Sat,  5 Sep 2020 08:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599293135;
        bh=swlplrjI3QNfeMVuhTr1PFxCION4Fl0IQNgnXjcUKG8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1XEfOM2eudn6bZaY8YpnGTlYkQLWl8PnhK6x1lc4kVLdtlos6ErofC6cEeIdQcHVO
         rlw7s8rWQoX2e6bx4D1r7D7s4Rn2FG6reosPTMYDPUuDTbyuMog+PNd2r2MFnfk9cG
         EBEpFyo0epOHE9fu7zbpNf/ydVZxDL+f2t9xn7/Y=
Date:   Sat, 5 Sep 2020 16:05:30 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 14/14] ARM: dts: imx28-m28: Align GPMI NAND node name
 with schema
Message-ID: <20200905080529.GS9261@dragon>
References: <20200904062743.6273-1-krzk@kernel.org>
 <20200904062743.6273-14-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904062743.6273-14-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 04, 2020 at 08:27:43AM +0200, Krzysztof Kozlowski wrote:
> Device tree schema expects NAND controller to be named
> "nand-controller", otherwise dtbs_check complain with a warning like:
> 
>     arch/arm/boot/dts/imx28-eukrea-mbmx283lc.dt.yaml: gpmi-nand@8000c000:
>         $nodename:0: 'gpmi-nand@8000c000' does not match '^nand-controller(@.*)?'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied, thanks. 
