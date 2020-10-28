Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBA829D943
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389596AbgJ1WuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733102AbgJ1WuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:50:20 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D147C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:50:20 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id f4so473895vsk.7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JyFZVHFIwsjOtixIaapn2aRITWuLE/SXcWB3HZmeB+0=;
        b=dNUbNC/LibEu/12wPT3wLQU4l253e8d+dRSGFzAgepLVz/D5GuI1DSvndlT3yHGkh/
         n9+ZaU9FWtxAMEovNiQyvNjOw2fQnsU3Tp+b7GBMRih5wh7uwhZSyUe3wriz6tyb7Gik
         FiDUGYvYX2rQgZWfceLTcwf5KMTwqo9Fjmw+RShuPnR1bEjmqI1peMLZzz4437Fv22Hi
         cf/UhI0D6/58RNrUmbJEIfmda/rzatEu/CqjGkFOGakPmmh3NCA36I2t1vb4cRXus6X1
         jUW8fgoCzhN6wQsbXVe8BTc3sabKsphjtqoaKDcmH4MrSlwHFhe0xZz0IyeHZrNvGbqd
         R9Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JyFZVHFIwsjOtixIaapn2aRITWuLE/SXcWB3HZmeB+0=;
        b=Y3BQYZGTiZeDUIdiN68eS8GNnj4DlW6h4HQzk49DRisvrFm/ypaTFDlJX4sAGOsQRj
         CW4CgVYjW+feL3ol7iHcuRmBHgvnwUqARhhoR+eXdspkO2RBSAEadXyAgVA2zkVrbSYT
         LtJfGSJWliZAOKqrMWk15dhKicHQjfK3xkpyj5YnaTr1PmGxoZlqhkcJZbNgpOsd5CwZ
         aI65dRj1FScmxyrV6ArH4uRzysGFMDyHtX376ATL/ctxeM+TMI4J8a8pkVLcFAUGScMu
         Ux3iV8py7DnrqWTF2MxmrSUYdNnLBCgAjePwMnW/b9OEj/+/O0Q1itFE1m61EDdcCVpx
         y4PQ==
X-Gm-Message-State: AOAM533ydwwDiIc5+872gf5XXzS1Sm44v2zs8UUePQJxLO+cBBS10vL+
        jmSV7JB4IxAJhj1b+xW4ixOA8rkBmKnKug==
X-Google-Smtp-Source: ABdhPJw9o+T8NOHuEU0meW9VqJXv9khxbpcKHSACWUuhDGD0CmCqrdlnFV6/Aj92ZaPA5qk1PTbUnA==
X-Received: by 2002:a17:902:864b:b029:d3:ce46:2829 with SMTP id y11-20020a170902864bb02900d3ce462829mr6558463plt.16.1603867574125;
        Tue, 27 Oct 2020 23:46:14 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id lk13sm3526294pjb.43.2020.10.27.23.46.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2020 23:46:13 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V1 resend] qcom-geni-se: remove has_opp_table
Date:   Wed, 28 Oct 2020 12:16:10 +0530
Message-Id: <08ec1ee1d4252a266956abb5f1e0e0026d753564.1603867487.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

has_opp_table isn't used anymore, remove it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

---
 include/linux/qcom-geni-se.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/qcom-geni-se.h b/include/linux/qcom-geni-se.h
index f7bbea3f09ca..ec2ad4b0fe14 100644
--- a/include/linux/qcom-geni-se.h
+++ b/include/linux/qcom-geni-se.h
@@ -48,7 +48,6 @@ struct geni_icc_path {
  * @clk_perf_tbl:	Table of clock frequency input to serial engine clock
  * @icc_paths:		Array of ICC paths for SE
  * @opp_table:		Pointer to the OPP table
- * @has_opp_table:	Specifies if the SE has an OPP table
  */
 struct geni_se {
 	void __iomem *base;
@@ -59,7 +58,6 @@ struct geni_se {
 	unsigned long *clk_perf_tbl;
 	struct geni_icc_path icc_paths[3];
 	struct opp_table *opp_table;
-	bool has_opp_table;
 };
 
 /* Common SE registers */
-- 
2.25.0.rc1.19.g042ed3e048af

