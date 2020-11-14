Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B83442B2D76
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 14:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgKNNwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 08:52:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbgKNNwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 08:52:23 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B84C061A04
        for <linux-kernel@vger.kernel.org>; Sat, 14 Nov 2020 05:52:21 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id f38so9182761pgm.2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Nov 2020 05:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F/nq3JnunleBEPmOqQ59JVNiFyN2h6AIwG//l7PiMiQ=;
        b=l5FsBr48D12H3HK8mLGUuPcnIWvJp1vzinlvLgFfovlMFugm7gKec4ctCEOoBdkoDz
         fSuT4W75rbTt7t2WFPTCG2GevKdL2TeqeE6PJhpx2Iy4vFvvncr6EhL35l37w+6Fe+G6
         oV//uwgXt1OunaaouRB1KY7CSrhOl2eeo93qo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F/nq3JnunleBEPmOqQ59JVNiFyN2h6AIwG//l7PiMiQ=;
        b=jD5fC5wL3eH3T/OP0v1N1wIXIPSxjs52jSPfqBlOwQkwhIZpKlrNrX2iPZaSl0Oo9I
         ZXkCRX2haGb21jwRQguR19S7JMYaOVgPY534c4uq9huL2WkSJhf5dbnqkR6rD/f48Wzg
         KY+O6k0ngKD9vJMPBENtNXjfe6gizxm9f0u4HnzfG6jd91Ky6qwo8KaHUS4/GReLk1h1
         gsB+TB57wdP0XHFKxNF3MpP39WOdfJNDTM0DJH+W1vh8vdXriFoR6Oojx9MfsCZHgOAP
         51jfr2oQ3s2jSAfqIBKlfzsqXOvkmlngyTOHc63iz5bEWpnZfRofC3nLAX22NPtt3Vft
         YD9A==
X-Gm-Message-State: AOAM533VE0fXp0URMg6VqmH1e+jB0NM3dp7fdHa1gYT//TKwaUKXPrP9
        s65gKpm8QmTSArESYyUDJDpWaQ==
X-Google-Smtp-Source: ABdhPJzq4Ydud7WeDfpMytkX7tslUBQ49azEQ7XkLoSKZEyI0EoGIy2e/XTGLLSPG5v8hRo5NIhAKw==
X-Received: by 2002:aa7:8b12:0:b029:18c:7b88:d7fc with SMTP id f18-20020aa78b120000b029018c7b88d7fcmr6241210pfd.53.1605361941458;
        Sat, 14 Nov 2020 05:52:21 -0800 (PST)
Received: from shiro.work (p1268123-ipngn200803sizuokaden.shizuoka.ocn.ne.jp. [118.13.124.123])
        by smtp.googlemail.com with ESMTPSA id r205sm13008023pfr.25.2020.11.14.05.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2020 05:52:21 -0800 (PST)
From:   Daniel Palmer <daniel@0x0f.com>
To:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        w@1wt.eu, Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 1/6] dt-bindings: clk: mstar msc313 mpll binding header
Date:   Sat, 14 Nov 2020 22:50:39 +0900
Message-Id: <20201114135044.724385-2-daniel@0x0f.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201114135044.724385-1-daniel@0x0f.com>
References: <20201114135044.724385-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simple header to document the relationship between the MPLL outputs
and which divider they come from.

Output 0 is missing because it should not be consumed.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 MAINTAINERS                                   |  1 +
 include/dt-bindings/clock/mstar-msc313-mpll.h | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)
 create mode 100644 include/dt-bindings/clock/mstar-msc313-mpll.h

diff --git a/MAINTAINERS b/MAINTAINERS
index a3f0aa46d0d8..1e874fda810e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2135,6 +2135,7 @@ F:	Documentation/devicetree/bindings/gpio/mstar,msc313-gpio.yaml
 F:	arch/arm/boot/dts/mstar-*
 F:	arch/arm/mach-mstar/
 F:	drivers/gpio/gpio-msc313.c
+F:	include/dt-bindings/clock/mstar-*
 F:	include/dt-bindings/gpio/msc313-gpio.h
 
 ARM/NEC MOBILEPRO 900/c MACHINE SUPPORT
diff --git a/include/dt-bindings/clock/mstar-msc313-mpll.h b/include/dt-bindings/clock/mstar-msc313-mpll.h
new file mode 100644
index 000000000000..1b30b02317b6
--- /dev/null
+++ b/include/dt-bindings/clock/mstar-msc313-mpll.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+/*
+ * Output definitions for the MStar/SigmaStar MPLL
+ *
+ * Copyright (C) 2020 Daniel Palmer <daniel@thingy.jp>
+ */
+
+#ifndef _DT_BINDINGS_CLOCK_MSTAR_MSC313_MPLL_H
+#define _DT_BINDINGS_CLOCK_MSTAR_MSC313_MPLL_H
+
+#define MSTAR_MSC313_MPLL_DIV2	1
+#define MSTAR_MSC313_MPLL_DIV3	2
+#define MSTAR_MSC313_MPLL_DIV4	3
+#define MSTAR_MSC313_MPLL_DIV5	4
+#define MSTAR_MSC313_MPLL_DIV6	5
+#define MSTAR_MSC313_MPLL_DIV7	6
+#define MSTAR_MSC313_MPLL_DIV10	7
+
+#endif
-- 
2.29.2

