Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75EC427F483
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 23:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731297AbgI3VzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 17:55:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51115 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731204AbgI3Vy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 17:54:57 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601502895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nwkOICvOQaXOWcko8kpLlTGev7mN/mGmU8J6lWaTsxY=;
        b=c5DWjVkJYh/+s8h083jU3Set55xk5h8OCMLiVsdntj2Tw0oo1iAk0XGePFj7tRj2BePalJ
        Ga3m4zFYRezxeOHPQusnvCEBiepmBVI/hLKEbs5074Ye/9cwRf0zP79Na+chHHHxOqOlUo
        PmZKzmlTTYuIW3+PrzxbNZbYyn1KZLQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-FTfY9ZpnNRyUcmJ8yRQPuw-1; Wed, 30 Sep 2020 17:54:53 -0400
X-MC-Unique: FTfY9ZpnNRyUcmJ8yRQPuw-1
Received: by mail-qk1-f197.google.com with SMTP id a2so1814791qkg.19
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 14:54:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nwkOICvOQaXOWcko8kpLlTGev7mN/mGmU8J6lWaTsxY=;
        b=p9L7vCvDbk/ozTLagMrQlacD/aAYjrD11nIoqJ78GNczailqrTb3omJCFoWysoTmlT
         Bd6bIJqgsIx8iAWTcWUCOCqUwoyzCp7ubBXUWERcxvoT1PMqZKab4uQHTUgbFDQbsHlc
         cZMKDHUtw3ZqGx7oq9xWjcPzpJp0fxzQAlybIk2wyGAfSxqjb+9+XAx6pZShcqJyl+/B
         YKag8hDt94fbo8UycP+UXn/YaVR07dIE2huUI4sFDXwuA+yryoFSgOR22gUQItnJccjP
         KcU+1ZLN1xQrRh6tTmqVT9BTEqla4/r0VnmHGx/YAKMnv68prmtFHOpAUP8r8Q0AQwdz
         UuHg==
X-Gm-Message-State: AOAM530UcNDt65aFcwN6yMNQzQDQ47LemtcP/nElWaZfb7MVWTopaAJK
        +L9ylhPt9+u+qg1wGqhItGERoiDOCzrcYqqoAEqX98vFE4iJeHtwU4Ba47qwYn2aOiV9i3zXEUD
        9vvgGOep+NBoqAJWZ/TVWvgOR
X-Received: by 2002:a05:6214:1873:: with SMTP id eh19mr4582597qvb.16.1601502893274;
        Wed, 30 Sep 2020 14:54:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJybLwVY6jEpq4x2HA+sDFN0U69X2dz5Fiuq3Ua/MNBMapwHzf9NElvAEdB+0tfsaWQi1xfS1Q==
X-Received: by 2002:a05:6214:1873:: with SMTP id eh19mr4582577qvb.16.1601502893059;
        Wed, 30 Sep 2020 14:54:53 -0700 (PDT)
Received: from xz-x1.redhat.com (toroon474qw-lp130-09-184-147-14-204.dsl.bell.ca. [184.147.14.204])
        by smtp.gmail.com with ESMTPSA id a11sm3903690qto.2.2020.09.30.14.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 14:54:52 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andrew Jones <drjones@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com
Subject: [PATCH v12 13/13] KVM: selftests: Add "-c" parameter to dirty log test
Date:   Wed, 30 Sep 2020 17:54:51 -0400
Message-Id: <20200930215451.48391-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200930214948.47225-1-peterx@redhat.com>
References: <20200930214948.47225-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's only used to override the existing dirty ring size/count.  If
with a bigger ring count, we test async of dirty ring.  If with a
smaller ring count, we test ring full code path.  Async is default.

It has no use for non-dirty-ring tests.

Reviewed-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/kvm/dirty_log_test.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index 4b404dfdc2f9..80c42c87265e 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -168,6 +168,7 @@ static enum log_mode_t host_log_mode_option = LOG_MODE_ALL;
 /* Logging mode for current run */
 static enum log_mode_t host_log_mode;
 static pthread_t vcpu_thread;
+static uint32_t test_dirty_ring_count = TEST_DIRTY_RING_COUNT;
 
 /* Only way to pass this to the signal handler */
 static struct kvm_vm *current_vm;
@@ -250,7 +251,7 @@ static void dirty_ring_create_vm_done(struct kvm_vm *vm)
 	 * Switch to dirty ring mode after VM creation but before any
 	 * of the vcpu creation.
 	 */
-	vm_enable_dirty_ring(vm, TEST_DIRTY_RING_COUNT *
+	vm_enable_dirty_ring(vm, test_dirty_ring_count *
 			     sizeof(struct kvm_dirty_gfn));
 }
 
@@ -272,7 +273,7 @@ static uint32_t dirty_ring_collect_one(struct kvm_dirty_gfn *dirty_gfns,
 	uint32_t count = 0;
 
 	while (true) {
-		cur = &dirty_gfns[*fetch_index % TEST_DIRTY_RING_COUNT];
+		cur = &dirty_gfns[*fetch_index % test_dirty_ring_count];
 		if (!dirty_gfn_is_dirtied(cur))
 			break;
 		TEST_ASSERT(cur->slot == slot, "Slot number didn't match: "
@@ -778,6 +779,9 @@ static void help(char *name)
 	printf("usage: %s [-h] [-i iterations] [-I interval] "
 	       "[-p offset] [-m mode]\n", name);
 	puts("");
+	printf(" -c: specify dirty ring size, in number of entries\n");
+	printf("     (only useful for dirty-ring test; default: %"PRIu32")\n",
+	       TEST_DIRTY_RING_COUNT);
 	printf(" -i: specify iteration counts (default: %"PRIu64")\n",
 	       TEST_HOST_LOOP_N);
 	printf(" -I: specify interval in ms (default: %"PRIu64" ms)\n",
@@ -833,8 +837,11 @@ int main(int argc, char *argv[])
 	guest_mode_init(VM_MODE_P40V48_4K, true, true);
 #endif
 
-	while ((opt = getopt(argc, argv, "hi:I:p:m:M:")) != -1) {
+	while ((opt = getopt(argc, argv, "c:hi:I:p:m:M:")) != -1) {
 		switch (opt) {
+		case 'c':
+			test_dirty_ring_count = strtol(optarg, NULL, 10);
+			break;
 		case 'i':
 			iterations = strtol(optarg, NULL, 10);
 			break;
-- 
2.26.2

