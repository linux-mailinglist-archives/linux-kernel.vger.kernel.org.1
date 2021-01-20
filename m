Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDC572FD6CB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 18:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391786AbhATRUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 12:20:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22582 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404213AbhATRTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 12:19:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611163078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BuVvNIiTcLIwTMUtR2/AICUGs4023e5C4mwCuIOhLQ0=;
        b=OmD16cq3Ek7f7v5AcJZg9Gjbtxskryv7osUWxZ5by4LliV/kZGQGkeDY3CV+0bkl0iwov+
        mcm36elD9AYYx1F/i+zi/dfkn3Up7xUl2oQAYaMbc5nsbYXBzTc096Md4+ZqHZ0QeKk+Ev
        zOI2Ffna6vTEYSgaFdkwBdONxo8q6UE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-529-FnCTjPKbO-SFFi9uVqho1w-1; Wed, 20 Jan 2021 12:17:56 -0500
X-MC-Unique: FnCTjPKbO-SFFi9uVqho1w-1
Received: by mail-wm1-f69.google.com with SMTP id f16so1793355wmq.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 09:17:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BuVvNIiTcLIwTMUtR2/AICUGs4023e5C4mwCuIOhLQ0=;
        b=q7xohgpOIJ8f/yrhY2XFFXmHYv5TdMMxvqWrp/4lTuLsZgs0xmSIcalLEoE7Dg0s7I
         42Sf4JRAI0lo9XoMM6+DRI0sl4uG8IOWWuSfZQjaoLtUo33qXqDrILVxxpP+oA2nKq09
         EZyZVFTDtCRjvF95L6Tblc+Ef7GWbQIG0UgP0aWF+2WarhlMoVgOK73Sjm6IWniKMFTG
         6d5U22wxzK1DHNT2D1kG6iyv8YWQrf4M8CtgjnlrPOalcGz8JeU61Xyyaotnvv7tw4VE
         DpcjN3cQStYOU8sqxPLSvUU2EcXkATqQ5c6iyymo4eulUCJ1VQUOBn6QyoXjfy1l0voR
         FJNA==
X-Gm-Message-State: AOAM530rcylCPxDa9WhD4bhHYXAUXgTWCtuRJ0BQimibc4Gt5g5lFkpe
        NMwy4gOPRpQ3at5eK2fQqXoh51W9q8PNBVZYQ+c9NkZ/pwhPrvrNxk0iS0BkhVvVKCDloG8b1wQ
        Kv2h/+ZBqaia6Nzk40seHmWjB/ivdcGHHENMYKC+9OYS+izZLoZHUXNy1p56wUBKx+NBh4FjfRV
        9G
X-Received: by 2002:a1c:1b51:: with SMTP id b78mr4510286wmb.123.1611163074730;
        Wed, 20 Jan 2021 09:17:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxsYCMfhhEKjutOwxT3RZb6da21RtH1zNW+YSSWuEhWKikT8WABtWZyJvupULKIXKqtmJVmpA==
X-Received: by 2002:a1c:1b51:: with SMTP id b78mr4510260wmb.123.1611163074473;
        Wed, 20 Jan 2021 09:17:54 -0800 (PST)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id o124sm5444077wmb.5.2021.01.20.09.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 09:17:54 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        broonie@kernel.org, Julien Thierry <jthierry@redhat.com>
Subject: [RFC PATCH 3/5] arm64: aarch64-insn: Add barrier encodings
Date:   Wed, 20 Jan 2021 18:17:43 +0100
Message-Id: <20210120171745.1657762-4-jthierry@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210120171745.1657762-1-jthierry@redhat.com>
References: <20210120171745.1657762-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create necessary functions to encode/decode aarch64 data/instruction
barriers.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 arch/arm64/include/asm/aarch64-insn.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/include/asm/aarch64-insn.h b/arch/arm64/include/asm/aarch64-insn.h
index 200bee726172..d0fee47bbe6e 100644
--- a/arch/arm64/include/asm/aarch64-insn.h
+++ b/arch/arm64/include/asm/aarch64-insn.h
@@ -379,6 +379,9 @@ __AARCH64_INSN_FUNCS(eret_auth,	0xFFFFFBFF, 0xD69F0BFF)
 __AARCH64_INSN_FUNCS(mrs,	0xFFF00000, 0xD5300000)
 __AARCH64_INSN_FUNCS(msr_imm,	0xFFF8F01F, 0xD500401F)
 __AARCH64_INSN_FUNCS(msr_reg,	0xFFF00000, 0xD5100000)
+__AARCH64_INSN_FUNCS(dmb,	0xFFFFF0FF, 0xD50330BF)
+__AARCH64_INSN_FUNCS(dsb,	0xFFFFF0FF, 0xD503309F)
+__AARCH64_INSN_FUNCS(isb,	0xFFFFF0FF, 0xD50330DF)
 
 #undef	__AARCH64_INSN_FUNCS
 
@@ -390,6 +393,12 @@ static inline bool aarch64_insn_is_adr_adrp(u32 insn)
 	return aarch64_insn_is_adr(insn) || aarch64_insn_is_adrp(insn);
 }
 
+static inline bool aarch64_insn_is_barrier(u32 insn)
+{
+	return aarch64_insn_is_dmb(insn) || aarch64_insn_is_dsb(insn) ||
+	       aarch64_insn_is_isb(insn);
+}
+
 enum aarch64_insn_encoding_class aarch64_get_insn_class(u32 insn);
 bool aarch64_insn_uses_literal(u32 insn);
 bool aarch64_insn_is_branch(u32 insn);
-- 
2.25.4

