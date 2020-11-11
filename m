Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A28962AF897
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 19:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbgKKSxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 13:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgKKSxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 13:53:42 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990F6C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 10:53:42 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id v20so1664869plo.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 10:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=93R4ztQrLrDF9Ja7P3toIKUvpq9Mkw15Zf+bh5c6Tqo=;
        b=kK51WkYoFHiSWND2/+N+C4Ova1zafjAVM+MPR0hpWwVY8W6VovOfLNmIiMynognenH
         lbj/HnGi8LUypoLkUvvq6ifdmaKSM7Qs5KY8OLvuNSHqi93xn9P6OKqDth56mfLf7TmS
         eTy6XVOeyZYgAtmx4jHnLmdF44tZnyR7Y37vDyXD8JbUe+YWpWxdIFOY2Nm8WnVKjlrZ
         mxOlGUs7o2Q964Dlth1cEweUi0t1TPbzd6pUE+KsV14NikSdbNfPu+/9c1+67WbwQh0t
         up5tbY5R9KY1/3ZqfWU+oDjfpEZZf3nt8OrukS3kW8t8SAHkHMKBe8JkEeeJE8heHb7y
         6zVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=93R4ztQrLrDF9Ja7P3toIKUvpq9Mkw15Zf+bh5c6Tqo=;
        b=lNt7ISFZZrkhRDCUfNHfigWeR2gq5FZ4/x1ll+u8RWyOZrj8V5Qz2OrQAvW+n8T5s6
         CNxwVl5okHkX2x73HFWtHWCg/m7R+Shq/Li896OnVbF+PrbLYWz586o1kmEPbdIFJ1QC
         lP/7RJqTwzsG3ApqmC/htasyjOoDbsduKfEWqMp+FWB3ULLDFFpvRthLBYWREMN9kysI
         9zpZiiRUoDyzZjWjX/aecjJPorDxLHBgtQEtr26HMAU/0TP5jxbEOATOuNnBilTt4/A9
         qLJ2G45J7PxGdsGo/yX1LlmNvzVVI+2gM0eEM2Rr7qLovSSLCd2ZdTStphOS/1N5q4Ym
         QCyw==
X-Gm-Message-State: AOAM5324XNDMjnw+VvHzZogmaNiL1IBZxuSuFrEDUzUIRKzfYizdmwyF
        uJwQP+7eDfVFuOBl10srTIjsJVJBTnFT5mIwqP9Yx2K6lfWB86LnxaOl1PU6O2ZEBczGzOF592Z
        29KMFzEbK5QqRl8zKQDc8ilDwrgo0Tc8FGkju+kAnJRX1QIYRIyg1H/M8llXBKyX/UeRgJDwq
X-Google-Smtp-Source: ABdhPJyl7J/4ZMYI6a1D98WFOkbXOBJ8G/8pul2PYv3oklRs7dNvgDUFi0coDy0Z5skyieCqVo68nE6HtM2h
Sender: "bgardon via sendgmr" <bgardon@bgardon.sea.corp.google.com>
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:f693:9fff:fef4:a293])
 (user=bgardon job=sendgmr) by 2002:a17:902:bc46:b029:d6:d98a:1a68 with SMTP
 id t6-20020a170902bc46b02900d6d98a1a68mr10718919plz.63.1605120821929; Wed, 11
 Nov 2020 10:53:41 -0800 (PST)
Date:   Wed, 11 Nov 2020 10:53:37 -0800
Message-Id: <20201111185337.1237383-1-bgardon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH] kvm: x86/mmu: Fix is_tdp_mmu_check when using PAE
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Peter Shier <pshier@google.com>,
        Jim Mattson <jmattson@google.com>,
        Zdenek Kaspar <zkaspar82@gmail.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When PAE is in use, the root_hpa will not have a shadow page assoicated
with it. In this case the kernel will crash with a NULL pointer
dereference. Add checks to ensure is_tdp_mmu_root works as intended even
when using PAE.

Tested: compiles

Fixes: 02c00b3a2f7e ("kvm: x86/mmu: Allocate and free TDP MMU roots")
Reported-by: Zdenek Kaspar <zkaspar82@gmail.com>
Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 27e381c9da6c..13013f4d98ad 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -49,8 +49,18 @@ bool is_tdp_mmu_root(struct kvm *kvm, hpa_t hpa)
 {
 	struct kvm_mmu_page *sp;
 
+	if (WARN_ON(!VALID_PAGE(hpa)))
+		return false;
+
 	sp = to_shadow_page(hpa);
 
+	/*
+	 * If this VM is being run with PAE, the TDP MMU will not be enabled
+	 * and the root HPA will not have a shadow page associated with it.
+	 */
+	if (!sp)
+		return false;
+
 	return sp->tdp_mmu_page && sp->root_count;
 }
 
-- 
2.29.2.222.g5d2a92d10f8-goog

