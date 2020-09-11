Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64A6426661E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 19:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725875AbgIKRVn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 11 Sep 2020 13:21:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51147 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726029AbgIKNA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 09:00:29 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-XoifVDoTPOmy5KbhGZ_S1g-1; Fri, 11 Sep 2020 09:00:10 -0400
X-MC-Unique: XoifVDoTPOmy5KbhGZ_S1g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73B9B107B272;
        Fri, 11 Sep 2020 13:00:08 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 13EDE75136;
        Fri, 11 Sep 2020 13:00:05 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Wang Nan <wangnan0@huawei.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH] perf test: Fix signal test inline assembly
Date:   Fri, 11 Sep 2020 15:00:05 +0200
Message-Id: <20200911130005.1842138-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When compiling with DEBUG=1 on Fedora 32 I'm getting crash for
'perf test signal':

  Program received signal SIGSEGV, Segmentation fault.
  0x0000000000c68548 in __test_function ()
  (gdb) bt
  #0  0x0000000000c68548 in __test_function ()
  #1  0x00000000004d62e9 in test_function () at tests/bp_signal.c:61
  #2  0x00000000004d689a in test__bp_signal (test=0xa8e280 <generic_ ...
  #3  0x00000000004b7d49 in run_test (test=0xa8e280 <generic_tests+1 ...
  #4  0x00000000004b7e7f in test_and_print (t=0xa8e280 <generic_test ...
  #5  0x00000000004b8927 in __cmd_test (argc=1, argv=0x7fffffffdce0, ...
  ...

It's caused by __test_function being in .bss section:

  $ readelf -a ./perf | less
    [Nr] Name              Type             Address           Offset
         Size              EntSize          Flags  Link  Info  Align
    ...
    [28] .bss              NOBITS           0000000000c356a0  008346a0
         00000000000511f8  0000000000000000  WA       0     0     32

  $ nm perf | grep __test_function
  0000000000c68548 B __test_function

I guess most of the time we're just lucky the inline asm ended up
in .text section, so making it specific explicit with push and pop
section cluases.

  $ readelf -a ./perf | less
    [Nr] Name              Type             Address           Offset
         Size              EntSize          Flags  Link  Info  Align
    ...
    [13] .text             PROGBITS         0000000000431240  00031240
         0000000000306faa  0000000000000000  AX       0     0     16

  $ nm perf | grep __test_function
  00000000004d62c8 T __test_function

Cc: Wang Nan <wangnan0@huawei.com>
Fixes: 8fd34e1cce18 ("perf test: Improve bp_signal")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/tests/bp_signal.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/bp_signal.c b/tools/perf/tests/bp_signal.c
index da8ec1e8e064..cc9fbcedb364 100644
--- a/tools/perf/tests/bp_signal.c
+++ b/tools/perf/tests/bp_signal.c
@@ -45,10 +45,13 @@ volatile long the_var;
 #if defined (__x86_64__)
 extern void __test_function(volatile long *ptr);
 asm (
+	".pushsection .text;"
 	".globl __test_function\n"
+	".type __test_function, @function;"
 	"__test_function:\n"
 	"incq (%rdi)\n"
-	"ret\n");
+	"ret\n"
+	".popsection\n");
 #else
 static void __test_function(volatile long *ptr)
 {
-- 
2.26.2

