Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5EB2A1CDC
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 10:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgKAJ1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 04:27:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:59290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbgKAJ1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 04:27:13 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37EFE20706;
        Sun,  1 Nov 2020 09:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604222833;
        bh=S148xYiDLkpqMjXcFmkJzuuhVelRZwJmOjteNJYXqKw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yOXZdPNQ8nzjrOJ1gSC+drld20Na0eN9i3SfWXg2wthRPYUH0p6oEG7DzIJ5w9xJk
         H/NtfnU45L2bcZ6y6NKRFQn6nL3hB/MuIpsHuTcg+lEOgky2liAVvwm15BgDmemjQz
         LKHyvDNB1r4VZU7xfZ90J/y1GdyAX9hGKzirxfsQ=
Date:   Sun, 1 Nov 2020 17:27:06 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: imx: remove redundant assignment to pointer np
Message-ID: <20201101092705.GO31601@dragon>
References: <20201029224007.390762-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029224007.390762-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 10:40:07PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Pointer np is being initialized with a value that is never read
> and it is being updated with a value later on. The initialization
> is redundant and can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied, thanks.
