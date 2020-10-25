Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23C0B298339
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 19:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1418343AbgJYSxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 14:53:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55260 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1418322AbgJYSxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 14:53:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603652025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zm0y/NgV1CA3qc6DHTxR8W397xZffPB2LchwQHAbN7M=;
        b=IpSmUHgS7yOOgCYznbaRfzwqqZkDDyA0z6jvgPv3f2EMFkeNtwwwtyhuvYPuYR6YchKr1l
        sINI4k/JoZGWjnrTYIGiiaUBNtAGKqgvtEwzn4e04hB2TFRAu2TWb6bMwtcH8rO/iGlUCJ
        BJflt86zS3LALyk/anqt+gX5R6hYJvE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-16JtkHBJOjaMTTca2zMSlA-1; Sun, 25 Oct 2020 14:53:41 -0400
X-MC-Unique: 16JtkHBJOjaMTTca2zMSlA-1
Received: by mail-qv1-f70.google.com with SMTP id ec4so4362219qvb.21
        for <linux-kernel@vger.kernel.org>; Sun, 25 Oct 2020 11:53:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zm0y/NgV1CA3qc6DHTxR8W397xZffPB2LchwQHAbN7M=;
        b=TMKSlo5uDfbcbWMp/RappT3ikprQBlqmWzI6GlQRaMRLBzP+1kKgVwHvhzaykFz96M
         nFPx3wudplxnNJjzZNj3rZlBEIkCX11qpd8brcKYoL6dz6sNVV5galadygcedMQBMdhJ
         qbDthUbI4vkCmDyerhROk8RKSZk6F5CWm0ysoMKaXKjkbJpiJlFvuobe3z4Gl/Y8oWdN
         q7tHse6yTfsvSgBzmj7JyRMuB/oH4Fvn/C2jwT7f87Ko4cJC7srezFJMkG2DZdDsZ1lB
         SYFNg8Q9YyIH8T3ji2aDS1djO2i4OTI45LdRLp2DS8WEj+7FLyL6LgDqdgkJHRhhFiOh
         967Q==
X-Gm-Message-State: AOAM531pdYwDw4M0wYfzrxr8IHIbdC59d4s+AzYcrscW/36pfeUpwtqs
        JyabDm1IaEFa8ceIG8G20tlUb71LISsyvAcccjPCVOCU4QkCdfDV4bfQYbWNnU/uoKzCycgauay
        8GjgDW43g5gY4g/xWjIbf8uxX
X-Received: by 2002:a37:a5d4:: with SMTP id o203mr13829921qke.40.1603652020636;
        Sun, 25 Oct 2020 11:53:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzyWNSYqgjU/lO0p0UapTK2q5MU0iTqDM8Kql9oXtrbn3a+VgKT8IStndVitg5xOQZJ2pUuRw==
X-Received: by 2002:a37:a5d4:: with SMTP id o203mr13829901qke.40.1603652020413;
        Sun, 25 Oct 2020 11:53:40 -0700 (PDT)
Received: from xz-x1.redhat.com (toroon474qw-lp140-04-174-95-215-133.dsl.bell.ca. [174.95.215.133])
        by smtp.gmail.com with ESMTPSA id y3sm5305224qto.2.2020.10.25.11.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 11:53:39 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>, peterx@redhat.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Steffen Dirkwinkel <kernel-bugs@steffen.cc>
Subject: [PATCH 2/2] KVM: X86: Fix null pointer reference for KVM_GET_MSRS
Date:   Sun, 25 Oct 2020 14:53:34 -0400
Message-Id: <20201025185334.389061-3-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201025185334.389061-1-peterx@redhat.com>
References: <20201025185334.389061-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kvm_msr_ignored_check() could trigger a null pointer reference if ignore_msrs=Y
and report_ignore_msrs=Y when try to fetch an invalid feature msr using the
global KVM_GET_MSRS.  Degrade the error report to not rely on vcpu since that
information (index, rip) is not as important as msr index/data after all.

Fixes: 12bc2132b15e0a96
Reported-by: Steffen Dirkwinkel <kernel-bugs@steffen.cc>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/kvm/x86.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ce856e0ece84..5993fbd6d2c5 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -259,8 +259,8 @@ static int kvm_msr_ignored_check(struct kvm_vcpu *vcpu, u32 msr,
 
 	if (ignore_msrs) {
 		if (report_ignored_msrs)
-			vcpu_unimpl(vcpu, "ignored %s: 0x%x data 0x%llx\n",
-				    op, msr, data);
+			kvm_pr_unimpl("ignored %s: 0x%x data 0x%llx\n",
+				      op, msr, data);
 		/* Mask the error */
 		return 0;
 	} else {
-- 
2.26.2

