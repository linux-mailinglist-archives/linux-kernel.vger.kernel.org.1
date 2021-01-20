Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 738702FD8E8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 19:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392417AbhATS4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 13:56:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50594 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387637AbhATRjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 12:39:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611164297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5kZxUm2npMwQG1TG1qATstMBS9/a58lwU+qMaeV/pLI=;
        b=ADEJXoOhqVNUGVjqh+0Axs0I+X4AnFUEl1klJY70TozcHDeFuPrPpRuA7T9OEGwr4NR1F9
        SeiEv8Qj8qg9iK6C72DL2968KgmW9QZJxinKEnf8kKzj4+Sjwi4S9A8DSxkxvFstyLFCbD
        Tr/3Ga3hNw+ewG9Fe/TdJ1GLO1ZGviw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-jLhO-efjPNuIX6B_dOEcuQ-1; Wed, 20 Jan 2021 12:38:16 -0500
X-MC-Unique: jLhO-efjPNuIX6B_dOEcuQ-1
Received: by mail-wr1-f72.google.com with SMTP id z8so11985339wrh.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 09:38:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5kZxUm2npMwQG1TG1qATstMBS9/a58lwU+qMaeV/pLI=;
        b=AIaoR2c6dWGqm7hooxW5w2/Ogs23ZkqHsxMrb7B3j9qj23MWdYFK2VMjO3j3rjprk1
         6EV5Eq0Nob6AUrlhr01y3XcTSTPqIw87wF6Vdtxss3DDqM5ylTLXkZdVZTOqiAN8dQ6V
         C3RWZ3RlotjO7XzuVlYSEqHFRc4+9H0ijxD4mJsCkBduWrTuSQflt5b9pOcchuQKqcAV
         vhkiKPDzlJVR/q158JpFFPzqbjaOvzjPj4LNpTvuFOMqAqvWdNzzEJaGs2MuaFpskfvo
         fUv8rtkDz6velzac8q7so4bfjjXUfWlzbqIamdM+7oK5eFWVm7pAhVyFS1Jx/OZuC46a
         AEPg==
X-Gm-Message-State: AOAM530sVjLmkDZL8Htqd8tzBwHuafqS9paGbCZsFatmy8hTt7MiVSaO
        7MeWIJpyc3o4RhsY1ySXoJkjOWariPVyuE2i+q4wAzdwWuK4SapshELtlwFzWydoPRX0pHf7v+V
        hiF9b2YtJSUp2aZDF8EpTuGbkHNBI0+fanjdvXh78+WpbGwpadxTKsT6r7IYG83q/60GTDM5hIG
        sq
X-Received: by 2002:adf:8145:: with SMTP id 63mr10098338wrm.8.1611164294480;
        Wed, 20 Jan 2021 09:38:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzQzDN3HBtD5u6jA4hqcs01Fugkowpn2vULtp1RxBDFANC375MC0WgDFgHupnT7fa0d1iia8Q==
X-Received: by 2002:adf:8145:: with SMTP id 63mr10098306wrm.8.1611164294279;
        Wed, 20 Jan 2021 09:38:14 -0800 (PST)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id x11sm4948325wmi.4.2021.01.20.09.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 09:38:13 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, ardb@kernel.org,
        masahiroy@kernel.org, keescook@chromium.org,
        michal.lkml@markovi.net, jpoimboe@redhat.com, peterz@infradead.org,
        mark.rutland@arm.com, broonie@kernel.org,
        linux-efi@vger.kernel.org, linux-hardening@vger.kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC PATCH 05/17] objtool: arm64: Decode add/sub instructions
Date:   Wed, 20 Jan 2021 18:37:48 +0100
Message-Id: <20210120173800.1660730-6-jthierry@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210120173800.1660730-1-jthierry@redhat.com>
References: <20210120173800.1660730-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Decode aarch64 additions and substractions and create stack_ops for
instructions interacting with SP or FP.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/arch/arm64/decode.c | 84 +++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/tools/objtool/arch/arm64/decode.c b/tools/objtool/arch/arm64/decode.c
index 8ae822f553ca..0f312dd1b146 100644
--- a/tools/objtool/arch/arm64/decode.c
+++ b/tools/objtool/arch/arm64/decode.c
@@ -23,6 +23,13 @@
 
 #include "../../../arch/arm64/lib/aarch64-insn.c"
 
