Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8BA28DA90
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 09:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbgJNHiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 03:38:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57135 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728281AbgJNHiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 03:38:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602661094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4fAIhOkqsR9SbvTSajxJK62o21fkRY9D258Ab7LxX8c=;
        b=Kx8NnsSBM9qmHe41qEU9nJXMiqWw4/nPgIbroSb9xTm4EsDLwnKof8rTWIvDqiHXWw5hcY
        J/i66+lXYOKaz1yVqeqlBi6cGdaOwTdARvXvu5aYOK8/NZw7z0nGOWwf+aSdJuC5PYV6Bt
        Ioqsr2vlMZF7rlZK8niNuXCSA6/1kM4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-PqtV0xicP3uAMpKidgHAwg-1; Wed, 14 Oct 2020 03:38:12 -0400
X-MC-Unique: PqtV0xicP3uAMpKidgHAwg-1
Received: by mail-wr1-f70.google.com with SMTP id t17so916339wrm.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 00:38:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4fAIhOkqsR9SbvTSajxJK62o21fkRY9D258Ab7LxX8c=;
        b=ZN69xFW5d+mbWWV1w53Gw5wqfBC9gHg3tD64mB9/9gDnoutE+mXFc9PaZ/wOV+2IJ4
         ie+fLfy02XBVDPfaNJ76dgj//TjTHCJ1mGGAsmIsxjtZxqEBQaVhtJ5YkUIOA3SygMo1
         C6K7uHs3Zf2gh/InfVTnzHZh/MhDshQ+xU+0C6AXCr8uak/0+eLi5KyEbynRTVzgiBek
         LVhWJVgbXsy3pZVPJzGa3IxlBXg1pJzxgXhT3+1EFhxrcv9Afdqd6fKDbOa2olciHfif
         ZkfhDgb66Ep+xgOTVvF4/peXjf/xGPsqYs38vX4/8keOY5I5MNlo2ZXhvBUBzoF+RUKO
         1NrA==
X-Gm-Message-State: AOAM530r6Da6GS3Edn1BFBDOZ4AuQ9h3dHKhLrQVNcyRAzmu6ACcyZ5u
        fEM94jaqjOozJzmnw7941K5UOmCbp1g3kEOUx6boZ4mdfAqqXKLzbYIHmspNx8loKIIG1F3CddK
        +y4AOIlEZTtfaw4ko+oc1uA50
X-Received: by 2002:adf:f305:: with SMTP id i5mr3872645wro.346.1602661090816;
        Wed, 14 Oct 2020 00:38:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy/JeM/MwxnSopPo7jOTunx4OyJhcaKZubO5iXlV6y+bNaiXBMwEZTFpsj2jqDp37Xt8AXkuA==
X-Received: by 2002:adf:f305:: with SMTP id i5mr3872629wro.346.1602661090685;
        Wed, 14 Oct 2020 00:38:10 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id y66sm2618360wmd.14.2020.10.14.00.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 00:38:10 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, mbenes@suse.cz,
        raphael.gault@arm.com, benh@kernel.crashing.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [PATCH v3 3/3] objtool: check: Make SP memory operation match PUSH/POP semantics
Date:   Wed, 14 Oct 2020 08:38:02 +0100
Message-Id: <20201014073802.436630-4-jthierry@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201014073802.436630-1-jthierry@redhat.com>
References: <20201014073802.436630-1-jthierry@redhat.com>
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
index 815aeb770930..32ee9902ade2 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2003,6 +2003,14 @@ static int update_cfi_state(struct instruction *insn, struct cfi_state *cfi,
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
 
@@ -2024,6 +2032,12 @@ static int update_cfi_state(struct instruction *insn, struct cfi_state *cfi,
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
@@ -2101,6 +2115,12 @@ static int update_cfi_state(struct instruction *insn, struct cfi_state *cfi,
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

