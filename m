Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EED72B0C1F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 19:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbgKLSBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 13:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbgKLR7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 12:59:07 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8418C0613D4;
        Thu, 12 Nov 2020 09:59:07 -0800 (PST)
Received: from ip4d145e30.dynamic.kabel-deutschland.de ([77.20.94.48] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1kdGsD-0006ue-03; Thu, 12 Nov 2020 18:59:05 +0100
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 06/26] docs: reporting-bugs: point out we only care about fresh vanilla kernels
Date:   Thu, 12 Nov 2020 18:58:43 +0100
Message-Id: <c5a8c2126499ae6093cb25dff7b78b83764a1554.1605203187.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1605203187.git.linux@leemhuis.info>
References: <cover.1605203187.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=yes
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1605203947;764f585d;
X-HE-SMSGID: 1kdGsD-0006ue-03
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

More explicitly than the old text point out the Linux kernel developers
don't care about vendor kernels. That is obvious to Linux kernel
developers, but something a lot of users fail to gasp, as quite a few (a
lot?) reports on bugzilla.kernel.org show; most of them get silently
ignored, which is frustrating for people that invested time in preparing
and writing the report. This should help to reduce that. It also
explains the reasons, as some users otherwise might think "why do kernel
devs makes things so complicated for me".

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---

= RFC =

Should we accept reports for issues with kernel images that are pretty
close to vanilla? But when are they close enough and how to put that
line in words? Maybe something like this (any major distributions
missing?):

```Note: Some Linux kernel developers accept reports from vendor kernels
that are known to be close to upstream. That for example is often the
case for the kernels that Debian GNU/Linux Sid or Fedora Rawhide ship,
which are close to mainline. Additionally, Arch Linux, other Fedora
releases, and openSUSE Tumbleweed often use recent stable kernels that
are pretty close to upstream, too. So a report with one of these might
be acceptable. But it depends heavily on the individual issue and the
involved developers, as some expect tests with a frehs vanilla mainline
kernel. That's why installing one is the safe bet.```
---
 Documentation/admin-guide/reporting-bugs.rst | 35 ++++++++++++++++----
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/reporting-bugs.rst b/Documentation/admin-guide/reporting-bugs.rst
index 8993b4ccb0f0..9122889509de 100644
--- a/Documentation/admin-guide/reporting-bugs.rst
+++ b/Documentation/admin-guide/reporting-bugs.rst
@@ -251,6 +251,35 @@ With that off the table, find below the details on how to properly report
 issues to the Linux kernel developers.
 
 
+Make sure you're using the upstream Linux kernel
+------------------------------------------------
+
+   *Stop reading this document and report the problem to your vendor instead,
+   unless you are running the latest mainline kernel already or are willing to
+   install it. This kernel must not be modified or enhanced in any way, and
+   thus be considered 'vanilla'.*
+
+Like most programmers, Linux kernel developers don't like to spend time dealing
+with reports for issues that don't even happen with the source code they
+maintain: it's just a waste everybody's time, yours included. That's why you
+later will have to test your issue with the latest 'vanilla' kernel: a kernel
+that was build using the Linux sources taken straight from `kernel.org
+<https://kernel.org/>`_ and not modified or enhanced in any way.
+
+Almost all kernels used in devices (Computers, Laptops, Smartphones, Routers,
+…) and most kernels shipped by Linux distributors are ancient from the point of
+kernel development and heavily modified. They thus do not qualify for reporting
+an issue to the Linux kernel developers: the issue you face with such a kernel
+might be fixed already or caused by the changes or additions, even if they look
+small or totally unrelated. That's why issues with such kernels need to be
+reported to the vendor that distributed it. Its developers should look into the
+report and, in case it turns out to be an upstream issue, fix it directly
+upstream or report it there. In practice that sometimes does not work out. If
+that the case, you might want to circumvent the vendor by installing the latest
+mainline kernel yourself and reporting the issue as outlined in this document;
+just make sure to use really fresh kernel (see below).
+
+
 .. ############################################################################
 .. Temporary marker added while this document is rewritten. Sections above
 .. are new and dual-licensed under GPLv2+ and CC-BY 4.0, those below are old.
@@ -268,12 +297,6 @@ Please see https://www.kernel.org/ for a list of supported kernels.  Any
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
2.28.0

