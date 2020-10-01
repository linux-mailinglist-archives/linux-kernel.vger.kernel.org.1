Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B53927FFB9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 15:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732293AbgJANGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 09:06:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33037 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732259AbgJANGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 09:06:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601557561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CqeR3uAKWwgiVR77lBGw+uusUYIh/rVmFkUgiBSbq/E=;
        b=ApU/D7myfXW/UaXyt32CqW6g6rTZQpFGRFTD+6OduYBlb3FvuwMw9dgNnq5JwfzbjxmRgF
        RpHpgCS9U8pdL4frdwhpOjr39sAUu9cX9Qr1GKb4ICr/LWEo8HqIyiP/1VEn1ZDU0Oe/X+
        7Vlv5+QlKhkJpz8BYQJGznWfCCMW3Q8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-4bY9DclHMEqb7ZA8h96vhw-1; Thu, 01 Oct 2020 09:05:57 -0400
X-MC-Unique: 4bY9DclHMEqb7ZA8h96vhw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32CD5AE821;
        Thu,  1 Oct 2020 13:05:56 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.195.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EDE295C1CF;
        Thu,  1 Oct 2020 13:05:53 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Wei Huang <whuang2@amd.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] KVM: x86: bump KVM_MAX_CPUID_ENTRIES
Date:   Thu,  1 Oct 2020 15:05:41 +0200
Message-Id: <20201001130541.1398392-4-vkuznets@redhat.com>
In-Reply-To: <20201001130541.1398392-1-vkuznets@redhat.com>
References: <20201001130541.1398392-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As vcpu->arch.cpuid_entries is now allocated dynamically, the only
remaining use for KVM_MAX_CPUID_ENTRIES is to check KVM_SET_CPUID/
KVM_SET_CPUID2 input for sanity. Since it was reported that the
current limit (80) is insufficient for some CPUs, bump
KVM_MAX_CPUID_ENTRIES and use an arbitrary value '256' as the new
limit.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/include/asm/kvm_host.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 7d259e21ea04..f6d6df64e63a 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -133,7 +133,7 @@ static inline gfn_t gfn_to_index(gfn_t gfn, gfn_t base_gfn, int level)
 #define KVM_NUM_MMU_PAGES (1 << KVM_MMU_HASH_SHIFT)
 #define KVM_MIN_FREE_MMU_PAGES 5
 #define KVM_REFILL_PAGES 25
-#define KVM_MAX_CPUID_ENTRIES 80
+#define KVM_MAX_CPUID_ENTRIES 256
 #define KVM_NR_FIXED_MTRR_REGION 88
 #define KVM_NR_VAR_MTRR 8
 
-- 
2.25.4

