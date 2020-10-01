Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 932D627F747
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 03:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731513AbgJABWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 21:22:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58194 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731417AbgJABWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 21:22:45 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601515363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nwkOICvOQaXOWcko8kpLlTGev7mN/mGmU8J6lWaTsxY=;
        b=LBRDY2h8V/ljWymn6cM23TTvDe3P4W4vNgNuOQWTBPP8VQi7AwSwnoienXrwpZVSwssjfb
        TiatNA71CUObw9UeZl8Xi6k5goIJ0KV2+D3KCXU3AJMTn/6Ait/ZiFIO99Ftl0ayYCy482
        o1oW4dsG17at3lJPoiXkiBbih35vvBs=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-IjscwUGPMtygnKUbn3gqhA-1; Wed, 30 Sep 2020 21:22:41 -0400
X-MC-Unique: IjscwUGPMtygnKUbn3gqhA-1
Received: by mail-qv1-f72.google.com with SMTP id a13so2117026qvl.6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 18:22:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nwkOICvOQaXOWcko8kpLlTGev7mN/mGmU8J6lWaTsxY=;
        b=uHju465y1xDRcTuEpEtaP19IHp9kGb9Fp+bto77pYb0pUyE2/8nHBKa3inpR+czWam
         VbBmNclrK/E5dLjUw1089yBHapHVFeOJ9FYS7ODRkuLN0h0AOAkLhc4XS7Bu1HfVV37J
         WiFiEPiRzpQ5zBVCTr6xPiC+ZiwZuXLFYPbAnKJoLcIDumosFAtNVuy3sq1JsuMpoAu2
         XuGsozu96VfEBaepxLFmuTnmg18oR+6K07QL6aKIp3fj+MOSmp0epgBv9VeTrB2icTSS
         ExVIt6kVUw6nIxcyWQwtZwsaMSeEKHVQh4S6pvPQetmDk6l4vr3JYEblG+2oEZ6b/6qF
         PO+g==
X-Gm-Message-State: AOAM530MHuE63Bto/P1GETL5v/dHM1Ij8fLYpzmZI2QWcHVb8UJ/eOSV
        t4jC0xhwy/cCmlNJB4RsdVoBZGkpdp8t5U1IhaKRTR8iY/M5prhqIV3ApP2cHwJ+0O4Y2rUGLJg
        Iph+XtABCmUdHyH307Mj3O0vV
X-Received: by 2002:ad4:5653:: with SMTP id bl19mr5138450qvb.7.1601515361099;
        Wed, 30 Sep 2020 18:22:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzsEJsnvKvtbJ/u+i76tMf5ynAd81WHTOX5f/J75IRCU4qFNtOcoXp/mLKgQTz+Mt4hyPJY+Q==
X-Received: by 2002:ad4:5653:: with SMTP id bl19mr5138435qvb.7.1601515360847;
        Wed, 30 Sep 2020 18:22:40 -0700 (PDT)
Received: from localhost.localdomain (toroon474qw-lp130-09-184-147-14-204.dsl.bell.ca. [184.147.14.204])
        by smtp.gmail.com with ESMTPSA id h65sm4520087qtd.58.2020.09.30.18.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 18:22:40 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com,
        Andrew Jones <drjones@redhat.com>
Subject: [PATCH v13 14/14] KVM: selftests: Add "-c" parameter to dirty log test
Date:   Wed, 30 Sep 2020 21:22:41 -0400
Message-Id: <20201001012241.6208-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201001012044.5151-1-peterx@redhat.com>
References: <20201001012044.5151-1-peterx@redhat.com>
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

