Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2988D2AC9E5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 01:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730619AbgKJAyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 19:54:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:53458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727311AbgKJAyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 19:54:45 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD403206D8;
        Tue, 10 Nov 2020 00:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604969685;
        bh=csiuiH88E1xd2DKtqCkT2WGa255xwcmAwxXzOc+zo7o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ScTRITilaUzwMHEIPNnvpExH6QSZDa3pK8lIFlkeEOr7n4Or2ssO7awjxabIqUg7i
         nD9xgLgG+N/flLKBWU6CYjVQwha/1/gO/xkAMZL6+y4MUmuU1i15+wJzwEcB4UQYmm
         oxMZYOeVPaWqAoON4EM4qqBWruLIBhP2DNPXGnH8=
Date:   Tue, 10 Nov 2020 08:54:40 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Joakim Zhang <qiangqing.zhang@nxp.com>
Cc:     s.hauer@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] arm64: dts: imx8m: add IR support
Message-ID: <20201110005439.GI31601@dragon>
References: <20201102022527.14265-1-qiangqing.zhang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102022527.14265-1-qiangqing.zhang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 10:25:24AM +0800, Joakim Zhang wrote:
> Add IR support on i.MX8M platforms.
> 
> Joakim Zhang (3):
>   arm64: dts: imx8mq-evk: add linux,autosuspend-period property for IR
>   arm64: dts: imx8mm-evk: add IR support
>   arm64: dts: imx8mn-evk: add IR support

Applied all, thanks.
