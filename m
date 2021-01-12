Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 914CA2F380E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 19:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392213AbhALSL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 13:11:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391891AbhALSL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 13:11:56 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764EAC0617B9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 10:10:58 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id c83so2124233qkg.15
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 10:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=zBj4o53W1HK0H3qMajow5mpw8KHH0LDuEQnosEPCoeQ=;
        b=uSOAFid37w4lzwlCIdRo8jUVqJkDSGyW0jCe9XqwFmh44qlhSaa4sp4OI72SdZKSIz
         SyLky6tAXG07oVgUPQMPJ9A7keUkRNlOLwuMFBAP6ZQckkmz4hugiOzRX8A4XOFyYQUJ
         NmOnGuF29ZkXGWHgmbmliVdxA3pq17gL4Al9dY1kYHgInDWYMkKfqtQLsj362VgcCLca
         6phvluUx4fMWQKgGjjVqGs91MgxtrKItjHW608Xij+JvYLCS7blHg7X4672HPUG4VIe2
         Q3B3NnLbJOWOgy71KBdUEzu+zWSoydQNPOiRApKqyiKsDojwIBoVYvUB6gnK7/I28hg2
         ebBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zBj4o53W1HK0H3qMajow5mpw8KHH0LDuEQnosEPCoeQ=;
        b=kHxm3gOSqQQPbKaset82/IS61rS5qTl44lnrPFmuG1vwpcaizJS11rURHI2WnTLQUz
         pP/bGuLbjhO4kVVtuppndWBqfsbPiXvVHNFDFVGqH/XxGTVfhRS/+CQOd44fT8Dwm4Oy
         D5ib6ZLfUj9HqFrZa0C45LPjbehnBJBmlwUTyA2qDd64Ib1h45pKpmY26B0Ezd/3uhts
         z38dKfDpV5u2OvxjGtweYYAbP8qpdJMttJkYDxEZmJKMLmyk59mPhUysVTFaJc2LJBTs
         Q3lAeB6G4Yoy8zYCAGEp8u50UCz6CO/QdUcD7TCCNqwZ9VbfYqUyTAtO3bPew7fdGmI3
         Hllw==
X-Gm-Message-State: AOAM531IBHtRkug2vQSFN/R2sldFPEgDgc51jq7jF7alEuauv5Elmoza
        wOo4OE0XuO43t4djJcDkk05JcGqGqzVngbwileCj3ixDAEc3aiXwnSyvditqEGjq/OCEHXUlH5s
        E00h2olBZrhz1qA+oKJtuDNrztvYJkWF+nQhEiocr9T6lRVOeFaWqGOaiUWfu0QrN4kqSKHRM
X-Google-Smtp-Source: ABdhPJyAumO5UP7YQDoBTNB/GTjXBeBum2y4V4qjRNJi0M6Gw6MY+3qPYDKW2tNa/hIfoiRX4yCXPjjoy8qs
Sender: "bgardon via sendgmr" <bgardon@bgardon.sea.corp.google.com>
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:f693:9fff:fef4:a293])
 (user=bgardon job=sendgmr) by 2002:ad4:5192:: with SMTP id
 b18mr673974qvp.46.1610475057494; Tue, 12 Jan 2021 10:10:57 -0800 (PST)
Date:   Tue, 12 Jan 2021 10:10:24 -0800
In-Reply-To: <20210112181041.356734-1-bgardon@google.com>
Message-Id: <20210112181041.356734-8-bgardon@google.com>
Mime-Version: 1.0
References: <20210112181041.356734-1-bgardon@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH 07/24] kvm: x86/mmu: Add comment on __tdp_mmu_set_spte
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Shier <pshier@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__tdp_mmu_set_spte is a very important function in the TDP MMU which
already accepts several arguments and will take more in future commits.
To offset this complexity, add a comment to the function describing each
of the arguemnts.

No functional change intended.

Reviewed-by: Peter Feiner <pfeiner@google.com>

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 2650fa9fe066..b033da8243fc 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -357,6 +357,22 @@ static void handle_changed_spte(struct kvm *kvm, int as_id, gfn_t gfn,
 				      new_spte, level);
 }
 
+/*
+ * __tdp_mmu_set_spte - Set a TDP MMU SPTE and handle the associated bookkeeping
+ * @kvm: kvm instance
+ * @iter: a tdp_iter instance currently on the SPTE that should be set
+ * @new_spte: The value the SPTE should be set to
+ * @record_acc_track: Notify the MM subsystem of changes to the accessed state
+ *		      of the page. Should be set unless handling an MMU
+ *		      notifier for access tracking. Leaving record_acc_track
+ *		      unset in that case prevents page accesses from being
+ *		      double counted.
+ * @record_dirty_log: Record the page as dirty in the dirty bitmap if
+ *		      appropriate for the change being made. Should be set
+ *		      unless performing certain dirty logging operations.
+ *		      Leaving record_dirty_log unset in that case prevents page
+ *		      writes from being double counted.
+ */
 static inline void __tdp_mmu_set_spte(struct kvm *kvm, struct tdp_iter *iter,
 				      u64 new_spte, bool record_acc_track,
 				      bool record_dirty_log)
-- 
2.30.0.284.gd98b1dd5eaa7-goog

