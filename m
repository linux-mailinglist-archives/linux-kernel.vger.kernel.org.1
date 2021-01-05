Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94CBA2EB644
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 00:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbhAEXcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 18:32:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbhAEXcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 18:32:21 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46567C061793
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 15:31:41 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id f27so1114381qkh.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 15:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=dDiuE/L+TEOVkofWeADZyQOWx+prBVUG+hG/zE7qjqw=;
        b=g0QzlZiBXFKXnhwcB2i5sdfEuv61jQ/gqu5LPmOitwt436dX8/BoHXI5hB7eRkLIfs
         ZZ5pXK56kfNdrrSz2v88EaseQ/vE7rvZMyii/saTD1b555ShCSSLo10RQTfzsBh9nQlg
         kQTUeoodNDdBM5WFHuAMBgseEWiO5eX+tGsE/z19RmgZiQ+SVfANI5sXKtVjBEeiIwi6
         6qUtS25WleI4JxfxUuDEGU1ORzvHKEqDvVPMujBJjYgZI4PwhAbDIkc2/xs9i75rRkGK
         F8ct/L3iru64+Z1/V3DV9HOyVETB9DWAe/Pm/dmikgC6jyVhP3+SHuisGhnsxBT/cQpB
         nCfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=dDiuE/L+TEOVkofWeADZyQOWx+prBVUG+hG/zE7qjqw=;
        b=mPFyszl+5XQW+djm2yrilXjFoUQ21190coi1KPhyFgJ+0QlWpviYcJ6RLJgOw+Xcdw
         0GHpbKrPizQKo7/qtUSkDZ+GwK73KPuKYDXffU64mlmyDoQ5qLLgELhTgfsSq/D3DEv/
         xlFBNMJGGq0MA2C+wiozYZoDuhB9/BCzPaJ9mQ7vehbyTXVVLQW/QrsErtF+rItYwacu
         0lMgw/0fhFUYmUxiI0M1uzE7MWW96p3ilWQsLd+ePkR/MUD3941cSJ/IazPIcHPbKrbB
         /b45tledHFxBm2FE9jRaftS7hEweiFdtc1N2Rj7spD5NW6vgypAlcT8hUdE0GuhPClGp
         uDsw==
X-Gm-Message-State: AOAM531zTEB1GooZxX4GOo3mOIcNLfWuFcP6flYOJvZZkd0I0kZ3Prte
        6TNvkggkEv7rpYAXKDZHphYs3lWKIRg04eyKCU1N6Jbc4XTyb4OuPgZbYqAQmd0OUhbtWsNI9oo
        q74M6VC2/Kxt5bH3bDRPWNYhInbxJ4jZmq8nA+p1rYd153nEuOzJ2pzWE9S7qSvSBzo5/4hfo
X-Google-Smtp-Source: ABdhPJyuqHDKvNJCgAD1VSvNZHytfUGZ2RnhLCOtS6Vfa+72p2t5/2Gh8C8r309kAlPmQART5K58nDKsBsTv
Sender: "bgardon via sendgmr" <bgardon@bgardon.sea.corp.google.com>
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:f693:9fff:fef4:a293])
 (user=bgardon job=sendgmr) by 2002:a0c:f74a:: with SMTP id
 e10mr1887824qvo.47.1609889500231; Tue, 05 Jan 2021 15:31:40 -0800 (PST)
Date:   Tue,  5 Jan 2021 15:31:34 -0800
Message-Id: <20210105233136.2140335-1-bgardon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [PATCH 1/3] kvm: x86/mmu: Clarify TDP MMU page list invariants
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Peter Shier <pshier@google.com>,
        "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>,
        Leo Hou <leohou1402@gmail.com>, Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tdp_mmu_roots and tdp_mmu_pages in struct kvm_arch should only contain
pages with tdp_mmu_page set to true. tdp_mmu_pages should not contain any
pages with a non-zero root_count and tdp_mmu_roots should only contain
pages with a positive root_count, unless a thread holds the MMU lock and
is in the process of modifying the list. Various functions expect these
invariants to be maintained, but they are not explictily documented. Add
to the comments on both fields to document the above invariants.

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/include/asm/kvm_host.h | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 39707e72b062..2389735a29f3 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1010,9 +1010,21 @@ struct kvm_arch {
 	 */
 	bool tdp_mmu_enabled;
 
-	/* List of struct tdp_mmu_pages being used as roots */
+	/*
+	 * List of struct tdp_mmu_pages being used as roots.
+	 * All struct kvm_mmu_pages in the list should have
+	 * tdp_mmu_page set.
+	 * All struct kvm_mmu_pages in the list should have a positive
+	 * root_count except when a thread holds the MMU lock and is removing
+	 * an entry from the list.
+	 */
 	struct list_head tdp_mmu_roots;
-	/* List of struct tdp_mmu_pages not being used as roots */
+
+	/*
+	 * List of struct tdp_mmu_pages not being used as roots.
+	 * All struct kvm_mmu_pages in the list should have
+	 * tdp_mmu_page set and a root_count of 0.
+	 */
 	struct list_head tdp_mmu_pages;
 };
 
-- 
2.29.2.729.g45daf8777d-goog

