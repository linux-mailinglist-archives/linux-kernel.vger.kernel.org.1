Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 917D52FCE09
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 11:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731911AbhATKQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 05:16:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731422AbhATJcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 04:32:15 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095DCC061795
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 01:30:50 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id l12so17142938wry.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 01:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mIiZ6UdkfZ1pzms9iuBNbuiycjVakqbZxBNbxqLfJT0=;
        b=XmAXV4QTvia9d7Vz/pwW/8VDwM1KnqnvenvY8gWiIM4kU7VmW018gvcjDYTBZDGLvn
         UNJcx0c3Lwhntubpnh/K+KYhcJaeWY30f+AL9iD/SAeDtsB+S61sU2SMHk4dn5mOwoS/
         gkuzsCjm1midnauwlSPHSouHc3o7UsEj4f9W0dnnIiKfXnzmqv8zUTrmowL2VUJ7/PcX
         ltN/5JSGkyzRH5oWfc+tLKMCHxJvUC2JP9R0B39FOMBN5sBg/4OF6GEtcKxF+osaJtry
         HvD73sMOxl1aYjWXlzgbgZ61Eb+G6SNv9ppWLJiTsd4DVDv9n9S2C8z0CY6ankFpaOJP
         ey1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mIiZ6UdkfZ1pzms9iuBNbuiycjVakqbZxBNbxqLfJT0=;
        b=SBi8Mm1cT6kPK8oxS1Zo9jVyZDHTJflnhevoH94zCFGWV+vSfQJH0C/+6EM63+QJ+C
         zF7Ogte4bB/wFY8n/YRvk83Gv24PfE+cDIdDgkm1xgLLg/03czUhT5hg+5JkjOgh4pI0
         wC0kYouLaWny2TIYNOY5wjZdFTll9B47tj+YrvLo627oU588qr4m+pvZZTgcA9jD5rMd
         jTYK0VRm5oqUpHlCe9ftyKLVjMh+lZNdAccrrmvjhhzbBY6JDuWbrfcd3627TYQXttw2
         1ZPL64jNkxQ50vhK0zYG9cPM2bMPuRIaHDwOP4w/yx1rK6qb9Iy+nt4zB9bpja1/BXO9
         Ql+g==
X-Gm-Message-State: AOAM530AkhikPVwgf6vyexd184Tgii3MAQBnxzeshjei36/QBOpFERQL
        UbuysZrn4rfDh2BiMuNyi1nemQ==
X-Google-Smtp-Source: ABdhPJzb9TpEAlS6uB5qzU34JkRauMRiiiQnVSqfLKRcLm1T15iP+zYNBDZVnTR85MF/1qEjQkO7nQ==
X-Received: by 2002:a5d:6311:: with SMTP id i17mr6328988wru.195.1611135048804;
        Wed, 20 Jan 2021 01:30:48 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id z130sm2889201wmb.33.2021.01.20.01.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 01:30:48 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH 04/20] clk: rockchip: clk-half-divider: Demote non-conformant kernel-doc header
Date:   Wed, 20 Jan 2021 09:30:24 +0000
Message-Id: <20210120093040.1719407-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210120093040.1719407-1-lee.jones@linaro.org>
References: <20210120093040.1719407-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/clk/rockchip/clk-half-divider.c:168: warning: Function parameter or member 'name' not described in 'rockchip_clk_register_halfdiv'
 drivers/clk/rockchip/clk-half-divider.c:168: warning: Function parameter or member 'parent_names' not described in 'rockchip_clk_register_halfdiv'
 drivers/clk/rockchip/clk-half-divider.c:168: warning: Function parameter or member 'num_parents' not described in 'rockchip_clk_register_halfdiv'
 drivers/clk/rockchip/clk-half-divider.c:168: warning: Function parameter or member 'base' not described in 'rockchip_clk_register_halfdiv'
 drivers/clk/rockchip/clk-half-divider.c:168: warning: Function parameter or member 'muxdiv_offset' not described in 'rockchip_clk_register_halfdiv'
 drivers/clk/rockchip/clk-half-divider.c:168: warning: Function parameter or member 'mux_shift' not described in 'rockchip_clk_register_halfdiv'
 drivers/clk/rockchip/clk-half-divider.c:168: warning: Function parameter or member 'mux_width' not described in 'rockchip_clk_register_halfdiv'
 drivers/clk/rockchip/clk-half-divider.c:168: warning: Function parameter or member 'mux_flags' not described in 'rockchip_clk_register_halfdiv'
 drivers/clk/rockchip/clk-half-divider.c:168: warning: Function parameter or member 'div_shift' not described in 'rockchip_clk_register_halfdiv'
 drivers/clk/rockchip/clk-half-divider.c:168: warning: Function parameter or member 'div_width' not described in 'rockchip_clk_register_halfdiv'
 drivers/clk/rockchip/clk-half-divider.c:168: warning: Function parameter or member 'div_flags' not described in 'rockchip_clk_register_halfdiv'
 drivers/clk/rockchip/clk-half-divider.c:168: warning: Function parameter or member 'gate_offset' not described in 'rockchip_clk_register_halfdiv'
 drivers/clk/rockchip/clk-half-divider.c:168: warning: Function parameter or member 'gate_shift' not described in 'rockchip_clk_register_halfdiv'
 drivers/clk/rockchip/clk-half-divider.c:168: warning: Function parameter or member 'gate_flags' not described in 'rockchip_clk_register_halfdiv'
 drivers/clk/rockchip/clk-half-divider.c:168: warning: Function parameter or member 'flags' not described in 'rockchip_clk_register_halfdiv'
 drivers/clk/rockchip/clk-half-divider.c:168: warning: Function parameter or member 'lock' not described in 'rockchip_clk_register_halfdiv'

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: linux-clk@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-rockchip@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/clk/rockchip/clk-half-divider.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-half-divider.c b/drivers/clk/rockchip/clk-half-divider.c
index ccd5c270c2132..64f7faad2148f 100644
--- a/drivers/clk/rockchip/clk-half-divider.c
+++ b/drivers/clk/rockchip/clk-half-divider.c
@@ -145,7 +145,7 @@ static const struct clk_ops clk_half_divider_ops = {
 	.set_rate = clk_half_divider_set_rate,
 };
 
-/**
+/*
  * Register a clock branch.
  * Most clock branches have a form like
  *
-- 
2.25.1

