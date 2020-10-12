Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 435F728C190
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 21:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730928AbgJLTkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 15:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728338AbgJLTkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 15:40:37 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995B1C0613D1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 12:40:36 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k18so18753204wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 12:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+EfUv/T2E3FnntdBC8S4jr9sPsz796Fi5uP55L4BrAM=;
        b=Wypqo2E4gKtll0xj4IRPBM30Ax0Kr+xLg7R7En85zXkibEo6bp5CrdFuEFuzFnTi2A
         EF/v6A6s3qMl56QhqfWx6boN1mJ8XM2IldqC53V0bJTNCuypA7N4CpeOjZidcy0QtSea
         Fg9javKOdd5G+581vabzl31nb1PJEH1cGMeyghoop9Wrp6OdaHA30T83JaKULsZHk7th
         j3A8BUpmfJy++rstbLygt3iMePhowH2YDk/LGRkmNiikFWVaeS44BJr/ffqa2sxU/sW6
         aap5swmqwZ95gd1QEvzb6CL2G6w1AXAAhKXJOp5JOIqvYMLhBDglEyXm5aGyb0wRpWR/
         p9lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+EfUv/T2E3FnntdBC8S4jr9sPsz796Fi5uP55L4BrAM=;
        b=nIQR6RYuACrMVPX/jMT5A0TI6pNVeGf1Y2p+iy7Dfx2LzDa++RvsaV74MCMcwLm+Jz
         AAlswQWHW+QEankhqix1mfzEoBru5TAjUdtHkpAV9BjvbR/cNeyZ50O9w/9g41uyUP64
         RqDcEtHs/V0MdLkCddDtSWH/025gpAlr9Jld6G6EacVfx9BqCplNpSS11XfuPdnJJnXz
         hnmiJ2wi0PARPwGNkklb0vUI2KjDkdKuUXNcCV6zGIc4poc27RyZ6s4aPDsdGuUXjtMq
         8oSb4C2N6bPqG2wTaY7sReEJbeGy+37wcoLMUZbNVj6XwvVRbp0AdxEaE6wLAfiGE/4x
         0Ekg==
X-Gm-Message-State: AOAM530ZoKtBrFLoMxJGSvpkCz+s4HWfnKeU9e5hCB12NU8w3xHAlZ+H
        hMdnVn9d4H2U1vpc2b8tQcCXJQ==
X-Google-Smtp-Source: ABdhPJwLeNcHMRSjmQ9MjHiT9XaiXa3Bt4emzJpT6lzHtPr7+Ii858iRpiy7q9HYHX8uvo178Ljx2w==
X-Received: by 2002:a1c:1dc3:: with SMTP id d186mr11622031wmd.182.1602531635141;
        Mon, 12 Oct 2020 12:40:35 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id f63sm24500203wme.38.2020.10.12.12.40.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Oct 2020 12:40:34 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     mdtipton@codeaurora.org, okukatla@codeaurora.org,
        sibis@codeaurora.org, bjorn.andersson@linaro.org,
        amit.pundir@linaro.org, georgi.djakov@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] interconnect: qcom: sdm845: Enable keepalive for the MM1 BCM
Date:   Mon, 12 Oct 2020 22:40:34 +0300
Message-Id: <20201012194034.26944-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After enabling interconect scaling for display on the db845c board,
in certain configurations the board hangs, while the following errors
are observed on the console:

  Error sending AMC RPMH requests (-110)
  qcom_rpmh TCS Busy, retrying RPMH message send: addr=0x50000
  qcom_rpmh TCS Busy, retrying RPMH message send: addr=0x50000
  qcom_rpmh TCS Busy, retrying RPMH message send: addr=0x50000
  ...

In this specific case, the above is related to one of the sequencers
being stuck, while client drivers are returning from probe and trying
to disable the currently unused clock and interconnect resources.
Generally we want to keep the multimedia NoC enabled like the rest of
the NoCs, so let's set the keepalive flag on it too.

Fixes: aae57773fbe0 ("interconnect: qcom: sdm845: Split qnodes into their respective NoCs")
Reported-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/qcom/sdm845.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
index 47556dc12ec0..5304aea3b058 100644
--- a/drivers/interconnect/qcom/sdm845.c
+++ b/drivers/interconnect/qcom/sdm845.c
@@ -151,7 +151,7 @@ DEFINE_QBCM(bcm_mc0, "MC0", true, &ebi);
 DEFINE_QBCM(bcm_sh0, "SH0", true, &qns_llcc);
 DEFINE_QBCM(bcm_mm0, "MM0", false, &qns_mem_noc_hf);
 DEFINE_QBCM(bcm_sh1, "SH1", false, &qns_apps_io);
-DEFINE_QBCM(bcm_mm1, "MM1", false, &qxm_camnoc_hf0_uncomp, &qxm_camnoc_hf1_uncomp, &qxm_camnoc_sf_uncomp, &qxm_camnoc_hf0, &qxm_camnoc_hf1, &qxm_mdp0, &qxm_mdp1);
+DEFINE_QBCM(bcm_mm1, "MM1", true, &qxm_camnoc_hf0_uncomp, &qxm_camnoc_hf1_uncomp, &qxm_camnoc_sf_uncomp, &qxm_camnoc_hf0, &qxm_camnoc_hf1, &qxm_mdp0, &qxm_mdp1);
 DEFINE_QBCM(bcm_sh2, "SH2", false, &qns_memnoc_snoc);
 DEFINE_QBCM(bcm_mm2, "MM2", false, &qns2_mem_noc);
 DEFINE_QBCM(bcm_sh3, "SH3", false, &acm_tcu);
