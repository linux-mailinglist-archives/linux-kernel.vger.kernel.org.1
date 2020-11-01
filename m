Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 848CC2A1CD4
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 10:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbgKAJXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 04:23:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:57630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbgKAJXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 04:23:34 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD78B208E4;
        Sun,  1 Nov 2020 09:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604222614;
        bh=7H90vvwhN0eN09/lcoRqbbV84xbyY7mylYi/+YQPp7U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BOR+KVSUGhlhod+Flv/hrUH8QfA+wi/SaXpESF3naFKn8knHcU2kDkE0byGZFn4Hq
         hFOLGnuj45gmUHF4XSjechMg1mhgku94hEoPfjHHrz/CuOxXK5mlwZUhF8rRyHcKS5
         JBLvae0kaAm0zB27IqqrWChCD4Yvz+peJmfeWRB8=
Date:   Sun, 1 Nov 2020 17:23:28 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Qinglang Miao <miaoqinglang@huawei.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: imx: add missing clk_disable_unprepare() when
 remove imx_mmdc
Message-ID: <20201101092328.GN31601@dragon>
References: <20201028091539.136026-1-miaoqinglang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028091539.136026-1-miaoqinglang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 05:15:39PM +0800, Qinglang Miao wrote:
> Clock source is prepared and enabled by clk_prepare_enable()
> in probe function, but no disable or unprepare in remove.
> 
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>

Applied, thanks.
