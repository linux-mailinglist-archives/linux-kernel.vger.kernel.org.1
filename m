Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7472F2FD8E4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 19:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392279AbhATSz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 13:55:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32650 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387801AbhATRjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 12:39:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611164305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hMguHZY/sCxCSurZhMfyymWiW0UnVLAVgK8Kmo5II94=;
        b=THrivMmjI1Fzl+zpczXAd+vR5ZvZxKUqXgyqyXn/Lzzo33mNtTAJU53w3HeruTuXuW75pm
        0C3Vk7n0k++crSiUh4WREEQrKfxRHL0gyL94S+JyWa3qKrk5HCxV4opqxVtX4kqqYU2iH7
        rO/DrgYPcR9yqMriahpF1eWJpaDZNQw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-oJAc-s66Mhuqf0Z7pFQzHA-1; Wed, 20 Jan 2021 12:38:24 -0500
X-MC-Unique: oJAc-s66Mhuqf0Z7pFQzHA-1
Received: by mail-wr1-f72.google.com with SMTP id y4so1504955wrt.18
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 09:38:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hMguHZY/sCxCSurZhMfyymWiW0UnVLAVgK8Kmo5II94=;
        b=SVpj2u3+jilnI/l4KeLAeJ8m+5teWMU3vfHNGuLKw4jtTOstSdcXfyYWI+tvM5YhGj
         C+Flehyilbu2fVqjNLxK6/LAsa1m9MbrzZwwhVacB0mvEeVP74jVtA3x8pSnm2KZMLTV
         mxYh8E6qWkspWDyROJLsGhLQ9xDKNH2Va3hivJoo6brMFPbZK2L5i8sHXUQ+VV/fDu74
         hPrFwEevRjzjLaSZMN7+csj+fjLsRRGmRlrnyhZyRjmeNTNMJhqUtqZCntPgIgSnsCOU
         m+qsKjCHU9Zm0uEgW722jCT69rKRrk0UarsD8omrQVnJyea+pPDb479WT/GGYGWDeILM
         O9og==
X-Gm-Message-State: AOAM533iSCgrKHEEmQL/xOmL0rxafJF4si/JGat6fc9GsksTpq9Gaq9Q
        ul3knci0JD5C5uPbmG1imoS28CEd8lZfeT5nkxAsMflBAXYhl42JWamUbnGp4jT0/DlzBqFkr0e
        4XbqLPnfjjoCji49nRwLxOQu+qnwEs1KAu+LnfFQgdQHXNmapwc8eqMmZjNsF2k4x6qZTvSMfUY
        10
X-Received: by 2002:a5d:5112:: with SMTP id s18mr10242718wrt.267.1611164302728;
        Wed, 20 Jan 2021 09:38:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwfzo6NlUcDC38dNrSR8pTXGMXlfQTTcZKajys6pTqFZqQ1R+z9gv6rpXRif0O4vIIw0NAjMg==
X-Received: by 2002:a5d:5112:: with SMTP id s18mr10242694wrt.267.1611164302569;
        Wed, 20 Jan 2021 09:38:22 -0800 (PST)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id x11sm4948325wmi.4.2021.01.20.09.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 09:38:22 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, ardb@kernel.org,
        masahiroy@kernel.org, keescook@chromium.org,
        michal.lkml@markovi.net, jpoimboe@redhat.com, peterz@infradead.org,
        mark.rutland@arm.com, broonie@kernel.org,
        linux-efi@vger.kernel.org, linux-hardening@vger.kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC PATCH 08/17] objtool: arm64: Decode load/store instructions
Date:   Wed, 20 Jan 2021 18:37:51 +0100
Message-Id: <20210120173800.1660730-9-jthierry@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210120173800.1660730-1-jthierry@redhat.com>
References: <20210120173800.1660730-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Decode load/store operations and create corresponding stack_ops for
operations targetting SP or FP.

Operations storing/loading multiple registers are split into separate
stack_ops storing single registers.

Operations modifying the base register get an additional stack_op
for the register update. Since the atomic register(s) load/store + base
register update gets split into multiple operations, to make sure
objtool always sees a valid stack, consider store instruction to perform
stack allocations (i.e. modifying the base pointer before the storing)
and loads de-allocations (i.e. modifying the base pointer after the
load).

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/arch/arm64/decode.c | 127 ++++++++++++++++++++++++++++++
 1 file changed, 127 insertions(+)

diff --git a/tools/objtool/arch/arm64/decode.c b/tools/objtool/arch/arm64/decode.c
index a4a587c400a1..1087ede67bcd 100644
--- a/tools/objtool/arch/arm64/decode.c
+++ b/tools/objtool/arch/arm64/decode.c
@@ -105,6 +105,40 @@ int arch_decode_hint_reg(struct instruction *insn, u8 sp_reg)
 	return -1;
 }
 
