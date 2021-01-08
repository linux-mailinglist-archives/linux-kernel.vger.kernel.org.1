Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 330D32EF23C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 13:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbhAHMQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 07:16:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbhAHMQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 07:16:51 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F2EC0612FF
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 04:15:37 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id l7so8102685qvp.15
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 04:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=unx+w/DYhIKkLLjEFZ0ZjVS7ADRwuEnqRq53UmcJNco=;
        b=siB1XHnnTlEHKkQZGDr8YyjzyGhAZrCxbjSbr5CQNJ9d5DIj1wZzvNJWZGJt3xADr7
         RPbPqVYK7G/VjHQbbDFy9FHLUf8EvAZ37P9j+wpxd0ndJ+tgVdfgIKCOMtA/3mGyqOwg
         m/00VMN9dan8SnkxyGgNCyaQtGwDsNJrwgBtTpJWAvLEnqEYh6rBD8HUvXsNXLHMjD8v
         CrzfgYDC4I+fG7aQ12H1g9qmiXCJAI//rxlzo/WqKUuMkqjSOJ1fiiDhZeIcQFkHbRcQ
         OcOGC7EQ7FnqzdklWauf0h4lPGJW8VoDERKaWoBtCaZRuVy8Tp2QyWRbTfRcnGDltlD0
         OOCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=unx+w/DYhIKkLLjEFZ0ZjVS7ADRwuEnqRq53UmcJNco=;
        b=pgX1VccOoCXMRPkDxWV3roDUNdGzllkjjbz4W7CMBMGadZJZq390Mz0aywyL8AkV4a
         33l5TUYhyg15H6KujsTuZzfezJUZfRTwPVbslwWs9gSNHPd6hEcyOR/cINwS1FzM60+k
         PEReMONEmN3wXtGls/2Yfo/Sa00BL5Ulzv15jLlWy2oIPb29YTdNewtSTyFS4WnoaRFS
         QqiDdisIpNt5U0TJOcZQJklF/WQXo34F5C7gXV3QqNqeDNU8KEZ7cElR11c7AyXb8vSp
         67Rc4W7+2JU/6VkK40LV9ykkVCra1Dds2OUd/dMGpV8spB2YgIem4YNodIrom4fVvOZR
         OK1A==
X-Gm-Message-State: AOAM532bGgxF0Ay8owEIdm0ed4qxhK4b0dUtrgQ1IrE4J/tnqrs1tA+Q
        12EH3urup8ScMmz7ipIKVqpTAKHGP3vX
X-Google-Smtp-Source: ABdhPJzbPjW7FIolFk3swj7ZTloyVho84hOEZCHjuWJg3S9PMHPt+3WGf+xElVymEqN4wYzsD6qCiUsy42cO
Sender: "qperret via sendgmr" <qperret@r2d2-qp.c.googlers.com>
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a05:6214:1230:: with SMTP id
 p16mr3316335qvv.47.1610108137203; Fri, 08 Jan 2021 04:15:37 -0800 (PST)
Date:   Fri,  8 Jan 2021 12:15:03 +0000
In-Reply-To: <20210108121524.656872-1-qperret@google.com>
Message-Id: <20210108121524.656872-6-qperret@google.com>
Mime-Version: 1.0
References: <20210108121524.656872-1-qperret@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [RFC PATCH v2 05/26] KVM: arm64: Avoid free_page() in page-table allocator
From:   Quentin Perret <qperret@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, android-kvm@google.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        Fuad Tabba <tabba@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the KVM page-table allocator uses a mix of put_page() and
free_page() calls depending on the context even though page-allocation
is always achieved using variants of __get_free_page().

Make the code consitent by using put_page() throughout, and reduce the
memory management API surface used by the page-table code. This will
ease factoring out page-alloction from pgtable.c, which is a
pre-requisite to creating page-tables at EL2.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/pgtable.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 0271b4a3b9fe..d7122c5eac24 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -410,7 +410,7 @@ int kvm_pgtable_hyp_init(struct kvm_pgtable *pgt, u32 va_bits)
 static int hyp_free_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
 			   enum kvm_pgtable_walk_flags flag, void * const arg)
 {
-	free_page((unsigned long)kvm_pte_follow(*ptep));
+	put_page(virt_to_page(kvm_pte_follow(*ptep)));
 	return 0;
 }
 
@@ -422,7 +422,7 @@ void kvm_pgtable_hyp_destroy(struct kvm_pgtable *pgt)
 	};
 
 	WARN_ON(kvm_pgtable_walk(pgt, 0, BIT(pgt->ia_bits), &walker));
-	free_page((unsigned long)pgt->pgd);
+	put_page(virt_to_page(pgt->pgd));
 	pgt->pgd = NULL;
 }
 
@@ -551,7 +551,7 @@ static int stage2_map_walk_table_post(u64 addr, u64 end, u32 level,
 	if (!data->anchor)
 		return 0;
 
-	free_page((unsigned long)kvm_pte_follow(*ptep));
+	put_page(virt_to_page(kvm_pte_follow(*ptep)));
 	put_page(virt_to_page(ptep));
 
 	if (data->anchor == ptep) {
@@ -674,7 +674,7 @@ static int stage2_unmap_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
 	}
 
 	if (childp)
-		free_page((unsigned long)childp);
+		put_page(virt_to_page(childp));
 
 	return 0;
 }
@@ -871,7 +871,7 @@ static int stage2_free_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
 	put_page(virt_to_page(ptep));
 
 	if (kvm_pte_table(pte, level))
-		free_page((unsigned long)kvm_pte_follow(pte));
+		put_page(virt_to_page(kvm_pte_follow(pte)));
 
 	return 0;
 }
-- 
2.30.0.284.gd98b1dd5eaa7-goog

