Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0357328D584
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 22:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbgJMUnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 16:43:13 -0400
Received: from mxout04.lancloud.ru ([89.108.124.63]:47504 "EHLO
        mxout04.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727215AbgJMUnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 16:43:12 -0400
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru ADCE320275ED
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: [PATCH 1/2] module: merge repetitive strings in module_sig_check()
From:   Sergey Shtylyov <s.shtylyov@omprussia.ru>
To:     Jessica Yu <jeyu@kernel.org>, <linux-kernel@vger.kernel.org>
References: <789a4e5c-8efd-bb1c-86e2-eed8b2b7b0af@omprussia.ru>
Organization: Open Mobile Platform, LLC
Message-ID: <4c4a3fa0-3eee-6cca-947c-9d01e3eb2a8a@omprussia.ru>
Date:   Tue, 13 Oct 2020 23:34:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <789a4e5c-8efd-bb1c-86e2-eed8b2b7b0af@omprussia.ru>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [213.87.131.195]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1908.lancloud.ru (fd00:f066::208)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'reason' variable in module_sig_check() points to 3 strings across
the *switch* statement, all needlessly starting with the same text.  Let's
put as much of the starting text as we can into the pr_notice() call (this
includes some rewording of the 1st message) -- it saves 37 bytes of object
code (x86 gcc 10.2.1).

Signed-off-by: Sergey Shtylyov <s.shtylyov@omprussia.ru>

---
 kernel/module.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

Index: linux/kernel/module.c
===================================================================
--- linux.orig/kernel/module.c
+++ linux/kernel/module.c
@@ -2906,16 +2906,17 @@ static int module_sig_check(struct load_
 		 * enforcing, certain errors are non-fatal.
 		 */
 	case -ENODATA:
-		reason = "Loading of unsigned module";
+		reason = "no signature";
 		goto decide;
 	case -ENOPKG:
-		reason = "Loading of module with unsupported crypto";
+		reason = "unsupported crypto";
 		goto decide;
 	case -ENOKEY:
-		reason = "Loading of module with unavailable key";
+		reason = "unavailable key";
 	decide:
 		if (is_module_sig_enforced()) {
-			pr_notice("%s: %s is rejected\n", info->name, reason);
+			pr_notice("%s: loading of module with %s is rejected\n",
+				  info->name, reason);
 			return -EKEYREJECTED;
 		}
 
