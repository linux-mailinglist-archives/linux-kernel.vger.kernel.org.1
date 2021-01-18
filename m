Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 138772FA564
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 16:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406101AbhARP5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 10:57:16 -0500
Received: from foss.arm.com ([217.140.110.172]:38426 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405992AbhARPyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 10:54:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC96E31B;
        Mon, 18 Jan 2021 07:53:28 -0800 (PST)
Received: from slackpad.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 061FA3F68F;
        Mon, 18 Jan 2021 07:53:26 -0800 (PST)
Date:   Mon, 18 Jan 2021 15:52:28 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Icenowy Zheng <icenowy@aosc.io>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Shuosheng Huang <huangshuosheng@allwinnertech.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 02/21] mmc: sunxi: add support for A100 mmc
 controller
Message-ID: <20210118155228.3bd0e909@slackpad.fritz.box>
In-Reply-To: <20210118132854.yiwn7rnvcyexgqim@gilmour>
References: <20210118020848.11721-1-andre.przywara@arm.com>
        <20210118020848.11721-3-andre.przywara@arm.com>
        <20210118132854.yiwn7rnvcyexgqim@gilmour>
Organization: Arm Ltd.
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jan 2021 14:28:54 +0100
Maxime Ripard <maxime@cerno.tech> wrote:

Hi Maxime,

> On Mon, Jan 18, 2021 at 02:08:29AM +0000, Andre Przywara wrote:
> > From: Yangtao Li <frank@allwinnertech.com>
> > 
> > This patch adds support for A100 MMC controller, which use word
> > address for internal dma.
> > 
> > Signed-off-by: Yangtao Li <frank@allwinnertech.com>
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>  
> 
> We should also disable the timings setup in probe to derive them from
> the DT. This is causing issues on some SoCs already, so it would be
> best to not make the situation worse

But only for those new SoCs, where we have the speed modes in the DT
in every case (so only new ones)? And this disabling would be
SoC/compatible string dependent? Happy to send a patch later if that is
what you were thinking about.

Also I was wondering about the voltage dependent speed modes: At the
moment the driver declares both MMC_CAP_1_8V_DDR and MMC_CAP_3_3V_DDR,
so I mimic this in the .dtsi. However in the eventual DTB this looks
somewhat dodgy, since most boards only support one of those voltages. Do
we ignore this, and rely on the vqmmc-supply to limit this choice?

Cheers,
Andre

Btw: This patch is already in Ulf's -next tree, I just included it here
for the sake of completeness. Is that a problem? I don't think it
affects the build, so we don't care too much? 
