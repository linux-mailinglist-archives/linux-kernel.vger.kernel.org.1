Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 514042C84CA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 14:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgK3NM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 08:12:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgK3NMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 08:12:24 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7095EC061A4F
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 05:11:12 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id x15so6458445pll.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 05:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZmXMtKJx+N4tYwcvtUovyBiKEQa6t+IIEkwiQ3K9Kyk=;
        b=NxoxPa8FXIUyktqGrUYMykPc3QGeELu7oBR4Da49xavORiHzpQoQ4BkXXSNXPthLUT
         8Ax/SOzDYiHVd22MIpKaz7so11IqxYNh/HMhQ37F6btbcL7Bil4bAO3Nr67c6EeKnlWj
         /G0U6IxnDInTRu2aBf/JswFUC5jlri5jXPqj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZmXMtKJx+N4tYwcvtUovyBiKEQa6t+IIEkwiQ3K9Kyk=;
        b=WbRQunRLO5UvgX9iaxdrRUxmksckmSxiMQoFed3sXKTLKv7eAlB/7pvvcO9IdUEZJZ
         S1TALtmU7GICPw0dA9X0bjmTZWNmwmgLavohUc02j0THoXlWG8zMUKKzVn3Nmmjj57fd
         GJGpHO9V0Bs/OKqReUXFDn6TncVdec1MDLe6sZRTBueqwefSroV9wzpUF9EY+IeHqKR8
         pVasZ0MdyaVhh4HBzKISvSdHkqPApriAqx2VD/4my5dcjipliWORk2ZukdT4Unu24jKj
         D9bBHca3wQFIIPlcVXsbJA6HmuFcChJ4GVgm+6EJQQoRg1D5cIBUgYTiBwu0rnqGICvB
         +inA==
X-Gm-Message-State: AOAM531gQjfvTpHY5z8/YJ1FzMvBGwXaQmoFBBxNcY/OLdfOomz/So4A
        Gd0hroDSGU55S5l5h0GwRALBaA==
X-Google-Smtp-Source: ABdhPJyyKf5MZtzV/RLjmmfqkXeyEU9oJO0u3J5R7PGr5uYS5/HDPSvBHntPzokzzMLVSuuP6bC+sQ==
X-Received: by 2002:a17:902:788e:b029:d6:9a57:ccab with SMTP id q14-20020a170902788eb02900d69a57ccabmr18678566pll.41.1606741872015;
        Mon, 30 Nov 2020 05:11:12 -0800 (PST)
Received: from shiro.work (p1268123-ipngn200803sizuokaden.shizuoka.ocn.ne.jp. [118.13.124.123])
        by smtp.googlemail.com with ESMTPSA id a4sm41757578pjq.0.2020.11.30.05.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 05:11:11 -0800 (PST)
From:   Daniel Palmer <daniel@0x0f.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de, robh@kernel.org,
        w@1wt.eu, daniel@0x0f.com
Subject: [PATCH 6/9] ARM: mstar: Add chip level dtsi for SSD202D
Date:   Mon, 30 Nov 2020 22:10:44 +0900
Message-Id: <20201130131047.2648960-7-daniel@0x0f.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201130131047.2648960-1-daniel@0x0f.com>
References: <20201130131047.2648960-1-daniel@0x0f.com>
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

