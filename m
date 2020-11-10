Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F18C2ACBE1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 04:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732068AbgKJDcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 22:32:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:48680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729451AbgKJDcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 22:32:51 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 574AA206E3;
        Tue, 10 Nov 2020 03:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604979171;
        bh=m16hqRdfFO2Sb0NGQY/rDLW8dSTrGnfkfA4FEkruTqQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hQ+qe2+LPDZWHXNGkGO+DoUdU/wZOd7JdSAQ1oSpbpPItukIH8gFE78/h6jx6QrOR
         yAcaI/BRCbyRTW0VnpNGS5jArhbURY87lM8K4aH2DnTpY7lRR8nQZHxhW7q0RTfFYn
         +lZ5D0kNWmnlDs1P83bRQwBVBfVYZbGfAyOVuA5A=
Date:   Tue, 10 Nov 2020 11:32:44 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        krzk@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 1/3] dt-bindings: arm: fsl: Add
 beacon,imx8mn-beacon-kit
Message-ID: <20201110033243.GA31601@dragon>
References: <20201107144811.1977108-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201107144811.1977108-1-aford173@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 07, 2020 at 08:48:08AM -0600, Adam Ford wrote:
> Add beacon,imx8mn-beacon-kit to list of compatible options.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

You need to stop posting patches that have dependency not accepted yet,
or explicitly mention the dependency.

Series dropped.

Shawn
