Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 787E228ADCC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 07:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgJLFjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 01:39:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34253 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726072AbgJLFjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 01:39:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602481183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=e3QWjUJHv2lwRgaQ8sIPZv9jiWiYDz9cFhes637STLk=;
        b=DqmPR2Z1Db99Cx2/3UeZi7i1BtggeH2PXhv4r6b3Eu6AF81bI7pQd4rdPdYhTRY52vPmDc
        sCZ0zG+batNJN3clzFV0qf9C8Yvhw3jdGZLoGrvksSawynFW0TFiCWpDcsAzeia6GIOHOS
        vKvJrIQUDWH2NfPWDplIKjkpnrKa7Sk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-XjPeKJ8UPd-Fa5JBmoKakg-1; Mon, 12 Oct 2020 01:39:41 -0400
X-MC-Unique: XjPeKJ8UPd-Fa5JBmoKakg-1
Received: by mail-wr1-f69.google.com with SMTP id 33so8732201wrf.22
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 22:39:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e3QWjUJHv2lwRgaQ8sIPZv9jiWiYDz9cFhes637STLk=;
        b=rs4txl30tzao+8UkkSKWA43EQBg1m1JAH3iVjtXfW/IEaHjz8yWfrsS1v9EohMRw+v
         C2lrsRN0kn9/4fJ0fEtcN1NF5RSs1SpRnhIqxuLSIBh/NEblUcEfBeVnZyaKe2yONaQh
         MKLePgY2bOPf72iqdmBYwiaKPsbArEr72TQC35lNHD/cqpHPzPrIHgY9464rW+oKNGpn
         EG6AAH+2DBt+qqDk9YGgoQatkmk+XRB2JPF6siQMEEv6zDwOmJKTSMdNpkxeKFl9c8KX
         c2z6tDD1G1Fyw5pW88h7qxYNwdaRXd7yRPM0c0U7/Bm8G0nbjnpGRXwqJRXdregdDCYM
         9NuQ==
X-Gm-Message-State: AOAM531LcTJneOpQH8af1k88bZkENAQ7DioU69ukvn1bGDKuV+tgc1iD
        bMs/rAqEDOI4L/Yn9CwykhcWvCmhZ4MaZF3du88I+Pn3OGDmTyhXhxqaHoYhG6261ou4FLvSxfJ
        08x99mdY9wds0rnuFYIAi55/P
X-Received: by 2002:adf:f247:: with SMTP id b7mr1685281wrp.56.1602481179988;
        Sun, 11 Oct 2020 22:39:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx6UJnbj9fexnbwrYOQj2XQcUtgvyC/g++nUyC6Mc+Zi2kMlkPSBCQMH5Wwgc8bGUhZXCqjJA==
X-Received: by 2002:adf:f247:: with SMTP id b7mr1685267wrp.56.1602481179778;
        Sun, 11 Oct 2020 22:39:39 -0700 (PDT)
Received: from localhost.localdomain.com ([151.29.23.182])
        by smtp.gmail.com with ESMTPSA id d20sm9329823wra.38.2020.10.11.22.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2020 22:39:39 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org, bristot@redhat.com,
        patrick.bellasi@matbug.net, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, chris.redpath@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH] sched/features: Fix !CONFIG_JUMP_LABEL case
Date:   Mon, 12 Oct 2020 07:39:10 +0200
Message-Id: <20201012053910.97010-1-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 765cc3a4b224e ("sched/core: Optimize sched_feat() for
!CONFIG_SCHED_DEBUG builds") made sched features static for
!CONFIG_SCHED_DEBUG configurations, but overlooked the CONFIG_
SCHED_DEBUG enabled and !HAVE_JUMP_LABEL cases. For the latter, echoing
changes to /sys/kernel/debug/sched_features has the nasty effect of
effectively changing what sched_features reports, but without actually
changing the scheduler behaviour (since different translation units get
different sysctl_sched_features).

Fix CONFIG_SCHED_DEBUG and !HAVE_JUMP_LABEL configurations by properly
restructuring ifdefs.

Fixes: 765cc3a4b224e ("sched/core: Optimize sched_feat() for !CONFIG_SCHED_DEBUG builds")
Co-developed-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/sched/core.c  |  2 +-
 kernel/sched/sched.h | 13 ++++++++++---
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3dc415f58bd7..a7949e3ed7e7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -44,7 +44,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_update_nr_running_tp);
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
 
-#if defined(CONFIG_SCHED_DEBUG) && defined(CONFIG_JUMP_LABEL)
+#ifdef CONFIG_SCHED_DEBUG
 /*
  * Debugging: various feature bits
  *
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 28709f6b0975..caf9202b0aab 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1629,7 +1629,7 @@ enum {
 
 #undef SCHED_FEAT
 
-#if defined(CONFIG_SCHED_DEBUG) && defined(CONFIG_JUMP_LABEL)
+#ifdef CONFIG_SCHED_DEBUG
 
 /*
  * To support run-time toggling of sched features, all the translation units
@@ -1637,6 +1637,7 @@ enum {
  */
 extern const_debug unsigned int sysctl_sched_features;
 
+#ifdef HAVE_JUMP_LABEL
 #define SCHED_FEAT(name, enabled)					\
 static __always_inline bool static_branch_##name(struct static_key *key) \
 {									\
@@ -1649,7 +1650,13 @@ static __always_inline bool static_branch_##name(struct static_key *key) \
 extern struct static_key sched_feat_keys[__SCHED_FEAT_NR];
 #define sched_feat(x) (static_branch_##x(&sched_feat_keys[__SCHED_FEAT_##x]))
 
-#else /* !(SCHED_DEBUG && CONFIG_JUMP_LABEL) */
+#else /* !HAVE_JUMP_LABEL */
+
+#define sched_feat(x) (sysctl_sched_features & (1UL << __SCHED_FEAT_##x))
+
+#endif /* HAVE_JUMP_LABEL */
+
+#else /* !SCHED_DEBUG */
 
 /*
  * Each translation unit has its own copy of sysctl_sched_features to allow
@@ -1665,7 +1672,7 @@ static const_debug __maybe_unused unsigned int sysctl_sched_features =
 
 #define sched_feat(x) !!(sysctl_sched_features & (1UL << __SCHED_FEAT_##x))
 
-#endif /* SCHED_DEBUG && CONFIG_JUMP_LABEL */
+#endif /* SCHED_DEBUG */
 
 extern struct static_key_false sched_numa_balancing;
 extern struct static_key_false sched_schedstats;
-- 
2.26.2

