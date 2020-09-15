Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6A2426A0C4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 10:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgIOIZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 04:25:18 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24561 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726169AbgIOIMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 04:12:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600157534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AvXzJ+/mYa2k23WKizLT5MVkIFMKauBVgoE9b3QT1+c=;
        b=K4R9czi5PPKyvQBsdnHrqetwG7sqyT5Z8MjTfQ+/mlPVOaVpCYdJY1doGo2jBvjOQcZz7m
        P1wBKE/799zmpKJayeP9gANHUz0RIuhlsaeTKfKtb0fJcITNFTaAR7RUjB9VtjkEJ7f4KT
        zC+UdIZC32ZC6BHsPN/lKuPXTrLXQsA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-IAFZNgBqPhOeswxZETPlSw-1; Tue, 15 Sep 2020 04:12:12 -0400
X-MC-Unique: IAFZNgBqPhOeswxZETPlSw-1
Received: by mail-wr1-f72.google.com with SMTP id n15so901134wrv.23
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 01:12:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AvXzJ+/mYa2k23WKizLT5MVkIFMKauBVgoE9b3QT1+c=;
        b=jQPXIrtrupH4ppERglqTeNQBNpt12mmeS5BMf03Xyvdmrpa5BAckYwXz+QNGSESKkl
         oYyagWoyQv59cJSVRp/n9zLr/9wrSWvNIVpOMZeXD+Em+0edFKzRhA36op8DjoF++UFO
         kfxesQk7MbuRmKIdGpmjzuyvL7+ltywz1ArO8Mzjy+g+fM1POjDha9HqElrWqksaWOtJ
         IiTzCa8n9mg+DvvD+fXNN9r7/YGcx49jCxdiphMipWk0sKv8V8cQTNUFbM9e3F3XZt7N
         e52bzaLd40wHXhVS0HjKHKi007tXBR3FI7k1Y64ByyJ1Na7gboRWbhuLclL0DJGwUfhc
         oXbA==
X-Gm-Message-State: AOAM5329RAHi9C+aZWDEcGT9cjvS7GC3nMNVP2r4bE9wCBxZMgrvc2VR
        pC20uuUP9ETd26nChG3Xjr2sKjvIv++/1xmSp1q9wBWhp2HfzpOE/2cvYz/yaac6g4o/+WH5I7G
        rXEMrU1vaJ1rvnoPgBxs6f6Ms
X-Received: by 2002:a7b:cb82:: with SMTP id m2mr3635409wmi.56.1600157531397;
        Tue, 15 Sep 2020 01:12:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxCZCYSlAS9A9xrRkfDCeVMgyv1oEo8EmaKHr5yO8AkFmvnEwA7n84/9TAGi7zB1vMyhDpcrw==
X-Received: by 2002:a7b:cb82:: with SMTP id m2mr3635387wmi.56.1600157531233;
        Tue, 15 Sep 2020 01:12:11 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id x16sm24661372wrq.62.2020.09.15.01.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 01:12:10 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, mbenes@suse.cz,
        raphael.gault@arm.com, benh@kernel.crashing.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [PATCH 2/3] objtool: check: Support addition to set CFA base
Date:   Tue, 15 Sep 2020 09:12:03 +0100
Message-Id: <20200915081204.9204-3-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200915081204.9204-1-jthierry@redhat.com>
References: <20200915081204.9204-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of "mov SP, BP", a compiler could simply set BP
to SP + constant. Handle changing the CFA base in such cases.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/check.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 7db6761d28c2..f45991c2db41 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1898,6 +1898,19 @@ static int update_cfi_state(struct instruction *insn, struct cfi_state *cfi,
 				break;
 			}
 
+			if (!cfi->drap && op->src.reg == CFI_SP &&
+			    op->dest.reg == CFI_BP && cfa->base == CFI_SP &&
+			    check_reg_frame_pos(&regs[CFI_BP],
+						-cfa->offset + op->src.offset + CFA_SIZE,
+						CFA_BP_OFFSET)) {
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
2.21.3

