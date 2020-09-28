Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D65FC27AADD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 11:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgI1Jgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 05:36:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23235 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726461AbgI1Jgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 05:36:47 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601285806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/WgS1xrAGNaR1w25bpfxAMCDpceOdkO5sDtEbF+SHm8=;
        b=gbuhPQ5/OfZprSFL8ROKm18+w8nYo3ZBd55mBTP7NTNBXwkS0amEHdp24S3TXz2sD2IdJu
        gr5QCoBUcmJhRNIiJDBKpejbA3dsbHZL1pVqzL38eIRD71hEgF1qikF4ioUqHN8q688msi
        lqrarfX3rhOM7rtK5fWOILKzPhQVx6U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-MC3afXSWPbePNl6GUTtOxw-1; Mon, 28 Sep 2020 05:36:45 -0400
X-MC-Unique: MC3afXSWPbePNl6GUTtOxw-1
Received: by mail-wr1-f71.google.com with SMTP id v12so175141wrm.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 02:36:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/WgS1xrAGNaR1w25bpfxAMCDpceOdkO5sDtEbF+SHm8=;
        b=Nvn67nbch61rkVu9PWXR5CyJXa0JKM0ubM2vdGIPzlBgPk7PFE+Fta00uUFH3HLoZE
         9Uaf0f8bI4nlIJeSVPC6WL4i8cFjfNsY6PhkkX+iJ6mTIUxx6V+cWEsi1S6sqWba23ub
         ZQ92nMFeabPWgtbbWHGsDBbKulOfMD+WXy/Sio9nTq6aRN0+UsjvNLuG6E0yZDApWFIL
         jHYGyu0nTj9aTB1OzQ8/l9KDd+6qK2hwfxOBJm0fRPordhYJ0ySWdPHDan8nnOD66c2S
         NAYuXv+Kd2LlrawcQUxyh+MgSx3CAEXEfqqlW8dyRIJtFcaTwMIfxL6M2h2CJe/CTElu
         m6AQ==
X-Gm-Message-State: AOAM530CLBqlnOKktIYxfcD0LvHEAOwKV8eo4neXz4OQd1cnBuRWdLNs
        QRGZ8R2sgCYyrBtCs1o7NGO0r1ouBRP7nMf/hrmUYOh/aFaYgtK/Q2sgTF/aSbJwEC5SO8NjV3q
        8M8UTg7uvF7dQDvuwXRf+1XHa
X-Received: by 2002:a7b:c3d0:: with SMTP id t16mr654041wmj.169.1601285803820;
        Mon, 28 Sep 2020 02:36:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz7AdNu30H9NDkb94aLqhmHIGYPCh17X+9H0WdF6XYR6RVkN6Vd2xmdDT+1N9VUDEp+czyu6A==
X-Received: by 2002:a7b:c3d0:: with SMTP id t16mr654010wmj.169.1601285803512;
        Mon, 28 Sep 2020 02:36:43 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id y207sm495967wmc.17.2020.09.28.02.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 02:36:42 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, mbenes@suse.cz,
        raphael.gault@arm.com, benh@kernel.crashing.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [PATCH v2 3/3] objtool: check: Make SP memory operation match PUSH/POP semantics
Date:   Mon, 28 Sep 2020 10:36:31 +0100
Message-Id: <20200928093631.210610-4-jthierry@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200928093631.210610-1-jthierry@redhat.com>
References: <20200928093631.210610-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Architectures without PUSH/POP instructions will always access the stack
though memory operations (SRC/DEST_INDIRECT). Make those operations have
the same effect on the CFA as PUSH/POP, with no stack pointer
modification.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/check.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 9f7a14a24a65..724293fd1f59 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2008,6 +2008,14 @@ static int update_cfi_state(struct instruction *insn, struct cfi_state *cfi,
 			break;
 
 		case OP_SRC_REG_INDIRECT:
+			if (!cfi->drap && op->dest.reg == cfa->base &&
+			    op->dest.reg == CFI_BP) {
+
+				/* mov disp(%rsp), %rbp */
+				cfa->base = CFI_SP;
+				cfa->offset = cfi->stack_size;
+			}
+
 			if (cfi->drap && op->src.reg == CFI_BP &&
 			    op->src.offset == cfi->drap_offset) {
 
@@ -2029,6 +2037,12 @@ static int update_cfi_state(struct instruction *insn, struct cfi_state *cfi,
 				/* mov disp(%rbp), %reg */
 				/* mov disp(%rsp), %reg */
 				restore_reg(cfi, op->dest.reg);
+
+			} else if (op->src.reg == CFI_SP &&
+				   op->src.offset == regs[op->dest.reg].offset + cfi->stack_size) {
+
+				/* mov disp(%rsp), %reg */
+				restore_reg(cfi, op->dest.reg);
 			}
 
 			break;
@@ -2106,6 +2120,12 @@ static int update_cfi_state(struct instruction *insn, struct cfi_state *cfi,
 			/* mov reg, disp(%rsp) */
 			save_reg(cfi, op->src.reg, CFI_CFA,
 				 op->dest.offset - cfi->cfa.offset);
+
+		} else if (op->dest.reg == CFI_SP) {
+
+			/* mov reg, disp(%rsp) */
+			save_reg(cfi, op->src.reg, CFI_CFA,
+				 op->dest.offset - cfi->stack_size);
 		}
 
 		break;
-- 
2.25.4

