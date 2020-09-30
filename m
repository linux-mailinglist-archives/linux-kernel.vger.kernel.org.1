Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85A0F27F47E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 23:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731348AbgI3VzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 17:55:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34334 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730862AbgI3Vyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 17:54:38 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601502877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gztZBGkRzVp8WHABoAlzTY5u2/3Xedlc1leDKo+CwFA=;
        b=C48TsGiV6WoIbejMryuxmBve61yV2LDfOFP4ZeEywB5y6KRYQYGI/sKk47UozJYK6jddL+
        bez+1haCa2rTbwEeVQSEknwTDib6ITwPGIbhtmxGWcDOV8Q4EUkj8wJsM2uflW8AJ1dhLh
        nRhzKj1TrpV8CXutMRGnvGLhpo/MWPQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-1EDkrC1wPwmSxjBceosyIw-1; Wed, 30 Sep 2020 17:54:35 -0400
X-MC-Unique: 1EDkrC1wPwmSxjBceosyIw-1
Received: by mail-qv1-f70.google.com with SMTP id w2so1841150qvr.19
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 14:54:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gztZBGkRzVp8WHABoAlzTY5u2/3Xedlc1leDKo+CwFA=;
        b=DCrWJU1Yu3txzXYTToIyWEgMmQKIesMsf0bbFry119CM+1tRFBJtt2y+i/+M0Lx3fd
         a7G2OAe0d5TE4sti24dPZvJIEXI1Vntx49i6nUZYC+Of57u9BGjZv7tTR4o0omOyV6lQ
         O1w208tTgD2PNglkp8l2L9iidZ6Og0jiH1dGoKeuDAh1Mym/mbu96Uzbh3zwXME+c+yv
         UT7pcWrc6QLJoFJGfxYyy4Ee87+SC0dw+NTqq7LJu0TP3DN4beB5t+OxaJJqAKUBG52h
         llAQA7BNJregQ5d1PM05xNGWXbxXNaQAbv4q2PG5roUpqHaoYZO4FKj15anrV48Iqz/z
         Stjg==
X-Gm-Message-State: AOAM533LYxLX+f/NbcuFJ8tp3dNtuIg7/bRvsE8knnX6psDDdbirX6AY
        /YKqknQMG6jeBxMI3tHyAiWQmAVEx7k1meR2EFKcdXcSdOWdQ/NXk0Ee0A1DBMeThodLIa/ROcE
        Uws2pIlKhT5IF3Io0uIM/Hj5K
X-Received: by 2002:ac8:3845:: with SMTP id r5mr4569372qtb.223.1601502875194;
        Wed, 30 Sep 2020 14:54:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzPOXScD6l843W9QJYs/dVmI+c+0uBwzsiIKxQPyKljnuCbend6CH7peDDqRGj5nuDgH8MnGA==
X-Received: by 2002:ac8:3845:: with SMTP id r5mr4569354qtb.223.1601502874971;
        Wed, 30 Sep 2020 14:54:34 -0700 (PDT)
Received: from xz-x1.redhat.com (toroon474qw-lp130-09-184-147-14-204.dsl.bell.ca. [184.147.14.204])
        by smtp.gmail.com with ESMTPSA id s25sm4026348qtc.90.2020.09.30.14.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 14:54:34 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andrew Jones <drjones@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com
Subject: [PATCH v12 05/13] KVM: Make dirty ring exclusive to dirty bitmap log
Date:   Wed, 30 Sep 2020 17:54:33 -0400
Message-Id: <20200930215433.48004-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200930214948.47225-1-peterx@redhat.com>
References: <20200930214948.47225-1-peterx@redhat.com>
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
index f9d18f17bb0b..23f09b3717a6 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6309,3 +6309,10 @@ make sure all the existing dirty gfns are flushed to the dirty rings.
 
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
index 1f1da2ca907a..0574a9725727 100644
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

