Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35C072B0BE3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 18:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgKLR7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 12:59:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbgKLR7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 12:59:33 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC6AC061A49;
        Thu, 12 Nov 2020 09:59:30 -0800 (PST)
Received: from ip4d145e30.dynamic.kabel-deutschland.de ([77.20.94.48] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1kdGsb-00076N-JI; Thu, 12 Nov 2020 18:59:29 +0100
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 26/26] docs: reporting-bugs: add SPDX tag and license hint, remove markers
Date:   Thu, 12 Nov 2020 18:59:03 +0100
Message-Id: <e2556271695cb376d7c29749d303967ae9d4c51f.1605203187.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1605203187.git.linux@leemhuis.info>
References: <cover.1605203187.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=yes
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1605203971;26f1d192;
X-HE-SMSGID: 1kdGsb-00076N-JI
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the last leftovers from the old text. Also delete the temporary
markers added for the rewrite of this document. Add a SPDX tag with the
new license now that the rewrite is complete. Add a license hint whom to
attribute when distributing the text under CC-BY 4.0.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 Documentation/admin-guide/reporting-bugs.rst | 29 ++++++--------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/Documentation/admin-guide/reporting-bugs.rst b/Documentation/admin-guide/reporting-bugs.rst
index 592329afc2a5..6372800769e7 100644
--- a/Documentation/admin-guide/reporting-bugs.rst
+++ b/Documentation/admin-guide/reporting-bugs.rst
@@ -1,15 +1,17 @@
+.. SPDX-License-Identifier: (GPL-2.0+ OR CC-BY-4.0)
+..
+   If you want to distribute this document under the CC-BY-4.0, please use ‘The
+   Linux kernel developers’ for author attribution and either
+   https://www.kernel.org/doc/html/latest/admin-guide/reporting-bugs.html or
+   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/Documentation/admin-guide/reporting-bugs.rst
+   when pointing to the source.
+
 .. _reportingbugs:
 
+
 Reporting bugs
 ++++++++++++++
 
-.. ############################################################################
-.. Temporary marker added while this document is rewritten. The sections below
-.. up to a second marker of this kind are new and dual-licensed under GPLv2+
-.. and CC-BY 4.0. Both sections are incomplete as of now and thus might be
-.. inconsistent/not make sense before all patches of the rewrite got applied.
-.. ###########################################################################
-
 
 The short guide (aka TL;DR)
 ===========================
@@ -1532,16 +1534,3 @@ issues to the Linux kernel developers: the length and complexity of this
 document and the implications between the lines illustrate that. But that's how
 it is for now. The main author of this text hopes documenting the state of the
 art will lay some groundwork to improve the situation over time.
-
-.. ############################################################################
-.. Temporary marker added while this document is rewritten. Sections above
-.. are new and dual-licensed under GPLv2+ and CC-BY 4.0, those below are old.
-.. Both sections are incomplete as of now and thus sometimes inconsistent.
-.. ###########################################################################
-
-How to report Linux kernel bugs
-===============================
-
-Thank you!
-
-[Some of this is taken from Frohwalt Egerer's original linux-kernel FAQ]
-- 
2.28.0

