Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18A6F2A1A7F
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 21:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbgJaUKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 16:10:31 -0400
Received: from mxout03.lancloud.ru ([89.108.73.187]:52846 "EHLO
        mxout03.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728451AbgJaUKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 16:10:31 -0400
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru 42D12206646C
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: [PATCH v2 3/3] module: only handle errors with the *switch* statement
 in module_sig_check()
From:   Sergey Shtylyov <s.shtylyov@omprussia.ru>
To:     Jessica Yu <jeyu@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Joe Perches <joe@perches.com>
References: <22e48a3d-06ee-5b8e-6e56-3694871a7c2f@omprussia.ru>
Organization: Open Mobile Platform, LLC
Message-ID: <afd5f3cc-741c-f03f-b307-3651883adef4@omprussia.ru>
Date:   Sat, 31 Oct 2020 23:10:28 +0300
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

Let's handle the successful call of mod_verify_sig() right after that call,
making the *switch* statement only handle the real errors, and then move
the comment from the first *case* before *switch* itself and the comment
before *default* after it.  Fix the comment style, add article/comma/dash,
spell out "nomem" as "lack of memory" in these comments, while at it...

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Sergey Shtylyov <s.shtylyov@omprussia.ru>

---
Changes in version 2:
- new patch.

 kernel/module.c |   26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

Index: linux/kernel/module.c
===================================================================
--- linux.orig/kernel/module.c
+++ linux/kernel/module.c
@@ -2895,17 +2895,18 @@ static int module_sig_check(struct load_
 		/* We truncate the module to discard the signature */
 		info->len -= markerlen;
 		err = mod_verify_sig(mod, info);
+		if (!err) {
+			info->sig_ok = true;
+			return 0;
+		}
 	}
 
+	/*
+	 * We don't permit modules to be loaded into the trusted kernels
+	 * without a valid signature on them, but if we're not enforcing,
+	 * certain errors are non-fatal.
+	 */
 	switch (err) {
-	case 0:
-		info->sig_ok = true;
-		return 0;
-
-		/* We don't permit modules to be loaded into trusted kernels
-		 * without a valid signature on them, but if we're not
-		 * enforcing, certain errors are non-fatal.
-		 */
 	case -ENODATA:
 		reason = "unsigned module";
 		break;
@@ -2916,11 +2917,12 @@ static int module_sig_check(struct load_
 		reason = "module with unavailable key";
 		break;
 
-		/* All other errors are fatal, including nomem, unparseable
-		 * signatures and signature check failures - even if signatures
-		 * aren't required.
-		 */
 	default:
+		/*
+		 * All other errors are fatal, including lack of memory,
+		 * unparseable signatures, and signature check failures --
+		 * even if signatures aren't required.
+		 */
 		return err;
 	}
 
