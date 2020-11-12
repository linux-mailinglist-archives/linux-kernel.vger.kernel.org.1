Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 101CA2B0C11
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 19:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgKLSBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 13:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgKLR7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 12:59:17 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8695C0613D6;
        Thu, 12 Nov 2020 09:59:17 -0800 (PST)
Received: from ip4d145e30.dynamic.kabel-deutschland.de ([77.20.94.48] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1kdGsO-00070q-Bs; Thu, 12 Nov 2020 18:59:16 +0100
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 11/26] docs: reporting-bugs: remind people to back up their data
Date:   Thu, 12 Nov 2020 18:58:48 +0100
Message-Id: <846f5c1e4e309a749d5cc5075adfa3dca82f0394.1605203187.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1605203187.git.linux@leemhuis.info>
References: <cover.1605203187.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1605203957;fbc755ce;
X-HE-SMSGID: 1kdGsO-00070q-Bs
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a small reminder that users are best of preparing for emergencies.
Doesn't cost us much and might prevent data-loss for a few people, as
disabling DKMS, installing mainline and other tasks this guide suggest
can break the system if you're unlucky.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 Documentation/admin-guide/reporting-bugs.rst | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/admin-guide/reporting-bugs.rst b/Documentation/admin-guide/reporting-bugs.rst
index 455d67be0fd7..8633f0976b00 100644
--- a/Documentation/admin-guide/reporting-bugs.rst
+++ b/Documentation/admin-guide/reporting-bugs.rst
@@ -589,6 +589,19 @@ test a proposed fix. Jump to the section 'Duties after the report went out' for
 details on how to get properly involved.
 
 
+Prepare for emergencies
+-----------------------
+
+    *Create a fresh backup and put system repair and restore tools at hand.*
+
+Reminder, you are dealing with computers, which sometimes do unexpected things,
+especially if you fiddle with crucial parts like the kernel of its operating
+system. That's what you are about to do in this process. Thus, make sure to
+create a fresh backup; also ensure you have all tools at hand to repair or
+reinstall the operating system as well as everything you need to restore the
+backup.
+
+
 .. ############################################################################
 .. Temporary marker added while this document is rewritten. Sections above
 .. are new and dual-licensed under GPLv2+ and CC-BY 4.0, those below are old.
-- 
2.28.0

