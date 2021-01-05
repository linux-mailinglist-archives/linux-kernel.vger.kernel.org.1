Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC5F72EB20B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 19:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730705AbhAESGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 13:06:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727971AbhAESGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 13:06:37 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EABC061795
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 10:05:57 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id c133so360933wme.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 10:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X/13wAME+aCvCn5cqIsjPJwjMTVT6zNfbY7h8F95inU=;
        b=wN3JmV9nSFl9HK96BxwqTYn8/5UMJbxbz7CdJ8zLp9QDqHWYIr3oZGc4uAOw8rjKLq
         ETvqki58TnkhhMU0ZfEFIV77MlBPFlzO6+h17IU+14xd8Nsin6C9PEw8brMKfiL0DRb5
         7c0MmBmJFCilyM6rPfjXrkmU/QT25TSvmBKGpQWse1fdHtSTRTkIM8yVIv4cysMFfPBs
         N7woQ89PdailPKQd2ASmnmkRfySg0Vp79bgqYLXO0vzza6WKA4zV8jVJ66sIbeiIknVw
         grv9cfR0BaqYEdtyf/Z5tWlBNvt83zbHFsqtKqM2QMqAywqAU1MTqHg5LhwoynxmvWgW
         lwZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X/13wAME+aCvCn5cqIsjPJwjMTVT6zNfbY7h8F95inU=;
        b=OmbsZMBkUDEIn33gQHENvMIgnF8Notg6VJEEZs2Qt+hU4169p1dZp3DSXVzW+hFzXn
         UBjKwCmYPsSKixvykugubHUlLJTFn4+dfEph9F2dUD/gqRFfh0SlDo4ahlonR3Jc/4bb
         dWvMcop3/Ak7xyAia5RQTbPDX9gW6u85ZnoA49SoWYPLXdL3YobYqM9FjibwxkiK9HxE
         8S6x/mfovuxBoILYwOUFLILHXR9n1c66iEsLK1W5eF7hfkdykBTBhlcW8TUnodKmcpGi
         aOy/nxsLG7LCtp+iVooMXGWiYscGg3bYy3HXPUaRbHWP0r/gv/5tlqsGhmhKMvtdXfP5
         edQg==
X-Gm-Message-State: AOAM530FdZKu7jBKfjXOTeV+hk/SU+8d/rj6RDcSIarAtxWbNy7Vj0HN
        QTMk2Jed/5g8J81ETgEvYbmWEQ==
X-Google-Smtp-Source: ABdhPJz/PuVzjxuGEJSY0xr4tIJRO9R+UGeZ8GgQutDB2H8aMEedZEEpe4b16RKs/VWV9FRUwnJ//A==
X-Received: by 2002:a7b:c849:: with SMTP id c9mr312455wml.11.1609869955809;
        Tue, 05 Jan 2021 10:05:55 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:4957:71a5:7b5c:c94f])
        by smtp.gmail.com with ESMTPSA id j15sm718938wrr.85.2021.01.05.10.05.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jan 2021 10:05:54 -0800 (PST)
From:   David Brazdil <dbrazdil@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Brazdil <dbrazdil@google.com>
Subject: [PATCH v2 1/8] KVM: arm64: Rename .idmap.text in hyp linker script
Date:   Tue,  5 Jan 2021 18:05:34 +0000
Message-Id: <20210105180541.65031-2-dbrazdil@google.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210105180541.65031-1-dbrazdil@google.com>
References: <20210105180541.65031-1-dbrazdil@google.com>
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
2.29.2.729.g45daf8777d-goog

