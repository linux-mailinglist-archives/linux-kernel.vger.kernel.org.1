Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC5372FD8E5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 19:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392322AbhATS4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 13:56:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25502 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388684AbhATRj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 12:39:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611164312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TunnN2Rmw/3iiIk96y5NqcKwVnXUUTnNVIzyUwYw5qc=;
        b=bLssEi5fnN4xUMa1/lfSXAslVrhp3VFTatskxRi6mNlR3KiMxE3C/on9ovYWGB6KtrrZl0
        qnfN5BFcrSpDOGHIJa6ZVtCMP0XIpV94Aug1L5P2yFe0JD+fV5gdG81e32vlvNB2gdZvTw
        sPbz1ZzjvUrCvXIpXxx1KTYVkRmRpyk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-qqfNkEbUMPq9UpYsqSw11Q-1; Wed, 20 Jan 2021 12:38:30 -0500
X-MC-Unique: qqfNkEbUMPq9UpYsqSw11Q-1
Received: by mail-wr1-f71.google.com with SMTP id r8so11923277wro.22
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 09:38:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TunnN2Rmw/3iiIk96y5NqcKwVnXUUTnNVIzyUwYw5qc=;
        b=II6N7KxlYOqHSvwm/TGEBFt/vDU8PKIbXvr4T2Okd5Kyyz1aPuRLvfPp+wUGHANr0L
         xAVdvMn3tm+PnAFI5izWsLSdcj5YOW59StQUA6CIZvUxEWnftFwvcYzbcpWEcCV3c+Xo
         z+sVL7FpFqXMmfmdLrYc4nwEL713IWoIXD4nYHNzvq6M3LHp571YtdDvlktRbUB86Ni7
         fTl2Tnc0xlAlOvhc06aiOCxFVtZCdYUQkJMGD6EVw3+03T/n7yQyVPeYBTfJJjsTtBEm
         wQln5Kfgao6WcNujYRR2j+Nmj0nW4MjmUpI4PRBMqPnmO8NPJJgbjmdRQNgEaALqB5r3
         z2DA==
X-Gm-Message-State: AOAM532KTT1xY6RbcizjufSQKn+o4P/9SAmo51hRZdt1RM084zXPOYfW
        1nu7qqraIKwjrVYSA82fbLQObclqsXth4NFEiBDh4sRYakyv6h9CcPK19GNsaK5yqJAC2tLaIK8
        oR4jE8bkFTQfuR+v6HtUfYx9aBk+TPv1TrStfPnvnKEwQs79pUjCIZgXaEBiSIMIK3rcAcJPGsC
        Df
X-Received: by 2002:a1c:a501:: with SMTP id o1mr5442926wme.21.1611164309243;
        Wed, 20 Jan 2021 09:38:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzdkiqIhQMa9qAcvB3y1xPRPRu1ifQGBBsVjTbJnRN8ssR5UHer5yLxDQqnoMtLa25rFV9xTQ==
X-Received: by 2002:a1c:a501:: with SMTP id o1mr5442896wme.21.1611164308963;
        Wed, 20 Jan 2021 09:38:28 -0800 (PST)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id x11sm4948325wmi.4.2021.01.20.09.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 09:38:28 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, ardb@kernel.org,
        masahiroy@kernel.org, keescook@chromium.org,
        michal.lkml@markovi.net, jpoimboe@redhat.com, peterz@infradead.org,
        mark.rutland@arm.com, broonie@kernel.org,
        linux-efi@vger.kernel.org, linux-hardening@vger.kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC PATCH 10/17] objtool: arm64: Accept padding in code sections
Date:   Wed, 20 Jan 2021 18:37:53 +0100
Message-Id: <20210120173800.1660730-11-jthierry@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210120173800.1660730-1-jthierry@redhat.com>
References: <20210120173800.1660730-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The compiler can introduce some '0' words in code sections to pad the
end of functions.
Similar to load literal functions, record these zero words to remove
the "struct instruction" created for them.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/arch/arm64/decode.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/arch/arm64/decode.c b/tools/objtool/arch/arm64/decode.c
index b4d4d5b051b0..ed5ef0b52bbe 100644
--- a/tools/objtool/arch/arm64/decode.c
+++ b/tools/objtool/arch/arm64/decode.c
@@ -362,8 +362,23 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 
 	switch (aarch64_get_insn_class(insn)) {
 	case AARCH64_INSN_CLS_UNKNOWN:
-		WARN("can't decode instruction at %s:0x%lx", sec->name, offset);
-		return -1;
+	{
+		/*
+		 * There are a few reasons we might have non-valid opcodes in
+		 * code sections:
+		 * - For load literal, assembler can generate the data to be
+		 *   loaded in the code section
+		 * - Compiler/assembler can generate zeroes to pad function that
+		 *   do not end on 8-byte alignment
+		 */
+		/* Compiler might put zeroes as padding */
+		if (record_invalid_insn(sec, offset, insn == 0x0))
+			return -1;
+
+		*type = INSN_OTHER;
+
+		break;
+	}
 	case AARCH64_INSN_CLS_DP_IMM:
 		/* Mov register to and from SP are aliases of add_imm */
 		if (aarch64_insn_is_add_imm(insn) ||
-- 
2.25.4

