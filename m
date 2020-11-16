Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D47E2B5312
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388117AbgKPUoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 15:44:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387864AbgKPUoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:44:03 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3754C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:44:02 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id m125so578896wmm.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xKNCvRo+cWBEwv+iG/MqOVO9vnc8V12glB7ZKcx5VKU=;
        b=uvtq0SJM5qXrnU0ME9zmBaFSQlas8lUR7tXAjYQxsKCnU6Mv96yccWofgGjWu+D1mh
         mWB1poN3vE8wxaPrJkGniVj8DLW7wtyKzrW7pB0S2nrlEW7mmubhnTLbq12562XJlBnS
         NqyXt56AkUb0nSpz1xXjKNLpTQH/grHJMSQnDMLeFaQdzTuCAXGjfX1R50mMBgpmT8vN
         c+p8mqjYRZVp/LLUZS8+VAl+5VlGbGx+dETtuUiK5ziqTTCDt5AmCF5XhZcF1NsSuQyb
         KLASGz2sR/NGVL3uSGy4PgyqPt60UjINx4oNeJ69y4LjYxz+AgSt1IHhCe1qEiq1j7QD
         Pcxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xKNCvRo+cWBEwv+iG/MqOVO9vnc8V12glB7ZKcx5VKU=;
        b=BhhR+kL7GQlJYYQGwjS2xGx/7lSyHs1b+ehfTaSeJLB+IK0CFMy8/fMVX3f9N7dSKD
         EtFkWjT25JB8AM5bfcMA3XrNzoRW0iAhQwatxZxqUczYhF3CDjD6frgSqfs4dcFfAW0U
         AJO3wW+bbb9oUl4OtsVOc74ry0ESUvQYVB6rFiOqlWtmsWmrTcZMfq3LAG6oD2STEMW3
         W6TYY6f6/YQ3V7hRc3yLY3AXUSFahn6AhSBlQFKkYPyBwNSIfk5Gf2apmxTYZ71L5vHO
         v5ajYXinNmO8Kz6Z0yA8AJEZBqlentbP25h4nWbfwaewQXIFbXNTie4/A2JWPTcONGyc
         kSlw==
X-Gm-Message-State: AOAM532W+2fg9Eud2rlEyQa3uiyoYg6vG2c3CSncnDChat7Qh+kSeFmW
        BydbJQc7RM6Y2FkTcFbTktgz8va2RlOYZlW/W1s=
X-Google-Smtp-Source: ABdhPJyIANBejihi3jGdjfX3z634hE2xrtyZytrb2OvyN3PLZZcUButBGlO29at3MIhqZkdG/pkKGA==
X-Received: by 2002:a1c:bd0b:: with SMTP id n11mr718274wmf.111.1605559441419;
        Mon, 16 Nov 2020 12:44:01 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:bc40:bd71:373a:1b33])
        by smtp.gmail.com with ESMTPSA id 18sm557066wmo.3.2020.11.16.12.44.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2020 12:44:00 -0800 (PST)
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
Subject: [PATCH v2 18/24] kvm: arm64: Add function to enter host from KVM nVHE hyp code
Date:   Mon, 16 Nov 2020 20:43:12 +0000
Message-Id: <20201116204318.63987-19-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116204318.63987-1-dbrazdil@google.com>
References: <20201116204318.63987-1-dbrazdil@google.com>
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
index 52dae5cd5a28..170d6f6376ae 100644
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
2.29.2.299.gdc1121823c-goog

