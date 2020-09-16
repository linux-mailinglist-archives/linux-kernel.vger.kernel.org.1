Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5317326BA56
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 04:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbgIPCtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 22:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgIPCtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 22:49:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E389CC06174A;
        Tue, 15 Sep 2020 19:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Sv9Vl7JNADXrPEema1u8+9rY9RXo33Dj3P6UNr+t14k=; b=JYLx7GgOoYj35BYgnwiL04axCZ
        ufStCfdCdTSVXS8b5XyxXRZp/ZgBAVMPTygs4pihcjkj+5df9JRbrtguEl9UjyAaloWBR1WKSbYqs
        j0WL8N8o5N6C34XNnjvovYioDTrDMrMWhkxkV1Nzodtjx0s+Dvp4EuoDwDnpdac/IpB4jfST/dL4w
        vupiAu0A4m1HvicBswuoJaJBvnDVWMehiAZWLfHQSOwOSKQQFjQwscZfflILWGla1ff+IWgSXzwxv
        PiPphboOr0VZlOD64dnxpHYUaqCJrDULVflyPWrITMa4W1UwpFj9Utn+7jbqEmG6AX7mLF/cLn37g
        KMvVfDkg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kINVJ-0003n4-Sj; Wed, 16 Sep 2020 02:49:06 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Jessica Yu <jeyu@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] Documentation: kernel-parameters: clarify "module."
 parameters
Message-ID: <67d40b6d-c073-a3bf-cbb6-6cad941cceeb@infradead.org>
Date:   Tue, 15 Sep 2020 19:49:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

The command-line parameters "dyndbg" and "async_probe" are not
parameters for kernel/module.c but instead they are for the
module that is being loaded. Try to make that distinction in the
help text.

OTOH, "module.sig_enforce" is handled as a parameter of kernel/module.c
so "module." is correct for it.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/admin-guide/kernel-parameters.txt |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- lnx-59-rc5.orig/Documentation/admin-guide/kernel-parameters.txt
+++ lnx-59-rc5/Documentation/admin-guide/kernel-parameters.txt
@@ -1019,7 +1019,7 @@
 			what data is available or for reverse-engineering.
 
 	dyndbg[="val"]		[KNL,DYNAMIC_DEBUG]
-	module.dyndbg[="val"]
+	<module>.dyndbg[="val"]
 			Enable debug messages at boot time.  See
 			Documentation/admin-guide/dynamic-debug-howto.rst
 			for details.
@@ -1027,7 +1027,7 @@
 	nopku		[X86] Disable Memory Protection Keys CPU feature found
 			in some Intel CPUs.
 
-	module.async_probe [KNL]
+	<module>.async_probe [KNL]
 			Enable asynchronous probe on this module.
 
 	early_ioremap_debug [KNL]

