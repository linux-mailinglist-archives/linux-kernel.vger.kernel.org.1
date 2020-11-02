Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 382252A32FA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 19:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbgKBS2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 13:28:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49474 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725801AbgKBS2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 13:28:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604341718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=9YpQmMFcKiBaEPkaIebjDurDXYdtTD2oSKBxgB9b1i0=;
        b=gqjUNsFDvAFWMDP9+hMgNmw5sIhhMdgIQ3sSyzH1v61Tq01BZmyOiyOWPPeULQjFnUAT29
        aMpWOsWgOLlbK8Nolw2VKLJuT0hliZjOHW6gZZVEhoLVFJ33TkIvOS6UsdWykCV4Tzm6lE
        Vn/6bn2OKriP7LtBKo6LRK2jgd5lFvw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-usHQBcwBODClpeJiZGFXug-1; Mon, 02 Nov 2020 13:28:36 -0500
X-MC-Unique: usHQBcwBODClpeJiZGFXug-1
Received: by mail-qk1-f197.google.com with SMTP id s5so9190779qkj.21
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 10:28:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9YpQmMFcKiBaEPkaIebjDurDXYdtTD2oSKBxgB9b1i0=;
        b=FC/zgDCbumocFkcyisffoWEzKj9liyL3JC7QXrWei1SjPc5NJGJwB9wuQ0luILXlkB
         h2cme9as8QHPaFCs6LRUSNNFRzmB565w/pFkp10gBI+kbFfeh5Ga8hY62HKlVu8wgZpe
         8CCjPQQcND15nREMdz3IG72Dl2PBgNOPrUM/99tLcWxWXxi0v52ARoYMK+QPsDI0A5ee
         u/vlLCbT6/cLRe7BmlqoMoXs8Eoos6aTrJZDipNEufSWCxA75SM48isSu1IYL16kNKhD
         3VtCAWqWsJ3z4iCEF5wphgqaWcDa6bSdMtGO5Z1kg4MB3nyuJegVBvukuH+RGyZtiUqz
         uieg==
X-Gm-Message-State: AOAM532FmLECHifLoOEmxaXaKJvMu2gDM4/PIHdsyPhldpI6bv+Bvl/h
        xsUeRafWOSqVFJ3dCwp35+8eKXl+/uQuhYyX6EgNe4vSNCJGV0c1OjvXMDXZUqeHZxfn+2xSo+B
        mjwbe0ay6yucSHsD0YtBgqF0R
X-Received: by 2002:a0c:9004:: with SMTP id o4mr23573401qvo.17.1604341715647;
        Mon, 02 Nov 2020 10:28:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx9bRiuM9PVcEQYq1Cr0KOflbD/zGBnxCe9k1OD7WGCmbl7jWVYzc6pAAHo4SsxfUxMRmUNWQ==
X-Received: by 2002:a0c:9004:: with SMTP id o4mr23573371qvo.17.1604341715392;
        Mon, 02 Nov 2020 10:28:35 -0800 (PST)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-20-174-93-89-196.dsl.bell.ca. [174.93.89.196])
        by smtp.gmail.com with ESMTPSA id p13sm8431476qkj.58.2020.11.02.10.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 10:28:34 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2] KVM: selftests: Add get featured msrs test case
Date:   Mon,  2 Nov 2020 13:28:33 -0500
Message-Id: <20201102182833.20382-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Try to fetch any supported featured msr.  Currently it won't fail, so at least
we can check against valid ones (which should be >0).

This reproduces the issue [1] too by trying to fetch one invalid msr there.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=209845

Signed-off-by: Peter Xu <peterx@redhat.com>
--
v2:
- rename kvm_vm_get_feature_msrs to be prefixed with "_" [Vitaly, Drew]
- drop the fix patch since queued with a better version
---
 .../testing/selftests/kvm/include/kvm_util.h  |  3 +
 tools/testing/selftests/kvm/lib/kvm_util.c    | 14 +++++
 .../testing/selftests/kvm/x86_64/state_test.c | 58 +++++++++++++++++++
 3 files changed, 75 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 919e161dd289..1199f2003bee 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -66,6 +66,9 @@ int vm_enable_cap(struct kvm_vm *vm, struct kvm_enable_cap *cap);
 
 struct kvm_vm *vm_create(enum vm_guest_mode mode, uint64_t phy_pages, int perm);
 struct kvm_vm *_vm_create(enum vm_guest_mode mode, uint64_t phy_pages, int perm);
