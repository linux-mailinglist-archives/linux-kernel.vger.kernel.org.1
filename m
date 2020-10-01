Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2396327F744
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 03:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731437AbgJABWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 21:22:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37831 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731217AbgJABWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 21:22:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601515356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1Frsr00VTIsYjdqDeTzSRco7BaTYBstaIvbV6rdyHlg=;
        b=aKOfWhmwlW7DgSUnfVjn8Ke7nseapeaykPe2fSvwx8JJhK0XZkFZKI6HvuS9SeGegTKBPW
        g/LsZEJyP47aGz7ZFLCCjXqubqvZNzmz+YxBw5POzfdZ/AiOK7shuxnBc0MCoywya6afAw
        hW5FUnT9kR4m6qoDwURVzpzaokFB5no=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-fT5K4TmuOVu3KYcyeKzWeQ-1; Wed, 30 Sep 2020 21:22:35 -0400
X-MC-Unique: fT5K4TmuOVu3KYcyeKzWeQ-1
Received: by mail-qt1-f200.google.com with SMTP id u6so2519347qte.8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 18:22:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1Frsr00VTIsYjdqDeTzSRco7BaTYBstaIvbV6rdyHlg=;
        b=QAicUpH4r7IDrlV2eCOqbNCE69rrR30/PTBo6RfjKKc5kX/s9nhpiAqi2FILUoHmUB
         dpL+PZH3BansgGCQRvSRXHkMDTYaA0L/951bwcum1Hvx2EHqU/hosKyyymMqRJAhz6ph
         MHlxk9fkLYcDR1skFKOIAgv52h8UxS5s/eGLvNnuRnT6frlUBGw2h3EC7K/quMdmIXEJ
         uttwAArvv9f1ZnRepQWteRh/z4cfbgYeU7EgVT7p5m+MNgFeFXAiTvJ3wUY01YFJNlsK
         nGBNCKc+S13h2nHSJWSH5OBz5w9kWGtNPZK48S3oYDBIqu4/3pRh9ZeYddFepkHEU8Fi
         4EJA==
X-Gm-Message-State: AOAM530IhnofKpbv5WhpW0rYZlYk62AmwrQnBbXvdqUQl9cHfuuuC0NL
        UvEq8cfi+GytXOp0rmnO8VWzZxasfFkcHJ28GbPvJXRsuYKSk/C7GOKgtrIBaJAxW62C3Wc6ZoU
        mJUj1iTk4BtO5BN4Anktmf8H9
X-Received: by 2002:a05:620a:1341:: with SMTP id c1mr5369772qkl.460.1601515354611;
        Wed, 30 Sep 2020 18:22:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwTLU06a4jpTQTbqtgSPvejw6TopdW4ggGMhHzTw1NbO7I8zgzAN0WfWXAithKOzZZblbLY1w==
X-Received: by 2002:a05:620a:1341:: with SMTP id c1mr5369753qkl.460.1601515354393;
        Wed, 30 Sep 2020 18:22:34 -0700 (PDT)
Received: from localhost.localdomain (toroon474qw-lp130-09-184-147-14-204.dsl.bell.ca. [184.147.14.204])
        by smtp.gmail.com with ESMTPSA id t20sm4502156qke.79.2020.09.30.18.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 18:22:33 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com,
        Andrew Jones <drjones@redhat.com>
Subject: [PATCH v13 11/14] KVM: selftests: Introduce after_vcpu_run hook for dirty log test
Date:   Wed, 30 Sep 2020 21:22:35 -0400
Message-Id: <20201001012235.6063-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201001012044.5151-1-peterx@redhat.com>
References: <20201001012044.5151-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a hook for the checks after vcpu_run() completes.  Preparation
for the dirty ring test because we'll need to take care of another
exit reason.

Reviewed-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/kvm/dirty_log_test.c | 36 +++++++++++++-------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index 139ccb550618..a2160946bcf5 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -178,6 +178,15 @@ static void clear_log_collect_dirty_pages(struct kvm_vm *vm, int slot,
 	kvm_vm_clear_dirty_log(vm, slot, bitmap, 0, num_pages);
 }
 
+static void default_after_vcpu_run(struct kvm_vm *vm)
+{
+	struct kvm_run *run = vcpu_state(vm, VCPU_ID);
+
+	TEST_ASSERT(get_ucall(vm, VCPU_ID, NULL) == UCALL_SYNC,
+		    "Invalid guest sync status: exit_reason=%s\n",
+		    exit_reason_str(run->exit_reason));
+}
+
 struct log_mode {
 	const char *name;
 	/* Return true if this mode is supported, otherwise false */
@@ -187,16 +196,20 @@ struct log_mode {
 	/* Hook to collect the dirty pages into the bitmap provided */
 	void (*collect_dirty_pages) (struct kvm_vm *vm, int slot,
 				     void *bitmap, uint32_t num_pages);
+	/* Hook to call when after each vcpu run */
+	void (*after_vcpu_run)(struct kvm_vm *vm);
 } log_modes[LOG_MODE_NUM] = {
 	{
 		.name = "dirty-log",
 		.collect_dirty_pages = dirty_log_collect_dirty_pages,
+		.after_vcpu_run = default_after_vcpu_run,
 	},
 	{
 		.name = "clear-log",
 		.supported = clear_log_supported,
 		.create_vm_done = clear_log_create_vm_done,
 		.collect_dirty_pages = clear_log_collect_dirty_pages,
+		.after_vcpu_run = default_after_vcpu_run,
 	},
 };
 
@@ -247,6 +260,14 @@ static void log_mode_collect_dirty_pages(struct kvm_vm *vm, int slot,
 	mode->collect_dirty_pages(vm, slot, bitmap, num_pages);
 }
 
+static void log_mode_after_vcpu_run(struct kvm_vm *vm)
+{
+	struct log_mode *mode = &log_modes[host_log_mode];
+
+	if (mode->after_vcpu_run)
+		mode->after_vcpu_run(vm);
+}
+
 static void generate_random_array(uint64_t *guest_array, uint64_t size)
 {
 	uint64_t i;
@@ -261,25 +282,16 @@ static void *vcpu_worker(void *data)
 	struct kvm_vm *vm = data;
 	uint64_t *guest_array;
 	uint64_t pages_count = 0;
-	struct kvm_run *run;
-
-	run = vcpu_state(vm, VCPU_ID);
 
 	guest_array = addr_gva2hva(vm, (vm_vaddr_t)random_array);
-	generate_random_array(guest_array, TEST_PAGES_PER_LOOP);
 
 	while (!READ_ONCE(host_quit)) {
+		generate_random_array(guest_array, TEST_PAGES_PER_LOOP);
+		pages_count += TEST_PAGES_PER_LOOP;
 		/* Let the guest dirty the random pages */
 		ret = _vcpu_run(vm, VCPU_ID);
 		TEST_ASSERT(ret == 0, "vcpu_run failed: %d\n", ret);
-		if (get_ucall(vm, VCPU_ID, NULL) == UCALL_SYNC) {
-			pages_count += TEST_PAGES_PER_LOOP;
-			generate_random_array(guest_array, TEST_PAGES_PER_LOOP);
-		} else {
-			TEST_FAIL("Invalid guest sync status: "
-				  "exit_reason=%s\n",
-				  exit_reason_str(run->exit_reason));
-		}
+		log_mode_after_vcpu_run(vm);
 	}
 
 	pr_info("Dirtied %"PRIu64" pages\n", pages_count);
-- 
2.26.2

