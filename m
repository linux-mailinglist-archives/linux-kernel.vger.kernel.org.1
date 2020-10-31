Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE43C2A1A77
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 21:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728586AbgJaUGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 16:06:48 -0400
Received: from mxout04.lancloud.ru ([89.108.124.63]:46030 "EHLO
        mxout04.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728533AbgJaUGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 16:06:48 -0400
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru 29108204FB80
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: [PATCH v2 1/3] module: merge repetitive strings in module_sig_check()
From:   Sergey Shtylyov <s.shtylyov@omprussia.ru>
To:     Jessica Yu <jeyu@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Joe Perches <joe@perches.com>
References: <22e48a3d-06ee-5b8e-6e56-3694871a7c2f@omprussia.ru>
Organization: Open Mobile Platform, LLC
Message-ID: <e8991b3e-9360-6b35-250f-c2e98850660f@omprussia.ru>
Date:   Sat, 31 Oct 2020 23:06:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <22e48a3d-06ee-5b8e-6e56-3694871a7c2f@omprussia.ru>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [213.87.129.247]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1908.lancloud.ru (fd00:f066::208)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'reason' variable in module_sig_check() points to 3 strings across
the *switch* statement, all needlessly starting with the same text.
Let's put the starting text into the pr_notice() call -- it saves 21
bytes of the object code (x86 gcc 10.2.1).

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Sergey Shtylyov <s.shtylyov@omprussia.ru>

---
Changes in version 2:
- put less starting text into the pr_notice() call;
- updated the patch description accordingly, added the "Suggested-by:" tag.

 kernel/module.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

Index: linux/kernel/module.c
===================================================================
--- linux.orig/kernel/module.c
+++ linux/kernel/module.c
@@ -2907,16 +2907,17 @@ static int module_sig_check(struct load_
 		 * enforcing, certain errors are non-fatal.
 		 */
 	case -ENODATA:
-		reason = "Loading of unsigned module";
+		reason = "unsigned module";
 		goto decide;
 	case -ENOPKG:
-		reason = "Loading of module with unsupported crypto";
+		reason = "module with unsupported crypto";
 		goto decide;
 	case -ENOKEY:
-		reason = "Loading of module with unavailable key";
+		reason = "module with unavailable key";
 	decide:
 		if (is_module_sig_enforced()) {
-			pr_notice("%s: %s is rejected\n", info->name, reason);
+			pr_notice("%s: loading of %s is rejected\n",
+				  info->name, reason);
 			return -EKEYREJECTED;
 		}
 
