Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8071B7CA7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Apr 2020 19:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbgDXRYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Apr 2020 13:24:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26181 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728807AbgDXRYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 13:24:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587749078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=MucM5opZvyl4Z4L+ZeXePRz2z1atvDYyLaene/+Wtmk=;
        b=dvDCRdHcojYQb/4TzgXBu5NGsT2V4hHc1bcbpkYAL/VFkl1fqqC1Is0kVVJ2qYdnAJOyWt
        jqkqUYCo8q/DmpStMOv2Xo4rAwDIhDT8cWXBv+E3h5DU2cuI4LE3Xx0cUK3YYtjM5n18Bd
        yeTRJ+z55UjaEPyzTKyjIrpjvtV19Fk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-CbvVGUzRPxGYh4gw5OFHQA-1; Fri, 24 Apr 2020 13:24:35 -0400
X-MC-Unique: CbvVGUzRPxGYh4gw5OFHQA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32AFC8BE49C;
        Fri, 24 Apr 2020 17:24:26 +0000 (UTC)
Received: from virtlab511.virt.lab.eng.bos.redhat.com (virtlab511.virt.lab.eng.bos.redhat.com [10.19.152.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4B09C25277;
        Fri, 24 Apr 2020 17:24:25 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     wei.huang2@amd.com, cavery@redhat.com, vkuznets@redhat.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Oliver Upton <oupton@google.com>,
        Jim Mattson <jmattson@google.com>
Subject: [PATCH v2 07/22] KVM: x86: Set KVM_REQ_EVENT if run is canceled with req_immediate_exit set
Date:   Fri, 24 Apr 2020 13:24:01 -0400
Message-Id: <20200424172416.243870-8-pbonzini@redhat.com>
In-Reply-To: <20200424172416.243870-1-pbonzini@redhat.com>
References: <20200424172416.243870-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

Re-request KVM_REQ_EVENT if vcpu_enter_guest() bails after processing
pending requests and an immediate exit was requested.  This fixes a bug
where a pending event, e.g. VMX preemption timer, is delayed and/or lost
if the exit was deferred due to something other than a higher priority
_injected_ event, e.g. due to a pending nested VM-Enter.  This bug only
affects the !injected case as kvm_x86_ops.cancel_injection() sets
KVM_REQ_EVENT to redo the injection, but that's purely serendipitous
behavior with respect to the deferred event.

Note, emulated preemption timer isn't the only event that can be
affected, it simply happens to be the only event where not re-requesting
KVM_REQ_EVENT is blatantly visible to the guest.

Fixes: f4124500c2c13 ("KVM: nVMX: Fully emulate preemption timer")
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Message-Id: <20200423022550.15113-4-sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/x86.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ee934a88a267..8ebfebc807fd 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8489,6 +8489,8 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 	return r;
 
 cancel_injection:
+	if (req_immediate_exit)
+		kvm_make_request(KVM_REQ_EVENT, vcpu);
 	kvm_x86_ops.cancel_injection(vcpu);
 	if (unlikely(vcpu->arch.apic_attention))
 		kvm_lapic_sync_from_vapic(vcpu);
-- 
2.18.2


