Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88C51303E3F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 14:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392216AbhAZNMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 08:12:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391911AbhAZMrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 07:47:52 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45ABAC0698CF
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 04:45:53 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id g10so16338660wrx.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 04:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XuvdeEVGgVGx8Q6bfVHqk100qI9P2WGDJUgmEfT3Z80=;
        b=qVYoj1LV43OERPJkGr6NsVaicAcn1JfbweAsSv4QBHHFtLXYj48oJA1HhFmkUEi2EZ
         EzvZ+5Vig/rfcG7me0rL+pNqn4XYtc6Ku5X5bHO2ATdWdPMwnm8aRhHWbxSPg4pTQRrk
         QaYBpInkNzdJ0ZcAO3KfvGPwRaG5kwDptYkTGAJ/uNRTZJpF2PqwOaBNL68+u/s8YkH2
         PhMQQT1wdU1YhRkAN7b+WZ+lKQYhhYN/HIbn3ImwPDj3BiPOIk5ZY6vUi401NleKyoc1
         AsD1Wew2f+VZdKcplOi7bCvk8gRMMs/TeU1+rgsBqPqT9060O/maLEI4OtshFoKzA8zS
         OF/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XuvdeEVGgVGx8Q6bfVHqk100qI9P2WGDJUgmEfT3Z80=;
        b=MN8IudYDhpK4xWht0v1Es5Xnvyt92wDYtjAUyz+q/gJOU0xdq5KTisK4MFkK2h32ag
         GKMypuCYFDYM/VHlvTqMUdDj6nEY1Hk10WKsk01By0hVVghKjWcjAHRbvM1Rg6+ZzUKC
         9cVyqONiIE/3Kq4I5/Y7JVDvAYYwF2VxixWYK7qpjUceA4/k8ynp2phESmnZHAWQGwrX
         ojnxm6pw3YgE/3+SjVrZcvUu5cxzg26F2wcK0rusv53T3FXCkt+Zpc5StvbFAETZtmRH
         cJS8YyA+gJ6rt6ggJ0ZhmJ2vaOqu/2gtzhgVu2OSvNoB1NGLpEnhnw+UBFaDAYZ2gcEX
         JzpQ==
X-Gm-Message-State: AOAM531b8xE60txooRgqdMmmnjr9MBM6H7DzMdPp0DHlr2xYqn91Gr/O
        qv1zzA6q1e8jMXRjSfRPa/rYoA==
X-Google-Smtp-Source: ABdhPJyKKCPuEPaelxY+HfAhH8/k3ZMsUja3L7lTXwAZLVcQ/bRenxKcss5It+OKhPJb9XgdisE7UQ==
X-Received: by 2002:a05:6000:1252:: with SMTP id j18mr5772873wrx.232.1611665152035;
        Tue, 26 Jan 2021 04:45:52 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id i131sm3263073wmi.25.2021.01.26.04.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 04:45:51 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Emilio=20L=C3=B3pez?= <emilio@elopez.com.ar>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 06/21] clk: sunxi: clk-usb: Demote obvious kernel-doc abuse
Date:   Tue, 26 Jan 2021 12:45:25 +0000
Message-Id: <20210126124540.3320214-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210126124540.3320214-1-lee.jones@linaro.org>
References: <20210126124540.3320214-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/clk/sunxi/clk-usb.c:22: warning: cannot understand function prototype: 'struct usb_reset_data '

Cc: "Emilio López" <emilio@elopez.com.ar>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Jernej Skrabec <jernej.skrabec@siol.net>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-clk@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/clk/sunxi/clk-usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi/clk-usb.c b/drivers/clk/sunxi/clk-usb.c
index d78a78495bede..5460218f3467a 100644
--- a/drivers/clk/sunxi/clk-usb.c
+++ b/drivers/clk/sunxi/clk-usb.c
@@ -15,7 +15,7 @@
 #include <linux/spinlock.h>
 
 
-/**
+/*
  * sunxi_usb_reset... - reset bits in usb clk registers handling
  */
 
-- 
2.25.1

