Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 729162976BE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 20:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S465118AbgJWSSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 14:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S373951AbgJWSSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 14:18:32 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D0BC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 11:18:32 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id b23so1890663pgb.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 11:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4m6jfpbMPvI670v+G/621vDvUbzIbqCiowX3qojKrHw=;
        b=OnkZ5bNo3R7+KUYl2VjSFO4cE69flfZGBlgFhKWUCEvet4c7zl9z0V4Qa/bIHcoFlb
         ZvZUeqnObh5JBFDqgzycXfZq1QwG8mAJvv+v8eHfYQGSRUAvRlxsm1u5CI98zQOirmFj
         4yjjrW5PwzY1KGllFJ+rgc1yGbwPVz+8jyU0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4m6jfpbMPvI670v+G/621vDvUbzIbqCiowX3qojKrHw=;
        b=HhZTaIXJMhe6sPQ8O9wekfZRR1rXaSHCMEI8dMYn7tt3tgFibehJC9gloEKY6a9469
         y9A7WCNv4kjBX+osvX7vmLpYLUr9HSZc/hpZYxUo0sPQkJ9iYaYaQQVRSnzL6+/CtE6J
         3h1MPJ9viiTNqcYKoBCqD/LhUVBi08ZNJINbkH/Zi/+3PsbO+1vQ3rjT6zdD6R/04ZDO
         QoFGoy1/vfqnewU0rxT55ZhX4H8vq/syVipOeVNcJxVc/ztlgMVwSkBAHPh12EZL+CpG
         SfyW5HGI9rkNsDWsHddsHhXAGDllUBKQqpeEh+yP6euMEABYiiia9YkkxL/JJDuXu5Wx
         Md2Q==
X-Gm-Message-State: AOAM531u5uV4KkJ0YfTO3f6Hb97wkwFyJ//i/Sg327TAtz7ewgGPuPZD
        O7Io4WJrpbSG1SB59PTKb7kA2g==
X-Google-Smtp-Source: ABdhPJybfaHmQ0Qz0QLxS4XqhlxkmDHZb4o+gWXwJ3icSXABR6RqkLoRyXl0QuuoqyOHS54Cas/Ysw==
X-Received: by 2002:a63:481d:: with SMTP id v29mr2942292pga.448.1603477112153;
        Fri, 23 Oct 2020 11:18:32 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c809:c7a4:2d08:2249:ad54:d32d])
        by smtp.gmail.com with ESMTPSA id q24sm3271162pfn.72.2020.10.23.11.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 11:18:31 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Tom Cubie <tom@radxa.com>,
        Suniel Mahesh <sunil@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 1/2] arm64: defconfig: Enable RTC_DRV_HYM8563
Date:   Fri, 23 Oct 2020 23:48:13 +0530
Message-Id: <20201023181814.220974-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RTC HYM8563 used in the ARM64 Rockchip SoC's SDIO power
sequence enablement.

Enable it as module.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index e0f33826819f..7f72d3b4b39d 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -770,6 +770,7 @@ CONFIG_EDAC=y
 CONFIG_EDAC_GHES=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_DS1307=m
+CONFIG_RTC_DRV_HYM8563=m
 CONFIG_RTC_DRV_MAX77686=y
 CONFIG_RTC_DRV_RK808=m
 CONFIG_RTC_DRV_PCF85363=m
-- 
2.25.1

