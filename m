Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B77728C70A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 04:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbgJMCNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 22:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728559AbgJMCNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 22:13:01 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6403FC0613D1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 19:13:01 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 144so15632700pfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 19:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=EVFofZm/KKugvT26BUHQlCq/DzVw9jPsM+MG4z5PIao=;
        b=gzN6p6EqNPIxhrpp6eIRsy8uVkY+8z5cNtT6QuS48Oy0hz8hoB2pI1FsAIiRbAmVgC
         nNGBoRG4MgINxKWhtJvc7yVPQWkrVeQAJPnkxDkJ53reUjJDV16nKCWsUYy30PkwJAKR
         ZZ7O5hJSoGb4zMsphPvnLFn8MAcnET4wFHCO8pkLAn7fv38lB01Ofi2osqKFml71hXGZ
         Kwn6/SruL+YoxBJpNypOs9F+hzOyozOYG7Qlmn3mWquSV4bTdERww1IY+G6EDJyrS4qo
         DC+tX7Yi4En00QirpM2sCNtt1U3Vtc6FmQawYe1s25gfz6hYuRlKeGimiLxjD4ToWrmx
         OoKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EVFofZm/KKugvT26BUHQlCq/DzVw9jPsM+MG4z5PIao=;
        b=pg4L46+Pkx3X9EQ0AwqYGl9sGCv1u0T8Q0KdhVfKMzZ+3rOTkitLcSNxhues+aOB1o
         c73luhiVRDrM++UWbKBbjJESZsEISgbyTVeNfzUIdpHRqxjXv53D2BFobpENggdG1dPq
         D93BDKYVs8QmBFwaoPQG6S2qabT2Q0Bi2XD811oySjEfNj9IGMP2H4PrMZIq8qGm0Fia
         9PK7Xudnt7ASBUS+FwnXePjnPBeYEeJ3uUQBr6GC/oMBmVcjzKP5YkjbnL5fy90I165P
         dpg/HYou22BDRY4m2Sp7zCg11xPywiN7MmbmT3lL1+dzD4+Cs3220rZSUt+Wb05PYAUL
         ELBQ==
X-Gm-Message-State: AOAM531q3e9u9sGIzp2oBA4M0XzNCkAZaulu8BnIZzWOsXBQWKVVBxhF
        V3SSWzv+vsD7D4ecj3dOHIA/ig==
X-Google-Smtp-Source: ABdhPJzOQXaNUKDmS2Jh3v51MTDPM5cpVtkr0wG2HSKgFdxM99feg3PaAa+ftjOgCorShzjkLkE5jg==
X-Received: by 2002:a17:90a:46c2:: with SMTP id x2mr23268518pjg.60.1602555180701;
        Mon, 12 Oct 2020 19:13:00 -0700 (PDT)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id m34sm20637530pgl.94.2020.10.12.19.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 19:12:59 -0700 (PDT)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Andy Gross <agross@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konradybcio@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH] mailbox: qcom-apcs-ipc: use PLATFORM_DEVID_AUTO to register device
Date:   Tue, 13 Oct 2020 10:12:41 +0800
Message-Id: <20201013021241.5656-1-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On MSM8916, only one qcom-apcs-msm8916-clk device is needed, as there is
only one APCS clock.  However, on MSM8939 three APCS clocks need to be
registered for cluster0 (little cores), cluster1 (big cores) and CCI
(Cache Coherent Interconnect).  That said, we will need to register 3
qcom-apcs-msm8916-clk devices.  Let's use PLATFORM_DEVID_AUTO rather
than PLATFORM_DEVID_NONE for platform_device_register_data() call.
Otherwise, the second APCS clock registration will fail due to duplicate
device name.

[    0.519657] sysfs: cannot create duplicate filename '/bus/platform/devices/qcom-apcs-msm8916-clk'
...
[    0.661158] qcom_apcs_ipc b111000.mailbox: failed to register APCS clk

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/mailbox/qcom-apcs-ipc-mailbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
index 077e5c6a9ef7..3d100a004760 100644
--- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
+++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
@@ -128,7 +128,7 @@ static int qcom_apcs_ipc_probe(struct platform_device *pdev)
 	if (apcs_data->clk_name) {
 		apcs->clk = platform_device_register_data(&pdev->dev,
 							  apcs_data->clk_name,
-							  PLATFORM_DEVID_NONE,
+							  PLATFORM_DEVID_AUTO,
 							  NULL, 0);
 		if (IS_ERR(apcs->clk))
 			dev_err(&pdev->dev, "failed to register APCS clk\n");
-- 
2.17.1

