Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E542F267800
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 07:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725844AbgILFhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 01:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgILFhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 01:37:34 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7EFC061573
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 22:37:33 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id x10so11001270ybj.19
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 22:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=IzEAqsDDn5rXz1ixs09fPDPhKK47SPxCXjigiPSAcAM=;
        b=qYbXJe5uG2SoGqbfJaDZ7O2YNLK6DQbJHIYaV8oyHdxcOXj2XcIw92uIxg5Cl8x/+n
         nAssu7L83NN/6NV64UnDwF1yhho1hqMhHrBXB+90+D/IWeOisrfjSjHSVvCY6yOjUlLO
         jF6vpdmA8oCQV+35xHgoCEbQhXRp11vnZUv7Gpz71sQNj+umA3VuEw68tjYsDxToxGRR
         Z8Eb9h5OlV/CZaEs30J3UDbSYo9c/1c8OsQzYzeO3VkASsda+dlpupvaoGxwh0wP/Syr
         KToVkShjuEhu2N8l0tTEWPL8tfduThjkueAKrAB1Kwio7LYF1R7zS8K5DrBg/Xctihv7
         0asQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=IzEAqsDDn5rXz1ixs09fPDPhKK47SPxCXjigiPSAcAM=;
        b=JJcsVb0QUm6mlrgw4P9pklNcpGcil2sGrMsVWCMYugSn7oq220FNJukmNvRz6MMiIj
         MJ9pc/vvd3YSiGhi7qcurLW2ElY1AzdgoTqDIdeySLFZoTyPwj246+CErx0GhBvTFkzm
         OA7MWvW2KSuLJgH7Qu+WrStNXOeKcRYl0K85uBco1J2X5U8MjARRSDmjR7Rs+6jOglv0
         rlX+6Z17/Z4QfOd/AwI0kgL4Fx6sXlgf+SnUXLMvBbbvkSx6WgHgWffD8bAVOzCjLRsQ
         boIa9645wgjW8/6xTAPRsLHIf+sgBx5VOiDXwRD5GXBlogYMYzphJQ3Zh0olAEJos+IZ
         G2nw==
X-Gm-Message-State: AOAM53354DlKByI97s2C31NFI5DxPeRIOxcZondbQ4SSGntjtFzxDTCz
        WGYr2bE2ZcaMj4Y0JWhtK36OI7JPDEuo
X-Google-Smtp-Source: ABdhPJx4OjnsCmz/CCNYqPCe/IM3s6/SKrc6qCYpww46Iu2G3WgO31mRgD/dxPg41xASaSMtf2bcAfxfzrig
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:f693:9fff:fef4:4583])
 (user=irogers job=sendgmr) by 2002:a25:8404:: with SMTP id
 u4mr7376373ybk.176.1599889048784; Fri, 11 Sep 2020 22:37:28 -0700 (PDT)
Date:   Fri, 11 Sep 2020 22:37:25 -0700
Message-Id: <20200912053725.1405857-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [PATCH] perf bench: Fix 2 memory sanitizer warnings
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory sanitizer warns if a write is performed where the memory
being read for the write is uninitialized. Avoid this warning by
initializing the memory.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/bench/sched-messaging.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/bench/sched-messaging.c b/tools/perf/bench/sched-messaging.c
index 71d830d7b923..cecce93ccc63 100644
--- a/tools/perf/bench/sched-messaging.c
+++ b/tools/perf/bench/sched-messaging.c
@@ -66,11 +66,10 @@ static void fdpair(int fds[2])
 /* Block until we're ready to go */
 static void ready(int ready_out, int wakefd)
 {
-	char dummy;
 	struct pollfd pollfd = { .fd = wakefd, .events = POLLIN };
 
 	/* Tell them we're ready. */
-	if (write(ready_out, &dummy, 1) != 1)
+	if (write(ready_out, "R", 1) != 1)
 		err(EXIT_FAILURE, "CLIENT: ready write");
 
 	/* Wait for "GO" signal */
@@ -85,6 +84,7 @@ static void *sender(struct sender_context *ctx)
 	unsigned int i, j;
 
 	ready(ctx->ready_out, ctx->wakefd);
+	memset(data, 'S', sizeof(data));
 
 	/* Now pump to every receiver. */
 	for (i = 0; i < nr_loops; i++) {
-- 
2.28.0.618.gf4bc123cb7-goog

