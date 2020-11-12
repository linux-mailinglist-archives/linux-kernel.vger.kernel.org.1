Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 411AB2B0C0D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 19:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgKLSBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 13:01:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbgKLR7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 12:59:18 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AEB9C0617A6;
        Thu, 12 Nov 2020 09:59:18 -0800 (PST)
Received: from ip4d145e30.dynamic.kabel-deutschland.de ([77.20.94.48] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1kdGsP-00070q-5e; Thu, 12 Nov 2020 18:59:17 +0100
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 15/26] docs: reporting-bugs: make readers test a fresh kernel
Date:   Thu, 12 Nov 2020 18:58:52 +0100
Message-Id: <00f0de693974e5c66a4ac63de8b265640f54ddb4.1605203187.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1605203187.git.linux@leemhuis.info>
References: <cover.1605203187.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=yes
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1605203958;24c9afe5;
X-HE-SMSGID: 1kdGsP-00070q-5e
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the document described all preparatory steps tell users to
install a really fresh kernel. The text tries pretty hard motivating
them to install a mainline kernel, as that is best for reporting issues.
Mention the latest stable kernel as an acceptable alternative, but
discourage this option. Point out that longterm kernels are unsuitable.

While at it, provide a few hints how to obtain a fresh kernel. Also
explain how to find out what the latest version actually is. And mention
why it might be a good idea to wait till the end of the merge window
when reporting issues.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---

v2: reshuffled and rewritten to make this section more straight forward

= RFC =

Am I asking for too much from users by telling them to test mainline?
But most will likely have an outdated and heavily patched vendor kernel
anyway, so they have to install a vanilla kernel if they want to report
something upstream; that's why I thought "well, then let's go all in and
make them test mainline.
---
 Documentation/admin-guide/reporting-bugs.rst | 103 +++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/Documentation/admin-guide/reporting-bugs.rst b/Documentation/admin-guide/reporting-bugs.rst
index 981ddd5a0646..506292ab9bb6 100644
--- a/Documentation/admin-guide/reporting-bugs.rst
+++ b/Documentation/admin-guide/reporting-bugs.rst
@@ -686,6 +686,109 @@ due to faulty hardware apart from a kernel issue that rarely happens and thus
 is hard to reproduce.
 
 
+Install a fresh kernel for testing
+----------------------------------
+
+    *Install the latest Linux mainline kernel: that's where all issues get
+    fixed first, because it's the version line the kernel developers mainly
+    care about. Testing and reporting with the latest Linux stable kernel can
+    be an acceptable alternative in some situations, for example during the
+    merge window; but during that period you might want to suspend your efforts
+    till its end anyway.*
+
+Reporting an issue to the Linux kernel developers they fixed weeks or months
+ago is annoying for them and wasting their and your time. That's why it's in
+everybody's interest to check if the issue occurs with the latest codebase
+before reporting it.
+
+In the scope of the Linux kernel the term 'latest' means: a kernel version
+recently created from the main line of development, as this 'mainline' tree is
+where developers first apply fixes; only after that are they are allowed to get
+backported to older, still supported version lines called 'stable' and
+'longterm' kernels. That's why you should check a recent mainline kernel, even
+if you deal with an issue you only want to see fixed in an older version line.
+Another reason: some fixes are only applied to mainline or recent version
+lines, as it's too hard or risky to backport them to older versions. If that
+the case, reporting the issue again is unlikely to change anything.
+
+Longterm kernels (sometimes called "LTS kernels") are therefore unsuitable for
+testing; they simply are too distant from current development. Even the latest
+Linux 'stable' kernel is a significant bit behind and thus better avoided. At
+least most of the time, as sometimes a stable kernel can the best choice; but
+in those situations you might want to wait a few days anyway:
+
+Choosing between mainline, stable and waiting
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Head over to `kernel.org <https://kernel.org/>`_ to decide which version to
+use. Ignore the big yellow button that says 'Latest release' and look a little
+lower for a table. At its top you'll see a line starting with 'mainline', which
+most of the time will point to a pre-release with a version number like
+'5.8-rc2'. If that's the case, you'll want to use this mainline kernel for
+testing. Do not let that 'rc' scare you, these 'development kernels' are pretty
+reliable — and you made a backup, as you were instructed above, didn't you?
+
+In about two out of every nine to ten weeks, 'mainline' might point you to a
+proper release with a version number like '5.7'. If that happens, consider
+suspending the reporting process until the first pre-release of the next
+version (5.8-rc1) shows up on kernel.org. That's because the Linux development
+cycle then is in its two-week long 'merge window'. The bulk of the changes and
+all intrusive ones get merged for the next release during this time. It's a bit
+more risky to use mainline during this period. Kernel developers are also often
+quite busy then and might have no spare time to deal with issue reports. It's
+also quite possible that one of the many changes applied during the merge
+window fixes the issue you face; that's why you soon would have to retest with
+a newer kernel version anyway, as outlined below in the section 'Duties after
+the report went out'.
+
+That's why it might make sense to wait till the merge window is over. But don't
+to that if you're dealing with something that shouldn't wait. In that case
+consider obtaining the latest mainline kernel via git (see below) or use the
+latest stable version offered on kernel.org. Using that is also acceptable in
+case mainline for some reason does currently not work for you. An in general:
+using it for reproducing the issue is also better than not reporting it issue
+at all.
+
+How to obtain a fresh Linux kernel
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+You can use pre-built or self-compiled kernel for testing; if you choose the
+latter approach, you can either obtain the source code using git or download it
+as tar archive.
+
+Using a pre-compiled kernel for testing is often the quickest, easiest, and
+safest way – especially is you are unfamiliar with the Linux kernel. But it
+needs to be a vanilla kernel, which can be hard to come buy. You are in luck if
+you are using a popular Linux distribution: for quite a few of them you'll find
+repositories on the net that contain packages with the latest mainline or
+stable kernels in vanilla fashion. It's totally okay to use these, just make
+sure from the repository's documentation they are really vanilla. And ensure
+the packages contain the latest versions as offered on kernel.org; they are
+likely unsuitable if the package is older than a week, as new mainline and
+stable kernels typically get released at least once a week. And be aware that
+you might need to get build your own kernel later anyway when it comes to
+helping test fixes, as described later in this document.
+
+Developers and experienced Linux users familiar with git are often best served
+by obtaining the latest Linux kernel sources straight from the `official
+development repository on kernel.org
+<https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/>`_.
+Those are likely a bit ahead of the latest mainline pre-release. Don't worry
+about it: they are as reliable as a proper pre-release, unless the kernel's
+development cycle is currently in the middle of a merge window. But even then
+they are quite reliable.
+
+People unfamiliar with git are often best served by downloading the sources as
+tarball from `kernel.org <https://kernel.org/>`_.
+
+How to actually build a kernel isnot described here, as many websites explain
+the necessary steps already. If you are new to it, consider following one of
+those how-to's that suggest to use ``make localmodconfig``, as that tries to
+pick up the configuration of your current kernel and then tries to adjust it
+somewhat for your system. That does not make the resulting kernel any better,
+but quicker to compile.
+
+
 .. ############################################################################
 .. Temporary marker added while this document is rewritten. Sections above
 .. are new and dual-licensed under GPLv2+ and CC-BY 4.0, those below are old.
-- 
2.28.0

