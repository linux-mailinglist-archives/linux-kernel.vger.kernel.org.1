Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C62172B0C0C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 19:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbgKLSA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 13:00:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgKLR7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 12:59:18 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D053EC0613D4;
        Thu, 12 Nov 2020 09:59:18 -0800 (PST)
Received: from ip4d145e30.dynamic.kabel-deutschland.de ([77.20.94.48] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1kdGsP-00070q-Hb; Thu, 12 Nov 2020 18:59:17 +0100
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 17/26] docs: reporting-bugs: explain options if reproducing on mainline fails
Date:   Thu, 12 Nov 2020 18:58:54 +0100
Message-Id: <53088b838b425a5705d5add9f66175e0a2b455c4.1605203187.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1605203187.git.linux@leemhuis.info>
References: <cover.1605203187.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1605203958;24c9afe5;
X-HE-SMSGID: 1kdGsP-00070q-Hb
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Explicitly lay out the remaining options if the user can't reproduce the
issue with a mainline kernel. Especially send those that are interested
in seeing it fixed in stable and longterm kernels to a section dedicated
to it (added in a later patch), as the process would get hard to follow
if all of it was explained here; especially as there is a back reference
to this process for regressions that are specific to stable and longterm
and were never present in mainline.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 Documentation/admin-guide/reporting-bugs.rst | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/admin-guide/reporting-bugs.rst b/Documentation/admin-guide/reporting-bugs.rst
index e9fe40a96b87..60a84f52724c 100644
--- a/Documentation/admin-guide/reporting-bugs.rst
+++ b/Documentation/admin-guide/reporting-bugs.rst
@@ -803,6 +803,23 @@ eliminate the reason for it before you reporting issues that occur with it. See
 the section above for details how to do that.
 
 
+Reproduce issue with the fresh kernel
+-------------------------------------
+
+    *Reproduce the issue with the kernel you just installed. If it doesn't show
+    up there, head over to the instructions for issues only happening with
+    stable and longterm kernels.*
+
+Check if the issue occurs with the fresh Linux kernel version you just
+installed. If it was fixed there already, consider sticking with this version
+line and abandoning your plan to report the issue. But keep in mind that other
+users might still be plagued by it, as long as it's not fixed in either stable
+and longterm version from kernel.org (and thus vendor kernels derived from
+those). If you prefer to use one of those or just want to help their users,
+head over to the section "Details about reporting issues only occurring in
+older kernel version lines" below.
+
+
 .. ############################################################################
 .. Temporary marker added while this document is rewritten. Sections above
 .. are new and dual-licensed under GPLv2+ and CC-BY 4.0, those below are old.
-- 
2.28.0

