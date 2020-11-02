Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70D742A2C3C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 15:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725833AbgKBOCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 09:02:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgKBOCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 09:02:36 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47061C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 06:02:35 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id r10so10839574pgb.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 06:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aBAGrZOQHDRkPzaH2DKZkHGsPIvny1yf8Z0u84M7i3w=;
        b=a3B+1OEmk/d4pnLG1eRR8/Ii4VXE3m9sSn9f5PBETAC8ob7Z6AGo5NiVUSZnHFvffZ
         bNvMC6zQmr64l2hgld3RiqToo5z+2hPUX2+ieFH/lvGuXV8CVp04mWetjSO9B34yeHCB
         DBgBylvCCUQEICc/PEfFJeygWSveDOqSixictEEz/jkehDmfQ+kjAcM9saSXUM7HyQDA
         3V5kaYZqB2BLDFfT95U1ZYgnnwFCOZH92B97eVDx86zwI2u2lYOA9XV/UpNqjgu83c1v
         +QZflzx1qGAaPyZsJU6rCbYPKsN8F+sHV092dFV89NUKnp05nc8K+xezmfiVaYXKiMDB
         ATjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=aBAGrZOQHDRkPzaH2DKZkHGsPIvny1yf8Z0u84M7i3w=;
        b=eLoksomzdsUp+lrvO2aNibyazo1ofk8ky/T5X3xvh/wEgJbBHDF4ODsF4hzDj0xPBY
         98+uxi5zBfJ9rLo0OSY7DExUe+VBqdSlHgUuslTC0GIrXB6c7OPSnQwW4D3V2Jtjc0vl
         87/Mj0n6bSwSOTMv4OzdlVftCkEK0pJztAiahn544Y4XdxGASGaz5XJCiTGMcbUAp23+
         cGkZ4+QWIZb9HOZkezvEvxLJ+4P4awsqcrq9XaKnlRhJV6UmB3Sr6kb9y8Zb6OqHmCJE
         QYdfRmUSvaumTMITa32i2Fg//bWTz1cyBQoXNyp26nBJCZE9ZNaMK+D4kvqyo5Zvn/5R
         ciDw==
X-Gm-Message-State: AOAM532os4UQF/xXL4fs4XV5hzdVISh7QxFMD1b+wTjOFQuL5RUxNE8p
        tAmO9+SabB9df8Opp4AoC18=
X-Google-Smtp-Source: ABdhPJzy3oseuwQ0F9xOe0W/RC/VVfti3Z4gME2LZQcG9FJ32n+YSDxGOf8shHy8jVzM/HkTaEz5Tw==
X-Received: by 2002:a62:1b58:0:b029:18a:df98:24fa with SMTP id b85-20020a621b580000b029018adf9824famr6838299pfb.25.1604325754853;
        Mon, 02 Nov 2020 06:02:34 -0800 (PST)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id a2sm14042600pfo.11.2020.11.02.06.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 06:02:34 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH] perf tools: Add missing swap for cgroup events
Date:   Mon,  2 Nov 2020 23:02:28 +0900
Message-Id: <20201102140228.303657-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was missed to add a swap function for PERF_RECORD_CGROUP.

Fixes: ba78c1c5461c ("perf tools: Basic support for CGROUP event")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/session.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 7a5f03764702..c44c8e8c09c6 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -710,6 +710,18 @@ static void perf_event__namespaces_swap(union perf_event *event,
 		swap_sample_id_all(event, &event->namespaces.link_info[i]);
 }
 
+static void perf_event__cgroup_swap(union perf_event *event, bool sample_id_all)
+{
+	event->cgroup.id = bswap_64(event->cgroup.id);
+
+	if (sample_id_all) {
+		void *data = &event->cgroup.path;
+
+		data += PERF_ALIGN(strlen(data) + 1, sizeof(u64));
+		swap_sample_id_all(event, data);
+	}
+}
+
 static u8 revbyte(u8 b)
 {
 	int rev = (b >> 4) | ((b & 0xf) << 4);
@@ -952,6 +964,7 @@ static perf_event__swap_op perf_event__swap_ops[] = {
 	[PERF_RECORD_SWITCH]		  = perf_event__switch_swap,
 	[PERF_RECORD_SWITCH_CPU_WIDE]	  = perf_event__switch_swap,
 	[PERF_RECORD_NAMESPACES]	  = perf_event__namespaces_swap,
+	[PERF_RECORD_CGROUP]		  = perf_event__cgroup_swap,
 	[PERF_RECORD_TEXT_POKE]		  = perf_event__text_poke_swap,
 	[PERF_RECORD_HEADER_ATTR]	  = perf_event__hdr_attr_swap,
 	[PERF_RECORD_HEADER_EVENT_TYPE]	  = perf_event__event_type_swap,
-- 
2.29.1.341.ge80a0c044ae-goog

