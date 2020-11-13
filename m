Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D3E2B238E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 19:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbgKMSU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 13:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbgKMSU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 13:20:58 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81900C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 10:20:58 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id g129so11678220ybf.20
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 10:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=UN5KOEvN+JZYIPsHe3DM/FFg3ACm2oVCE2QnOg7sgbM=;
        b=bqs+hfJb85Nhl7BhukKBMm7kGQGX5PZIya6D4L1GmxhkXvubMs33/p++4RjYzExMWe
         Y8mDDG30qGH1bC4VsDFAgP5ik85+oc8REmlZwUBtAoOCReXS8wIvNadmtbUhs1csWNK2
         0KHd3BgVjWeJ//UaNlxosyF3VEMVTedzSYVbkkpgnEQ4bykARPLDJaMjjC5hzo0DtoSP
         RPMDYGir/BrZS2woHeRbPTapcHxrOc6rgDmGxPDC7yttTXdFhbX4FR17Qba7wwyoHgjj
         xmlFETjhNOs1JtthhA6Xk5/aYq7TGsFFCOLqW4Lj8yolT/AGRNKqiD1wN3+UAIehVyxz
         0CuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=UN5KOEvN+JZYIPsHe3DM/FFg3ACm2oVCE2QnOg7sgbM=;
        b=r0M2g6zTfC8EkU7Id3SYKkifcLAbLp7BrYCspWgfXPfF7YQu9pGeXUcsa/0oh/W4EJ
         yfstC4cAHfA2Qoeq4jyxWeoRUwa17dQEHV+Hxl7tAIsvYyJjiRgU8BFZB8lntB4eSF6M
         tX3nQ0BFhwJEXvw3uL1ZOZxk+LdkREozrCoH5j2hrSiAflZg3jK1+Is6deEIW6fbk8DT
         /d9UIM+88F/sGe3Jc5IOsRHXfEMtlHFDWdxHDRKzRDx5/QzL4+U9m3ETaiNP7nyH89ab
         nj+HTT8O0UrSTaeKw2CLveOwkfwEqfz0LPBlXNjufRPAeBP9vuSyaveBRkX2JOOSoFXD
         w7EA==
X-Gm-Message-State: AOAM530dIg0XEGtseTpOuyOVzuKfjG1Nql94O2XD817n5RgiHcRvfTDr
        Xnuq0QxEFBs6UWx+C4L2JvoaVhUxKe99
X-Google-Smtp-Source: ABdhPJxObbcBI9kl3VlpK7JTmVB2RohHnHI5jFz5Mg5nhYz+HuNlsyc1XyoKKUY2Nd3rfbtUiXi/+ciDB2u9
Sender: "irogers via sendgmr" <irogers@irogers.svl.corp.google.com>
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:f693:9fff:fef4:4583])
 (user=irogers job=sendgmr) by 2002:a25:774c:: with SMTP id
 s73mr7508141ybc.262.1605291657714; Fri, 13 Nov 2020 10:20:57 -0800 (PST)
Date:   Fri, 13 Nov 2020 10:20:53 -0800
Message-Id: <20201113182053.754625-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH] perf test: Avoid an msan warning in a copied stack.
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Cc:     Stephane Eranian <eranian@google.com>,
        Sandeep Dasgupta <sdasgup@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fix is for a failure that occurred in the DWARF unwind perf test.
Stack unwinders may probe memory when looking for frames. Memory
sanitizer will poison and track uninitialized memory on the stack, and
on the heap if the value is copied to the heap. This can lead to false
memory sanitizer failures for the use of an uninitialized value. Avoid
this problem by removing the poison on the copied stack.

The full msan failure with track origins looks like:

