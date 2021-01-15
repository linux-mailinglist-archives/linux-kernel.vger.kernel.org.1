Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24F6E2F8823
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 23:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbhAOWE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 17:04:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbhAOWE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 17:04:57 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F71C061799
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 14:04:06 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id c83so9357394qkg.15
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 14:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=2h5JADF5aibKmlPcIhEIz6Cci5P07JwXVRYCu6RYD34=;
        b=nvLE1t9zvMfH3Xl0Rv9Mqj6PggnwUHlZoedRba/027S3GxjVyLStkyWuTjbWcDQPo9
         asSNihwxRbVSQG7RjNB2AnGIHhMGF1AsPGkf26oIo9qVAt2/6nlL/CXa+brtFY8YeSIg
         7ABAY6FvrxJLXtURLJuoWH5cEoxAMfakMKUql1Oeppexsqg4Mq44i8nJL0fSEwQbjBCV
         o/ByBVR0JfNYT0WH7nWE2AM5VvqlJf6+pIf3mrdskpgU9obgQQcqDeKTwej7YJ42ciC5
         m4UioeT4shrWJ93T3MXI3BG3wAHtoIkMWcvqpKzjbbWUPK5AUAZN6BRd11wJnF+dXy5c
         i8/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=2h5JADF5aibKmlPcIhEIz6Cci5P07JwXVRYCu6RYD34=;
        b=Ciu75orm/mOTVl0voy1wCa9E27ZwraZEfc7VIBFy7kd8EtL/z7h/6buZyBX0y51Qp4
         cX2Q3MD38onE5+1BC+c0iwxf9ps1f40xpLXhpm1SuvU+1cBudb5gmY4DUuEVK90cFhJM
         DYKnn1xpNBwleWrm+za3SJSocD6XxCYazKR3/G0ABY+FzzYKu9aYhtg2V4mkv1FtK6H+
         cQ5ZehESwQfJxj5h9Hs/iwvME1iSPDJzXC+9Qgt69sDYwFJonny47gYMOlZMJ2sCpZWG
         WiNCprShCsAd4ccYg+3yMMfwkxS3SFvefqsdqkb48VS2HR3d9D4x/35HS6cKTiRul03r
         WYnw==
X-Gm-Message-State: AOAM531Mg/FA5PfVZjeR9+rP0ClakgHtYGAXHY/I+cIr0rsXudhJ3osb
        gQ4scqpiaVKpuW26JAez53tCnngG7Qo=
X-Google-Smtp-Source: ABdhPJx0BCCAbCBkZkETT6SrAr9envoXwfD3Zg1e2yzg9Q8/oP8UGerV8n+UTszb/CTE6FQ+5DmEJjbTYW8=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
 (user=seanjc job=sendgmr) by 2002:ad4:5986:: with SMTP id ek6mr14361313qvb.57.1610748245270;
 Fri, 15 Jan 2021 14:04:05 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 15 Jan 2021 14:03:54 -0800
In-Reply-To: <20210115220354.434807-1-seanjc@google.com>
Message-Id: <20210115220354.434807-3-seanjc@google.com>
Mime-Version: 1.0
References: <20210115220354.434807-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH 2/2] KVM: VMX: Use x2apic_mode to avoid RDMSR when querying PI state
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, luferry <luferry@163.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use x2apic_mode instead of x2apic_enabled() when adjusting the
destination ID during Posted Interrupt updates.  This avoids the costly
RDMSR that is hidden behind x2apic_enabled().

Reported-by: luferry <luferry@163.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/posted_intr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/vmx/posted_intr.c b/arch/x86/kvm/vmx/posted_intr.c
index f02962dcc72c..4831bc44ce66 100644
--- a/arch/x86/kvm/vmx/posted_intr.c
+++ b/arch/x86/kvm/vmx/posted_intr.c
@@ -54,7 +54,7 @@ void vmx_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu)
 
 		dest = cpu_physical_id(cpu);
 
-		if (x2apic_enabled())
+		if (x2apic_mode)
 			new.ndst = dest;
 		else
 			new.ndst = (dest << 8) & 0xFF00;
@@ -104,7 +104,7 @@ static void __pi_post_block(struct kvm_vcpu *vcpu)
 
 		dest = cpu_physical_id(vcpu->cpu);
 
-		if (x2apic_enabled())
+		if (x2apic_mode)
 			new.ndst = dest;
 		else
 			new.ndst = (dest << 8) & 0xFF00;
@@ -174,7 +174,7 @@ int pi_pre_block(struct kvm_vcpu *vcpu)
 		 */
 		dest = cpu_physical_id(vcpu->pre_pcpu);
 
-		if (x2apic_enabled())
+		if (x2apic_mode)
 			new.ndst = dest;
 		else
 			new.ndst = (dest << 8) & 0xFF00;
-- 
2.30.0.284.gd98b1dd5eaa7-goog

