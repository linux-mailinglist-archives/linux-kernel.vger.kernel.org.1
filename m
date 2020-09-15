Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8058F26B8A0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 02:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgIPAr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 20:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgIOMlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 08:41:03 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04319C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 05:41:00 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id ED00A299D30
Subject: Re: [PATCH v3 0/1] drm/bridge: ps8640: Make sure all needed is
 powered to get the EDID
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, matthias.bgg@gmail.com,
        drinkcat@chromium.org, hsinyi@chromium.org,
        laurent.pinchart@ideasonboard.com, sam@ravnborg.org,
        Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org
References: <20200827085911.944899-1-enric.balletbo@collabora.com>
Message-ID: <68d6a409-39fb-0aa8-7d21-d6afc7b51aab@collabora.com>
Date:   Tue, 15 Sep 2020 14:40:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200827085911.944899-1-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

On 27/8/20 10:59, Enric Balletbo i Serra wrote:
> The first 4 patches of the series version 2:
>   - drm/bridge_connector: Set default status connected for eDP connectors
>   - drm/bridge: ps8640: Get the EDID from eDP control
>   - drm/bridge: ps8640: Return an error for incorrect attach flags
>   - drm/bridge: ps8640: Print an error if VDO control fails
> 
> Are already applied to drm-misc-next, so I removed from this series. The
> pending patch is part of the original series and is a rework of the power
> handling to get the EDID. Basically, we need to make sure all the
> needed is powered to be able to get the EDID. Before, we saw that getting
> the EDID failed as explained in the third patch.
> 
> [1] https://lkml.org/lkml/2020/6/15/1208
> 
> Changes in v3:
> - Make poweron/poweroff and pre_enable/post_disable reverse one to each other (Sam Ravnborg)
> 
> Changes in v2:
> - Use drm_bridge_chain_pre_enable/post_disable() helpers (Sam Ravnborg)
> 
> Enric Balletbo i Serra (1):
>   drm/bridge: ps8640: Rework power state handling
> 
>  drivers/gpu/drm/bridge/parade-ps8640.c | 68 ++++++++++++++++++++++----
>  1 file changed, 58 insertions(+), 10 deletions(-)
> 

A gentle ping on this patch. Would be nice land this together with the already
accepted patches.

Thanks,
  Enric
