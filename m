Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9781E27FBB3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 10:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731710AbgJAIlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 04:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731663AbgJAIlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 04:41:00 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D11C0613D0;
        Thu,  1 Oct 2020 01:41:00 -0700 (PDT)
Received: from ip4d14bc8c.dynamic.kabel-deutschland.de ([77.20.188.140] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1kNu94-0000mi-Qw; Thu, 01 Oct 2020 10:40:59 +0200
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 17/26] docs: reporting-bugs: explain options if reproducing on mainline fails
Date:   Thu,  1 Oct 2020 10:39:38 +0200
Message-Id: <9c0ab407bcbecca3c039d6d836368011d4a4097f.1601541165.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601541165.git.linux@leemhuis.info>
References: <cover.1601541165.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1601541660;7dc8d30b;
X-HE-SMSGID: 1kNu94-0000mi-Qw
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
 Documentation/admin-guide/reporting-bugs.rst | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/admin-guide/reporting-bugs.rst b/Documentation/admin-guide/reporting-bugs.rst
index 02f846f4a324..2a7d13562905 100644
--- a/Documentation/admin-guide/reporting-bugs.rst
+++ b/Documentation/admin-guide/reporting-bugs.rst
@@ -744,6 +744,22 @@ for it before you reporting issues that occur with it. See the section above for
 details how to do that.
 
 
+Reproduce issue with the fresh kernel
+-------------------------------------
+
+    *Reproduce the issue with the kernel you just installed. If it doesn't show
+    up there, head over to the instructions for issues only happening with
+    stable and longterm kernels if you want to see it fixed there.*
+
+Check if the issue occurs with the Linux kernel you just installed. If it was
+fixed there already, consider sticking with this version line and canceling
+your plan to report the issue. But keep in mind that other users might be
+plagued by it, as long as it's not fixed in either stable and longterm version
+from kernel.org (and thus vendor kernels derived from those). If you prefer to
+use one of those and help their users, head over to the section "Details about
+reporting issues only occurring in older kernel version lines" below.
+
+
 .. ############################################################################
 .. Temporary marker added while this document is rewritten. Sections above
 .. are new and dual-licensed under GPLv2+ and CC-BY 4.0, those below are old.
-- 
2.26.2

