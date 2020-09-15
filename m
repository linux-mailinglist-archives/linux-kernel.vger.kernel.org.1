Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAA526A0C5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 10:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgIOIZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 04:25:23 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42812 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726276AbgIOIMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 04:12:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600157536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N0dN3su4IJ/Z+C/nlgSMm0AHs4b+881J3iJWr6dOE8c=;
        b=HXyToJU64mkFAHDz4EeiQWCir2QievkMN5geQG4pmQgCD4Bapa8TsA8Z1GfLLzgvS2Mvri
        fZKUt2IdYq/bQU2Lw5xiKO58QEgekiaDYsLWKoznYJefGfJGoI3Svwu4dKODbrz36DEvP4
        9MFng4WZhwsgaTmOUaRqLrbWhHxKz5o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-sKi7k1w_Pj6VRhpMhb80gQ-1; Tue, 15 Sep 2020 04:12:14 -0400
X-MC-Unique: sKi7k1w_Pj6VRhpMhb80gQ-1
Received: by mail-wr1-f71.google.com with SMTP id l9so902071wrq.20
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 01:12:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N0dN3su4IJ/Z+C/nlgSMm0AHs4b+881J3iJWr6dOE8c=;
        b=kQjeZz8KLYOkcU5XKuXMsxUVvM9+y/i/ogesozRBs/mg9HHpz9OIzHrli80p0qtYDD
         SdHsCTkIako2xqwZKZ3BP7I8DdtNVw6QoJ+n2b3GItBT6W7Bfn/LuUnuQB8mun64M4Po
         1KOrJM9dtDNaelv6w7hJFnPGzBtOwUohUTHUJK239SrNEh/snoQBP+YAC4MclRmrybPe
         mKzIi3+lPnvuSkRCeI8Dodez/NuQY7y2KVewcIxcXppUZxkBSD88zFpICgfqnzPs4oP0
         Bb3moN03ML0z28N2BsS1MW60VZvHO0GKijKY1cdMHqGyEOjOGH3Q7OBj1HWoUbg1RhH3
         aBqQ==
X-Gm-Message-State: AOAM530LLThi6QGlQnLYCsAAw+mR7Lgkgh9KJ45XGXUwxQMaWgndNtDn
        SfjXPowGX0f9dH07E1sd54Y+pWCx68OUdt7Q39AVATxfy3GQiHh2g8+oUkz28/bc9wk/vuDL7Hq
        SE/89/YS4AdMBdk64TjsYrEla
X-Received: by 2002:a7b:cf27:: with SMTP id m7mr3397667wmg.74.1600157533060;
        Tue, 15 Sep 2020 01:12:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrKy8pjIawJP3SoJT6bv3mj4n25nKcnf/d1Sno/PxF//23XIx9AmeZZSBa6ke6EPujktxKwA==
X-Received: by 2002:a7b:cf27:: with SMTP id m7mr3397648wmg.74.1600157532908;
        Tue, 15 Sep 2020 01:12:12 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id x16sm24661372wrq.62.2020.09.15.01.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 01:12:12 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, mbenes@suse.cz,
        raphael.gault@arm.com, benh@kernel.crashing.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [PATCH 3/3] objtool: check: Make SP memory operation match PUSH/POP semantics
Date:   Tue, 15 Sep 2020 09:12:04 +0100
Message-Id: <20200915081204.9204-4-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200915081204.9204-1-jthierry@redhat.com>
References: <20200915081204.9204-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Architectures without PUSH/POP instructions will always access the stack
though memory operations (SRC/DEST_INDIRECT). Make those operations have
the same effect on the CFA as PUSH/POP, with no stack pointer
modification.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/check.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index f45991c2db41..7ff87fa3caec 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2005,6 +2005,13 @@ static int update_cfi_state(struct instruction *insn, struct cfi_state *cfi,
 			break;
 
 		case OP_SRC_REG_INDIRECT:
+			if (!cfi->drap && op->dest.reg == cfa->base) {
+
+				/* mov disp(%rsp), %rbp */
+				cfa->base = CFI_SP;
+				cfa->offset = cfi->stack_size;
+			}
+
 			if (cfi->drap && op->src.reg == CFI_BP &&
 			    op->src.offset == cfi->drap_offset) {
 
@@ -2026,6 +2033,11 @@ static int update_cfi_state(struct instruction *insn, struct cfi_state *cfi,
 				/* mov disp(%rbp), %reg */
 				/* mov disp(%rsp), %reg */
 				restore_reg(cfi, op->dest.reg);
+			} else if (op->src.reg == CFI_SP &&
+				   op->src.offset == regs[op->dest.reg].offset + cfi->stack_size) {
+
+				/* mov disp(%rsp), %reg */
+				restore_reg(cfi, op->dest.reg);
 			}
 
 			break;
@@ -2103,6 +2115,11 @@ static int update_cfi_state(struct instruction *insn, struct cfi_state *cfi,
 			/* mov reg, disp(%rsp) */
 			save_reg(cfi, op->src.reg, CFI_CFA,
 				 op->dest.offset - cfi->cfa.offset);
+		} else if (op->dest.reg == CFI_SP) {
+
+			/* mov reg, disp(%rsp) */
+			save_reg(cfi, op->src.reg, CFI_CFA,
+				 op->dest.offset - cfi->stack_size);
 		}
 
 		break;
-- 
2.21.3

