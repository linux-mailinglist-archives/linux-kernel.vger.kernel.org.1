Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16674274A57
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 22:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbgIVUt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 16:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgIVUtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 16:49:19 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C139C061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 13:49:19 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id w2so4781860wmi.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 13:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3kHjplFMRxcRQ7QJ8k8iF7bm3FiTydZh5jGCVZmHf+c=;
        b=nT1ODEGNx0aGczQakjhgc8PzyG2vj1szHXyuRNb6ebsGWxr4clvxUsmYNXN/XqNHHD
         5kRQN1xZ/+iHBIVOj22PxJt8FTjR5ZzZDwVA2jFoMAZ7t3DX2ewxPJATn3T3ushgecn8
         K0qK+NZAlqwPRs3XtsO0sl8rVXebdlNh+uQft/DMAqmaxoiLCrO1mT3/vG2cEMGxkY8Y
         3i3kwYoCjCsX/jkbrZ7OP9OBvrgR402Fv/hN2DKE02quuTq9c7z628XiGYC9lBkjawDx
         S7t4FQu4fHewd3qe+5IRnYL7KrtjrMvxrbcLo8elkqKwdz3zkm8skXGUJgRY8QMziN+l
         wYyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3kHjplFMRxcRQ7QJ8k8iF7bm3FiTydZh5jGCVZmHf+c=;
        b=m6SNqnroIaScoPM31cKcyrW8UwojqaeFENXKFdRIL8pKn1Nz1p0lOk6OBS0egKuC0b
         jDZ152z1mqS9mbDvM0dUERApyoxKiII/FkRwPSrt+PM3T7C+F2vE3+DgIoilOaIYe6VN
         Lr4OYMSj7tERWIUHabWRkBJ/J89DFZJ09/hK1UMHxMzZEfp3Kl+ZYVUpbi6vrE52yiU1
         RI/yx5m8hyQ+iBRjuN5YwyHWbCUePMoJL4Gd+ncFwsRJ6hrYd/RNbBipaUAK14FGMtkh
         uiA/Ilz+pYIBnAU/Kew82XBw6P6RJpWznpbgyKlwfplQbtBkgmhGoJ/6klPxq3DTk00Z
         aGKg==
X-Gm-Message-State: AOAM532+6Gy9vm8bxe4+VOa0WZXs7MzsJ10yDaERfLjX4ZyoLwKB1p5r
        +RyRF9aRUB0+EWwycvOyabf+iQ==
X-Google-Smtp-Source: ABdhPJwzq0jqg1SzcNK3sGKx+Fh4ubVp4OV/CRlzx+rQnQQIvi7aVnvBq7whpEsUGD7nfXhj/zUbTQ==
X-Received: by 2002:a1c:f612:: with SMTP id w18mr2791094wmc.47.1600807757941;
        Tue, 22 Sep 2020 13:49:17 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:1105:630f:e990:272f])
        by smtp.gmail.com with ESMTPSA id k8sm6538012wma.16.2020.09.22.13.49.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 13:49:17 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, David Brazdil <dbrazdil@google.com>
Subject: [PATCH v4 03/10] kvm: arm64: Only define __kvm_ex_table for CONFIG_KVM
Date:   Tue, 22 Sep 2020 21:49:03 +0100
Message-Id: <20200922204910.7265-4-dbrazdil@google.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200922204910.7265-1-dbrazdil@google.com>
References: <20200922204910.7265-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minor cleanup that only creates __kvm_ex_table ELF section and
related symbols if CONFIG_KVM is enabled. Also useful as more
hyp-specific sections will be added.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kernel/vmlinux.lds.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index fbb13f38d0c5..d14166012e51 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -22,11 +22,15 @@ ENTRY(_text)
 jiffies = jiffies_64;
 
 
+#ifdef CONFIG_KVM
 #define HYPERVISOR_EXTABLE					\
 	. = ALIGN(SZ_8);					\
 	__start___kvm_ex_table = .;				\
 	*(__kvm_ex_table)					\
 	__stop___kvm_ex_table = .;
+#else /* CONFIG_KVM */
+#define HYPERVISOR_EXTABLE
+#endif
 
 #define HYPERVISOR_TEXT					\
 	/*						\
-- 
2.28.0.681.g6f77f65b4e-goog

