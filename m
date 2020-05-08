Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65FD91CA042
	for <lists+linux-kernel@lfdr.de>; Fri,  8 May 2020 03:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgEHBqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 21:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726509AbgEHBqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 21:46:36 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9239DC05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 18:46:36 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 18so94631pfx.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 18:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cweRr9cAyY6zAkbWBKWMpZ4+w4vWexg4Pp5+tOHzveM=;
        b=qkSr8PCxTjLesHCIYKLjPg4DjNMUEOltWQ3xEt49V/dH3wG5Q2bFVu8h0oBVariOzD
         64FCLQtbLsFM3L2fGXIu2f3ZTV87w4JIZ4pByFeHiG0fb0e2eaLbwVSxq6uhbBOIsFVA
         o4X2O6+JRsVnyjJXUZCkalLxRJ19vJF6+ZvXy4tIUYZe3eqzhmjPxg1NFR03nYirHoGO
         OpqTL/wuA1r4/GAj+Y9d4LJ5zE7GQ+lQ0xsUWjmmOj7dJ+fpkQ5+L7+wbhfF/McwSuJp
         Vlw/LHP/qZWOzoDyAuA3DYq4M3wy/I8sbhcO3oXxbgWsWyVjfc/swSe/DlISYnfepxCd
         Vx2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cweRr9cAyY6zAkbWBKWMpZ4+w4vWexg4Pp5+tOHzveM=;
        b=Ai8mYItmJzral7XWKEnY+SMpFAIcRs9u42JYOo+7uwEFzIzfMjHu/7oURRBhDPxSHj
         jVWKmlEoyquhNGq12kEt52BWB3mO+D3GzpbN/rH0yWb5+pXGOfWJ7YBKaqPY/5Ci5Kjz
         fzNYBkEdp4BhA+XAXEue5ZEzkwMaWM8/zIAgpAa59la8qv+pVIDBNWRP4+5S0K0vjR8M
         da3x6IBwGF2Bl9FxcOWVFkKOTIoDivXCqgBZ15IKxt5aL9qbB+qwfLi4Kd9kdgjYDLZd
         gVLmD8ZTRAMRpXaZ27syEfEU6CxqCbjzSAgdNR0I52c0d1lq0gG8a8K4D0RxLAs6YeMR
         mKDw==
X-Gm-Message-State: AGi0PubrNOieHOmXSKnjXivL8k6Qslab8y50SRj46i5B4gVaFBViQBRZ
        vf/6zEJlX43x3nxz7lwdlmo=
X-Google-Smtp-Source: APiQypLM2K5G2GnkqO1UGyLId9fhCM/BEPlhPv4MJCsMXb2nUR3hPIVNMI8YnRBe67fjalob4a88aQ==
X-Received: by 2002:a62:18c8:: with SMTP id 191mr242124pfy.255.1588902396205;
        Thu, 07 May 2020 18:46:36 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([103.206.190.146])
        by smtp.gmail.com with ESMTPSA id f74sm9270816pje.3.2020.05.07.18.46.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 May 2020 18:46:35 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        philippe.schenker@toradex.com
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dillon min <dillon.minfei@gmail.com>
Subject: [PATCH v3 1/4] ARM: dts: stm32: add I2C3 support on STM32F429 SoC
Date:   Fri,  8 May 2020 09:46:25 +0800
Message-Id: <1588902388-4596-2-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588902388-4596-1-git-send-email-dillon.minfei@gmail.com>
References: <1588902388-4596-1-git-send-email-dillon.minfei@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

This patch adds I2C3 instances of the STM32F429 SoC

Signed-off-by: dillon min <dillon.minfei@gmail.com>
---
 arch/arm/boot/dts/stm32f429.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index d777069..257b843 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -402,6 +402,18 @@
 			status = "disabled";
 		};
 
+		i2c3: i2c@40005c00 {
+			compatible = "st,stm32f4-i2c";
+			reg = <0x40005c00 0x400>;
+			interrupts = <72>,
+				     <73>;
+			resets = <&rcc STM32F4_APB1_RESET(I2C3)>;
+			clocks = <&rcc 0 STM32F4_APB1_CLOCK(I2C3)>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		dac: dac@40007400 {
 			compatible = "st,stm32f4-dac-core";
 			reg = <0x40007400 0x400>;
-- 
2.7.4

