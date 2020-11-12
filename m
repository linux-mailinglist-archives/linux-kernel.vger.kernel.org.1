Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9B862B0BDA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 18:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgKLR7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 12:59:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbgKLR7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 12:59:10 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BDAC061A47;
        Thu, 12 Nov 2020 09:59:07 -0800 (PST)
Received: from ip4d145e30.dynamic.kabel-deutschland.de ([77.20.94.48] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1kdGsC-0006ue-20; Thu, 12 Nov 2020 18:59:04 +0100
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 01/26] docs: reporting-bugs: temporary markers for licensing and diff reasons
Date:   Thu, 12 Nov 2020 18:58:38 +0100
Message-Id: <b80b1387cf09fb897f4a527bc487fff3012d1181.1605203187.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1605203187.git.linux@leemhuis.info>
References: <cover.1605203187.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1605203947;764f585d;
X-HE-SMSGID: 1kdGsC-0006ue-20
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add two temporary markers for the transition to the rewritten document.

Both tell users that the document is incomplete and partly inconsistent
before all patches from the series got applied. It also points out the
new text is dual-licensed under GPLv2+ and CC-BY 4.0. The latter is
better for documentation in general. It's also more liberal, which is a
nice-to-have for a document like this, as that makes it possible for
websites and books to republish it or build upon it.

The second marker separates old and new text, which makes diffs a lot
more readable. It's also there for licensing reasons, to make is obvious
that all old text got removed in the end. Then a proper SPDX license tag
will get added as well.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---

= RFC =

Let me know if you think dual-licensing was a bad idea or if CC-BY-4.0
is a bad choice here.
---
 Documentation/admin-guide/reporting-bugs.rst | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/admin-guide/reporting-bugs.rst b/Documentation/admin-guide/reporting-bugs.rst
index 42481ea7b41d..4bbb9132782b 100644
--- a/Documentation/admin-guide/reporting-bugs.rst
+++ b/Documentation/admin-guide/reporting-bugs.rst
@@ -3,6 +3,19 @@
 Reporting bugs
 ++++++++++++++
 
+.. ############################################################################
+.. Temporary marker added while this document is rewritten. The sections below
+.. up to a second marker of this kind are new and dual-licensed under GPLv2+
+.. and CC-BY 4.0. Both sections are incomplete as of now and thus might be
+.. inconsistent/not make sense before all patches of the rewrite got applied.
+.. ###########################################################################
+
+.. ############################################################################
+.. Temporary marker added while this document is rewritten. Sections above
+.. are new and dual-licensed under GPLv2+ and CC-BY 4.0, those below are old.
+.. Both sections are incomplete as of now and thus sometimes inconsistent.
+.. ###########################################################################
+
 Background
 ==========
 
-- 
2.28.0

