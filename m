Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB4D2A6CE1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 19:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732504AbgKDShF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 13:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732437AbgKDShC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 13:37:02 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D87DC0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 10:37:01 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id k18so3265560wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 10:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fuG04+12p5GokhKo0kAWDPgSX2S/UpZSRo8GkJtW9dc=;
        b=NS23bt/72SalQlPudTi1kUeX4t6arEB5xzntdPJJpX9s45iPtfgG25FglOu4DBwuIG
         qzomur1VBzBc4eT5elwu7R8DhwGP3UWqyIW03ua3R8FF0NAFV/hAEUHGoNvJ92aATLPG
         Hc50WuDGVvCyF2qvzN1oqJ0pQ/uzyS1xVgM5ySHGA/2Zr3YWI9emxF2G0MZ57rF8fn3+
         /WnduyCd+eCb7wr0OK7Tmj46TiKZLTLrEnko/9u8/wjW6APOdTjHk+YdTtjnX/xbcKQT
         NyqveU6uNgHoKOBvg7H8nh/7Qu06IfYBzm8UD65hQ3YltPI1FpIYhhvcUu8MMntcXDCu
         4+Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fuG04+12p5GokhKo0kAWDPgSX2S/UpZSRo8GkJtW9dc=;
        b=Pwcw+aKcPAMN/oA/Zz82OMTls69FolwUFt6EyoipgVxjYnEcyz4FRZ6jlUV6/KBGhQ
         2ggHKqAl+0oSqhB+AOeAn4HLFTa6khDcwD/QT/9Buk953UQi+C0R2FxuobwSeiu097sp
         x9Ga1+jsPOsJJxZxQ40Rc7fchOEfF9+j9ZKckj0JOQtGTrVJSNdq+Zel0E0U7BHUNqBI
         3bYOA0jwqRYmli9ybXXbNVdeK2tbOSYY6cRWITbnN2sIkkhU8M/aLw54OlBwcYgv2lu3
         UhSCUTWM1CWKnz99kdLZlBgW8T41wPD/LhVw+WZihLS7PicoZ74Jcam4R2X5M/O1+bDb
         FOtA==
X-Gm-Message-State: AOAM530uRcw1cPP5LdssbFSY0hmP0BbfG9UaSwSW3+S1fALpE0MO94as
        N1+vwJdrdl/ch5vaSgwBmbcbrA==
X-Google-Smtp-Source: ABdhPJwMQ/dqr9JqMtNDYjvCoJDFSybTlMO7ZERHRXz8pPXtXsVsNjnOk5mwvRVZ/l0H0MUNKyXdMw==
X-Received: by 2002:a1c:1d92:: with SMTP id d140mr6025920wmd.48.1604515019649;
        Wed, 04 Nov 2020 10:36:59 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:c8d2:30f2:53c6:bc2])
        by smtp.gmail.com with ESMTPSA id o184sm3518971wmo.37.2020.11.04.10.36.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 10:36:58 -0800 (PST)
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
        Andrew Scull <ascull@google.com>, kernel-team@android.com,
        David Brazdil <dbrazdil@google.com>
Subject: [RFC PATCH 10/26] kvm: arm64: Refactor handle_trap to use a switch
Date:   Wed,  4 Nov 2020 18:36:14 +0000
Message-Id: <20201104183630.27513-11-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201104183630.27513-1-dbrazdil@google.com>
References: <20201104183630.27513-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Small refactor so that nVHE's handle_trap uses a switch on the Exception
Class value of ESR_EL2 in preparation for adding a handler of SMC32/64.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kvm/hyp/nvhe/hyp-main.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 411b0f652417..19332c20fcde 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -16,9 +16,9 @@
 
 DEFINE_PER_CPU(struct kvm_nvhe_init_params, kvm_init_params);
 
-static void handle_host_hcall(unsigned long func_id,
-			      struct kvm_cpu_context *host_ctxt)
+static void handle_host_hcall(struct kvm_cpu_context *host_ctxt)
 {
+	unsigned long func_id = host_ctxt->regs.regs[0];
 	unsigned long ret = 0;
 
 	switch (func_id) {
@@ -109,11 +109,12 @@ static void handle_host_hcall(unsigned long func_id,
 void handle_trap(struct kvm_cpu_context *host_ctxt)
 {
 	u64 esr = read_sysreg_el2(SYS_ESR);
-	unsigned long func_id;
 
-	if (ESR_ELx_EC(esr) != ESR_ELx_EC_HVC64)
+	switch (ESR_ELx_EC(esr)) {
+	case ESR_ELx_EC_HVC64:
+		handle_host_hcall(host_ctxt);
+		break;
+	default:
 		hyp_panic();
-
-	func_id = host_ctxt->regs.regs[0];
-	handle_host_hcall(func_id, host_ctxt);
+	}
 }
-- 
2.29.1.341.ge80a0c044ae-goog

