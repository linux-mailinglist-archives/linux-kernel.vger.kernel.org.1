Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B24E928DA8E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 09:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbgJNHiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 03:38:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39647 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728208AbgJNHiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 03:38:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602661092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zS6+XpfxlYwAszKmwUTbmTv+BIABgJlNrMhpGM8DlgI=;
        b=i2IGD5UJw0+Uy5+1vRc63+RfLU2/stNSgnB6i6mKA+uqpuW81Rbi2O5MIq5mJkvnpcMHuv
        B/QiU1R17Lc5jCfTuEW2kEb1dHag40wWbPAfKY9p9RWHR2dZFqjw+6h0dIzVIHPMo4xyfD
        1rnt+vAb0MuK8MZEnUFBv60ruULOp94=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-tv6uhEpdN_GNe1sofOMNjQ-1; Wed, 14 Oct 2020 03:38:10 -0400
X-MC-Unique: tv6uhEpdN_GNe1sofOMNjQ-1
Received: by mail-wm1-f70.google.com with SMTP id 13so328693wmf.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 00:38:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zS6+XpfxlYwAszKmwUTbmTv+BIABgJlNrMhpGM8DlgI=;
        b=pQtTTJ6BIwJVSIZO8znmxoSbiWUA0LlJog6OIH3zxJAKLnx6P2WL+w2ZFXhRo5y6tF
         ZuprZNBXnKNVLzi3/jnfr/iZttYRhhtF5Bx/c81EkVAZ90/sYVhPGR2fUERT8YvfZg+E
         9cCnx4hwQ+7c2qHNStUuz2+GzFB1yTvZPBy7muSAWDJzFLQkVZDoO5fSSnn7Gu/e85Yf
         7RySiBxHrG1U6I1JsmsItleb6DVP0pwxkshvNeF05Sxku0AXEVjs7J7caMbmbAuboGxr
         G3F3uFTPmsNdc1zYYhbg3YLTVSB7shZ4k7jMpPlfs3ealo8VBxDCm5txMafBI+7DjzJV
         9IMA==
X-Gm-Message-State: AOAM532pyBvyXxJhtoz4dkv9c3AzhjGdSPQUzpMezULOwoQ4VQSoBA7W
        8NtwKuGGKJblZJhLKhH5kYA1sNCCWjdDGTiErXZ1GimEWn3vguMHTVTwMoRa+Hs02plyrANVJqj
        vynR0wQbMOA8lSX5NZA2fqm60
X-Received: by 2002:adf:e681:: with SMTP id r1mr3702604wrm.181.1602661089221;
        Wed, 14 Oct 2020 00:38:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyy1thCpGJyOcn0vFKRyEgTiw+JXEH74jDeizZaGjDJ0KT5F8lNEexcJOxSYjXozMSBB/CQRQ==
X-Received: by 2002:adf:e681:: with SMTP id r1mr3702585wrm.181.1602661089035;
        Wed, 14 Oct 2020 00:38:09 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id y66sm2618360wmd.14.2020.10.14.00.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 00:38:08 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, mbenes@suse.cz,
        raphael.gault@arm.com, benh@kernel.crashing.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [PATCH v3 2/3] objtool: check: Support addition to set CFA base
Date:   Wed, 14 Oct 2020 08:38:01 +0100
Message-Id: <20201014073802.436630-3-jthierry@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201014073802.436630-1-jthierry@redhat.com>
References: <20201014073802.436630-1-jthierry@redhat.com>
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
 tools/objtool/check.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 87f10e726a75..815aeb770930 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1898,6 +1898,17 @@ static int update_cfi_state(struct instruction *insn, struct cfi_state *cfi,
 				break;
 			}
 
+			if (!cfi->drap && op->src.reg == CFI_SP &&
+			    op->dest.reg == CFI_BP && cfa->base == CFI_SP &&
+			    check_reg_frame_pos(&regs[CFI_BP], -cfa->offset + op->src.offset)) {
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

