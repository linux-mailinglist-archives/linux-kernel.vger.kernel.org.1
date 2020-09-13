Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D85A267D2E
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 03:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbgIMBql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 21:46:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:53886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbgIMBqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 21:46:40 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8752421531;
        Sun, 13 Sep 2020 01:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599961600;
        bh=GwRsGmQPxPXZvkghZC562wXoSBHQCZTy/z9V7TwRZ6c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cRebRgZZaNS/MAcZhsFvmtDo6z2k8N0H0CLKcwBW1z+e3qmVdefMqo20d6wmAuTpd
         4N14TWJS9+glcyd+nYWX84agiw1uJn1Lvfn+bQu/nZIYkBAgvLCn/m9SnJFUktn/CX
         Q/+64M7kP1HKljBKfj0VpK8zuar//3UA+5XU4SAE=
Date:   Sun, 13 Sep 2020 09:46:35 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     peng.fan@nxp.com
Cc:     s.hauer@pengutronix.de, festevam@gmail.com, abel.vesa@nxp.com,
        kernel@pengutronix.de, linux-imx@nxp.com, Anson.Huang@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        aisheng.dong@nxp.com
Subject: Re: [PATCH] firmware: imx: scu-pd: ignore power domain not owned
Message-ID: <20200913014634.GF25109@dragon>
References: <1599559621-1397-1-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599559621-1397-1-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 08, 2020 at 06:07:01PM +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Should not register power domain that not owned by current
> partition.
> 
> Alought power domains will not be registered when power on failure,
> we have to let CPU waste more cycles.
> 
> Whether power on or owned check, both need communicate with SCU,
> but with owned check, we no need to run more code path to save CPU
> cycles.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>

Applied, thanks.
