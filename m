Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E37321C87CE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 13:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgEGLO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 07:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgEGLO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 07:14:57 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4D5C05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 04:14:56 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id l12so2367110pgr.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 04:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cweRr9cAyY6zAkbWBKWMpZ4+w4vWexg4Pp5+tOHzveM=;
        b=P9xzAJWNtpjG4GM5U3Le0oR9S0hAuJPJAnKqdXJxjdBeAlU1kK9ev60F6NUlFWuqSf
         0jR0DjkY/COxzCP/1kz2MeVCJdzwdTcmdWGw81XdGgJVtt34H3FIuNPSXhOCggQ3nL2F
         1KXAfLZC3Rk5FnOJmARCEQn6HwPsItMdYj7Pm7vqfeHaAyItsyxtSfS9ACuy5H4kZXRm
         CgTfXnAFJDztw6upni3fz8mYsHoITdYwUTNHmrZL3bepyA85Y2Q/hYu+yurlLFsdBw2y
         7NEWb/9tqQjNx848PhgqrivnMNVlP4kxUVXzb/6EOHyEIJoIeFadl37qPNiBFxNM2tZ7
         wbKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cweRr9cAyY6zAkbWBKWMpZ4+w4vWexg4Pp5+tOHzveM=;
        b=q+bdStH2yI1s4uH6tWP9n0WZQA3i35Ex0bcUL3OZRf4oKoBuIWo70+9HeBAz8Y4he8
         sIpdGtiue0dgc4SGRPpnQHQ7SkKmSq65qu7wWv4//9IXzlq64FWv0Z2cazYhPykA2xOf
         B13FQ708kslPHTWsVoTwTz16saFgi/IuqXfIIURuTaKa/DnVrWWXuI77bxU1bhj9GQ8D
         y1ZkfsWALj15wHaHgF+bLryrPHdogSebgfCmJVcF3nf7YNCRH6nYoqB9zGWnP4XRCl6K
         Mfak5ABljTND8EF9MB5D+7HRLUZMrknCmt7RMoCcqAXfgis6zDK592sc1wj9lt51FHzV
         u+Gg==
X-Gm-Message-State: AGi0PuZvAMCKgmsDtPjU6OqbjxXWiiKEM5/ZdJ1UFsVl6ZdFJbqrkji1
        7zyDxi+yZ/2dVwrDRRzow8I=
X-Google-Smtp-Source: APiQypIvZeaFF5cDEz/4tLTjZNOm0OTb5Djpyxeum+11V5wTG99AuLzfa25c+QU6BOGUSiCcWz+bBw==
X-Received: by 2002:a63:778d:: with SMTP id s135mr11615957pgc.238.1588850096044;
        Thu, 07 May 2020 04:14:56 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([103.206.190.146])
        by smtp.gmail.com with ESMTPSA id l30sm7304041pje.34.2020.05.07.04.14.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 May 2020 04:14:55 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        philippe.schenker@toradex.com
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dillon min <dillon.minfei@gmail.com>
Subject: [PATCH V2 1/4] ARM: dts: stm32: add I2C3 support on STM32F429 SoC
Date:   Thu,  7 May 2020 19:14:46 +0800
Message-Id: <1588850086-24169-2-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588850086-24169-1-git-send-email-dillon.minfei@gmail.com>
References: <1588850086-24169-1-git-send-email-dillon.minfei@gmail.com>
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

