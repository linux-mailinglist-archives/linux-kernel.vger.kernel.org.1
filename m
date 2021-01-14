Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD812F68D7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 19:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729764AbhANSDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 13:03:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729745AbhANSDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 13:03:38 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AC0C061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 10:02:57 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id d7so5406661qkb.23
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 10:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=a5DqBEIg9ZUUqFisuGcFzEBE1gkPQ03QOU2mivyMBu0=;
        b=TWuUGXbiGPyD5CBA77F/WwdIAp+ZzlrA2W6ning74zQn7ymPiHFOEEEp9P4B/1LOyP
         Ltslja0N1kg8oZxwBUqsTUYi1Ub8DUyeAW0nFPhW85P3QL5WHVahtNd2rMZs72EuU9Z8
         nVbLpZrS3E9kP/QeXf4t9QJla5P4l8WJG3mdWv1tIo+fMnSk57jSEzky2uiZy9o0Cgts
         QbfR2l8Il5zxFFBywU5POAirAVWXgxLkc51ZVxZ2Vb3eU8Ud5/JqnUyRdWhQHeC+bekJ
         ezlqTjbOtRjkD3XnXXg1oSFwLLVSPTnLN/uYFsbkX9n1Wie/3JPdEPxOQj1gGwJh74cB
         ovWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=a5DqBEIg9ZUUqFisuGcFzEBE1gkPQ03QOU2mivyMBu0=;
        b=kljZXRjtgtgXuZXS8blAJskR7siOF0qeKzMbHUuDcT3hzinLOFk5yA8NN78zeU0W3y
         x+7x7Utxz0WkP74RJZ4JqgAc+FSy+H78Dcz2qWsmez0mbHGPk0nRIUJ/4D3HsgknftdC
         emWq6mEW8kbsSctn7QmlmlloYl8vx+t2W0MP4yLHWc9ZLqp20lppyTjTh3P++1CEAJbg
         5sg7dcvdsSEhLzVaPKl25jvsfN1yvH76UmCbh3SshDrqSkuUX8bt6mkbyXsZWw7tj7lR
         9DRTAe0LhDbnBe3HAQbUUbLqve3rATFzOeBfsDr2Vq6TLS5/VVXAdQJv3POaMxEYE2aY
         szfQ==
X-Gm-Message-State: AOAM531yGIly1QjsVbEaT7AY9nMlvqSFCmJQbl4fQ1XSZ8k2tpgAWa5T
        hxJLwd2cqn96OwQ/fXCWGcRXbXxWtk6n
X-Google-Smtp-Source: ABdhPJzmewDq3o9BCswJvlLnKBaCJWc+Q99sQNPUY+dpxhsF96dT/3XEvSTufZnpJuxaVuzIRCWV9LLe5h0j
Sender: "irogers via sendgmr" <irogers@irogers.svl.corp.google.com>
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:f693:9fff:fef4:4583])
 (user=irogers job=sendgmr) by 2002:a0c:fa4c:: with SMTP id
 k12mr8252877qvo.16.1610647377087; Thu, 14 Jan 2021 10:02:57 -0800 (PST)
Date:   Thu, 14 Jan 2021 10:02:50 -0800
In-Reply-To: <20210114180250.3853825-1-irogers@google.com>
Message-Id: <20210114180250.3853825-2-irogers@google.com>
Mime-Version: 1.0
References: <20210114180250.3853825-1-irogers@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH 2/2] libperf tests: Fail when failing to get a tracepoint id
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Permissions are necessary to get a tracepoint id. Fail the test when the
read fails.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/tests/test-evlist.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/perf/tests/test-evlist.c b/tools/lib/perf/tests/test-evlist.c
index d913241d4135..bd19cabddaf6 100644
--- a/tools/lib/perf/tests/test-evlist.c
+++ b/tools/lib/perf/tests/test-evlist.c
@@ -215,6 +215,7 @@ static int test_mmap_thread(void)
 		 sysfs__mountpoint());
 
 	if (filename__read_int(path, &id)) {
+		tests_failed++;
 		fprintf(stderr, "error: failed to get tracepoint id: %s\n", path);
 		return -1;
 	}
-- 
2.30.0.284.gd98b1dd5eaa7-goog

