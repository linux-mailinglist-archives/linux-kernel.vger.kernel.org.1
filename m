Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 528D52ACF96
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 07:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730803AbgKJGXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 01:23:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730398AbgKJGXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 01:23:30 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1204CC0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 22:23:29 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id e21so9267117pgr.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 22:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y1x0mATAfMh0RgOZpG1Vhgavz1aahfCajrpAeC6qJxM=;
        b=l4OBvo/A+6U/Ibi4nNicHUWvlD3zzTlsyr/vEp59ySOYlxafdsQu/sWAKDVfQwwncb
         UQRc6gE9L0tHad1dICQAwkOTBqHnDr96vDIfYRHQSAW4dgRTNAlWBmaqfymva8ww/UfU
         R0xrMfqKQj50EGx2CBaDnNwrYFEGDrPrPnYvJInWBIVAdshpn+JwKeVVcj6LjWByzSoQ
         aVnRfTkug55BvXJJo6dRcI1Sa2DG74KdkOU67pwLhU4cgkTsN/qxCtX01zlDjyckWZFC
         EGt4n+4BF0woKUQTA7KyrnEaGXa02gx/mLbWsdFXb3Ee09M6CqkZZI4hcEfRq6U9A0J6
         u5MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y1x0mATAfMh0RgOZpG1Vhgavz1aahfCajrpAeC6qJxM=;
        b=rxQwO0g0bz+26KXkyN4xfhilhokqMp4CbZ/XPXhs+SoEyASlx012OG5qvWjEthBUbD
         5DLH8Mg9kEw49K1oy9/yYS60f33ea0mdsEudqLKfOxZp7Kn8UP5ICldbcLxaVZRwGSQ8
         OYNjX5mu4zGL1KUlJ+oc78R/RPjxAvMPkHhQxwgF+rhZg3JIMp8aaMNcifcH/m077Jvw
         fGgtc0/psWD6+GoLlYxituq8v2/U6b+unGSlTGhVWPxrDrGXhknVuHAx5/n7TrC19Kq9
         YFU4BKWG+qFX9SLllo2zYSKFsoH2z3tRYlz1D499NngSQZ2Zwn35Qm2hZNRvCoUXk5Eg
         R4Ww==
X-Gm-Message-State: AOAM530NdAHuDgOszdyObPopvaJ9MfiSsJSYOm5nJokaq/m5O6WFlF5D
        5BB3T28uL7DRHq8NcZ5cSZgdwg==
X-Google-Smtp-Source: ABdhPJwWK1PE8rV7dFkPxg3cX1XyWcP8/iVIt/Wk1l9paRrGs4xeOTXhnvdcNAP22brg+FKbX5q3Og==
X-Received: by 2002:a63:e241:: with SMTP id y1mr16251616pgj.264.1604989406158;
        Mon, 09 Nov 2020 22:23:26 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id p15sm1569330pjv.44.2020.11.09.22.23.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Nov 2020 22:23:25 -0800 (PST)
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
        linux-kernel@vger.kernel.org,
        Coresight ML <coresight@lists.linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH 2/2] perf test: Update branch sample parttern for cs-etm
Date:   Tue, 10 Nov 2020 14:23:12 +0800
Message-Id: <20201110062312.11908-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201110062312.11908-1-leo.yan@linaro.org>
References: <20201110062312.11908-1-leo.yan@linaro.org>
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

