Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B30B72B0C04
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 19:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgKLR7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 12:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbgKLR7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 12:59:17 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713ACC0613D1;
        Thu, 12 Nov 2020 09:59:17 -0800 (PST)
Received: from ip4d145e30.dynamic.kabel-deutschland.de ([77.20.94.48] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1kdGsO-00070q-5J; Thu, 12 Nov 2020 18:59:16 +0100
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 10/26] docs: reporting-bugs: remind people to look for existing reports
Date:   Thu, 12 Nov 2020 18:58:47 +0100
Message-Id: <3ac369304c4fdb2f93d0e8c5e496113bd15ef399.1605203187.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1605203187.git.linux@leemhuis.info>
References: <cover.1605203187.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1605203957;fbc755ce;
X-HE-SMSGID: 1kdGsO-00070q-5J
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tells users to search for existing reports, as not reporting them a
second time is in their own interest. Tell them where to look and
provide a few hints how to search properly, as that is easy to get
wrong. That seems to be especially true when it comes to things like
graphics cards or wifi modules: mentioning the model name often is not
much help, but mentioning its main chip often leads to the results you
are looking for. This might be obvious to kernel developers, but for
many users it's not.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---

= RFC =

Have I gone to far in describing how to find good search terms? I got
the impression quite a few could benefit from a detailed description.
---
 Documentation/admin-guide/reporting-bugs.rst | 59 ++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/Documentation/admin-guide/reporting-bugs.rst b/Documentation/admin-guide/reporting-bugs.rst
index 9e0e9b2ba27b..455d67be0fd7 100644
--- a/Documentation/admin-guide/reporting-bugs.rst
+++ b/Documentation/admin-guide/reporting-bugs.rst
@@ -530,6 +530,65 @@ modified during tree-wide cleanups by developers that do not care about the
 particular driver at all.
 
 
+Search for existing reports
+---------------------------
+
+    *Search the archives of the bug tracker or mailing list in question
+    thoroughly for reports that might match your issue. Also check if you find
+    something with your favorite internet search engine or in the Linux Kernel
+    Mailing List (LKML) archives. If you find anything, join the discussion
+    instead of sending a new report.*
+
+Reporting an issue that someone else already brought forward is often a waste
+of time for everyone involved, especially you as the reporter. So it's in your
+own interest to thoroughly check if somebody reported the issue already. Thus
+do not hurry with this step of the reporting process. Spending 30 to 60 minutes
+or even more time can save you and others quite a lot of time and trouble.
+
+The best place to search is the bug tracker or the mailing list where your
+report needs to be filed. You'll find quite a few of those lists on
+`lore.kernel.org/ <https://lore.kernel.org/>`_, but some are hosted in
+different places. That for example is the case for the ath10k WiFi driver used
+as example in the previous step. But you'll often find the archives for these
+lists easily on the net. Searching for 'archive ath10k@lists.infradead.org' for
+example will quickly lead you to the `Info page for the ath10k mailing list
+<https://lists.infradead.org/mailman/listinfo/ath10k>`_, which at the top links
+to its `list archives <https://lists.infradead.org/pipermail/ath10k/>`_.
+
+Sadly this and quite a few other lists miss a way to search the archives. In
+those cases use a regular internet search engine and add something like
+'site:lists.infradead.org/pipermail/ath10k/' to your search terms, which limits
+the results to the archives at that URL.
+
+Additionally, search the internet and the `Linux Kernel Mailing List (LKML)
+archives <https://lore.kernel.org/lkml/>`_, as maybe the real culprit might be
+in some other subsystem. Searching in `bugzilla.kernel.org
+<https://bugzilla.kernel.org/>`_ might also be a good idea, but if you find
+anything there keep in mind: most subsystems expect reports in different
+places, hence those you find there might have not even reached the people
+responsible for the subsystem in question. Nevertheless, the data there might
+provide valuable insights.
+
+If you get flooded with results consider telling your search engine to limit
+search timeframe to the past month or year. And wherever you search, make sure
+to use good search terms; vary them a few times, too. While doing so try to
+look at the issue from the perspective of someone else: that will help you to
+come up with other words to use as search terms. Also make sure not to use too
+many search terms at once. Remember to search with and without information like
+the name of the kernel driver or the name of the affected hardware component.
+But its exact brand name (say 'ASUS Red Devil Radeon RX 5700 XT Gaming OC')
+often is not much helpful, as it is too specific. Instead try search terms like
+the model line (Radeon 5700 or Radeon 5000) and the code name of the main chip
+('Navi' or 'Navi10') with and without its manufacturer ('AMD').
+
+In case you find an existing report about your issue, join the discussion, as
+you might be able to provide valuable additional information. That can be
+important even when a fix is prepared or in its final stages already, as
+developers might look for people that can provide additional information or
+test a proposed fix. Jump to the section 'Duties after the report went out' for
+details on how to get properly involved.
+
+
 .. ############################################################################
 .. Temporary marker added while this document is rewritten. Sections above
 .. are new and dual-licensed under GPLv2+ and CC-BY 4.0, those below are old.
-- 
2.28.0

