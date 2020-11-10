Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31A902ACA11
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 02:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730795AbgKJBJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 20:09:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:56352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727311AbgKJBJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 20:09:09 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 555AB206D8;
        Tue, 10 Nov 2020 01:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604970549;
        bh=RIo3fK/MWXPbHbSM2PvGQBX/Qvsn97JKCRNg1IK3moM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kr1Hk4nL6ktQZD+5eWScYo7YAKxEfo0Y3vFP6SQcY9stktmEXnPfxXZXRtz1Rz8u9
         vD/wJPugKBcypmOd1B6d5c9m6aP8eZtACorFBUlHBACJryfiqfx8x3ViDH+ZeB8mWm
         OozaJqiV5yjqeD91zH5axzZPJ4Ad4d2McWlont1c=
Date:   Tue, 10 Nov 2020 09:09:03 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Zou Wei <zou_wei@huawei.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] clk: imx: gate2: Remove unused variable ret
Message-ID: <20201110010902.GL31601@dragon>
References: <1604403134-32814-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604403134-32814-1-git-send-email-zou_wei@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 03, 2020 at 07:32:14PM +0800, Zou Wei wrote:
> This patch fixes below warning reported by coccicheck:
> 
> ./clk-gate2.c:57:5-8: Unneeded variable: "ret". Return "0" on line 68
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>

Applied, thanks.
