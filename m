Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29DBD303266
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 04:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbhAYMxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 07:53:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:39806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728359AbhAYMtg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 07:49:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6B2F922583;
        Mon, 25 Jan 2021 12:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611577547;
        bh=WEu6xFibX0AWxe6SUVQhMl1iWA9mDOLr68B6RzcwQlg=;
        h=From:To:Cc:Subject:Date:From;
        b=lZy1xrMCh5by4v6N/nuKNTDygAOQX3S9+fYSQemWPn3VsgS1Cin2TAFqofoIfZjDq
         uaPL7yLPtzK+CuVrbIDeqwt69OAirmhCw2srJkEBNXvgGB4o8sAjzRK3OYE4lpW6rs
         innvECZoTC5IGQdWx8KN65bgy8g0a1KbHZ+RJZlIoe5MSBqI1i/92Uw+gUpLdG4evH
         bj+Yg32P6FdkiZR4bvlSFYKavRhuMEz0qYrGbQlRymixPX/lwEkd+X28tzbjE5VpEQ
         uASJMbqNQ+lvlvXpv92U4Vwd1KwaLESovdzsfNC/SHT3txhhZtRBNx8sDPHFEoaGPf
         DpABsfdL/6bEg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthew Auld <matthew.auld@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/i915/gem: fix non-SMP build failure
Date:   Mon, 25 Jan 2021 13:25:34 +0100
Message-Id: <20210125122542.4144849-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The x86-specific wbinvd_on_all_cpus() function is exported
through asm/smp.h, causing a build failure in the i915 driver
when SMP is disabled:

drivers/gpu/drm/i915/i915_gem.c:1182:2: error: implicit declaration of function 'wbinvd_on_all_cpus' [-Werror,-Wimplicit-function-declaration]

Include that header file explicitly.

Fixes: 30d2bfd09383 ("drm/i915/gem: Almagamate clflushes on freeze")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/i915/i915_gem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/i915/i915_gem.c b/drivers/gpu/drm/i915/i915_gem.c
index 9b04dff5eb32..2a1643514577 100644
--- a/drivers/gpu/drm/i915/i915_gem.c
+++ b/drivers/gpu/drm/i915/i915_gem.c
@@ -36,6 +36,7 @@
 #include <linux/pci.h>
 #include <linux/dma-buf.h>
 #include <linux/mman.h>
+#include <asm/smp.h>
 
 #include "display/intel_display.h"
 #include "display/intel_frontbuffer.h"
-- 
2.29.2

