Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2EBB2AFCD8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 02:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbgKLBfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 20:35:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbgKKXSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 18:18:53 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC84C061A04
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 15:17:38 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id w4so2485008pgg.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 15:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/dH9UFeMcV0a7tddK7fnFsE7nDzUadvL2LHVz1gwfBA=;
        b=D+wRmxYZrPfTbf41Qmtf1+vmy2kzme8lZxYy3ksDEbqQHwSJOMCebWpr1gA/vmrMm+
         tDCm5ZgB/Fl5OoYUPFoh6KP+IknLBrP2Fq4vxJ73OYKrB+Jw0uIWwhL119anNT+qO0Ic
         Vz4aUoqQxjNhisZUEoKayGKHzMgBclLy/doSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/dH9UFeMcV0a7tddK7fnFsE7nDzUadvL2LHVz1gwfBA=;
        b=oT8phQsxAffBrS/J8uj3oSBBmTL63OKszV/4xAiPeXLc8nwon6G8TyxphtbFb6hhX6
         Tm+Nf2X9PJ5Cn20ES6KCQ117XtP00vg6XIGEMKUNoI65AymVF0PbcTwh2BlfTaUCb7F1
         mubLexo8JYjMbZCUHRIIaoIxFKULMlWvBU1634jzz2ZZxcwyLk1imp8/Q8snjIsE+2aD
         JbQh39P1dx89Pwh8mgnjD6lU6EmilN+bjpVKKs7m+fQllkaNuFbqJkSA7j0KRAuZYPsU
         mFXunL7ogxzCBlwMmaofDcMijL0svYpDBIxqXpjQBrWHuWicLVvsugnxYyouat/80WIA
         J9TQ==
X-Gm-Message-State: AOAM530yfcgGiZ8QJwZQm6c0lFGUsc+XjZ/gZYMUGHjvxcarntogjFxz
        v2Spcc6Rw29zoaq02dSpKM2uOA==
X-Google-Smtp-Source: ABdhPJzAPl6ZoAkCbGuV9SAr61vyMVKE17gM4tkTNAy5+MS06IM7oE/N+KKYUXJiE4JYSroLrp79Aw==
X-Received: by 2002:a17:90b:88b:: with SMTP id bj11mr4403117pjb.229.1605136657834;
        Wed, 11 Nov 2020 15:17:37 -0800 (PST)
Received: from evgreen-glaptop.cheshire.ch ([2601:646:c780:1404:250:b6ff:fee1:7d4c])
        by smtp.gmail.com with ESMTPSA id q8sm3612226pjy.3.2020.11.11.15.17.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Nov 2020 15:17:37 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     Andy Shevchenko <andy@kernel.org>
Cc:     Evan Green <evgreen@chromium.org>, stable@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] pinctrl: intel: Fix Jasperlake HOSTSW_OWN offset
Date:   Wed, 11 Nov 2020 15:17:28 -0800
Message-Id: <20201111151650.v2.1.I54a30ec0a7eb1f1b791dc9d08d5e8416a1e8e1ef@changeid>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIOs that attempt to use interrupts get thwarted with a message like:
"pin 161 cannot be used as IRQ" (for instance with SD_CD). This is because
the HOSTSW_OWN offset is incorrect, so every GPIO looks like it's
owned by ACPI.

Fixes: e278dcb7048b1 ("pinctrl: intel: Add Intel Jasper Lake pin controller support")
Cc: stable@vger.kernel.org
Signed-off-by: Evan Green <evgreen@chromium.org>
---

Changes in v2:
- Commit text rewording [Andy]

 drivers/pinctrl/intel/pinctrl-jasperlake.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/intel/pinctrl-jasperlake.c b/drivers/pinctrl/intel/pinctrl-jasperlake.c
index 9bd0e8e6310c3..283698cf0dc7d 100644
--- a/drivers/pinctrl/intel/pinctrl-jasperlake.c
+++ b/drivers/pinctrl/intel/pinctrl-jasperlake.c
@@ -16,7 +16,7 @@
 
 #define JSL_PAD_OWN	0x020
 #define JSL_PADCFGLOCK	0x080
-#define JSL_HOSTSW_OWN	0x0b0
+#define JSL_HOSTSW_OWN	0x0c0
 #define JSL_GPI_IS	0x100
 #define JSL_GPI_IE	0x120
 
-- 
2.26.2

