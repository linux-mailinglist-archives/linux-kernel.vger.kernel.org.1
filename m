Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83CA32FEF8E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 16:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731610AbhAUP4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 10:56:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731723AbhAUPxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 10:53:45 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA292C061786
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 07:52:59 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id j3so3018581ljb.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 07:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=JgJ9soxybA1o27bKejN8yKs9EOx9gsIQCO6dTbQVL9c=;
        b=ZwI8PpIUolJOdFomVXItWc6Ei9K6Xlnxm5Je1UlruTVxwV8/5MKEhFHUNJy2RelrSR
         mVjJkRTv9PGcoVSw6cCjitPuJ21NHvqakZ0U+qGjOXrwURslvqFzFx7U7jkDGKFPjVFw
         +1mjDQcArQjUoPInkCnHSvriac5lShzk07L5IiODdLW8xZpJgXX1yLjBNQdIa8AXzn0m
         tUZJtbm4H+JIYl0yfXq41+dIyrP4VI8eBWfS015dtAjorV62ukH9PAQqf9eNP44WW3RL
         s7hGPD/RH1YCrs9xGMJYCQLA4bRyRvYR/PfC/EXFKB98kwa+Jt3HuLU0y9d512V7Vx5Q
         qA2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JgJ9soxybA1o27bKejN8yKs9EOx9gsIQCO6dTbQVL9c=;
        b=law77pQ1O+Ht2kWio6P2u04Ry7Z63JktiNxqIFJcbx59Orxq3sxD4onAbztMp/Nf4b
         QMcCL+phpMLeXV6tv5g6lTN0NBTD2mQt9eIEAYeU6gYbklan9YfEhjbPf1wPVI5DgkpR
         8bd3VE9AG4SVCf+dOH9i+0ci2yT/zzffL5rd6jo9H25/1DK6DePo4qkBrcpZjx2s1ncM
         Oei+NLOSPwAZl4uK9Iw9giOElwTNIR9SgtbqTb4/tUnbMx2CymsuUaC5k8wfu9QSlZHT
         iM3Yfejzbzsqp4Rjv+x9RYxzlZrxQqwyZT2/H4MFp+P/kqLMOj8CgWUnqL6L8kb5Xnhz
         G8jw==
X-Gm-Message-State: AOAM532iJEdE5uAV8POQlCN0U3BB1fA2sDuItb/jHwyKK+st4UFxrCJ7
        JFzZk1jJhzF+e5+RbyEFQfx2GQ==
X-Google-Smtp-Source: ABdhPJzBas/8VImlBe+3srXin6AiXd1AubNON2XkPDcrMPRT0OoveVfac9pRS6bgKYVKOKxw6/sV2w==
X-Received: by 2002:a2e:5018:: with SMTP id e24mr7505282ljb.425.1611244378214;
        Thu, 21 Jan 2021 07:52:58 -0800 (PST)
Received: from zr.local ([185.200.81.30])
        by smtp.gmail.com with ESMTPSA id l7sm616628lja.15.2021.01.21.07.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 07:52:57 -0800 (PST)
From:   Zyta Szpak <zr@semihalf.com>
To:     shawnguo@kernel.org, leoyang.li@nxp.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org
Subject: [PATCH] arm64: dts: freescale: fix dcfg address range
Date:   Thu, 21 Jan 2021 16:52:37 +0100
Message-Id: <20210121155237.15517-1-zr@semihalf.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dcfg was overlapping with clockgen address space which resulted
in failure in memory allocation for dcfg. According regs description
dcfg size should not be bigger than 4KB.

Signed-off-by: Zyta Szpak <zr@semihalf.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 025e1f587662..565934cbfa28 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -385,7 +385,7 @@
 
 		dcfg: dcfg@1ee0000 {
 			compatible = "fsl,ls1046a-dcfg", "syscon";
-			reg = <0x0 0x1ee0000 0x0 0x10000>;
+			reg = <0x0 0x1ee0000 0x0 0x1000>;
 			big-endian;
 		};
 
-- 
2.17.1

