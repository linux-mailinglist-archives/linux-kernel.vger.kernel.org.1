Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9832F881F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 23:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbhAOWEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 17:04:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbhAOWEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 17:04:41 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689F8C061795
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 14:04:01 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 203so8410930ybz.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 14:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=F4qSiyP6qNsDhBMqCUY6h5QJboOTRDoltedUrihSiWc=;
        b=Q93aXvTiT7/Nuaby+dCOgqxB4DbUiRhsGWJtdcyTmjoKE+RnZiQv4StLdlcVhg3c4+
         +C6RVz/EmcpRQwaNHk3miO89hu8VDzZQJvBDZV8c7GfRbUm0MvlXaI3g516WvDqcQqt5
         1sl+h4A/FyHrwyxN9KMZ9C2n8dhJ4vzFY8MImNedDbK0+8WZSmZGXKeNumERlFsFPqOR
         eQ8aGrA41ytuI/yjSNQCkUwN3KAQuG04WDY3S9zqhceUmqOuB5bZzESTKuvybupAleME
         BpJ1v24GtegZoRz1EtV1LoFC6fF5aanVOIxVS7xQtVKsfSI29PLZnIT6OgxJb35gvH8+
         N5jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:message-id:mime-version
         :subject:from:to:cc;
        bh=F4qSiyP6qNsDhBMqCUY6h5QJboOTRDoltedUrihSiWc=;
        b=jNlxY/l+d1+f3WTSAqIzr0cv/AhpxoXzRy+nq2u8GaSq0dZF/N1P2WMeWBm53ngPAZ
         KMPcWyEAkLanjGj8+nju2aocRLBliCmI8L7XfG6MO5Xx7+ZNp+CDahvWUnBbgTcrfM93
         lWk7ceKmvqrfSHqzLodMUJNR2nPgsQECMfop2ZCmNo58+phxsWmoFziqvw+ZdpogWbuZ
         wdRzgf81Akq6J/Ms2uGAuGtUJXge+l5cnilo3AMISWNqAgUthyNNjT/QGJNCWKV8vZNK
         65seamGqzkSm2EbSGogqE02qTTs6QKO0R2WZ5OT/CEWC8pR6Hg/Em4LH02mYUvduzMkq
         p5FQ==
X-Gm-Message-State: AOAM532EB9DeTe0ZkZcKXlH71CVxnrKtVKVmEQBTgUADdyufUf7NtiJA
        4zU1G4jT7TIuPzl9polnLcFCa4tc9Ls=
X-Google-Smtp-Source: ABdhPJzp4A3W1q3Tqhar2/Evi1HCTQ5/uUoQIM/i7LHvbvw5BJaOYCPfssOfhCcdTCa/dJEeGjj4v/SjFps=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
 (user=seanjc job=sendgmr) by 2002:a05:6902:20a:: with SMTP id
 j10mr21842753ybs.293.1610748240590; Fri, 15 Jan 2021 14:04:00 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 15 Jan 2021 14:03:52 -0800
Message-Id: <20210115220354.434807-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH 0/2] KVM: VMX: Avoid RDMSRs in PI x2APIC checks
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, luferry <luferry@163.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resurrect a patch[*] from over a year ago to avoid RDMSR in a fairly hot
path in KVM's posted interrupt support.  Note, in my response to that
patch, I suggested checking x2apic_supported() as well as x2apic_mode.  I
have no idea why I suggested that; unless I'm missing something,
x2apic_mode can never be set if x2apic_supported() is false.

[*] https://lkml.kernel.org/r/20190723130608.26528-1-luferry@163.com/

Sean Christopherson (2):
  x86/apic: Export x2apic_mode for use by KVM in "warm" path
  KVM: VMX: Use x2apic_mode to avoid RDMSR when querying PI state

 arch/x86/kernel/apic/apic.c    | 1 +
 arch/x86/kvm/vmx/posted_intr.c | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

-- 
2.30.0.284.gd98b1dd5eaa7-goog

