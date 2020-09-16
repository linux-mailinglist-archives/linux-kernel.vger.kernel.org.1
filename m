Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3CC26C9ED
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 21:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgIPTih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 15:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727371AbgIPTTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 15:19:30 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4C2C061354
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 12:17:51 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id l126so4555541pfd.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 12:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4vmHBZCLmqwGh1JrNfyEzOHsM8+Nrv3dx8TspskyRXo=;
        b=KZJOSshqj5FFzQ7czSqunHffeDNfegzos7p7XFd0SdxE2EBbpS1IWYdpTpcJn0XxQ5
         ClNb0/mXssumjBRQnZn0J9dLOQRFd/5F8t7zo2TpN+f1fYlb8lk1PbcNZwqOM5Ztk5Xx
         fed76TqxxRzzx6PmfQIoGWuypcKRpYh5cuyAX8gxwTEpXwDyFjLhNKrBtPyqqrqa3nOy
         3BJ2goSv5DwQtrv5N0k2/XdNGuivWFd2ZLHJ+aOM4mQ5lP726zDZk+W6NQXilOrsLN0v
         OD+cOR75uc9azOko6WqLYItsoa/pjRaslja7dbL0jtAFuzGJv0MlFdOGsIsUWOmuOICf
         pwOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4vmHBZCLmqwGh1JrNfyEzOHsM8+Nrv3dx8TspskyRXo=;
        b=S8BwSTTS1fW0gJWgB/WF0dVBZWL5Q4/X0URhWQoAadnLxiUbY1j9M9sIgXQ5XGR0sr
         6nb5vuQLjtX2FQgxyJShOHIwc70wcjbNmvslaVULQeodKqUuNCTm/ufL6nbdtELtY7SU
         3cFiY8IiWK4/q/eKcXyJIVDspoWRIqDt3GccDmdZ2ddqFlDE1hyp3HlrMxqTzi/+gfIV
         ApZHKQ3SOivqbHjPLhExGJeJDoUfOz0HXs/SCYN16cXatXgy5+Y6eBwRFBMjEW4QdT94
         u582AIin8V2sV/pw4FX5qaCof4TEdRUiuN8yEDrfYAbnvq+1t17N7OIo42D+x0X83xEf
         aE7Q==
X-Gm-Message-State: AOAM533jeasP5UZP40UNHQo87E3b/ZLvd2Jjqznp4QRiDGcaIkRQSuZu
        m9O0HW8dV26d+lUCgQ3bVecxZQ==
X-Google-Smtp-Source: ABdhPJwqgLEEt/Zs/+PIDGya7dvTCcQaxAtK24x78juhCiKYpfkL4WT80mdnASV/NVVQMbx8iH/JdA==
X-Received: by 2002:a63:4a43:: with SMTP id j3mr20191746pgl.42.1600283870703;
        Wed, 16 Sep 2020 12:17:50 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id b2sm11373688pfp.3.2020.09.16.12.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 12:17:50 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/16] coresight: etm4x: Handle unreachable sink in perf mode
Date:   Wed, 16 Sep 2020 13:17:31 -0600
Message-Id: <20200916191737.4001561-11-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200916191737.4001561-1-mathieu.poirier@linaro.org>
References: <20200916191737.4001561-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

If the specified/hinted sink is not reachable from a subset of the CPUs,
we could end up unable to trace the event on those CPUs. This
is the best effort we could do until we support 1:1 configurations.
Fail gracefully in such cases avoiding a WARN_ON, which can be easily
triggered by the user on certain platforms (Arm N1SDP), with the following
trace paths :

 CPU0
      \
       -- Funnel0 --> ETF0 -->
      /                        \
 CPU1                           \
                                  MainFunnel
 CPU2                           /
      \                        /
       -- Funnel1 --> ETF1 -->
      /
 CPU1

$ perf record --per-thread -e cs_etm/@ETF0/u -- <app>

could trigger the following WARNING, when the event is scheduled
on CPU2.

[10919.513250] ------------[ cut here ]------------
[10919.517861] WARNING: CPU: 2 PID: 24021 at
drivers/hwtracing/coresight/coresight-etm-perf.c:316 etm_event_start+0xf8/0x100
...

