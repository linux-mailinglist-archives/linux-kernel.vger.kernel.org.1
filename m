Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6C427FC05
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 10:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731754AbgJAI43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 04:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731592AbgJAI4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 04:56:25 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6CCC0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 01:56:25 -0700 (PDT)
Received: from ip4d14bc8c.dynamic.kabel-deutschland.de ([77.20.188.140] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1kNu7x-0006b9-8X; Thu, 01 Oct 2020 10:39:49 +0200
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 03/26] docs: reporting-bugs: step-by-step guide on how to report issues
Date:   Thu,  1 Oct 2020 10:39:24 +0200
Message-Id: <0c647add40e56b403bc17e9de1430917aa88bacb.1601541165.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601541165.git.linux@leemhuis.info>
References: <cover.1601541165.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1601542585;8582cca0;
X-HE-SMSGID: 1kNu7x-0006b9-8X
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a more detailed section on how to report bugs to the Linux kernel
developers that nevertheless still is shorter, more straight-forward and
thus easier to gasp than the old text. It should provide enough details
for most users, even if it still leaves a lot of things unexplained.
Some of them can be important, that's why later patches will add a
reference section describing each of the steps and the motivation for it
in more detail. The text of the particular step will be repeated there
as introduction.

The order of the steps was chosen in the interest of the users: make
sure they get the basics right before they do more complicated,
time-consuming, and dangerous tasks. Some of it also explain a few
basics that might seem natural to kernel developers, but are things that
people often get wrong.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 Documentation/admin-guide/reporting-bugs.rst | 103 +++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/Documentation/admin-guide/reporting-bugs.rst b/Documentation/admin-guide/reporting-bugs.rst
index 7bde6f32ff72..203df36af55f 100644
--- a/Documentation/admin-guide/reporting-bugs.rst
+++ b/Documentation/admin-guide/reporting-bugs.rst
@@ -53,6 +53,109 @@ Security issues are typically best report privately; also CC the security team
 or forward your report there.
 
 
+Step-by-step guide how to report issues to the kernel maintainers
+=================================================================
+
+Above TL;DR outlines roughly how to report issues to the Linux kernel
+developers. It might be all that's needed for people already familiar with
+reporting issues to Free/Libre & Open Source Software (FLOSS) projects. For
+everyone else there is this section. It is more detailed and uses a
+step-by-step approach. It still tries to be brief for readability; if it's to
+brief for you, look up the details in the reference section below, where each
+of the steps is explained in more detail.
+
+Note, this section covers a few more aspects than the TL;DR and does things in a
+slightly different order. That's in your interest, to make sure you notice early
+if an issue that looks like a Linux kernel problem is actually caused by
+something else. These steps thus help to ensure the time you invest in this
+process won't feel wasted in the end:
+
+ * Stop reading this document and report the problem to your vendor instead,
+   unless you are running a vanilla mainline kernel already or are willing to
+   install it.
+
+ * See if the issue you are dealing with qualifies as regression, security
+   issue, or a really severe problem: those are 'issues of high priority' that
+   need special handling in some steps that are about to follow.
+
+ * Check if your kernel was 'tainted' when the issue occurred, as the event that
+   made the kernel set this flag might be causing the issue you face.
+
+ * Locate the driver or kernel subsystem that seems to be causing the issue.
+   Find out how and where its developers expect reports. Note: most of the time
+   this won't be `bugzilla.kernel.org <https://bugzilla.kernel.org/>`_, as issues
+   typically need to be sent by mail to a maintainer and a public mailing list.
+
+ * Search the archives of the bug tracker or mailing list in question
+   thoroughly for reports that might match your issue. Also check if you find
+   something with your favorite internet search engine or in the `Linux Kernel
+   Mailing List (LKML) archives <https://lore.kernel.org/lkml/>`_. If you find
+   anything, join the discussion instead of sending a new report.
+
+ * Create a fresh backup and put system repair and restore tools at hand.
+
+ * Ensure your system does not enhance its kernels by building additional
+   kernel modules on-the-fly locally, which solutions like DKMS might be doing
+   without your knowledge.
+
+ * Make sure it's not the kernels surroundings that are causing the issue you
+   face.
+
+ * Write down coarsely how to reproduce the issue. If you deal with multiple
+   issue at once, create separate notes for each of them and make sure they
+   work independently on a freshly booted system. That's needed, as each issue
+   needs to get reported to the kernel developers separately, unless they are
+   strongly entangled.
+
+After these preparations you'll now enter the main part:
+
+ * Install the latest Linux mainline kernel: that's where all issue get fixed
+   first, because it's the version line the kernel developers mainly care about.
+   Testing and reporting with the latest Linux stable kernel can be acceptable
+   alternative in some situations, but is best avoided.
+
+ * Ensure the kernel you just installed does not 'taint' itself when running.
+
+ * Reproduce the issue with the kernel you just installed. If it doesn't show up
+   there, head over to the instructions for issues only happening with stable
+   and longterm kernels if you want to see it fixed there.
+
+ * Optimize your notes: try to find and write the most straightforward way to
+   reproduce your issue. Make sure the end result has all the important details,
+   and at the same time is easy to read and understand for others that hear
+   about it for the first time. And if you learned something in this process,
+   consider searching again for existing reports about the issue.
+
+ * If the failure includes a stack dump, like an Oops does, consider decoding it
+   to find the offending line of code.
+
+ * If your problem is a regression, try to narrow down when the issue was
+   introduced as much as possible.
+
+ * Start to compile the report by writing a detailed description about the
+   issue. Always mentions a few things: the latest kernel version you installed
+   for reproducing, the Linux Distribution used, and your notes how to
+   reproduce the issue. Ideally, make the kernels build configuration (.config)
+   and the output from ``dmesg`` available somewhere on the net and link to it.
+   Include or upload all other information that might be relevant, like the
+   output/screenshot of an Oops or the output from ``lspci``. Once you
+   wrote this main part insert a normal length paragraph on top of it outlining
+   the issue and the impact quickly. On top of this add one sentence that
+   briefly describes the problem and gets people to read on. Now give the thing
+   a descriptive title or subject that yet again is shorter. Then you're ready
+   to send or file the report like the `MAINTAINERS file
+   <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/MAINTAINERS>`_
+   told you, unless you are dealing with one of those 'issues of high priority':
+   they need special care which is explained in 'Special handling for high
+   priority issues' below.
+
+ * Wait for reactions and keep the thing rolling until you can accept the
+   outcome in one way or the other. Thus react publicly and in a timely manner
+   to any inquiries. Test proposed fixes. Do proactive testing when a new rc1
+   gets released. Sent friendly reminders if things stall. And try to help
+   yourself, if you don't get any help or if it is unsatisfying.
+
+
 .. ############################################################################
 .. Temporary marker added while this document is rewritten. Sections above
 .. are new and dual-licensed under GPLv2+ and CC-BY 4.0, those below are old.
-- 
2.26.2