==2168==WARNING: MemorySanitizer: use-of-uninitialized-value
    #0 0x559ceb10755b in handle_cfi elfutils/libdwfl/frame_unwind.c:648:8
    #1 0x559ceb105448 in __libdwfl_frame_unwind elfutils/libdwfl/frame_unwind.c:741:4
    #2 0x559ceb0ece90 in dwfl_thread_getframes elfutils/libdwfl/dwfl_frame.c:435:7
    #3 0x559ceb0ec6b7 in get_one_thread_frames_cb elfutils/libdwfl/dwfl_frame.c:379:10
    #4 0x559ceb0ec6b7 in get_one_thread_cb elfutils/libdwfl/dwfl_frame.c:308:17
    #5 0x559ceb0ec6b7 in dwfl_getthreads elfutils/libdwfl/dwfl_frame.c:283:17
    #6 0x559ceb0ec6b7 in getthread elfutils/libdwfl/dwfl_frame.c:354:14
    #7 0x559ceb0ec6b7 in dwfl_getthread_frames elfutils/libdwfl/dwfl_frame.c:388:10
    #8 0x559ceaff6ae6 in unwind__get_entries tools/perf/util/unwind-libdw.c:236:8
    #9 0x559ceabc9dbc in test_dwarf_unwind__thread tools/perf/tests/dwarf-unwind.c:111:8
    #10 0x559ceabca5cf in test_dwarf_unwind__compare tools/perf/tests/dwarf-unwind.c:138:26
    #11 0x7f812a6865b0 in bsearch (libc.so.6+0x4e5b0)
    #12 0x559ceabca871 in test_dwarf_unwind__krava_3 tools/perf/tests/dwarf-unwind.c:162:2
    #13 0x559ceabca926 in test_dwarf_unwind__krava_2 tools/perf/tests/dwarf-unwind.c:169:9
    #14 0x559ceabca946 in test_dwarf_unwind__krava_1 tools/perf/tests/dwarf-unwind.c:174:9
    #15 0x559ceabcae12 in test__dwarf_unwind tools/perf/tests/dwarf-unwind.c:211:8
    #16 0x559ceabbc4ab in run_test tools/perf/tests/builtin-test.c:418:9
    #17 0x559ceabbc4ab in test_and_print tools/perf/tests/builtin-test.c:448:9
    #18 0x559ceabbac70 in __cmd_test tools/perf/tests/builtin-test.c:669:4
    #19 0x559ceabbac70 in cmd_test tools/perf/tests/builtin-test.c:815:9
    #20 0x559cea960e30 in run_builtin tools/perf/perf.c:313:11
    #21 0x559cea95fbce in handle_internal_command tools/perf/perf.c:365:8
    #22 0x559cea95fbce in run_argv tools/perf/perf.c:409:2
    #23 0x559cea95fbce in main tools/perf/perf.c:539:3

  Uninitialized value was stored to memory at
    #0 0x559ceb106acf in __libdwfl_frame_reg_set elfutils/libdwfl/frame_unwind.c:77:22
    #1 0x559ceb106acf in handle_cfi elfutils/libdwfl/frame_unwind.c:627:13
    #2 0x559ceb105448 in __libdwfl_frame_unwind elfutils/libdwfl/frame_unwind.c:741:4
    #3 0x559ceb0ece90 in dwfl_thread_getframes elfutils/libdwfl/dwfl_frame.c:435:7
    #4 0x559ceb0ec6b7 in get_one_thread_frames_cb elfutils/libdwfl/dwfl_frame.c:379:10
    #5 0x559ceb0ec6b7 in get_one_thread_cb elfutils/libdwfl/dwfl_frame.c:308:17
    #6 0x559ceb0ec6b7 in dwfl_getthreads elfutils/libdwfl/dwfl_frame.c:283:17
    #7 0x559ceb0ec6b7 in getthread elfutils/libdwfl/dwfl_frame.c:354:14
    #8 0x559ceb0ec6b7 in dwfl_getthread_frames elfutils/libdwfl/dwfl_frame.c:388:10
    #9 0x559ceaff6ae6 in unwind__get_entries tools/perf/util/unwind-libdw.c:236:8
    #10 0x559ceabc9dbc in test_dwarf_unwind__thread tools/perf/tests/dwarf-unwind.c:111:8
    #11 0x559ceabca5cf in test_dwarf_unwind__compare tools/perf/tests/dwarf-unwind.c:138:26
    #12 0x7f812a6865b0 in bsearch (libc.so.6+0x4e5b0)
    #13 0x559ceabca871 in test_dwarf_unwind__krava_3 tools/perf/tests/dwarf-unwind.c:162:2
    #14 0x559ceabca926 in test_dwarf_unwind__krava_2 tools/perf/tests/dwarf-unwind.c:169:9
    #15 0x559ceabca946 in test_dwarf_unwind__krava_1 tools/perf/tests/dwarf-unwind.c:174:9
    #16 0x559ceabcae12 in test__dwarf_unwind tools/perf/tests/dwarf-unwind.c:211:8
    #17 0x559ceabbc4ab in run_test tools/perf/tests/builtin-test.c:418:9
    #18 0x559ceabbc4ab in test_and_print tools/perf/tests/builtin-test.c:448:9
    #19 0x559ceabbac70 in __cmd_test tools/perf/tests/builtin-test.c:669:4
    #20 0x559ceabbac70 in cmd_test tools/perf/tests/builtin-test.c:815:9
    #21 0x559cea960e30 in run_builtin tools/perf/perf.c:313:11
    #22 0x559cea95fbce in handle_internal_command tools/perf/perf.c:365:8
    #23 0x559cea95fbce in run_argv tools/perf/perf.c:409:2
    #24 0x559cea95fbce in main tools/perf/perf.c:539:3

  Uninitialized value was stored to memory at
    #0 0x559ceb106a54 in handle_cfi elfutils/libdwfl/frame_unwind.c:613:9
    #1 0x559ceb105448 in __libdwfl_frame_unwind elfutils/libdwfl/frame_unwind.c:741:4
    #2 0x559ceb0ece90 in dwfl_thread_getframes elfutils/libdwfl/dwfl_frame.c:435:7
    #3 0x559ceb0ec6b7 in get_one_thread_frames_cb elfutils/libdwfl/dwfl_frame.c:379:10
    #4 0x559ceb0ec6b7 in get_one_thread_cb elfutils/libdwfl/dwfl_frame.c:308:17
    #5 0x559ceb0ec6b7 in dwfl_getthreads elfutils/libdwfl/dwfl_frame.c:283:17
    #6 0x559ceb0ec6b7 in getthread elfutils/libdwfl/dwfl_frame.c:354:14
    #7 0x559ceb0ec6b7 in dwfl_getthread_frames elfutils/libdwfl/dwfl_frame.c:388:10
    #8 0x559ceaff6ae6 in unwind__get_entries tools/perf/util/unwind-libdw.c:236:8
    #9 0x559ceabc9dbc in test_dwarf_unwind__thread tools/perf/tests/dwarf-unwind.c:111:8
    #10 0x559ceabca5cf in test_dwarf_unwind__compare tools/perf/tests/dwarf-unwind.c:138:26
    #11 0x7f812a6865b0 in bsearch (libc.so.6+0x4e5b0)
    #12 0x559ceabca871 in test_dwarf_unwind__krava_3 tools/perf/tests/dwarf-unwind.c:162:2
    #13 0x559ceabca926 in test_dwarf_unwind__krava_2 tools/perf/tests/dwarf-unwind.c:169:9
    #14 0x559ceabca946 in test_dwarf_unwind__krava_1 tools/perf/tests/dwarf-unwind.c:174:9
    #15 0x559ceabcae12 in test__dwarf_unwind tools/perf/tests/dwarf-unwind.c:211:8
    #16 0x559ceabbc4ab in run_test tools/perf/tests/builtin-test.c:418:9
    #17 0x559ceabbc4ab in test_and_print tools/perf/tests/builtin-test.c:448:9
    #18 0x559ceabbac70 in __cmd_test tools/perf/tests/builtin-test.c:669:4
    #19 0x559ceabbac70 in cmd_test tools/perf/tests/builtin-test.c:815:9
    #20 0x559cea960e30 in run_builtin tools/perf/perf.c:313:11
    #21 0x559cea95fbce in handle_internal_command tools/perf/perf.c:365:8
    #22 0x559cea95fbce in run_argv tools/perf/perf.c:409:2
    #23 0x559cea95fbce in main tools/perf/perf.c:539:3

  Uninitialized value was stored to memory at
    #0 0x559ceaff8800 in memory_read tools/perf/util/unwind-libdw.c:156:10
    #1 0x559ceb10f053 in expr_eval elfutils/libdwfl/frame_unwind.c:501:13
    #2 0x559ceb1060cc in handle_cfi elfutils/libdwfl/frame_unwind.c:603:18
    #3 0x559ceb105448 in __libdwfl_frame_unwind elfutils/libdwfl/frame_unwind.c:741:4
    #4 0x559ceb0ece90 in dwfl_thread_getframes elfutils/libdwfl/dwfl_frame.c:435:7
    #5 0x559ceb0ec6b7 in get_one_thread_frames_cb elfutils/libdwfl/dwfl_frame.c:379:10
    #6 0x559ceb0ec6b7 in get_one_thread_cb elfutils/libdwfl/dwfl_frame.c:308:17
    #7 0x559ceb0ec6b7 in dwfl_getthreads elfutils/libdwfl/dwfl_frame.c:283:17
    #8 0x559ceb0ec6b7 in getthread elfutils/libdwfl/dwfl_frame.c:354:14
    #9 0x559ceb0ec6b7 in dwfl_getthread_frames elfutils/libdwfl/dwfl_frame.c:388:10
    #10 0x559ceaff6ae6 in unwind__get_entries tools/perf/util/unwind-libdw.c:236:8
    #11 0x559ceabc9dbc in test_dwarf_unwind__thread tools/perf/tests/dwarf-unwind.c:111:8
    #12 0x559ceabca5cf in test_dwarf_unwind__compare tools/perf/tests/dwarf-unwind.c:138:26
    #13 0x7f812a6865b0 in bsearch (libc.so.6+0x4e5b0)
    #14 0x559ceabca871 in test_dwarf_unwind__krava_3 tools/perf/tests/dwarf-unwind.c:162:2
    #15 0x559ceabca926 in test_dwarf_unwind__krava_2 tools/perf/tests/dwarf-unwind.c:169:9
    #16 0x559ceabca946 in test_dwarf_unwind__krava_1 tools/perf/tests/dwarf-unwind.c:174:9
    #17 0x559ceabcae12 in test__dwarf_unwind tools/perf/tests/dwarf-unwind.c:211:8
    #18 0x559ceabbc4ab in run_test tools/perf/tests/builtin-test.c:418:9
    #19 0x559ceabbc4ab in test_and_print tools/perf/tests/builtin-test.c:448:9
    #20 0x559ceabbac70 in __cmd_test tools/perf/tests/builtin-test.c:669:4
    #21 0x559ceabbac70 in cmd_test tools/perf/tests/builtin-test.c:815:9
    #22 0x559cea960e30 in run_builtin tools/perf/perf.c:313:11
    #23 0x559cea95fbce in handle_internal_command tools/perf/perf.c:365:8
    #24 0x559cea95fbce in run_argv tools/perf/perf.c:409:2
    #25 0x559cea95fbce in main tools/perf/perf.c:539:3

  Uninitialized value was stored to memory at
    #0 0x559cea9027d9 in __msan_memcpy llvm/llvm-project/compiler-rt/lib/msan/msan_interceptors.cpp:1558:3
    #1 0x559cea9d2185 in sample_ustack tools/perf/arch/x86/tests/dwarf-unwind.c:41:2
    #2 0x559cea9d202c in test__arch_unwind_sample tools/perf/arch/x86/tests/dwarf-unwind.c:72:9
    #3 0x559ceabc9cbd in test_dwarf_unwind__thread tools/perf/tests/dwarf-unwind.c:106:6
    #4 0x559ceabca5cf in test_dwarf_unwind__compare tools/perf/tests/dwarf-unwind.c:138:26
    #5 0x7f812a6865b0 in bsearch (libc.so.6+0x4e5b0)
    #6 0x559ceabca871 in test_dwarf_unwind__krava_3 tools/perf/tests/dwarf-unwind.c:162:2
    #7 0x559ceabca926 in test_dwarf_unwind__krava_2 tools/perf/tests/dwarf-unwind.c:169:9
    #8 0x559ceabca946 in test_dwarf_unwind__krava_1 tools/perf/tests/dwarf-unwind.c:174:9
    #9 0x559ceabcae12 in test__dwarf_unwind tools/perf/tests/dwarf-unwind.c:211:8
    #10 0x559ceabbc4ab in run_test tools/perf/tests/builtin-test.c:418:9
    #11 0x559ceabbc4ab in test_and_print tools/perf/tests/builtin-test.c:448:9
    #12 0x559ceabbac70 in __cmd_test tools/perf/tests/builtin-test.c:669:4
    #13 0x559ceabbac70 in cmd_test tools/perf/tests/builtin-test.c:815:9
    #14 0x559cea960e30 in run_builtin tools/perf/perf.c:313:11
    #15 0x559cea95fbce in handle_internal_command tools/perf/perf.c:365:8
    #16 0x559cea95fbce in run_argv tools/perf/perf.c:409:2
    #17 0x559cea95fbce in main tools/perf/perf.c:539:3

  Uninitialized value was created by an allocation of 'bf' in the stack frame of function 'perf_event__synthesize_mmap_events'
    #0 0x559ceafc5f60 in perf_event__synthesize_mmap_events tools/perf/util/synthetic-events.c:445

SUMMARY: MemorySanitizer: use-of-uninitialized-value elfutils/libdwfl/frame_unwind.c:648:8 in handle_cfi
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/tests/dwarf-unwind.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/arch/x86/tests/dwarf-unwind.c b/tools/perf/arch/x86/tests/dwarf-unwind.c
index 4e40402a4f81..478078fb0f22 100644
--- a/tools/perf/arch/x86/tests/dwarf-unwind.c
+++ b/tools/perf/arch/x86/tests/dwarf-unwind.c
@@ -38,6 +38,13 @@ static int sample_ustack(struct perf_sample *sample,
 	stack_size = stack_size > STACK_SIZE ? STACK_SIZE : stack_size;
 
 	memcpy(buf, (void *) sp, stack_size);
+#ifdef MEMORY_SANITIZER
+	/*
+	 * Copying the stack may copy msan poison, avoid false positives in the
+	 * unwinder by removing the poison here.
+	 */
+	__msan_unpoison(buf, stack_size);
+#endif
 	stack->data = (char *) buf;
 	stack->size = stack_size;
 	return 0;
-- 
2.29.2.299.gdc1121823c-goog

