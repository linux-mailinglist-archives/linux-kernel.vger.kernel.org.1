Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEF932A3640
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 23:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbgKBWHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 17:07:15 -0500
Received: from aposti.net ([89.234.176.197]:44676 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725777AbgKBWHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 17:07:15 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     od@zcrc.me, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 0/5] Add option to mmap GEM buffers cached, try 2
Date:   Mon,  2 Nov 2020 22:06:46 +0000
Message-Id: <20201102220651.22069-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rework of my previous patchset which added support for GEM buffers
backed by non-coherent memory to the ingenic-drm driver.

For the record, the previous patchset was accepted for 5.10 then had
to be reverted, as it conflicted with some changes made to the DMA API.

This new patchset is pretty different as it adds the functionality to
the DRM core. The first three patches add variants to existing functions
but with the "non-coherent memory" twist, exported as GPL symbols. The
fourth patch adds a function to be used with the damage helpers.
Finally, the last patch adds support for non-coherent GEM buffers to the
ingenic-drm driver. The functionality is enabled through a module
parameter, and is disabled by default.

Cheers,
-Paul

Paul Cercueil (5):
  drm: Add and export function drm_gem_cma_create_noncoherent
  drm: Add and export function drm_gem_cma_dumb_create_noncoherent
  drm: Add and export function drm_gem_cma_mmap_noncoherent
  drm: Add and export function drm_gem_cma_sync_data
  drm/ingenic: Add option to alloc cached GEM buffers

 drivers/gpu/drm/drm_gem_cma_helper.c      | 190 +++++++++++++++++++---
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c |  58 ++++++-
 drivers/gpu/drm/ingenic/ingenic-drm.h     |   4 +
 drivers/gpu/drm/ingenic/ingenic-ipu.c     |  12 +-
 include/drm/drm_gem_cma_helper.h          |  13 ++
 5 files changed, 251 insertions(+), 26 deletions(-)

-- 
2.28.0