+static struct stack_op *arm_make_store_op(enum aarch64_insn_register base,
+					  enum aarch64_insn_register reg,
+					  int offset)
+{
+	struct stack_op *op;
+
+	op = calloc(1, sizeof(*op));
+	op->dest.type = OP_DEST_REG_INDIRECT;
+	op->dest.reg = base;
+	op->dest.offset = offset;
+	op->src.type = OP_SRC_REG;
+	op->src.reg = reg;
+	op->src.offset = 0;
+
+	return op;
+}
+
+static struct stack_op *arm_make_load_op(enum aarch64_insn_register base,
+					 enum aarch64_insn_register reg,
+					 int offset)
+{
+	struct stack_op *op;
+
+	op = calloc(1, sizeof(*op));
+	op->dest.type = OP_DEST_REG;
+	op->dest.reg = reg;
+	op->dest.offset = 0;
+	op->src.type = OP_SRC_REG_INDIRECT;
+	op->src.reg = base;
+	op->src.offset = offset;
+
+	return op;
+}
+
 static struct stack_op *arm_make_add_op(enum aarch64_insn_register dest,
 					enum aarch64_insn_register src,
 					int val)
@@ -121,6 +155,94 @@ static struct stack_op *arm_make_add_op(enum aarch64_insn_register dest,
 	return op;
 }
 
+static bool arm_decode_load_store(u32 insn, enum insn_type *type,
+				  unsigned long *immediate,
+				  struct list_head *ops_list)
+{
+	enum aarch64_insn_register base;
+	enum aarch64_insn_register rt;
+	struct stack_op *op;
+	int size;
+	int offset;
+
+	*type = INSN_OTHER;
+
+	if (aarch64_insn_is_store_single(insn) ||
+	    aarch64_insn_is_load_single(insn))
+		size = 1 << ((insn & GENMASK(31, 30)) >> 30);
+	else
+		size = 4 << ((insn >> 31) & 1);
+
+	if (aarch64_insn_is_store_imm(insn) || aarch64_insn_is_load_imm(insn))
+		*immediate = size * aarch64_insn_decode_immediate(AARCH64_INSN_IMM_12,
+								  insn);
+	else if (aarch64_insn_is_store_pre(insn) ||
+		 aarch64_insn_is_load_pre(insn) ||
+		 aarch64_insn_is_store_post(insn) ||
+		 aarch64_insn_is_load_post(insn))
+		*immediate = sign_extend(aarch64_insn_decode_immediate(AARCH64_INSN_IMM_9,
+								       insn),
+					 9);
+	else if (aarch64_insn_is_stp(insn) || aarch64_insn_is_ldp(insn) ||
+		 aarch64_insn_is_stp_pre(insn) ||
+		 aarch64_insn_is_ldp_pre(insn) ||
+		 aarch64_insn_is_stp_post(insn) ||
+		 aarch64_insn_is_ldp_post(insn))
+		*immediate = size * sign_extend(aarch64_insn_decode_immediate(AARCH64_INSN_IMM_7,
+									      insn),
+						7);
+	else
+		return false;
+
+	base = aarch64_insn_decode_register(AARCH64_INSN_REGTYPE_RN, insn);
+	if (base != AARCH64_INSN_REG_FP && base != AARCH64_INSN_REG_SP)
+		return true;
+
+	offset = *immediate;
+
+	if (aarch64_insn_is_store_pre(insn) || aarch64_insn_is_stp_pre(insn) ||
+	    aarch64_insn_is_store_post(insn) || aarch64_insn_is_stp_post(insn)) {
+		op = arm_make_add_op(base, base, *immediate);
+		list_add_tail(&op->list, ops_list);
+
+		if (aarch64_insn_is_store_post(insn) || aarch64_insn_is_stp_post(insn))
+			offset = -*immediate;
+		else
+			offset = 0;
+	} else if (aarch64_insn_is_load_post(insn) || aarch64_insn_is_ldp_post(insn)) {
+		offset = 0;
+	}
+
+	/* First register */
+	rt = aarch64_insn_decode_register(AARCH64_INSN_REGTYPE_RT, insn);
+	if (aarch64_insn_is_store_single(insn) ||
+	    aarch64_insn_is_store_pair(insn))
+		op = arm_make_store_op(base, rt, offset);
+	else
+		op = arm_make_load_op(base, rt, offset);
+	list_add_tail(&op->list, ops_list);
+
+	/* Second register (if present) */
+	if (aarch64_insn_is_store_pair(insn) ||
+	    aarch64_insn_is_load_pair(insn)) {
+		rt = aarch64_insn_decode_register(AARCH64_INSN_REGTYPE_RT2,
+						  insn);
+		if (aarch64_insn_is_store_pair(insn))
+			op = arm_make_store_op(base, rt, offset + size);
+		else
+			op = arm_make_load_op(base, rt, offset + size);
+		list_add_tail(&op->list, ops_list);
+	}
+
+	if (aarch64_insn_is_load_pre(insn) || aarch64_insn_is_ldp_pre(insn) ||
+	    aarch64_insn_is_load_post(insn) || aarch64_insn_is_ldp_post(insn)) {
+		op = arm_make_add_op(base, base, *immediate);
+		list_add_tail(&op->list, ops_list);
+	}
+
+	return true;
+}
+
 static void arm_decode_add_sub_imm(u32 instr, bool set_flags,
 				   enum insn_type *type,
 				   unsigned long *immediate,
@@ -234,6 +356,11 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 			*type = INSN_OTHER;
 		}
 		break;
+	case AARCH64_INSN_CLS_LDST:
+		if (arm_decode_load_store(insn, type, immediate, ops_list))
+			break;
+		*type = INSN_OTHER;
+		break;
 	default:
 		*type = INSN_OTHER;
 		break;
-- 
2.25.4

