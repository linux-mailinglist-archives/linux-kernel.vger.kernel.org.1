Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC19E27868E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 14:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbgIYMCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 08:02:32 -0400
Received: from smtprelay0152.hostedemail.com ([216.40.44.152]:39266 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727521AbgIYMCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 08:02:31 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id B368518225647;
        Fri, 25 Sep 2020 12:02:30 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:968:988:989:1260:1277:1311:1313:1314:1345:1359:1381:1437:1515:1516:1518:1534:1539:1567:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3865:3866:3867:3868:3871:4250:4321:5007:6691:6737:10004:10400:10848:11026:11232:11473:11657:11658:11914:12043:12048:12296:12297:12740:12760:12895:13069:13161:13229:13311:13357:13439:14659:14721:21080:21451:21627:30012:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: apple13_2f1784c27167
X-Filterd-Recvd-Size: 1751
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Fri, 25 Sep 2020 12:02:28 +0000 (UTC)
Message-ID: <c28eae83c4297e14ed039eb00154d3a7e0fddaaa.camel@perches.com>
Subject: Re: [PATCH] drm/stm: dsi: Use dev_ based logging
From:   Joe Perches <joe@perches.com>
To:     Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Antonio Borneo <antonio.borneo@st.com>,
        Vincent Abriou <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        dri-devel@lists.freedesktop.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Fri, 25 Sep 2020 05:02:27 -0700
In-Reply-To: <20200925102233.18016-1-yannick.fertre@st.com>
References: <20200925102233.18016-1-yannick.fertre@st.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-09-25 at 12:22 +0200, Yannick Fertre wrote:
> Standardize on the dev_ based logging and drop the include of drm_print.h.
> Remove useless dsi_color_from_mipi function.
[]
> diff --git a/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c b/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
[]
> -	DRM_DEBUG_DRIVER("pll_in %ukHz pll_out %ukHz lane_mbps %uMHz\n",
> -			 pll_in_khz, pll_out_khz, *lane_mbps);
> +	dev_dbg(dsi->dev, "pll_in %ukHz pll_out %ukHz lane_mbps %uMHz\n", pll_in_khz, pll_out_khz,
> +		*lane_mbps);

The line wrapping change here is pretty pointless and IMO
makes the code harder to read.


