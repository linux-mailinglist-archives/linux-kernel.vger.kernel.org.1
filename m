Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 048B227FBAC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 10:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731459AbgJAIkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 04:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgJAIky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 04:40:54 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 01 Oct 2020 01:40:54 PDT
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF228C0613D0;
        Thu,  1 Oct 2020 01:40:54 -0700 (PDT)
Received: from ip4d14bc8c.dynamic.kabel-deutschland.de ([77.20.188.140] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1kNu8z-0000mi-DT; Thu, 01 Oct 2020 10:40:53 +0200
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 15/26] docs: reporting-bugs: make readers test mainline, but leave a loophole
Date:   Thu,  1 Oct 2020 10:39:36 +0200
Message-Id: <e9166fcbb777e9b7685745e572ab7c7322596ec2.1601541165.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601541165.git.linux@leemhuis.info>
References: <cover.1601541165.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=yes
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1601541654;eea1c51e;
X-HE-SMSGID: 1kNu8z-0000mi-DT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the document described all preparatory steps tell users to
install the latest kernel. Try pretty hard to motivate them installing a
mainline kernel, as that is best for reporting issues. Mention the
latest stable kernel as an acceptable alternative, but discourage this
option. Point out that longterm kernels are unsuitable.

While at it, provide a few hints how to obtain a fresh kernel. Also
explain how to find out what the latest version actually is. And mention
why it might be a good idea to wait till the end of the merge window
when reporting issues.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---

= RFC =

Am I asking for too much from users by telling them to test mainline? But most
will likely have an outdated and heavily patched vendor kernel anyway, so they
have to install a vanilla kernel if they want to report something upstream;
that's why I thought "well, then let's go all in and make them test mainline.
---
 Documentation/admin-guide/reporting-bugs.rst | 88 ++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/Documentation/admin-guide/reporting-bugs.rst b/Documentation/admin-guide/reporting-bugs.rst
index f99d92a05bca..dee6d65aa95c 100644
--- a/Documentation/admin-guide/reporting-bugs.rst
+++ b/Documentation/admin-guide/reporting-bugs.rst
@@ -643,6 +643,94 @@ hardware apart from a kernel issue that rarely happens and thus is hard to
 reproduce.
 
 
+Install the latest mainline kernel
+----------------------------------
+
+    *Install the latest Linux mainline kernel: that's where all issue get fixed
+    first, because it's the version line the kernel developers mainly care
+    about. Testing and reporting with the latest Linux stable kernel can be
+    acceptable alternative in some situations, but is best avoided.*
+
+Reporting an issue to the Linux kernel developers they fixed a while ago is
+annoying for them and wasting their and your time. That's why it's in
+everybody's interest to check if the issue occurs with the latest version before
+reporting it.
+
+In the scope of the Linux kernel the term 'latest' means: a kernel version
+recently created from the main line of development, as this 'mainline' tree is
+where every fix gets applied to first; only later they are allowed to get
+backported to older, still support version lines called 'stable' and 'longterm'
+kernels. That's why it's a prerequisite to check mainline even if just want to
+see the issue fixed in one of those. Another reasons: sometimes fixes for an
+issue are only applied to mainline, as they are too risky to get backported
+into older version lines where they thus remain unfixed.
+
+It's thus in your and everybody's else interest to reproduce the issue with a
+fresh mainline kernel before reporting it. Reproducing it with the latest Linux
+'stable' kernel can be acceptable alternative, if you can't test mainline for
+some reason; this is not ideal, but better than not reporting the issue at all.
+
+Avoid testing with one of the longterm kernels (sometimes called "LTS kernels"),
+they are too distant from current development; the same is also true for
+mainline or stable kernels that are not very recent, as there is a new release
+of those nearly every week.
+
+Ways to obtains a fresh vanilla kernel
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+One way to get the latest mainline or stable kernel in a vanilla fashion is to
+download the Linux sources from `kernel.org <https://kernel.org/>`_ and build a
+kernel image and modules from them yourself. How to do that is not described
+here, as many texts on the internet explain the necessary steps already. If you
+are new to it, consider following one of those how-to's that suggest to use
+``make localmodconfig``, as that tries to pick up the configuration of your
+current kernel and then tries to adjust it somewhat for your system. That does
+not make the resulting kernel any better, but makes it compile a lot faster.
+
+There might be a way around building your own kernel, if you are in a luck: for
+popular Linux distribution you'll find repositories on the net that offer
+packages with of the latest mainline or stable Linux vanilla kernels for easy
+installation. It's totally okay to use packages with these pre-compiled kernels,
+just make sure from the repository's documentation they are supposed to be
+'vanilla', for reasons outlined in the first step of this process. And be aware
+that you might need to build your own kernel later anyway when it comes to
+testing fixes, as described later in this document.
+
+Finding the latest Linux version
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+To check what the latest mainline release actually is, go to `kernel.org
+<https://kernel.org/>`_. Ignore the big yellow button that says 'Latest
+release': that points to the latest stable release, which you normally don't
+want to use.
+
+Instead, look a little lower for a table for a line with the description
+'mainline', which you'll find at the top of that table. Most of the time
+'mainline' will point to a pre-release with a version number like '5.8-rc2'. In
+that case that's the version you want to test. Do not let that 'rc' scare you,
+these 'development kernels' are pretty reliable — and you have a backup, like we
+told you above, don't you?
+
+In about two out of every nine to ten weeks, 'mainline' might point you to a
+proper release with a version number like '5.7'. If that happens consider
+suspending the reporting process for a while, as the Linux development cycle is
+currently in its two-week long 'merge window'. That's where the bulk of the
+changes (and all intrusive ones) get merged for the next release, before its
+first pre-release is published (5.8-rc1). Kernel developers are often quite
+busy during this time period and might have no spare time to deal with issue
+reports. It's also quite possible that one of the many changes applied during
+the merge window fixes the issue you face; that's why you soon would have to
+retest with a newer kernel version anyway, as outlined below in the section
+'Duties after the report when out'. Therefor it's often wise to wait for the
+first pre-release before proceeding with this step, unless you're dealing with
+one of those 'issues of high priority' or one that can't wait for a good reason.
+
+Feel free to ignore the past three paragraphs if you are a developer, Linux
+kernel expert, or brave; instead simply get the latest Linux kernel sources
+using ``git`` straight from the `official development repository on kernel.org
+<https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/>`_.
+
+
 .. ############################################################################
 .. Temporary marker added while this document is rewritten. Sections above
 .. are new and dual-licensed under GPLv2+ and CC-BY 4.0, those below are old.
-- 
2.26.2

