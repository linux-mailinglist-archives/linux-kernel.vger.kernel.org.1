Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 001AD301182
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 01:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726288AbhAWAQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 19:16:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbhAVXvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 18:51:48 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B912C06178B
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 15:50:59 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 67so7094394ybh.22
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 15:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=3POhTHexc6LhDaubtjgYfatSABcmeOtOygjcnj4BcAk=;
        b=pryGpbyDnNOlGkYMhi2UiMqUHCC/6GQrKj10KF3gt440WMZK53ART6IIrsh+WVazvJ
         yGNW9MIybtRzmL1HlgL2Co1zBKOMJOQOBvMcGsekWCeR8mb4cLqOrIyNpQy4W8nU/fr9
         hymtvZgOXTRTfKcVSCAoWdQWlmQIrfrOtVGHmyxr/ag24AGO9ZKJiEOmvU3aBArQQMf4
         dAYzd5myoRnm2qmPqCIKk0KPYkA2m8AMgsLEopGXzaxJolosOwcQV3f59f3Zv9/wv1BQ
         7DhWRyy/gtiNuGi1LYheMQmr+kvzS0LENiposnKznX/dxvLn7omnUJvTuZji4pdjFcwW
         Jtgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:message-id:mime-version
         :subject:from:to:cc;
        bh=3POhTHexc6LhDaubtjgYfatSABcmeOtOygjcnj4BcAk=;
        b=Swv5stuiDjJhHQzwbJxJN+Ssmi15QphaJQ+iwV0Xzt29JSwc3VwzMSu1rUUNHD2Feu
         NEg2UyChdN6Xttx7DRHeqLKDMPSyyB23FjBqBXiwKu5SJr2vD7KhNfcZBi2srVUgrHk6
         cAMlxqX+LOJ/5EoXD/c9XOvH13/hrd9N45dXJ601VuBDO5I6PJL4328jWVug/LMFZyUR
         hYryGqz1cFLBlpLg6JdthDOmjGP4X2g9T32pvapKJ7kS0n4e0b90aPQHc8rjL/AnXLZ2
         TjUXLRxkrBNIMm/bPhFh5iwuWrrThEpMuzHVG7k7IE2Ko03sBrtLDO9ElOFPso2SmwY5
         TaqQ==
X-Gm-Message-State: AOAM5314snU1FsJcjl0GFM16O5bZWVt8ozTM2Tl+GJNf+/eTXTXgW3sH
        4S2xYtn0HRC8z6XPW2D1oRijCT5FRgs=
X-Google-Smtp-Source: ABdhPJwRa6A+ByMCfzsyYm3rJ5xGzonineYxYMTISwqJkhK1O0xoGicNKm02GnIcwVQOJd8axJMihD0A/gg=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
 (user=seanjc job=sendgmr) by 2002:a25:a0d4:: with SMTP id i20mr10015259ybm.182.1611359458330;
 Fri, 22 Jan 2021 15:50:58 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 22 Jan 2021 15:50:46 -0800
Message-Id: <20210122235049.3107620-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH 0/3] KVM: x86: Revert dirty tracking for GPRs
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is effectively belated feedback on the SEV-ES series.  My primary
interest is to revert the GPR dirty/available tracking, as it's pure
overhead for non-SEV-ES VMs, and even for SEV-ES I suspect the dirty
tracking is at best lost in the noise, and possibly even a net negative.

My original plan was to submit patches 1+3 as patch 1, taking a few
creative liberties with the GHCB spec to justify writing the GHCB GPRs
after every VMGEXIT.  But, since KVM is effectively writing the GHCB GPRs
on every VMRUN, I feel confident in saying that my interpretation of the
spec has already been proven correct.

The SEV-ES changes are effectively compile tested only, but unless I've
overlooked a code path, patch 1 is a nop.  Patch 3 definitely needs
testing.

Paolo, I'd really like to get patches 1 and 2 into 5.11, the code cost of
the dirty/available tracking is not trivial.

Sean Christopherson (3):
  KVM: SVM: Unconditionally sync GPRs to GHCB on VMRUN of SEV-ES guest
  KVM: x86: Revert "KVM: x86: Mark GPRs dirty when written"
  KVM: SVM: Sync GPRs to the GHCB only after VMGEXIT

 arch/x86/kvm/kvm_cache_regs.h | 51 +++++++++++++++++------------------
 arch/x86/kvm/svm/sev.c        | 14 +++++-----
 arch/x86/kvm/svm/svm.h        |  1 +
 3 files changed, 34 insertions(+), 32 deletions(-)

-- 
2.30.0.280.ga3ce27912f-goog

