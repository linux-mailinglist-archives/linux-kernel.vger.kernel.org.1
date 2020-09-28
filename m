Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50D2C27AADE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 11:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgI1Jgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 05:36:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31191 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726380AbgI1Jgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 05:36:47 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601285805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J6b7rvUA+1w7iqW8kEtLXFQVs31ukjeHiFKqzkhFxhE=;
        b=JIace/mud8tRG/NUptCtv+NfgutbM09wgYdJl3IH5wB2fJoD8xiZu+edFDZ49F4usoEN68
        vHfaK+TT6/ynWK63sZHwLbB+psVpDymXITf5220YElAivDiTnYGpyziJIY1z7v9MCEX+6J
        FVD+fqTkCLnJdETmrDE5TdqlrFF6uE4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-MixSBHRnPheygZPmIjZqvg-1; Mon, 28 Sep 2020 05:36:41 -0400
X-MC-Unique: MixSBHRnPheygZPmIjZqvg-1
Received: by mail-wr1-f71.google.com with SMTP id s8so167329wrb.15
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 02:36:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J6b7rvUA+1w7iqW8kEtLXFQVs31ukjeHiFKqzkhFxhE=;
        b=PB0JWwU77xga26GWLIzrdJArWTU8QI5+iIaxSeFI01rElYJ1HmwzLmbbQCpNBzs34z
         1ki2ZoqGzCu8MjhtD/dP0N2ef372MeA0L6WGJNhHxRGd2uTHR6xQ2D65TObnpXKsPMVu
         +t3YMXSa9Kd1FeBE5Tryk5JfKxvmbduFHB6/cyQ5DBnkBJJYbbWQVTOr9h5ZTR6irwag
         GAZssDGUnGoQe0sKQFUTu0xlVDKcNNLj/6vgItQV2o24aFJ95W0NzIb3RTSHEXIAXC9S
         /lk5a49BeD6AHAaoL703vKRMUVEkiQYTbS94LfWMKSdKBiwtzavVYCBGl7bdA3J/8SXw
         CFyA==
X-Gm-Message-State: AOAM530jSZyZHE85Sggdal1c38Qd3cf8s5guTV7147nY9T0cTuuD/3+K
        1hgZQluhSn2HgPMK47mhQ71ido9qr4M7lkDzxspmaNjooQboxQinFy8/A8Efiomg02Y4PZKRRbH
        h0VPheJcM9fxxkfKIOtAjGrGJ
X-Received: by 2002:a5d:574c:: with SMTP id q12mr651044wrw.253.1601285800317;
        Mon, 28 Sep 2020 02:36:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwxGAI8YjnxdpZgn95O8nnOq2AmcUXHPec/JHXUdwT0Ill/DQOb42t91XuTpU2yyyuE59sk+w==
X-Received: by 2002:a5d:574c:: with SMTP id q12mr651029wrw.253.1601285800173;
        Mon, 28 Sep 2020 02:36:40 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id y207sm495967wmc.17.2020.09.28.02.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 02:36:39 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, mbenes@suse.cz,
        raphael.gault@arm.com, benh@kernel.crashing.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [PATCH v2 1/3] objtool: check: Fully validate the stack frame
Date:   Mon, 28 Sep 2020 10:36:29 +0100
Message-Id: <20200928093631.210610-2-jthierry@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200928093631.210610-1-jthierry@redhat.com>
References: <20200928093631.210610-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A valid stack frame should contain both the return address and the
previous frame pointer value.

On x86, the return value is placed on the stack by the calling
instructions. On other architectures, the callee need to explicitly
save the return address on the stack.

Add the necessary checks to verify a function properly sets up all the
elements of the stack frame.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/arch/x86/include/cfi_regs.h |  3 +++
 tools/objtool/cfi.h                       |  2 ++
 tools/objtool/check.c                     | 21 +++++++++++++++++----
 3 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/tools/objtool/arch/x86/include/cfi_regs.h b/tools/objtool/arch/x86/include/cfi_regs.h
index 79bc517efba8..4e443b49d0d3 100644
--- a/tools/objtool/arch/x86/include/cfi_regs.h
+++ b/tools/objtool/arch/x86/include/cfi_regs.h
@@ -22,4 +22,7 @@
 #define CFI_RA			16
 #define CFI_NUM_REGS		17
 
+#define STACKFRAME_BP_OFFSET	-16
+#define STACKFRAME_RA_OFFSET	-8
+
 #endif /* _OBJTOOL_CFI_REGS_H */
diff --git a/tools/objtool/cfi.h b/tools/objtool/cfi.h
index c7c59c6a44ee..2691b6ce4fcd 100644
--- a/tools/objtool/cfi.h
+++ b/tools/objtool/cfi.h
@@ -35,4 +35,6 @@ struct cfi_state {
 	bool end;
 };
 
+#define STACKFRAME_SIZE	16
+
 #endif /* _OBJTOOL_CFI_H */
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 2df9f769412e..50b3a4504db1 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1668,12 +1668,24 @@ static bool has_modified_stack_frame(struct instruction *insn, struct insn_state
 	return false;
 }
 
+static bool check_reg_frame_pos(const struct cfi_reg *reg, int stackframe_start,
+				int expected_offset)
+{
+	return reg->base == CFI_CFA &&
+	       reg->offset == stackframe_start + expected_offset;
+}
+
 static bool has_valid_stack_frame(struct insn_state *state)
 {
 	struct cfi_state *cfi = &state->cfi;
 
-	if (cfi->cfa.base == CFI_BP && cfi->regs[CFI_BP].base == CFI_CFA &&
-	    cfi->regs[CFI_BP].offset == -16)
+	if (cfi->cfa.base == CFI_BP && cfi->cfa.offset >= STACKFRAME_SIZE &&
+	    check_reg_frame_pos(&cfi->regs[CFI_BP],
+			        -cfi->cfa.offset + STACKFRAME_SIZE,
+			        STACKFRAME_BP_OFFSET) &&
+	    check_reg_frame_pos(&cfi->regs[CFI_RA],
+			        -cfi->cfa.offset + STACKFRAME_SIZE,
+			        STACKFRAME_RA_OFFSET))
 		return true;
 
 	if (cfi->drap && cfi->regs[CFI_BP].base == CFI_BP)
@@ -1802,8 +1814,9 @@ static int update_cfi_state(struct instruction *insn, struct cfi_state *cfi,
 		case OP_SRC_REG:
 			if (op->src.reg == CFI_SP && op->dest.reg == CFI_BP &&
 			    cfa->base == CFI_SP &&
-			    regs[CFI_BP].base == CFI_CFA &&
-			    regs[CFI_BP].offset == -cfa->offset) {
+			    check_reg_frame_pos(&regs[CFI_BP],
+						-cfa->offset + STACKFRAME_SIZE,
+						STACKFRAME_BP_OFFSET)) {
 
 				/* mov %rsp, %rbp */
 				cfa->base = op->dest.reg;
-- 
2.25.4

