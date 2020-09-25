Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8F92784BA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 12:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbgIYKJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 06:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbgIYKJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 06:09:00 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521D1C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 03:09:00 -0700 (PDT)
Received: from [2a0a:edc0:0:900:6245:cbff:fea0:1793] (helo=kresse.office.stw.pengutronix.de)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1kLkew-0004fm-K6; Fri, 25 Sep 2020 12:08:58 +0200
Message-ID: <81c1883b52f33ef286635d7ae2a564ccb3436a68.camel@pengutronix.de>
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Christian Gmeiner <christian.gmeiner@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Russell King <linux+etnaviv@armlinux.org.uk>, cphealy@gmail.com
Date:   Fri, 25 Sep 2020 12:08:58 +0200
In-Reply-To: <20200814090512.151416-1-christian.gmeiner@gmail.com>
References: <20200814090512.151416-1-christian.gmeiner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:6245:cbff:fea0:1793
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
        metis.ext.pengutronix.de
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=4.0 tests=AWL,BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.2
Subject: Re: [PATCH 0/4] drm/etnaviv: add total hi bandwidth perf counters
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on metis.ext.pengutronix.de)
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fr, 2020-08-14 at 11:05 +0200, Christian Gmeiner wrote:
> This little patch set adds support for the total bandwidth used by HI. The
> basic hi bandwidth read-out is quite simple but I needed to add some little
> clean-ups to make it nice looking.
> 
> Christian Gmeiner (4):
>   drm/etnaviv: rename pipe_reg_read(..)
>   drm/etnaviv: call perf_reg_read(..)
>   drm/etnaviv: add total hi bandwidth perfcounter
>   drm/etnaviv: add pipe_select(..) helper
> 
>  drivers/gpu/drm/etnaviv/etnaviv_perfmon.c | 78 ++++++++++++++++-------
>  1 file changed, 55 insertions(+), 23 deletions(-)

Thanks,

I've applied the whole series to my etnaviv/next branch.

regards,
Lucas

