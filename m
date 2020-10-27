Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0240129CD0C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 02:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgJ1Biz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 21:38:55 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:48704 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1833023AbgJ0XhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 19:37:01 -0400
Received: by mail-pl1-f202.google.com with SMTP id w16so1770749ply.15
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 16:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=4a9MYiiaTByHEbKl6To5Tz0gAmU1s4D2bue8aWKymII=;
        b=ti0ysnDzMX8K9s3iOF6d3+2ZR/oAqISGhCt//Y8qyqRAD+FFbTBuNGhv/HfDxO0iWO
         Tnksd0YoilK4CS7LK0en3GtVxELV5DhrS8cpR1XC4IEjbU9qoA7CbX9fg4xVGcSZe4aY
         CDDrO2ZjyZhFnSVvdFL/nbOFmlZKk2d0TGMPT+qdGsuBVZhjmeKfuMIYt4dfGcFQv2iT
         I8t3YhyERHXCwFzAPrm9TY1WmCkybWOg7uhosZ5ze9YDVNm+FUb1s31Qwi6gwIfXF66F
         kpYyUxxUkNsmtGwKEV4suUGGYe56pCNYU7pj6pHyITQfO8mZsJDLMKmFuZ0bVhQHYiIq
         ZZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4a9MYiiaTByHEbKl6To5Tz0gAmU1s4D2bue8aWKymII=;
        b=C0I98gz+E45MplVMAO6o5uhawK6zDd20J0O9DW6l7N7p4OKJH+vvkuZpKkSeu0eRrW
         k+TM+Q0B6xloDC7I41YK2paa8e+zNr4imkbQkRJS66ywh6Xn79VewxDRR+KBV3lTeZjx
         /NtpmfoPIub16nLeyBx9jePsrUeQ+ftS8ZTO7mEd26ygAvkDIyVa0UPatvCxbKGHD+Pm
         59OTWhcg3Gkqswnf2/nIDGpaSxwy5TUteeWFD/R94W7jUmNFrSZLHCjRmsi51a0Oq39D
         ruxDohuhpQl4LjtAp4MiJTl7bwqNOjfE6WlaL3e9UniSkgvgtb/8+Z9b2m9f3XMi0igV
         BCsg==
X-Gm-Message-State: AOAM530iQ5FlmDhsOabCkkubL7kdmEScG20nMVX2k92drPf4RqY9s6gY
        TaC+bxV/nm2XOOMJ832jEkggJF/n7P6J
X-Google-Smtp-Source: ABdhPJyFHO0f4PxvIORwWA5M0VfCJIehQ4AlnLeaLHsxZx+/28M/X1yaGhFBvfcBbffl9uTCEYmyzwBptmWK
Sender: "irogers via sendgmr" <irogers@irogers.svl.corp.google.com>
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:f693:9fff:fef4:4583])
 (user=irogers job=sendgmr) by 2002:a17:90a:7e0a:: with SMTP id
 i10mr4190504pjl.89.1603841820716; Tue, 27 Oct 2020 16:37:00 -0700 (PDT)
Date:   Tue, 27 Oct 2020 16:36:46 -0700
In-Reply-To: <20201027233646.3434896-1-irogers@google.com>
Message-Id: <20201027233646.3434896-2-irogers@google.com>
Mime-Version: 1.0
References: <20201027233646.3434896-1-irogers@google.com>
X-Mailer: git-send-email 2.29.0.rc2.309.g374f81d7ae-goog
Subject: [PATCH 2/2] tools, bpftool: Remove two unused variables.
From:   Ian Rogers <irogers@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Michal Rostecki <mrostecki@opensuse.org>,
        "=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid an unused variable warning.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/bpf/bpftool/skeleton/profiler.bpf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/skeleton/profiler.bpf.c b/tools/bpf/bpftool/skeleton/profiler.bpf.c
index 4e3512f700c0..ce5b65e07ab1 100644
--- a/tools/bpf/bpftool/skeleton/profiler.bpf.c
+++ b/tools/bpf/bpftool/skeleton/profiler.bpf.c
@@ -70,7 +70,7 @@ int BPF_PROG(fentry_XXX)
 static inline void
 fexit_update_maps(u32 id, struct bpf_perf_event_value *after)
 {
-	struct bpf_perf_event_value *before, diff, *accum;
+	struct bpf_perf_event_value *before, diff;
 
 	before = bpf_map_lookup_elem(&fentry_readings, &id);
 	/* only account samples with a valid fentry_reading */
@@ -95,7 +95,7 @@ int BPF_PROG(fexit_XXX)
 {
 	struct bpf_perf_event_value readings[MAX_NUM_MATRICS];
 	u32 cpu = bpf_get_smp_processor_id();
-	u32 i, one = 1, zero = 0;
+	u32 i, zero = 0;
 	int err;
 	u64 *count;
 
-- 
2.29.0.rc2.309.g374f81d7ae-goog

