Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D85B52F07C5
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 16:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbhAJPHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 10:07:40 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:33372 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbhAJPHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 10:07:39 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 8CE8BFB03;
        Sun, 10 Jan 2021 16:06:56 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id suGH5Iqrk0OG; Sun, 10 Jan 2021 16:06:55 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 19D4940885; Sun, 10 Jan 2021 16:06:55 +0100 (CET)
Date:   Sun, 10 Jan 2021 16:06:55 +0100
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Shawn Guo <shawnguo@kernel.org>
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
Message-ID: <20210110150654.GA9546@bogon.m.sigxcpu.org>
References: <cover.1608216796.git.agx@sigxcpu.org>
 <20210110122617.GM28365@dragon>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210110122617.GM28365@dragon>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,
On Sun, Jan 10, 2021 at 08:26:18PM +0800, Shawn Guo wrote:
> On Thu, Dec 17, 2020 at 04:13:11PM +0100, Guido Günther wrote:
> > This enables more components to get a working display, panel, audio and
> > sensors. It also updates some device tree bits to make mainline boot.
> > 
> > I've skipped wifi (which needs some more driver work) and devfreq (since Martin
> > is working on that).
> > 
> > The config changes don't depend on the DT parts so could be applied
> > independently. The series was tested against next-20201214 and i made sure the
> > defconfig changes also apply on top of shawnguo/imx/defconfig.
> 
> Sorry.  It doesn't apply any more.

v3 of this patch

    https://lore.kernel.org/linux-arm-kernel/5636a3d6e3217475e2a479248250d5c0e0a50e26.1610110514.git.agx@sigxcpu.org/)

applies for me on top of

    https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git/log/?h=imx/defconfig

(which is at 773fcbcdf9d66b4aec964238b613e93804cba24c) - am i looking at
the wrong tree?

Cheers and sorry for any inconvenience,
 -- Guido


> 
> Shawn
> 
