Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 552052AE26F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 23:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731687AbgKJWEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 17:04:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgKJWEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 17:04:04 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFBCC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:04:02 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id 10so4720800wml.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=B0CXBxq6ZAXd5FkSitRtEvhYhUL6Gbj9G7WXdfEnSfk=;
        b=NlJ9XvyD6Efjbam4XOZs3RdXp05ThhueT/ZaAfUoMKZX64pwW0As4AmFTNl6g2zWJe
         wC5Bm3hw9m34pBqCwFvj16pMRJXAZdl5lMy3aYrkBb3PY7NT7GsiBrira9QCUNs4daIK
         /M1HUogRRusuSeQTPHUeg/mysiRlHVJXQv9KehIJka2f/8NGYnMvolZcekdO9xzTKv6X
         +DO7J0053yEKhnQYdnLLPHguoU6Svfj1zOiTF19paXgHIRfDn66UVo3+MGB+wDug3qHF
         QwJucbv+8toosdND8+bY/PFs196LPH14nzauL4IG6rQmDulhc5jH3nimS0u1aODDfkxu
         yL7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=B0CXBxq6ZAXd5FkSitRtEvhYhUL6Gbj9G7WXdfEnSfk=;
        b=nmC4KnBQllLUKgm1H26wNBQraJddpC66JhkC0JxmNmUQkYz+aXIUnLvl4mlYFt+yQC
         ZoXXEyw2fSVAdUDNqsXLc6rRifWxoUAW/1tAoOgKjl9GeAnTHhYFgdQ8CQ441K3f3Hrg
         78KaFautQd4IXqe7UCYUHv6dzB4imh8aU1AOCwC2udo4Qgx2RdjpDHZk2/DUWIk9UFKd
         E7C5U9smUO0qy3suIgD8j7Nz4wfKRtzx1WOOfveZhGq17kJzU6E5kaV4T2lpK3HOTwSM
         SzQ7OMjey7d1LQv7nbXp3Sdg6FA3VF01gVSJBuVEnnox7smQOPtDKSQ6h6xgwbShtG1a
         7Wtg==
X-Gm-Message-State: AOAM532/n3AUku09qlfQVi96qD61mwgXY+zaTS0Jt8yJJu/yBfu7AutL
        Y8eLbCZXU2GDzXsRiqNzWpY=
X-Google-Smtp-Source: ABdhPJyz+xBEcEYwW9IfiVU8hWIVZxGrSztwXDgxqYIFVTdPC+YiSm8Styk/xnzgJ7tM7nCJMYx1nA==
X-Received: by 2002:a7b:c845:: with SMTP id c5mr191433wml.135.1605045840978;
        Tue, 10 Nov 2020 14:04:00 -0800 (PST)
Received: from localhost.localdomain (host-92-5-241-147.as43234.net. [92.5.241.147])
        by smtp.gmail.com with ESMTPSA id v19sm79099wrf.40.2020.11.10.14.04.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Nov 2020 14:04:00 -0800 (PST)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] mm: fix build failure with xtensa
Date:   Tue, 10 Nov 2020 22:01:51 +0000
Message-Id: <20201110220151.20911-1-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_ZSMALLOC is enabled with xtensa then the build fails with:
mm/zsmalloc.c:43:10: fatal error: asm/sparsemem.h: No such file or directory

Disable CONFIG_ZSMALLOC for xtensa as xtensa arch has not defined
sparsemem.h.

Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---

Build failed with next-20201110.
Build log at https://travis-ci.org/github/sudipm-mukherjee/linux-next/jobs/742793855#L13375

 mm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index e8587f6bf29a..5b9426ba5e6a 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -698,7 +698,7 @@ config Z3FOLD
 
 config ZSMALLOC
 	tristate "Memory allocator for compressed pages"
-	depends on MMU
+	depends on (MMU && !XTENSA)
 	help
 	  zsmalloc is a slab-based memory allocator designed to store
 	  compressed RAM pages.  zsmalloc uses virtual memory mapping
-- 
2.11.0

