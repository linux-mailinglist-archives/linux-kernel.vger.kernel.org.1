Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1008E2EFD18
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 03:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbhAICS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 21:18:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbhAICS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 21:18:27 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4E8C061573
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 18:17:41 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id q20so4131466pfu.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 18:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fxGKprgKgOx9Z6r09iAmrSZAnCZQKpzUHy/O5VAkXuM=;
        b=h7xb8/qJClsw5eB3/RmP3DlgKb3S7IQEvbIXrz8P6ZKFVZoS0Ffg8LtG9b8y07fwki
         meYlXflxj94ixizvoMb4q099nKJ7yBA9E+77+JLFlu2LstXxsk4H3rrdW0EvRPCHiMaP
         sj9xMIGCUoq0Erg78LIZRHKFouXK8CX2HlEKDDN5MHmeRgYPH6w5PtJqVpEyDojUab7F
         e9+8zKjJWPMqZNkwPXZJB+LbBaoXKjx3F7VMzs+d5HwdsOeUTpqptzJL6ojteQ5kdi6q
         5Dhbq8XStYmtx7hH7RtaGEQmZ5FE85bXrxV4TNVjIXEW83NviIyILFTxQmuzzpufffll
         7viA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fxGKprgKgOx9Z6r09iAmrSZAnCZQKpzUHy/O5VAkXuM=;
        b=dY7okolr9Mh1ELuATUgLBXDLxfuDh2MXTurPfqwjjMOBQ1iLtuW6m9lef0LW8eT4kD
         HE1VUIU+vAZbFXzX6zFtSAnlG9kr9AM47INLooLK0jYkCzFB0MYS9liKy97Hqx6FHFZ/
         uMq20JUGgOS0HG9lzVbymov04qtWmm4JnYjC92gHIZzeiWMWSNVagoZV1Es2NbUctzN3
         BjCY3T097uMCd/1NK4C+NV3nI/QHujFKloJG3r40SGnKkGDIy6wlOdIP60aWrdecLFaN
         L0euhvJmB3Sc46dcKjL0zMnfljBiKOdTs027QA78n0v4TtlejHScrb6vKhNt6QBlfZ8O
         Ku8Q==
X-Gm-Message-State: AOAM532oyoKh/oRLwTOZ28lUWJC4zNkrTuI5+DslinrXRVKxyARL78Te
        aKqHEk07ljkbWHlvH6Ruluo=
X-Google-Smtp-Source: ABdhPJyKfMztVofE3veYwqtoNIpJ3NiIcaVdPwfnUEwLc4gHP+ESYRb1li2X0nPZLPqkcBC3dY8EIw==
X-Received: by 2002:a63:ce4d:: with SMTP id r13mr9726349pgi.204.1610158660856;
        Fri, 08 Jan 2021 18:17:40 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC.domain.name ([122.171.171.27])
        by smtp.gmail.com with ESMTPSA id d2sm6018386pjd.29.2021.01.08.18.17.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jan 2021 18:17:40 -0800 (PST)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>
Subject: [PATCH] perf/core: Mark perf_pmu_snapshot_aux() as static
Date:   Sat,  9 Jan 2021 07:47:42 +0530
Message-Id: <1610158662-3926-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel test robot throws below warning ->

 kernel/events/core.c:6535:6: warning: no previous prototype for
'perf_pmu_snapshot_aux' [-Wmissing-prototypes]
    6535 | long perf_pmu_snapshot_aux(struct perf_buffer *rb,
         |      ^~~~~~~~~~~~~~~~~~~~~
Marking perf_pmu_snapshot_aux() as static as it is not used outside
this file.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 55d1879..a4ba6fd 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6532,7 +6532,7 @@ static unsigned long perf_prepare_sample_aux(struct perf_event *event,
 	return data->aux_size;
 }
 
-long perf_pmu_snapshot_aux(struct perf_buffer *rb,
+static long perf_pmu_snapshot_aux(struct perf_buffer *rb,
 			   struct perf_event *event,
 			   struct perf_output_handle *handle,
 			   unsigned long size)
-- 
1.9.1

