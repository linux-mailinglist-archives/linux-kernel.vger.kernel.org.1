Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34C17296A90
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 09:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S375842AbgJWHrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 03:47:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:59596 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S374613AbgJWHrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 03:47:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6E158AC83;
        Fri, 23 Oct 2020 07:47:13 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     dri-devel@lists.freedesktop.org
Cc:     amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] drm/amd/display: Don't invoke kgdb_breakpoint() unconditionally
Date:   Fri, 23 Oct 2020 09:46:55 +0200
Message-Id: <20201023074656.11855-3-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20201023074656.11855-1-tiwai@suse.de>
References: <20201023074656.11855-1-tiwai@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ASSERT_CRITICAL() invokes kgdb_breakpoint() whenever either
CONFIG_KGDB or CONFIG_HAVE_KGDB is set.  This, however, may lead to a
kernel panic when no kdb stuff is attached, since the
kgdb_breakpoint() call issues INT3.  It's nothing but a surprise for
normal end-users.

For avoiding the pitfall, make the kgdb_breakpoint() call only when
CONFIG_DEBUG_KERNEL_DC is set.

https://bugzilla.opensuse.org/show_bug.cgi?id=1177973
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/gpu/drm/amd/display/dc/os_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/os_types.h b/drivers/gpu/drm/amd/display/dc/os_types.h
index 330acaaed79a..32758b245754 100644
--- a/drivers/gpu/drm/amd/display/dc/os_types.h
+++ b/drivers/gpu/drm/amd/display/dc/os_types.h
@@ -94,7 +94,7 @@
  * general debug capabilities
  *
  */
-#if defined(CONFIG_HAVE_KGDB) || defined(CONFIG_KGDB)
+#if defined(CONFIG_DEBUG_KERNEL_DC) && (defined(CONFIG_HAVE_KGDB) || defined(CONFIG_KGDB))
 #define ASSERT_CRITICAL(expr) do {	\
 	if (WARN_ON(!(expr))) { \
 		kgdb_breakpoint(); \
-- 
2.16.4

