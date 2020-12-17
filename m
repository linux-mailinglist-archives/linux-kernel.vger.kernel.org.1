Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F24C2DCD83
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 09:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbgLQISg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 03:18:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgLQISg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 03:18:36 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C4DC061794
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 00:17:55 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kpoTx-00AYbO-E1; Thu, 17 Dec 2020 09:17:53 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-kernel@vger.kernel.org
Cc:     Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2] gdb: lx-symbols: store the abspath()
Date:   Thu, 17 Dec 2020 09:17:47 +0100
Message-Id: <20201217091747.bf4332cf2b35.I10ebbdb7e9b80ab1a5cddebf53d073be8232d656@changeid>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If we store the relative path, the user might later cd to a
different directory, and that would break the automatic symbol
resolving that happens when a module is loaded into the target
kernel. Fix this by storing the abspath() of each path given,
just like we already do for the cwd (os.getcwd() is absolute.)

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
v2: break the long line
---
 scripts/gdb/linux/symbols.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/gdb/linux/symbols.py b/scripts/gdb/linux/symbols.py
index 1be9763cf8bb..08d264ac328b 100644
--- a/scripts/gdb/linux/symbols.py
+++ b/scripts/gdb/linux/symbols.py
@@ -164,7 +164,8 @@ lx-symbols command."""
             saved_state['breakpoint'].enabled = saved_state['enabled']
 
     def invoke(self, arg, from_tty):
-        self.module_paths = [os.path.expanduser(p) for p in arg.split()]
+        self.module_paths = [os.path.abspath(os.path.expanduser(p))
+                             for p in arg.split()]
         self.module_paths.append(os.getcwd())
 
         # enforce update
-- 
2.26.2

