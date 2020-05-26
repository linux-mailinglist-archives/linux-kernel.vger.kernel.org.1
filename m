Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D68331B4BDB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Apr 2020 19:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgDVRgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Apr 2020 13:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726006AbgDVRgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 13:36:52 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D640FC03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 10:36:52 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a32so1237726pje.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 10:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.washington.edu; s=goo201206;
        h=from:to:cc:subject:date:message-id;
        bh=pKJyhXiuj2Ugps4yZFwXPuLBd6CO2XHLk23yr11XPUU=;
        b=Wuka4V05WpA33NOcmcV0RQM00BdjsKcI5C+v7II9CcXxeP5oTz0fUXRvK2hWnStDuu
         B+edBNqq5jKuoLBSsqY1Pn9fsX4nweAnbBF6UDJ12raphayaz3bglemue6WYhqD0h0y3
         3XsrUI1ME6gxllaG/ZuBxLXkSNvdepQMAF3MA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pKJyhXiuj2Ugps4yZFwXPuLBd6CO2XHLk23yr11XPUU=;
        b=XRYxipeJ/5k62ikK4IKAR33mgBB72AytV9RDvtKYQJ0320uVGjOqezmSIdw2fUaCe+
         34kiiAZIZWAdNYMkjMsKwegle83gR4GKvub17L8XoGFEZHs09QYt+PFPrdgE4by6cgO7
         bHiH8GI2GUV757AhhNyZM+RRkjjDZpDQVe5Y9rzGXKDcuZY3YX1NE+CSoW5PY9tMl4YQ
         OgwMywD5IT/I7PkOumZ6/CTm/G/gKNHzjwp25AKHnetM9k0vfXc4uTgoYXvbUVlVet0S
         WyWLyEtErFWFQCG0D+nx+jmAx9HzI5K8VNpGjZSDpXoxGLftEV8OK14pUWJZ0wExvt9/
         uhgg==
X-Gm-Message-State: AGi0PuaVM+cFb3DOqfNUQidPRN42vxuuuI4u4YdWr6xRWHrB/bvIk+Ql
        qvmI67fOLuPXqCME4biQpycA/g==
X-Google-Smtp-Source: APiQypLrcgjFGa1gJskocnU6csUZlxRb1FTlBXblSlEAwl5l99pthecQNlgX1AdQ79pDzCy2Jf4H2g==
X-Received: by 2002:a17:90a:db46:: with SMTP id u6mr13131918pjx.15.1587577012060;
        Wed, 22 Apr 2020 10:36:52 -0700 (PDT)
Received: from localhost.localdomain (c-73-53-94-119.hsd1.wa.comcast.net. [73.53.94.119])
        by smtp.gmail.com with ESMTPSA id 1sm59514pff.151.2020.04.22.10.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 10:36:51 -0700 (PDT)
From:   Luke Nelson <lukenels@cs.washington.edu>
X-Google-Original-From: Luke Nelson <luke.r.nels@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Brian Gerst <brgerst@gmail.com>,
        Luke Nelson <luke.r.nels@gmail.com>,
        Xi Wang <xi.wang@gmail.com>, Wang YanQing <udknight@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf v2 1/2] bpf, x86_32: Fix incorrect encoding in BPF_LDX zero-extension
Date:   Wed, 22 Apr 2020 10:36:29 -0700
Message-Id: <20200422173630.8351-1-luke.r.nels@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current JIT uses the following sequence to zero-extend into the
upper 32 bits of the destination register for BPF_LDX BPF_{B,H,W},
when the destination register is not on the stack:

  EMIT3(0xC7, add_1reg(0xC0, dst_hi), 0);

The problem is that C7 /0 encodes a MOV instruction that requires a 4-byte
immediate; the current code emits only 1 byte of the immediate. This
means that the first 3 bytes of the next instruction will be treated as
the rest of the immediate, breaking the stream of instructions.

This patch fixes the problem by instead emitting "xor dst_hi,dst_hi"
to clear the upper 32 bits. This fixes the problem and is more efficient
than using MOV to load a zero immediate.

This bug may not be currently triggerable as BPF_REG_AX is the only
register not stored on the stack and the verifier uses it in a limited
way, and the verifier implements a zero-extension optimization. But the
JIT should avoid emitting incorrect encodings regardless.

Fixes: 03f5781be2c7b ("bpf, x86_32: add eBPF JIT compiler for ia32")
Signed-off-by: Xi Wang <xi.wang@gmail.com>
Signed-off-by: Luke Nelson <luke.r.nels@gmail.com>
---
v1 -> v2: Updated commit message to better reflect the bug.
          (H. Peter Anvin and Brian Gerst)
---
 arch/x86/net/bpf_jit_comp32.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
index 4d2a7a764602..cc9ad3892ea6 100644
--- a/arch/x86/net/bpf_jit_comp32.c
+++ b/arch/x86/net/bpf_jit_comp32.c
@@ -1854,7 +1854,9 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 					      STACK_VAR(dst_hi));
 					EMIT(0x0, 4);
 				} else {
-					EMIT3(0xC7, add_1reg(0xC0, dst_hi), 0);
+					/* xor dst_hi,dst_hi */
+					EMIT2(0x33,
+					      add_2reg(0xC0, dst_hi, dst_hi));
 				}
 				break;
 			case BPF_DW:
-- 
2.17.1

