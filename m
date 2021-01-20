Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB6EA2FD29B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 15:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388457AbhATOXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 09:23:46 -0500
Received: from aposti.net ([89.234.176.197]:42126 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389815AbhATMgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 07:36:31 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        od@zcrc.me, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 0/3] Fixes to bridge/panel and ingenic-drm
Date:   Wed, 20 Jan 2021 12:35:32 +0000
Message-Id: <20210120123535.40226-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are three independent fixes. The first one addresses a
use-after-free in bridge/panel.c; the second one addresses a
use-after-free in the ingenic-drm driver; finally, the third one makes
the ingenic-drm driver work again on older Ingenic SoCs.

Changes from v1:
- patch [1/3]: the connector is cleaned up only if it was initialized in
  the first place;
- patch [2/3]: use __drmm_simple_encoder_alloc;
- patch [3/3] is unmodified.

Note to linux-stable guys: patch [v2 2/3] will only apply on the current
drm-misc-next branch, to fix it for v5.11 and older kernels, use the V1
of that patch.

Cheers,
-Paul

Paul Cercueil (3):
  drm: bridge/panel: Cleanup connector on bridge detach
  drm/ingenic: Register devm action to cleanup encoders
  drm/ingenic: Fix non-OSD mode

 drivers/gpu/drm/bridge/panel.c            |  6 +++++
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 27 ++++++++++++-----------
 2 files changed, 20 insertions(+), 13 deletions(-)

-- 
2.29.2

