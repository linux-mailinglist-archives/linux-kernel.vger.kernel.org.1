Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 089602D2428
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 08:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgLHHQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 02:16:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbgLHHQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 02:16:03 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1AAC061285
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 23:14:50 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id c79so13047757pfc.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 23:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZNKLbQTe0EJyIiECa6jG2QS24SEV6zzCe3D1RGbycgk=;
        b=E2prpuFklZfHyH6uGERrJEd5U62cUHD6+jSRpRBvz9wsvtrC20j+4Fn+n7c+9o/lXu
         T5yP4WsFIHwhR58DpHjewsBB8ODHY5YQelCx/8hTqZaxBI0Nj6IUKBTCdxMU3lMIXV40
         UD5N2IdOVVT+6uZgX1HaqgHjfpoz6Y6QAYtMBYEc8UIDMkw9TvApqmqo8+ymwY52vRYn
         t2+RyX2Ynn5+6OQXehL0LYSq1RlE4AgZgnT84IFpzU86kL01Ez6OeTNKOWbE6G1xpyj2
         Kqrb4c1eSUcj+tQBvOTPsup8e2ez/3pF/0KIBktmOFpj7dI6DbyKiP3S23rtBnZAvBvC
         6uOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZNKLbQTe0EJyIiECa6jG2QS24SEV6zzCe3D1RGbycgk=;
        b=TO8Pa5EeXsCKuYozSk+qnZAyoIBRNknVcIF262j6xYQXjEL2VRqhFf/LV/5NkySuII
         zFmgOX+EDlzbnopx7ihCBRhOvOHORI/ATMcmXXzKRNSmYQ9ds/VHQpZjr99uYRlnxcqP
         W6k/zO+hzu+zTeVtXZCQAq1pyIt1AmhH9k0nDfDX0fE8BuzaSnDMTgxyMvlO0jia/rkK
         L9B5z9rnlpro4DGsOulot8oZhVjeiV8JOn+zvxOkOlqCCwhVl5vYDhylfvWk35jhG0VY
         gjVeq6OQQF/XpnK0Fv+hUqLYGTWA2d9pWsDukBcVqencCwUDMZFskv9XcvhmtXKzMaCP
         aPmA==
X-Gm-Message-State: AOAM531D7v7kOs/mHxRbB/cOUJrpY+siplVIqxgYGYl4tWgoffUXeavd
        ftkV4gK8DF/ehUx1AKNwPZNyuw==
X-Google-Smtp-Source: ABdhPJwhFnypmLLLO0205xPiuLXlp21n4FMLux8hU9cokIicnjaN5LG5pDAN3RD8U8cS1l0BYvhgew==
X-Received: by 2002:a63:782:: with SMTP id 124mr10202051pgh.187.1607411690374;
        Mon, 07 Dec 2020 23:14:50 -0800 (PST)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id gp17sm1801318pjb.0.2020.12.07.23.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 23:14:49 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com, sboyd@kernel.org,
        schwab@linux-m68k.org, pragnesh.patel@openfive.com,
        aou@eecs.berkeley.edu, mturquette@baylibre.com,
        yash.shah@sifive.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Zong Li <zong.li@sifive.com>,
        Pragnesh Patel <pragnesh.patel@sifive.com>
Subject: [PATCH v6 4/5] clk: sifive: Fix the wrong bit field shift
Date:   Tue,  8 Dec 2020 15:14:31 +0800
Message-Id: <20201208071432.55583-5-zong.li@sifive.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201208071432.55583-1-zong.li@sifive.com>
References: <20201208071432.55583-1-zong.li@sifive.com>
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

