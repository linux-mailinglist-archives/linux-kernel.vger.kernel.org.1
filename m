Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD891E3853
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 07:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgE0FhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 01:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgE0FhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 01:37:05 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFFDC061A0F;
        Tue, 26 May 2020 22:37:05 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id bg4so4423409plb.3;
        Tue, 26 May 2020 22:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9fwAH/9wNW27Bix3RiJQ6nNoorCZe5Ipf6jNZRotmVU=;
        b=vSCWkOKlHzyJy2tS/DW66bftOKxX3fkd4hLElv9dM1GKBGK1pfYgh5CJCUgN9Z/HmV
         9JRKiy0BEsz00gfY2VPiQSLQ/AGh7Xq9gvLvbCaBtUdlaO1hzrQCPu3MGX0QlkhrYYRY
         iu6+sUo0AjTYImsSVhN4DiZ51rMWMK+svnprW9bpCIYUYELI+GiZWODKONcMNSu1xYbR
         ptvpSB3L7lMjAdbTg3NiFc5lkM3qmH0Q1P2vUq/JHbzKztVR2hA3MYU35RifKv7YXlQD
         ML30lHaCNWq4RrOwvynmTwcl5tZbJ9XfeAcZ56jQlTLkV7aRk7YiUE8C5STPptVCyU64
         f7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9fwAH/9wNW27Bix3RiJQ6nNoorCZe5Ipf6jNZRotmVU=;
        b=hQqMnhDsyrw2YUg1uoE4a7Baprih+g0W64znDm4tAks7sgOmdPDsMSm3t/8nrtraPr
         IXcSZ2MVXBCzT1odkP67CFv61M8b1IiJKOQq4F+Sp/Jbp2pZjYGx4rcNW1oktFU26IyS
         m3papqj6x45B5KyfTd5vOVYb0BFemMCKkYEWJ/lxBY1CN4FFQMHt4+j7T40Y5WU1MC4Y
         ZQw1A+hocWRsJd4mZyg75kX6R/XxYKCuFyDGUxtIYH92lbxFXpRvzi3E43p1U0dVQXJM
         1n+G4TfcUXudScv5++dqSUpkQ8bFIWZiM0Bbvb+Kre3buQws5gLATnqxO7qW/QMGwHTe
         jrAg==
X-Gm-Message-State: AOAM531PO6erwqvBIvsIedTbuyMICJ0FUsOWOMvGlVTw1VKFK5z7Mk0j
        T6ATDP4pTFGQPJBhpEHL/4o=
X-Google-Smtp-Source: ABdhPJzh8Dsl6UQ9yVlyFHy7aSawgg/+oHWpHbdnZH/Iq+igyhgNHO0s1YZmcsf7Yr5Bp4ehMnsjNw==
X-Received: by 2002:a17:90a:6409:: with SMTP id g9mr2868729pjj.188.1590557825008;
        Tue, 26 May 2020 22:37:05 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id r34sm1092406pgl.38.2020.05.26.22.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 22:37:04 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [RESEND PATCH v2 3/4] clk: sprd: add dt-bindings include for mipi_csi_xx clocks
Date:   Wed, 27 May 2020 13:36:37 +0800
Message-Id: <20200527053638.31439-4-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200527053638.31439-1-zhang.lyra@gmail.com>
References: <20200527053638.31439-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

mipi_csi_xx clocks are used by camera sensors.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 include/dt-bindings/clock/sprd,sc9863a-clk.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/dt-bindings/clock/sprd,sc9863a-clk.h b/include/dt-bindings/clock/sprd,sc9863a-clk.h
index 901ba59676c2..4e030421641f 100644
--- a/include/dt-bindings/clock/sprd,sc9863a-clk.h
+++ b/include/dt-bindings/clock/sprd,sc9863a-clk.h
@@ -308,6 +308,11 @@
 #define CLK_MCPHY_CFG_EB	14
 #define CLK_MM_GATE_NUM		(CLK_MCPHY_CFG_EB + 1)
 
+#define CLK_MIPI_CSI		0
+#define CLK_MIPI_CSI_S		1
+#define CLK_MIPI_CSI_M		2
+#define CLK_MM_CLK_NUM		(CLK_MIPI_CSI_M + 1)
+
 #define CLK_SIM0_EB		0
 #define CLK_IIS0_EB		1
 #define CLK_IIS1_EB		2
-- 
2.20.1

