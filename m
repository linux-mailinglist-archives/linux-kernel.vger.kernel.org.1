Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33474269C6F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 05:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgIODSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 23:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgIODSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 23:18:40 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932A6C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 20:18:40 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id t14so1209414pgl.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 20:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bIoSOHrdpFjVe5hbA/jTzosQ+mXpqE8CV0qfXZ/zfS4=;
        b=hgMzZDMdqmeohwWZBpxxra1pQikPyZReN2f+or1ROOp5OBRmEThw35RxRO+UefO+p2
         /+DdvNrCJfp/nAyTKSjDIdcw2Qhvx6ChTMlHbL0ZtxdAoPbpJgbCoZCdt0IdX9vvEQze
         MIcuMb/pFHLguEbhivpv5ZKP9ab2QahNfeMZc9DGpMYIByukTTr1eBG+qXb1OzIGpg0g
         PjZxJ042Fy9zvInsY4D6Cib85xe//NSS1alDV3BDrhOUXBgDNXYQwlr8XaQYiSWd0WVt
         EC17obaym+ujrFrC4QmRA9THu0Q0Ruu8nQzUWATjBn/rDfYmjHx0mY5J9aYodk+DN3mG
         LQ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=bIoSOHrdpFjVe5hbA/jTzosQ+mXpqE8CV0qfXZ/zfS4=;
        b=EWKeJ3ZtMNveOI2q2Cbsx3viQUH68em/EZV/1mP4HuIofmDbsSVs2ci0rhYj8u3e47
         LZqpn9QG3uW6cUrMjRMDe5n9DVG9oEF7fEatT9NDjjFtkTXZj3wYtW2CKPT503WAbrJ/
         U++bhXN3HQma3idbemnx8wmxjP+pA/YoTG7dYU3OCiC6Rw/353CkJqjeyY6PsCgukpbU
         4NSKyqBxbj2wozRyFn0Jqn+A51L+unergyhZ6LIpPJoHDOk2mFfVI170p/1qImxfnB3V
         UArNjyz78obcmj3/GeEDSBKaIWay3DI56AUBzMBtj+PFowx3bLaoUWw8gclYjshn6+0Z
         Lj0w==
X-Gm-Message-State: AOAM531kg88nMLf8PLjuC9Hd3UJAIg9MmAmn3Y6EuDFF6B9sohbckFYl
        24uQzDAWIONHNTcnq4kjdv4=
X-Google-Smtp-Source: ABdhPJxZMK02rFEsTGi5ePdBiqnjoPjSoD5XBfxSbVKg6BCmmhqd/qNGhqGLIeekVzQODPW2MKSRzQ==
X-Received: by 2002:aa7:864c:0:b029:13c:1611:6591 with SMTP id a12-20020aa7864c0000b029013c16116591mr15452672pfo.14.1600139920153;
        Mon, 14 Sep 2020 20:18:40 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id a24sm10584582pju.25.2020.09.14.20.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 20:18:39 -0700 (PDT)
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
Subject: [PATCH 03/11] perf evlist: Fix cpu/thread map leak
Date:   Tue, 15 Sep 2020 12:18:11 +0900
Message-Id: <20200915031819.386559-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
In-Reply-To: <20200915031819.386559-1-namhyung@kernel.org>
References: <20200915031819.386559-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Asan reported leak of cpu and thread maps as they have one more
refcount than released.  I found that after setting evlist maps it
should release it's refcount.

It seems to be broken from the beginning so I chose the original
commit as the culprit.  But not sure how it's applied to stable trees
since there are many changes in the code after that.

Acked-by: Jiri Olsa <jolsa@redhat.com>
Fixes: 7e2ed097538c5 ("perf evlist: Store pointer to the cpu and thread maps")
Fixes: 4112eb1899c0e ("perf evlist: Default to syswide target when no thread/cpu maps set")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/evlist.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index ee7b576d3b12..e971daf946d0 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -946,6 +946,10 @@ int perf_evlist__create_maps(struct evlist *evlist, struct target *target)
 
 	perf_evlist__set_maps(&evlist->core, cpus, threads);
 
+	/* as evlist now has references, put count here */
+	perf_cpu_map__put(cpus);
+	perf_thread_map__put(threads);
+
 	return 0;
 
 out_delete_threads:
@@ -1273,11 +1277,12 @@ static int perf_evlist__create_syswide_maps(struct evlist *evlist)
 		goto out_put;
 
 	perf_evlist__set_maps(&evlist->core, cpus, threads);
-out:
-	return err;
+
+	perf_thread_map__put(threads);
 out_put:
 	perf_cpu_map__put(cpus);
-	goto out;
+out:
+	return err;
 }
 
 int evlist__open(struct evlist *evlist)
-- 
2.28.0.618.gf4bc123cb7-goog

