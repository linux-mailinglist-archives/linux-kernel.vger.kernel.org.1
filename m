Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1379727F74C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 03:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731591AbgJABXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 21:23:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32651 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731148AbgJABWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 21:22:36 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601515354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zoLLv00Q8ql8znDExtdkYmCYWKsHTnv0c90Ims5Wjt4=;
        b=QmvD13tFuwwoGP9sr8T2L2cArSFYPTt/PVk2uyJHsS5sXhzGraDD4j+u9Rspff/+psCtEn
        xv280TVjP0TXnJpdJ1rb21lG5Bzg0mvsAFA3s7XsvMi6XocKUWdE29C8zwLwLLDwoDsL9O
        qI1hGgRVBynfo2GXWuMdiY94rO6usUE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-5X4MEuvDOHeEaV5e3pBoIA-1; Wed, 30 Sep 2020 21:22:30 -0400
X-MC-Unique: 5X4MEuvDOHeEaV5e3pBoIA-1
Received: by mail-qt1-f197.google.com with SMTP id b18so2544333qto.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 18:22:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zoLLv00Q8ql8znDExtdkYmCYWKsHTnv0c90Ims5Wjt4=;
        b=In+qLr2niXngd8cxCj8z/t6E7Y7Zb9qSk0w2dMSw/yvD+lcIPQ7DK+8fkFi5nbA5/q
         j2vCm3DYC8PCFKylPOTrlG1tkF2+VVIXYiH75Do2SZkmjoJgEy8hUxfBU9AUT7j5DP8Q
         Wqq9JvU8XYWkEjH/65kBBCxX0SQvPGw/49UaA+DxicPg8lsF9YhA2s1S7H95bFu2h3ss
         jfB1nk0Fqju0lMErvzoLyBa9Tw437AO0Nt6yWWlHn0F27pFRI9EExL6NcqmBBMhRWU6A
         XNkmCq5cjpb9Nh7qI07pUKubWMl3L2ryWqsA9D3DVKTb4A6UKk/6EGACynC2uYtrAEk+
         RTNg==
X-Gm-Message-State: AOAM5300j164eC/Imi1rvEb45QpAPoxAnukwkD1IRavXB+txhft98QXK
        zId+wLKUS07l6fmqL9WVSx7Riz95D5YZg72gsVwHbwkjzp+nXMl68lZCym/VSo5hWL1mN7bKYIE
        WKoduac3BDY495fxSRRKWFfuZ
X-Received: by 2002:ae9:e914:: with SMTP id x20mr5349901qkf.163.1601515350373;
        Wed, 30 Sep 2020 18:22:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwfYXhNI3eGwvBQzRTuVyuUA3z1f7q1pz6g2tsiaklFvj41RvejJoDQMRwClqaJ/0N+f5i6kA==
X-Received: by 2002:ae9:e914:: with SMTP id x20mr5349879qkf.163.1601515350128;
        Wed, 30 Sep 2020 18:22:30 -0700 (PDT)
Received: from localhost.localdomain (toroon474qw-lp130-09-184-147-14-204.dsl.bell.ca. [184.147.14.204])
        by smtp.gmail.com with ESMTPSA id q3sm4015955qkq.132.2020.09.30.18.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 18:22:29 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com,
        Andrew Jones <drjones@redhat.com>
Subject: [PATCH v13 09/14] KVM: selftests: Sync uapi/linux/kvm.h to tools/
Date:   Wed, 30 Sep 2020 21:22:31 -0400
Message-Id: <20201001012231.5964-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201001012044.5151-1-peterx@redhat.com>
References: <20201001012044.5151-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will be needed to extend the kvm selftest program.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/include/uapi/linux/kvm.h | 77 +++++++++++++++++++++++++++++++++-
 1 file changed, 75 insertions(+), 2 deletions(-)

diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index f6d86033c4fa..b3b0f94c6aa6 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -248,6 +248,9 @@ struct kvm_hyperv_exit {
 #define KVM_EXIT_IOAPIC_EOI       26
 #define KVM_EXIT_HYPERV           27
 #define KVM_EXIT_ARM_NISV         28
+#define KVM_EXIT_X86_RDMSR        29
+#define KVM_EXIT_X86_WRMSR        30
+#define KVM_EXIT_DIRTY_RING_FULL  31
 
 /* For KVM_EXIT_INTERNAL_ERROR */
 /* Emulate instruction failed. */
@@ -413,6 +416,17 @@ struct kvm_run {
 			__u64 esr_iss;
 			__u64 fault_ipa;
 		} arm_nisv;
+		/* KVM_EXIT_X86_RDMSR / KVM_EXIT_X86_WRMSR */
+		struct {
+			__u8 error; /* user -> kernel */
+			__u8 pad[7];
+#define KVM_MSR_EXIT_REASON_INVAL	(1 << 0)
+#define KVM_MSR_EXIT_REASON_UNKNOWN	(1 << 1)
+#define KVM_MSR_EXIT_REASON_FILTER	(1 << 2)
+			__u32 reason; /* kernel -> user */
+			__u32 index; /* kernel -> user */
+			__u64 data; /* kernel <-> user */
+		} msr;
 		/* Fix the size of the union. */
 		char padding[256];
 	};
