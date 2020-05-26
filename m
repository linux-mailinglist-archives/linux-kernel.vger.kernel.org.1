Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B85EB1B0ED2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 16:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbgDTOqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 10:46:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:46652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbgDTOqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 10:46:51 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B6C9206D5;
        Mon, 20 Apr 2020 14:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587394011;
        bh=/IPyAGYnCw1gtPtCf3Qro0SLyqMiQcu4OSyyNBu1dSU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RWlOb5rLlNT5NcnsBjC1VII2xSKyaQFU2hwCWHuX6z8/o4g67upM16l0x1kovzmsk
         zVVzxuVIRMaiEVWU2bHcVsGxXt/A03OOLlY/q4volpIQeK4e/f+0pwAf+NibrBOnY4
         HhNjhnXFrleNSewnZPS+xa3D3pNv9/TO+FnxNf+w=
Date:   Mon, 20 Apr 2020 22:46:43 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     peng.fan@nxp.com
Cc:     s.hauer@pengutronix.de, jassisinghbrar@gmail.com,
        o.rempel@pengutronix.de, leonard.crestez@nxp.com,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, aisheng.dong@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V7 4/4] firmware: imx-scu: Support one TX and one RX
Message-ID: <20200420144630.GD32419@dragon>
References: <1584604193-2945-1-git-send-email-peng.fan@nxp.com>
 <1584604193-2945-5-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584604193-2945-5-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 03:49:53PM +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Current imx-scu requires four TX and four RX to communicate with
> SCU. This is low efficient and causes lots of mailbox interrupts.
> 
> With imx-mailbox driver could support one TX to use all four transmit
> registers and one RX to use all four receive registers, imx-scu
> could use one TX and one RX.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks.
