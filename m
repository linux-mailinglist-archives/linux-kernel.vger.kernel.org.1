Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC0252C45F4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 17:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732426AbgKYQw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 11:52:29 -0500
Received: from smtp.asem.it ([151.1.184.197]:55961 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731918AbgKYQw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 11:52:29 -0500
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 6.5.2)
        with ESMTP id SG000631152.MSG 
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 17:52:26 +0100
Received: from ASAS044.asem.intra (172.16.16.44) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 25
 Nov 2020 17:52:23 +0100
Received: from flavio-x.asem.intra (172.16.17.208) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 25 Nov 2020 17:52:23 +0100
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     Jonathan Corbet <corbet@lwn.net>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Flavio Suligoi <f.suligoi@asem.it>
Subject: [PATCH v1] docs/vm: hwpoison: fix spelling mistakes
Date:   Wed, 25 Nov 2020 17:52:22 +0100
Message-ID: <20201125165222.788910-1-f.suligoi@asem.it>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-SGHeloLookup-Result: pass smtp.helo=webmail.asem.it (ip=172.16.16.44)
X-SGSPF-Result: none (smtp.asem.it)
X-SGOP-RefID: str=0001.0A090210.5FBE8BC8.0058,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Actions:

- fix spelling mistake
- reduce some double spaces to a single one
- substitute spaces with tab

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
---
 Documentation/vm/hwpoison.rst | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/vm/hwpoison.rst b/Documentation/vm/hwpoison.rst
index a5c884293dac..88ba2df198d1 100644
--- a/Documentation/vm/hwpoison.rst
+++ b/Documentation/vm/hwpoison.rst
@@ -50,7 +50,7 @@ of applications. KVM support requires a recent qemu-kvm release.
 For the KVM use there was need for a new signal type so that
 KVM can inject the machine check into the guest with the proper
 address. This in theory allows other applications to handle
-memory failures too. The expection is that near all applications
+memory failures too. The expectation is that near all applications
 won't do that, but some very specialized ones might.
 
 Failure recovery modes
@@ -121,7 +121,7 @@ Testing
 
   unpoison-pfn
 	Software-unpoison page at PFN echoed into this file. This way
-	a page can be reused again.  This only works for Linux
+	a page can be reused again. This only works for Linux
 	injected failures, not for real memory failures.
 
   Note these injection interfaces are not stable and might change between
@@ -129,8 +129,8 @@ Testing
 
   corrupt-filter-dev-major, corrupt-filter-dev-minor
 	Only handle memory failures to pages associated with the file
-	system defined by block device major/minor.  -1U is the
-	wildcard value.  This should be only used for testing with
+	system defined by block device major/minor. -1U is the
+	wildcard value. This should be only used for testing with
 	artificial injection.
 
   corrupt-filter-memcg
@@ -141,7 +141,7 @@ Testing
 
 		mkdir /sys/fs/cgroup/mem/hwpoison
 
-	        usemem -m 100 -s 1000 &
+		usemem -m 100 -s 1000 &
 		echo `jobs -p` > /sys/fs/cgroup/mem/hwpoison/tasks
 
 		memcg_ino=$(ls -id /sys/fs/cgroup/mem/hwpoison | cut -f1 -d' ')
@@ -152,7 +152,7 @@ Testing
 
   corrupt-filter-flags-mask, corrupt-filter-flags-value
 	When specified, only poison pages if ((page_flags & mask) ==
-	value).  This allows stress testing of many kinds of
+	value). This allows stress testing of many kinds of
 	pages. The page_flags are the same as in /proc/kpageflags. The
 	flag bits are defined in include/linux/kernel-page-flags.h and
 	documented in Documentation/admin-guide/mm/pagemap.rst
-- 
2.25.1

