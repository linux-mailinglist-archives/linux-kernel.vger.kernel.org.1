Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5647A2B97D7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 17:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbgKSQZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 11:25:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728011AbgKSQZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 11:25:56 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749BFC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 08:25:56 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id l5so6431691edq.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 08:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4v/cI0W618Ll5oLWISpFhPxrIsIv3CzVb2jjngYJV1Y=;
        b=d5PO+tqR8NqolGIpflVwHQcaoSm8nizbEKWRPNduNGR++veNurs6hl8d+bpaVieFyx
         N/4qzptR0qOSoxQx7FQPsoe+iJswnHDVYtCadJO3C2slcCcPefUTQ+zOiNyarho+GJTQ
         eQVq93/itpn3uOMr/bNlKeAjhJZdy4EqJV6kjmkrHbofx2egXY3zQ+yRKs+a7dQtwgdK
         4NoSRABTZAqopd6clg6Riim7meD6ewWkye8RYV/TV41uhgV3OcI7IOBtaWy6jDfV+Jfn
         HS8RCnV4PSHXaSeawTEOygjXqwZVK8R/FKpjfbB4tqH67KPho4pLvDzc9Uy4bjYb/kik
         IvoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4v/cI0W618Ll5oLWISpFhPxrIsIv3CzVb2jjngYJV1Y=;
        b=Ij1Wsdj1yPsJ/tpQG9dUrmH2+Dro4dI3RiK6lFf5k7r7dPX0iERDMNc86IDvt2svkl
         2mVKPMW1kgY5gQUa0Uck+Ka6tkOGZWWt9tWJ8SgprIaExb6o02/2Lm2DTnfonK1W33B1
         7yHbLkM0H87fQ9yHudYvFS1nGDTiuI3O5QKK7ox6zo7MLt8cRP0xKt9KiyInUojms+Xu
         KsWW64vlmasoBkl8P71w3IRgz7nd/CvEl8F6VDNT7dNTHkn/TVPycKekcWxMriFEJCqc
         lM1umZv5zckWGG8ux5zZ3jeMW0+h8u7vBBQksraaRiedeNpi+gZyrLdcZslFiYb7Xk0H
         bqoQ==
X-Gm-Message-State: AOAM532KU35e4ih7UtJ/uendh5aGoDkUYU7T6Hdsvb3wJ+eLm2B1gHnf
        o5hLvVLjYHkTdhBBDJVmasw0LQ==
X-Google-Smtp-Source: ABdhPJwsWb2PZ6sVei/sp7eotqJ6Uj+ntArrx/BCAAQKZymcK4INkpViSTd4Aa9KHDTnkjsffwkiyQ==
X-Received: by 2002:a50:ccdb:: with SMTP id b27mr9198862edj.253.1605803154843;
        Thu, 19 Nov 2020 08:25:54 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:9843:cd3f:f36b:d55c])
        by smtp.gmail.com with ESMTPSA id k2sm84334ejp.6.2020.11.19.08.25.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2020 08:25:53 -0800 (PST)
From:   David Brazdil <dbrazdil@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Scull <ascull@google.com>,
        Ard Biesheuvel <ardb@kernel.org>, kernel-team@android.com,
        David Brazdil <dbrazdil@google.com>
Subject: [RFC PATCH 3/6] kvm: arm64: Fix up RELR relocation in hyp code/data
Date:   Thu, 19 Nov 2020 16:25:40 +0000
Message-Id: <20201119162543.78001-4-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201119162543.78001-1-dbrazdil@google.com>
References: <20201119162543.78001-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arm64 kernel also supports packing of relocation data using the RELR
format. Implement a parser of RELR data and fixup the relocations using
the same infra as RELA relocs.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kvm/va_layout.c | 41 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm64/kvm/va_layout.c b/arch/arm64/kvm/va_layout.c
index b80fab974896..7f45a98eacfd 100644
--- a/arch/arm64/kvm/va_layout.c
+++ b/arch/arm64/kvm/va_layout.c
@@ -145,6 +145,43 @@ static void __fixup_hyp_rela(void)
 		__fixup_hyp_rel(rel[i].r_offset);
 }
 
+#ifdef CONFIG_RELR
+static void __fixup_hyp_relr(void)
+{
+	u64 *rel, *end;
+
+	rel = (u64*)(kimage_vaddr + __load_elf_u64(__relr_offset));
+	end = rel + (__load_elf_u64(__relr_size) / sizeof(*rel));
+
+	while (rel < end) {
+		unsigned n;
+		u64 addr = *(rel++);
+
+		/* Address must not have the LSB set. */
+		BUG_ON(addr & BIT(0));
+
+		/* Fix up the first address of the chain. */
+		__fixup_hyp_rel(addr);
+
+		/*
+		 * Loop over bitmaps, i.e. as long as words' LSB is 1.
+		 * Each bit (ordered from LSB to MSB) represents one word from
+		 * the last full address (exclusive). If the corresponding bit
+		 * is 1, there is a relative relocation on that word.
+		 */
+		for (n = 0; rel < end && (*rel & BIT(0)); n++) {
+			unsigned i;
+			u64 bitmap = *(rel++);
+
+			for (i = 1; i < 64; ++i) {
+				if ((bitmap & BIT(i)))
+					__fixup_hyp_rel(addr + 8 * (63 * n + i));
+			}
+		}
+	}
+}
+#endif
+
 /*
  * The kernel relocated pointers to kernel VA. Iterate over relocations in
  * the hypervisor ELF sections and convert them to hyp VA. This avoids the
@@ -156,6 +193,10 @@ __init void kvm_fixup_hyp_relocations(void)
 		return;
 
 	__fixup_hyp_rela();
+
+#ifdef CONFIG_RELR
+	__fixup_hyp_relr();
+#endif
 }
 
 static u32 compute_instruction(int n, u32 rd, u32 rn)
-- 
2.29.2.299.gdc1121823c-goog

