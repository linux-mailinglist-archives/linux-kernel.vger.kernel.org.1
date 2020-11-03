Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA6742A5AB9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 00:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729932AbgKCXuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 18:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729888AbgKCXuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 18:50:02 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91686C061A48
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 15:50:02 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id 33so12387352pgt.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 15:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=4JPm7cCk/VJhuMXczUOk2KTP1ZH/THD6iHmmgO0eSiQ=;
        b=RfMvmms2e0z/cLkRY39sQHAqwDuUkgV+W8G4cwqO6JdpEmxcb+NoSrXChCJJc1V7AS
         1i1mwpCzKuLFUQC5DLv+9YhArFgzXUPkvf1nOmsSOwxdBIMHD3iPatOdCiVF+AuxqmmR
         YovNp7sk8En6HR0b54SfFNKNEe04ztGQy3CC4C3IYtCZKI3LHDvROvSxFV0BD08YlE8Q
         /3zp8mVRyFmOpjwUTiq3dTlq2VFT1OIgK5Tfz742RLV99Z50lzXGR0Z8YdVBJ7Kkn1eQ
         P8P0IYBVod3xxbAY/KzX8kREGerXC3dW7o3RzVEncFdTpW5Y2d9ROqOps+segLACFtZ7
         GHwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4JPm7cCk/VJhuMXczUOk2KTP1ZH/THD6iHmmgO0eSiQ=;
        b=jO280qXiDCPHBpR2p8Rl/AOf12yPu+MONrcOT+YnPg0SlRv/5ugOfzpvlvRBlBfqA1
         xWYK9vMk1FQ4Jb+gVtBsKcScfSnYd5p4I1LDXJO3QelE7rdrw9mwzS3Cqs9wReVA50c5
         mW+Y+2EUvdDGV221cvLG4VPcVKw+jFjnHxyf9HqS1PTJ3eq77iufFUVrjLoctj0G5ArM
         CfXtIzg2FiuG6TlCPsM/+Lt/ufdQtA1QF/MRCAqmnWfsn7r8gv2qa42IGmklIEi9Vu4C
         AW/ewpLPiXtoTCzOOgg8fntlWW59A9RF8cxXeYTbOCGrfj+i58Ew+97hXuwXJoHIcYiF
         K4MQ==
X-Gm-Message-State: AOAM533kEX0HjRbL0QAZi87XssiJ/rJQDnhXjLeToUXz+h+y+iWcawsc
        mBf3mFZ/S6wJIyMO2YOjHNvN7fSRoO+RQWzmwg3rdwzpSOGJ9yh09Ucz84OsY3KDQthdOkMGSXg
        bmX87ljNATloGw2nt4YXKv9qJf5TAYvz6sqHoZVa0m2Pc0T/b99G6pdF5u8gISK01BEPzJi6g
X-Google-Smtp-Source: ABdhPJwdOKprX2XTwP7S3Q3Cly6l8+cGkgJqp8xEAdoLvPS3P5gW6Lozsk8mdejFz1vOqkwHLmCBdSBTAr6e
Sender: "bgardon via sendgmr" <bgardon@bgardon.sea.corp.google.com>
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:f693:9fff:fef4:a293])
 (user=bgardon job=sendgmr) by 2002:aa7:8755:0:b029:163:f620:5be7 with SMTP id
 g21-20020aa787550000b0290163f6205be7mr28088640pfo.15.1604447401900; Tue, 03
 Nov 2020 15:50:01 -0800 (PST)
Date:   Tue,  3 Nov 2020 15:49:51 -0800
In-Reply-To: <20201103234952.1626730-1-bgardon@google.com>
Message-Id: <20201103234952.1626730-5-bgardon@google.com>
Mime-Version: 1.0
References: <20201103234952.1626730-1-bgardon@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v2 4/5] KVM: selftests: Add wrfract to common guest code
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Peter Shier <pshier@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Huth <thuth@redhat.com>,
        Peter Feiner <pfeiner@google.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wrfract will be used by the dirty logging perf test introduced later in
this series to dirty memory sparsely.

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 tools/testing/selftests/kvm/demand_paging_test.c     | 2 ++
 tools/testing/selftests/kvm/include/perf_test_util.h | 1 +
 tools/testing/selftests/kvm/lib/perf_test_util.c     | 5 ++++-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
index 63ea7c06e1141..72b8890c0dc3b 100644
--- a/tools/testing/selftests/kvm/demand_paging_test.c
+++ b/tools/testing/selftests/kvm/demand_paging_test.c
@@ -264,6 +264,8 @@ static void run_test(enum vm_guest_mode mode, bool use_uffd,
 	int vcpu_id;
 	int r;
 
+	perf_test_args.wr_fract = 1;
+
 	vm = create_vm(mode, vcpus, vcpu_memory_bytes);
 
 	guest_data_prototype = malloc(perf_test_args.host_page_size);
diff --git a/tools/testing/selftests/kvm/include/perf_test_util.h b/tools/testing/selftests/kvm/include/perf_test_util.h
index 4d52b9ee13c42..645b942ae0229 100644
--- a/tools/testing/selftests/kvm/include/perf_test_util.h
+++ b/tools/testing/selftests/kvm/include/perf_test_util.h
@@ -36,6 +36,7 @@ struct perf_test_args {
 	struct kvm_vm *vm;
 	uint64_t host_page_size;
 	uint64_t guest_page_size;
+	int wr_fract;
 
 	struct vcpu_args vcpu_args[MAX_VCPUS];
 };
diff --git a/tools/testing/selftests/kvm/lib/perf_test_util.c b/tools/testing/selftests/kvm/lib/perf_test_util.c
index fa7efbac9ef8a..1abb6b1321c3c 100644
--- a/tools/testing/selftests/kvm/lib/perf_test_util.c
+++ b/tools/testing/selftests/kvm/lib/perf_test_util.c
@@ -44,7 +44,10 @@ void guest_code(uint32_t vcpu_id)
 	for (i = 0; i < pages; i++) {
 		uint64_t addr = gva + (i * perf_test_args.guest_page_size);
 
-		*(uint64_t *)addr = 0x0123456789ABCDEF;
+		if (i % perf_test_args.wr_fract == 0)
+			*(uint64_t *)addr = 0x0123456789ABCDEF;
+		else
+			READ_ONCE(*(uint64_t *)addr);
 	}
 
 	GUEST_SYNC(1);
-- 
2.29.1.341.ge80a0c044ae-goog

