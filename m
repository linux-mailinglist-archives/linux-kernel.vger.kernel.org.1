Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27EF61A0EF9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 16:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbgDGOQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Apr 2020 10:16:35 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:42430 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728861AbgDGOQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 10:16:35 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B59B859E;
        Tue,  7 Apr 2020 16:16:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1586268993;
        bh=CcU2iAia1wY4OY0Wlixli88UQl/oDVQJd3BN2oHVZs4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hyx/r2qvOlhW/upsn1igaKv3oxlLGcSnhX+2DoQ0FH+lQrwx8zYoWNsqDWEBT4CKj
         oPNY9yZdASHuEJaHeFRyZAnMLIC3Fo9mHavnwXkFOAwGBriB9/5rKXn/AP7AqGoVFv
         r5MsZwh13hLhgZBGK7HbMd3B5QlAYYCZcPkHptlA=
Date:   Tue, 7 Apr 2020 17:16:24 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Max Krummenacher <max.oss.09@gmail.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Will Deacon <will@kernel.org>, Vidya Sagar <vidyas@nvidia.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Olof Johansson <olof@lixom.net>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH 0/4] defconfig: fix changed configs and refresh
Message-ID: <20200407141624.GG4751@pendragon.ideasonboard.com>
References: <20200407103537.4138-1-max.krummenacher@toradex.com>
 <CAMuHMdWrekHiADkMmgO5nDxFNYjLud7FD=7ArMZNQire_+7TQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMuHMdWrekHiADkMmgO5nDxFNYjLud7FD=7ArMZNQire_+7TQg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Tue, Apr 07, 2020 at 03:16:14PM +0200, Geert Uytterhoeven wrote:
> On Tue, Apr 7, 2020 at 12:36 PM Max Krummenacher <max.oss.09@gmail.com> wrote:
> > Three configs have been renamed and/or changed behaviour.
> > Clean that by using the new config name.
> > Then refresh the defconfig with make defconfig savedefconfig.
> >
> > The refreshed defconfig does result in a not changed .config.
> >
> > Applies on linux-next/master tag: next-20200407
> >
> > Max Krummenacher (4):
> >   arm64: defconfig: DRM_DUMB_VGA_DAC: follow changed config symbol name
> >   arm64: defconfig: PCIE_TEGRA194: follow changed config symbol name
> >   arm64: defconfig: ARCH_R8A7795: follow changed config symbol name
> >   arm64: defconfig: refresh
> 
> Probably CONFIG_DRM_DISPLAY_CONNECTOR should also be enabled for HDMI,
> VGA, and composite display connectors on various boards since commit
> 0c275c30176b2e78 ("drm/bridge: Add bridge driver for display
> connectors"), but it's not clear to me when exactly this became a
> requirement, as before there was no code that looked for e.g.
> vga-connector.
> Laurent?

It's not required yet for R-Car DU, but I'm working on changing that :-)
If we can enable CONFIG_DRM_DISPLAY_CONNECTOR in defconfig as part of
this series, it would be useful for me.

-- 
Regards,

Laurent Pinchart
