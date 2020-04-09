Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 106D71A3698
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Apr 2020 17:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbgDIPHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Apr 2020 11:07:43 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:22787 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727736AbgDIPHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 11:07:43 -0400
Received: from grover.flets-west.jp (softbank126125134031.bbtec.net [126.125.134.31]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 039F6Zj5025357;
        Fri, 10 Apr 2020 00:06:35 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 039F6Zj5025357
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1586444796;
        bh=MUvhE7+ejNToesPB6VeHbyGzSUZRlpfGDiwXF83CYes=;
        h=From:To:Cc:Subject:Date:From;
        b=Kf3cMpbBc7OAc9Kj4TUDvcl/BH0s2qTuTc8GtX1PMo37ZfxzNtV0xNnNoo0YHsO8A
         ToUncwvbr8EajVFIR+00idM6Yqv1lpUL4PjyCUz8DYcNUyqmmnBPeJRryfpkCfNY1a
         DIXACKztrm35yW7/5yhRAz74W5fx4evOAI1hMx6bJaiWxT3l6SOrG+zZKSy8asezMa
         9DAGyKq+Y43YpV5Qa+HU2TXQylFErvINQtXg78b8v0GG0+g1bF/x+5r039CfTHokXD
         ohok4xDS9drR3H/wmuoXh7noiGZMs7A9U3Rnn4dpGvGkplfjjo57Cr5fraxMKms4zU
         djioWoz6BTdrA==
X-Nifty-SrcIP: [126.125.134.31]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        dri-devel@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm/i915: remove unneeded ccflags-y from gvt/Makefile
Date:   Fri, 10 Apr 2020 00:06:26 +0900
Message-Id: <20200409150627.29205-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_DRM_I915_GVT=y, the same include path is added twice.

drivers/gpu/drm/i915/Makefile specifies:

  subdir-ccflags-y += -I$(srctree)/$(src)

drivers/gpu/drm/i915/gvt/Makefile adds the second '-I $(srctree)/$(src)',
which is redundant.

The include path '-I $(srctree)/$(src)/$(GVT_DIR)/' is added to allow
include/trace/define_trace.h to find the gvt/trace.h

By setting the correct relative path to TRACE_INCLUDE_PATH, this -I
is also unneeded.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 drivers/gpu/drm/i915/gvt/Makefile | 1 -
 drivers/gpu/drm/i915/gvt/trace.h  | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/Makefile b/drivers/gpu/drm/i915/gvt/Makefile
index ea8324abc784..4d70f4689479 100644
--- a/drivers/gpu/drm/i915/gvt/Makefile
+++ b/drivers/gpu/drm/i915/gvt/Makefile
@@ -5,5 +5,4 @@ GVT_SOURCE := gvt.o aperture_gm.o handlers.o vgpu.o trace_points.o firmware.o \
 	execlist.o scheduler.o sched_policy.o mmio_context.o cmd_parser.o debugfs.o \
 	fb_decoder.o dmabuf.o page_track.o
 
-ccflags-y				+= -I $(srctree)/$(src) -I $(srctree)/$(src)/$(GVT_DIR)/
 i915-y					+= $(addprefix $(GVT_DIR)/, $(GVT_SOURCE))
diff --git a/drivers/gpu/drm/i915/gvt/trace.h b/drivers/gpu/drm/i915/gvt/trace.h
index 6d787750d279..d63b7eef6179 100644
--- a/drivers/gpu/drm/i915/gvt/trace.h
+++ b/drivers/gpu/drm/i915/gvt/trace.h
@@ -377,7 +377,7 @@ TRACE_EVENT(render_mmio,
 
 /* This part must be out of protection */
 #undef TRACE_INCLUDE_PATH
-#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_PATH ../../drivers/gpu/drm/i915/gvt
 #undef TRACE_INCLUDE_FILE
 #define TRACE_INCLUDE_FILE trace
 #include <trace/define_trace.h>
-- 
2.17.1

