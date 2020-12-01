Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF8152CA802
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 17:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404120AbgLAQRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 11:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404098AbgLAQRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 11:17:34 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F444C0617A7
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 08:16:54 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id k11so1465255pgq.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 08:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B3cGCHzxS7oj9LZKxlOIS4CcjJY/Vd95YR2IG8LQpYg=;
        b=IHx2W6Gs1iR719luXIlgneTcg2D0BEi//HtPJ+UbArGz1pUuPZAAj+eGlslDU6pYhi
         /IFmMrXQa5kzgg3OOhe0nCzXtB3zOZM/i2vpDixY7zz3EyccyiUM/qox7gQ/uoVzFZSV
         xZuVzmh/W9/uwtD8kUV+XZxJx439LBWHXVFZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B3cGCHzxS7oj9LZKxlOIS4CcjJY/Vd95YR2IG8LQpYg=;
        b=rEb1BksMkPxNHvz311njrBqWqVCVIn1t6ZxEMkxSdwlLKoWgmHMN1gIbe+S+W7jmfT
         7hv8T/p/yNguro8bsRqA39iJIwRsEXZDograbQW6E3ZXrsdma2IP2HkZnPT/yP06oMPY
         04+SAJZEqaEH2Lkt8zSIa9YX7GUfO8A4Yt+cwxSyft7C8vH0+IjZk7W1B2EEFWqJkQo2
         a+zznirIIrsfcrUOm8nI0FUrF7hxjSAQgS1HMlsBIZGSOX7j4+z9OkCEXlu3zUMWLl8z
         HUqLSaMtemyGrKp/ZSsFYyyipA30SzCvbdpgo/oQborZUvx6mim5EBznXsrmdLfZIppt
         XTnw==
X-Gm-Message-State: AOAM530bbLK5l+Jr+sy4omy+V/RS1Zp6T1sWDlzB2Am8pwXP6hcTdOgw
        V6zYH+d9Hfjv1Zc7mO2SC2eu/WXZFttpuQ==
X-Google-Smtp-Source: ABdhPJwrA3YHSUmJRi5GEZqfh2/A24D2qfQRXKs0pu9yHzHzLmvDKS+8BCRbVAmsWDRGY8s2k7jCOw==
X-Received: by 2002:aa7:868e:0:b029:197:cc73:6f15 with SMTP id d14-20020aa7868e0000b0290197cc736f15mr3168859pfo.18.1606839413794;
        Tue, 01 Dec 2020 08:16:53 -0800 (PST)
Received: from localhost (2001-44b8-111e-5c00-f932-2db6-916f-25e2.static.ipv6.internode.on.net. [2001:44b8:111e:5c00:f932:2db6:916f:25e2])
        by smtp.gmail.com with ESMTPSA id p14sm64656pgm.69.2020.12.01.08.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 08:16:53 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
        christophe.leroy@c-s.fr, aneesh.kumar@linux.ibm.com,
        bsingharora@gmail.com
Cc:     Daniel Axtens <dja@axtens.net>
Subject: [PATCH v9 4/6] kasan: Document support on 32-bit powerpc
Date:   Wed,  2 Dec 2020 03:16:30 +1100
Message-Id: <20201201161632.1234753-5-dja@axtens.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201201161632.1234753-1-dja@axtens.net>
References: <20201201161632.1234753-1-dja@axtens.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KASAN is supported on 32-bit powerpc and the docs should reflect this.

Document s390 support while we're at it.

Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 Documentation/dev-tools/kasan.rst |  7 +++++--
 Documentation/powerpc/kasan.txt   | 12 ++++++++++++
 2 files changed, 17 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/powerpc/kasan.txt

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index 2b68addaadcd..eaf868094a8e 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -19,7 +19,8 @@ out-of-bounds accesses for global variables is only supported since Clang 11.
 Tag-based KASAN is only supported in Clang.
 
 Currently generic KASAN is supported for the x86_64, arm64, xtensa, s390 and
-riscv architectures, and tag-based KASAN is supported only for arm64.
+riscv architectures. It is also supported on 32-bit powerpc kernels. Tag-based
+KASAN is supported only on arm64.
 
 Usage
 -----
@@ -255,7 +256,9 @@ CONFIG_KASAN_VMALLOC
 ~~~~~~~~~~~~~~~~~~~~
 
 With ``CONFIG_KASAN_VMALLOC``, KASAN can cover vmalloc space at the
-cost of greater memory usage. Currently this is only supported on x86.
+cost of greater memory usage. Currently this supported on x86, s390
+and 32-bit powerpc. It is optional, except on 32-bit powerpc kernels
+with module support, where it is required.
 
 This works by hooking into vmalloc and vmap, and dynamically
 allocating real shadow memory to back the mappings.
diff --git a/Documentation/powerpc/kasan.txt b/Documentation/powerpc/kasan.txt
new file mode 100644
index 000000000000..26bb0e8bb18c
--- /dev/null
+++ b/Documentation/powerpc/kasan.txt
@@ -0,0 +1,12 @@
+KASAN is supported on powerpc on 32-bit only.
+
+32 bit support
+==============
+
+KASAN is supported on both hash and nohash MMUs on 32-bit.
+
+The shadow area sits at the top of the kernel virtual memory space above the
+fixmap area and occupies one eighth of the total kernel virtual memory space.
+
+Instrumentation of the vmalloc area is optional, unless built with modules,
+in which case it is required.
-- 
2.25.1

