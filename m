Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 577262E79F8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 15:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgL3ObE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 09:31:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgL3ObD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 09:31:03 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43810C061799
        for <linux-kernel@vger.kernel.org>; Wed, 30 Dec 2020 06:30:23 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id m6so9769562pfm.6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Dec 2020 06:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=T4dQxuzV5VdvddqhfOaNjgaLY8qslqXfAmtRnLsrwqU=;
        b=IpBXCyqs51xIib/ZdHBWyQJI9wGIIlIKNy7jIsNu3TTDVOwLiwUgEvWDy3byeNqMcc
         Gn1CXIPI0Z2q1z1K8OLInS5YdFGfbrmzmf0zcKe6mcfuuDTHQPNgNH33x1KhN8a44l7O
         EMz2y2/6LbsLM81MGS0yGTP3ck68gTtjobaDkDRfaaLBCFpMjrRrIuVPNY0o8UuLEuzZ
         N3JVIhzLXo02KI0amM9QuRIdIC0Jf3RcqlVuz6K2I8YyxfmurpGMq4Az4y8Kgn5w3PuI
         A1S+v5iOGuy3qeLV07c6CDeFJEKbVUB/vfQVJ+gs6Ho9MhQzFhBSKiADbhVlG79kHC79
         W7IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=T4dQxuzV5VdvddqhfOaNjgaLY8qslqXfAmtRnLsrwqU=;
        b=RWTa9Y5N+IAp8g1KxI0NDVPopew7tZfbb9gVNYwXKk28Im4aGw/hKNtjIwcN+eLAHq
         pyN7uXwgmlUKM/24PkzDgLLa4G23TfI6gRuOnNHwXItvbfIw7xtpMoAXQpswCy0l1Laq
         OUhbFSv5bFS1XU1vo9kj0AHKmF+BDjsDmJTRg5hrkgBn5uIBVviwugGvf4lHgqs8REeH
         mSumhe0aa+afLd5pcBMYS4ENIvawjRMVlWl4Xt1wpvg2GWNwVVl9NyZIYbJHGSL5l6Tt
         1JinRrrC9uE48H3VG5/j39K0Tzno4qahiPyPE4XCG6ZyYDiBNYjiM9S2HZrzCKot8m9D
         M5+A==
X-Gm-Message-State: AOAM531Y+LfcGbf300sP5/ekv0SMXdvDDMXPPY9cJi+CiSQL/TA2wprG
        3m5qhOJFjt1RMseKpuYtlR8=
X-Google-Smtp-Source: ABdhPJy+LaaIcbLSz11mmlWvK7xH1vAPyvKADmOEupdGJCUoaH6TqiSIWZp4wIFScXxZfRJke6E9WA==
X-Received: by 2002:a63:9dcf:: with SMTP id i198mr52075436pgd.242.1609338622060;
        Wed, 30 Dec 2020 06:30:22 -0800 (PST)
Received: from localhost ([13.94.42.177])
        by smtp.gmail.com with ESMTPSA id h4sm49825819pgp.8.2020.12.30.06.30.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Dec 2020 06:30:21 -0800 (PST)
From:   Qiujun Huang <hqjagain@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Cc:     Qiujun Huang <hqjagain@gmail.com>
Subject: [PATCH] smp: Fix the description for raw_smp_processor_id()
Date:   Wed, 30 Dec 2020 22:30:15 +0800
Message-Id: <20201230143015.32149-1-hqjagain@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/raw_processor_id/raw_smp_processor_id/

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
---
 include/linux/smp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/smp.h b/include/linux/smp.h
index 70c6f6284dcf..081a9d98e1e3 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -197,7 +197,7 @@ static inline int get_boot_cpu_id(void)
 #endif /* !SMP */
 
 /**
- * raw_processor_id() - get the current (unstable) CPU id
+ * raw_smp_processor_id() - get the current (unstable) CPU id
  *
  * For then you know what you are doing and need an unstable
  * CPU id.
-- 
2.17.1

