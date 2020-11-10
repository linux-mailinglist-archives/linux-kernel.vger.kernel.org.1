Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD932AD901
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 15:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730909AbgKJOl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 09:41:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730059AbgKJOl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 09:41:26 -0500
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32258C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 06:41:26 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by xavier.telenet-ops.be with bizsmtp
        id qehP2300h4C55Sk01ehPY0; Tue, 10 Nov 2020 15:41:24 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kcUpn-001CQ5-EG; Tue, 10 Nov 2020 15:41:23 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kcUpm-00DkwU-Ng; Tue, 10 Nov 2020 15:41:22 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Jonathan Corbet <corbet@lwn.net>, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] docs: core-api/printk-formats.rst: Clarify formatting {cpu,node}mask
Date:   Tue, 10 Nov 2020 15:41:21 +0100
Message-Id: <20201110144121.3278667-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clarify how to pass the field width for bitmaps, and mention the helper
macros that are available to ease printing cpumask and nodemask.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/core-api/printk-formats.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index 6d26c5c6ac485cec..160e710d992f3a36 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -531,7 +531,9 @@ For printing bitmap and its derivatives such as cpumask and nodemask,
 %*pb outputs the bitmap with field width as the number of bits and %*pbl
 output the bitmap as range list with field width as the number of bits.
 
-Passed by reference.
+The field width is passed by value, the bitmap is passed by reference.
+Helper macros cpumask_pr_args() and nodemask_pr_args() are available to ease
+printing cpumask and nodemask.
 
 Flags bitfields such as page flags, gfp_flags
 ---------------------------------------------
-- 
2.25.1

