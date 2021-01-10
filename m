Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27B912F0731
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 13:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbhAJM1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 07:27:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:53604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726418AbhAJM1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 07:27:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B17E224D2;
        Sun, 10 Jan 2021 12:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610281585;
        bh=wgwc5pZ2wCCwctYNUxDibkCWCm5JG3BzKhsS7z1kKsA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lB6rDrVh0s1UqTJrtDyLDg3nJ0JsycKE19vLrBzn6EPcwPk6QQHyehPg1tHkm5YI5
         RJgxg0bTZURHP+aYWGU5H12LQkwOjHGfBPT+hwdmfDTt6TiQ6VoQsbYPBlMAZxGmwD
         2SbrQRmDCobvQGESjQGE5AnJkKSftRW6xsmUHfsBNFYmof941dJdt8bpipcXOEa/Hp
         Tqoq27/7AUo3vRAlK9PhzsxuC5QiF2Eu5CTPZByup70RTIQTgPzGK7hQkQJTpz1SFh
         cfPZSvO3OLFE/XxPUsELv6DIf0Kc1ubRGEAwJBHYfd0wapZu75uShfd1/MadAEzpOp
         DxdZTDY9t+hKA==
Date:   Sun, 10 Jan 2021 20:26:18 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Martin Kepplinger <martink@posteo.de>,
        Angus Ainslie <angus@akkea.ca>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Li Yang <leoyang.li@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Vinod Koul <vkoul@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Config and device tree updates for the Librem 5
 devkit
Message-ID: <20210110122617.GM28365@dragon>
References: <cover.1608216796.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1608216796.git.agx@sigxcpu.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 17, 2020 at 04:13:11PM +0100, Guido Günther wrote:
> This enables more components to get a working display, panel, audio and
> sensors. It also updates some device tree bits to make mainline boot.
> 
> I've skipped wifi (which needs some more driver work) and devfreq (since Martin
> is working on that).
> 
> The config changes don't depend on the DT parts so could be applied
> independently. The series was tested against next-20201214 and i made sure the
> defconfig changes also apply on top of shawnguo/imx/defconfig.

Sorry.  It doesn't apply any more.

Shawn
