Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFA4254157
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 10:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbgH0I7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 04:59:21 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52888 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgH0I7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 04:59:20 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id EAC5B291331
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
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v3 0/1] drm/bridge: ps8640: Make sure all needed is powered to get the EDID
Date:   Thu, 27 Aug 2020 10:59:10 +0200
Message-Id: <20200827085911.944899-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first 4 patches of the series version 2:
  - drm/bridge_connector: Set default status connected for eDP connectors
  - drm/bridge: ps8640: Get the EDID from eDP control
  - drm/bridge: ps8640: Return an error for incorrect attach flags
  - drm/bridge: ps8640: Print an error if VDO control fails

Are already applied to drm-misc-next, so I removed from this series. The
pending patch is part of the original series and is a rework of the power
handling to get the EDID. Basically, we need to make sure all the
needed is powered to be able to get the EDID. Before, we saw that getting
the EDID failed as explained in the third patch.

[1] https://lkml.org/lkml/2020/6/15/1208

Changes in v3:
- Make poweron/poweroff and pre_enable/post_disable reverse one to each other (Sam Ravnborg)

Changes in v2:
- Use drm_bridge_chain_pre_enable/post_disable() helpers (Sam Ravnborg)

Enric Balletbo i Serra (1):
  drm/bridge: ps8640: Rework power state handling

 drivers/gpu/drm/bridge/parade-ps8640.c | 68 ++++++++++++++++++++++----
 1 file changed, 58 insertions(+), 10 deletions(-)

-- 
2.28.0

