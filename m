Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 628562CA805
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 17:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392044AbgLAQSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 11:18:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390720AbgLAQSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 11:18:04 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27B7C061A04
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 08:16:57 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id x15so1421794pll.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 08:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s2vaNiCstBIb+WWFV0QIyynMgzg46gv0imUofC6H27w=;
        b=bNqGOi6Pb8cXVBRjb+IHzu2v9idq3SGrmXDH6tXU2y92TwY8fPJFE/1ljNTHCmgNNb
         P3nAOxBHWfSpzgMF8QuWDIz6eBzz09+UB7Z0DKgwf6pu5PUdVu01EdDbfq2RWwCnfRwB
         69VVIgRLfSY3qVdtfWZEiLuOFVsDUxcn5N8KI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s2vaNiCstBIb+WWFV0QIyynMgzg46gv0imUofC6H27w=;
        b=iFHY3wIVAaXTt/uz68cWWkvZhQQaXXM4zcNIxJGahrK3vRm1XYJTgwzd2LRHtIpJuy
         46OE91sIWBsTIFyySn1K2l/bKQWYFYHrljFI3OTE4g1S3EMqtf0cx9JX/5UW6cBbvcH8
         1Yl6BHVrJMrA0Rk/V1p6hhtxmdCMzIoASsP8CCPGWyD7Bm2ibKN64Yxl6P+PGo/cE41T
         F5CCVl3izM25eoseHz9snlvJuWCG2PqnwBcM2/CbcdQS8kb+Ggnw29oqVfPCzkL7tAlD
         9DZpY8T8imr/QellfNOR494GooD8b2ic/r3UIjL+vuKTHNKMYVFQmgeUwFrkHHOGAm4B
         AWLw==
X-Gm-Message-State: AOAM5338kcHvlpYlbYq3+Iq7uWy09U3HgbuxkNIauqoa/qL0C6QRtxOy
        4NCmX7GPwkL0g8i9fZi3DQemdnt4JuiDbA==
X-Google-Smtp-Source: ABdhPJwScxtBHY4y6Tf+/sQF0B387gZklp4alOnvPWLxpndNFLBZZOLN05k7yFY2t7oWsub/0S+/yg==
X-Received: by 2002:a17:902:6b84:b029:d8:d13d:14e with SMTP id p4-20020a1709026b84b02900d8d13d014emr3544651plk.29.1606839417392;
        Tue, 01 Dec 2020 08:16:57 -0800 (PST)
Received: from localhost (2001-44b8-111e-5c00-f932-2db6-916f-25e2.static.ipv6.internode.on.net. [2001:44b8:111e:5c00:f932:2db6:916f:25e2])
        by smtp.gmail.com with ESMTPSA id y5sm220594pfl.114.2020.12.01.08.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 08:16:56 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
        christophe.leroy@c-s.fr, aneesh.kumar@linux.ibm.com,
        bsingharora@gmail.com
Cc:     Daniel Axtens <dja@axtens.net>
Subject: [PATCH v9 5/6] powerpc/mm/kasan: rename kasan_init_32.c to init_32.c
Date:   Wed,  2 Dec 2020 03:16:31 +1100
Message-Id: <20201201161632.1234753-6-dja@axtens.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201201161632.1234753-1-dja@axtens.net>
References: <20201201161632.1234753-1-dja@axtens.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kasan is already implied by the directory name, we don't need to
repeat it.

Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/mm/kasan/Makefile                       | 2 +-
 arch/powerpc/mm/kasan/{kasan_init_32.c => init_32.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename arch/powerpc/mm/kasan/{kasan_init_32.c => init_32.c} (100%)

diff --git a/arch/powerpc/mm/kasan/Makefile b/arch/powerpc/mm/kasan/Makefile
index bb1a5408b86b..42fb628a44fd 100644
--- a/arch/powerpc/mm/kasan/Makefile
+++ b/arch/powerpc/mm/kasan/Makefile
@@ -2,6 +2,6 @@
 
 KASAN_SANITIZE := n
 
-obj-$(CONFIG_PPC32)           += kasan_init_32.o
+obj-$(CONFIG_PPC32)           += init_32.o
 obj-$(CONFIG_PPC_8xx)		+= 8xx.o
 obj-$(CONFIG_PPC_BOOK3S_32)	+= book3s_32.o
diff --git a/arch/powerpc/mm/kasan/kasan_init_32.c b/arch/powerpc/mm/kasan/init_32.c
similarity index 100%
rename from arch/powerpc/mm/kasan/kasan_init_32.c
rename to arch/powerpc/mm/kasan/init_32.c
-- 
2.25.1

