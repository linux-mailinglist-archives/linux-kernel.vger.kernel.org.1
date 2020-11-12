Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0814A2B0C20
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 19:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgKLSB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 13:01:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbgKLR7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 12:59:07 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF0FC0617A7;
        Thu, 12 Nov 2020 09:59:07 -0800 (PST)
Received: from ip4d145e30.dynamic.kabel-deutschland.de ([77.20.94.48] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1kdGsD-0006ue-68; Thu, 12 Nov 2020 18:59:05 +0100
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 07/26] docs: reporting-bugs: let users classify their issue
Date:   Thu, 12 Nov 2020 18:58:44 +0100
Message-Id: <f2cf323b319067fbfd46f4d1f3b600a63f567a65.1605203187.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1605203187.git.linux@leemhuis.info>
References: <cover.1605203187.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1605203947;764f585d;
X-HE-SMSGID: 1kdGsD-0006ue-68
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Explicitly outline that some issues are more important than others and
thus need to be handled differently in some steps that are about to
follow. This makes things explicit and easy to find if you need to look
up what issues actually qualify as "regression" or a "severe problem".

The alternative would have been: explain each of the three types in the
place where it requires special handling for the first time. But that
makes it quite easy to miss and harder to find when you need to look it
up.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 Documentation/admin-guide/reporting-bugs.rst | 39 ++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/admin-guide/reporting-bugs.rst b/Documentation/admin-guide/reporting-bugs.rst
index 9122889509de..fdd79d99c18f 100644
--- a/Documentation/admin-guide/reporting-bugs.rst
+++ b/Documentation/admin-guide/reporting-bugs.rst
@@ -280,6 +280,45 @@ mainline kernel yourself and reporting the issue as outlined in this document;
 just make sure to use really fresh kernel (see below).
 
 
+Issue of high priority?
+-----------------------
+
+    *See if the issue you are dealing with qualifies as regression, security
+    issue, or a really severe problem: those are 'issues of high priority' that
+    need special handling in some steps that are about to follow.*
+
+Linus Torvalds and the leading Linux kernel developers want to see some issues
+fixed as soon as possible, hence there are 'issues of high priority' that get
+handled slightly differently in the reporting process. Three type of cases
+qualify: regressions, security issues, and really severe problems.
+
+You deal with a 'regression' if something that worked with an older version of
+the Linux kernel does not work with a newer one or somehow works worse with it.
+It thus is a regression when a WiFi driver that did a fine job with Linux 5.7
+somehow misbehaves with 5.8 or doesn't work at all. It's also a regression if
+an application shows erratic behavior with a newer kernel, which might happen
+due to incompatible changes in the interface between the kernel and the
+userland (like procfs and sysfs). Significantly reduced performance or
+increased power consumption also qualify as regression. But keep in mind: the
+new kernel needs to be built with a configuration that is similar to the one
+from the old kernel (see below how to achieve that). That's because the kernel
+developers sometimes can not avoid incompatibilities when implementing new
+features; but to avoid regressions such features have to be enabled explicitly
+during build time configuration.
+
+What qualifies as security issue is left to your judgment. Consider reading
+:ref:`Documentation/admin-guide/security-bugs.rst <securitybugs>` before
+proceeding.
+
+An issue is a 'really severe problem' when something totally unacceptably bad
+happens. That's for example the case when a Linux kernel corrupts the data it's
+handling or damages hardware it's running on. You're also dealing with a severe
+issue when the kernel suddenly stops working with an error message ('kernel
+panic') or without any farewell note at all. Note: do not confuse a 'panic' (a
+fatal error where the kernel stop itself) with a 'Oops' (a recoverable error),
+as the kernel remains running after the latter.
+
+
 .. ############################################################################
 .. Temporary marker added while this document is rewritten. Sections above
 .. are new and dual-licensed under GPLv2+ and CC-BY 4.0, those below are old.
-- 
2.28.0

