Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 371E829771C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 20:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754859AbgJWSf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 14:35:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33893 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754886AbgJWSeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 14:34:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603478058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R2ALy67CtgBF8fDQMZT8Ir08uhC8QFjLGT5DkxROP8I=;
        b=aCPSGGzqUNOvM7GDVJBRcGmozWC5PsojctGAwTgdmJubW/z15msm8IP04hRdg0PWGn+reZ
        uFkqxJAJr1hws7bamaEE2zKrMfjkgaUZSBZulWmeQzU8TFQjCC885yq+CcE4cm7t0ZW+mj
        cxNJQNIG56kPHachhlQgYzHfpZC7XMQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-vOLFYnJiMUuGLwx8PDPQuQ-1; Fri, 23 Oct 2020 14:34:16 -0400
X-MC-Unique: vOLFYnJiMUuGLwx8PDPQuQ-1
Received: by mail-qk1-f198.google.com with SMTP id w189so1622592qkd.6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 11:34:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R2ALy67CtgBF8fDQMZT8Ir08uhC8QFjLGT5DkxROP8I=;
        b=ox55rXTQZ+SynVIK2t1Yojmc3TOVguVl+FVA9D5Lqfbi9zjJ6AFQBUEGF3tHxW0ajP
         PTOPPVSDu3JEpHise7rmlNfSYcnzuZL3I351D7ne17g2MgkOiSk8VqFCXm3JY8wCwzYH
         EYKvP0ocjbmBDDxwJ0qp4ly5VwrQCLdZUqWU26boVRpiiFHzek7iIkqDn7rxNjPDTIed
         3R2vghRxpFxGuRcMVbHwdgrolPIi2CgGl1XISy/dk6f51osa05M5mlT8eg339ZFg7LPb
         tSoCa+rQ0zIib6fZx9M8e2A3jbpxfNknmIk1hVYiHnJZHvk6n9kyERJ82qFIPc6uydtT
         /PNQ==
X-Gm-Message-State: AOAM531mz1gl5PW2VuYEoxX2gYzAwBzSXwnISXRhjwOcmp6UB8hUphbm
        bSG0jQ9MucqCFAfRL7nGHk5b/cF6Wm7wsrjomKlAsQG9LdDbMFm118ct9qaWZz7ilc/WYPsrmK2
        wHmOOclXWaNq0VcRBqiwxiVLV
X-Received: by 2002:a05:620a:1e7:: with SMTP id x7mr3511287qkn.465.1603478055907;
        Fri, 23 Oct 2020 11:34:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzdbEKO+mgZn7fwYiD7deukv0UF5TGReMh4GNOJSVqM5OzUudOoLbS84dolU1UuPtlhENiuCw==
X-Received: by 2002:a05:620a:1e7:: with SMTP id x7mr3511035qkn.465.1603478052715;
        Fri, 23 Oct 2020 11:34:12 -0700 (PDT)
Received: from xz-x1.redhat.com (toroon474qw-lp140-04-174-95-215-133.dsl.bell.ca. [174.95.215.133])
        by smtp.gmail.com with ESMTPSA id u11sm1490407qtk.61.2020.10.23.11.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 11:34:11 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        peterx@redhat.com, Andrew Jones <drjones@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v15 08/14] KVM: selftests: Always clear dirty bitmap after iteration
Date:   Fri, 23 Oct 2020 14:33:52 -0400
Message-Id: <20201023183358.50607-9-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201023183358.50607-1-peterx@redhat.com>
References: <20201023183358.50607-1-peterx@redhat.com>
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

