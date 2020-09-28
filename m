Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBA5127AADF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 11:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgI1Jgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 05:36:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52533 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726477AbgI1Jgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 05:36:47 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601285805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DY6cg62Ey5F2ROJM/bs73Z39aAYVa4/dTeUdSZUIBM8=;
        b=AoeWP2DamN0RTVOg9xjwoyTm+9EWltX7fYQH3oWtgcOqSL66/YCYMAEWeT87/awWFKphCz
        rQdOV6MK2YXKZvpdXLOFWsbhGXEwze8HfDseih74xb+icPQKZamsx6z+XSC0bBHvFKS9Jq
        QQTw5I3JXKCIYBs9LN+vh9v3gs0eInQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-ZSuDLR3sPGGEvXFAN5qi3g-1; Mon, 28 Sep 2020 05:36:43 -0400
X-MC-Unique: ZSuDLR3sPGGEvXFAN5qi3g-1
Received: by mail-wr1-f70.google.com with SMTP id f18so164453wrv.19
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 02:36:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DY6cg62Ey5F2ROJM/bs73Z39aAYVa4/dTeUdSZUIBM8=;
        b=I3/Y8UOGDwtEah4rmSE3euOBjEGuh4glQGsqS2txeqcWWIL1+H9DiMgAxhCBSKpxJM
         EOcXe7EOei7j5EfWO6ArPUe0saF2GFx6s7hb/x3VKsknY7RvRcIODtQDxQwexFGi20f4
         i5O4E8E2fw5ENcSiaqcbGg/mWMBHy/rfHg2TEslB3TElBiqxucDggScD2JNnTr8y+QON
         4dk1bbXbBoYYV4jBbIkuFKHK7qk4K+c/+8IkCjUJ6JSBYajN2LQ/UrEB5CzWVkhnPrzy
         2uxLcsEEXuNg/iKVl8kXGrvFBoSjmf3b6LLmNbc3QA9O4AihqyAREsD4JUOdzII5lRU1
         012A==
X-Gm-Message-State: AOAM530RCWb84H+RbKsOWJgJTouzY9FBYG2bTMTqDsdaoBFZIvatdgUr
        /TxMdAET8RcJ+PPWvFfzdcPyEkBnFLPDtG4AUxKu4kh7dH0SXSQ3qMd0Tve/YjOdn+pnYKUliKk
        XXzBkIpmF/goT9Gh5za8yz48E
X-Received: by 2002:a5d:460c:: with SMTP id t12mr651659wrq.225.1601285801996;
        Mon, 28 Sep 2020 02:36:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZzBmYnMqpxdCpMLHno278MbnPiTDFQ3bJTFs4AL8PSuIhtlyPZMhB9fYRyYrGCTdp3x+55A==
X-Received: by 2002:a5d:460c:: with SMTP id t12mr651635wrq.225.1601285801813;
        Mon, 28 Sep 2020 02:36:41 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id y207sm495967wmc.17.2020.09.28.02.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 02:36:41 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, mbenes@suse.cz,
        raphael.gault@arm.com, benh@kernel.crashing.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [PATCH v2 2/3] objtool: check: Support addition to set CFA base
Date:   Mon, 28 Sep 2020 10:36:30 +0100
Message-Id: <20200928093631.210610-3-jthierry@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200928093631.210610-1-jthierry@redhat.com>
References: <20200928093631.210610-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On arm64, the compiler can set the frame pointer either
with a move operation or with and add operation like:

    add (SP + constant), BP

For a simple move operation, the CFA base is changed from SP to BP.
Handle also changing the CFA base when the frame pointer is set with
an addition instruction.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/check.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 50b3a4504db1..9f7a14a24a65 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1901,6 +1901,19 @@ static int update_cfi_state(struct instruction *insn, struct cfi_state *cfi,
 				break;
 			}
 
+			if (!cfi->drap && op->src.reg == CFI_SP &&
+			    op->dest.reg == CFI_BP && cfa->base == CFI_SP &&
+			    check_reg_frame_pos(&regs[CFI_BP],
+						-cfa->offset + op->src.offset + STACKFRAME_SIZE,
+						STACKFRAME_BP_OFFSET)) {
+
+				/* lea disp(%rsp), %rbp */
+				cfa->base = CFI_BP;
+				cfa->offset -= op->src.offset;
+				cfi->bp_scratch = false;
+				break;
+			}
+
 			if (op->src.reg == CFI_SP && cfa->base == CFI_SP) {
 
 				/* drap: lea disp(%rsp), %drap */
-- 
2.25.4

