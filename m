Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 558BD2E9A52
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 17:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729585AbhADQI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 11:08:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:38974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728620AbhADQBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 11:01:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 71F3422515;
        Mon,  4 Jan 2021 16:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1609776064;
        bh=krZ3AKzCCtzMuA9mGz3d3t2EqXtdL9ffVCFMkS0wWsU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U9aVQZM08Ml94gl6HUURbJRdiWYIkYuDMBmbe0CQg71AIBZoHg3/qWQD/7SNLeWSa
         UVr5dR4bStBWJi8c2Jzw3MFv83RpaAj2Jz2++HZ7z37P74WomHvS34lAbhqoEMGzWL
         yRBf78eLqHa+qxJcYm6luocPYMX8Za9XmxwCYAv4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhiyi Guo <zhguo@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Laszlo Ersek <lersek@redhat.com>
Subject: [PATCH 5.4 13/47] KVM: SVM: relax conditions for allowing MSR_IA32_SPEC_CTRL accesses
Date:   Mon,  4 Jan 2021 16:57:12 +0100
Message-Id: <20210104155706.388304028@linuxfoundation.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210104155705.740576914@linuxfoundation.org>
References: <20210104155705.740576914@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Bonzini <pbonzini@redhat.com>

[ Upstream commit df7e8818926eb4712b67421442acf7d568fe2645 ]

Userspace that does not know about the AMD_IBRS bit might still
allow the guest to protect itself with MSR_IA32_SPEC_CTRL using
the Intel SPEC_CTRL bit.  However, svm.c disallows this and will
cause a #GP in the guest when writing to the MSR.  Fix this by
loosening the test and allowing the Intel CPUID bit, and in fact
allow the AMD_STIBP bit as well since it allows writing to
MSR_IA32_SPEC_CTRL too.

Reported-by: Zhiyi Guo <zhguo@redhat.com>
Analyzed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Analyzed-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/svm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 72bf1d8175ac2..ca746006ac040 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -4233,6 +4233,8 @@ static int svm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		break;
 	case MSR_IA32_SPEC_CTRL:
 		if (!msr_info->host_initiated &&
+		    !guest_cpuid_has(vcpu, X86_FEATURE_SPEC_CTRL) &&
+		    !guest_cpuid_has(vcpu, X86_FEATURE_AMD_STIBP) &&
 		    !guest_cpuid_has(vcpu, X86_FEATURE_AMD_IBRS) &&
 		    !guest_cpuid_has(vcpu, X86_FEATURE_AMD_SSBD))
 			return 1;
@@ -4318,6 +4320,8 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 		break;
 	case MSR_IA32_SPEC_CTRL:
 		if (!msr->host_initiated &&
+		    !guest_cpuid_has(vcpu, X86_FEATURE_SPEC_CTRL) &&
+		    !guest_cpuid_has(vcpu, X86_FEATURE_AMD_STIBP) &&
 		    !guest_cpuid_has(vcpu, X86_FEATURE_AMD_IBRS) &&
 		    !guest_cpuid_has(vcpu, X86_FEATURE_AMD_SSBD))
 			return 1;
-- 
2.27.0



