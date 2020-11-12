Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A94B2B0BEA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 19:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgKLR7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 12:59:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgKLR7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 12:59:32 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A650C061A47;
        Thu, 12 Nov 2020 09:59:30 -0800 (PST)
Received: from ip4d145e30.dynamic.kabel-deutschland.de ([77.20.94.48] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1kdGsb-00076N-7Q; Thu, 12 Nov 2020 18:59:29 +0100
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 24/26] docs: reporting-bugs: explain why users might get neither reply nor fix
Date:   Thu, 12 Nov 2020 18:59:01 +0100
Message-Id: <155079162f54102450ccd1095a5fd3a815360e72.1605203187.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1605203187.git.linux@leemhuis.info>
References: <cover.1605203187.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=yes
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1605203970;46a1d46b;
X-HE-SMSGID: 1kdGsb-00076N-7Q
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not even getting a reply after one invested quite a bit of time with
preparing and writing a report can be quite devastating. But when it
comes to Linux, this can easily happen for good or bad reasons. Hence,
use this opportunity to explain why this might happen. Hopefully some
people will then be less disappointed if it happens to them.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 Documentation/admin-guide/reporting-bugs.rst | 57 ++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/Documentation/admin-guide/reporting-bugs.rst b/Documentation/admin-guide/reporting-bugs.rst
index ad9a5d896728..446c02e94c93 100644
--- a/Documentation/admin-guide/reporting-bugs.rst
+++ b/Documentation/admin-guide/reporting-bugs.rst
@@ -1467,6 +1467,63 @@ for the subsystem as well as the stable mailing list the :ref:`MAINTAINERS
 <maintainers>` file mention in the section "STABLE BRANCH".
 
 
+Why some issues won't get any reaction or remain unfixed after being reported
+=============================================================================
+
+When reporting a problem to the Linux developers, be aware only 'issues of high
+priority' (regressions, security issues, severe problems) are definitely going
+to get resolved. The maintainers or if all else fails Linus Torvalds himself
+will make sure of that. They and the other kernel developers will fix a lot of
+other issues as well. But be aware that sometimes they can't or won't help; and
+sometimes there isn't even anyone to send a report to.
+
+This is best explained with kernel developers that contribute to the Linux
+kernel in their spare time. Quite a few of the drivers in the kernel were
+written by such programmers, often because they simply wanted to make their
+hardware usable on their favorite operating system.
+
+These programmers most of the time will happily fix problems other people
+report. But nobody can force them to do, as they are contributing voluntarily.
+
+Then there are situations where such developers really want to fix an issue,
+but can't: sometimes they lack hardware programming documentation to do so.
+This often happens when the publicly available docs are superficial or the
+driver was written with the help of reverse engineering.
+
+Sooner or later spare time developers will also stop caring for the driver.
+Maybe their test hardware broke, got replaced by something more fancy, or is so
+old that it's something you don't find much outside of computer museums
+anymore. Sometimes developer stops caring for their code and Linux at all, as
+something different in their life became way more important. In some cases
+nobody is willing to take over the job as maintainer – and nobody can be forced
+to, as contributing to the Linux kernel is done on a voluntary basis. Abandoned
+drivers nevertheless remain in the kernel: they are still useful for people and
+removing would be a regression.
+
+The situation is not that different with developers that are paid for their
+work on the Linux kernel. Those contribute most changes these days. But their
+employers sooner or later also stop caring for their code or make its
+programmer focus on other things. Hardware vendors for example earn their money
+mainly by selling new hardware; quite a few of them hence are not investing
+much time and energy in maintaining a Linux kernel driver for something they
+stopped selling years ago. Enterprise Linux distributors often care for a
+longer time period, but in new versions often leave support for old and rare
+hardware aside to limit the scope. Often spare time contributors take over once
+a company orphans some code, but as mentioned above: sooner or later they will
+leave the code behind, too.
+
+Priorities are another reason why some issues are not fixed, as maintainers
+quite often are forced to set those, as time to work on Linux is limited.
+That's true for spare time or the time employers grant their developers to
+spend on maintenance work on the upstream kernel. Sometimes maintainers also
+get overwhelmed with reports, even if a driver is working nearly perfectly. To
+not get completely stuck, the programmer thus might have no other choice than
+to prioritize issue reports and reject some of them.
+
+But don't worry too much about all of this, a lot of drivers have active
+maintainers who are quite interested in fixing as many issues as possible.
+
+
 .. ############################################################################
 .. Temporary marker added while this document is rewritten. Sections above
 .. are new and dual-licensed under GPLv2+ and CC-BY 4.0, those below are old.
-- 
2.28.0

