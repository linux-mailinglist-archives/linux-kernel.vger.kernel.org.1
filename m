Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 859B72F8E21
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 18:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbhAPRFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 12:05:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbhAPQa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 11:30:57 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43329C0617BA;
        Sat, 16 Jan 2021 06:35:48 -0800 (PST)
Received: from ip4d149f6e.dynamic.kabel-deutschland.de ([77.20.159.110] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1l0mg2-0005m6-Ns; Sat, 16 Jan 2021 15:35:42 +0100
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: [PATCH] docs: process/howto.rst: make sections on bug reporting match practice
Date:   Sat, 16 Jan 2021 15:35:42 +0100
Message-Id: <20210116143542.69199-1-linux@leemhuis.info>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1610807748;01b788a3;
X-HE-SMSGID: 1l0mg2-0005m6-Ns
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The file Documentation/process/howto.rst points to bugzilla.kernel.org
as the primary place to report kernel bugs to. For most of the kernel
that's the wrong place, as the MAINTAINERS file shows. Adjust those
sections to make them match current practice.

This change also removes a contradiction with the recently added text
Documentation/admin-guide/reporting-issues.rst, which is a reason for a
'this needs further discussion' warning note in there. The change is
thus a prerequisite to remove that warning, nevertheless it is left for
now to make sure people review the text's approach more carefully.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
v1:
- kind of a follow up to "[PATCH v1 (RFC)] docs: discourage users from using bugzilla.kernel.org"[1] – I decided to break that idea down into smaller pieces, which I guess is easier for everyone

[1] https://lore.kernel.org/lkml/20210110121033.130504-1-linux@leemhuis.info/
---
 Documentation/process/howto.rst | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/process/howto.rst b/Documentation/process/howto.rst
index 7a5c105e34d4..e4beeca57e5f 100644
--- a/Documentation/process/howto.rst
+++ b/Documentation/process/howto.rst
@@ -342,16 +342,10 @@ Adventurous testers are very welcome to runtime-test the linux-next.
 Bug Reporting
 -------------
 
-https://bugzilla.kernel.org is where the Linux kernel developers track kernel
-bugs.  Users are encouraged to report all bugs that they find in this
-tool.  For details on how to use the kernel bugzilla, please see:
-
-	https://bugzilla.kernel.org/page.cgi?id=faq.html
-
 The file 'Documentation/admin-guide/reporting-issues.rst' in the main kernel
-source directory has a good template for how to report a possible kernel bug,
-and details what kind of information is needed by the kernel developers to help
-track down the problem.
+source directory describes how to report a possible kernel bug, and details
+what kind of information is needed by the kernel developers to help track
+down the problem.
 
 
 Managing bug reports
@@ -364,7 +358,13 @@ improve your skills, and other developers will be aware of your presence.
 Fixing bugs is one of the best ways to get merits among other developers,
 because not many people like wasting time fixing other people's bugs.
 
-To work in the already reported bug reports, go to https://bugzilla.kernel.org.
+To work on already reported bug reports, find a subsystem you are interested in.
+Check the MAINTAINERS file where bugs for that subsystem get reported to; often
+it will be a mailing list, rarely a bugtracker. Search the archives of said
+place for recent reports and help where you see fit. You may also want to check
+https://bugzilla.kernel.org for bug reports; only a handful of kernel subsystems
+use it actively for reporting or tracking, nevertheless bugs for the whole
+kernel get filed there.
 
 
 Mailing lists
-- 
2.29.2

