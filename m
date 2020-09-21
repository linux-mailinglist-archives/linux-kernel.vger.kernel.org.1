Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0C87272544
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 15:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbgIUNTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 09:19:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41133 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726353AbgIUNTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 09:19:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600694380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cp4MK36U1jUXwvFeIryJqYh6pqv7rYh+phHr+1tztts=;
        b=QyhyvF5jyU0tu7XajTBgxwy0OWMghjtt5GmpBMLzLAHRZDRAQ2c7Q51oQeH0YsafkgRLLU
        W6Vf7oZWdDWP5UlPWBL9PI//LWrHduC/L/stU1tOywP5hyYNeDZ/RS0a6zyQq8mSPxSKVM
        Ifa33v+a73XWeLPulTS/BX2EjtbWTmA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-wSnF_GshO6-Hf3MS57MiRg-1; Mon, 21 Sep 2020 09:19:36 -0400
X-MC-Unique: wSnF_GshO6-Hf3MS57MiRg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8CD5802B4A;
        Mon, 21 Sep 2020 13:19:34 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.35.206.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1790455765;
        Mon, 21 Sep 2020 13:19:30 +0000 (UTC)
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        Wanpeng Li <wanpengli@tencent.com>,
        Borislav Petkov <bp@alien8.de>,
        Jim Mattson <jmattson@google.com>,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH v5 1/4] KVM: x86: xen_hvm_config: cleanup return values
Date:   Mon, 21 Sep 2020 16:19:20 +0300
Message-Id: <20200921131923.120833-2-mlevitsk@redhat.com>
In-Reply-To: <20200921131923.120833-1-mlevitsk@redhat.com>
References: <20200921131923.120833-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MSR writes should return 1 when giving #GP to the user,
and negative value when fatal error (e.g out of memory)
happened.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/x86.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 17f4995e80a7e..063d70e736f7f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2694,24 +2694,19 @@ static int xen_hvm_config(struct kvm_vcpu *vcpu, u64 data)
 	u32 page_num = data & ~PAGE_MASK;
 	u64 page_addr = data & PAGE_MASK;
 	u8 *page;
-	int r;
 
-	r = -E2BIG;
 	if (page_num >= blob_size)
-		goto out;
-	r = -ENOMEM;
+		return 1;
+
 	page = memdup_user(blob_addr + (page_num * PAGE_SIZE), PAGE_SIZE);
-	if (IS_ERR(page)) {
-		r = PTR_ERR(page);
-		goto out;
+	if (IS_ERR(page))
+		return PTR_ERR(page);
+
+	if (kvm_vcpu_write_guest(vcpu, page_addr, page, PAGE_SIZE)) {
+		kfree(page);
+		return 1;
 	}
-	if (kvm_vcpu_write_guest(vcpu, page_addr, page, PAGE_SIZE))
-		goto out_free;
-	r = 0;
-out_free:
-	kfree(page);
-out:
-	return r;
+	return 0;
 }
 
 static inline bool kvm_pv_async_pf_enabled(struct kvm_vcpu *vcpu)
-- 
2.26.2

