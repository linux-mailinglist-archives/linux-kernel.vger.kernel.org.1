Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7A42B1021
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 22:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbgKLVXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 16:23:02 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:54092 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbgKLVXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 16:23:01 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 523C02001E;
        Thu, 12 Nov 2020 22:22:56 +0100 (CET)
Date:   Thu, 12 Nov 2020 22:22:54 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Jonathan Liu <net147@gmail.com>
Cc:     linux-rockchip@lists.infradead.org,
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
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Liu Ying <victor.liu@nxp.com>
Subject: Re: [PATCH] drm: bridge: dw-hdmi: Avoid resetting force in the
 detect function
Message-ID: <20201112212254.GA3361340@ravnborg.org>
References: <20201031081747.372599-1-net147@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201031081747.372599-1-net147@gmail.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VbvZwmh9 c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=pGLkceISAAAA:8 a=iiUPO-3NZFt9cYWtpHIA:9
        a=CjuIK1q_8ugA:10
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan
On Sat, Oct 31, 2020 at 07:17:47PM +1100, Jonathan Liu wrote:
> It has been observed that resetting force in the detect function can
> result in the PHY being powered down in response to hot-plug detect
> being asserted, even when the HDMI connector is forced on.
> 
> Enabling debug messages and adding a call to dump_stack() in
> dw_hdmi_phy_power_off() shows the following in dmesg:
> [  160.637413] dwhdmi-rockchip ff940000.hdmi: EVENT=plugin
> [  160.637433] dwhdmi-rockchip ff940000.hdmi: PHY powered down in 0 iterations
> 
> Call trace:
> dw_hdmi_phy_power_off
> dw_hdmi_phy_disable
> dw_hdmi_update_power
> dw_hdmi_detect
> dw_hdmi_connector_detect
> drm_helper_probe_detect_ctx
> drm_helper_hpd_irq_event
> dw_hdmi_irq
> irq_thread_fn
> irq_thread
> kthread
> ret_from_fork
> 
> Fixes: 381f05a7a842 ("drm: bridge/dw_hdmi: add connector mode forcing")
> Signed-off-by: Jonathan Liu <net147@gmail.com>

Applied to drm-misc-fixes.

	Sam
