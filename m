Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 883A8204A3C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 08:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730862AbgFWGxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 02:53:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:54596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730476AbgFWGxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 02:53:17 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D6E220724;
        Tue, 23 Jun 2020 06:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592895197;
        bh=kTbnxtWZaVnKAzweo8XMbjGX2zAcjAPyn4YWfihQZOw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t6Ks0/kbQGbgzCPuUbxSeS7W6yhm6esdxYnY4iABcDYLLiX2MORtOx2yLpp6OyMc5
         BceIhrVpf/vPHJPPyWEuhPsW4qccffF+/Gs9UdZYHYoNX1VteoyLame6iJr5hdtBWT
         PPaUqV+KhMyZtPQFedrrVnE1mY1PamLqwhQR+t78=
Date:   Tue, 23 Jun 2020 14:53:11 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     peng.fan@nxp.com
Cc:     fabio.estevam@nxp.com, kernel@pengutronix.de, aisheng.dong@nxp.com,
        robh+dt@kernel.org, sboyd@kernel.org, linux@rempel-privat.de,
        jaswinder.singh@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        l.stach@pengutronix.de, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH V3 3/3] clk: imx8mp: add mu root clk
Message-ID: <20200623065310.GQ30139@dragon>
References: <1590999602-29482-1-git-send-email-peng.fan@nxp.com>
 <1590999602-29482-4-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590999602-29482-4-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 01, 2020 at 04:20:02PM +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add mu root clk for mu mailbox usage.
> 
> Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks.
