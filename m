Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13E872B0C28
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 19:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgKLSCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 13:02:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgKLR7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 12:59:07 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F99C0617A6;
        Thu, 12 Nov 2020 09:59:07 -0800 (PST)
Received: from ip4d145e30.dynamic.kabel-deutschland.de ([77.20.94.48] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1kdGsC-0006ue-Q7; Thu, 12 Nov 2020 18:59:04 +0100
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 05/26] docs: reporting-bugs: begin reference section providing details
Date:   Thu, 12 Nov 2020 18:58:42 +0100
Message-Id: <d17db477809c640049eacbadb56bca89eb51e104.1605203187.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1605203187.git.linux@leemhuis.info>
References: <cover.1605203187.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1605203947;764f585d;
X-HE-SMSGID: 1kdGsC-0006ue-Q7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide an introduction to the reference section that will provide more
details how to report an issue. Mention a few general things here. Those
are not strictly needed, but likely wise to write down somewhere.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
v2:
- mention https://jvns.ca/blog/good-questions/

= RFC =

Should we keep the links to
https://www.chiark.greenend.org.uk/~sgtatham/bugs.html and
http://www.catb.org/esr/faqs/smart-questions.html? Are they worth it? Or
is there anything similar or better that's a bit fresher and ideally
still maintained?
---
 Documentation/admin-guide/reporting-bugs.rst | 47 +++++++++++++++++---
 1 file changed, 41 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/reporting-bugs.rst b/Documentation/admin-guide/reporting-bugs.rst
index 2b48c824d070..8993b4ccb0f0 100644
--- a/Documentation/admin-guide/reporting-bugs.rst
+++ b/Documentation/admin-guide/reporting-bugs.rst
@@ -210,6 +210,47 @@ rebased on new stable or longterm releases. If that case follow these steps:
    as the stable mailing list.
 
 
+Reference section: Reporting issues to the kernel maintainers
+=============================================================
+
+The detailed guides above outline all the major steps in brief fashion, which
+should be enough for most people. But sometimes there are situations where even
+experienced users might wonder how to actually do one of those steps. That's
+what this section is for, as it will provide a lot more details on each of the
+above steps. Consider this as reference documentation: it's possible to read it
+from top to bottom. But it's mainly meant to skim over and a place to look up
+details how to actually perform those steps.
+
+A few words of general advice before digging into the details:
+
+ * The Linux kernel developers are well aware this process is complicated and
+   demands more than other FLOSS projects. We'd love to make it simpler. But
+   that would require work in various places as well as some infrastructure,
+   which would need constant maintenance; nobody has stepped up to do that
+   work, so that's just how things are for now.
+
+ * A warranty or support contract with some vendor doesn't entitle you to
+   request fixes from developers in the upstream Linux kernel community: such
+   contracts are completely outside the scope of the Linux kernel, its
+   development community, and this document. That's why you can't demand
+   anything such a contract guarantees in this context, not even if the
+   developer handling the issue works for the vendor in question. If you want
+   to claim your rights, use the vendor's support channel instead. When doing
+   so, you might want to mention you'd like to see the issue fixed in the
+   upstream Linux kernel; motivate them by saying it's the only way to ensure
+   the fix in the end will get incorporated in all Linux distributions.
+
+ * If you never reported an issue to a FLOSS project before you should consider
+   reading `How to Report Bugs Effectively
+   <https://www.chiark.greenend.org.uk/~sgtatham/bugs.html>`_, `How To Ask
+   Questions The Smart Way
+   <http://www.catb.org/esr/faqs/smart-questions.html>`_, and `How to ask good
+   questions <https://jvns.ca/blog/good-questions/>`_.
+
+With that off the table, find below the details on how to properly report
+issues to the Linux kernel developers.
+
+
 .. ############################################################################
 .. Temporary marker added while this document is rewritten. Sections above
 .. are new and dual-licensed under GPLv2+ and CC-BY 4.0, those below are old.
@@ -286,12 +327,6 @@ http://vger.kernel.org/lkml/).
 Tips for reporting bugs
 -----------------------
 
-If you haven't reported a bug before, please read:
-
-	https://www.chiark.greenend.org.uk/~sgtatham/bugs.html
-
-	http://www.catb.org/esr/faqs/smart-questions.html
-
 It's REALLY important to report bugs that seem unrelated as separate email
 threads or separate bugzilla entries.  If you report several unrelated
 bugs at once, it's difficult for maintainers to tease apart the relevant
-- 
2.28.0

