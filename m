Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 800732E7D62
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 01:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgLaA2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 19:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgLaA2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 19:28:04 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A621C061575
        for <linux-kernel@vger.kernel.org>; Wed, 30 Dec 2020 16:27:24 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id e74so31254154ybh.19
        for <linux-kernel@vger.kernel.org>; Wed, 30 Dec 2020 16:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=nVNkPdtrx1pwYAnHz8fVa4ArTvLcKWdQz2N8fgjsYlM=;
        b=L0O4vl41jxnecCnVk0EWmu28x4N/hKzJ0akivHyV4IV9xyaU7e7EsZR766gERgfDM1
         MSTYIhErSO+ttCt1GCuxqu/6z4j74wEbVhEdtnLcfx+oNTNAvn1Hn7D3r/xAeGLaVOip
         jnQ1gH01F6/lNqJy1Lu0ZnPRD5KcuH2DjHgbJBv8I8n8Mqh9XF3vuHFq6DiN5BwXOWJW
         XRuZCGTJRXIYMbaVwK/ZrDFE7p/EfgbZoVb2mBm44SsI6ZBrP+t0P6+9I8+6zcFKQnH1
         WcS0wxDWQ9KQkeoMwCKl3chaXMM/765TBfof9gSPcxjakaVbrdoeDufOy/n3sVjFKKSp
         o7Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:message-id:mime-version
         :subject:from:to:cc;
        bh=nVNkPdtrx1pwYAnHz8fVa4ArTvLcKWdQz2N8fgjsYlM=;
        b=O1bK873sYj22U6Ok4SjCnzlEwVdEVD757LiuU3DKsl9+WJbbJiySHYTo+4pw3hvSjt
         Mhdpzqet0MMMWNJWofaFRTJ23zuyhKPhLb050Rdtr1wyd60eZsyMblVPhgkcW/GuNugV
         KHxDjXYhhp2cxpEkfktseqCGRDgC51OV/b8qmN9B8oNGVoEpu4ctu6eBJp3GzaIY+nDu
         3WKcRKRyRfWlte0tcZ8ZgBcGllV4U2SEC2Z2PuNkhskwfOVvXi6Cn8VgF3jLuHcs/Cp3
         EgG0OCAUKGVUSMK9VKaICzOlZPqJne7YDv86qmnBG1iGJlGu2AyrVJ3C/qnKuzvMXp2e
         qhTg==
X-Gm-Message-State: AOAM533yedJVjbpF+HFiFjgVIWxvDfoUgjm7uDrC1E7iv0thiefPoiLJ
        wqxxykh/4L0GoQ4UGN1PX4B65gp9Gvw=
X-Google-Smtp-Source: ABdhPJx5QnpnlhcOcBUNeZBAOJ8GALDkMb+HgNFOlORprDIX+e9KbOgwSKgWQbjQzrivQTkLmx/F07Dd2Wk=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
 (user=seanjc job=sendgmr) by 2002:a25:16c5:: with SMTP id 188mr79343598ybw.62.1609374443673;
 Wed, 30 Dec 2020 16:27:23 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 30 Dec 2020 16:26:53 -0800
Message-Id: <20201231002702.2223707-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [PATCH 0/9] x86/virt: KVM: x86: Exception handling fixes/cleanups
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "David P . Reed" <dpreed@deepplum.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Uros Bizjak <ubizjak@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is a conglomeration of three previous series/patches and a bit
of new code.  None of the previous series are directly related, but they
are all needed to achieve the overarching goal of nuking
__kvm_handle_fault_on_reboot(), which is a rather ugly inline asm macro
that has the unfortunate side effect of inserting in-line JMP+CALL
sequences.

Patches 1-3 are resurrected from a series by David Reed[1] to fix VMXOFF
bugs in the reboot flows.

Patch 4 is a patch from Uros Bizjak to get rid of custom inline asm in
nested VMX.  This already received Paolo's "Queued, thanks." blessing,
but has not been pushed to kvm.git.  It's included here as there is an
indirect dependency in patch 8.

Patches 5-6 are minor tweaks to KVM's VMX{ON/OFF} paths to use the
kernel's now-fault-tolerant VMXOFF instead of KVM's custom asm.

Patch 7 replaces SVM's __ex()/__kvm_handle_fault_on_reboot() with more
tailored asm goto macros, similar to the existing VMX asm_vmx*() macros.
This is largely an excuse to get rid of __kvm_handle_fault_on_reboot();
the actual benefits of removing JMP+CALL are likely negligible as SVM only
has a few uses of the macro (versus VMX's bajillion VMREADs/VMWRITEs).

Patch 8 removes __ex()/__kvm_handle_fault_on_reboot().

Patch 9 is a very trimmed down version of a different patch from Uros[3],
which cleaned up the __ex()/__kvm_handle_fault_on_reboot() code, as
opposed to zapping them entirely.

[1] https://lkml.kernel.org/r/20200704203809.76391-1-dpreed@deepplum.com
[2] https://lkml.kernel.org/r/20201029134145.107560-1-ubizjak@gmail.com
[3] https://lkml.kernel.org/r/20201221194800.46962-1-ubizjak@gmail.com

David P. Reed (1):
  x86/virt: Mark flags and memory as clobbered by VMXOFF

Sean Christopherson (6):
  x86/virt: Eat faults on VMXOFF in reboot flows
  x86/reboot: Force all cpus to exit VMX root if VMX is supported
  KVM: VMX: Move Intel PT shenanigans out of VMXON/VMXOFF flows
  KVM: VMX: Use the kernel's version of VMXOFF
  KVM: SVM: Use asm goto to handle unexpected #UD on SVM instructions
  KVM: x86: Kill off __ex() and __kvm_handle_fault_on_reboot()

Uros Bizjak (2):
  KVM/nVMX: Use __vmx_vcpu_run in nested_vmx_check_vmentry_hw
  KVM: x86: Move declaration of kvm_spurious_fault() to x86.h

 arch/x86/include/asm/kvm_host.h | 25 --------------
 arch/x86/include/asm/virtext.h  | 25 ++++++++++----
 arch/x86/kernel/reboot.c        | 30 ++++++-----------
 arch/x86/kvm/svm/sev.c          |  5 ++-
 arch/x86/kvm/svm/svm.c          | 18 +---------
 arch/x86/kvm/svm/svm_ops.h      | 59 +++++++++++++++++++++++++++++++++
 arch/x86/kvm/vmx/nested.c       | 32 ++----------------
 arch/x86/kvm/vmx/vmenter.S      |  2 +-
 arch/x86/kvm/vmx/vmx.c          | 28 ++++++----------
 arch/x86/kvm/vmx/vmx.h          |  1 +
 arch/x86/kvm/vmx/vmx_ops.h      |  4 +--
 arch/x86/kvm/x86.c              |  9 ++++-
 arch/x86/kvm/x86.h              |  2 ++
 13 files changed, 117 insertions(+), 123 deletions(-)
 create mode 100644 arch/x86/kvm/svm/svm_ops.h

-- 
2.29.2.729.g45daf8777d-goog

