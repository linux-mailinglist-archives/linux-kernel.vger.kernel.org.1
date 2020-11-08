Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2BCB2AAA75
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 10:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbgKHJ5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 04:57:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgKHJ5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 04:57:39 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE437C0613CF
        for <linux-kernel@vger.kernel.org>; Sun,  8 Nov 2020 01:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Gu6W+SYNYwujRSnH/S/cqUbxFQBEVozmfEiGAZYOXTA=; b=CV5/QWIS9Q6yhKqIURS3jOiQr
        sTYBSt7zBvclZtLq9/AyhSNGwBonxuH2r2ePFH8J+7Xx5jqnPUmzQc4SH/mmz0W7mNqzbECRh+Zii
        anGEnoxZi3Oiac1yj2hm/+SGR5mYROn55SFyDixBQAdjv2wCxdzFKJjTsbl7mPPZUXH4zAEtjfMVd
        KC8+q9qJ3pWisOnBEhcJ1apqGtoHIB8xS3EWeuctgpJke1jD+8sDCvhuUBj0ZIdQf0WG+Y0jes3Wc
        y1021x5lFU0en/hGGD/wuAW5+FVgp9yVfPrj2X/thGkAUnVtGuzijUVgGjrdIs81zgdp0RHPdF2F6
        VJg9lE4Hg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56562)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1kbhRy-0007Ez-TU; Sun, 08 Nov 2020 09:57:30 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1kbhRt-0007jT-4M; Sun, 08 Nov 2020 09:57:25 +0000
Date:   Sun, 8 Nov 2020 09:57:25 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Jonathan Liu <net147@gmail.com>,
        linux-rockchip@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <fabio.estevam@freescale.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Liu Ying <victor.liu@nxp.com>
Subject: Re: [PATCH] drm: bridge: dw-hdmi: Avoid resetting force in the
 detect function
Message-ID: <20201108095724.GW1551@shell.armlinux.org.uk>
References: <20201031081747.372599-1-net147@gmail.com>
 <20201108095322.GA1129714@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201108095322.GA1129714@ravnborg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 08, 2020 at 10:53:22AM +0100, Sam Ravnborg wrote:
> Russell,
> 
> On Sat, Oct 31, 2020 at 07:17:47PM +1100, Jonathan Liu wrote:
> > It has been observed that resetting force in the detect function can
> > result in the PHY being powered down in response to hot-plug detect
> > being asserted, even when the HDMI connector is forced on.
> > 
> > Enabling debug messages and adding a call to dump_stack() in
> > dw_hdmi_phy_power_off() shows the following in dmesg:
> > [  160.637413] dwhdmi-rockchip ff940000.hdmi: EVENT=plugin
> > [  160.637433] dwhdmi-rockchip ff940000.hdmi: PHY powered down in 0 iterations
> > 
> > Call trace:
> > dw_hdmi_phy_power_off
> > dw_hdmi_phy_disable
> > dw_hdmi_update_power
> > dw_hdmi_detect
> > dw_hdmi_connector_detect
> > drm_helper_probe_detect_ctx
> > drm_helper_hpd_irq_event
> > dw_hdmi_irq
> > irq_thread_fn
> > irq_thread
> > kthread
> > ret_from_fork
> > 
> > Fixes: 381f05a7a842 ("drm: bridge/dw_hdmi: add connector mode forcing")
> > Signed-off-by: Jonathan Liu <net147@gmail.com>
> 
> you are the original author of this code - any comments on this patch?

No further comments beyond what has already been discussed, and the
long and short of it is it's been so long that I don't remember why
that code was there. Given that, I'm not even in a position to ack
the change. Sorry.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
