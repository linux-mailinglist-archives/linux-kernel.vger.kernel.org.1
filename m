Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 428252ACB59
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 03:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730305AbgKJC4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 21:56:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbgKJC4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 21:56:06 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1DEC0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 18:56:06 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id 10so10072743pfp.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 18:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=10dhqypAgXKLqnQc/Ojgnp2H1LV7b1aG71TKjLfXWtM=;
        b=gWWeHTLiHwPrViViLz3noob5AhWPsr8rnxg1oN48xMXTcobUuKzrbKSmRwVjJkXIpe
         0ZXs7RUVg3B9K1kPXx6iEs8emZdybNukF5xLe7bfd/FCTl5nZam+nn9SWZqmp0kUduce
         2FE5PCyHRb37ks+FHJrM1M0J2p3/4tLoSdX85tN9u6cH4YV2VbCKZG2opLoP3TomOgwC
         Ln6c+0eZ7S5LarN0D0eYP3WYOIzJ1AU/Fued4CB/8bxvbz0ZSnh/kG0QtJKddgctE6fT
         PHu9S/DbnoDfZM06IU6IKf8at8GBhB9ZPP32hgdEmcXFoJTAZ9ibLejWbtTI05mnj0CX
         PSzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=10dhqypAgXKLqnQc/Ojgnp2H1LV7b1aG71TKjLfXWtM=;
        b=b7DmsG7/MIbiv6TspVyyxsZLkhs+4uZKeUCN6l/IHIBPti5ODtwsBE+a0YQgWRSNIh
         w/KPlM5k+2oFsb3oEjt96AEidpt2QQzObchdfvC0lLm7QNU/4yfj8EpsVdK+eAi3EFcN
         x5hNhnMS66YrugdSaAzJSsMwNZSEfqEwQ4+FpLJaTjZBc2qAhuRFRobLjcFZVizXBLzy
         BMPpoc56T3r1VzJtN/CL8fSCuu7EYmP5XN6FFBXPXc0LxkxVOrysDogKI43+zMdsdHvr
         Hl13lEqVZ5PokEcf4uzLSNfgmDoa3L81QZj3fzHD8xqGmxvkB387sBF8fMfKVxdXKeIZ
         EhXQ==
X-Gm-Message-State: AOAM532f7/K4BnpnlsJHSRPfXQj0pNDqv8iEuLRg1iO8Rq52MY2wYkQ9
        +RbSQIeKNJT/S95lHyjiJw==
X-Google-Smtp-Source: ABdhPJxGLd96DmACzpGMPyv3gfQnc7fyfkF5dYrFJKuIMk9THqi9LLX9IXGDwl619kCYT6eodO/T5Q==
X-Received: by 2002:a17:90a:7784:: with SMTP id v4mr2582765pjk.60.1604976966173;
        Mon, 09 Nov 2020 18:56:06 -0800 (PST)
Received: from he-cluster.localdomain (67.216.221.250.16clouds.com. [67.216.221.250])
        by smtp.gmail.com with ESMTPSA id t32sm11812552pgl.0.2020.11.09.18.56.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Nov 2020 18:56:05 -0800 (PST)
From:   xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH] powerpc/mm: Fix comparing pointer to 0 warning
Date:   Tue, 10 Nov 2020 10:56:01 +0800
Message-Id: <1604976961-20441-1-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kaixu Xia <kaixuxia@tencent.com>

Fixes coccicheck warning:

./arch/powerpc/mm/pgtable_32.c:87:11-12: WARNING comparing pointer to 0

Avoid pointer type value compared to 0.

Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 arch/powerpc/mm/pgtable_32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 079159e97bca..888b9713a316 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -84,7 +84,7 @@ int __ref map_kernel_page(unsigned long va, phys_addr_t pa, pgprot_t prot)
 		pg = pte_alloc_kernel(pd, va);
 	else
 		pg = early_pte_alloc_kernel(pd, va);
-	if (pg != 0) {
+	if (pg) {
 		err = 0;
 		/* The PTE should never be already set nor present in the
 		 * hash table
-- 
2.20.0

