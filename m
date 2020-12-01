Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA7A2C9E83
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 11:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbgLAKAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 05:00:23 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:49186 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbgLAKAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 05:00:23 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id D17CC2001E;
        Tue,  1 Dec 2020 10:59:31 +0100 (CET)
Date:   Tue, 1 Dec 2020 10:59:30 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     allen <allen.chen@ite.com.tw>
Cc:     Kenneth Hung <Kenneth.Hung@ite.com.tw>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Jau-Chih Tseng <Jau-Chih.Tseng@ite.com.tw>,
        Yilun Lin <yllin@google.com>, David Airlie <airlied@linux.ie>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Hermes Wu <hermes.wu@ite.com.tw>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        Jonas Karlman <jonas@kwiboo.se>
Subject: Re: [PATCH v5] drm/bridge: add it6505 driver
Message-ID: <20201201095930.GA1981628@ravnborg.org>
References: <20201201054454.51240-1-allen.chen@ite.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201054454.51240-1-allen.chen@ite.com.tw>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=Ibmpp1ia c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=Ns9eNvu6AAAA:8 a=mpaa-ttXAAAA:8 a=cm27Pg_UAAAA:8
        a=1XWaLZrsAAAA:8 a=qw3Jv0Z29LwRxbBwalcA:9 a=CjuIK1q_8ugA:10
        a=LZLx1i01EnjtqRv10NxV:22 a=6heAxKwa5pAsJatQ0mat:22
        a=xmb-EsYY8bH0VWELuYED:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Allen.
On Tue, Dec 01, 2020 at 01:44:41PM +0800, allen wrote:
> This adds support for the iTE IT6505.
> This device can convert DPI signal to DP output.
> 
> From: Allen Chen <allen.chen@ite.com.tw>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
> Signed-off-by: Yilun Lin <yllin@google.com>
> Signed-off-by: Hermes Wu <hermes.wu@ite.com.tw>
> Signed-off-by: Allen Chen <allen.chen@ite.com.tw>

I recall I provided the same comment as last time, but may remember
wrong.

New bridge drivers shall support that connector creation is optional.
This driver does not do that - see following code snippet:

+       if (flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR) {
+               DRM_ERROR("Fix bridge driver to make connector optional!");
+               return -EINVAL;
+       }
+

I did not check, but likely the drive needs to implment some of the
connector hooks too. (detect, get_edid, etc).

Please include a changelog too - it can be very hard to remember what
feedback was provided when one reviews several patches/week.

	Sam
