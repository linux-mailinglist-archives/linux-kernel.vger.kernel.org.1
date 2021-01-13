Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8332F5454
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 21:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbhAMUvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 15:51:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728856AbhAMUvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 15:51:15 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E21AC061795
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 12:50:35 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id x19so2566246qvv.16
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 12:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=aIUBOyJyX6WGyseukIAcch3nn35rSww3/Zr/HwJ5908=;
        b=X46oEX+TtT0/gQq1+bgCMAGs5q+1p1nbBc5zmdukXctlvH4UtROQqOzXceid7TJNTu
         kyXXTX6tncyk3hxvujy/iyyVN4QcvZVqz9Ff/t7884507h2CcrZG99Qh7L5U9hFWnBEM
         p2T0UjyYtTsOq/O3JVLPMzJ46Be7mqYvRWwEKbOwDA9kgOnKQ2u0sAiQT/RkXj+LMmvi
         6dL4/+ctx1S3OZlfE5mxMgg9uAvMp82HbV08QrtHenL0NuGmPF05sLE3jYH1OY6q6yL9
         GvdecP8BRSOMRK0al+gWw/03Ja6TgBa3ksLeHvCVcztk6qd4SHkeguOWKFs1SzklcDim
         RSfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:message-id:mime-version
         :subject:from:to:cc;
        bh=aIUBOyJyX6WGyseukIAcch3nn35rSww3/Zr/HwJ5908=;
        b=kHMoloydzZ09c72drP7BFypMBYagj0ekBJW/Ss7OPTCZlYE7MvPRzStUA42O2LSF7u
         j2o2bp9AI4FYJy1TtOxDhI8gig4vZFiOFqKsmbMqwpy7gsQ/OJ2rO639KD09LN8cClUr
         12dbsNdU25fBrdj9IqNGMSLDvJ/rK2xWrWEQjP+zsP5FIGVCRFGPqHMyiPylKsu2Q28N
         svQTkxYy4AhwmLs1KGsCpV5B/w1Hn8lBYzuxZUfL6XWvZ/r3FQV92U91vaxMzajHVWFA
         +OCSdxaR2Acf2D5JFR8090DBU7iUByM7e4hhdCz7ViLom/wzjR5/Ml3m/g09NmG4B8t3
         0m8g==
X-Gm-Message-State: AOAM532xJYjwBjqTeU9Gt+fZp2Ki7xW7QRcVt7yxcVkOnzqq/Ka9NEQz
        j1hqP/DAc2CtswiZpNbfpKV8VXW9Ya4=
X-Google-Smtp-Source: ABdhPJwlo3gK+jvvCcXXwYoVkAhwO/EjVIRBiIUBMoTWB4pnwbc/n6HoZoeY/is8j0V6z8lDlU3WyBETvSY=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
 (user=seanjc job=sendgmr) by 2002:a25:d60a:: with SMTP id n10mr6327286ybg.457.1610571034135;
 Wed, 13 Jan 2021 12:50:34 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 13 Jan 2021 12:50:30 -0800
Message-Id: <20210113205030.3481307-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH] KVM: x86: Zap the oldest MMU pages, not the newest
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zdenek Kaspar <zkaspar82@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Walk the list of MMU pages in reverse in kvm_mmu_zap_oldest_mmu_pages().
The list is FIFO, meaning new pages are inserted at the head and thus
the oldest pages are at the tail.  Using a "forward" iterator causes KVM
to zap MMU pages that were just added, which obliterates guest
performance once the max number of shadow MMU pages is reached.

Fixes: 6b82ef2c9cf1 ("KVM: x86/mmu: Batch zap MMU pages when recycling oldest pages")
Reported-by: Zdenek Kaspar <zkaspar82@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 6d16481aa29d..ed861245ecf0 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2417,7 +2417,7 @@ static unsigned long kvm_mmu_zap_oldest_mmu_pages(struct kvm *kvm,
 		return 0;
 
 restart:
-	list_for_each_entry_safe(sp, tmp, &kvm->arch.active_mmu_pages, link) {
+	list_for_each_entry_safe_reverse(sp, tmp, &kvm->arch.active_mmu_pages, link) {
 		/*
 		 * Don't zap active root pages, the page itself can't be freed
 		 * and zapping it will just force vCPUs to realloc and reload.
-- 
2.30.0.284.gd98b1dd5eaa7-goog

