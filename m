Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 793E7296A8A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 09:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S375825AbgJWHrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 03:47:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:59574 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S374595AbgJWHrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 03:47:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5236EABF4;
        Fri, 23 Oct 2020 07:47:13 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     dri-devel@lists.freedesktop.org
Cc:     amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] drm/amd/display: Fix kernel panic by breakpoint
Date:   Fri, 23 Oct 2020 09:46:53 +0200
Message-Id: <20201023074656.11855-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the amdgpu driver's ASSERT_CRITICAL() macro calls the
kgdb_breakpoing() even if no debug option is set, and this leads to a
kernel panic on distro kernels.  The first two patches are the
oneliner fixes for those, while the last one is the cleanup of those
debug macros.


Takashi

===

Takashi Iwai (3):
  drm/amd/display: Fix kernel panic by dal_gpio_open() error
  drm/amd/display: Don't invoke kgdb_breakpoint() unconditionally
  drm/amd/display: Clean up debug macros

 drivers/gpu/drm/amd/display/Kconfig             |  1 +
 drivers/gpu/drm/amd/display/dc/gpio/gpio_base.c |  4 +--
 drivers/gpu/drm/amd/display/dc/os_types.h       | 33 +++++++++----------------
 3 files changed, 15 insertions(+), 23 deletions(-)

-- 
2.16.4

