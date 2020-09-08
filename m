Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF132260CBD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 09:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729966AbgIHH6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 03:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729964AbgIHH54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 03:57:56 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34661C061798
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 00:57:55 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x123so161096pfc.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 00:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YZg1jgAyMAGcUdolyBPogn5Fs274mLtu0TxITODgyQk=;
        b=X0sh0hRgOfNg6g6Xs/xBHAHfJOKoFUGTKrA8N/PRUCbDA5OGQYT9QFu9MczM7BHeYW
         dKetHdiNtPV55KRI7+iG12BJLSvyS77vmoF/tlfBjw65+nRwP97HVgffaKfv5pdr3PoP
         YzRxeqAD20aA0ip3uUtYxRamNQmTgTw6oCl3DEDb/1qT/MA3dpoysDDlRnj8zOUzETbt
         Ihn2+zKFhOlK6RGx48GQuqZXXkaq8lT/Sqws01yFY/f8tMxUy+FFCub+ryjdOR39P0oQ
         jhqfDbeM9ob1v9CBWfDSQ6K1HvZoINDQd24uvOzGtS0naRDkEnPFuUw2frp4VncmuA0F
         /4yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YZg1jgAyMAGcUdolyBPogn5Fs274mLtu0TxITODgyQk=;
        b=rjBWnDajdt4inWlXhjIoLv+umG4QOYMMO/XzQ5UOjY5bVdCnVQ9ZSnZOhJP2YR/73E
         0oP9rrLWlGsLj4NnBLkGYMogwzOfXd4pifgj7nqO9nffx8F9sm7/E1PDA2r+P9KXrGl+
         oJShdEwBxvjCvhgYmUroBiCWJ0O6si+RQ3xkIQF0pTEqDC6cPwrrvxTCy07jP9/zqUdh
         Zlcqqnsm5w7I7e2okGSWH56s64pOtfsJDp34RnyoMVBLTklOpVCqptkR2ryV3egYhszm
         1wsLyZgshEvDosu1pMaAsvgW2oBMWGdYoJZksyhNgwtPhvXQAO9nd/LFctE+YhqsyfWL
         +6+A==
X-Gm-Message-State: AOAM533anDuleeAHdz6BsM0EG8ASP05U8aaDfIPI+E2yVfUkC8bFzaaq
        BzpewKny8Fb81dilXwwQDi1M
X-Google-Smtp-Source: ABdhPJzDpHdcubpXgfdewiKO7WW8WbmfYSSgPQIYuc63xX5GYQC3Nvkd146IpnByx3u5Kopy5Tgpog==
X-Received: by 2002:aa7:9ab0:0:b029:13c:1611:66bb with SMTP id x16-20020aa79ab00000b029013c161166bbmr21708900pfi.6.1599551874706;
        Tue, 08 Sep 2020 00:57:54 -0700 (PDT)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.googlemail.com with ESMTPSA id m21sm7560154pfo.13.2020.09.08.00.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 00:57:54 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org, robh+dt@kernel.org,
        agross@kernel.org, bjorn.andersson@linaro.org
Cc:     amitk@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dmitry.baryshkov@linaro.org,
        tdas@codeaurora.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 6/7] cpufreq: qcom-hw: Add cpufreq support for SM8250 SoC
Date:   Tue,  8 Sep 2020 13:27:15 +0530
Message-Id: <20200908075716.30357-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200908075716.30357-1-manivannan.sadhasivam@linaro.org>
References: <20200908075716.30357-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SM8250 SoC uses EPSS block for carrying out the cpufreq duties. Hence, add
support for it in the driver with relevant of_match data.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index de816bcafd33..c3c397cc3dc6 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -285,8 +285,17 @@ static const struct qcom_cpufreq_soc_data qcom_soc_data = {
 	.lut_row_size = 32,
 };
 
+static const struct qcom_cpufreq_soc_data sm8250_soc_data = {
+	.reg_enable = 0x0,
+	.reg_freq_lut = 0x100,
+	.reg_volt_lut = 0x200,
+	.reg_perf_state = 0x320,
+	.lut_row_size = 4,
+};
+
 static const struct of_device_id qcom_cpufreq_hw_match[] = {
 	{ .compatible = "qcom,cpufreq-hw", .data = &qcom_soc_data },
+	{ .compatible = "qcom,sm8250-epss", .data = &sm8250_soc_data },
 	{}
 };
 MODULE_DEVICE_TABLE(of, qcom_cpufreq_hw_match);
-- 
2.17.1

