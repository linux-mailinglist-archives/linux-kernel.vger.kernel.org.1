Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB7821A28F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 16:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgGIOyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 10:54:09 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55232 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726475AbgGIOyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 10:54:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594306447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=h49iUghddx6q/28Q3GpO3NfUnwfKQascXywErp2c0+8=;
        b=dgbeH73gAd1T9wAGptB5rKeU3K6M3CytHccI1PACMX9SH9tvn+obROtUp/Z5GV5W5mQH2c
        d68AnLno8tkhD4OWL/yimLXvLIJOIjk+eXdcgVTSmuUazcvIRymACPhhJyeMTOhPB5Ky/r
        1XqgXrHrtnswlvrBO/EUtJbtmwFZG9I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-92-lKFlz2d7PPKoAmMNMXLf5w-1; Thu, 09 Jul 2020 10:54:06 -0400
X-MC-Unique: lKFlz2d7PPKoAmMNMXLf5w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8EC18005B0;
        Thu,  9 Jul 2020 14:54:04 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.195.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 01C1E6106A;
        Thu,  9 Jul 2020 14:53:59 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Junaid Shahid <junaids@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/9] KVM: nSVM: fixes for CR3/MMU switch upon nested guest entry/exit
Date:   Thu,  9 Jul 2020 16:53:49 +0200
Message-Id: <20200709145358.1560330-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a successor of "[PATCH v2 0/3] KVM: nSVM: fix #TF from CR3 switch
when entering guest" and "[PATCH] KVM: x86: drop erroneous mmu_check_root()
from fast_pgd_switch()".

The snowball is growing fast! It all started with an intention to fix
the particular 'tripple fault' issue (now fixed by PATCH7) but now we
also get rid of unconditional kvm_mmu_reset_context() upon nested guest
entry/exit and make the code resemble nVMX. There is still a huge room
for further improvement (proper error propagation, removing unconditional
MMU sync/TLB flush,...) but at least we're making some progress.

Tested with kvm selftests/kvm-unit-tests and by running nested Hyper-V
on KVM. The series doesn't seem to introduce any new issues.

Vitaly Kuznetsov (9):
  KVM: nSVM: split kvm_init_shadow_npt_mmu() from kvm_init_shadow_mmu()
  KVM: nSVM: stop dereferencing vcpu->arch.mmu to get the context in
    kvm_init_shadow{,_npt}_mmu()
  KVM: nSVM: reset nested_run_pending upon nested_svm_vmrun_msrpm()
    failure
  KVM: nSVM: prepare to handle errors from enter_svm_guest_mode()
  KVM: nSVM: introduce nested_svm_load_cr3()
  KVM: nSVM: move kvm_set_cr3() after nested_svm_uninit_mmu_context()
  KVM: nSVM: implement nested_svm_load_cr3() and use it for host->guest
    switch
  KVM: nSVM: use nested_svm_load_cr3() on guest->host switch
  KVM: x86: drop superfluous mmu_check_root() from fast_pgd_switch()

 arch/x86/kvm/mmu.h        |   3 +-
 arch/x86/kvm/mmu/mmu.c    |  39 ++++++++++----
 arch/x86/kvm/svm/nested.c | 108 ++++++++++++++++++++++++++++----------
 arch/x86/kvm/svm/svm.c    |   6 ++-
 arch/x86/kvm/svm/svm.h    |   4 +-
 5 files changed, 116 insertions(+), 44 deletions(-)

-- 
2.25.4

