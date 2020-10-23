Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F73C297721
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 20:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750017AbgJWSfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 14:35:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60660 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754829AbgJWSeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 14:34:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603478046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f9RAo1p5Z3QHuNccDaVSZ9lEhBh3TGuTwN8hkmUR6Fw=;
        b=YfpPgb0XSMThlg7QwKA4/qEMLHTcGkF0TxD/otzoEzRz2o1fUTaIZb0J2ckypCOAPP+tHV
        2hAc1p/HD5CyZtEWK7uFeSsnYWMKiGKUXIMEwCUFchbUFyXPrDuUNBMBJExPbKd76j8TQH
        KBv58NGq1Or7V3v0IaHWtFJ+tgnLHx0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-Mnfu9NmTO4GtAcaN8y29lQ-1; Fri, 23 Oct 2020 14:34:02 -0400
X-MC-Unique: Mnfu9NmTO4GtAcaN8y29lQ-1
Received: by mail-qk1-f200.google.com with SMTP id x85so1623712qka.14
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 11:34:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f9RAo1p5Z3QHuNccDaVSZ9lEhBh3TGuTwN8hkmUR6Fw=;
        b=KDtxe7bVcAxLedGWXdw+3JHDi4laHp9UMJ+bDhBK96kOqzKisQ0JihSoHvxR5bsjwN
         YQR8CjD2ajAMVQt51J+B0NMxcfn5tLOuK1ecetH27Z2ESKiylXnE6z60tlznBOgIzbTw
         QoxE/2J4ADZ/p1hoZVTxEsPd6XcgxZXsIrVwSGJv/JNfF/QplwBhKWEojhaheS8SKFeS
         pMkmdOibcyW61l/g7857SNtKx+FXcThaDWkfkehndYsf1m56KqV8j+/uelH+pixkgbZ6
         63sWZOlUt9Mhf+ElfrgFVrGGVZnXet1GUEKm4U0662Q7AEKxZ2jS8372wMCzo4cKvZNI
         a2ZA==
X-Gm-Message-State: AOAM5300vFzUBgHwUr4d4nNi1Aycgi96B5SQqo2nZNMbNkWeBZc0zQbR
        11z+3X3mFNrw7/YZszOiWFu53Bnr/E8qJKzwKouI/GU6H7jvTRedPCqOTzhiwVp4kc959T+UtFi
        0FOTbIEIAxAKeKEEZtGpATNxf
X-Received: by 2002:ac8:2f91:: with SMTP id l17mr3488382qta.252.1603478041960;
        Fri, 23 Oct 2020 11:34:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyay/GTLlaHShgebWAWLZqPirAfvX+bQW7w7XUQEvI4fD7jH+bC1CjDWb2H2QxOTagrC/TUKA==
X-Received: by 2002:ac8:2f91:: with SMTP id l17mr3488368qta.252.1603478041747;
        Fri, 23 Oct 2020 11:34:01 -0700 (PDT)
Received: from xz-x1.redhat.com (toroon474qw-lp140-04-174-95-215-133.dsl.bell.ca. [174.95.215.133])
        by smtp.gmail.com with ESMTPSA id u11sm1490407qtk.61.2020.10.23.11.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 11:34:01 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        peterx@redhat.com, Andrew Jones <drjones@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v15 01/14] KVM: Documentation: Update entry for KVM_X86_SET_MSR_FILTER
Date:   Fri, 23 Oct 2020 14:33:45 -0400
Message-Id: <20201023183358.50607-2-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201023183358.50607-1-peterx@redhat.com>
References: <20201023183358.50607-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It should be an accident when rebase, since we've already have section
8.25 (which is KVM_CAP_S390_DIAG318).  Fix the number.

Should be squashed into 1a155254ff937ac92cf9940d.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 Documentation/virt/kvm/api.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 76317221d29f..094e128634d2 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6367,7 +6367,7 @@ accesses that would usually trigger a #GP by KVM into the guest will
 instead get bounced to user space through the KVM_EXIT_X86_RDMSR and
 KVM_EXIT_X86_WRMSR exit notifications.
 
-8.25 KVM_X86_SET_MSR_FILTER
+8.27 KVM_X86_SET_MSR_FILTER
 ---------------------------
 
 :Architectures: x86
-- 
2.26.2

