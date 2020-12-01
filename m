Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7252C94DB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 02:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgLABu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 20:50:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:40194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725918AbgLABu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 20:50:56 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25E052085B;
        Tue,  1 Dec 2020 01:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606787415;
        bh=i24tqU+wEFKeqAjGV2x17GMPR+CnMcATDed1HcxklvU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vR4jzRbNAiWABuYB8k2NOe73aM2EZTc18PBibYaocJNoabNuJEzjnnDguuLcN9N9j
         hb2iNU7DigfGNcvLQTpE6rhQfzpTGSKioesgPgeVELSbpA8TbOo//nA537Sz3WQ3Hm
         O25a8x5RZ8p2gOPHfmS6A+LO5UWBq2+uFMTusYGo=
Date:   Tue, 1 Dec 2020 09:50:08 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/2] arm64: dts: imx8mm-beacon-som: Configure RTC
 aliases
Message-ID: <20201201015000.GV4072@dragon>
References: <20201126104535.1075658-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126104535.1075658-1-aford173@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 04:45:34AM -0600, Adam Ford wrote:
> On the i.MX8MM Beacon SOM, there is an RTC chip which is fed power
> from the baseboard during power off.  The SNVS RTC integrated into
> the SoC is not fed power.  Depending on the order the modules are
> loaded, this can be a problem if the external RTC isn't rtc0.
> 
> Make the alias for rtc0 point to the external RTC all the time and
> rtc1 point to the SVNS in order to correctly hold date/time over
> a power-cycle.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

Applied both, thanks.
