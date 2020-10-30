Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF04529FF31
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 08:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbgJ3H5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 03:57:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:58880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgJ3H5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 03:57:11 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8016420719;
        Fri, 30 Oct 2020 07:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604044630;
        bh=skMmy2Vr9/AuSxj3bzuIBOiuSOxk+xs9CPjuY1ruZJA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=04Arz/yzW8Lq26ElySPjCpknyJJ6S9D54AU8XABbc64vFnnBR6esPj3/6jZ0yNQ0e
         5IYDgU5xZyHyDIleWgOztBm0sX2R+v4ZWSfv0nTpDRg6yI5A5wLA+X72TLxs9qV6NB
         jG0IJ4aJZBFhnCGty6y/9dP5ZaGqX/uOWdeX8r8c=
Date:   Fri, 30 Oct 2020 15:57:04 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mm-beacon-som: Fix Choppy BT audio
Message-ID: <20201030075703.GJ28755@dragon>
References: <20201007130237.230613-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007130237.230613-1-aford173@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 08:02:37AM -0500, Adam Ford wrote:
> When streaming bluetooth audio, the sound is choppy due to the
> fact that the default baud rate of the HCI interface is too slow
> to handle 16-bit stereo at 48KHz.
> 
> The Bluetooth chip is capable of up to 4M baud on the serial port,
> so this patch sets the max-speed to 4000000 in order to properly
> stream audio over the Bluetooth.
> 
> Fixes: 593816fa2f35 ("arm64: dts: imx: Add Beacon i.MX8m-Mini development kit")
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

Applied, thanks.
