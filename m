Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E02582D2D23
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 15:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729865AbgLHOZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 09:25:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728786AbgLHOZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 09:25:47 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991D8C061794
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 06:25:06 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id t4so16385567wrr.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 06:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EaxldaDhN9JlM3hE+IVwd+bTy8bVzmLP3BfUJc4jBBQ=;
        b=gULKGUKDNs5K8nvvXyITt50X6Uz79vM8+89FVjcAK6zuOHuIsYhOe00OqWQpm5TSDx
         nO/IrbyzFdepEFETzFAk43WiZWmcNzfBkWmyFGZ7/CE3M3a8c8UgRUqJ1T7bxmgmEXTi
         ah1qwtxT+O8hgLZgyXup0DutJii6RxEe0micQGZqCFpncp18p3Nr1G4O378zaFhdYGmH
         2rFzRZAG6RGGAifB5Ab+jkuNsBpkSU2V+GlcJZ5dEqcjjFYsMKVcpca30QjNdRH0HawY
         NNE+iIMrSbbHfJ6G/Tl1kfUA7TX/Mml25q29hbTuoaFYkbORxsivaK/tU69ho0TbxZvv
         iRSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EaxldaDhN9JlM3hE+IVwd+bTy8bVzmLP3BfUJc4jBBQ=;
        b=UNNT2tW2t8Iq5549v079Nfo6NhjlAeJgQxB0nnLcRAh6gI3mjTQjQUkQpuT9xOVfSa
         NaIpXzgpxdRAqd+TBVBwzuAI3Hi44tsORD89v3kb91FCRI0O9efn3FVvVCphn2ySAy65
         VTv6KPj5tHo8xzgeDFNhp/fz1TcSuh2DeyDx0eEDPtp5Eal+53vc7XqvO0GzRhPJa2H8
         t0ugfyt8lYWet1WZe3p+clhv2mxdtyPUrfr2+4V698pQKJFpY3fELy64nI1x69VPOB8n
         tUj5AdMLVfpVJ4nk+5rVtpIXARH5hQRsQq7YGp/BT5ene1brk4c6iN4g/RZ/LJTcPK3n
         948w==
X-Gm-Message-State: AOAM531/DsR0YBIh+3URLlgVDIPBAG58KsVf2fSN+2fJ1/cmCjhrYVje
        qURPVYSPn2yVtpwhAofmG/kVew==
X-Google-Smtp-Source: ABdhPJzYqcZS7aoqzu4qYNksPaO6tUAeFeTHSKRNPw1/fsSQ1g1CJLkKZZZyFEt/fPl04D3ibmVhAw==
X-Received: by 2002:adf:f98b:: with SMTP id f11mr26057502wrr.235.1607437505274;
        Tue, 08 Dec 2020 06:25:05 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:258e:cb26:cef:a620])
        by smtp.gmail.com with ESMTPSA id d9sm20747214wrs.26.2020.12.08.06.25.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Dec 2020 06:25:04 -0800 (PST)
From:   David Brazdil <dbrazdil@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, David Brazdil <dbrazdil@google.com>
Subject: [PATCH 3/6] kvm: arm64: Skip computing hyp VA layout for VHE
Date:   Tue,  8 Dec 2020 14:24:49 +0000
Message-Id: <20201208142452.87237-4-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201208142452.87237-1-dbrazdil@google.com>
References: <20201208142452.87237-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Computing the hyp VA layout is redundant when the kernel runs in EL2 and
hyp shares its VA mappings. Make calling kvm_compute_layout()
conditional on not just CONFIG_KVM but also !is_kernel_in_hyp_mode().

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 18e9727d3f64..4e585cc892e8 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -434,7 +434,7 @@ static void __init hyp_mode_check(void)
 			   "CPU: CPUs started in inconsistent modes");
 	else
 		pr_info("CPU: All CPU(s) started at EL1\n");
-	if (IS_ENABLED(CONFIG_KVM))
+	if (IS_ENABLED(CONFIG_KVM) && !is_kernel_in_hyp_mode())
 		kvm_compute_layout();
 }
 
-- 
2.29.2.576.ga3fc446d84-goog

