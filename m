Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA63D2CA800
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 17:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404104AbgLAQR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 11:17:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404098AbgLAQR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 11:17:27 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9627C0613D4
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 08:16:41 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id v3so1374891plz.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 08:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N0YdCjkJ51EOhZtuBaCrGJ/RvqotXRv8loSeq+0K1Lw=;
        b=aaIMgn1kMgD56TG5g0Vi0ZkKk6tnzbIUF1pfDYVYgvX7pggmfVvYYTd1Op8oEFa5Qn
         jcyh85859ruNoHIygqJnBsOe9WlQuE2aD0H/iS7qoLbb2lx86xlSuSMhjpkFrtqevRS5
         9nqF6NnLxd0AtaCPpFxA7HmRVmDGrNM1bGLas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N0YdCjkJ51EOhZtuBaCrGJ/RvqotXRv8loSeq+0K1Lw=;
        b=KYZ25F15lEH0Ovq4seov0eQcCKKCmzvxXHX+NpRkIWL9bk6WoTkuF4b3VGywOtXvCL
         oIHATQsVNFEb0LKIGlw2d9BSEU9oCMwOo4kVAh91DJYEhQiOGnav6+4kpWQEMubQ4qIU
         MYJlF2UFQSc21JD0jiIPxNz4SAcLtBHafiBqELvuQ/fKWGqzhPG4vh+Qmfe99bpIy1nJ
         Ie2uV1Fw984qc0nBAGJik54UBgL6z8nqiqQSKHYmQQ/wbuslD151akiptwBaGtVlfcXy
         R0QvbQ0BHuDDKegkWUWavoCPFrPFdmofLAp2sWfvm8ixw/byE5cROr27VRz34Sgq/rVb
         ra+w==
X-Gm-Message-State: AOAM531NCKUPDySjMfMQ+EAQpdoDyna45v7pABINk+MO6RbM7sRI8LzM
        AzpIekDcKR52C4H89eGO9fL6AUmOKOtXYw==
X-Google-Smtp-Source: ABdhPJyXoEkCjSN+IDdIpKLJVoutR17sCfVu7a/oC94ndZZBF9Z2S63HRCawbS5ZfYp8mS2kuNDaTg==
X-Received: by 2002:a17:90a:a2e:: with SMTP id o43mr3337563pjo.59.1606839401186;
        Tue, 01 Dec 2020 08:16:41 -0800 (PST)
Received: from localhost (2001-44b8-111e-5c00-f932-2db6-916f-25e2.static.ipv6.internode.on.net. [2001:44b8:111e:5c00:f932:2db6:916f:25e2])
        by smtp.gmail.com with ESMTPSA id q72sm222708pfq.62.2020.12.01.08.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 08:16:40 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
        christophe.leroy@c-s.fr, aneesh.kumar@linux.ibm.com,
        bsingharora@gmail.com
Cc:     Daniel Axtens <dja@axtens.net>
Subject: [PATCH v9 1/6] kasan: allow an architecture to disable inline instrumentation
Date:   Wed,  2 Dec 2020 03:16:27 +1100
Message-Id: <20201201161632.1234753-2-dja@axtens.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201201161632.1234753-1-dja@axtens.net>
References: <20201201161632.1234753-1-dja@axtens.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For annoying architectural reasons, it's very difficult to support inline
instrumentation on powerpc64.

Add a Kconfig flag to allow an arch to disable inline. (It's a bit
annoying to be 'backwards', but I'm not aware of any way to have
an arch force a symbol to be 'n', rather than 'y'.)

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 lib/Kconfig.kasan | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index 542a9c18398e..31a0b28f6c2b 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -9,6 +9,9 @@ config HAVE_ARCH_KASAN_SW_TAGS
 config	HAVE_ARCH_KASAN_VMALLOC
 	bool
 
+config HAVE_ARCH_NO_KASAN_INLINE
+	def_bool n
+
 config CC_HAS_KASAN_GENERIC
 	def_bool $(cc-option, -fsanitize=kernel-address)
 
@@ -108,6 +111,7 @@ config KASAN_OUTLINE
 
 config KASAN_INLINE
 	bool "Inline instrumentation"
+	depends on !HAVE_ARCH_NO_KASAN_INLINE
 	help
 	  Compiler directly inserts code checking shadow memory before
 	  memory accesses. This is faster than outline (in some workloads
-- 
2.25.1

