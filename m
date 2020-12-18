Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 688982DDC65
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 01:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbgLRAcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 19:32:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgLRAce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 19:32:34 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C0DC0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 16:31:54 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id o65so526071qkc.21
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 16:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=2tzta+SNMsYxKKonR8VaQ9Msx9ezDvobAtQZxP1CmTo=;
        b=amSSz5zGcCHdNrtCi5FrIruhHpn5OoUl6IA1/X5JxM4N7MvhDZqrXJM2eyE1xgR8Rr
         2QaQDE8gdcMULMMy6eI97mlfZY1x2Bspoba0n9tpQJ/S3IHiVUSz51ZWcN/+iUgAFwUI
         1DhsZWhpwetS7/vedXEQ4ILtQYKUVeHMfJNWvXviUwWirkQw6fXeP5iWOcZ6bn5KoQra
         T+d6Q/TwEw+2FMgQ8SJFBZvemoXfGI/t6hZJkw3+NNSrTy5l+KYoKENttqfPB+d2ixgZ
         UV6fdyoL7wn5XxXyBBukMU2qMPBhzHmOn/Wfupuci1GTBphgBB8GXVJxjtVlsXgIUHrj
         ueSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:message-id:mime-version
         :subject:from:to:cc;
        bh=2tzta+SNMsYxKKonR8VaQ9Msx9ezDvobAtQZxP1CmTo=;
        b=sdzZwghkPmFcfP24VAgtihOJueWkyuTgIlOwj1QxuJyCD/tmWPCbQa8UFn/itZUp0p
         eiQ1EdwHcCenRY13/DHBKmvlYQar/brGUZzxJuJeHM4n+7vAChv3iurviJmaHdXoyDAq
         jQi6N1BBdmXtMGhk+WwvdJjv7+RN0BlxKOIO4qyAooQqxYphRv5R8mvg5DCc9sd+VHHC
         Fw7ohzI71BxYk0F0hYTI0crY07Mji7PAJM2CoCwsMYt8T1df7Y64E5fhGxT/ayzm6iM0
         cICzZ1YM2bFF9lfwdu+48dKkyfw3ljfvBcuaImpO3t3DaDcC3tWR8RfBvYLIi/gcHxTx
         YEzA==
X-Gm-Message-State: AOAM531FV5t4O7/Dx+07XL0wqhGPUVRxrWun2lJ+l6VuDAjfDyNsQymV
        nUl123B6cKdHqEQ+2dDmmFviyDiP0/4=
X-Google-Smtp-Source: ABdhPJyP8JnZK9FrE2u34potBYnzNLsxVsqEiU4W380aT+tsp9or0rO/5iX8TOjLzl9M1V6ApI50oqRNUWk=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
 (user=seanjc job=sendgmr) by 2002:a05:6214:184a:: with SMTP id
 d10mr1855912qvy.41.1608251511737; Thu, 17 Dec 2020 16:31:51 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 17 Dec 2020 16:31:35 -0800
Message-Id: <20201218003139.2167891-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
Subject: [PATCH 0/4] KVM: x86/mmu: Bug fixes and cleanups in get_mmio_spte()
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        Richard Herbert <rherbert@sympatico.ca>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two fixes for bugs that were introduced along with the TDP MMU (though I
strongly suspect only the one reported by Richard, fixed in patch 2/4, is
hittable in practice).  Two additional cleanup on top to try and make the
code a bit more readable and shave a few cycles.

Sean Christopherson (4):
  KVM: x86/mmu: Use -1 to flag an undefined spte in get_mmio_spte()
  KVM: x86/mmu: Get root level from walkers when retrieving MMIO SPTE
  KVM: x86/mmu: Use raw level to index into MMIO walks' sptes array
  KVM: x86/mmu: Optimize not-present/MMIO SPTE check in get_mmio_spte()

 arch/x86/kvm/mmu/mmu.c     | 53 +++++++++++++++++++++-----------------
 arch/x86/kvm/mmu/tdp_mmu.c |  9 ++++---
 arch/x86/kvm/mmu/tdp_mmu.h |  4 ++-
 3 files changed, 39 insertions(+), 27 deletions(-)

-- 
2.29.2.684.gfbc64c5ab5-goog

