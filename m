Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8F8C252903
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 10:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgHZIPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 04:15:37 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39438 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbgHZIPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 04:15:35 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id C2951292457
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
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 0/5] drm/bridge: ps8640: Make sure all needed is powered to get the EDID
Date:   Wed, 26 Aug 2020 10:15:21 +0200
Message-Id: <20200826081526.674866-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first patch was initially part of the series [1] but for some reason
was not picked when the series were merged, so I included in this series
because it is needed to make the others to work properly.

The same happened for the second patch, was part of series [1] but not
merged.

The third patch and next are part of the original series and are to rework
the power handling to get the EDID. Basically, we need to make sure all the
needed is powered to be able to get the EDID. Before, we saw that getting
the EDID failed as explained in the third patch.

[1] https://lkml.org/lkml/2020/6/15/1208

Changes in v2:
- Included the patch `drm/bridge_connector: Set default status connected for eDP connectors`
- Included the patch `drm/bridge: ps8640: Get the EDID from eDP control`
- Use drm_bridge_chain_pre_enable/post_disable() helpers (Sam Ravnborg)

Enric Balletbo i Serra (5):
  drm/bridge_connector: Set default status connected for eDP connectors
  drm/bridge: ps8640: Get the EDID from eDP control
  drm/bridge: ps8640: Return an error for incorrect attach flags
  drm/bridge: ps8640: Print an error if VDO control fails
  drm/bridge: ps8640: Rework power state handling

 drivers/gpu/drm/bridge/parade-ps8640.c | 89 ++++++++++++++++++++++----
 drivers/gpu/drm/drm_bridge_connector.c |  1 +
 2 files changed, 79 insertions(+), 11 deletions(-)

-- 
2.28.0

