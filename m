Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E1F1D60E9
	for <lists+linux-kernel@lfdr.de>; Sat, 16 May 2020 14:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgEPMuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 May 2020 08:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726364AbgEPMuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 08:50:16 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4FCC061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 05:50:15 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id k19so2076865pll.9
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 05:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pj+H0XRs7BZqevflwkq03eXzGKUz5DncbQ0n+P/Er7k=;
        b=SqOx1Fs0PYZCUFSLq4NUzY0q2y7WznWgqRu3dFYQKg0y2ottvIvnL8mVcbedHe+iup
         bnxY4njYqa6N6zPPJJxUjYLtaWqa7xhOTdBvxy/FyZzOdJGtDaHkDB7d0XQLGpV2O0P0
         zcCFTK/1eMWxsBJYwit6KmiGTY0+V/+UJJmdQtmngbr7sVU+GCFkYZPiiUuNEroVNlgg
         4i1wl/TyUV0dQ9s3bRigv74/tR0siF5T+RGHAzqovmZ0Ss1iYoZML/Gcf9yYZdITEuTn
         zOfUTo8MpdCkM3jLcevUXNLKURZY1KlpFkS+kjP3n+v8x6CN2DEV9OvFvejrRs7nJeKt
         50nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pj+H0XRs7BZqevflwkq03eXzGKUz5DncbQ0n+P/Er7k=;
        b=JFchm3g9ES2ycYeHrrSANT+sf+tzRye6h9qpxAly2knooIgJGk1xjxbdwH4RITowZ/
         fzHnVSN0UE8DhiVSUcdZ8XyAmMlL7OZujgad89PB8N08UuB8tlOdd/OX2sQX/w4SvWN2
         CUdClq+bWWgFhIyJ3ImQ6bl28LUO17hS9LWoz6lpYmIp4OqstEcKdxrPvXAhUI0+n3Dj
         GTHbkDkRzCiafbTO2HmG/hc5cMAyNoaTT8D/M21uT1LiOkKhtDFuw/RE1Cj42xYpMFh6
         LDFKPtBFH1BFnvaSshH+AlI0Ck+CaPxug8nildd121HZAcdRsF1+Axv4hmTZm5WU6GvH
         Zn9w==
X-Gm-Message-State: AOAM531wLDCKD/OsuxYxTGqhrbw/P3V04avQoCJCjZqiLn64Q/+59Z3c
        8Qsa2hrMNUMt7l3/dVQQICFH9ahH
X-Google-Smtp-Source: ABdhPJyAN5qZYimmiLJsxFBo/5zvTCga+8G7/eOmKCQTEdGPpNyZdtuU/fUbzfII9WcvK1fEqIuA4Q==
X-Received: by 2002:a17:902:bccc:: with SMTP id o12mr7435028pls.162.1589633415208;
        Sat, 16 May 2020 05:50:15 -0700 (PDT)
Received: from localhost.localdomain (61-228-240-171.dynamic-ip.hinet.net. [61.228.240.171])
        by smtp.gmail.com with ESMTPSA id k27sm3768323pgb.30.2020.05.16.05.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2020 05:50:14 -0700 (PDT)
From:   Lecopzer Chen <lecopzer@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     lecopzer.chen@mediatek.com, linux-arm-kernel@lists.infradead.org,
        matthias.bgg@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        mark.rutland@arm.com, mingo@redhat.com, acme@kernel.org,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-mediatek@lists.infradead.org,
        alexander.shishkin@linux.intel.com, peterz@infradead.org,
        yj.chiang@mediatek.com, Lecopzer Chen <lecopzer@gmail.com>
Subject: [PATCH 3/3] arm64: Kconfig: Add support for the Perf NMI
Date:   Sat, 16 May 2020 20:48:57 +0800
Message-Id: <20200516124857.75004-4-lecopzer@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200516124857.75004-1-lecopzer@gmail.com>
References: <20200516124857.75004-1-lecopzer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an extending function for Pseudo NMI that registering
Perf events interrupts as NMI.

It's helpful for sampling irq-off context when using perf.

Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
---
 arch/arm64/Kconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 40fb05d96c60..f89c169771a0 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1679,6 +1679,16 @@ config ARM64_PSEUDO_NMI
 	  If unsure, say N
 
 if ARM64_PSEUDO_NMI
+config ARM64_PSEUDO_NMI_PERF
+	bool "Register Perf interrupts as Pseudo NMI"
+	depends on HW_PERF_EVENTS
+	depends on ARM_PMU
+	select HAVE_PERF_EVENTS_NMI
+	help
+	  This registers Perf interrupts to NMI when Pseudo NMI is active.
+	  This option is helpful when you need to debug any context disabled
+	  irq and get more inforamtion.
+
+	  If unsure, say N
+
 config ARM64_DEBUG_PRIORITY_MASKING
 	bool "Debug interrupt priority masking"
 	help
-- 
2.25.1

