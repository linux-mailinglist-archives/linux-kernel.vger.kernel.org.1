Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06AB927FBE7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 10:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731771AbgJAIum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 04:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbgJAIuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 04:50:40 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B42AC0613D0;
        Thu,  1 Oct 2020 01:50:40 -0700 (PDT)
Received: from ip4d14bc8c.dynamic.kabel-deutschland.de ([77.20.188.140] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1kNuIP-0004XP-Ux; Thu, 01 Oct 2020 10:50:38 +0200
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 26/26] docs: reporting-bugs: add SPDX tag and license hint, remove markers
Date:   Thu,  1 Oct 2020 10:50:37 +0200
Message-Id: <a755240762dd07bb48cf3e561b1e6cfa894f9178.1601541165.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601541165.git.linux@leemhuis.info>
References: <cover.1601541165.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1601542240;ce6046ea;
X-HE-SMSGID: 1kNuIP-0004XP-Ux
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the last leftovers from the old text. Also delete the temporary
markers added for the rewrite of this document. Add a SPDX tag with the
new license now that the rewrite is complete. Add a license hint whom to
attribute when distributing the text under CC-BY 4.0.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 Documentation/admin-guide/reporting-bugs.rst | 27 ++++++--------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/Documentation/admin-guide/reporting-bugs.rst b/Documentation/admin-guide/reporting-bugs.rst
index 42f59419263a..bbddea6b1567 100644
--- a/Documentation/admin-guide/reporting-bugs.rst
+++ b/Documentation/admin-guide/reporting-bugs.rst
@@ -1,15 +1,10 @@
+.. SPDX-License-Identifier: (GPL-2.0+ OR CC-BY-4.0)
+
 .. _reportingbugs:
 
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
@@ -1467,15 +1462,9 @@ document and the implications between the lines illustrate that. But that's how
 it is for now. The main author of this text hopes documenting the state of the
 art will lay some groundwork to improve the situation over time.
 
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
+*Licensing advice: This document is dual-licensed under GPL-2.0+ and CC-BY 4.0.
+If you want to distribute it under the terms of the latter, please use 'The
+Linux kernel developers' for author attribution and either
+https://www.kernel.org/doc/html/latest/admin-guide/reporting-bugs.html or
+https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/Documentation/admin-guide/reporting-bugs.rst
+when pointing to the source.*
-- 
2.26.2

