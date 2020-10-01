Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDF7627FBB0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 10:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731674AbgJAIlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 04:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgJAIlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 04:41:00 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44DEC0613D0;
        Thu,  1 Oct 2020 01:40:59 -0700 (PDT)
Received: from ip4d14bc8c.dynamic.kabel-deutschland.de ([77.20.188.140] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1kNu8z-0000mi-Js; Thu, 01 Oct 2020 10:40:58 +0200
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 16/26] docs: reporting-bugs: let users check taint status again
Date:   Thu,  1 Oct 2020 10:39:37 +0200
Message-Id: <895e726ac90d2cec9edb24baa901a43753b90d8b.1601541165.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601541165.git.linux@leemhuis.info>
References: <cover.1601541165.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1601541660;7dc8d30b;
X-HE-SMSGID: 1kNu8z-0000mi-Js
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel just installed in the previous step might taint itself for
reasons unrelated to the issue the reader used when he started this
process. Make sure the reader catches this early, as this is the area
where it really matters. The former check was just ensuring the reader
notices early if his kernel is tainted, e.g. before he does more
complicated and dangerous things in this process.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 Documentation/admin-guide/reporting-bugs.rst | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/admin-guide/reporting-bugs.rst b/Documentation/admin-guide/reporting-bugs.rst
index dee6d65aa95c..02f846f4a324 100644
--- a/Documentation/admin-guide/reporting-bugs.rst
+++ b/Documentation/admin-guide/reporting-bugs.rst
@@ -731,6 +731,19 @@ using ``git`` straight from the `official development repository on kernel.org
 <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/>`_.
 
 
+Check 'taint' flag
+------------------
+
+    *Ensure the kernel you just installed does not 'taint' itself when running.*
+
+As outlined above in more detail already: the kernel sets a 'taint' flag when
+something happens that can lead to follow-up errors that look totally unrelated.
+That's why you need to check if the kernel you just installed does not set this
+flag. And if it does, you in almost all the cases needs to eliminate the reason
+for it before you reporting issues that occur with it. See the section above for
+details how to do that.
+
+
 .. ############################################################################
 .. Temporary marker added while this document is rewritten. Sections above
 .. are new and dual-licensed under GPLv2+ and CC-BY 4.0, those below are old.
-- 
2.26.2