@@ -790,9 +804,10 @@ struct kvm_ppc_resize_hpt {
 #define KVM_VM_PPC_HV 1
 #define KVM_VM_PPC_PR 2
 
-/* on MIPS, 0 forces trap & emulate, 1 forces VZ ASE */
-#define KVM_VM_MIPS_TE		0
+/* on MIPS, 0 indicates auto, 1 forces VZ ASE, 2 forces trap & emulate */
+#define KVM_VM_MIPS_AUTO	0
 #define KVM_VM_MIPS_VZ		1
+#define KVM_VM_MIPS_TE		2
 
 #define KVM_S390_SIE_PAGE_OFFSET 1
 
@@ -1035,6 +1050,10 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_LAST_CPU 184
 #define KVM_CAP_SMALLER_MAXPHYADDR 185
 #define KVM_CAP_S390_DIAG318 186
+#define KVM_CAP_STEAL_TIME 187
+#define KVM_CAP_X86_USER_SPACE_MSR 188
+#define KVM_CAP_X86_MSR_FILTER 189
+#define KVM_CAP_DIRTY_LOG_RING 190
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1536,6 +1555,12 @@ struct kvm_pv_cmd {
 /* Available with KVM_CAP_S390_PROTECTED */
 #define KVM_S390_PV_COMMAND		_IOWR(KVMIO, 0xc5, struct kvm_pv_cmd)
 
+/* Available with KVM_CAP_X86_MSR_FILTER */
+#define KVM_X86_SET_MSR_FILTER	_IOW(KVMIO,  0xc6, struct kvm_msr_filter)
+
+/* Available with KVM_CAP_DIRTY_LOG_RING */
+#define KVM_RESET_DIRTY_RINGS		_IO(KVMIO, 0xc7)
+
 /* Secure Encrypted Virtualization command */
 enum sev_cmd_id {
 	/* Guest initialization commands */
@@ -1689,4 +1714,52 @@ struct kvm_hyperv_eventfd {
 #define KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE    (1 << 0)
 #define KVM_DIRTY_LOG_INITIALLY_SET            (1 << 1)
 
+/*
+ * Arch needs to define the macro after implementing the dirty ring
+ * feature.  KVM_DIRTY_LOG_PAGE_OFFSET should be defined as the
+ * starting page offset of the dirty ring structures.
+ */
+#ifndef KVM_DIRTY_LOG_PAGE_OFFSET
+#define KVM_DIRTY_LOG_PAGE_OFFSET 0
+#endif
+
+/*
+ * KVM dirty GFN flags, defined as:
+ *
+ * |---------------+---------------+--------------|
+ * | bit 1 (reset) | bit 0 (dirty) | Status       |
+ * |---------------+---------------+--------------|
+ * |             0 |             0 | Invalid GFN  |
+ * |             0 |             1 | Dirty GFN    |
+ * |             1 |             X | GFN to reset |
+ * |---------------+---------------+--------------|
+ *
+ * Lifecycle of a dirty GFN goes like:
+ *
+ *      dirtied         collected        reset
+ * 00 -----------> 01 -------------> 1X -------+
+ *  ^                                          |
+ *  |                                          |
+ *  +------------------------------------------+
+ *
+ * The userspace program is only responsible for the 01->1X state
+ * conversion (to collect dirty bits).  Also, it must not skip any
+ * dirty bits so that dirty bits are always collected in sequence.
+ */
+#define KVM_DIRTY_GFN_F_DIRTY           BIT(0)
+#define KVM_DIRTY_GFN_F_RESET           BIT(1)
+#define KVM_DIRTY_GFN_F_MASK            0x3
+
+/*
+ * KVM dirty rings should be mapped at KVM_DIRTY_LOG_PAGE_OFFSET of
+ * per-vcpu mmaped regions as an array of struct kvm_dirty_gfn.  The
+ * size of the gfn buffer is decided by the first argument when
+ * enabling KVM_CAP_DIRTY_LOG_RING.
+ */
+struct kvm_dirty_gfn {
+	__u32 flags;
+	__u32 slot;
+	__u64 offset;
+};
+
 #endif /* __LINUX_KVM_H */
-- 
2.26.2

