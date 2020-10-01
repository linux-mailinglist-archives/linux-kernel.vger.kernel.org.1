Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6893127FBAE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 10:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731689AbgJAIlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 04:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731671AbgJAIlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 04:41:01 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45CEC0613E2;
        Thu,  1 Oct 2020 01:41:00 -0700 (PDT)
Received: from ip4d14bc8c.dynamic.kabel-deutschland.de ([77.20.188.140] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1kNu95-0000mi-GO; Thu, 01 Oct 2020 10:40:59 +0200
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 19/26] docs: reporting-bugs: decode failure messages [need help]
Date:   Thu,  1 Oct 2020 10:39:40 +0200
Message-Id: <fc63c021e58106559717fe1ecbbd24163e1c152d.1601541165.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601541165.git.linux@leemhuis.info>
References: <cover.1601541165.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1601541660;7dc8d30b;
X-HE-SMSGID: 1kNu95-0000mi-GO
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This part is quite similar to the old text and just a placeholder for
now. It and the referenced document afaics need to be revisited, as they
seem outdated to me. But I'm not really familiar with the current state
of things in that area and thus didn't feel qualified to write down
anything better quickly.

So consider this a request for help for those that know this area. Could
you maybe write something that would fit in here? Or outline the current
situation roughly in a reply, as that will make it easier for me or
others to write something? It should answer questions like "when is this
actually needed", "what .config options to ideally set to make this step
easy or unnecessary?"

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 Documentation/admin-guide/reporting-bugs.rst | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/reporting-bugs.rst b/Documentation/admin-guide/reporting-bugs.rst
index c9a3491bf4db..e1219e56979f 100644
--- a/Documentation/admin-guide/reporting-bugs.rst
+++ b/Documentation/admin-guide/reporting-bugs.rst
@@ -780,6 +780,18 @@ issue you face. Use this knowledge and search again for existing reports
 instead you can join.
 
 
+Decode failure messages
+-----------------------
+
+    *If the failure includes a stack dump, like an Oops does, consider decoding
+    it to find the offending line of code.*
+
+When the kernel detects an error, it will print a stack dump that allows to
+identify the exact line of code where the issue happens. But that information
+sometimes needs to get decoded to be readable, which is explained in
+admin-guide/bug-hunting.rst.
+
+
 .. ############################################################################
 .. Temporary marker added while this document is rewritten. Sections above
 .. are new and dual-licensed under GPLv2+ and CC-BY 4.0, those below are old.
@@ -811,9 +823,7 @@ step-by-step instructions for how a user can trigger the bug.
 
 If the failure includes an "OOPS:", take a picture of the screen, capture
 a netconsole trace, or type the message from your screen into the bug
-report.  Please read "Documentation/admin-guide/bug-hunting.rst" before posting your
-bug report. This explains what you should do with the "Oops" information
-to make it useful to the recipient.
+report.
 
 This is a suggested format for a bug report sent via email or bugzilla.
 Having a standardized bug report form makes it easier for you not to
-- 
2.26.2

