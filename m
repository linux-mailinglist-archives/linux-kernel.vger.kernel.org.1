Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8DBD26BBCE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 07:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbgIPFbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 01:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgIPFbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 01:31:40 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E81C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 22:31:38 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id y1so3242083pgk.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 22:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LY0P4ISqX/BlkwFip5IXHUhpzZ/gtHjw0QSgLOOkdBw=;
        b=DGjXIBpBcIHb03nMs4t/7ruYfFSwSdLBeR2L/FiksdRRBOi9ypDgUsoCTG4FpeoQQm
         kn818j6xUbW4UHeLY04SG9n4UaeVLtfhCfin4RIEZqIubXo1Debk+Ahi+wO7dLDfMRPJ
         5TInahqM2vPlVT5mHRhAevcKnAGrUGJyMSyEi9AgiwH3WJ7T1DS0kgpl9Z1UpiaoJ4LM
         6p7bUZf7gh4Dsj3T5xaJOw2L1DS/mIjbsCoo0Q7bGuie3y6WqIOxyqn8aF3SEDr+IDT5
         4L0+fVAvDbXCRkcRYaqpvNFjdZA45wz8un1BKrFIczZ3oyZEo3XZXVQdkj+n2GWKxmn3
         T+rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=LY0P4ISqX/BlkwFip5IXHUhpzZ/gtHjw0QSgLOOkdBw=;
        b=SyVME3P+SEiFzZ3AvU+8aRnnlE8GaFceuU6mJHmC4JwLvm1+UdFBUsIwibz2OEVtXX
         OozUh0/orlKWHUurREk0ssL/JoOjDspqbWwqyn4RVQBsCT5DTnJTWtE6BqT0VR8S2rBY
         Uq8erSAQYOLPTtK9bSFJv0GNLAjxGzU4IjDp5mOotCPFXEEJi9dy+Y0dIfwAT4T7zn9C
         9BsuLWdX7aAUpgEzNQwKG/530JE+TpN1Dy6ejGv5co54nlFppkw8CE4Z/2/eDPEpiyZH
         r2LdK4FvNKeDQdqm2UzqhK6hacY7Wkj2R0C9k9DEfJVgfclH+9MzVylLuMYCBMEqXn44
         39ng==
X-Gm-Message-State: AOAM5335AmEbqCAmLtimkkEGWMn2tQH9BHKPLGNqz0OZSx23i+jXWJDO
        Huhem5Beis8wSLlDqQ5WkhY=
X-Google-Smtp-Source: ABdhPJxx+kfr7LJvVYg7kHlvMbBU6w1AxQ2gB3xWNe55W7Plvvcs0rD/pTvjmIDNKgi1xS1ODqvy4Q==
X-Received: by 2002:a63:1c26:: with SMTP id c38mr17565246pgc.105.1600234298202;
        Tue, 15 Sep 2020 22:31:38 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id s3sm15388513pfe.116.2020.09.15.22.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 22:31:37 -0700 (PDT)
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
Subject: [PATCH 1/2] perf parse-event: Release cpu_map if evsel alloc failed
Date:   Wed, 16 Sep 2020 14:31:30 +0900
Message-Id: <20200916053131.1001604-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/parse-events.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 667cbca1547a..176a51698a64 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -360,8 +360,10 @@ __add_event(struct list_head *list, int *idx,
 		event_attr_init(attr);
 
 	evsel = evsel__new_idx(attr, *idx);
-	if (!evsel)
+	if (!evsel) {
+		perf_cpu_map__put(cpus);
 		return NULL;
+	}
 
 	(*idx)++;
 	evsel->core.cpus   = perf_cpu_map__get(cpus);
-- 
2.28.0.618.gf4bc123cb7-goog

