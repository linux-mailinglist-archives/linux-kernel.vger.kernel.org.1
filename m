Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFEC92ACFCA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 07:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731115AbgKJGgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 01:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730781AbgKJGgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 01:36:00 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45795C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 22:35:59 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id t18so5990223plo.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 22:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eEoBv6uSiAkz5F0HtLjSefRpJkNN5bDWJxgtlluGna0=;
        b=ZsBX+sXhjx09+/8hUOyOBq3HY3hSVHE2N67zsU1nvjooX3dmYPqX11JHy1035RDk8s
         4XYeTAhsBDPXUBgk4NYVukaELs4iLREH8Rm41pXZrKVpKT6wlAkQtKa+bOLkOtckMl6B
         eGrOyXu/HAiBNZYYDXI6cSdyS2oXB9coXGVIFoDNlAUuBt4xukaXj+1w0lD/AyNjqfk2
         d9YtPP1YhM391BC3zR3I6cXVEVDhPM9PqZ0nSSv2y/Dyv748GMxNwIZMbSe4uuygQEMb
         bVCuq+CXKhyELW1yCSy/Q8BogsP+jBfdIfUpO+3NxwWNQEIeqOJD0UaArMp0xA1t2eyx
         N4lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eEoBv6uSiAkz5F0HtLjSefRpJkNN5bDWJxgtlluGna0=;
        b=J0ixxmL13ljzh6vNr3Y47GrBZi7XiNRznLmYLd61mlcsShCJjs17JkUg0yCGtbpALx
         QVoSSEglfNgQokIyc6O3H+vJtUESstX/OIcZNZ9pea0pjL4W9PJzh+oH0qHRixJF+EgS
         GzKSwITF3h9VqwF7H4qAlqGVKJ/GH5TE0CB+GMmWM/T9En4aSc250hgm4cUGidmP6bH4
         GYf2dhF4vZozq+Tel0sm/bNxbe3Wewpu3J9AiqhrBjU8vLvOmCCq2QEWaZ/qoE09N+lC
         gswOdnrcyWBfhdgcGQfzn8tFk4UmWcSWwS7v+5WR250hJkM1UbCNwgF4qT0zX+iGASGZ
         7rlw==
X-Gm-Message-State: AOAM533T7+UQFZp10YHD6tygPfKlPXo12kMsg0Kv9bnErh677TCilK7b
        waKbyz1jmTLeAm5qpHzQcZfnWQ==
X-Google-Smtp-Source: ABdhPJwxRCQr/gUvRc9+tVnlb2uznQiLqW8+hce/oJGmpTCMx8oOM1t/ct7VeBMi4ZR4jXRxBpCSiA==
X-Received: by 2002:a17:902:9006:b029:d6:e5d0:abfd with SMTP id a6-20020a1709029006b02900d6e5d0abfdmr15595347plp.69.1604990158827;
        Mon, 09 Nov 2020 22:35:58 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id n27sm13407445pfq.59.2020.11.09.22.35.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Nov 2020 22:35:58 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Coresight ML <coresight@lists.linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH RESEND 2/2] perf test: Update branch sample parttern for cs-etm
Date:   Tue, 10 Nov 2020 14:34:17 +0800
Message-Id: <20201110063417.14467-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201110063417.14467-1-leo.yan@linaro.org>
References: <20201110063417.14467-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the commit 943b69ac1884 ("perf parse-events: Set exclude_guest=1
for user-space counting"), 'exclude_guest=1' is set for user-space
counting; and the branch sample's modifier has been altered, the sample
event name has been changed from "branches:u:" to "branches:uH:", which
gives out info for "user-space and host counting".

But the cs-etm testing's regular expression cannot match the updated
branch sample event and leads to test failure.

This patch updates the branch sample parttern by using a more flexible
expression '.*' to match branch sample's modifiers, so that allows the
testing to work as expected.

Fixes: 943b69ac1884 ("perf parse-events: Set exclude_guest=1 for user-space counting")
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/tests/shell/test_arm_coresight.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/test_arm_coresight.sh b/tools/perf/tests/shell/test_arm_coresight.sh
index 59d847d4981d..18fde2f179cd 100755
--- a/tools/perf/tests/shell/test_arm_coresight.sh
+++ b/tools/perf/tests/shell/test_arm_coresight.sh
@@ -44,7 +44,7 @@ perf_script_branch_samples() {
 	#   touch  6512          1         branches:u:      ffffb22082e0 strcmp+0xa0 (/lib/aarch64-linux-gnu/ld-2.27.so)
 	#   touch  6512          1         branches:u:      ffffb2208320 strcmp+0xe0 (/lib/aarch64-linux-gnu/ld-2.27.so)
 	perf script -F,-time -i ${perfdata} | \
-		egrep " +$1 +[0-9]+ .* +branches:([u|k]:)? +"
+		egrep " +$1 +[0-9]+ .* +branches:(.*:)? +"
 }
 
 perf_report_branch_samples() {
-- 
2.17.1

