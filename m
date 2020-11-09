Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD3C72AB6F4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 12:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729644AbgKILdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 06:33:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729698AbgKILdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 06:33:10 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F284C0613D4
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 03:33:10 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id d142so7643611wmd.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 03:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JvpizBPB+yAcRM4Glrg0Xz/WI/kNrOgIVHNM6YK4qt4=;
        b=N2oJBCvh3937hgiPHLvZgGr+8MSRUE7jzDGHq0E50z6OYpJoviAI+Xy+tr2bS0Syvc
         +ZA+cH3vl48CQyezHZWrr0hsUW0+r2EZ6OeZLjXssBKk/pSDriWqjxTyqQ7ST3tmHyqF
         ojXap54Rd+mTWUbYv7iy/HnlawErOxKQDgXnpzxTo3VUBxFhv71nPdfHde+dLFrJVUZn
         hqQIXwZBBwj5kox6c0qfhMKvyfpmvktLIKzuR+LqAdiec/hRcTOb7Yr0X94B7NSUR7M6
         hPvmnLDkj0OL3qcnlSBtNY6UN5nzgTQIz10dNHEg26o/m74ZmfeC0qHwRX77LEdResiu
         Yccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JvpizBPB+yAcRM4Glrg0Xz/WI/kNrOgIVHNM6YK4qt4=;
        b=BAl423TmC5h4L+WbFAcqWlpWPPtxyJZGfksenlz2rUOwGzLuE3SN72M+ieZCsJAhOK
         vR6oGECzh0KuaGz8nRKStJG2WU7nY9tM6a+TosCl1u6M5kLbWsDBFzSjuJtd0v27tio5
         x21yPjNCXdHx0Bcd4RsI/MQdANrPiKinSpllOQxCZURRfkq+SfW0MTNuzUW/+CWtBB1p
         vziU2pSOWnsm5u2U0FCkMYSspq7S6bb7Thzky1oElP7zOkR2oH5ZR+CvoyonaFU3OP9B
         ZZYiLZMcP+BMEqcNlJ57hZlv39HKJHT9uzJwuEt9PPLUzpwOoRyLdqCRKoE7wFY+OAek
         RX5Q==
X-Gm-Message-State: AOAM530JmiSZgr/BkfXYgTMubMRjBWDBwG/40VekaeqvLp3ytydBS2If
        I0ruqGRd7PqhlGxx5Cua5cSAIZ5ifk1NmjMq
X-Google-Smtp-Source: ABdhPJwNkMDI36maGIPoQF9cj4OihOCg6Qd2vk9HMNRujo30A1ZVB6rxqcsQTVcMVxkwuxyP6czVZw==
X-Received: by 2002:a1c:56c4:: with SMTP id k187mr13931516wmb.92.1604921588714;
        Mon, 09 Nov 2020 03:33:08 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:209d:10b7:c480:3e1f])
        by smtp.gmail.com with ESMTPSA id r1sm655701wrt.6.2020.11.09.03.33.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 03:33:07 -0800 (PST)
From:   David Brazdil <dbrazdil@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Quentin Perret <qperret@google.com>,
        Andrew Scull <ascull@google.com>,
        Andrew Walbran <qwandor@google.com>, kernel-team@android.com,
        David Brazdil <dbrazdil@google.com>
Subject: [PATCH v1 14/24] kvm: arm64: Add function to enter host from KVM nVHE hyp code
Date:   Mon,  9 Nov 2020 11:32:23 +0000
Message-Id: <20201109113233.9012-15-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201109113233.9012-1-dbrazdil@google.com>
References: <20201109113233.9012-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All nVHE hyp code is currently executed as handlers of host's HVCs. This
will change as nVHE starts intercepting host's PSCI CPU_ON SMCs. The
newly booted CPU will need to initialize EL2 state and then enter the
host. Add __host_enter function that branches into the existing
host state-restoring code after the trap handler would have returned.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kvm/hyp/nvhe/host.S | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/kvm/hyp/nvhe/host.S b/arch/arm64/kvm/hyp/nvhe/host.S
index ed27f06a31ba..ff04d7115eab 100644
--- a/arch/arm64/kvm/hyp/nvhe/host.S
+++ b/arch/arm64/kvm/hyp/nvhe/host.S
@@ -41,6 +41,7 @@ SYM_FUNC_START(__host_exit)
 	bl	handle_trap
 
 	/* Restore host regs x0-x17 */
+__host_enter_restore_full:
 	ldp	x0, x1,   [x29, #CPU_XREG_OFFSET(0)]
 	ldp	x2, x3,   [x29, #CPU_XREG_OFFSET(2)]
 	ldp	x4, x5,   [x29, #CPU_XREG_OFFSET(4)]
@@ -63,6 +64,14 @@ __host_enter_without_restoring:
 	sb
 SYM_FUNC_END(__host_exit)
 
+/*
+ * void __noreturn __host_enter(struct kvm_cpu_context *host_ctxt);
+ */
+SYM_FUNC_START(__host_enter)
+	mov	x29, x0
+	b	__host_enter_restore_full
+SYM_FUNC_END(__host_enter)
+
 /*
  * void __noreturn __hyp_do_panic(bool restore_host, u64 spsr, u64 elr, u64 par);
  */
-- 
2.29.2.222.g5d2a92d10f8-goog

