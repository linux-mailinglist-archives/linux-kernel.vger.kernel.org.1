Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D59D2B0BDB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 18:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgKLR7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 12:59:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbgKLR7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 12:59:10 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD70C061A04;
        Thu, 12 Nov 2020 09:59:07 -0800 (PST)
Received: from ip4d145e30.dynamic.kabel-deutschland.de ([77.20.94.48] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1kdGsC-0006ue-Di; Thu, 12 Nov 2020 18:59:04 +0100
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 03/26] docs: reporting-bugs: step-by-step guide on how to report issues
Date:   Thu, 12 Nov 2020 18:58:40 +0100
Message-Id: <b439c3d74c541d4d7631203a52f9d697ea8c283d.1605203187.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1605203187.git.linux@leemhuis.info>
References: <cover.1605203187.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1605203947;764f585d;
X-HE-SMSGID: 1kdGsC-0006ue-Di
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a more detailed section on how to report issues to the Linux kernel
developers that nevertheless still is shorter, more straight-forward and
thus easier to gasp than the old text. It should provide enough details
for most users, even if it still leaves a lot of things unexplained.
Some of them can be important, that's why later patches will add a
reference section describing each of the steps and the motivation for it
in more detail. The text of the particular step will be repeated there
as introduction.

The order of the steps was chosen in the interest of the users: make
sure they get the basics right before they do more complicated,
time-consuming, and dangerous tasks. Some steps explain a few basics
that might seem natural to kernel developers, but are things that people
sometimes get wrong.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 Documentation/admin-guide/reporting-bugs.rst | 107 +++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/Documentation/admin-guide/reporting-bugs.rst b/Documentation/admin-guide/reporting-bugs.rst
index 97815a35c546..a654c54d7dc6 100644
--- a/Documentation/admin-guide/reporting-bugs.rst
+++ b/Documentation/admin-guide/reporting-bugs.rst
@@ -55,6 +55,113 @@ If you reached this point without a solution, ask for advice one the
 subsystem's mailing list.
 
 
+Step-by-step guide how to report issues to the kernel maintainers
+=================================================================
+
+The above TL;DR outlines roughly how to report issues to the Linux kernel
+developers. It might be all that's needed for people already familiar with
+reporting issues to Free/Libre & Open Source Software (FLOSS) projects. For
+everyone else there is this section. It is more detailed and uses a
+step-by-step approach. It still tries to be brief for readability and leaves
+out a lot of details; those are described below the step-by-step guide in a
+reference section, which explains each of the steps in more detail.
+
+Note: this section covers a few more aspects than the TL;DR and does things in
+a slightly different order. That's in your interest, to make sure you notice
+early if an issue that looks like a Linux kernel problem is actually caused by
+something else. These steps thus help to ensure the time you invest in this
+process won't feel wasted in the end:
+
+ * Stop reading this document and report the problem to your vendor instead,
+   unless you are running the latest mainline kernel already or are willing to
+   install it. This kernel must not be modified or enhanced in any way, and
+   thus be considered 'vanilla'.
+
+ * See if the issue you are dealing with qualifies as regression, security
+   issue, or a really severe problem: those are 'issues of high priority' that
+   need special handling in some steps that are about to follow.
+
+ * Check if your kernel was 'tainted' when the issue occurred, as the event
+   that made the kernel set this flag might be causing the issue you face.
+
+ * Locate the driver or kernel subsystem that seems to be causing the issue.
+   Find out how and where its developers expect reports. Note: most of the
+   time this won't be bugzilla.kernel.org, as issues typically need to be sent
+   by mail to a maintainer and a public mailing list.
+
+ * Search the archives of the bug tracker or mailing list in question
+   thoroughly for reports that might match your issue. Also check if you find
+   something with your favorite internet search engine or in the Linux Kernel
+   Mailing List (LKML) archives. If you find anything, join the discussion
+   instead of sending a new report.
+
+ * Create a fresh backup and put system repair and restore tools at hand.
+
+ * Ensure your system does not enhance its kernels by building additional
+   kernel modules on-the-fly, which solutions like DKMS might be doing locally
+   without your knowledge.
+
+ * Make sure it's not the kernel's surroundings that are causing the issue
+   you face.
+
+ * Write down coarsely how to reproduce the issue. If you deal with multiple
+   issues at once, create separate notes for each of them and make sure they
+   work independently on a freshly booted system. That's needed, as each issue
+   needs to get reported to the kernel developers separately, unless they are
+   strongly entangled.
+
+After these preparations you'll now enter the main part:
+
+ * Install the latest Linux mainline kernel: that's where all issues get
+   fixed first, because it's the version line the kernel developers mainly
+   care about. Testing and reporting with the latest Linux stable kernel can
+   be an acceptable alternative in some situations, for example during the
+   merge window; but during that period you might want to suspend your efforts
+   till its end anyway.
+
+ * Ensure the kernel you just installed does not 'taint' itself when
+   running.
+
+ * Reproduce the issue with the kernel you just installed. If it doesn't show
+   up there, head over to the instructions for issues only happening with
+   stable and longterm kernels.
+
+ * Optimize your notes: try to find and write the most straightforward way to
+   reproduce your issue. Make sure the end result has all the important
+   details, and at the same time is easy to read and understand for others
+   that hear about it for the first time. And if you learned something in this
+   process, consider searching again for existing reports about the issue.
+
+ * If the failure includes a stack dump, like an Oops does, consider decoding
+   it to find the offending line of code.
+
+ * If your problem is a regression, try to narrow down when the issue was
+   introduced as much as possible.
+
+ * Start to compile the report by writing a detailed description about the
+   issue. Always mention a few things: the latest kernel version you installed
+   for reproducing, the Linux Distribution used, and your notes on how to
+   reproduce the issue. Ideally, make the kernel's build configuration
+   (.config) and the output from ``dmesg`` available somewhere on the net and
+   link to it. Include or upload all other information that might be relevant,
+   like the output/screenshot of an Oops or the output from ``lspci``. Once
+   you wrote this main part, insert a normal length paragraph on top of it
+   outlining the issue and the impact quickly. On top of this add one sentence
+   that briefly describes the problem and gets people to read on. Now give the
+   thing a descriptive title or subject that yet again is shorter. Then you're
+   ready to send or file the report like the MAINTAINERS file told you, unless
+   you are dealing with one of those 'issues of high priority': they need
+   special care which is explained in 'Special handling for high priority
+   issues' below.
+
+ * Wait for reactions and keep the thing rolling until you can accept the
+   outcome in one way or the other. Thus react publicly and in a timely manner
+   to any inquiries. Test proposed fixes. Do proactive testing: retest with at
+   least every first release candidate (RC) of a new mainline version and
+   report your results. Send friendly reminders if things stall. And try to
+   help yourself, if you don't get any help or if it's unsatisfying.
+
+
 .. ############################################################################
 .. Temporary marker added while this document is rewritten. Sections above
 .. are new and dual-licensed under GPLv2+ and CC-BY 4.0, those below are old.
-- 
2.28.0

