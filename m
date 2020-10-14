Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEC828DA8F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 09:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbgJNHiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 03:38:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54058 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728242AbgJNHiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 03:38:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602661090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ABiTA6hFtXP0oYeC1XbiwALLzlf+HAyRRK4UXFyPFsU=;
        b=Vy1ARA7cqg+vvg8K/WbOtuc+ddh69k005RbNoM9vlqH03yGbkHNhi1LlZl4RMhgIj+zoXs
        ijWtdeQ/sgHRcG1VrwV2oZTN1o5Xhhlw8wM3/HmU3Zn8Yd1bsxDfI+6fK+wO5ycERj8xlc
        tr6tAHFwTtlKLJ5Uau8+W1KAbPpvomo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-vJkfAzBjMVaMgDOqfcfvOw-1; Wed, 14 Oct 2020 03:38:08 -0400
X-MC-Unique: vJkfAzBjMVaMgDOqfcfvOw-1
Received: by mail-wm1-f72.google.com with SMTP id i9so238927wml.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 00:38:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ABiTA6hFtXP0oYeC1XbiwALLzlf+HAyRRK4UXFyPFsU=;
        b=gLpA42E6QiwpGM9ugyjymm3YjeZovLVtacBuDa+ABXhjKocXAm5Ls5viw9fm5e833O
         VmOcxEI6p+2Lv0pC5+5Uz7zV2Jlzb1heRtGCK1HMtTN9F6sL6Mnpj+B380D4pQprZXXK
         QmxKLWXsLFL/tB/XI+OVz+zl1EpJ+XvS3DjQkCsu+fUrpR9BR2ptzx7V3b2S9tyjV7GU
         YzAzHaekdr6MVwTF7k4r6iJddf1AD/rFo+75HZA7pjW1Tt3KMRxqQC9FW3jsFBCJrKjv
         oouglMRuS/uVo2xE+hgnDyx2lml2cXPLIjQhKKuzXZsEF2xJAbDMmpkYCZF0FUX+WtQ/
         vthA==
X-Gm-Message-State: AOAM532q2CT7yJimL/isS+W1PKX4uwEw8SD2A4RTgU4A+MIkBcWYSE1/
        xrwxj8nvkYxZyc6pVoPX1qZNUuXl6WnR65iyK2qIa3GtrGKMdMGjHfM+cfP2MReQdKDAAB5rKOM
        Kf/WmVxVxYPFbTYVvsOPxsbSD
X-Received: by 2002:a5d:6a51:: with SMTP id t17mr3894810wrw.80.1602661087401;
        Wed, 14 Oct 2020 00:38:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwBiv7wrGX+MTvq30rTo8SD0FHmRmImjXpCdS8+g+Lk7ZwbrL6ugKFNPTksk3HjUvonw81fBQ==
X-Received: by 2002:a5d:6a51:: with SMTP id t17mr3894791wrw.80.1602661087201;
        Wed, 14 Oct 2020 00:38:07 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id y66sm2618360wmd.14.2020.10.14.00.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 00:38:06 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, mbenes@suse.cz,
        raphael.gault@arm.com, benh@kernel.crashing.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [PATCH v3 1/3] objtool: check: Fully validate the stack frame
Date:   Wed, 14 Oct 2020 08:38:00 +0100
Message-Id: <20201014073802.436630-2-jthierry@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201014073802.436630-1-jthierry@redhat.com>
References: <20201014073802.436630-1-jthierry@redhat.com>
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
 tools/objtool/check.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index f50ffa243c72..87f10e726a75 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1671,12 +1671,20 @@ static bool has_modified_stack_frame(struct instruction *insn, struct insn_state
 	return false;
 }
 
+static bool check_reg_frame_pos(const struct cfi_reg *reg,
+				int expected_offset)
+{
+	return reg->base == CFI_CFA &&
+	       reg->offset == expected_offset;
+}
+
 static bool has_valid_stack_frame(struct insn_state *state)
 {
 	struct cfi_state *cfi = &state->cfi;
 
-	if (cfi->cfa.base == CFI_BP && cfi->regs[CFI_BP].base == CFI_CFA &&
-	    cfi->regs[CFI_BP].offset == -16)
+	if (cfi->cfa.base == CFI_BP &&
+	    check_reg_frame_pos(&cfi->regs[CFI_BP], -cfi->cfa.offset) &&
+	    check_reg_frame_pos(&cfi->regs[CFI_RA], -cfi->cfa.offset + 8))
 		return true;
 
 	if (cfi->drap && cfi->regs[CFI_BP].base == CFI_BP)
@@ -1805,8 +1813,7 @@ static int update_cfi_state(struct instruction *insn, struct cfi_state *cfi,
 		case OP_SRC_REG:
 			if (op->src.reg == CFI_SP && op->dest.reg == CFI_BP &&
 			    cfa->base == CFI_SP &&
-			    regs[CFI_BP].base == CFI_CFA &&
-			    regs[CFI_BP].offset == -cfa->offset) {
+			    check_reg_frame_pos(&regs[CFI_BP], -cfa->offset)) {
 
 				/* mov %rsp, %rbp */
 				cfa->base = op->dest.reg;
-- 
2.25.4

