Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C32E82B972D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 17:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729077AbgKSP4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 10:56:13 -0500
Received: from aposti.net ([89.234.176.197]:43888 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728080AbgKSP4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 10:56:11 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     Sam Ravnborg <sam@ravnborg.org>, od@zcrc.me,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 0/3] drm/ingenic: Add support for delta-RGB panels
Date:   Thu, 19 Nov 2020 15:55:56 +0000
Message-Id: <20201119155559.14112-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patchset adds support for delta-RGB panels to the ingenic-drm
driver. Delta-RGB panels have diamond-pattern subpixel layout, and
expect odd lines to have RGB subpixel ordering, and even lines to have
GBR subpixel ordering.

Such panel is used in the YLM (aka. Anbernic) RG-99, RG-300, RG-280M
and RG-280V handheld gaming consoles.

Cheers,
-Paul

Paul Cercueil (3):
  drm/ingenic: Compute timings according to adjusted_mode->crtc_*
  drm/ingenic: Properly compute timings when using a 3x8-bit panel
  drm/ingenic: Add support for serial 8-bit delta-RGB panels

 drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 40 ++++++++++++++++-------
 drivers/gpu/drm/ingenic/ingenic-drm.h     | 14 ++++++++
 2 files changed, 43 insertions(+), 11 deletions(-)

-- 
2.29.2

