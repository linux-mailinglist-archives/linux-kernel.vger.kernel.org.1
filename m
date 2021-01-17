Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 729942F91F9
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jan 2021 12:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbhAQL1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 06:27:48 -0500
Received: from aposti.net ([89.234.176.197]:36552 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726295AbhAQL1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 06:27:43 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     Sam Ravnborg <sam@ravnborg.org>, od@zcrc.me,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 0/3] Fixes to bridge/panel and ingenic-drm
Date:   Sun, 17 Jan 2021 11:26:43 +0000
Message-Id: <20210117112646.98353-1-paul@crapouillou.net>
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

Cheers,
-Paul

Paul Cercueil (3):
  drm: bridge/panel: Cleanup connector on bridge detach
  drm/ingenic: Register devm action to cleanup encoders
  drm/ingenic: Fix non-OSD mode

 drivers/gpu/drm/bridge/panel.c            |  4 ++++
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 21 +++++++++++++++++----
 2 files changed, 21 insertions(+), 4 deletions(-)

-- 
2.29.2

