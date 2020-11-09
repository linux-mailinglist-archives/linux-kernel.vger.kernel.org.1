Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A09382AB73E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 12:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729609AbgKILg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 06:36:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729566AbgKILdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 06:33:02 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0636C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 03:32:59 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id s8so1210832wrw.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 03:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R9d1+peEDKIDAC4BUkJrLbr91HxlsiVlv7gVncj7oJE=;
        b=Nlkt2NoSN06mNMUiV4czGigWOfDI7alqjAr/VMiKAFi8r6SvbUFmz5qPCSigNbzGOt
         CcGl9WRnVJZlERP13JXxePqpq+CU1BM2zj7a30/EIygFZ19rzJYInzQrH0Ljz4jw7llX
         f1jQJ0Kc8LLGgt1H2glCPIT3bTzTawZk3J/ZwhQ/dbCiyJR8NCUeqezVV4pN1JrRhYD+
         1H/QFadgpHUUQqKOgln9mSwviXlgghCm6zoyLHdi32xsm/LfSaHON6HH/BFfBXggztVp
         Xm6hUSHCwFGge2giBU9ofUcBQTbgyAdWT16BEx2thI/+/obwWbQx/TBHVlTa6aPc4rUM
         hr6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R9d1+peEDKIDAC4BUkJrLbr91HxlsiVlv7gVncj7oJE=;
        b=GxIIDQs1MYP+p9N6bcm28ViwroZSDagUB9KNvB2Ouk+g6rXO9daqa4saG5Sq7iIXgc
         5T1jRy2FwhOLrLzs3lPhAfb4QoEWXARoP4THH2K7BpJgMUX9WHSEYiVlIOadSdDH+SEv
         yfO9vh3+Qu2FcaJ9LjFOmNeIs/tOXF9Kba/yMSr9aPoj08XcDYtuzmDMXpvCLvxsDBUU
         vk8yse8v2MwPw5S/E+lvfnNnxhZeY0Ik0cZcoj9PUWNhzKUpWVB/YTAf2/fXIvIMyqmy
         3+IgopTK5fPfddrrHUWAXa++bc2alL2l13fy6SvdHkGT0HPR6fZJJexR9q+9gMyb1rMO
         3XRQ==
X-Gm-Message-State: AOAM532T65Cg2efs2pj+kWb+PZOhlKc0FbilMTF0o9V40GBtzdWx+isM
        QIRMjyLgoZe8ZTxQgscBah50lA==
X-Google-Smtp-Source: ABdhPJwYuIGUPqMp11VFz88V7y1F5zU6JG+SWQiwKv4yp8uGAfg16WUH01aMz+AxIfZqkyce6q2v2A==
X-Received: by 2002:a5d:6452:: with SMTP id d18mr7927464wrw.200.1604921578344;
        Mon, 09 Nov 2020 03:32:58 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:209d:10b7:c480:3e1f])
        by smtp.gmail.com with ESMTPSA id z14sm12812890wmc.15.2020.11.09.03.32.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 03:32:57 -0800 (PST)
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
Subject: [PATCH v1 09/24] kvm: arm64: Refactor handle_trap to use a switch
Date:   Mon,  9 Nov 2020 11:32:18 +0000
Message-Id: <20201109113233.9012-10-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201109113233.9012-1-dbrazdil@google.com>
References: <20201109113233.9012-1-dbrazdil@google.com>
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
2.29.2.222.g5d2a92d10f8-goog

