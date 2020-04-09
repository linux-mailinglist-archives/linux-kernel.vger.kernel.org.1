Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8D0C1A334B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Apr 2020 13:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgDILgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Apr 2020 07:36:41 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:38038 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgDILgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 07:36:41 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id C574C20047;
        Thu,  9 Apr 2020 13:36:34 +0200 (CEST)
Date:   Thu, 9 Apr 2020 13:36:33 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Lee Jones <lee.jones@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Robert Chiras <robert.chiras@nxp.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v10 2/2] drm/bridge: Add NWL MIPI DSI host controller
 support
Message-ID: <20200409113633.GA4330@ravnborg.org>
References: <cover.1584730033.git.agx@sigxcpu.org>
 <22f34fb7cf7ee4262cf63372aee90bc8e5ae3f35.1584730033.git.agx@sigxcpu.org>
 <20200408175252.GB24828@ravnborg.org>
 <20200409104314.GB104945@bogon.m.sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409104314.GB104945@bogon.m.sigxcpu.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=eMA9ckh1 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10
        a=wF2D5j3In6wItstX1c4A:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guido.

> > > +
> > > +/* i.MX8 NWL quirks */
> > > +/* i.MX8MQ errata E11418 */
> > > +#define E11418_HS_MODE_QUIRK	BIT(0)
> > > +
> > > +#define NWL_DSI_MIPI_FIFO_TIMEOUT msecs_to_jiffies(500)
> > Should the defines be moved to the header file?
> 
> I've used this rules: register layout (that is chip properties)
> go to the header file while defines specific to this very driver
> go into the .c file. Hope that makes sense.

Makes good sense, thanks for the explanation.

	Sam
