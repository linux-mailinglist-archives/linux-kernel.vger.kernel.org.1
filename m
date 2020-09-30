Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52C2527F478
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 23:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731052AbgI3Vyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 17:54:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56707 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730842AbgI3Vyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 17:54:43 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601502882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R2ALy67CtgBF8fDQMZT8Ir08uhC8QFjLGT5DkxROP8I=;
        b=Eb7fqjTgLfq0/HNxVhGthll7nCiA+7ujvIKmjV4TR2ZNVQYjbAmkiXZ+XCi6IUXLvkbVi+
        VBJW5xSMgJKv0HtT1sAdHTHSVQ6fPo4ntunPtMW7/zBE996PBudyHC2zC7GW9Mo090MNnF
        B39A+MWbwdMIkT4fIHZje2FRBQf7QeQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-581-jqYbeCrNP5GoMHW6rAB8jQ-1; Wed, 30 Sep 2020 17:54:40 -0400
X-MC-Unique: jqYbeCrNP5GoMHW6rAB8jQ-1
Received: by mail-qv1-f69.google.com with SMTP id f4so1845208qvw.15
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 14:54:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R2ALy67CtgBF8fDQMZT8Ir08uhC8QFjLGT5DkxROP8I=;
        b=GMEMEq/yU03cHL5AurbMZB6oCd7k0vJU82CGsntfKdgfzG8GM6SaLHzZGRfsD6Q9bc
         vjW9Vn8/G89gVbThukYFRzJaWCGrhuI4GP9q+6KV2RMH5d30f5fDL4tNeUGH1HB1a1uu
         ZXHzLoaa/F8DOW1DJqju2JDkZM0iFDNbcojBHXPKRXOhYLoaRKJ+IxbSXKV7/RA94Qkl
         QjvIUqXGdABQs6GtD6GEFqFuGSU87acO4T9xc8X5WG0kmAcrZqioei3KcAeAYpHPL2b6
         eI4jSag+q5oUH4BhY4xOJxOm5jV3j7C5h5GRS62hGqeaChZBJYRcumDh/eghcyMgmQ5Y
         Icwg==
X-Gm-Message-State: AOAM531A5Pt8hSfNoetKVZLjc3EJiRYoZo+uxYemMqPkw6IIpHQO5Z0L
        gImL8HwXmn53dft2Su+SggdexYUtoiD7WjbXirQ6cAeb5VNeTHGwzSAUIVCyLh0MCecWQ3Ap7Cw
        G0YCq44mxhVoc+oB+kcLkUoc7
X-Received: by 2002:ac8:774f:: with SMTP id g15mr4367685qtu.294.1601502879698;
        Wed, 30 Sep 2020 14:54:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyo9Y9fPwSdcJ5NaY13SXCpRPPVcNuPIlxZwUDY9BhsBPQWJAurv6M4LALLADYaBZT7tnAjNQ==
X-Received: by 2002:ac8:774f:: with SMTP id g15mr4367678qtu.294.1601502879507;
        Wed, 30 Sep 2020 14:54:39 -0700 (PDT)
Received: from xz-x1.redhat.com (toroon474qw-lp130-09-184-147-14-204.dsl.bell.ca. [184.147.14.204])
        by smtp.gmail.com with ESMTPSA id t43sm4126963qtc.54.2020.09.30.14.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 14:54:38 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andrew Jones <drjones@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com
Subject: [PATCH v12 07/13] KVM: selftests: Always clear dirty bitmap after iteration
Date:   Wed, 30 Sep 2020 17:54:37 -0400
Message-Id: <20200930215437.48102-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200930214948.47225-1-peterx@redhat.com>
References: <20200930214948.47225-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't clear the dirty bitmap before because KVM_GET_DIRTY_LOG will
clear it for us before copying the dirty log onto it.  However we'd
still better to clear it explicitly instead of assuming the kernel
will always do it for us.

More importantly, in the upcoming dirty ring tests we'll start to
fetch dirty pages from a ring buffer, so no one is going to clear the
dirty bitmap for us.

Reviewed-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/kvm/dirty_log_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index 752ec158ac59..6a8275a22861 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -195,7 +195,7 @@ static void vm_dirty_log_verify(enum vm_guest_mode mode, unsigned long *bmap)
 				    page);
 		}
 
-		if (test_bit_le(page, bmap)) {
+		if (test_and_clear_bit_le(page, bmap)) {
 			host_dirty_count++;
 			/*
 			 * If the bit is set, the value written onto
-- 
2.26.2

