Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72EF72D2D22
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 15:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729856AbgLHOZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 09:25:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728786AbgLHOZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 09:25:45 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F59C061793
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 06:25:04 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id k14so16436051wrn.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 06:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Js+kADbtgM+vdnerlP9z0cKyj1NsUqnpPe0pQv1UIXw=;
        b=rNqDlvxyiJ1P0X/0WsQzcAkJH7Wxtpn3w4/snPmFyQE2KualXgw27WCaRrxPRFYwwI
         QsoSIhbDK/z907X9cKGawWx3YqPOhniUpNV1ttzOUbL2Xq2ygPlTp3uuFaexqbw2e7TM
         jdPGWa9M+DcgzmdFp0iih/gDDMH7slzsCXgDqnvpQ29RZuDbpmF3IqIKm06SjMnw2EzM
         WOtgcp0yD0ppJcFJgI573XFMmWxBCOKN5+aoJmLMv7u2bHi87WbHN7aVZrm92p/mzelu
         C76fa08qbD0a4wn1vmdzbRf2A1519kerYbbXV9QHDQqk2wmYfsyqYachY5A4E8hypG4o
         MFUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Js+kADbtgM+vdnerlP9z0cKyj1NsUqnpPe0pQv1UIXw=;
        b=FupKoYaN9xEbQTtfw46n7j8dyluL4/LCN5OIZQIHx6wOjpg3jFoWf2FvaU0ak3TMBu
         i44qHLYdqbBUAS/bRL0kquG+u0lvHG8C4JjX80LBQlv0hTHm2HTrCY41zp2osxbLWol2
         7WfQ6vApuHpScHX/6w/oDubau94GbviRyfBXQgPR3PF9hu8u6ATaQbnsDlnNNqbmd9Im
         baPdcoFZH/nzSk8nnXLa2I5cHxISezZSFMZ1hSMUy/r27vRZ97GnblobhIhhMWskYNlA
         LQLEqztkwQp+Tfg6sEJvuQv21t6HvLgJLBjd19eZAGnoK4xJ0atLsWKOopGXYBtIkKq3
         jGog==
X-Gm-Message-State: AOAM53247EEtp+1foUxPkdPI2QVnZoFuwfxBkMBGWQxYgqJIhm6l/rLf
        hb6reGqViOjWRyEOFkZzh5srfg==
X-Google-Smtp-Source: ABdhPJxHrjfFXJbqnCX9xFY5SICS+JzIJWzJPSavZ7ozgbyJlJghKGdV9NwVaAw/PLQwBO8RZFpRfA==
X-Received: by 2002:adf:aa4a:: with SMTP id q10mr24761702wrd.276.1607437503226;
        Tue, 08 Dec 2020 06:25:03 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:258e:cb26:cef:a620])
        by smtp.gmail.com with ESMTPSA id m8sm3952024wmc.27.2020.12.08.06.25.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Dec 2020 06:25:02 -0800 (PST)
From:   David Brazdil <dbrazdil@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, David Brazdil <dbrazdil@google.com>,
        Qian Cai <qcai@redhat.com>
Subject: [PATCH 2/6] kvm: arm64: Use lm_alias in nVHE-only VA conversion
Date:   Tue,  8 Dec 2020 14:24:48 +0000
Message-Id: <20201208142452.87237-3-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201208142452.87237-1-dbrazdil@google.com>
References: <20201208142452.87237-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

init_hyp_physvirt_offset() computes PA from a kernel VA. Conversion to
kernel linear-map is required first but the code used kvm_ksym_ref() for
this purpose. Under VHE that is a NOP and resulted in a runtime warning.
Replace kvm_ksym_ref with lm_alias.

Reported-by: Qian Cai <qcai@redhat.com>
Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kvm/va_layout.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/va_layout.c b/arch/arm64/kvm/va_layout.c
index d8cc51bd60bf..914732b88c69 100644
--- a/arch/arm64/kvm/va_layout.c
+++ b/arch/arm64/kvm/va_layout.c
@@ -42,7 +42,7 @@ static void init_hyp_physvirt_offset(void)
 	u64 kern_va, hyp_va;
 
 	/* Compute the offset from the hyp VA and PA of a random symbol. */
-	kern_va = (u64)kvm_ksym_ref(__hyp_text_start);
+	kern_va = (u64)lm_alias(__hyp_text_start);
 	hyp_va = __early_kern_hyp_va(kern_va);
 	CHOOSE_NVHE_SYM(hyp_physvirt_offset) = (s64)__pa(kern_va) - (s64)hyp_va;
 }
-- 
2.29.2.576.ga3fc446d84-goog

