Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C92C11B943A
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Apr 2020 23:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgDZVm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Apr 2020 17:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgDZVmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 17:42:25 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94DDC061A0F
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 14:42:25 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b6so18357919ybo.8
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 14:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=wP3YUSwt75lpebH/kLrQdqblssHhZZ89gAzPrZ9VKZs=;
        b=fG5gI4J7oDbK8qs78tZgGY0NlRU6gceYYgCJ0eoJqEZzSts21/GsCXHGIEajLEe8RM
         Z+9O8Tz6sDXSt8WAoEYiKxexdBnP6zHgKmOIhsm65DVRHBMZq2xg5l5+gLbjJq5LnBp8
         ZZbKoyPzNKR9uBYzWNh7SdQdLQXmoOIJOOBJcHdmQM3hzWSI9UF3UMl8222Dynxu5aNq
         BvDLcDhsmONYCp10xG0z3gUKrrmFyUEixlveJEeM24MVNrN70+khd1+xqoEjiCIyw66Q
         Ovywqm+KREClud//DTN73yY25tOlNOxGVcn0VF0tHbyvwXYm5MGwVmrGH9u63vE9sQuH
         vguw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=wP3YUSwt75lpebH/kLrQdqblssHhZZ89gAzPrZ9VKZs=;
        b=pDNnwCEGdEDPSWbKnCrwVvRLXrJKh+NBPNK1Y6BdyTn/xbsxdRaFWVuD+uqA8auxsc
         G6rwj/sB2ltxpx6543WXJnMBRNnHnDE8nCJl2TBO1Is/ao9tMNHA0vGS+03MmeauhiIz
         iWf0mtN+b4342ewtdMnyByT0phu36Xgb+KPLCiRwK3xs9m/7y+RzXNR1lESuWRTnA3/Z
         cC8nksTsX0lZqrwsuXzyw0RR0sY5p0mYftFQP24s+welBrIF+meLR8b90QfwVQS5ZJL+
         uE1DQhdNge72E3S2j8U5+Vp7kuQWvDM3hpNooXVHcq0Dh+G12JUc0PwJ1WNUEeiSczH9
         PTLg==
X-Gm-Message-State: AGi0PubOoBZdo4scMOpjqMPFD9kUMxfuFGpB+9xVLK/xmy4hJkF0/49x
        aanHIFWEDs92fuy39TVleiC87icx3tR+krxz1vg=
X-Google-Smtp-Source: APiQypKkUtSeaiUIVHxuzqmehWg/q5NMUry/6HHvoHkGlurMd144EQeQWrgree6KD13oOGVZbT0VX40GqJ1gqaig0cQ=
X-Received: by 2002:a25:bbd0:: with SMTP id c16mr31683706ybk.296.1587937343841;
 Sun, 26 Apr 2020 14:42:23 -0700 (PDT)
Date:   Sun, 26 Apr 2020 14:42:15 -0700
Message-Id: <20200426214215.139435-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH] drm/i915: re-disable -Wframe-address
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     jani.nikula@linux.intel.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The top level Makefile disables this warning. When building an
i386_defconfig with Clang, this warning is triggered a whole bunch via
includes of headers from perf.

Link: https://github.com/ClangBuiltLinux/continuous-integration/pull/182
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 drivers/gpu/drm/i915/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/i915/Makefile b/drivers/gpu/drm/i915/Makefile
index 6f112d8f80ca..8c2257437471 100644
--- a/drivers/gpu/drm/i915/Makefile
+++ b/drivers/gpu/drm/i915/Makefile
@@ -22,6 +22,7 @@ subdir-ccflags-y += $(call cc-disable-warning, sign-compare)
 subdir-ccflags-y += $(call cc-disable-warning, sometimes-uninitialized)
 subdir-ccflags-y += $(call cc-disable-warning, initializer-overrides)
 subdir-ccflags-y += $(call cc-disable-warning, uninitialized)
+subdir-ccflags-y += $(call cc-disable-warning, frame-address)
 subdir-ccflags-$(CONFIG_DRM_I915_WERROR) += -Werror
 
 # Fine grained warnings disable
-- 
2.26.2.303.gf8c07b1a785-goog

