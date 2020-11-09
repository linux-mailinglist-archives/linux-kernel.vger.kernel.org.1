Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EACE12AB6FC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 12:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729788AbgKILdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 06:33:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729661AbgKILdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 06:33:16 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA006C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 03:33:15 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id 23so5250426wmg.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 03:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=caV1ipuiTawe8T6twZGVAfyUFvhkg9VCzsqdE5ZajF4=;
        b=sB/y2/Ui9hncBiir49+ICz2IN5o2gtyOCZwiJX/81JcCULdYTBnLUZyWbf6WVQntem
         ST3A4s2jm+XkTBO+sD3RVmCmxXbkleOYtQkWctTReDQDMpcUTd8lFfELThVx7bxsi3A+
         mvOkZQv7hxbi/TUEOZtp4ETbpxrbZrLYmIaYwxS6p4xqY1hdKrvJTKfq6C6+XLdCQYb8
         NUY4JS033hx/waCf51nR8AnhxJWjo9FCRMh00+hUa0kh/PrtaUg6VfqLa2Hr8xyE3Dpf
         +lBqYkLg5uQySHjRhpyROYvpOV29xnCuLkDENvnYQ4A2kG6ODvE3+I00D69G0vZ7YC1K
         5odw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=caV1ipuiTawe8T6twZGVAfyUFvhkg9VCzsqdE5ZajF4=;
        b=GLvBKy5BY/zq0mZmHpThzuJNeuz4XPniM9vdwAiMeChanQNv1FIR9UE6JfQQjlmk5P
         +Fl3cLGK2cNYoNwZfq3JedfshaV7Lb0bTVadRFU0ZBrrZEPukTHxVEXIiXp7f3S3eFQQ
         0duzUYLhVI7leOxIvg2atJv1kKUurjLDo+69YdNKyP3Xy7VQeAWeopRfg6gIV1BvSQqV
         L6Px2rtu1yL9t1oPkO5vcriEJ1IzKJ1B/2D3IGwZ/5BWoOXCpg8fNErGjpkFYF5Txznw
         o5BP9aYEsqxzP+KICdJpb5JrxNtZNTkgT9XFsDK2NkMat5TR0p6bnrq7omcsNS8aV/KA
         sNUQ==
X-Gm-Message-State: AOAM530C6yg23n4KFDbZPmC5xPFewftaw5+VWaw7FDtMq5NF0XQJJXQY
        Z6rVYxnDLePN0C4D1NBAnqXstw==
X-Google-Smtp-Source: ABdhPJzSRWUlAySru4rwQabNSKivoN+hTeZrlzLIDmklGE7PxHdfZql7hj+Mrx0wU/sAZLmtXqsBrw==
X-Received: by 2002:a7b:cd99:: with SMTP id y25mr13827347wmj.128.1604921594515;
        Mon, 09 Nov 2020 03:33:14 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:209d:10b7:c480:3e1f])
        by smtp.gmail.com with ESMTPSA id n128sm5063590wmb.46.2020.11.09.03.33.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 03:33:13 -0800 (PST)
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
Subject: [PATCH v1 17/24] kvm: arm64: Add __hyp_pa_symbol helper macro
Date:   Mon,  9 Nov 2020 11:32:26 +0000
Message-Id: <20201109113233.9012-18-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201109113233.9012-1-dbrazdil@google.com>
References: <20201109113233.9012-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add helper macro for computing the PA of a kernel symbol in nVHE hyp
code. This will be useful for computing the PA of a PSCI CPU_ON entry
point.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kvm/hyp/nvhe/psci.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/kvm/hyp/nvhe/psci.c b/arch/arm64/kvm/hyp/nvhe/psci.c
index b0b5df590ba5..7510b9e174e9 100644
--- a/arch/arm64/kvm/hyp/nvhe/psci.c
+++ b/arch/arm64/kvm/hyp/nvhe/psci.c
@@ -20,6 +20,16 @@ s64 hyp_physvirt_offset;
 
 #define __hyp_pa(x) ((phys_addr_t)((x)) + hyp_physvirt_offset)
 
+#define __hyp_pa_symbol(sym)					\
+	({							\
+		extern char sym[];				\
+		unsigned long kern_va;				\
+								\
+		asm volatile("ldr %0, =%1" : "=r" (kern_va)	\
+					   : "S" (sym));	\
+		kern_va - kimage_voffset;			\
+	})
+
 static u64 get_psci_func_id(struct kvm_cpu_context *host_ctxt)
 {
 	return host_ctxt->regs.regs[0];
-- 
2.29.2.222.g5d2a92d10f8-goog

