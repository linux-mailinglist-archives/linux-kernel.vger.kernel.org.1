Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F64B29FF4E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 09:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbgJ3IAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 04:00:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:60754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbgJ3IAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 04:00:33 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10585206DC;
        Fri, 30 Oct 2020 08:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604044833;
        bh=A5DqtYVC+Vuu9s3i/DSxLYmaYp166CzIlSseYdbIrQs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0/uwP2z4FYfcl3tBJEmeorlBzl1rw7AE13l+HpNAP2e+sQ5Sdp6jemI0j7niAj8ya
         qBiWtj5M+NJbysp9r+rtPTnP42+BQRiw8GqSktTtnCbbzAigJwDfD0WnWpZmHsCvAG
         hpJvr3q9+MuMon2IIyJxEVoI5tvmtJvNpmhcCgIk=
Date:   Fri, 30 Oct 2020 16:00:27 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mm-beacon-som: Configure supplies on
 secondary cpus
Message-ID: <20201030080026.GK28755@dragon>
References: <20201007140457.233697-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007140457.233697-1-aford173@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 09:04:57AM -0500, Adam Ford wrote:
> Each cpu core should have a corresponding supply, but only cpu0 does.
> This patch adds a supply for each of the secondary cpus.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

Applied, thanks.
