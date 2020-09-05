Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF88325E4F6
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Sep 2020 03:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbgIEBfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 21:35:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:55180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbgIEBfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 21:35:44 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CBB2206E7;
        Sat,  5 Sep 2020 01:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599269744;
        bh=ogeKoV6w2E9LzttKLM8WXU9zWl4hKbp92c4RbE/Ki+M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I6TKkDNOrns6RH3FsMwK3jUS5W4pfnY60zCF9wGrCJPDo8jcSPdP1JLBAywltYsBc
         DpIb4zovHyedPUIMKKR7Nq/SAfFQKfWXoPUN6C90JkJpOWniHmDCuYsfN976X1bWzv
         awa8zHW/baQ87+a2e3GtKyrxxyTvhUZLhbJlXWxU=
Date:   Sat, 5 Sep 2020 09:35:39 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     peng.fan@nxp.com
Cc:     sboyd@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, abel.vesa@nxp.com,
        Anson.Huang@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: imx: fix composite peripheral flags
Message-ID: <20200905013538.GB7508@dragon>
References: <20200826071407.10543-1-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826071407.10543-1-peng.fan@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 03:14:07PM +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> According to RM, for peripheral clock slice,
> "IP clock slices must be stopped to change the clock source.".
> 
> So we must have CLK_SET_PARENT_GATE flag to avoid glitch.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks.
