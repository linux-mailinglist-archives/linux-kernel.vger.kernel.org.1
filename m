Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6630220709
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 10:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbgGOI0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 04:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729904AbgGOI0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 04:26:50 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E0EC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 01:26:49 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a6so1487640wrm.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 01:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WdiKEUGtJNb3K8rH57Xa0bqqHuMKs85IufCe6WoIQH0=;
        b=h/tM5SidCdeT9YEPZb0RPN7LNM4OQEfUG0Gla4WTqsbW13CThG9SPV0We8E9oe7eKW
         y2PuLeXzK9008gi1pAyFmaKBkBvo+0EWGPrnbrzZAy1uJxsvdLwLtevQ30Cwl7ocp8t9
         x8sysDZkNQexAapYEh0MZvEOg0v2i0PIGOBb9hBxkdWOboI8mKwgyM8vTXy4oFwM0/Xp
         F+/uIo/HSfVGWcSiN6+Eg2osFMI5gKrKcnHvDvcmzpYy6any0IIvQHjqhi/efTC0CJ5D
         5O3Hc4EOm63rxsyL662vBvMpg3462huBOxdVH3By5OtQKJU4yzWjm2MOQfBtv1HMPH5y
         bXgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WdiKEUGtJNb3K8rH57Xa0bqqHuMKs85IufCe6WoIQH0=;
        b=mQ+WE9pgqERgR6xOdx0lA7QGDd9aneus/xrZ8nJGfENzFENMbpcfsSejaSYZuLRkgs
         38mzsKU7TCf6pfzVg4l82hTklgne0Ytl5fWYDpAabLgWjt8cIkMytPtht4NU2UaEFIWo
         VZA354CKGixa79Swgsc9RLP5zCMPGRftJ0pmYAocDCgiug0kI9hDqQ7E+BKFbuJ2LseU
         +6O9hABmuTEMB8VWAp/Jyh/9WW/NYLiNDypJujqeXyBB0wwnNYotOprrNLHL9FDB/kOy
         8N9B9bMsb5dCkNFsgX9w8mlkaK53XQhGqpUjqhHl4cjJfJwO2MRg2Le4vkUhwtEnldRU
         lmFQ==
X-Gm-Message-State: AOAM530R7d5L1ntal9UV24yvtcSa9QCdh7tFKb0kGUgGkAwJUXj96aaC
        5Rt0Ro3S3BhYA9Gv51+W5RJxMg==
X-Google-Smtp-Source: ABdhPJxh4iIC96B7vP7yT2NRdJCiN3e86bbKXTI7FBlC/f5JJATdbpmIk6pi0D1BpMCqtslGlYLI6A==
X-Received: by 2002:a5d:540d:: with SMTP id g13mr9474170wrv.380.1594801608318;
        Wed, 15 Jul 2020 01:26:48 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id h13sm2400361wml.42.2020.07.15.01.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 01:26:47 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Andy Grover <andrew.grover@intel.com>,
        Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>,
        Dominik Brodowski <linux@brodo.de>,
        Denis Sadykov <denis.m.sadykov@intel.com>
Subject: [PATCH v2 08/13] cpufreq: acpi-cpufreq: Mark 'dummy' variable as __always_unused
Date:   Wed, 15 Jul 2020 09:26:29 +0100
Message-Id: <20200715082634.3024816-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200715082634.3024816-1-lee.jones@linaro.org>
References: <20200715082634.3024816-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we fail to use a variable, even a 'dummy' one, then the compiler
complains that it is set but not used.  We know this is fine, so we
set it as __always_unused to let the compiler know.

Fixes the following W=1 kernel build warning(s):

 drivers/cpufreq/acpi-cpufreq.c: In function ‘cpu_freq_read_intel’:
 drivers/cpufreq/acpi-cpufreq.c:247:11: warning: variable ‘dummy’ set but not used [-Wunused-but-set-variable]
 drivers/cpufreq/acpi-cpufreq.c: In function ‘cpu_freq_read_amd’:
 drivers/cpufreq/acpi-cpufreq.c:265:11: warning: variable ‘dummy’ set but not used [-Wunused-but-set-variable]

Cc: Andy Grover <andrew.grover@intel.com>
Cc: Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
Cc: Dominik Brodowski <linux@brodo.de>
Cc: Denis Sadykov <denis.m.sadykov@intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/cpufreq/acpi-cpufreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 429e5a36c08a9..6b3d8355c8dea 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -244,7 +244,7 @@ static unsigned extract_freq(struct cpufreq_policy *policy, u32 val)
 
 static u32 cpu_freq_read_intel(struct acpi_pct_register *not_used)
 {
-	u32 val, dummy;
+	u32 val, dummy __always_unused;
 
 	rdmsr(MSR_IA32_PERF_CTL, val, dummy);
 	return val;
@@ -261,7 +261,7 @@ static void cpu_freq_write_intel(struct acpi_pct_register *not_used, u32 val)
 
 static u32 cpu_freq_read_amd(struct acpi_pct_register *not_used)
 {
-	u32 val, dummy;
+	u32 val, dummy __always_unused;
 
 	rdmsr(MSR_AMD_PERF_CTL, val, dummy);
 	return val;
-- 
2.25.1

