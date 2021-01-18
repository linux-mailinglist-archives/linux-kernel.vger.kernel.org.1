Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 985502F968D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 01:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730301AbhARATk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 19:19:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:56332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726785AbhARATa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 19:19:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B59392137B;
        Mon, 18 Jan 2021 00:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610929129;
        bh=AMoWwMeerbu7qqOXqsa78mXjRjBuQWevhvlMY9YjqsI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fxoy4aLBp7wHvaNt5YBGyOLBAVg0hUxDjY+fmt7rLrZFdGieAc6fynGKcPcrzSfXt
         ooB5Mvt9nrf7L/I2XF7Cqjr7V5hHOHgO2qfdrCLPHpdbzvX5nWYi9m0ZByeSVv4Wfd
         rz2gKJcHAdDFfPrT2QlElAzNuzJsMzoYymOv7MMkiyy9mcOt06vDSx7CsPoWM7iPc6
         5x1wePq4BD0s3qqLgCweXYJzVhvYQnXb6qeYJ7U89tEW7Hq7DqqVpYx64UU8Y/aQje
         dYub0JHD6ZhEhYZ1m0YlQwvM6hPvrC2s/nYrUyVKwU8jIMQdYAUjv5T0x6zxGqheT9
         fFLxhELjR6oJg==
Date:   Mon, 18 Jan 2021 08:18:44 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mn-beacon-som: Configure RTC aliases
Message-ID: <20210118001843.GB28365@dragon>
References: <20210110115354.1259994-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210110115354.1259994-1-aford173@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 10, 2021 at 05:53:53AM -0600, Adam Ford wrote:
> On the i.MX8MN Beacon SOM, there is an RTC chip which is fed power
> from the baseboard during power off.  The SNVS RTC integrated into
> the SoC is not fed power.  Depending on the order the modules are
> loaded, this can be a problem if the external RTC isn't rtc0.
> 
> Make the alias for rtc0 point to the external RTC all the time and
> rtc1 point to the SVNS in order to correctly hold date/time over
> a power-cycle.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

Applied, thanks.
