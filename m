Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE335294613
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 02:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439704AbgJUAkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 20:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439690AbgJUAkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 20:40:15 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7D0C0613CE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 17:40:15 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id t4so284342plq.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 17:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GlUW/84k70Oyt3dk0p6xhDBs610gyjBwk6Xkv2sl5sg=;
        b=SSsLbw/UmHjDPfehy6zDGLBv/x4CP40DD27U1rwCTbdz9kH7+b07u5rm5G3V8uYFVk
         LBl2JxumfpGiuck78vduATGpv8fnb1HTMEX3EMAADmvUVti11IkP8k1Tjthlvqoh7E65
         697nDQXjDS9b6bFuETkCeGAFjOFBNtqxR59A2t6WnHSi0kE4JQiYSwo0TgW0KCFlcxRl
         TL8cp2tCLhj1AaMPufwhlYOytTBPk06dslnwDz0MPpEhrZYmtPmpqpb/bRI0IWvpXdtw
         oslzSWtNE3QakMys2bbv3p6ydu1NH3prkwuPSkW1EO8KH0gWOu9J0nsKhMSRtN7YUcZ3
         wUXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GlUW/84k70Oyt3dk0p6xhDBs610gyjBwk6Xkv2sl5sg=;
        b=OWWUUcb4SWM9seo/wdMKjTi7YcwUQFAMd/3QbVIl+go2FXde6VdgVP+Z2Qgs16WxY/
         WwNmhO4QBeWYDRz515bhx4uyDMdyk95CpI1/05BwMUb9/IsiUJlWU4+y4qiF1/A29TbZ
         T3pg+jwIu46Hn5ZD1GYQYU2EJJvvMs4oxJuLE7L/+7ZvTnLL6TCuw7ZoFhAyz2v5bwRW
         nNFOzuz/DK7PkUjDXLy6OH6Hehlu+5q1KSkUbeVs5XwcHyY6DTOFRv80PHuMOfTYsVZ/
         tZtZfvKe73Iccj1Q9CGq6UrTG43Rpgjr+MMz3J9T/08bve6qmlkXbqeiazS24ex8GDTW
         ADDw==
X-Gm-Message-State: AOAM5339TZthg1dqsE0kb3J8Zr71zSan93LdDpE+8n5zF5/c1KuE1Czd
        Z5gESVOIECqiojP7lVrSxY3MjQ==
X-Google-Smtp-Source: ABdhPJwDOcTk93/nO+xo3aUtLKmxmS16TEn7qozH3+Vgu2So5DXW8udrtIrfyRjgtn4CFbxOIK2xrg==
X-Received: by 2002:a17:90a:6683:: with SMTP id m3mr673016pjj.225.1603240815081;
        Tue, 20 Oct 2020 17:40:15 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id u7sm197136pfn.37.2020.10.20.17.40.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Oct 2020 17:40:14 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 2/2] perf lock: Don't free "lock_seq_stat" if read_count isn't zero
Date:   Wed, 21 Oct 2020 08:39:48 +0800
Message-Id: <20201021003948.28817-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201021003948.28817-1-leo.yan@linaro.org>
References: <20201021003948.28817-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When execute command "perf lock report", it hits failure and outputs log
as follows:

  perf: builtin-lock.c:623: report_lock_release_event: Assertion `!(seq->read_count < 0)' failed.
  Aborted

This is an imbalance issue.  The locking sequence structure
"lock_seq_stat" contains the reader counter and it is used to check if
the locking sequence is balance or not between acquiring and releasing.

If the tool wrongly frees "lock_seq_stat" when "read_count" isn't zero,
the "read_count" will be reset to zero when allocate a new structure at
the next time; thus it causes the wrong counting for reader and finally
results in imbalance issue.

To fix this issue, if detects "read_count" is not zero (means still
have read user in the locking sequence), goto the "end" tag to skip
freeing structure "lock_seq_stat".

Fixes: e4cef1f65061 ("perf lock: Fix state machine to recognize lock sequence")
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-lock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 5cecc1ad78e1..a2f1e53f37a7 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -621,7 +621,7 @@ static int report_lock_release_event(struct evsel *evsel,
 	case SEQ_STATE_READ_ACQUIRED:
 		seq->read_count--;
 		BUG_ON(seq->read_count < 0);
-		if (!seq->read_count) {
+		if (seq->read_count) {
 			ls->nr_release++;
 			goto end;
 		}
-- 
2.17.1

