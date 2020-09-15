Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C41326A5AC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 14:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbgIOM4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 08:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbgIOMrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 08:47:47 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB08C061352
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 05:46:01 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id z1so3182890wrt.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 05:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GVroTBa/RDLMNit62OYeyl1hwDTywX684KnqperhLJ0=;
        b=KzcCsQcCjNO2iAn9TLGuYKccXqq76Nj0G9UJEj75DZeAVJEgvJT6Akrl2s/t8SN2jR
         f+VpZ3IYj0dWNYEWjt3KYBSzy+3ss8FhI3NjAX9w7PAbvdI1K75ZPZTCdZ3N9EZTpRcC
         9KyxKduWnNaYewl+WxNSAPi5bUdQAPrc7dH2IXz/+fOpTb3AJ92YfMuVMk3VtQtucnyc
         WeF6Z35o9CcD+fsh2JtEmSrhXeediy1NniiqbJptEfq45VvvtOXHPVKjusNu4HMMoBXC
         CHYpVKAW42yRxwxbyVUQvVGwzhaw46d2jKslG9h9oQI15IMindO2vTldycnwE1V4VQlW
         dF8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GVroTBa/RDLMNit62OYeyl1hwDTywX684KnqperhLJ0=;
        b=DOncfwwuqpDvHExVd+fYlDpgRFwikcl+h/Uij9igK3R8GfmIadmbkFKL1DMsGAu8Je
         TLKzSVIr/KxhoEO45QpWrLOtHMGLNCWy5JC7KjGLcwqQIK53ZvGSywTE59c/luTugM+r
         DdqwpVCVy5VuK91/tkgIAuBGGvKpGBCct4wMcnu4d3EQiSvAZIvyq7te+So7UPzLe6Bp
         F+UMidKm0LuVyCkpYD+bM21abfMEMcvdluAKKhAgahC8Tk1Y74dNlIxhZUW3Drk1WejI
         Ye12VEUFZ56sRhUI7CwzrJ1d6xiw3H3gydC+nfU8l//7bINQap/PFgEPT/NvTqJa0KAL
         MFRA==
X-Gm-Message-State: AOAM533Cv6ldPrvyWO1Aja9+4FsgVIcolHEIe81yTH7e4CDbMtWw2Iu4
        KiHsYJEyHgkHuQFvXO9AwOTvoyrn58hzLKcy
X-Google-Smtp-Source: ABdhPJysDu/Y8r8jEY0r1n/+h2yMo4tuRHu2mdOTiCUa1sJv4dyYJnuG+Dz8/5wjkBbEz3rOODjJgg==
X-Received: by 2002:adf:e690:: with SMTP id r16mr21086562wrm.15.1600173959260;
        Tue, 15 Sep 2020 05:45:59 -0700 (PDT)
Received: from bender.baylibre.local (home.beaume.starnux.net. [82.236.8.43])
        by smtp.gmail.com with ESMTPSA id q8sm26548589wrx.79.2020.09.15.05.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 05:45:58 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com, devicetree@vger.kernel.org
Cc:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 2/4] dt-bindings: clk: axg-clkc: add MIPI DSI Host clock binding
Date:   Tue, 15 Sep 2020 14:45:51 +0200
Message-Id: <20200915124553.8056-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200915124553.8056-1-narmstrong@baylibre.com>
References: <20200915124553.8056-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the clock ID for the MIPI DSI Host clock.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 include/dt-bindings/clock/axg-clkc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/axg-clkc.h b/include/dt-bindings/clock/axg-clkc.h
index 281df3e0f131..e2749dbc74b8 100644
--- a/include/dt-bindings/clock/axg-clkc.h
+++ b/include/dt-bindings/clock/axg-clkc.h
@@ -96,5 +96,6 @@
 #define CLKID_VCLK2_DIV6			130
 #define CLKID_VCLK2_DIV12			131
 #define CLKID_CTS_ENCL				133
+#define CLKID_VDIN_MEAS				136
 
 #endif /* __AXG_CLKC_H */
-- 
2.22.0

