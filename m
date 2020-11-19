Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AECC2B9EDE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 00:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbgKSX4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 18:56:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbgKSX4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 18:56:37 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A41C0613CF;
        Thu, 19 Nov 2020 15:56:37 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id i19so10384410ejx.9;
        Thu, 19 Nov 2020 15:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F1TKxF6AHHpAsVF/kWYh1rblL0kVtDfpsOGi5mvwL5o=;
        b=Q362hp+kKBmQZSnmR9HW+tg9cSIawvG0J7b4bx9VgHjFYBFa8EYRsxzbXsMKgt49t7
         IbpFDlB3eeswGYjx+ikDz7DuSAWrRSIrNprinnkn7G/4E/aU8vPVdcRKaFyrMGnbnhNf
         YBhVJV4FfFXh2lWFlpFVP78yC+053AhqOlhtFvh+6jigqUTlw9b3sG1JXv9K4oc071dv
         1YkjwR+/zB438IdztFtmNKYQPZMfXmLisgniNssLd7R4Xin1u8zKW8SuC4EFO0u+Z8Ut
         1V4LPbgKqAEt1ZhX0SKE0f7iTu36ohmideRd5Y82O9eID3uyOsgrSkb7i1bMu10EIc57
         WHUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F1TKxF6AHHpAsVF/kWYh1rblL0kVtDfpsOGi5mvwL5o=;
        b=NChnXOPUkW8E/1IBzTzF/rMsSIKjxHdCHYa0jwfbiHDBxijAE3fok5qNtoP+6/upN5
         WCAvmYFHFYJ+50nftLNeozlW0wvx2yNPQLxBFYye8OGLquhWD8XXwrmMajW2x8DAiaPZ
         Lw5iZO4ZTD9JYBoW9x9Q3/rk1Wgj2zro7uB1Z+WPnVHdIwt49cVHKVhsSX02rOuOYjA4
         vzbwy42Tl/jx0d0uNeBBtaoTNUHdzZSm0zPWqMm6Wi5fs+k+ZIvxVd7RCz7aSvxhNsld
         YMPWNlfG7x3QTszgG7WOOv5HDRNwsW0l9bs5ieAjJAjqVAJ4eUaXspk51E4ilXh1I7VL
         QNKA==
X-Gm-Message-State: AOAM531Ur4oM9tTOZrJW7ujZ4CGcqkEs7eAoCoz1l1BVmQsFBVm3/C/Q
        qNhY/NvKOGhdmh3QpxGxbac=
X-Google-Smtp-Source: ABdhPJz69kt9IRDlpsTIwV4/fUNXGsQPqUuLrFEF3oJDKWMF0XkSbkHJKQamBhTyOy6WEA9JM0IBSw==
X-Received: by 2002:a17:906:3a86:: with SMTP id y6mr31064458ejd.289.1605830196049;
        Thu, 19 Nov 2020 15:56:36 -0800 (PST)
Received: from localhost.localdomain ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id i3sm452987ejh.80.2020.11.19.15.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 15:56:35 -0800 (PST)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 15/18] arm: dts: owl-s500-roseapplepi: Use UART clock from CMU
Date:   Fri, 20 Nov 2020 01:56:09 +0200
Message-Id: <976d0275aadbf691df87aba27a8a6be20ca3de53.1605823502.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1605823502.git.cristian.ciocaltea@gmail.com>
References: <cover.1605823502.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the UART fixed clock for RoseapplePi SBC and switch to using
the clock provided by CMU.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
 arch/arm/boot/dts/owl-s500-roseapplepi.dts | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm/boot/dts/owl-s500-roseapplepi.dts b/arch/arm/boot/dts/owl-s500-roseapplepi.dts
index a2087e617cb2..800edf5d2d12 100644
--- a/arch/arm/boot/dts/owl-s500-roseapplepi.dts
+++ b/arch/arm/boot/dts/owl-s500-roseapplepi.dts
@@ -25,12 +25,6 @@ memory@0 {
 		device_type = "memory";
 		reg = <0x0 0x80000000>; /* 2GB */
 	};
-
-	uart2_clk: uart2-clk {
-		compatible = "fixed-clock";
-		clock-frequency = <921600>;
-		#clock-cells = <0>;
-	};
 };
 
 &twd_timer {
@@ -43,5 +37,4 @@ &timer {
 
 &uart2 {
 	status = "okay";
-	clocks = <&uart2_clk>;
 };
-- 
2.29.2

