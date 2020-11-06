Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7C6B2A8FE5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 08:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgKFHFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 02:05:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgKFHFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 02:05:22 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667CFC0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 23:05:22 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id t22so237715plr.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 23:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qJNlvtq3Q/fhRhMrBVr0jOCxwM2F0N9xU97jImW1c4M=;
        b=b3Zpcyw1zX1H4YDcNngNslvdi+HNpuoFhkHkD8WbuJXybYNAWn2baVM+TM517h5pIv
         4C5xr5v4i/051DJ0+CGlh4jQKeHQ3mO/kpnaqNoHCMvcEtVdHgDDQji/9rGvVo6yat4H
         CTaNB3AxT2pKMd/zsusOqCFPgUiK6tWxz8E6TYX2+eXr1cR3oTGqcxFJubu8eGlloERb
         0isAsKYT2nwpZImXK8sRAAzYbJ/TjA2P2OmChl9z1OVHrGwJql2y2usKkNP3aHQYyOlQ
         TWLa7MQuUFVsv7tRSoayCma2SF0EK8qYXOEuAlfsi6txB4eQEinff3Xybstl+yBkdr+m
         gc6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qJNlvtq3Q/fhRhMrBVr0jOCxwM2F0N9xU97jImW1c4M=;
        b=EN1Jl905oEg1qdgGU4L7SakT5Hk4ykmnonqfJiFuDeM9ITTInWmrgrXGkb4ZaH6+DR
         Dpm0wQpG1lCANzWymRp0UtYHs1ITL4cp45lxZleFOyHJ50DfE6Qv1bcDhSJjupGv8H/o
         a3WOcqumwmvJBqKbO1Ex4Qn40PJKu8Ki3gS/L+ydm6aJINuWfhy+DrSyNUDiRk8Y0m7O
         gzjturgebmpR6v8sEL1PBkoyi58p+lNQ4yCDi+QglbQq9FTFdjMylvQSIbauEWsh9ZRf
         /YOrwDSHUYWJG+hHrAeOxI/FNOLsX5ktXJPRs2x5W/0Lcz7wN7vkYgvcsN8vRsJ7UQ1j
         ac0A==
X-Gm-Message-State: AOAM532YUv7A3+hiPVdkvVJN1QUCUUKuJxLSN74cWxW5weOcjW3GiZXM
        Ch3V3QtBkTnI4OrstdZBS2bXNg==
X-Google-Smtp-Source: ABdhPJxxmtFJihSCZMzO8iC+QR+Wb7imnYNUNCmRFiSUJVg8xZNbVDDfHCA7BIT46Bcy4f5K9CLgQg==
X-Received: by 2002:a17:902:7298:b029:d4:c71a:357a with SMTP id d24-20020a1709027298b02900d4c71a357amr794203pll.38.1604646321967;
        Thu, 05 Nov 2020 23:05:21 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id s9sm815857pfs.89.2020.11.05.23.05.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Nov 2020 23:05:21 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>, digetx@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] opp: Allow dev_pm_opp_put_*() APIs to accept NULL opp_table
Date:   Fri,  6 Nov 2020 12:33:21 +0530
Message-Id: <7c8e6cacc6aa09c4b3b2c4e892d91b6d4864b176.1604646059.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1604646059.git.viresh.kumar@linaro.org>
References: <cover.1604646059.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows the callers to drop the unnecessary checks.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index b24f685823ae..9d145bb99a59 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1660,6 +1660,9 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_set_supported_hw);
  */
 void dev_pm_opp_put_supported_hw(struct opp_table *opp_table)
 {
+	if (unlikely(!opp_table))
+		return;
+
 	/* Make sure there are no concurrent readers while updating opp_table */
 	WARN_ON(!list_empty(&opp_table->opp_list));
 
@@ -1716,6 +1719,9 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_set_prop_name);
  */
 void dev_pm_opp_put_prop_name(struct opp_table *opp_table)
 {
+	if (unlikely(!opp_table))
+		return;
+
 	/* Make sure there are no concurrent readers while updating opp_table */
 	WARN_ON(!list_empty(&opp_table->opp_list));
 
@@ -1844,6 +1850,9 @@ void dev_pm_opp_put_regulators(struct opp_table *opp_table)
 {
 	int i;
 
+	if (unlikely(!opp_table))
+		return;
+
 	if (!opp_table->regulators)
 		goto put_opp_table;
 
@@ -1926,6 +1935,9 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_set_clkname);
  */
 void dev_pm_opp_put_clkname(struct opp_table *opp_table)
 {
+	if (unlikely(!opp_table))
+		return;
+
 	/* Make sure there are no concurrent readers while updating opp_table */
 	WARN_ON(!list_empty(&opp_table->opp_list));
 
@@ -1981,6 +1993,9 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_register_set_opp_helper);
  */
 void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table)
 {
+	if (unlikely(!opp_table))
+		return;
+
 	/* Make sure there are no concurrent readers while updating opp_table */
 	WARN_ON(!list_empty(&opp_table->opp_list));
 
@@ -2109,6 +2124,9 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_attach_genpd);
  */
 void dev_pm_opp_detach_genpd(struct opp_table *opp_table)
 {
+	if (unlikely(!opp_table))
+		return;
+
 	/*
 	 * Acquire genpd_virt_dev_lock to make sure virt_dev isn't getting
 	 * used in parallel.
-- 
2.25.0.rc1.19.g042ed3e048af