+void kvm_vm_get_msr_feature_index_list(struct kvm_vm *vm,
+				       struct kvm_msr_list *list);
+int _kvm_vm_get_feature_msrs(struct kvm_vm *vm, struct kvm_msrs *msrs);
 void kvm_vm_free(struct kvm_vm *vmp);
 void kvm_vm_restart(struct kvm_vm *vmp, int perm);
 void kvm_vm_release(struct kvm_vm *vmp);
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 74776ee228f2..ad81d51fcf53 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -132,6 +132,20 @@ static const struct vm_guest_mode_params vm_guest_mode_params[] = {
 _Static_assert(sizeof(vm_guest_mode_params)/sizeof(struct vm_guest_mode_params) == NUM_VM_MODES,
 	       "Missing new mode params?");
 
+void kvm_vm_get_msr_feature_index_list(struct kvm_vm *vm,
+				       struct kvm_msr_list *list)
+{
+	int r = ioctl(vm->kvm_fd, KVM_GET_MSR_FEATURE_INDEX_LIST, list);
+
+	TEST_ASSERT(r == 0, "KVM_GET_MSR_FEATURE_INDEX_LIST failed: %d\n",
+		    -errno);
+}
+
+int _kvm_vm_get_feature_msrs(struct kvm_vm *vm, struct kvm_msrs *msrs)
+{
+	return ioctl(vm->kvm_fd, KVM_GET_MSRS, msrs);
+}
+
 /*
  * VM Create
  *
diff --git a/tools/testing/selftests/kvm/x86_64/state_test.c b/tools/testing/selftests/kvm/x86_64/state_test.c
index f6c8b9042f8a..2d61dc5c2dcc 100644
--- a/tools/testing/selftests/kvm/x86_64/state_test.c
+++ b/tools/testing/selftests/kvm/x86_64/state_test.c
@@ -152,6 +152,61 @@ static void __attribute__((__flatten__)) guest_code(void *arg)
 	GUEST_DONE();
 }
 
+#define  KVM_MSR_FEATURE_N  64
+
+static int test_kvm_get_feature_msr_one(struct kvm_vm *vm, __u32 index,
+					struct kvm_msrs *msrs)
+{
+	msrs->nmsrs = 1;
+	msrs->entries[0].index = index;
+	return _kvm_vm_get_feature_msrs(vm, msrs);
+}
+
+static void test_kvm_get_msr_features(struct kvm_vm *vm)
+{
+	struct kvm_msr_list *msr_list;
+	struct kvm_msrs *msrs;
+	int i, ret, sum;
+
+	if (!kvm_check_cap(KVM_CAP_GET_MSR_FEATURES)) {
+		pr_info("skipping kvm get msr features test\n");
+		return;
+	}
+
+	msr_list = calloc(1, sizeof(struct kvm_msr_list) +
+			  sizeof(__u32) * KVM_MSR_FEATURE_N);
+	msr_list->nmsrs = KVM_MSR_FEATURE_N;
+
+	TEST_ASSERT(msr_list, "msr_list allocation failed\n");
+
+	kvm_vm_get_msr_feature_index_list(vm, msr_list);
+
+	msrs = calloc(1, sizeof(struct kvm_msrs) +
+		      sizeof(struct kvm_msr_entry));
+
+	TEST_ASSERT(msrs, "msr entries allocation failed\n");
+
+	sum = 0;
+	for (i = 0; i < msr_list->nmsrs; i++) {
+		ret = test_kvm_get_feature_msr_one(vm, msr_list->indices[i],
+						    msrs);
+		TEST_ASSERT(ret >= 0, "KVM_GET_MSR failed: %d\n", ret);
+		sum += ret;
+	}
+	TEST_ASSERT(sum > 0, "KVM_GET_MSR has no feature msr\n");
+
+	/*
+	 * Test invalid msr.  Note the retcode can be either 0 or 1 depending
+	 * on kvm.ignore_msrs
+	 */
+	ret = test_kvm_get_feature_msr_one(vm, (__u32)-1, msrs);
+	TEST_ASSERT(ret >= 0 && ret <= 1,
+		    "KVM_GET_MSR on invalid msr error: %d\n", ret);
+
+	free(msrs);
+	free(msr_list);
+}
+
 int main(int argc, char *argv[])
 {
 	vm_vaddr_t nested_gva = 0;
@@ -168,6 +223,9 @@ int main(int argc, char *argv[])
 	vcpu_set_cpuid(vm, VCPU_ID, kvm_get_supported_cpuid());
 	run = vcpu_state(vm, VCPU_ID);
 
+	/* Test KVM_GET_MSR for VM */
+	test_kvm_get_msr_features(vm);
+
 	vcpu_regs_get(vm, VCPU_ID, &regs1);
 
 	if (kvm_check_cap(KVM_CAP_NESTED_STATE)) {
-- 
2.26.2

