Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B356622F9C7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jul 2020 22:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbgG0UDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 16:03:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:45958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbgG0UDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 16:03:30 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64C162072E;
        Mon, 27 Jul 2020 20:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595880210;
        bh=mXVi6dNmeTTHEGhLpBn9kwB25pFNfvrXx1UPzS1ISEs=;
        h=Date:From:To:Cc:Subject:From;
        b=u5zsRUdq8hH6l+EscwKa4buoH5QG+mDT1k8i/sGMnD7kku/kLDrEXtG6bY8kaKuK0
         5qtsMZ/zdjsmrPvu5ldzw5E4+62aa50oPpaun70v/58lftuGVWBgDuZRto8+1DCivB
         j+0xpCAIvPKLDfeWaCgdy+P+heTw9N9yYNtGc2L0=
Date:   Mon, 27 Jul 2020 15:09:22 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH][next] clk: imx: Use fallthrough pseudo-keyword
Message-ID: <20200727200922.GA2326@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the existing /* fall through */ comments and its variants with
the new pseudo-keyword macro fallthrough[1].

[1] https://www.kernel.org/doc/html/v5.7/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/clk/imx/clk-pllv3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-pllv3.c b/drivers/clk/imx/clk-pllv3.c
index a7db93030e02..b20cdea3e9cc 100644
--- a/drivers/clk/imx/clk-pllv3.c
+++ b/drivers/clk/imx/clk-pllv3.c
@@ -433,7 +433,7 @@ struct clk_hw *imx_clk_hw_pllv3(enum imx_pllv3_type type, const char *name,
 		break;
 	case IMX_PLLV3_USB_VF610:
 		pll->div_shift = 1;
-		/* fall through */
+		fallthrough;
 	case IMX_PLLV3_USB:
 		ops = &clk_pllv3_ops;
 		pll->powerup_set = true;
@@ -441,7 +441,7 @@ struct clk_hw *imx_clk_hw_pllv3(enum imx_pllv3_type type, const char *name,
 	case IMX_PLLV3_AV_IMX7:
 		pll->num_offset = PLL_IMX7_NUM_OFFSET;
 		pll->denom_offset = PLL_IMX7_DENOM_OFFSET;
-		/* fall through */
+		fallthrough;
 	case IMX_PLLV3_AV:
 		ops = &clk_pllv3_av_ops;
 		break;
-- 
2.27.0

