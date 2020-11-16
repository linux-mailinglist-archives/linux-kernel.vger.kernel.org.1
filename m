Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D700E2B52FB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387470AbgKPUng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 15:43:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387453AbgKPUnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:43:35 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145C0C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:43:35 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id r17so20305278wrw.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bjd/L/G2RRJSREzHJQoP1g0vINVfsyI8Fcne4wQjdig=;
        b=qwqZWyct9mC77pKffhl9ewXjtbvEoGrUi8si2A11bZr9k90fjqy4CvCiKnuLULg9Xc
         xZsD/v5Iix62RPRCibgZ+tZiv+SAPkZFT0DU1jVhNoCjsPpbzg0xEMZviOo1l2H2yUz8
         I+smY239ch51NxRdHId1zlz51cgAXoskrOxAl+34LkMpkUhax7TjrBGvoGaS7j5SHTuP
         rP+KPKvuViyoxyq+uLMMCi3W/Y9+hT5n3I6Es+ziNVR8puNxmjHXTNM4abQR2ONs8n4Q
         vKE4B6ftz/SWim21pNTXO6NEZmCl9EybGnnBehU1aiXeOinjaFvoX7K4ExASkiniuJ5E
         K2QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bjd/L/G2RRJSREzHJQoP1g0vINVfsyI8Fcne4wQjdig=;
        b=SFbf4AtJ9Q/lzvl3HWVt/jjbyp2LtQI58yokXhESbEl3F6kTR4LLYbbk51rqV39cNk
         jk5Qsie9pdSzAkrrOiZxSNqBC0UX968EGlH1b+w0MfAXYkFQ4WK8OQ1B4g0oCguHM8dw
         BOINhB48aYZhbTi+yyU1OuitVBfBbZ7Wmvyr55KQWUc7EBZStNNivaLRxwuv0le3nvfg
         zaYuRCHr/etvWH5NRs/arTh8mJ1UInLFGjO/WCPf2B5THeWwqp04SFVr2WWiJftoeayU
         z9ZU5O6sjlpyn3PC4Z0pftFfhDwnZLnhOBOosiGCu/6MMQxH8NZ7YMQML3p1of0Xcvz3
         7OIw==
X-Gm-Message-State: AOAM53271tFT4IydHdpOkUr2cvUW24QqLWLW3BLG7kckHQ7OagpQMxop
        HO5CrIV2Hwceim4zVQrE+p2k2g==
X-Google-Smtp-Source: ABdhPJzhp5Qc3VCMl1XdepBsYRbo892rELQDUt+zy3yDaVQOCJPXpDk/FSGa+TxWc6mOuFFKMoZOug==
X-Received: by 2002:adf:f183:: with SMTP id h3mr21954131wro.239.1605559413646;
        Mon, 16 Nov 2020 12:43:33 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:bc40:bd71:373a:1b33])
        by smtp.gmail.com with ESMTPSA id a18sm530393wmm.22.2020.11.16.12.43.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2020 12:43:32 -0800 (PST)
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
Subject: [PATCH v2 05/24] kvm: arm64: Initialize MAIR_EL2 using a constant
Date:   Mon, 16 Nov 2020 20:42:59 +0000
Message-Id: <20201116204318.63987-6-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116204318.63987-1-dbrazdil@google.com>
References: <20201116204318.63987-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MAIR_EL2 is currently initialized to the value of MAIR_EL1, which itself
is set to a constant MAIR_ELx_SET.

Initialize MAIR_EL2 to MAIR_ELx_SET directly in preparation of allowing
KVM to start CPU cores itself and not initializing itself before ERETing
to EL1. In that case, MAIR_EL2 will be initialized before MAIR_EL1.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kvm/hyp/nvhe/hyp-init.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-init.S b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
index b11a9d7db677..17b58dbc3a2f 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-init.S
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
@@ -111,7 +111,7 @@ alternative_else_nop_endif
 
 	msr	tcr_el2, x0
 
-	mrs	x0, mair_el1
+	mov_q	x0, MAIR_ELx_SET
 	msr	mair_el2, x0
 	isb
 
-- 
2.29.2.299.gdc1121823c-goog

