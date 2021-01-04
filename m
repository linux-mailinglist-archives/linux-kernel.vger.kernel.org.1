Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 376D12E9486
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 13:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbhADMGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 07:06:00 -0500
Received: from inva021.nxp.com ([92.121.34.21]:46640 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbhADMGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 07:06:00 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BA36C201F31;
        Mon,  4 Jan 2021 13:05:12 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id ACE1F200F26;
        Mon,  4 Jan 2021 13:05:12 +0100 (CET)
Received: from localhost (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 98FA820347;
        Mon,  4 Jan 2021 13:05:12 +0100 (CET)
Date:   Mon, 4 Jan 2021 14:05:12 +0200
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Martin Kepplinger <martin.kepplinger@puri.sm>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Revert "clk: imx: fix composite peripheral flags"
Message-ID: <20210104120512.gmi2zjz7dzhjussp@fsr-ub1664-175>
References: <20201231142149.26062-1-martin.kepplinger@puri.sm>
 <CAOMZO5Bq5Qs90iZQTpouv5wW_xf0CQcP-i-+c-Jp-_Ftvhknnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5Bq5Qs90iZQTpouv5wW_xf0CQcP-i-+c-Jp-_Ftvhknnw@mail.gmail.com>
User-Agent: NeoMutt/20180622
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-12-31 17:33:40, Fabio Estevam wrote:
> Hi Martin,
> 
> On Thu, Dec 31, 2020 at 11:22 AM Martin Kepplinger
> <martin.kepplinger@puri.sm> wrote:
> >
> > This reverts commit 936c383673b9e3007432f17140ac62de53d87db9.
> >
> > It breaks clock reparenting via devfreq on the imx8mq used in the
> > Librem 5 phone. When switching dram frequency (which worked before)
> > the system now hangs after this where the dram_apb clock cannot be
> > set:
> >
> > [  129.391755] imx8m-ddrc-devfreq 3d400000.memory-controller: failed to
> > set dram_apb parent: -16
> > [  129.391959] imx8m-ddrc-devfreq 3d400000.memory-controller: ddrc
> > failed freq switch to 25000000 from 800000000: error -16. now at 25000000
> > [  129.406133] imx8m-ddrc-devfreq 3d400000.memory-controller: failed to
> > update frequency from PM QoS (-16)
> 
> I am wondering whether IMX8MQ_CLK_DRAM_ALT should also be marked as
> CLK_IS_CRITICAL.
> 

Hmm, the way the DRAM clocks are right registered right now is a real mess.
The DRAM clocks on i.MX8M are changed in TF-A, but the kernel still needs to
register them to keep track of the clock tree.

Martin, I already have a patchset waiting to be shipped which doesn't 
only fix the 8MQ, but all the 8M platforms. Unfortunately, I haven't had the time
to work on that in the last couple of weeks but I intend to switch back to it soon.

Fabio, marking the DRAM clocks as critical will not allow the set_parent to be done,
as CLK_IS_CRITICAL flag and set_parent do not go together. As of now the devfreq
tries to reparent to be consistent with TF-A configuration.

My approach here was to make the DRAM clocks read-only. This means adding some 
stuff in the clock core subsystem too.

> Could you please try the following change without the revert?
> 
> --- a/drivers/clk/imx/clk-imx8mq.c
> +++ b/drivers/clk/imx/clk-imx8mq.c
> @@ -458,7 +458,7 @@ static int imx8mq_clocks_probe(struct platform_device *pdev)
>          * Mark with GET_RATE_NOCACHE to always read div value from hardware
>          */
>         hws[IMX8MQ_CLK_DRAM_CORE] =
> imx_clk_hw_mux2_flags("dram_core_clk", base + 0x9800, 24, 1,
> imx8mq_dram_core_sels, ARRAY_SIZE(imx8mq_dram_core_sels),
> CLK_IS_CRITICAL);
> -       hws[IMX8MQ_CLK_DRAM_ALT] =
> __imx8m_clk_hw_composite("dram_alt", imx8mq_dram_alt_sels, base +
> 0xa000, CLK_GET_RATE_NOCACHE);
> +       hws[IMX8MQ_CLK_DRAM_ALT] =
> __imx8m_clk_hw_composite("dram_alt", imx8mq_dram_alt_sels, base +
> 0xa000, CLK_IS_CRITICAL | CLK_GET_RATE_NOCACHE);
>         hws[IMX8MQ_CLK_DRAM_APB] =
> __imx8m_clk_hw_composite("dram_apb", imx8mq_dram_apb_sels, base +
> 0xa080, CLK_IS_CRITICAL | CLK_GET_RATE_NOCACHE);
> 
> Thanks
