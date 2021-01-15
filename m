Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 423102F8821
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 23:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbhAOWEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 17:04:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbhAOWEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 17:04:46 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DBFC061798
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 14:04:03 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id j24so9017259qvg.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 14:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=945mZt11W/e1Cpr0kux35fc/oPlYVUnDMXl7cGh3YTM=;
        b=Yr1kAU4CG074m4dxfzKdbDRb4kKVYmOtLuUvFV4BkhGqFcrk+mQDMyPPg5uboFJ3Am
         wsLXuIay1J8LcDKkxThYDs+tX/wrEnaCXYHI2XtodoBK8qftJCm97N0mNUrrY3hBaL3a
         la48DizDpshlWYMoedKHESMVL/q/JXWPGrhZw+Jg+k+QPzfg96oT0B85TtwjTJGW1rNC
         n5o8DEmkzot0v9Ikh7XVZuH6yJWEFyCW7D8lAbNj7Y7ydcwPUtVeQ5drOj04QtMExVuU
         KUST7RwIFuHGmsLYMpFxRZgRs6Zjt4C8bZUDu38neVfW+UUqr/Hi97D+myZidRsO9JK/
         NP0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=945mZt11W/e1Cpr0kux35fc/oPlYVUnDMXl7cGh3YTM=;
        b=rJ3K5P93X2q0vzIQ9mnmuG+7/RVqn9ayZCt3PpnO1OQ2StOSgtP8i/FsPU8BF0XUIi
         7ADLmThi0WKu4Mf9CbJGI00WjVjE833eKvBqCGx+ekk7t+g+YiMLbBL/952YUSzH/NkE
         YuunsXSEIAvfK1C8lJcuk9wo6zuT4AMPCRT0OTIrxeczZ8mqDu2ubJQU6EpqdxSs0ckO
         t+vffXaoQShi//tUkBw0EMk2zJ1jgsV8sSXfMAfk078nBCxaAAK/PBcS5zC8T7y4oA52
         RO/JIWbZa9PcaJJfJrK73Ykcgeqjd4LCd+rIFJtbBao8klhrcKYOdeVuQZYfOPiT5ZMG
         xbRg==
X-Gm-Message-State: AOAM531QUW/pr4TQW52QfyHk3KrjbqX2p37XLbttCgTPvOPco+aHrDm0
        U4PLlmmxIvrgLDNgF/SCwCAZnXH4Gm4=
X-Google-Smtp-Source: ABdhPJyt07jGMmHQFCoFeqGCZ1Bu0ZBh9pKPci86yZRNoZyB2kLRYs8TpCw2UxNarA98HdV3SjMy8aXFUys=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
 (user=seanjc job=sendgmr) by 2002:ad4:4431:: with SMTP id e17mr13861250qvt.21.1610748242838;
 Fri, 15 Jan 2021 14:04:02 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 15 Jan 2021 14:03:53 -0800
In-Reply-To: <20210115220354.434807-1-seanjc@google.com>
Message-Id: <20210115220354.434807-2-seanjc@google.com>
Mime-Version: 1.0
References: <20210115220354.434807-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH 1/2] x86/apic: Export x2apic_mode for use by KVM in "warm" path
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

Export x2apic_mode so that KVM can query whether x2APIC is active
without having to incur the RDMSR in x2apic_enabled().  When Posted
Interrupts are in use for a guest with an assigned device, KVM ends up
checking for x2APIC at least once every time a vCPU halts.  KVM could
obviously snapshot x2apic_enabled() to avoid the RDMSR, but that's
rather silly given that x2apic_mode holds the exact info needed by KVM.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/apic/apic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 6bd20c0de8bc..dea2b44966ca 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1743,6 +1743,7 @@ void apic_ap_setup(void)
 
 #ifdef CONFIG_X86_X2APIC
 int x2apic_mode;
+EXPORT_SYMBOL_GPL(x2apic_mode);
 
 enum {
 	X2APIC_OFF,
-- 
2.30.0.284.gd98b1dd5eaa7-goog

