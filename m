Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63E932A6CDD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 19:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732459AbgKDSgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 13:36:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732449AbgKDSgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 13:36:51 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FC5C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 10:36:50 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id b8so23175088wrn.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 10:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DIjGlXFqYL9FyveOV16h0d1a4eeVc3TLm9h73PIyC8E=;
        b=n8+AMW9H/IX3G8lz+cWGN1oavBIb5GbzZnNrEEdw+sYskA9ecY1TNAMYatbRQDl7uy
         nU1UQSUawSlfFozbAg0rTLm5KbnI/FEYx0M9/Kn5+yGcBQ27q37523/Vo/IZipYdWuM5
         tw2FvnITfYxX4SXKqgpbQ4G76gBTOOkXtvxJTq7PtsfksWo89S01idD1OfYzSABuoFpP
         tVNb8gNrqGQGaUnf1bLkfw9v3P4dRzQICWnTURUB+lq5Xkz3zzjpXZlwLEPCy4VLihoo
         HEPi9o45di5YZQ7BQ/ZFrvoqXPnp9eMfV01QMcXfdeK2mVslLC+QAWW2jN6+MIZX9BRl
         qlGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DIjGlXFqYL9FyveOV16h0d1a4eeVc3TLm9h73PIyC8E=;
        b=j9Pq8h8e55r/+d0TnaXyWhgwgM23C+RJN3nhvGhvkiu2+XmbhX2mS/7/wGO39ye6oH
         wUSJJxeqvewtDCuvgV6ft8DX/x5dSTGSW94gr3CARX6mVd/JUU2dWQHN7XFyTek6ZdBY
         b7BmDSIWnHCbjVkA/URVWj5iPFGfI8I+bb9cSzth9STck8gDecparbxkE00LO15IegzM
         0R9ntydkVnzH+RfKlbz1TVzQ8xCVsiIKcFf94iMH0brYHLq9Gv2nXggrpgNH88yVr2WU
         QIcfmwpfthae5VALzyqsKFXSEdseSYchv/7lAGud9FMGv5FxvfBQ7rfgdHQbK2tR4OlI
         rSIQ==
X-Gm-Message-State: AOAM531mCxccwSthQ+Ojttq4PeYGMvnpj+pIxrl1v29PyIrn5rRSi/P7
        fyHpoSP9eEc1R+rrHj9VWBKG8iw1jRPq1Vlf
X-Google-Smtp-Source: ABdhPJwq7DN+2FlZtGXRhvnGQBPP7XUYeccP8u2X/rHVvW5yiq4qao29DK8F1rl8NE0ItwSBLn89Eg==
X-Received: by 2002:a5d:640d:: with SMTP id z13mr32595956wru.28.1604515009243;
        Wed, 04 Nov 2020 10:36:49 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:c8d2:30f2:53c6:bc2])
        by smtp.gmail.com with ESMTPSA id h12sm3718613wrw.70.2020.11.04.10.36.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 10:36:48 -0800 (PST)
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
Subject: [RFC PATCH 05/26] kvm: arm64: Initialize MAIR_EL2 using a constant
Date:   Wed,  4 Nov 2020 18:36:09 +0000
Message-Id: <20201104183630.27513-6-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201104183630.27513-1-dbrazdil@google.com>
References: <20201104183630.27513-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MAIR_EL2 is currently initialized to the value of MAIR_EL1, which itself
is set to a constant MAIR_EL1_SET.

Initialize MAIR_EL2 to the MAIR_EL1_SET constant directly in preparation
of allowing KVM to start CPU cores itself and not initializing itself
before ERETing to EL1. In that case, MAIR_EL2 will be initialized before
MAIR_EL1.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kvm/hyp/nvhe/hyp-init.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-init.S b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
index b11a9d7db677..96e70f976ff5 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-init.S
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
@@ -111,7 +111,7 @@ alternative_else_nop_endif
 
 	msr	tcr_el2, x0
 
-	mrs	x0, mair_el1
+	mov_q	x0, MAIR_EL1_SET
 	msr	mair_el2, x0
 	isb
 
-- 
2.29.1.341.ge80a0c044ae-goog