+static unsigned long sign_extend(unsigned long x, int nbits)
+{
+	unsigned long sign_bit = (x >> (nbits - 1)) & 1;
+
+	return ((~0UL + (sign_bit ^ 1)) << nbits) | x;
+}
+
 bool arch_callee_saved_reg(unsigned char reg)
 {
 	switch (reg) {
@@ -98,6 +105,53 @@ int arch_decode_hint_reg(struct instruction *insn, u8 sp_reg)
 	return -1;
 }
 
+static struct stack_op *arm_make_add_op(enum aarch64_insn_register dest,
+					enum aarch64_insn_register src,
+					int val)
+{
+	struct stack_op *op;
+
+	op = calloc(1, sizeof(*op));
+	op->dest.type = OP_DEST_REG;
+	op->dest.reg = dest;
+	op->src.reg = src;
+	op->src.type = val != 0 ? OP_SRC_ADD : OP_SRC_REG;
+	op->src.offset = val;
+
+	return op;
+}
+
+static void arm_decode_add_sub_imm(u32 instr, bool set_flags,
+				   enum insn_type *type,
+				   unsigned long *immediate,
+				   struct list_head *ops_list)
+{
+	u32 rd = aarch64_insn_decode_register(AARCH64_INSN_REGTYPE_RD, instr);
+	u32 rn = aarch64_insn_decode_register(AARCH64_INSN_REGTYPE_RN, instr);
+
+	*type = INSN_OTHER;
+	*immediate = aarch64_insn_decode_immediate(AARCH64_INSN_IMM_12, instr);
+
+	if (instr & AARCH64_INSN_LSL_12)
+		*immediate <<= 12;
+
+	if ((!set_flags && rd == AARCH64_INSN_REG_SP) ||
+	    rd == AARCH64_INSN_REG_FP ||
+	    rn == AARCH64_INSN_REG_FP ||
+	    rn == AARCH64_INSN_REG_SP) {
+		struct stack_op *op;
+		int value;
+
+		if (aarch64_insn_is_subs_imm(instr) || aarch64_insn_is_sub_imm(instr))
+			value = -*immediate;
+		else
+			value = *immediate;
+
+		op = arm_make_add_op(rd, rn, value);
+		list_add_tail(&op->list, ops_list);
+	}
+}
+
 int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 			    unsigned long offset, unsigned int maxlen,
 			    unsigned int *len, enum insn_type *type,
@@ -121,6 +175,36 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 	case AARCH64_INSN_CLS_UNKNOWN:
 		WARN("can't decode instruction at %s:0x%lx", sec->name, offset);
 		return -1;
+	case AARCH64_INSN_CLS_DP_IMM:
+		/* Mov register to and from SP are aliases of add_imm */
+		if (aarch64_insn_is_add_imm(insn) ||
+		    aarch64_insn_is_sub_imm(insn))
+			arm_decode_add_sub_imm(insn, false, type, immediate,
+					       ops_list);
+		else if (aarch64_insn_is_adds_imm(insn) ||
+			 aarch64_insn_is_subs_imm(insn))
+			arm_decode_add_sub_imm(insn, true, type, immediate,
+					       ops_list);
+		else
+			*type = INSN_OTHER;
+		break;
+	case AARCH64_INSN_CLS_DP_REG:
+		if (aarch64_insn_is_mov_reg(insn)) {
+			enum aarch64_insn_register rd;
+			enum aarch64_insn_register rm;
+
+			rd = aarch64_insn_decode_register(AARCH64_INSN_REGTYPE_RD, insn);
+			rm = aarch64_insn_decode_register(AARCH64_INSN_REGTYPE_RM, insn);
+			if (rd == AARCH64_INSN_REG_FP || rm == AARCH64_INSN_REG_FP) {
+				struct stack_op *op;
+
+				op = arm_make_add_op(rd, rm, 0);
+				list_add_tail(&op->list, ops_list);
+				break;
+			}
+		}
+		*type = INSN_OTHER;
+		break;
 	default:
 		*type = INSN_OTHER;
 		break;
-- 
2.25.4

