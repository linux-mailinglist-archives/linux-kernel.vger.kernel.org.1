Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1B452B5531
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 00:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730882AbgKPXiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 18:38:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730834AbgKPXiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 18:38:17 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7716C0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 15:38:16 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id j12so19311731iow.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 15:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JnfX7u3MtCHDWMgJ89/OD9n8QfiL8kOLSJS9DuzGPVg=;
        b=qUMzDmDIc/EKR5f1nLaZc2vwZR1z6ToDmIqHRQTci0szFx9P6CInIRgmOScBu0qC6o
         kQtt0qREClCYSSV5j4uWnDhn4Nfksv8yEoXpOJOf6XRMYNSGoimH7jsl3eL/P8mY727o
         ZDT5JP+9LYiXlYkB5C9DrRaRGcWznEn89/fAvwXM9mlD+N0gyUMME5bYouFm7DKlCnq5
         xfvbVPLRwyKWnsA7aL+6AdvtYYHMOPW5y6/k8Za7fuauJmB5u7Bd/8Q4cFNs8rZsEklj
         bHYrLktOso6/isLMHm3RpDpOQYDNX6FrljqJk+SgTUwgdGrGO7nS65g9GDl9Y9DbZUrx
         I57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JnfX7u3MtCHDWMgJ89/OD9n8QfiL8kOLSJS9DuzGPVg=;
        b=BXOBi3vEGqb0pLvvu6XPfl7J+GX3GxrbmPg5AEDnEpGYSVCj1yrHTtaT/fvmeuAL9r
         bVNCayMDmaAEVYWPhv6x1371QbBnQyqyLXSGwyO+d6zW++0XbBi5A+GmxWcnc31aXK1t
         qXjXA2rwtTkGgFQOiO/k9l55VOiWsxtOtLA3ULqdvvqt7p5PRvxE8FZcYyAqKoMc/3ub
         1RWcviDMGnpuew/cRyQ+MUDEW3SP4Kvmz0zW573OT3kb62O23uM23pJde4qoP72JPnXs
         Xy2tq7HeMbTgaE/eSfjSzGvp1foQWfZXH9ZM2SnhcEjt+ZCWqshL7RI8Fz/w6Js7VQJv
         kSUg==
X-Gm-Message-State: AOAM532rLn3KTpncu7P4o3niJIxovCSybr9gCgkC2f+bU8WirpteR6Mr
        cXH2d8T3wgKRiwPxiIi0CSTtEg==
X-Google-Smtp-Source: ABdhPJyhkCB/7BqVhC0LZxXQg/WNlwGhREvp0sK7pX2TXhzjq9NhxNcAK2DzsMW/4OTeFAB7/Nxgtg==
X-Received: by 2002:a05:6638:140f:: with SMTP id k15mr1574758jad.112.1605569896366;
        Mon, 16 Nov 2020 15:38:16 -0800 (PST)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id f18sm10180099ill.22.2020.11.16.15.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 15:38:15 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 01/11] net: ipa: share field mask values for IPA hash registers
Date:   Mon, 16 Nov 2020 17:37:55 -0600
Message-Id: <20201116233805.13775-2-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201116233805.13775-1-elder@linaro.org>
References: <20201116233805.13775-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IPA filter/routing hash enable register and filter/routing hash
flush register each have four single-bit fields representing the
four hashed tables to be enabled or flushed.  The field positions
are identical, so just use a single set of field masks to represent
the fields for both registers.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_reg.h   | 13 +++++--------
 drivers/net/ipa/ipa_table.c |  4 ++--
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ipa/ipa_reg.h b/drivers/net/ipa/ipa_reg.h
index 8eaf5f2096270..001961cd526bc 100644
--- a/drivers/net/ipa/ipa_reg.h
+++ b/drivers/net/ipa/ipa_reg.h
@@ -153,10 +153,6 @@ static inline u32 ipa_reg_state_aggr_active_offset(enum ipa_version version)
 
 /* The next register is present for IPA v4.2 and above */
 #define IPA_REG_FILT_ROUT_HASH_EN_OFFSET		0x00000148
-#define IPV6_ROUTER_HASH_EN			GENMASK(0, 0)
-#define IPV6_FILTER_HASH_EN			GENMASK(4, 4)
-#define IPV4_ROUTER_HASH_EN			GENMASK(8, 8)
-#define IPV4_FILTER_HASH_EN			GENMASK(12, 12)
 
 static inline u32 ipa_reg_filt_rout_hash_flush_offset(enum ipa_version version)
 {
@@ -166,10 +162,11 @@ static inline u32 ipa_reg_filt_rout_hash_flush_offset(enum ipa_version version)
 	return 0x000014c;
 }
 
-#define IPV6_ROUTER_HASH_FLUSH			GENMASK(0, 0)
-#define IPV6_FILTER_HASH_FLUSH			GENMASK(4, 4)
-#define IPV4_ROUTER_HASH_FLUSH			GENMASK(8, 8)
-#define IPV4_FILTER_HASH_FLUSH			GENMASK(12, 12)
+/* The next four fields are used for the hash enable and flush registers */
+#define IPV6_ROUTER_HASH_FMASK			GENMASK(0, 0)
+#define IPV6_FILTER_HASH_FMASK			GENMASK(4, 4)
+#define IPV4_ROUTER_HASH_FMASK			GENMASK(8, 8)
+#define IPV4_FILTER_HASH_FMASK			GENMASK(12, 12)
 
 #define IPA_REG_BCR_OFFSET				0x000001d0
 #define BCR_CMDQ_L_LACK_ONE_ENTRY		BIT(0)
diff --git a/drivers/net/ipa/ipa_table.c b/drivers/net/ipa/ipa_table.c
index b3790aa952a15..32e2d3e052d55 100644
--- a/drivers/net/ipa/ipa_table.c
+++ b/drivers/net/ipa/ipa_table.c
@@ -422,8 +422,8 @@ int ipa_table_hash_flush(struct ipa *ipa)
 		return -EBUSY;
 	}
 
-	val = IPV4_FILTER_HASH_FLUSH | IPV6_FILTER_HASH_FLUSH;
-	val |= IPV6_ROUTER_HASH_FLUSH | IPV4_ROUTER_HASH_FLUSH;
+	val = IPV4_FILTER_HASH_FMASK | IPV6_FILTER_HASH_FMASK;
+	val |= IPV6_ROUTER_HASH_FMASK | IPV4_ROUTER_HASH_FMASK;
 
 	ipa_cmd_register_write_add(trans, offset, val, val, false);
 
-- 
2.20.1

