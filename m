Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8E328696C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 22:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbgJGUxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 16:53:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26724 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728284AbgJGUxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 16:53:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602104028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kX1VG8a6zkuD/3E46MJcm8aBltfxr0Y3fuQzYvb2RnM=;
        b=RW79OtBBgNLIh8nFY2B1yJ9ZrdyaSOQwcmgPRncM/uNyHlqQ6gEyHrB9eX3FzJydwIOlD1
        5m6JCGkjTBJYOVTAlEMqRgDNlxdXcC1lIVbSImzBPv+FNfcgmHp4iF6BWUI7u9eUPtTxIz
        L81nuTw3n5KNK8uL1BXlWi9Vd1a1uT8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-536-ZzBPGzuuP965YcuTogSMCw-1; Wed, 07 Oct 2020 16:53:46 -0400
X-MC-Unique: ZzBPGzuuP965YcuTogSMCw-1
Received: by mail-qv1-f72.google.com with SMTP id w32so2190622qvw.8
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 13:53:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kX1VG8a6zkuD/3E46MJcm8aBltfxr0Y3fuQzYvb2RnM=;
        b=Eu4EesDzhYDVzhe8W/6ze7ZurPguNWxooTBLh5L2lSRVwhYkX238uXTpgXoHrxVbYi
         WnOZC3PEHpJQ1J1ReNsVkwz4AOQpnynKTFsSUv3mgMNTkfcA0Pzcep0Z4o9HjeNdh371
         fbt/bkS96+/9dlr44YB0R2kCOamJQ1kzYmgqwiqlhmnN0lmLIP8zqKIp1qRTfqR68MWT
         4bGB88bA8zKZdWkTmTH9/0Lce5Dt2/qrGkUV1AESekJqpqU4esXnaERqKhbkoY/kA+NO
         MpTwtIgtcHBo92heCoAepGArj9s02uOiG80h693DPMWh254Kj2x7aMYJt4j4YWrpCdbA
         BILQ==
X-Gm-Message-State: AOAM533QCxlYmx+vRbbw7RvdAUJmvTCC2WmP4l7YWQi0l4C5PDylFl7T
        dTmZy6Kojx7eFn1dzt3IEflfBZ6PSuBI4Mfjbwnm+IcbMf12ZchfjE2Lfc7sQFDi4rBHmRV6xh5
        nSsR5FXt+cTELTLGrx22THjb1
X-Received: by 2002:a37:a054:: with SMTP id j81mr4629824qke.23.1602104025800;
        Wed, 07 Oct 2020 13:53:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyL2cVzMVNA9GlSWo/fbUOzV8IgbQ37ZjN4M5sK55UpooCzprJA1mGC9Vb1RztHEuEaHNw97g==
X-Received: by 2002:a37:a054:: with SMTP id j81mr4629812qke.23.1602104025619;
        Wed, 07 Oct 2020 13:53:45 -0700 (PDT)
Received: from xz-x1.redhat.com (toroon474qw-lp140-04-174-95-215-133.dsl.bell.ca. [174.95.215.133])
        by smtp.gmail.com with ESMTPSA id j24sm2390695qkg.107.2020.10.07.13.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 13:53:45 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andrew Jones <drjones@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PATCH v14 01/14] KVM: Documentation: Update entry for KVM_X86_SET_MSR_FILTER
Date:   Wed,  7 Oct 2020 16:53:29 -0400
Message-Id: <20201007205342.295402-2-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201007205342.295402-1-peterx@redhat.com>
References: <20201007205342.295402-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It should be an accident when rebase, since we've already have section
8.25 (which is KVM_CAP_S390_DIAG318).  Fix the number.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 Documentation/virt/kvm/api.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 425325ff4434..136b11007d74 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6360,7 +6360,7 @@ accesses that would usually trigger a #GP by KVM into the guest will
 instead get bounced to user space through the KVM_EXIT_X86_RDMSR and
 KVM_EXIT_X86_WRMSR exit notifications.
 
-8.25 KVM_X86_SET_MSR_FILTER
+8.27 KVM_X86_SET_MSR_FILTER
 ---------------------------
 
 :Architectures: x86
-- 
2.26.2

