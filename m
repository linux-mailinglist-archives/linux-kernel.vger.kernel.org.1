Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C95E52C8118
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 10:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbgK3JdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 04:33:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:52602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726756AbgK3JdZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 04:33:25 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F0E62076E;
        Mon, 30 Nov 2020 09:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606728764;
        bh=qpt/omNfokXd4Bg6icgGXINwG61fMEflfl5dg8+HUM8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wPG5J7kWWr3HvZ3duEoSEyllmcXyvG2Ep0josjchXYuE3nmPQSaYKNQtkCWmj2MFv
         gHqahlE8bDoDsu8Zs24IU7585Lcv95CqgtClRxcL+3vPcFzEO9MhtuAToWlyrs4vzv
         re2QeZuG867MJge1PD90MLnGfz0UXlfCCElHHDiM=
Date:   Mon, 30 Nov 2020 17:32:39 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Ivan Zaentsev <ivan.zaentsev@wirenboard.ru>
Cc:     Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Evgeny Boger <boger@wirenboard.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM: mxs: Add serial number support for i.MX23,
 i.MX28 SoCs
Message-ID: <20201130093238.GE4072@dragon>
References: <20201116165826.51570-1-ivan.zaentsev@wirenboard.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116165826.51570-1-ivan.zaentsev@wirenboard.ru>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 07:58:26PM +0300, Ivan Zaentsev wrote:
> i.MX23 and i.MX28 SoCs unique identifiers are factory-programmed
> in On-Chip OTP memory. i.MX28's 64-bit unique id is in
> HW_OCOTP_OPS2:HW_OCOTP_OPS3 (see MCIMX28 Ref. Man., sec. 20.4.22-23).
> 
> i.MX23 provides 32-bit long unique id in HW_OCOTP_OPS3.
> Though not clearly documented, there is a clue in sec. 35.9.3.
> 
> The unique id is reported in /sys/devices/soc0/serial_number
> and in /proc/cpuinfo
> 
> Signed-off-by: Ivan Zaentsev <ivan.zaentsev@wirenboard.ru>
> Suggested-by: Evgeny Boger <boger@wirenboard.com>

Applied, thanks.
