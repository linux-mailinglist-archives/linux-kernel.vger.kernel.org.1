Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBE5324EBFF
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Aug 2020 09:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbgHWHYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Aug 2020 03:24:16 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:50668 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725981AbgHWHYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 03:24:15 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id E92DEFB03;
        Sun, 23 Aug 2020 09:24:12 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id g5yiK_vwgfGA; Sun, 23 Aug 2020 09:24:11 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 6E50845869; Sun, 23 Aug 2020 09:24:11 +0200 (CEST)
Date:   Sun, 23 Aug 2020 09:24:11 +0200
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
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Anson Huang <Anson.Huang@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Li Jun <jun.li@nxp.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Walle <michael@walle.cc>,
        Olof Johansson <olof@lixom.net>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] arm64: defconfig: re-sync DRM related defconfig
 bits
Message-ID: <20200823072411.GA6867@bogon.m.sigxcpu.org>
References: <cover.1597913263.git.agx@sigxcpu.org>
 <e13be6f742ecdf06f7000af6e8e5ec5bcb65f7f0.1597913263.git.agx@sigxcpu.org>
 <20200823025622.GR30094@dragon>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200823025622.GR30094@dragon>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Sun, Aug 23, 2020 at 10:56:22AM +0800, Shawn Guo wrote:
> On Thu, Aug 20, 2020 at 10:50:58AM +0200, Guido Günther wrote:
> > This moves the CONFIG_DRM_SIMPLE_BRIDGE entry around making further
> > updates simpler.
> > 
> > Signed-off-by: Guido Günther <agx@sigxcpu.org>
> 
> Patch #3 and #4 do not apply to my branch.

Thanks for applying the other two already! I've rebased these against

  https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git/log/?h=imx/defconfig

in v4:

  https://lore.kernel.org/linux-devicetree/cover.1598166983.git.agx@sigxcpu.org/T/#t  

Cheers,
 -- Guido


> 
> Shawn
> 
