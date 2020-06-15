Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59C7B1FA20A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jun 2020 22:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731619AbgFOUxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 16:53:30 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37386 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729692AbgFOUxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 16:53:30 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id EEFE82A0920
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
Subject: [PATCH 0/3] drm/bridge: ps8640: Make sure all needed is powered to get the EDID
Date:   Mon, 15 Jun 2020 22:53:17 +0200
Message-Id: <20200615205320.790334-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first patch is not really related and can be picked alone. The
second and the third are to rework the power handling to get the EDID.
Basically, we need to make sure all the needed is powered to be able
to get the EDID. Before, we saw that getting the EDID failed as
explained in the third patch.

Note that this series depends on:

  https://lore.kernel.org/patchwork/project/lkml/list/?series=448525

to apply cleanly.


Enric Balletbo i Serra (3):
  drm/bridge: ps8640: Return an error for incorrect attach flags
  drm/bridge: ps8640: Print an error if VDO control fails
  drm/bridge: ps8640: Rework power state handling

 drivers/gpu/drm/bridge/parade-ps8640.c | 94 ++++++++++++++++++++++----
 1 file changed, 82 insertions(+), 12 deletions(-)

-- 
2.27.0

