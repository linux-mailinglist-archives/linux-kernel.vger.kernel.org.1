Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30EA327FC08
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 10:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731822AbgJAI4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 04:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731592AbgJAI4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 04:56:31 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7E0C0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 01:56:31 -0700 (PDT)
Received: from ip4d14bc8c.dynamic.kabel-deutschland.de ([77.20.188.140] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1kNu7w-0006b9-F2; Thu, 01 Oct 2020 10:39:48 +0200
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 02/26] docs: reporting-bugs: Create a TLDR how to report issues
Date:   Thu,  1 Oct 2020 10:39:23 +0200
Message-Id: <dc293f6d4f71ea827c861c64e88dfa0316f1d934.1601541165.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601541165.git.linux@leemhuis.info>
References: <cover.1601541165.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1601542591;4b97c1ad;
X-HE-SMSGID: 1kNu7w-0006b9-F2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get straight to the point in a few paragraphs instead of forcing users
to read quite a bit of text, like the old approach did.

All normally needed fits into the first two paragraphs. The third is
dedicated to issues only happening in stable and longterm kernels, as
things otherwise get hard to follow. At the end explicitly spell out
that some issues need to be handled slightly different.

This TLDR naturally leaves lots of details out. But it will be good
enough in some situations, for example for users that recently reported
an issue or are familiar with reporting issues to FLOSS projects.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 Documentation/admin-guide/reporting-bugs.rst | 43 ++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/Documentation/admin-guide/reporting-bugs.rst b/Documentation/admin-guide/reporting-bugs.rst
index 4bbb9132782b..7bde6f32ff72 100644
--- a/Documentation/admin-guide/reporting-bugs.rst
+++ b/Documentation/admin-guide/reporting-bugs.rst
@@ -10,6 +10,49 @@ Reporting bugs
 .. inconsistent/not make sense before all patches of the rewrite got applied.
 .. ###########################################################################
 
+
+The short guide (aka TL;DR)
+===========================
+
+This is how you report issues with the Linux kernel to its developers:
+
+If you deal with multiple issues at once, process each of them separately. Try
+your best guess which area of the kernel might be responsible for your issue.
+Check the `MAINTAINERS file
+<https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/MAINTAINERS>`_
+how developers of that particular area expect to be told about issues; note,
+it's rarely `bugzilla.kernel.org <https://bugzilla.kernel.org/>`_, as most
+subsystems expect reports by mail sent to their maintainers and their public
+mailing list!
+
+Check the archives of the determined destination thoroughly for existing
+reports; also search the LKML archives and the internet as a whole. If you can't
+find any, install the `latest Linux mainline version <https://kernel.org/>`_.
+Make sure to use a vanilla kernel and avert any add-on kernel modules externally
+developed; also ensure the kernel is running in a healthy environment and does
+not 'taint' itself before the issue occurs. If you can reproduce it, write a
+report to the destination you determined earlier. Afterwards keep the ball
+rolling by proactive testing, a status update now and then, and helping where
+you can.
+
+You can't reproduce an issue with mainline you want to see fixed in older
+version lines? Then make sure the line you care about still gets support.
+Install its latest release as vanilla kernel. If you can reproduce the issue
+there, try to find the commit that fixed it in mainline or any discussion
+preceding it: those will often mention if backporting is planed or impossible;
+if not, ask for it. In case you don't find anything, check if it's a regression
+specific to the version line that need to be bisected and report just like a
+problem in mainline with the stable mailing list CCed. If you reached this point
+without a solution, ask for advice by mailing the subsystem maintainer with the
+subsystem and stable mailing list in CC.
+
+If you deal with a regression, bisect it to find the culprit and CC or forward
+your report to its developers.
+
+Security issues are typically best report privately; also CC the security team
+or forward your report there.
+
+
 .. ############################################################################
 .. Temporary marker added while this document is rewritten. Sections above
 .. are new and dual-licensed under GPLv2+ and CC-BY 4.0, those below are old.
-- 
2.26.2

