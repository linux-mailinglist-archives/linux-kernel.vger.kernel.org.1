Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 506972ACFC9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 07:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730737AbgKJGf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 01:35:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgKJGfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 01:35:55 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D086C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 22:35:55 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id e7so10468013pfn.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 22:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=sWUl8u7QEI6VPcaL5pYek3MNAlwgRsVcCQwCQEQ/ZUI=;
        b=FR/etF/TIdYTvNeBcd8e89+Of0RWMLL8gQ6Q0O5Y4/adbQ3OKuq2XerLa1MooZdvi2
         WkWh+/mwboXxyN3C6X/oSVdNEBqQJfkZtLgWiKNV8Yy1YHJRsF19SfSHQj81a2IHwWiV
         8pIZuwB+NPFS4EX7mgEvmyOaIDQ0kYm3CWRlM5INvuXtYFeUFKxKX8aU0iJvPkvJI8+1
         gS69YaeDZoMnzJe58Eea2/CaU5+HdcTbS6WDRbWeTMzyEKz9TrIZ5ipWXnPcLwitDd2N
         iATFpQBoo/gJwDzZvzg1V8n5woN9fYCB2GqZLqksNdE851jlCyVYm4RNaOvdTHOGfAYH
         wYgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sWUl8u7QEI6VPcaL5pYek3MNAlwgRsVcCQwCQEQ/ZUI=;
        b=Mnefrx2RspSueAfnJNUPrtEx8lY0NK4/2PCFe0Q8u9xUuT3GmbUq4oyeIF+U/Eou0Z
         IHrXLsxiriKCqbbMRfDj6xgAjmHBCPyJ47TOcRsdH4tO0yo0FcJn80XScDQYgPnjKCRm
         tLzl4an3l0wXXX4Nx6skAU2Nni194JHsLcZsYPdjl4JNTbxx+xTnvevG0ZnnvFWH1OMd
         eYxaIoozc5oMq7Cgo29SiwrfCC1EAHIk+mbb6d6tCFj7ISyWQB1EGnGFThGlbzdlqcFT
         oulN1Ml1NkvI/HAGTUXu91i5uPMkT9luuDoI1rPt5UKncG4U6WBkelweZS8GMQhK5QOP
         W76g==
X-Gm-Message-State: AOAM5325RP+R//SUDwPweDuovGIoCIlLRS2fa8mhF6vzG93FOjoToDMX
        E+6ZDpVZCKIRiJ2Fd5CPfDRrwg==
X-Google-Smtp-Source: ABdhPJyuf5AfqusXg/AtC/dBGLnoXUByE5pcvPcpQTkbcu1gz3h2eJEUj6s9MibGXU+XFZqwsdpWUw==
X-Received: by 2002:a63:5b63:: with SMTP id l35mr16498681pgm.70.1604990155000;
        Mon, 09 Nov 2020 22:35:55 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id d68sm13788955pfc.135.2020.11.09.22.35.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Nov 2020 22:35:54 -0800 (PST)
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
Subject: [PATCH RESEND 1/2] perf test: Fix a typo in cs-etm testing
Date:   Tue, 10 Nov 2020 14:34:16 +0800
Message-Id: <20201110063417.14467-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a typo: s/devce_name/device_name.

Fixes: fe0aed19b266 ("perf test: Introduce script for Arm CoreSight testing")
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---

Resend patches for adding "Fixes" tags.

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

