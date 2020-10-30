Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C43CB2A02FF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 11:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgJ3Ke6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 06:34:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:60752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbgJ3Ke6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 06:34:58 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E554C20704;
        Fri, 30 Oct 2020 10:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604054097;
        bh=dH/Euy84o8UAK6ZWf2evrfdJN2070vU7e+DONC1HjU0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2FxmcBZeAumkCwIR+WD1V3Ity4QOnJ+X8IY0pyUPDJGqIa9e5VMRud/7w2mS5F4br
         puB16ElAhqhzV24NCk32SoQshv/jPGqdpIe+pUVhLnHTNYh2Bgv0Xfie/RNRjGbD4r
         Z+ymhqPKKslf/J8O5ratBR+SHombmiqmWQzNNN5w=
Date:   Fri, 30 Oct 2020 18:34:49 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, krzk@kernel.org, aford173@gmail.com,
        daniel.baluta@nxp.com, shengjiu.wang@nxp.com, peter.chen@nxp.com,
        alifer.wsdm@gmail.com, abel.vesa@nxp.com, yibin.gong@nxp.com,
        jun.li@nxp.com, l.stach@pengutronix.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH V2 1/3] arm64: dts: imx8mm: Correct WDOG_B pin
 configuration
Message-ID: <20201030103449.GR28755@dragon>
References: <1602506642-5262-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1602506642-5262-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 08:44:00PM +0800, Anson Huang wrote:
> Different revision of i.MX8MM EVK boards may have different external
> pull up registor design, some are enabled while some are NOT, to make
> sure the WDOG_B pin works properly, better to enable internal pull up
> resistor. Since enabling internal pull up resistor is NOT harmful and
> having benefit of flexibility on different board design, just enable
> it for all i.MX8MM boards; And schmitt input is NOT necessary for this
> WDOG_B output pin, so remove it; Open drain outputs provide more
> flexibility to a designer as they can be pulled-up to any voltage found
> in the system, so enable it as well.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied all, thanks.
