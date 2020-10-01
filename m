Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D45F27F741
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 03:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731269AbgJABWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 21:22:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52255 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731056AbgJABW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 21:22:29 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601515347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Au/x+RXVuLpmMW71l+r09X+SFEaNcEAnQSW0uHVuybA=;
        b=cBWhlVZxBfDpCf9QN7wrC7mWKUUckaCSqe8c32y4v+VM8VDgq45Dad+79TfN0u9fzB2LYu
        3gIwNDNz0Z2qHBdZeNTbWiUfyqsUEPNORncWHoQHJhQ8TLP9CpuXD36ba+iTY9jO3XwDLg
        UnMJSkljILEiGs6nASlOkHhXlIG6Yr4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-X01p9ordPxqI-YV2azFl2Q-1; Wed, 30 Sep 2020 21:22:24 -0400
X-MC-Unique: X01p9ordPxqI-YV2azFl2Q-1
Received: by mail-qk1-f197.google.com with SMTP id s9so2083168qks.21
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 18:22:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Au/x+RXVuLpmMW71l+r09X+SFEaNcEAnQSW0uHVuybA=;
        b=mtjTaksCN649yMP3a4tbk8fFEv4MXhKgIKrYGFfmoPlK4DylgNeTI5/f9GIJFlDmY0
         rR6/XMEVcrhF43eQdAfdkQ0kg5GoQJfljTK3bh+CcJveHUGZZRqdKWLyZBQ/Tr/UH40t
         2QWEInp/1d9Vpppcp/7mUqVJN8AvfxndU/jMhLta6GDX3ecUQ6XuGhnsZOEPiXCiEGLF
         ydWO0BYOSLcnqz4aeqGOpS58WMR81R0Mi+9T5B6okCGCHOMy2ekGpGw8ePJQXr2YRpRC
         MeFltytK2i0+82D/pzmjA1FVwI6qb6YfTvTl0JlkkbCz9u1M6qBkp1+9niQQOJXt15Ky
         zeMQ==
X-Gm-Message-State: AOAM531GdP8mI+F3paa3EJUu/cUT/zDvmCRsQClYr3n4JytkqiErntX/
        8+vngRC3tYTV5YvQgJ+S6pcEN+2vV6MEYlErb/3r+87EBApjDi2JcNTI5QbLKv1oLWPpytwXffg
        zJJKnS7m429uK1iWVImB9N8Dl
X-Received: by 2002:a37:9f08:: with SMTP id i8mr5514630qke.197.1601515343543;
        Wed, 30 Sep 2020 18:22:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJHNu0WksI8q+v3CmlVSCeTCkIaWRAvpnmBVJ4CNWa5ya0x/cFOhsaCtmeYn8cdW52VAVBQA==
X-Received: by 2002:a37:9f08:: with SMTP id i8mr5514614qke.197.1601515343329;
        Wed, 30 Sep 2020 18:22:23 -0700 (PDT)
Received: from localhost.localdomain (toroon474qw-lp130-09-184-147-14-204.dsl.bell.ca. [184.147.14.204])
        by smtp.gmail.com with ESMTPSA id f76sm4174361qke.19.2020.09.30.18.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 18:22:22 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com,
        Andrew Jones <drjones@redhat.com>
Subject: [PATCH v13 06/14] KVM: Make dirty ring exclusive to dirty bitmap log
Date:   Wed, 30 Sep 2020 21:22:24 -0400
Message-Id: <20201001012224.5818-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201001012044.5151-1-peterx@redhat.com>
References: <20201001012044.5151-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no good reason to use both the dirty bitmap logging and the
new dirty ring buffer to track dirty bits.  We should be able to even
support both of them at the same time, but it could complicate things
which could actually help little.  Let's simply make it the rule
before we enable dirty ring on any arch, that we don't allow these two
interfaces to be used together.

The big world switch would be KVM_CAP_DIRTY_LOG_RING capability
enablement.  That's where we'll switch from the default dirty logging
way to the dirty ring way.  As long as kvm->dirty_ring_size is setup
correctly, we'll once and for all switch to the dirty ring buffer mode
for the current virtual machine.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 Documentation/virt/kvm/api.rst |  7 +++++++
 virt/kvm/kvm_main.c            | 12 ++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 6c41cc7eed77..eb628cc59b93 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6490,3 +6490,10 @@ make sure all the existing dirty gfns are flushed to the dirty rings.
 
 The dirty ring can gets full.  When it happens, the KVM_RUN of the
 vcpu will return with exit reason KVM_EXIT_DIRTY_LOG_FULL.
+
+NOTE: the capability KVM_CAP_DIRTY_LOG_RING and the corresponding
+ioctl KVM_RESET_DIRTY_RINGS are mutual exclusive to the existing ioctl
+KVM_GET_DIRTY_LOG.  After enabling KVM_CAP_DIRTY_LOG_RING with an
+acceptable dirty ring size, the virtual machine will switch to the
+dirty ring tracking mode.  Further ioctls to either KVM_GET_DIRTY_LOG
+or KVM_CLEAR_DIRTY_LOG will fail.
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index aefea6ebe132..f32f9fc60d0e 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1430,6 +1430,10 @@ int kvm_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log,
 	unsigned long n;
 	unsigned long any = 0;
 
+	/* Dirty ring tracking is exclusive to dirty log tracking */
+	if (kvm->dirty_ring_size)
+		return -EINVAL;
+
 	*memslot = NULL;
 	*is_dirty = 0;
 
@@ -1491,6 +1495,10 @@ static int kvm_get_dirty_log_protect(struct kvm *kvm, struct kvm_dirty_log *log)
 	unsigned long *dirty_bitmap_buffer;
 	bool flush;
 
+	/* Dirty ring tracking is exclusive to dirty log tracking */
+	if (kvm->dirty_ring_size)
+		return -EINVAL;
+
 	as_id = log->slot >> 16;
 	id = (u16)log->slot;
 	if (as_id >= KVM_ADDRESS_SPACE_NUM || id >= KVM_USER_MEM_SLOTS)
@@ -1599,6 +1607,10 @@ static int kvm_clear_dirty_log_protect(struct kvm *kvm,
 	unsigned long *dirty_bitmap_buffer;
 	bool flush;
 
+	/* Dirty ring tracking is exclusive to dirty log tracking */
+	if (kvm->dirty_ring_size)
+		return -EINVAL;
+
 	as_id = log->slot >> 16;
 	id = (u16)log->slot;
 	if (as_id >= KVM_ADDRESS_SPACE_NUM || id >= KVM_USER_MEM_SLOTS)
-- 
2.26.2

