Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB8221D210
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 10:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729437AbgGMIoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 04:44:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:39564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbgGMIo3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 04:44:29 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22A4A2065D;
        Mon, 13 Jul 2020 08:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594629869;
        bh=nCn6KLtowL+Z2VGZqiDZtOX/k4cPWGWYXEH+Yjoe2ws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dkRcHsIjd0l4Dp7Du9NEDGIXb+ThB2tm8kUa68ZIHPt+4BoIEYsKcb9VsxmDRHFxP
         5ImgOe+Kfe7Yfl+SkKZWUq7JFvcWPx9kT7xCEHDFHCAqCsdcsNMp+3Tw0sr2N/PoVp
         E/+2z4P/G86rNBw9orB026wOc7rBQCkjlwu6G8/Q=
Date:   Mon, 13 Jul 2020 16:44:25 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     peng.fan@nxp.com
Cc:     s.hauer@pengutronix.de, arnd@arndb.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: imx_v6_v7_defconfig: Support i.MX8MM
Message-ID: <20200713084424.GF15718@dragon>
References: <1594347053-30361-1-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594347053-30361-1-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 10:10:53AM +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX8MM is built with AArch64 hardware, this is to support
> it could run in Aarch32 mode with clock and pinctrl driver enabled.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks.
