Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F328629EE91
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 15:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbgJ2Omx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 10:42:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:56388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbgJ2Omh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 10:42:37 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0EBA20838;
        Thu, 29 Oct 2020 14:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603982539;
        bh=6RBN8Kg5rl5f9b8QXPgb4uFFk5IdGTlv2YKs82xXJB4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gVv6frS6pXab5N6ek2X6ub8Sz5HurZdzN3UxRw4jeMjnUwoDfwpI/RmR6rxSvC9Hj
         SdJyAb5hIDHAzdvUzKUkOnVbFBlmt/6qpDHQ7mn+SwUyRjlVmFFNUY9P9Qc85BT663
         meKeKtCX/PCSBFKM04IJgXOD9v6mbSrS03QSyTs0=
Date:   Thu, 29 Oct 2020 22:42:12 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Robert Jones <rjones@gateworks.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 06/14] dt-bindings: arm: fsl: document i.MX25 and i.MX27
 boards
Message-ID: <20201029144211.GR28755@dragon>
References: <20200926162811.5335-1-krzk@kernel.org>
 <20200926162811.5335-6-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200926162811.5335-6-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 26, 2020 at 06:28:03PM +0200, Krzysztof Kozlowski wrote:
> Document and adjust the compatibles for i.MX25 and i.MX27 based boards
> to fix dtbs_check warnings like:
> 
>   arch/arm/boot/dts/imx27-apf27dev.dt.yaml: /: compatible:
>     ['armadeus,imx27-apf27dev', 'armadeus,imx27-apf27', 'fsl,imx27'] is not valid under any of the given schemas
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied, thanks.
