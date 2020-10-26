Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1955C298CD4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 13:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1775067AbgJZMYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 08:24:38 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:34864 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1775059AbgJZMYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 08:24:38 -0400
X-Greylist: delayed 2231 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Oct 2020 08:24:37 EDT
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kX0yB-00CvJH-Pf; Mon, 26 Oct 2020 12:47:23 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-um@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christopher Obbard <chris.obbard@collabora.com>
Subject: [PATCH] um: include compiler_attributes.h where used
Date:   Mon, 26 Oct 2020 12:47:03 +0100
Message-Id: <20201026124702.874c23068ecc.I4c3cbf992dc2c038117a01c2cd9a4c406b89ec94@changeid>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Joe's commit didn't only convert uses of __section(...) to add
the quotes, but _also_ converted 'raw' uses of __attribute__(())
for setting the section to use __section, but didn't update the
includes where necessary. Add them now.

Fixes: 33def8498fdd ("treewide: Convert macro and uses of __section(foo) to __section("foo")")
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cause-identified-by: Christopher Obbard <chris.obbard@collabora.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/kernel/skas/clone.c | 1 +
 arch/x86/um/stub_segv.c     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/um/kernel/skas/clone.c b/arch/um/kernel/skas/clone.c
index 95c355181dcd..dfd81d4d0f5f 100644
--- a/arch/um/kernel/skas/clone.c
+++ b/arch/um/kernel/skas/clone.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
  */
 
+#include <linux/compiler_attributes.h>
 #include <signal.h>
 #include <sched.h>
 #include <asm/unistd.h>
diff --git a/arch/x86/um/stub_segv.c b/arch/x86/um/stub_segv.c
index fdcd58af707a..95110ad4f313 100644
--- a/arch/x86/um/stub_segv.c
+++ b/arch/x86/um/stub_segv.c
@@ -3,6 +3,7 @@
  * Licensed under the GPL
  */
 
+#include <linux/compiler_attributes.h>
 #include <sysdep/stub.h>
 #include <sysdep/faultinfo.h>
 #include <sysdep/mcontext.h>
-- 
2.26.2

