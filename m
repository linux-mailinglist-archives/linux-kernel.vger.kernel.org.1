Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E08932A1469
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 10:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgJaJIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 05:08:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:37670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726424AbgJaJIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 05:08:21 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7DEC206F7;
        Sat, 31 Oct 2020 09:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604135300;
        bh=UL7zqk5Z/W3STkRW38TMQbcALkFHV5QLS2El6tDhiaA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xEso9tJmu1xPWS1bkfQQ2pHXCkwbeArYq1l9+Gt1PODErhtoBi+YdSPk5X8cEr0c1
         7a56g+r+fnsVTO98oz6R6KqJeHPf5kVRfZ53TN0lM9CHPKFh/FJto0tf0IYLh3gF1+
         itlYAPNr7wRctKK5VBfoeTx9wB0pMZt+n2TRnc9g=
Date:   Sat, 31 Oct 2020 17:08:15 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/3] arm64: dts: imx8mm: Add support for micfil
Message-ID: <20201031090814.GA31601@dragon>
References: <20201019165038.274164-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019165038.274164-1-aford173@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 11:50:36AM -0500, Adam Ford wrote:
> The i.MX8M Mini has supports the MICFIL digital interface.
> It's a 16-bit audio signal from a PDM microphone bitstream.
> The driver is already in the kernel, but the node is missing.
> 
> This patch adds the micfil node.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

Applied all, thanks.
