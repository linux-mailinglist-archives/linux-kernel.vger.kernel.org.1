Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4D212A1A7E
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 21:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbgJaUJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 16:09:35 -0400
Received: from mxout03.lancloud.ru ([89.108.73.187]:52830 "EHLO
        mxout03.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728451AbgJaUJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 16:09:34 -0400
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru E0895206646C
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: [PATCH v2 2/3] module: avoid *goto*s in module_sig_check()
From:   Sergey Shtylyov <s.shtylyov@omprussia.ru>
To:     Jessica Yu <jeyu@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Joe Perches <joe@perches.com>
References: <22e48a3d-06ee-5b8e-6e56-3694871a7c2f@omprussia.ru>
Organization: Open Mobile Platform, LLC
Message-ID: <ea07f954-0cf2-a552-792e-d1b83f1a8fba@omprussia.ru>
Date:   Sat, 31 Oct 2020 23:09:31 +0300
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

Let's move the common handling of the non-fatal errors after the *switch*
statement -- this avoids *goto*s inside that *switch*...

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Sergey Shtylyov <s.shtylyov@omprussia.ru>

---
Changes in version 2:
- new patch.

 kernel/module.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

Index: linux/kernel/module.c
===================================================================
--- linux.orig/kernel/module.c
+++ linux/kernel/module.c
@@ -2908,20 +2908,13 @@ static int module_sig_check(struct load_
 		 */
 	case -ENODATA:
 		reason = "unsigned module";
-		goto decide;
+		break;
 	case -ENOPKG:
 		reason = "module with unsupported crypto";
-		goto decide;
+		break;
 	case -ENOKEY:
 		reason = "module with unavailable key";
-	decide:
-		if (is_module_sig_enforced()) {
-			pr_notice("%s: loading of %s is rejected\n",
-				  info->name, reason);
-			return -EKEYREJECTED;
-		}
-
-		return security_locked_down(LOCKDOWN_MODULE_SIGNATURE);
+		break;
 
 		/* All other errors are fatal, including nomem, unparseable
 		 * signatures and signature check failures - even if signatures
@@ -2930,6 +2923,13 @@ static int module_sig_check(struct load_
 	default:
 		return err;
 	}
+
+	if (is_module_sig_enforced()) {
+		pr_notice("%s: loading of %s is rejected\n", info->name, reason);
+		return -EKEYREJECTED;
+	}
+
+	return security_locked_down(LOCKDOWN_MODULE_SIGNATURE);
 }
 #else /* !CONFIG_MODULE_SIG */
 static int module_sig_check(struct load_info *info, int flags)
