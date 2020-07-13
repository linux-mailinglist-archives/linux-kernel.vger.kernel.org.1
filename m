Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 286ED21CD1A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 04:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbgGMCTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jul 2020 22:19:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:46070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727098AbgGMCTx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 22:19:53 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17832206D9;
        Mon, 13 Jul 2020 02:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594606793;
        bh=2rOJLR6P4/nkNMdRzIOv6pWnDLolY53OuD0IfuKzM4g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S9P4ib16ux2sFwLmHMm9T9I4/C4hOKkpGIDoBtenBnuu5So/+poBMKetIi3EDEsiz
         mK1BKsFAYcCeCzDrUubcQu/XnuIkqyDD17tg4+7h9fzJxRuUTdMnN0DezH+my8nhZR
         KtZ3RFt8jvkf7rH/bGrl0d+KkELUjvt6DtgYhU7M=
Date:   Mon, 13 Jul 2020 10:19:48 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Joakim Zhang <qiangqing.zhang@nxp.com>
Cc:     robh+dt@kernel.org, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mp: add ddr pmu device node
Message-ID: <20200713021948.GW21277@dragon>
References: <1593420150-30904-1-git-send-email-qiangqing.zhang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593420150-30904-1-git-send-email-qiangqing.zhang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 04:42:30PM +0800, Joakim Zhang wrote:
> Add ddr pmu device node for i.MX8MP.
> 
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>

Applied, thanks.
