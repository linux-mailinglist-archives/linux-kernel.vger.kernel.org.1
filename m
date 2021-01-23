Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8D58301161
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 01:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbhAWAHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 19:07:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbhAWAES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 19:04:18 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB3EC061793
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 16:03:38 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id v187so7157363ybv.21
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 16:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=huNlIJ7Yg75JoKdNsl5GEWjhm3+dWcG2HYvnr3aNRuc=;
        b=szY1n9iTsc/aaqj41mQ3HmYUSlKuHHupuib3xZUD9DyiOSeFw9sORxon7bApTIvxJh
         71u7D2GJgBezhMnEzszrGWnoBMGD1E31yIi9LVNx827d7m39p0QnOQkvpmbNlafQHvTR
         93J/KA/AgoHEodiIxjn7NDyopvVg3vUWXBpkIrJ4iPjm5/S1Kij/inN52V9hzcnusg3t
         HAeUJdM24uelQ9qAl2c7LQMBKHevbSxAfYIg25qx3lcTruPUSeBVVB35Nlp7cj6ZIjUb
         CZVIQ8Ny9WEhJwMyCdVbclIHI/RJgH8nztNZ1pngqDit3NdiAJgzI5bINot/OyjRAG2c
         h63w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:message-id:mime-version
         :subject:from:to:cc;
        bh=huNlIJ7Yg75JoKdNsl5GEWjhm3+dWcG2HYvnr3aNRuc=;
        b=ktTDV8IO/qt4jYi/qkVoMM7tqmhT6cn5wnlkgyW/lzkuRlq0UIdKOJ53gnfm4BwpvD
         ZgUiMrqEvjCLUvwM54bI5IakD9eyRw+lF2n72sqt8l4Fd+71ZySB1ZvJQzXRbrQmLNkM
         l6vUBMFD5HbET8j1oVkZT1lD+EPXNxmRKK4TYpbYwAbovPAwHj6RMTpwtdDcwGrplu9w
         MjTiufbrcTFDBiY2eUJ0haUgG8D7+sLPdrQeO2Rvm5aWbX1XL+Ln2ZPkP6ZIZvmKQGSO
         yGiLcaAa8uA8z4340iQhhq5oQHr0bzKzvLlnDFIQ5ddRRUu96MwUc/zVRxJ4HnQ1dvB+
         2oKg==
X-Gm-Message-State: AOAM532XltmEpB6CxPGxo/LqfH5ijsnBFauW0l3eI50s/eX7lZdwD+r1
        O5S90MwGHelVQurCM7bSixi1aV5IgWM=
X-Google-Smtp-Source: ABdhPJylkXbvRZTR5m0tqnFQUTNKRv6PkJ+Bi3QAo5kYyYoKj4yHKAnYaQAQfnzzkicXxVRPZCGtEBzpC8c=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
 (user=seanjc job=sendgmr) by 2002:a25:2388:: with SMTP id j130mr10249555ybj.301.1611360217905;
 Fri, 22 Jan 2021 16:03:37 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 22 Jan 2021 16:03:32 -0800
Message-Id: <20210123000334.3123628-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH 0/2] KVM: x86: Minor steal time cleanups
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanups and a minor optimization to kvm_steal_time_set_preempted() that
were made possible by the switch to using a cache gfn->pfn translation.

Sean Christopherson (2):
  KVM: x86: Remove obsolete disabling of page faults in
    kvm_arch_vcpu_put()
  KVM: x86: Take KVM's SRCU lock only if steal time update is needed

 arch/x86/kvm/x86.c | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

-- 
2.30.0.280.ga3ce27912f-goog

