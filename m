Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 271A52C529D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 12:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388628AbgKZLJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 06:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727498AbgKZLJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 06:09:37 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19CFC0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 03:09:35 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id 131so1343846pfb.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 03:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aohPs57IixgwMy83BIAsVgGmmsMMC4RPRh+Yr4o7DMw=;
        b=VDYblfrfdAYtbivQbd8r9dwV3Yulj9yvLMri7ShZW+UjKCg/CoMzUodjdF2R99G7v0
         bZtGbsk1ChDb44mzhSqpha77TAOllPrBZUkGQ7SC/PfVJYBgVM2gRYhQIQLQ2Cf8B3Fm
         BTvup83oL0O59r8vbG5RuujNtsi/IdyVbJ0aqF3qN4cx87KBlSLkL3NZZiiy/C7AtyxM
         VFQPps2vfqa+mlsAkRbtJ0k6bUi8e/DkjUCyqnKExYRFy7l/WQjBNDfqzkkLufbpjaHv
         htfPtPjqNHdOwML194Y+V83H1VBtA+hzyv9GBldI2puWGRUgQih7ve+nnC1sK77jIH4P
         6W3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=aohPs57IixgwMy83BIAsVgGmmsMMC4RPRh+Yr4o7DMw=;
        b=oHXtgJwYMCUlhYG80bThNkjYQl0CCfZoUNySBQkq02Iw/wKC1d8sDbfUro5aHj+3g/
         VQJ0tKggobvYK0g2cEcLrB9KgfPLUIQwFgyAGh5jbgMt64v4rFbVcchwZyYWu5OrqXCd
         +NkXhpvH3z2no2R0wbOjaiVfr+QYd4udmzfItnTIZn0LrHSh7kEUibNATvoioCSSuXxU
         mG9x4z5xE8DulOcywznja2VHeFocpmGuc1ol0z8fvVLo+lss4pyCUDuTFo/S6uspVOS7
         XYoXXd/wxULATssWi4rH0m7HfWpfjRns9q1bUmx7QW2ExokdcgZdq84yr9FIajbgvBhD
         A4DQ==
X-Gm-Message-State: AOAM530lq5BQw3HVDFQLQ4YSW8om1jIE3wGFFgV5uJR4ELEVcJLLyXv3
        6gdAstRIgjcHV+Y7jac93RU=
X-Google-Smtp-Source: ABdhPJxRRp0RUOOy86hcmqHZK46KBf1Xw8JvJ8+9LAPVA0QgLMUJVGwLogxdfiD5lEIMzd49XqDZOg==
X-Received: by 2002:a62:1c93:0:b029:198:1c0a:ea71 with SMTP id c141-20020a621c930000b02901981c0aea71mr2309663pfc.22.1606388975312;
        Thu, 26 Nov 2020 03:09:35 -0800 (PST)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id b80sm4463366pfb.40.2020.11.26.03.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 03:09:34 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Stephane Eranian <eranian@google.com>,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 2/2] perf/x86/intel: Check PEBS status correctly
Date:   Thu, 26 Nov 2020 20:09:22 +0900
Message-Id: <20201126110922.317681-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
In-Reply-To: <20201126110922.317681-1-namhyung@kernel.org>
References: <20201126110922.317681-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephane Eranian <eranian@google.com>

The kernel cannot disambiguate when 2+ PEBS counters overflow at the
same time. This is what the comment for this code suggests.  However,
I see the comparison is done with the unfiltered p->status which is a
copy of IA32_PERF_GLOBAL_STATUS at the time of the sample. This
register contains more than the PEBS counter overflow bits. It also
includes many other bits which could also be set.

Cc: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 arch/x86/events/intel/ds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 89dba588636e..485c5066f8b8 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1916,7 +1916,7 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
 		 * that caused the PEBS record. It's called collision.
 		 * If collision happened, the record will be dropped.
 		 */
-		if (p->status != (1ULL << bit)) {
+		if (pebs_status != (1ULL << bit)) {
 			for_each_set_bit(i, (unsigned long *)&pebs_status, size)
 				error[i]++;
 			continue;
-- 
2.29.2.454.gaff20da3a2-goog

