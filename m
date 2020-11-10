Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF7CD2ACF95
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 07:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730599AbgKJGXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 01:23:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730398AbgKJGXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 01:23:22 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0BBCC0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 22:23:22 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id e21so9266971pgr.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 22:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=znmZiWbMWfxgp4V+yaBZa2YAzEMMFVRQQRFNhmpIgUk=;
        b=Rh4lZ+k/ylDbzeibe+YfsynuKvEbS+wAdZQXj03HO/g6rg6xqZMnPHMq7UzHSnupZd
         Y0AGoRHa8x4fE7kWAnWrsr4K+MVY4+47WcPeyhwuTkkszKshBFX/i/0iMnsCtL8qlH4y
         5GQ+l7pNLlABBARJDiKCF6JaNaKpS2ZQfnSKrxoTffh+W5OH8ltQsRHNi6kGrUUAYrrk
         oJIogFB76WXeeiJJifBFqHS98iaVVWFVWeMxgcV8BM4BXJi3rrInb2XhEydG8npSBwL1
         +3pGrai/Lb4yH7wePjrAuiTqZlcL2krRjGudsAZdMOSu1u4wB5LDbItIclE9zw2Te8K5
         wdWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=znmZiWbMWfxgp4V+yaBZa2YAzEMMFVRQQRFNhmpIgUk=;
        b=VrTzPHeX1OqGdVQIpDlWuKNB0/4dQZbX8RzJPu2Xzq3ycKwsS5U2X3MYOgST7wYSw0
         q6G3+4Hs00EG8fUTc9SioIeYcfWPtn3xZYMnqS2L0TwRCwLlpJyik2Vu0nH/gxTeRlPK
         YJKy3R4M2q0i6qRa/NcpC04HQzsM/Ne7NlF8Vpg5FfwYH4384f1dbI32Kj7o1aZl48ku
         liJEImjkM8sn6xKjSntA71WO9BtzJqEt/VvNHru6VR+U6f84lOxq8Ams9ffiPcQ+F9XY
         96U7KJIVX6Dlr8u1QPIs16aasA7MJhjOvF8dBXfBek/WRO+1gRdjfYc2qlnwv2sAqdyM
         9frA==
X-Gm-Message-State: AOAM531aj31fXZEhQ8DPRgLgSbKesuC0rQK76/bwnldCjbn+65tSaMzp
        3/IPkTUXpGhvYw/1OFecIFrnGw==
X-Google-Smtp-Source: ABdhPJxILlTgovqHjRqDFkERGXiLfUVsL2ctWZH0q3Ri17A4ihHLLarEFRbl4LhfGOR2PmVbjaggzg==
X-Received: by 2002:aa7:8154:0:b029:156:4b89:8072 with SMTP id d20-20020aa781540000b02901564b898072mr14193207pfn.51.1604989402244;
        Mon, 09 Nov 2020 22:23:22 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id s23sm11783189pgl.47.2020.11.09.22.23.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Nov 2020 22:23:21 -0800 (PST)
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
Subject: [PATCH 1/2] perf test: Fix a typo in cs-etm testing
Date:   Tue, 10 Nov 2020 14:23:11 +0800
Message-Id: <20201110062312.11908-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a typo: s/devce_name/device_name.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/tests/shell/test_arm_coresight.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/test_arm_coresight.sh b/tools/perf/tests/shell/test_arm_coresight.sh
index 8d84fdbed6a6..59d847d4981d 100755
--- a/tools/perf/tests/shell/test_arm_coresight.sh
+++ b/tools/perf/tests/shell/test_arm_coresight.sh
@@ -105,7 +105,7 @@ arm_cs_iterate_devices() {
 		#     `> device_name = 'tmc_etf0'
 		device_name=$(basename $path)
 
-		if is_device_sink $path $devce_name; then
+		if is_device_sink $path $device_name; then
 
 			record_touch_file $device_name $2 &&
 			perf_script_branch_samples touch &&
-- 
2.17.1

