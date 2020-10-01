Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2756127FBB2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 10:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731483AbgJAIlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 04:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731670AbgJAIlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 04:41:00 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94931C0613D0;
        Thu,  1 Oct 2020 01:41:00 -0700 (PDT)
Received: from ip4d14bc8c.dynamic.kabel-deutschland.de ([77.20.188.140] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1kNu95-0000mi-5s; Thu, 01 Oct 2020 10:40:59 +0200
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 18/26] docs: reporting-bugs: let users optimize their notes
Date:   Thu,  1 Oct 2020 10:39:39 +0200
Message-Id: <1cac44ddfd3aa33bfa485b47951690fb88d4f9ee.1601541165.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601541165.git.linux@leemhuis.info>
References: <cover.1601541165.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1601541660;7dc8d30b;
X-HE-SMSGID: 1kNu95-0000mi-5s
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reader now users the mainline kernel and is getting closer to
reporting the issue, so it's a good point to let the person recheck and
optimize the notes how to reproduce the issue. It's also a good moment
to make him search again for existing reports, as he might have learned
something in the previous steps.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 Documentation/admin-guide/reporting-bugs.rst | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/admin-guide/reporting-bugs.rst b/Documentation/admin-guide/reporting-bugs.rst
index 2a7d13562905..c9a3491bf4db 100644
--- a/Documentation/admin-guide/reporting-bugs.rst
+++ b/Documentation/admin-guide/reporting-bugs.rst
@@ -760,6 +760,26 @@ use one of those and help their users, head over to the section "Details about
 reporting issues only occurring in older kernel version lines" below.
 
 
+Optimize description to reproduce issue
+---------------------------------------
+
+    *Optimize your notes: try to find and write the most straightforward way
+    to reproduce your issue. Make sure the end result has all the important
+    details, and at the same time is easy to read and understand for others
+    that hear about it for the first time. And if you learned something in this
+    process, consider searching again for existing reports about the issue.*
+
+An unnecessarily complex report makes it quite hard for others to understand
+your report later, thus try to find a reproducer that's straight forward to
+describe and thus easy to understand in written form. Make it long enough and
+include all important details, but at the same time try to keep it as short
+as possible.
+
+In this in the previous steps you likely have learned a thing or two about the
+issue you face. Use this knowledge and search again for existing reports
+instead you can join.
+
+
 .. ############################################################################
 .. Temporary marker added while this document is rewritten. Sections above
 .. are new and dual-licensed under GPLv2+ and CC-BY 4.0, those below are old.
-- 
2.26.2

