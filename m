Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D259D269C74
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 05:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgIODTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 23:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgIODTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 23:19:12 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB6DC06178C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 20:19:10 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 34so1193637pgo.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 20:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rmLOsl9fiKPr6PXFbWJUDNjvS63BrA/4vSubxExPeuU=;
        b=NJ1X7WBSX8XTFUwbW019tuAMbtXcebyxL6m/xSNML/EM/HpP5kENeIxUg49RYTQr9k
         NBO4WimVAkn8QgNuv2Bh4B18va/9GAW7g+a5jC3pVi/HXGXvZTR9rIROvTTEb1s2hMM3
         Cekn/BjqwFpSCKxFwxTvL/IhYTFTi+VszXLr4CbvoFBb1fPOwGM2ckmhO0m9CiKmJtwe
         QJKc75x9aILNO9fi1P3ylRuRHoa7JsABpdCrvohNMRKVqX5LNQVsjNzHGXzX0/kAOJKM
         lJ8mKpnXl3TxcRcEZOkrVgL3SJ0UMy9cPSCXhJ3vkTAwpT+mNytG6hyCFkWav1wRVDqn
         T0wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=rmLOsl9fiKPr6PXFbWJUDNjvS63BrA/4vSubxExPeuU=;
        b=KjVh3jsU0en9vaLlk1FxAK6Ig462FHkdzyST/MM9o534qt6CwCCiWiXluUg+8trcvE
         MmQnwOeNsaRRK4jf7S8NG9n93oGa6KFOEBhD2YxJ/PmbhgG1A83UMvkTXMJS5eUNgRTH
         vSu+hi+M2CioMQTMmk2WOlqQTE9b6VgRc1cWbQOkbHYvXasUFW3HhBxmb9acuoiKlK8F
         RJxEA/hoN0m5lTJREIA684whg4sAQDwdCuHTKXptieFXgPEn4Bw8mCP/LnMxv8H9Ht8H
         SmlidynmtEbeOBK42SGj9YwiQaodXuzgfvLabbPnIneWNbkUYESIUNmI3B/MrcUdifl9
         K0PA==
X-Gm-Message-State: AOAM533v1ymkQnY1SDWC4cW5QXK2XYIuFI5Qbo03gDtamJoveZb/tzwK
        wWRi/9kWcGwq3r7LypeFmTk=
X-Google-Smtp-Source: ABdhPJzOjiBkhW2fMXK8ljVP2t6ECQ/nKqM7pRS9UyrfoUXE/nmcuvoAAjJ2s/s5IHdYHol7r0rxTg==
X-Received: by 2002:a63:f104:: with SMTP id f4mr13609702pgi.365.1600139950175;
        Mon, 14 Sep 2020 20:19:10 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id a24sm10584582pju.25.2020.09.14.20.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 20:19:09 -0700 (PDT)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 11/11] perf test: Free formats for perf pmu parse test
Date:   Tue, 15 Sep 2020 12:18:19 +0900
Message-Id: <20200915031819.386559-12-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
In-Reply-To: <20200915031819.386559-1-namhyung@kernel.org>
References: <20200915031819.386559-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following leaks were detected by ASAN:

  Indirect leak of 360 byte(s) in 9 object(s) allocated from:
    #0 0x7fecc305180e in calloc (/lib/x86_64-linux-gnu/libasan.so.5+0x10780e)
    #1 0x560578f6dce5 in perf_pmu__new_format util/pmu.c:1333
    #2 0x560578f752fc in perf_pmu_parse util/pmu.y:59
    #3 0x560578f6a8b7 in perf_pmu__format_parse util/pmu.c:73
    #4 0x560578e07045 in test__pmu tests/pmu.c:155
    #5 0x560578de109b in run_test tests/builtin-test.c:410
    #6 0x560578de109b in test_and_print tests/builtin-test.c:440
    #7 0x560578de401a in __cmd_test tests/builtin-test.c:661
    #8 0x560578de401a in cmd_test tests/builtin-test.c:807
    #9 0x560578e49354 in run_builtin /home/namhyung/project/linux/tools/perf/perf.c:312
    #10 0x560578ce71a8 in handle_internal_command /home/namhyung/project/linux/tools/perf/perf.c:364
    #11 0x560578ce71a8 in run_argv /home/namhyung/project/linux/tools/perf/perf.c:408
    #12 0x560578ce71a8 in main /home/namhyung/project/linux/tools/perf/perf.c:538
    #13 0x7fecc2b7acc9 in __libc_start_main ../csu/libc-start.c:308

Acked-by: Jiri Olsa <jolsa@redhat.com>
Fixes: cff7f956ec4a1 ("perf tests: Move pmu tests into separate object")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/pmu.c |  1 +
 tools/perf/util/pmu.c  | 11 +++++++++++
 tools/perf/util/pmu.h  |  1 +
 3 files changed, 13 insertions(+)

diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
index 5c11fe2b3040..714e6830a758 100644
--- a/tools/perf/tests/pmu.c
+++ b/tools/perf/tests/pmu.c
@@ -173,6 +173,7 @@ int test__pmu(struct test *test __maybe_unused, int subtest __maybe_unused)
 		ret = 0;
 	} while (0);
 
+	perf_pmu__del_formats(&formats);
 	test_format_dir_put(format);
 	return ret;
 }
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 555cb3524c25..d41caeb35cf6 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1354,6 +1354,17 @@ void perf_pmu__set_format(unsigned long *bits, long from, long to)
 		set_bit(b, bits);
 }
 
+void perf_pmu__del_formats(struct list_head *formats)
+{
+	struct perf_pmu_format *fmt, *tmp;
+
+	list_for_each_entry_safe(fmt, tmp, formats, list) {
+		list_del(&fmt->list);
+		free(fmt->name);
+		free(fmt);
+	}
+}
+
 static int sub_non_neg(int a, int b)
 {
 	if (b > a)
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index b63c4c5e335e..a64e9c9ce731 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -94,6 +94,7 @@ int perf_pmu__new_format(struct list_head *list, char *name,
 			 int config, unsigned long *bits);
 void perf_pmu__set_format(unsigned long *bits, long from, long to);
 int perf_pmu__format_parse(char *dir, struct list_head *head);
+void perf_pmu__del_formats(struct list_head *formats);
 
 struct perf_pmu *perf_pmu__scan(struct perf_pmu *pmu);
 
-- 
2.28.0.618.gf4bc123cb7-goog

