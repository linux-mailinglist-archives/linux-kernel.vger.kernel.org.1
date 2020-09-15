Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1169726ACBB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 20:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbgIOS6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 14:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727716AbgIORXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 13:23:08 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8170CC061A10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 10:11:03 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id u3so116493pjr.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 10:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t80Xhl4ieaw4+4IDm2zgbCHUZGC+GFKM1u8bh3yil+k=;
        b=HBRJnVE076xMyH+ZPFgWRMAbcqDlTLK3EKzvCzclTmiXZIsarEPBo/u/uCe/t2unaU
         +BcFA1lMaJFc8LCsxwJ++J97q50ygi3uKm/L+OU/VkT2H0UXmbrVZpqyTTG13qlpgsPU
         B1lUmGtcBzplMcrAwISvhhJpdamnXDblC94hw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t80Xhl4ieaw4+4IDm2zgbCHUZGC+GFKM1u8bh3yil+k=;
        b=tobJJTBk01quNh6ZyEqmjIY+VGYjsnRF0AH5PcpzTtuTuDe1yoEY/7kq5NpR1yXlsS
         LscM/5SbKY4HDc3TIz+MyDBWezF2YAIY/b9NC8VvgIZElF0Mwh6yjXzt1Pkm5Psc7N/E
         VRQNCyhhichtVNXLytO6kh4O9HEAHU0hfCO8daEPzdkoP0Fd5tYRYC+V9K1rMc4j2A6N
         qECFeUEcdcYiVDRG+szhvb2F8XOEKWAOgYnq1jEBkBua+vz/Srfr296NSpznjNYpArbi
         OBfSqSAPbN0Zb21n2OhaGOK/Fz2DOa+HMiuuJQrsADu0EHH5wDZ5mIoZQMSBiV78nCM8
         lBPg==
X-Gm-Message-State: AOAM530KoDBdfrSx5XFoFYH46na7kzEHDDpLs53BX3YJu5yxlPwQn+SN
        EHvTOaoQ5TJRS89p1zXWOYifNA==
X-Google-Smtp-Source: ABdhPJyOY9aSbKit2ivdA6JFIddmNJ8Von035R3JQswaFSKsJXehrc6lpg8VraygWmsTae8nE81gNA==
X-Received: by 2002:a17:90a:b702:: with SMTP id l2mr363925pjr.82.1600189863016;
        Tue, 15 Sep 2020 10:11:03 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id a20sm13834008pfa.59.2020.09.15.10.11.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2020 10:11:02 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] cpufreq: qcom: Don't add frequencies without an OPP
Date:   Tue, 15 Sep 2020 10:10:54 -0700
Message-Id: <20200915101007.1.Iebcd373535de8eb0aa304ad22b062a5bbc88a665@changeid>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver currently adds all frequencies from the hardware LUT to
the cpufreq table, regardless of whether the corresponding OPP
exists. This prevents devices from disabling certain OPPs through
the device tree and can result in CPU frequencies for which the
interconnect bandwidth can't be adjusted. Only add frequencies
with an OPP entry.

Fixes: 55538fbc79e9 ("cpufreq: qcom: Read voltage LUT and populate OPP")
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

 drivers/cpufreq/qcom-cpufreq-hw.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 3fb044b907a8..47b7d394d2ab 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -177,10 +177,15 @@ static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
 			freq = cpu_hw_rate / 1000;
 
 		if (freq != prev_freq && core_count != LUT_TURBO_IND) {
-			table[i].frequency = freq;
-			qcom_cpufreq_update_opp(cpu_dev, freq, volt);
-			dev_dbg(cpu_dev, "index=%d freq=%d, core_count %d\n", i,
+			if (!qcom_cpufreq_update_opp(cpu_dev, freq, volt)) {
+				table[i].frequency = freq;
+				dev_dbg(cpu_dev, "index=%d freq=%d, core_count %d\n", i,
 				freq, core_count);
+			} else {
+				dev_warn(cpu_dev, "failed to update OPP for freq=%d\n", freq);
+				table[i].frequency = CPUFREQ_ENTRY_INVALID;
+			}
+
 		} else if (core_count == LUT_TURBO_IND) {
 			table[i].frequency = CPUFREQ_ENTRY_INVALID;
 		}
@@ -197,9 +202,13 @@ static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
 			 * as the boost frequency
 			 */
 			if (prev->frequency == CPUFREQ_ENTRY_INVALID) {
-				prev->frequency = prev_freq;
-				prev->flags = CPUFREQ_BOOST_FREQ;
-				qcom_cpufreq_update_opp(cpu_dev, prev_freq, volt);
+				if (!qcom_cpufreq_update_opp(cpu_dev, prev_freq, volt)) {
+					prev->frequency = prev_freq;
+					prev->flags = CPUFREQ_BOOST_FREQ;
+				} else {
+					dev_warn(cpu_dev, "failed to update OPP for freq=%d\n",
+						 freq);
+				}
 			}
 
 			break;
-- 
2.28.0.618.gf4bc123cb7-goog

