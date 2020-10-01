Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 993EF27FC14
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 10:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731919AbgJAI45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 04:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731783AbgJAI4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 04:56:39 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE57C0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 01:56:38 -0700 (PDT)
Received: from ip4d14bc8c.dynamic.kabel-deutschland.de ([77.20.188.140] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1kNu8I-0000Ew-CG; Thu, 01 Oct 2020 10:40:10 +0200
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 06/26] docs: reporting-bugs: point out we only care about fresh vanilla kernels
Date:   Thu,  1 Oct 2020 10:39:27 +0200
Message-Id: <d22f8af9bca4378622e74452d650e7e881082a3a.1601541165.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601541165.git.linux@leemhuis.info>
References: <cover.1601541165.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=yes
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1601542598;32d12a23;
X-HE-SMSGID: 1kNu8I-0000Ew-CG
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

More explicitly than the old text point out the Linux kernel developers
don't care about vendor kernels. That is obvious to Linux kernel
developers, but something a lot of users fail to gasp, as quite a few
(maybe a lot?) reports on bugzilla.kernel.org show; most of them get
silently ignored, which is frustrating for people that invested time in
preparing and writing the report. Try to minimize that and explain it
properly, as some users will think "why do kernel devs makes things so
complicated for me and force me to install a fresh vanilla kernel".

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---

= RFC =

Should we accept reports for issues with kernel images that are pretty close to
vanilla? But when are they close enough and how to put that line in words? Maybe
something like this (any major distributions missing?):

```Note: Some Linux kernel developers accept reports from vendor kernels that
are known to be close to upstream. That for example is often the case for the
kernels that Debian GNU/Linux Sid or Fedora Rawhide ship, which are close to
mainline. Additionally, Arch Linux, other Fedora releases, and openSUSE
Tumbleweed often use recent stable kernels that are pretty close to upstream,
too. So a report with one of these might be acceptable. But it depends heavily
on the issue in question and some developers nevertheless will ignore report
from these kernels, that's why installing the latest mainline vanilla kernel is
the safe bet.```
---
 Documentation/admin-guide/reporting-bugs.rst | 33 ++++++++++++++++----
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/reporting-bugs.rst b/Documentation/admin-guide/reporting-bugs.rst
index be1bce8d43aa..434e1a890dfe 100644
--- a/Documentation/admin-guide/reporting-bugs.rst
+++ b/Documentation/admin-guide/reporting-bugs.rst
@@ -245,6 +245,33 @@ With that of the table, find below the details on how to properly report issues
 to the Linux kernel developers.
 
 
+Make sure you're using the upstream Linux kernel
+------------------------------------------------
+
+   *Stop reading this document and report the problem to your vendor instead,
+   unless you are running a vanilla mainline kernel already or are willing to
+   install it.*
+
+Like most programmers, Linux kernel developers don't like to spend time dealing
+with reports for issues that don't even happen with the source code they
+maintain: it's just a waste everybody's time, yours included. That's why you
+later will have to test your issue with the latest 'vanilla kernel': a kernel
+that was build using the Linux sources taken straight from
+`kernel.org <https://kernel.org/>`_ and not modified or enhanced in any way.
+
+Almost all kernels used in devices (Computers, Laptops, Smartphones, Routers,
+…) and most kernels shipped by Linux distributors are ancient from the point of
+kernel development and heavily modified. They thus do not qualify for reporting
+an issue to the Linux kernel developers: the issue you face with such a kernel
+might be fixed already or caused by the changes or additions, even if they look
+small or totally unrelated. That's why issues with such kernels need to be
+reported to the vendor that distributed it. Its developers should look into the
+report and, in case it turns out to be an upstream issue, fix it directly
+upstream or report it there. If the company or project is uncooperative or if
+you want to circumvent it consider installing the mainline kernel yourself; just
+make sure it's the latest one (see below).
+
+
 .. ############################################################################
 .. Temporary marker added while this document is rewritten. Sections above
 .. are new and dual-licensed under GPLv2+ and CC-BY 4.0, those below are old.
@@ -262,12 +289,6 @@ Please see https://www.kernel.org/ for a list of supported kernels.  Any
 kernel marked with [EOL] is "end of life" and will not have any fixes
 backported to it.
 
-If you've found a bug on a kernel version that isn't listed on kernel.org,
-contact your Linux distribution or embedded vendor for support.
-Alternatively, you can attempt to run one of the supported stable or -rc
-kernels, and see if you can reproduce the bug on that.  It's preferable
-to reproduce the bug on the latest -rc kernel.
-
 
 How to report Linux kernel bugs
 ===============================
-- 
2.26.2

