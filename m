Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2128D26A0CC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 10:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgIOIZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 04:25:48 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53843 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726136AbgIOIMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 04:12:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600157532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S+NBrWOfjQJMIhm4nnteqanUdRJ1i48UoPgQw/o7qAU=;
        b=GYqQdxwK+9ooFAyjUBXF2rEQHYuzdzhQGdzxmmZgwmBQ650jUVlqja1oxyWlRHlbmhAY1b
        ovYGGNKUoJNy6QHTylc1odAUSYb30M9BWtXMqEQ6nV6eCcgMJHemapELXSmOtKllgLJ7Ho
        Dhxy9VTG/1AA5KHAnjyjFLIUXqE115k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-538-yOmvXq2SMnyHCBXx6B5gZA-1; Tue, 15 Sep 2020 04:12:10 -0400
X-MC-Unique: yOmvXq2SMnyHCBXx6B5gZA-1
Received: by mail-wr1-f70.google.com with SMTP id a12so915972wrg.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 01:12:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S+NBrWOfjQJMIhm4nnteqanUdRJ1i48UoPgQw/o7qAU=;
        b=gOlu4JjW82e4c+sJw4VUEBF9MMhldGBU4WpO/RKFFhVCTqBB8uCr5a0Cfi7YupVv4G
         i6ykGr07Kaw6UkE+3G1aBJ1g5p1q2O9SCf/dpFeeoWio4cJ8c22FTT58AUoFqzqCGOIU
         DymyJvKv2MkTp7NY2CzBFZkvbmIUS943RuE5kd2U1nS09SmW4JKMGkLCuRtVKuWe/OlR
         OqhAZmYrswY2X8tX6TTjARBcONZzYh2nGgkxYlI4u+OZVlhBc7zf0dyVLlf90JgZUfOD
         mTsvGXjzkZMB4oBgsSh755x/9LNfT598VZcK2YOJOgA73Od2lQTdqevEb61HK/DT8ixT
         skrA==
X-Gm-Message-State: AOAM532LWPhTajVr0nlHcaAHK1OA0eA8TK181MRl/B+Tf0WeqhZOEEHr
        06rM3/lIqwcuA6IC2MZbG+u/Xp8ysSguxRHc6aV+N82fVPGuQ25AAyvUWBVeIBsqFkyWKwJA4oZ
        +eAeLGU7b1s/5kf5dnpG5N/mU
X-Received: by 2002:a1c:9ecb:: with SMTP id h194mr3293020wme.140.1600157529276;
        Tue, 15 Sep 2020 01:12:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJztbVgJRGO08hKgvhFbalx2ta1QkRklaxEISZ6A2/jgb0Z7bxEnkEr4VmnScHqKwXkqRqa1TA==
X-Received: by 2002:a1c:9ecb:: with SMTP id h194mr3293005wme.140.1600157529110;
        Tue, 15 Sep 2020 01:12:09 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id x16sm24661372wrq.62.2020.09.15.01.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 01:12:08 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, mbenes@suse.cz,
        raphael.gault@arm.com, benh@kernel.crashing.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [PATCH 1/3] objtool: check: Fully validate the stack frame
Date:   Tue, 15 Sep 2020 09:12:02 +0100
Message-Id: <20200915081204.9204-2-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200915081204.9204-1-jthierry@redhat.com>
References: <20200915081204.9204-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A valid stack frame should contain both the return address and the
previous frame pointer value.

On x86, the return value is placed on the stack by the calling
instructions. On other architectures, the callee need to explicitly
save the return value on the stack.

Add the necessary checks to verify a function properly sets up the all
the elements of the stack frame.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/arch/x86/include/cfi_regs.h |  4 ++++
 tools/objtool/check.c                     | 17 +++++++++++++----
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/tools/objtool/arch/x86/include/cfi_regs.h b/tools/objtool/arch/x86/include/cfi_regs.h
index 79bc517efba8..19b75b8b8439 100644
--- a/tools/objtool/arch/x86/include/cfi_regs.h
+++ b/tools/objtool/arch/x86/include/cfi_regs.h
@@ -22,4 +22,8 @@
 #define CFI_RA			16
 #define CFI_NUM_REGS		17
 
+#define CFA_SIZE	16
+#define CFA_BP_OFFSET	-16
+#define CFA_RA_OFFSET	-8
+
 #endif /* _OBJTOOL_CFI_REGS_H */
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 500f63b3dcff..7db6761d28c2 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1669,12 +1669,20 @@ static bool has_modified_stack_frame(struct instruction *insn, struct insn_state
 	return false;
 }
 
+static bool check_reg_frame_pos(const struct cfi_reg *reg, int cfa_start,
+				int expected_offset)
+{
+	return reg->base == CFI_CFA &&
+	       reg->offset == cfa_start + expected_offset;
+}
+
 static bool has_valid_stack_frame(struct insn_state *state)
 {
 	struct cfi_state *cfi = &state->cfi;
 
-	if (cfi->cfa.base == CFI_BP && cfi->regs[CFI_BP].base == CFI_CFA &&
-	    cfi->regs[CFI_BP].offset == -16)
+	if (cfi->cfa.base == CFI_BP && cfi->cfa.offset >= CFA_SIZE &&
+	    check_reg_frame_pos(&cfi->regs[CFI_BP], -cfi->cfa.offset + CFA_SIZE, CFA_BP_OFFSET) &&
+	    check_reg_frame_pos(&cfi->regs[CFI_RA], -cfi->cfa.offset + CFA_SIZE, CFA_RA_OFFSET))
 		return true;
 
 	if (cfi->drap && cfi->regs[CFI_BP].base == CFI_BP)
@@ -1803,8 +1811,9 @@ static int update_cfi_state(struct instruction *insn, struct cfi_state *cfi,
 		case OP_SRC_REG:
 			if (op->src.reg == CFI_SP && op->dest.reg == CFI_BP &&
 			    cfa->base == CFI_SP &&
-			    regs[CFI_BP].base == CFI_CFA &&
-			    regs[CFI_BP].offset == -cfa->offset) {
+			    check_reg_frame_pos(&regs[CFI_BP],
+						-cfa->offset + CFA_SIZE,
+						CFA_BP_OFFSET)) {
 
 				/* mov %rsp, %rbp */
 				cfa->base = op->dest.reg;
-- 
2.21.3

