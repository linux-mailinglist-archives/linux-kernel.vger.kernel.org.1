Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8D52CA42D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 14:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391204AbgLANpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 08:45:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391166AbgLANpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 08:45:04 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CF8C061A4E
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 05:43:55 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id j13so1260437pjz.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 05:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZmXMtKJx+N4tYwcvtUovyBiKEQa6t+IIEkwiQ3K9Kyk=;
        b=t6q6uhfFqDAV+Gpt9MD0/6YR8au50Pju9fWCyH2hnyNEP9wJiJPqna+SH1c5DoAYUX
         s1a+2RKgaD8aqVVp2TFcKKf2+RYPuIlugkr+VezgnCx+YhZ1uLSoBB7vL1bU9e5NRnO2
         1EoptdP+uf1iEIO00tkEZQeXawKJ0PGcHCViQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZmXMtKJx+N4tYwcvtUovyBiKEQa6t+IIEkwiQ3K9Kyk=;
        b=j/Or/NXvCeLFZmp/zITmVJxjw+mD7tI+1IOR/+iX6LWpEi+wDCFFWgk6w7KfsRpJ+I
         oZEc9KKavxyAKb7luZeX6pbgJkA+Sp3eTLFKMxF++Wuo7HB6YEFC2ig6DNNTJxZc5+Cd
         y2aRKjkt2A26CjhOwrNfoHSlUr2lpPJDpK352q1KREG5pjv5XxGJEnJwRksKa3vkS8Cd
         iDf40z9UWvLTWQvGIiEp0wiZaL5BP4ZJRWagp9XrvjsGuRCmVEp864NoCiKpTdVXGhhH
         /zdlokLyYNdBHvD3NIqSeawnVurjaJi4rkAbxxOkgwHNm9koSNsZ+cXFHwmo35gdTPo1
         uuFQ==
X-Gm-Message-State: AOAM5333smtJ6800nvAgbJuyygJlFu/Y3DiC5UcikPERAr9kA2sU9ixo
        CgFAjWh2K+O7oCPqnJMyU9XZoA==
X-Google-Smtp-Source: ABdhPJzL6sz8FhzIj/VnR2T4URGqVwifM9uOLkrsNrYxoV7xuyu2esfcbIqT9WWHFPe7wKzSDADh3w==
X-Received: by 2002:a17:902:7b97:b029:d8:ec6e:5c28 with SMTP id w23-20020a1709027b97b02900d8ec6e5c28mr2848453pll.40.1606830234662;
        Tue, 01 Dec 2020 05:43:54 -0800 (PST)
Received: from shiro.work (p1268123-ipngn200803sizuokaden.shizuoka.ocn.ne.jp. [118.13.124.123])
        by smtp.googlemail.com with ESMTPSA id g14sm2839248pji.32.2020.12.01.05.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 05:43:54 -0800 (PST)
From:   Daniel Palmer <daniel@0x0f.com>
To:     devicetree@vger.kernel.org, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        robh@kernel.org, w@1wt.eu, daniel@0x0f.com
Subject: [PATCH v2 06/10] ARM: mstar: Add chip level dtsi for SSD202D
Date:   Tue,  1 Dec 2020 22:43:26 +0900
Message-Id: <20201201134330.3037007-7-daniel@0x0f.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201201134330.3037007-1-daniel@0x0f.com>
References: <20201201134330.3037007-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a chip level dtsi for the SigmaStar SSD202D

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 arch/arm/boot/dts/mstar-infinity2m-ssd202d.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 arch/arm/boot/dts/mstar-infinity2m-ssd202d.dtsi

diff --git a/arch/arm/boot/dts/mstar-infinity2m-ssd202d.dtsi b/arch/arm/boot/dts/mstar-infinity2m-ssd202d.dtsi
new file mode 100644
index 000000000000..176e10a29896
--- /dev/null
+++ b/arch/arm/boot/dts/mstar-infinity2m-ssd202d.dtsi
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 thingy.jp.
+ * Author: Daniel Palmer <daniel@thingy.jp>
+ */
+
+#include "mstar-infinity2m-ssd20xd.dtsi"
+
+/ {
+	memory {
+		device_type = "memory";
+		reg = <0x20000000 0x8000000>;
+	};
+};
-- 
2.29.2

