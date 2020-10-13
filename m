Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711CD28D585
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 22:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbgJMUnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 16:43:13 -0400
Received: from mxout04.lancloud.ru ([89.108.124.63]:47528 "EHLO
        mxout04.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbgJMUnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 16:43:12 -0400
X-Greylist: delayed 539 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Oct 2020 16:43:11 EDT
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru C99A920510BA
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: [PATCH 2/2] module: unindent comments in module_sig_check()
From:   Sergey Shtylyov <s.shtylyov@omprussia.ru>
To:     Jessica Yu <jeyu@kernel.org>, <linux-kernel@vger.kernel.org>
References: <789a4e5c-8efd-bb1c-86e2-eed8b2b7b0af@omprussia.ru>
Organization: Open Mobile Platform, LLC
Message-ID: <24fb12d3-aefb-a66e-524d-107bce8f8c68@omprussia.ru>
Date:   Tue, 13 Oct 2020 23:35:34 +0300
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

The way the comments in the *switch* statement in module_sig_check() are
indented, it may seem they refer to the statements above them, not below.
Align the comments with the *case* and *default* labels below them, fixing
the comment style and adding article/dash, while at it...

Signed-off-by: Sergey Shtylyov <s.shtylyov@omprussia.ru>

---
 kernel/module.c |   17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

Index: linux/kernel/module.c
===================================================================
--- linux.orig/kernel/module.c
+++ linux/kernel/module.c
@@ -2901,10 +2901,11 @@ static int module_sig_check(struct load_
 		info->sig_ok = true;
 		return 0;
 
-		/* We don't permit modules to be loaded into trusted kernels
-		 * without a valid signature on them, but if we're not
-		 * enforcing, certain errors are non-fatal.
-		 */
+	/*
+	 * We don't permit modules to be loaded into the trusted kernels
+	 * without a valid signature on them, but if we're not enforcing,
+	 * certain errors are non-fatal.
+	 */
 	case -ENODATA:
 		reason = "no signature";
 		goto decide;
@@ -2922,10 +2923,10 @@ static int module_sig_check(struct load_
 
 		return security_locked_down(LOCKDOWN_MODULE_SIGNATURE);
 
-		/* All other errors are fatal, including nomem, unparseable
-		 * signatures and signature check failures - even if signatures
-		 * aren't required.
-		 */
+	/*
+	 * All other errors are fatal, including nomem, unparseable signatures
+	 * and signature check failures -- even if signatures aren't required.
+	 */
 	default:
 		return err;
 	}


