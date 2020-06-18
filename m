Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB0731FF1BF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jun 2020 14:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbgFRM2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jun 2020 08:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727853AbgFRM0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 08:26:45 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4A8C0617BB
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 05:26:16 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id q2so3415491wrv.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 05:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eoJNhGWephHh2kHxeUxYOokymywaEEsB1soK0bgoMag=;
        b=TEXYXyhlg3yz0B8UIHkZXn6oAo3avJRrYkTyA9xaGkqdf5nonfGKN+VqZuKiArfpyg
         C4p/meD1W8zwxsQnM57O6GwJ4OdMceJ9XCYBBSHM7mMozUWAEhbCA6F0qm/dj2K9xK/e
         k/mK2fqb1vNFuJxs07bips/lRohz68SPOfmnqdd/TRIFyt5B/5+ceGinZ5PANTif+PWr
         EsACQ5qWGE413ytIYmfBVWTRRrjBhtqAGsGUFtYXw/Qx7SCxH8auMx0siwVhfPpoacYz
         Z4e+upQ9X957zGzIo//NEh3QnseeF0MDGnex47/HvPWSesAyd77vTORe6vQxrdY/0Gsg
         YedA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eoJNhGWephHh2kHxeUxYOokymywaEEsB1soK0bgoMag=;
        b=IeEkcCwDwWdD80OT0TNh94qr4axQPCSzeY4ZAbOLwD/PATgDTgY2j2fzCeS11348oJ
         ajH03NhDs9CvqYg3rwqRXVYosU8Cz6q45oWbb6S5Ln9If5h6n3eQI1vXGgeoYF6WIpdt
         NvezrxiGJZGtdzypg7gOwet2vXT4GsR0/q1gvthO33irR3aUCFXeu3+0Zcmo0Nrdsa7w
         u1Bvfn6m3PjrbHHTvPltxeEupYTLOmvA+EQebDD7r5uqzwhzfn+5du6IXneksQ8JUkIE
         DsFM+gxbgeLbLsXfTgxgaoRqrSXBqpBQCm9vPQu95D/KCLVd3pUegA3hsiNPYXWPmSnL
         /62w==
X-Gm-Message-State: AOAM5337H2uxGGHMcfN5sbluKvPGahJ/zR/tn4TF7IhpOwIqSvrE3N5M
        Ycj0ieCS8Zvt80i1JmITzAQWEA==
X-Google-Smtp-Source: ABdhPJxWu2jWVCT4QdDVDT6jQzuNA/gmHgg6owA60mBPTRcDkKwon5A4vNDF90GMtDZwYVwwGKyFJQ==
X-Received: by 2002:adf:97cb:: with SMTP id t11mr4371001wrb.314.1592483175166;
        Thu, 18 Jun 2020 05:26:15 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:c1af:c724:158a:e200])
        by smtp.gmail.com with ESMTPSA id t188sm3491013wmt.27.2020.06.18.05.26.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 05:26:14 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
To:     Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, android-kvm@google.com,
        kernel-team@android.com, David Brazdil <dbrazdil@google.com>
Subject: [PATCH v3 15/15] arm64: kvm: Lift instrumentation restrictions on VHE
Date:   Thu, 18 Jun 2020 13:25:37 +0100
Message-Id: <20200618122537.9625-16-dbrazdil@google.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200618122537.9625-1-dbrazdil@google.com>
References: <20200618122537.9625-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With VHE and nVHE executable code completely separated, remove build config
that disabled GCOV/KASAN/UBSAN/KCOV instrumentation for VHE as these now
execute under the same memory mappings as the rest of the kernel.

No violations are currently being reported by either KASAN or UBSAN.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kvm/hyp/Makefile | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm64/kvm/hyp/Makefile b/arch/arm64/kvm/hyp/Makefile
index 5f4f217532e0..cd0c3936d266 100644
--- a/arch/arm64/kvm/hyp/Makefile
+++ b/arch/arm64/kvm/hyp/Makefile
@@ -11,11 +11,3 @@ obj-$(CONFIG_KVM_INDIRECT_VECTORS) += smccc_wa.o
 
 hyp-y := vgic-v3-sr.o timer-sr.o aarch32.o vgic-v2-cpuif-proxy.o sysreg-sr.o \
 	 debug-sr.o entry.o switch.o fpsimd.o tlb.o hyp-entry.o
-
-# KVM code is run at a different exception code with a different map, so
-# compiler instrumentation that inserts callbacks or checks into the code may
-# cause crashes. Just disable it.
-GCOV_PROFILE	:= n
-KASAN_SANITIZE	:= n
-UBSAN_SANITIZE	:= n
-KCOV_INSTRUMENT	:= n
-- 
2.27.0

