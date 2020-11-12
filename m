Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4FFA2B0BE0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 18:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgKLR7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 12:59:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbgKLR7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 12:59:18 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A508AC0613D1;
        Thu, 12 Nov 2020 09:59:18 -0800 (PST)
Received: from ip4d145e30.dynamic.kabel-deutschland.de ([77.20.94.48] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1kdGsP-00070q-Bl; Thu, 12 Nov 2020 18:59:17 +0100
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 16/26] docs: reporting-bugs: let users check taint status again
Date:   Thu, 12 Nov 2020 18:58:53 +0100
Message-Id: <c3db53b65589644eff3b6eb961d289edfdb4a7a1.1605203187.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1605203187.git.linux@leemhuis.info>
References: <cover.1605203187.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1605203958;24c9afe5;
X-HE-SMSGID: 1kdGsP-00070q-Bl
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel just installed in the previous step might taint itself for
reasons unrelated to the issue the reader used when he started this
process. Make sure the reader catches this early, as this is the area
where it really matters. The former check was just ensuring the reader
notices early if his kernel is tainted, e.g., before he does more
complicated and dangerous things in this process.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 Documentation/admin-guide/reporting-bugs.rst | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/admin-guide/reporting-bugs.rst b/Documentation/admin-guide/reporting-bugs.rst
index 506292ab9bb6..e9fe40a96b87 100644
--- a/Documentation/admin-guide/reporting-bugs.rst
+++ b/Documentation/admin-guide/reporting-bugs.rst
@@ -789,6 +789,20 @@ somewhat for your system. That does not make the resulting kernel any better,
 but quicker to compile.
 
 
+Check 'taint' flag
+------------------
+
+    *Ensure the kernel you just installed does not 'taint' itself when
+    running.*
+
+As outlined above in more detail already: the kernel sets a 'taint' flag when
+something happens that can lead to follow-up errors that look totally
+unrelated. That's why you need to check if the kernel you just installed does
+not set this flag. And if it does, you in almost all the cases needs to
+eliminate the reason for it before you reporting issues that occur with it. See
+the section above for details how to do that.
+
+
 .. ############################################################################
 .. Temporary marker added while this document is rewritten. Sections above
 .. are new and dual-licensed under GPLv2+ and CC-BY 4.0, those below are old.
-- 
2.28.0

