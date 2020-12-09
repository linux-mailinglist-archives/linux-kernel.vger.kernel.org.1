Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6762D4317
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 14:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732289AbgLINSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 08:18:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731994AbgLINSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 08:18:36 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC72AC061793
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 05:17:55 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id v14so1452051wml.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 05:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ODR//cwk6hwl4QVv9WxKniuODKXuHa0De3QF5nrHIF8=;
        b=D9l4XlNV7e+nqwFqjwgoM8i0tZtjPXnV/1t9K4p0LHGAHrDPuK6Uh4KI0K1Ccf4rYR
         RyzWt8rtG2bUkWDMfweQh4sRU//DySGqA6cTqBEqWrjCga2vPp0k8VLsnHuhaRz8WW0p
         PIh6vQZhhs+WknKoOizMB6X9fo2KSgguJmaznyyhXFHP3tg8lgDhJP4ZEDwdn+hc3nwc
         CJe6Say+NGiW2MOE3ooxvI8ONCt2j+yYmQP9X7HEsWluFyovewhRwyv7SS9kVpnRoZi9
         Xsgl/EBsv8L0ZK5fNxVuQD0bOcT1j24yA9hR6pEk1+ESD99B5RZPMzRIQimFBNqgTeTp
         wicg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ODR//cwk6hwl4QVv9WxKniuODKXuHa0De3QF5nrHIF8=;
        b=JsNjGS0ecm7REPs3WyUAc0oeO9vbSnmFT0G7MQ3Q4onwglAtyEMK+/0P7Ev5jlcdZV
         uYPfxaXsP0asJ0StzTL2V4c+RyYgopcJgNq+/y3wvgrS7taqLX4z0qoJVLb/d0vx/Ze3
         xzz+kXLtczlBQO0KrkiswlC3lQsHLq4BMuHOl1CkhM6AlOVjYiP06tEJYRc7LPfd6N26
         qPLZ3pf0VbAX6AdefvmgoFyWyyJojBSBdBl2N0BzFC8k1ZUzB6lfuxv4ae2kHgI2Pv0V
         dAq9MtR8vZeYHQElTfO0tZ900P6jlABKE9eXrQnmvzjbvcdEnuoMVnZItO4BzC/ts1xv
         ++sw==
X-Gm-Message-State: AOAM5329Dyko7rxAUw0TzKATWnrT+pgM00ODpczDDIy5kzOEZaMTSWRd
        dsPC1CLf96B5FGVLwebSJ1J3wQ==
X-Google-Smtp-Source: ABdhPJxiJo216uaUR1rOvqNVgnsgrbK2oTOt+NyDqS8ioUu6zr1yo3ZpJ7RnHh81iFNCSDXZK4u0DQ==
X-Received: by 2002:a7b:c843:: with SMTP id c3mr2777094wml.100.1607519874381;
        Wed, 09 Dec 2020 05:17:54 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:9d1b:d0eb:db43:6cd2])
        by smtp.gmail.com with ESMTPSA id q25sm3750194wmq.37.2020.12.09.05.17.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Dec 2020 05:17:53 -0800 (PST)
From:   David Brazdil <dbrazdil@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, David Brazdil <dbrazdil@google.com>
Subject: [PATCH 2/9] KVM: arm64: Rename .idmap.text in hyp linker script
Date:   Wed,  9 Dec 2020 13:17:39 +0000
Message-Id: <20201209131746.85622-3-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201209131746.85622-1-dbrazdil@google.com>
References: <20201209131746.85622-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So far hyp-init.S created a .hyp.idmap.text section directly, without
relying on the hyp linker script to prefix its name. Change it to create
.idmap.text and add a HYP_SECTION entry to hyp.lds.S. This way all .hyp*
sections go through the linker script and can be instrumented there.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kvm/hyp/nvhe/hyp-init.S | 2 +-
 arch/arm64/kvm/hyp/nvhe/hyp.lds.S  | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-init.S b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
index 31b060a44045..68fd64f2313e 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-init.S
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
@@ -18,7 +18,7 @@
 #include <asm/virt.h>
 
 	.text
-	.pushsection	.hyp.idmap.text, "ax"
+	.pushsection	.idmap.text, "ax"
 
 	.align	11
 
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp.lds.S b/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
index 1206d0d754d5..70ac48ccede7 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
+++ b/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
@@ -12,6 +12,7 @@
 #include <asm/memory.h>
 
 SECTIONS {
+	HYP_SECTION(.idmap.text)
 	HYP_SECTION(.text)
 	/*
 	 * .hyp..data..percpu needs to be page aligned to maintain the same
-- 
2.29.2.576.ga3fc446d84-goog

