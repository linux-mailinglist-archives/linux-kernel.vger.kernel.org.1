Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 391FD1F8ABA
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jun 2020 22:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbgFNUlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Jun 2020 16:41:46 -0400
Received: from smtprelay0112.hostedemail.com ([216.40.44.112]:42896 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726648AbgFNUlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 16:41:45 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 79E4F15E7;
        Sun, 14 Jun 2020 20:41:44 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:968:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3867:3870:3871:4321:4605:5007:9121:10004:10400:10848:11026:11232:11233:11473:11657:11658:11914:12043:12048:12296:12297:12438:12679:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21433:21451:21627:21990:30012:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: error76_4e1659226df0
X-Filterd-Recvd-Size: 1906
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Sun, 14 Jun 2020 20:41:42 +0000 (UTC)
Message-ID: <48891eaf60c5e0c449e573a906894db2c3a7b72c.camel@perches.com>
Subject: Re: [PATCH] drm/mediatek: remove unnecessary conversion to bool
From:   Joe Perches <joe@perches.com>
To:     Bernard Zhao <bernard@vivo.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
Date:   Sun, 14 Jun 2020 13:41:41 -0700
In-Reply-To: <20200612124007.4990-1-bernard@vivo.com>
References: <20200612124007.4990-1-bernard@vivo.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-06-12 at 20:40 +0800, Bernard Zhao wrote:
> In function mtk_dsi_clk_hs_state, remove unnecessary conversion
> to bool return, this change is to make the code a bit readable.
[]
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
[]
> @@ -319,7 +319,7 @@ static bool mtk_dsi_clk_hs_state(struct mtk_dsi *dsi)
>  	u32 tmp_reg1;
>  
>  	tmp_reg1 = readl(dsi->regs + DSI_PHY_LCCON);
> -	return ((tmp_reg1 & LC_HS_TX_EN) == 1) ? true : false;
> +	return ((tmp_reg1 & LC_HS_TX_EN) == 1);

Given:

drivers/gpu/drm/mediatek/mtk_dsi.c:#define LC_HS_TX_EN                  BIT(0)

This is likely clearer as

	return tmp_reg1 & LC_HS_TX_EN;

or even

static bool mtk_dsi_clk_hs_state(struct mtk_dsi *dsi)
{
	return readl(dsi->regs + DSI_PHY_LCCON) & LC_HS_TX_EN;
}


