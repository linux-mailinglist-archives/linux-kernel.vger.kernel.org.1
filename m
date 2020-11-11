Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7391F2AEE71
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 11:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbgKKKGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 05:06:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727375AbgKKKGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 05:06:25 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E44C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 02:06:25 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id u2so717277pls.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 02:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZNKLbQTe0EJyIiECa6jG2QS24SEV6zzCe3D1RGbycgk=;
        b=PeekuDgz0P2oQrbgHf0FCJsHiFPz2BZ5Cv0EpubvZV33MfWN9TBmNIoMvevKzpAKwl
         7LJeN/GGuGZ1R8SpAyvdx9PV6YbcoggRDY0x4w9xPXzQGeKz4WnDAw06gmxneyOgmKhA
         /lAFxcltub4Uf/tXXaz4ZpsXGpLrCoyGmwQFdiISsmB4SgURGnWWwnYgNloUH1NuXD4I
         fVbamNCDjQnkK9gW1s3b1+yDDha0yEI92ND4/KzlrlG4VVgfF5U6OOfUgRj2uq9OGYl7
         8ZzoZiJQdd8CKeidNnJUbHDKXKybBKhey4LHDnjRvLwKZchOpPaIBJl5Llx+6ySZtwDi
         Ww/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZNKLbQTe0EJyIiECa6jG2QS24SEV6zzCe3D1RGbycgk=;
        b=nSmumuJQyHjraWW5rE2baq+89zASznHNak2jWWHBWe8VuAHDo522eFMKVkEHNywHZd
         b+Q6K2fkUAueJyF5n8/PlubVW56Wkr1bQkm4xVt11leAepab/5aYMPqVIajllLybFQn9
         Qf7agyCI8LgXzqFdYzNXMnk/4qa3IYbciBvyX/hMMaCTqqbrE0F2qZN7VH07D0f2KlJa
         LgTOO//zbt1NYGI4tMDkzTNM/ZkBGhDKxQudAzO+yxF+UQyf+L9up7oE+eLGwa+2Tf+O
         4w+MNAwZKuXBeYxsHCt6yareyuEyTKO8FasuCAgmfG6rUGYet16ajvFKWldCL6lzw+px
         mp0A==
X-Gm-Message-State: AOAM533yKG4Q3H2MidoWd3GZVXXJiLaJhT6Rwz4r+aaXUlcTrD1EBqhg
        T4BJhHb/foAhQa/ipKWhqs/2hQ==
X-Google-Smtp-Source: ABdhPJyXKkTB6t7sDQgeqfdIEFT0KtFRUawfjJ4kwO8HBmsgEDtvRVY0BcyIF6ftITFc/IHnSOKd3Q==
X-Received: by 2002:a17:902:d3d4:b029:d7:e936:7651 with SMTP id w20-20020a170902d3d4b02900d7e9367651mr10846937plb.57.1605089185026;
        Wed, 11 Nov 2020 02:06:25 -0800 (PST)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id u22sm1872801pgf.24.2020.11.11.02.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 02:06:24 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com, sboyd@kernel.org,
        schwab@linux-m68k.org, pragnesh.patel@openfive.com,
        aou@eecs.berkeley.edu, mturquette@baylibre.com,
        yash.shah@sifive.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Zong Li <zong.li@sifive.com>,
        Pragnesh Patel <pragnesh.patel@sifive.com>
Subject: [PATCH v4 4/4] clk: sifive: Fix the wrong bit field shift
Date:   Wed, 11 Nov 2020 18:06:08 +0800
Message-Id: <20201111100608.108842-5-zong.li@sifive.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201111100608.108842-1-zong.li@sifive.com>
References: <20201111100608.108842-1-zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clk enable bit should be 31 instead of 24.

Signed-off-by: Zong Li <zong.li@sifive.com>
Reported-by: Pragnesh Patel <pragnesh.patel@sifive.com>
---
 drivers/clk/sifive/sifive-prci.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/sifive/sifive-prci.h b/drivers/clk/sifive/sifive-prci.h
index 802fc8fb9c09..da7be9103d4d 100644
--- a/drivers/clk/sifive/sifive-prci.h
+++ b/drivers/clk/sifive/sifive-prci.h
@@ -59,7 +59,7 @@
 
 /* DDRPLLCFG1 */
 #define PRCI_DDRPLLCFG1_OFFSET		0x10
-#define PRCI_DDRPLLCFG1_CKE_SHIFT	24
+#define PRCI_DDRPLLCFG1_CKE_SHIFT	31
 #define PRCI_DDRPLLCFG1_CKE_MASK	(0x1 << PRCI_DDRPLLCFG1_CKE_SHIFT)
 
 /* GEMGXLPLLCFG0 */
@@ -81,7 +81,7 @@
 
 /* GEMGXLPLLCFG1 */
 #define PRCI_GEMGXLPLLCFG1_OFFSET	0x20
-#define RCI_GEMGXLPLLCFG1_CKE_SHIFT	24
+#define RCI_GEMGXLPLLCFG1_CKE_SHIFT	31
 #define PRCI_GEMGXLPLLCFG1_CKE_MASK	(0x1 << PRCI_GEMGXLPLLCFG1_CKE_SHIFT)
 
 /* CORECLKSEL */
-- 
2.29.2

