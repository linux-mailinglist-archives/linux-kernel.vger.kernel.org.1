Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 584973012B3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 04:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbhAWDjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 22:39:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbhAWDjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 22:39:17 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF27BC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 19:38:36 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id n25so5176917pgb.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 19:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=rgE+B9Mrz90Zoy2CynzPCLRveYysdlsrC4gZsCIAkuM=;
        b=1tPPgjLYT4ZzQn5b/I2jMEKDvzLt8mGpKGecfT7x9A2WpilOduevn+l3oBiBquY/1L
         ihcAacWIxk5kPJXqiu0MvHCm34IbE2JQzUZbSfEBU/TpWu9g3L1tZEWpxMPzlSdi+/wL
         JkvV5KsdmaocZSKZl931LEzkMjuIDVn40aS21M1XH9ZQ7FbC5JWcFKMuOdK9znG6xgoU
         /Uzdx+DVsqpmarHy7Edg5Bagd9t8m1AsbNNoDULQ3fHbMyV3+QiyJy/Y4m0YeMIEcOfT
         s5YPFSCj3jxG/pzsc/J3YPtiHcAczsJyShEdmiJfcJHIIFA7JSS45TNfjR5+6eWqIFNc
         4DvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=rgE+B9Mrz90Zoy2CynzPCLRveYysdlsrC4gZsCIAkuM=;
        b=USNUQHx7ug5ULHjp4i96J3yixuaDMNUV0+ENZpVQw0ZSwt9M+xHpQ3N914h0mKWnsl
         q4ulkj41q5O5hl7SRI6V4WI93iILPop+LCmnt6KmyJCBRYGUmoRD3rcOL3QuRD15yvPr
         4mpeAFmOq8WKAwFT5TiFU5U1yUbaCBPtoT0HLzmBbEbMgXG8I/1ft8d4YhSz7wXbpaez
         q0F0IZCrlnjYN6ApKgw0pM+LiJ2/8subkEvmCqR8nkr3DVeqRSGgp1+ybeJWfK5wTg5s
         nlPCh52BMKUHVm53kbloQ5EZ6oLcOccq4YorOEALNxCtAuC6rCGD8lkQ00XgNAtrJrmz
         jgYg==
X-Gm-Message-State: AOAM530fAhhqb/+nsZ5r157Y7aV/6JhmWCu9UvxKgrlMzeW7JOe60nqh
        tophCs5gXJ63Urtvlm6dn0+S1A==
X-Google-Smtp-Source: ABdhPJwdsmSCYteHe2T3KocLJ0IwQOD8NOx/8uEh3HWRw4w4ash8wQScLA8ymNyhTaMaP8FamxMMtw==
X-Received: by 2002:a65:6484:: with SMTP id e4mr7846939pgv.401.1611373116212;
        Fri, 22 Jan 2021 19:38:36 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id 68sm10045654pfe.33.2021.01.22.19.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 19:38:35 -0800 (PST)
Subject: [PATCH] RISC-V: probes: Treat the instruction stream as host-endian
Date:   Fri, 22 Jan 2021 19:34:29 -0800
Message-Id: <20210123033429.2072716-1-palmer@dabbelt.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        penberg@kernel.org, guoren@linux.alibaba.com, me@packi.ch,
        mhiramat@kernel.org, mingo@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Palmer Dabbelt <palmerdabbelt@google.com>,
        kernel test robot <lkp@intel.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:         linux-riscv@lists.infradead.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmerdabbelt@google.com>

Neither of these are actually correct: the instruction stream is defined
(for versions of the ISA manual newer than 2.2) as a stream of 16-bit
little-endian parcels, which is different than just being little-endian.
In theory we should represent this as a type, but we don't have any
concrete plans for the big endian stuff so it doesn't seem worth the
time -- we've got variants of this all over the place.

Instead I'm just dropping the unnecessary type conversion, which is a
NOP on LE systems but causes an sparse error as the types are all mixed
up.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/riscv/kernel/probes/decode-insn.c | 2 +-
 arch/riscv/kernel/probes/kprobes.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/probes/decode-insn.c b/arch/riscv/kernel/probes/decode-insn.c
index 0876c304ca77..0ed043acc882 100644
--- a/arch/riscv/kernel/probes/decode-insn.c
+++ b/arch/riscv/kernel/probes/decode-insn.c
@@ -16,7 +16,7 @@
 enum probe_insn __kprobes
 riscv_probe_decode_insn(probe_opcode_t *addr, struct arch_probe_insn *api)
 {
-	probe_opcode_t insn = le32_to_cpu(*addr);
+	probe_opcode_t insn = *addr;
 
 	/*
 	 * Reject instructions list:
diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
index e60893bd87db..a2ec18662fee 100644
--- a/arch/riscv/kernel/probes/kprobes.c
+++ b/arch/riscv/kernel/probes/kprobes.c
@@ -57,7 +57,7 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
 	}
 
 	/* copy instruction */
-	p->opcode = le32_to_cpu(*p->addr);
+	p->opcode = *p->addr;
 
 	/* decode instruction */
 	switch (riscv_probe_decode_insn(p->addr, &p->ainsn.api)) {
-- 
2.30.0.280.ga3ce27912f-goog