[10919.564403] CPU: 2 PID: 24021 Comm: perf Not tainted 5.8.0+ #24
[10919.570308] pstate: 80400089 (Nzcv daIf +PAN -UAO BTYPE=--)
[10919.575865] pc : etm_event_start+0xf8/0x100
[10919.580034] lr : etm_event_start+0x80/0x100
[10919.584202] sp : fffffe001932f940
[10919.587502] x29: fffffe001932f940 x28: fffffc834995f800
[10919.592799] x27: 0000000000000000 x26: fffffe0011f3ced0
[10919.598095] x25: fffffc837fce244c x24: fffffc837fce2448
[10919.603391] x23: 0000000000000002 x22: fffffc8353529c00
[10919.608688] x21: fffffc835bb31000 x20: 0000000000000000
[10919.613984] x19: fffffc837fcdcc70 x18: 0000000000000000
[10919.619281] x17: 0000000000000000 x16: 0000000000000000
[10919.624577] x15: 0000000000000000 x14: 00000000000009f8
[10919.629874] x13: 00000000000009f8 x12: 0000000000000018
[10919.635170] x11: 0000000000000000 x10: 0000000000000000
[10919.640467] x9 : fffffe00108cd168 x8 : 0000000000000000
[10919.645763] x7 : 0000000000000020 x6 : 0000000000000001
[10919.651059] x5 : 0000000000000002 x4 : 0000000000000001
[10919.656356] x3 : 0000000000000000 x2 : 0000000000000000
[10919.661652] x1 : fffffe836eb40000 x0 : 0000000000000000
[10919.666949] Call trace:
[10919.669382]  etm_event_start+0xf8/0x100
[10919.673203]  etm_event_add+0x40/0x60
[10919.676765]  event_sched_in.isra.134+0xcc/0x210
[10919.681281]  merge_sched_in+0xb0/0x2a8
[10919.685017]  visit_groups_merge.constprop.140+0x15c/0x4b8
[10919.690400]  ctx_sched_in+0x15c/0x170
[10919.694048]  perf_event_sched_in+0x6c/0xa0
[10919.698130]  ctx_resched+0x60/0xa0
[10919.701517]  perf_event_exec+0x288/0x2f0
[10919.705425]  begin_new_exec+0x4c8/0xf58
[10919.709247]  load_elf_binary+0x66c/0xf30
[10919.713155]  exec_binprm+0x15c/0x450
[10919.716716]  __do_execve_file+0x508/0x748
[10919.720711]  __arm64_sys_execve+0x40/0x50
[10919.724707]  do_el0_svc+0xf4/0x1b8
[10919.728095]  el0_sync_handler+0xf8/0x124
[10919.732003]  el0_sync+0x140/0x180

Even though we don't support using separate sinks for the ETMs yet (e.g,
for 1:1 configurations), we should at least honor the user's choice and
handle the limitations gracefully, by simply skipping the tracing on ETMs
which can't reach the requested sink.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Fixes: f9d81a657bb8 ("coresight: perf: Allow tracing on hotplugged CPUs")
Reported-by: Jeremy Linton <jeremy.linton@arm.com>
Tested-by: Jeremy Linton <jeremy.linton@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 1a3169e69bb1..9d61a71da96f 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -321,6 +321,16 @@ static void etm_event_start(struct perf_event *event, int flags)
 	if (!event_data)
 		goto fail;
 
+	/*
+	 * Check if this ETM is allowed to trace, as decided
+	 * at etm_setup_aux(). This could be due to an unreachable
+	 * sink from this ETM. We can't do much in this case if
+	 * the sink was specified or hinted to the driver. For
+	 * now, simply don't record anything on this ETM.
+	 */
+	if (!cpumask_test_cpu(cpu, &event_data->mask))
+		goto fail_end_stop;
+
 	path = etm_event_cpu_path(event_data, cpu);
 	/* We need a sink, no need to continue without one */
 	sink = coresight_get_sink(path);
-- 
2.25.1

