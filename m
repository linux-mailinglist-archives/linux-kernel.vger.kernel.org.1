Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF482B3EC1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 09:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbgKPIeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 03:34:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:56516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbgKPIeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 03:34:23 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F655207BC;
        Mon, 16 Nov 2020 08:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605515662;
        bh=XRMSYA38EWNB6SZh6t6STfpii3PwY9kz7Jvt5zohb8w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YdI9cFFQ2/Gv43v5+1Js9ojr5/kXbWUW141XXkWt30Ik0fSo/2Pjp2W7h/qSWpYeE
         T89r7H781FX7RjG+xkGexAlbBbf+gRt7HsW0Z4sEcj2FhTLnNkJZutDJovH1Pzcjaj
         REpRUdzXzIcgA2Gbv8zAvBEeIYzqvP7givijzroQ=
Date:   Mon, 16 Nov 2020 16:34:17 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, paul.olaru@nxp.com,
        shengjiu.wang@nxp.com
Subject: Re: [PATCH RESEND 0/3] Allow on demand channel request / free
Message-ID: <20201116083415.GK5849@dragon>
References: <20201111111118.21824-1-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111111118.21824-1-daniel.baluta@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 01:11:15PM +0200, Daniel Baluta wrote:
> Requesting an mailbox channel will call mailbox's startup
> function.
> 
> startup function calls pm_runtime_get_sync which increments device usage
> count and will keep the device active. Specifically, mailbox clock will
> be always ON when a mailbox channel is requested.
> 
> For this, reason we introduce a way to request/free IMX DSP channels
> on demand to save power when the channels are not used.
> 
> First two patches are doing code refactoring preparing the path
> for 3rd patch which exports functions for on demand channel request/free
> 
> 
> Daniel Baluta (3):
>   firmware: imx: Introduce imx_dsp_setup_channels
>   firmware: imx: Save channel name for further use
>   firmware: imx-dsp: Export functions to request/free channels

Applied all, thanks.
