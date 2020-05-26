Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0E4D1C747E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 17:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729969AbgEFPZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 11:25:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:44374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729455AbgEFPZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:25:06 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26057215A4;
        Wed,  6 May 2020 15:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588778705;
        bh=L2ExiaFaaJ7NWX2ZeWy30+rPSKc5qvFJX+4HTwcNHAk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sBwkKPsqo2ezpXRLVukNGNcdKjcTLfUX9AuVGhhZocvNQ3Bp1POS5hdesfGBN5cSx
         S+nQBr2ZYBunUnemKuWJFiTJWUSEBFCL7MHriR4EQfbCefLeRExNa6EPtgDgyksIgl
         47U1c9pgcb77sp3V9zOUrVyfwDtSog64kjCL5o5o=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Andi Kleen <ak@linux.intel.com>,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 38/91] perf tools: Simplify checking if SMT is active.
Date:   Wed,  6 May 2020 12:21:41 -0300
Message-Id: <20200506152234.21977-39-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

SMT now could be disabled via "/sys/devices/system/cpu/smt/control".

Status is shown in "/sys/devices/system/cpu/smt/active" simply as "0" / "1".

If this knob isn't here then fallback to checking topology as before.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/158817741394.748034.9273604089138009552.stgit@buzz
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/smt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/util/smt.c b/tools/perf/util/smt.c
index 8481842e9edb..20bacd5972ad 100644
--- a/tools/perf/util/smt.c
+++ b/tools/perf/util/smt.c
@@ -15,6 +15,9 @@ int smt_on(void)
 	if (cached)
 		return cached_result;
 
+	if (sysfs__read_int("devices/system/cpu/smt/active", &cached_result) > 0)
+		goto done;
+
 	ncpu = sysconf(_SC_NPROCESSORS_CONF);
 	for (cpu = 0; cpu < ncpu; cpu++) {
 		unsigned long long siblings;
@@ -42,6 +45,7 @@ int smt_on(void)
 	}
 	if (!cached) {
 		cached_result = 0;
+done:
 		cached = true;
 	}
 	return cached_result;
-- 
2.21.1

