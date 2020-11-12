Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1B4D2B0BD9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 18:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgKLR7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 12:59:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgKLR7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 12:59:07 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F94C0613D1;
        Thu, 12 Nov 2020 09:59:07 -0800 (PST)
Received: from ip4d145e30.dynamic.kabel-deutschland.de ([77.20.94.48] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1kdGsC-0006ue-7n; Thu, 12 Nov 2020 18:59:04 +0100
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 02/26] docs: reporting-bugs: Create a TLDR how to report issues
Date:   Thu, 12 Nov 2020 18:58:39 +0100
Message-Id: <8f359da90f3234bdaa49912dd9d082b0042b89bf.1605203187.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1605203187.git.linux@leemhuis.info>
References: <cover.1605203187.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1605203947;764f585d;
X-HE-SMSGID: 1kdGsC-0006ue-7n
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get straight to the point in a few paragraphs instead of forcing users
to read quite a bit of text, like the old approach did.

All normally needed fits into the first three paragraphs. The fourth is
dedicated to issues only happening in stable and longterm kernels, as
things otherwise get hard to follow.

This TLDR naturally leaves lots of details out. But it will be good
enough in some situations, for example for users that recently reported
an issue or are familiar with reporting issues to FLOSS projects.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---

v2: reshuffled and rewritten to make this section more straight forward
---
 Documentation/admin-guide/reporting-bugs.rst | 45 ++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/Documentation/admin-guide/reporting-bugs.rst b/Documentation/admin-guide/reporting-bugs.rst
index 4bbb9132782b..97815a35c546 100644
--- a/Documentation/admin-guide/reporting-bugs.rst
+++ b/Documentation/admin-guide/reporting-bugs.rst
@@ -10,6 +10,51 @@ Reporting bugs
 .. inconsistent/not make sense before all patches of the rewrite got applied.
 .. ###########################################################################
 
+
+The short guide (aka TL;DR)
+===========================
+
+If you're facing multiple issues with the Linux kernel at once, report each
+separately to its developers. Try your best guess which kernel part might be
+causing the issue. Check the :ref:`MAINTAINERS <maintainers>` file for how its
+developers expect to be told about issues. Note, it's rarely
+`bugzilla.kernel.org <https://bugzilla.kernel.org/>`_, as in almost all cases
+the report needs to be sent by email!
+
+Check the destination thoroughly for existing reports; also search the LKML
+archives and the web. Join existing discussion if you find matches. If you
+don't find any, install `the latest Linux mainline kernel
+<https://kernel.org/>`_. Make sure it's vanilla, thus is not patched or using
+add-on kernel modules. Also ensure the kernel is running in a healthy
+environment and is not already tainted before the issue occurs.
+
+If you can reproduce your issue with the mainline kernel, send a report to the
+destination you determined earlier. Make sure it includes all relevant
+information, which in case of a regression should mention the change that's
+causing it which can often can be found with a bisection. Also ensure the
+report reaches all people that need to know about it, for example the security
+team, the stable maintainers or the developers of the patch that causes a
+regression. Once the report it out, answer any questions that might be raised
+and help where you can. That includes keeping the ball rolling: every time a
+new rc1 mainline kernel is released, check if the issue is still happening
+there and attach a status update to your initial report.
+
+If you can not reproduce the issue with the mainline kernel, consider sticking
+with it; if you'd like to use an older version line and want to see it fixed
+there, first make sure it's still supported. Install its latest release as
+vanilla kernel. If you cannot reproduce the issue there, try to find the commit
+that fixed it in mainline or any discussion preceding it: those will often
+mention if backporting is planed or considered too complex. If backporting was
+not discussed, ask if it's in the cards. In case you don't find any commits or
+a preceding discussion, see the Linux-stable mailing list archives for existing
+reports, as it might be a regression specific to the version line. If it is,
+report it like you would report a problem in mainline (including the
+bisection).
+
+If you reached this point without a solution, ask for advice one the
+subsystem's mailing list.
+
+
 .. ############################################################################
 .. Temporary marker added while this document is rewritten. Sections above
 .. are new and dual-licensed under GPLv2+ and CC-BY 4.0, those below are old.
-- 
2.28.0

