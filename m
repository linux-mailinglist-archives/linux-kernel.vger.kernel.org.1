Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7AAE1B5E50
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Apr 2020 16:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbgDWOvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Apr 2020 10:51:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:54156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727832AbgDWOvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 10:51:04 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 602502074F;
        Thu, 23 Apr 2020 14:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587653464;
        bh=5S49h93wmsXbBI+Y0llES4okyh5R+bJPk/y1sqqW1QY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gEVE+0SHh/PiSIUhOEKJyoSjM1wFkcPS7wEWb5IeTvPp/U5RnP2mo+KLLH/XRTuib
         usLre+kBywfYAEawA4ZZ+USGciyt9mrF+h7rwE8d9qTRBPbeW/cniS1DBRGvYc5WBP
         16DRO1oiaeQ+anqeHdpoO9WVV0ExxVeXqt67RkIw=
Date:   Thu, 23 Apr 2020 22:50:57 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mn: Change SDMA1 ahb clock for imx8mn
Message-ID: <20200423145056.GG9391@dragon>
References: <20200328023353.156929-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200328023353.156929-1-aford173@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 09:33:53PM -0500, Adam Ford wrote:
> Using SDMA1 with UART1 is causing a "Timeout waiting for CH0" error.
> This patch changes to ahb clock from SDMA1_ROOT to AHB which fixes the
> timeout error.
> 
> Fixes: 6c3debcbae47 ("arm64: dts: freescale: Add i.MX8MN dtsi support")
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

Applied, thanks.
