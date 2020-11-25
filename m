Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3E8D2C3D94
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 11:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgKYKXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 05:23:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgKYKXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 05:23:54 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85950C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 02:23:54 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id p8so1351823wrx.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 02:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WGazmhq5Tx69dQOoXVy9h+Fs5IXXZtarGPYtiEE9Syw=;
        b=lfEzw+N1FxozwzbTEUGmen6YP2qoCUX8/9b/bYB5tJdBoIjYSzUEdYrF2KawX6Far9
         kP/AtlnioiLErEo/Q2yx7eLlqgy79sleK2wRt5cU/Hg3SwyWSHtlVP63GFelXGU+iCdj
         Lh7QQg6441U9Y7w7cY3zmXok6ZTfTiZQluURFgt2aA/GoghcXWnST6ihjGbyQLb4caIf
         zZl3j6RoIX33OCFQPOCNXcPDsqzJelrqoiXTtU4ZIO3LZi/lqaT2a80vZ4Zvr0QE59gD
         Goi7w/YEkur+l/IEaOuLqSlqIqmk1MvOHk9wRLuV7J/QmkfbxlllHls6X1tiluldwQZA
         Hjbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WGazmhq5Tx69dQOoXVy9h+Fs5IXXZtarGPYtiEE9Syw=;
        b=s9uBvodq+MmMfg1tmyM1LmlxrOqF0NroFHQvOR2oySszmKI5iPsaCpTkhdtMNOeS8u
         euBdMdMedjkkKt+cojYP2wxOSzgWmZtEM03Hpg99OOB0tmonyy5OqTc3opBJA58KH9EQ
         Zj/I1afi8AHrz2F3uVw+01X4Ia/KlAz99Av2xMdzmfbtUx8DF+gPa8+55iD756fo1OvE
         phhGKTb3ktcDR6qLfcM47kbZVWMgQVkaUKL5QfHXTmtOMjOVjuQBVyKsI1lcvVkkR/Xm
         Qh+RdeLDsyt73eC3V0mtkUmAJHUqTMB/a61prd6Zk3b4Tc/NP3ICL3wF7G+vp4/N3Pst
         yuuQ==
X-Gm-Message-State: AOAM53308mwlU9Y0rjzc7m9E5KHUPwbLi66tvrBHqhcfD82TOlkb6ear
        /dlOHkOr0vbhYrtmZCigrhOBIJgSVfOERA==
X-Google-Smtp-Source: ABdhPJxM6AbjijXTDARlS+lg8AmV+SNOu7ro3lS7m+BqhYbCkbyd3Gq3E/L56aaL5K0p8TFPr/+7jg==
X-Received: by 2002:a5d:514a:: with SMTP id u10mr3275647wrt.312.1606299833110;
        Wed, 25 Nov 2020 02:23:53 -0800 (PST)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:6510:7bd4:3caf:94b1])
        by smtp.gmail.com with ESMTPSA id f5sm4306327wmj.17.2020.11.25.02.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 02:23:52 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, zhouyanjie@wanyeetech.com,
        paul@crapouillou.net, paul@boddie.org.uk, hns@goldelico.com,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] clocksource/drivers/ingenic: Fix section mismatch
Date:   Wed, 25 Nov 2020 11:23:45 +0100
Message-Id: <20201125102346.1816310-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <202011251435.7F0RQBXw-lkp@intel.com>
References: <202011251435.7F0RQBXw-lkp@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function ingenic_tcu_get_clock() is annotated for the __init
section but it is actually called from the online cpu callback.

That will lead to a crash if a CPU is hotplugged after boot time.

Remove the __init annotatation for the ingenic_tcu_get_clock()
function.

Fixes: f19d838d08fc (clocksource/drivers/ingenic: Add high resolution timer support for SMP/SMT)
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/ingenic-timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/ingenic-timer.c b/drivers/clocksource/ingenic-timer.c
index 58fd9189fab7..905fd6b163a8 100644
--- a/drivers/clocksource/ingenic-timer.c
+++ b/drivers/clocksource/ingenic-timer.c
@@ -127,7 +127,7 @@ static irqreturn_t ingenic_tcu_cevt_cb(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static struct clk * __init ingenic_tcu_get_clock(struct device_node *np, int id)
+static struct clk *ingenic_tcu_get_clock(struct device_node *np, int id)
 {
 	struct of_phandle_args args;
 
-- 
2.25.1

