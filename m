Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 446082A001D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 09:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgJ3Iem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 04:34:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:49456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbgJ3Iem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 04:34:42 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9423320739;
        Fri, 30 Oct 2020 08:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604046882;
        bh=UkDUzuYwPb5jTV+e3QII3h/4OxTwBgACkSE9SIDmYQc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JifgwswuRqF9HiG4E/XylpjlOLmoerQENOiD6z/ac/a6W3DCrVyekwosCgevUK0Za
         dwJO6n2Wuc18GY5YpdCKCuoLz9FmcHY6LUhSMUgcd1RpIZzG251/ZPpTWyrWWXZl5Q
         4VP4hnSISrR5oKWQ4SA/OTeVxvZq6Itc4p3WZ9Xc=
Date:   Fri, 30 Oct 2020 16:34:16 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        krzk@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] arm64: dts imx8mn: Remove non-existent USB OTG2
Message-ID: <20201030083414.GN28755@dragon>
References: <20201008183300.726756-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008183300.726756-1-aford173@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 01:33:00PM -0500, Adam Ford wrote:
> According to the i.MX8MN TRM, there is only one OTG port.  The
> address for OTG2 is reserved on Nano.
> 
> This patch removes the non-existent OTG2, usbphynop2, and the usbmisc2
> nodes.
> 
> Fixes: 6c3debcbae47 ("arm64: dts: freescale: Add i.MX8MN dtsi support")
> 

This newline is not really necessary.

> Signed-off-by: Adam Ford <aford173@gmail.com>

Applied, thanks.

> ---
> V2:  Remove usbmisc2 and usbphynop2 in addition to the otg2 node.
