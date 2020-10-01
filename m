Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6289427F718
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 03:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729996AbgJABUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 21:20:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38124 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725799AbgJABUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 21:20:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601515252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kX1VG8a6zkuD/3E46MJcm8aBltfxr0Y3fuQzYvb2RnM=;
        b=gyuUgxTTo7p5dDegyBKf3sSsdFi7icDW0X29+EfQy8ukSe2HVH9T2BnWf9aVJVtowJHL8w
        9H1jZ8DeTY7TNy4PiVMkQpABs4jqR3oxVjRXbGmtxDhdpYD7VxS3JDhOARWcye2FSr5xmV
        8aHRYmAI1PnODdCYd9fS4/MlZHQLERk=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-r6k0xZT_OCSMpnTejBhn-g-1; Wed, 30 Sep 2020 21:20:51 -0400
X-MC-Unique: r6k0xZT_OCSMpnTejBhn-g-1
Received: by mail-qt1-f199.google.com with SMTP id b39so2548255qta.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 18:20:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kX1VG8a6zkuD/3E46MJcm8aBltfxr0Y3fuQzYvb2RnM=;
        b=EWN9bsxs4bIyu4Idu/HUiT8DtDDnTGBVL2K0MuEvUWYuOPX86gMR6f/pw3507MZqTt
         STvrOv4l3atSu0dyTrk0N4wjj6mk2QhXW7nKArbuN2t0HimZe1m1x+5DMUno79vZomSf
         hdeMwWKzem8Bgty8wxP/zlmeRYMDmTdFiqt9qzgmalzHBYBs06rfpjMI/rwzeQdwtxDZ
         vHmZdc/2G0BtoGtCOBZ868EGL/wzdFAnNXwBRjEID3+I2GK3qtTIjLGzG3KFoh7IagjU
         hyU/6z+E6kXbc/qoRr/dgBGtK1nZYvL9wz7EPbhKCOV1fXo14hOEHg/XTCpJZVqX8ODH
         vrcg==
X-Gm-Message-State: AOAM5308lGxlA5WBy2rBGj6u82aNzfMbNw2RtAkt/JiLKDADs3Dl4dqV
        Qqz4szLXE2Ll03YDac7mh8Ix8Td5n7ryKum/ksrJtku5PIYm+26SpodxW1hQodGvmdIiMHdqAxt
        5kvWoTOHuHrwpzriVPvyoM1eM
X-Received: by 2002:aed:2767:: with SMTP id n94mr5503182qtd.237.1601515250589;
        Wed, 30 Sep 2020 18:20:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwexGjkpxAISmZJU5rHDeSyZUsxTAK15C0TBN2t67Ns3CGcsxJR+LE5yAdOAZa+v7XnrjZbYA==
X-Received: by 2002:aed:2767:: with SMTP id n94mr5503153qtd.237.1601515250368;
        Wed, 30 Sep 2020 18:20:50 -0700 (PDT)
Received: from localhost.localdomain (toroon474qw-lp130-09-184-147-14-204.dsl.bell.ca. [184.147.14.204])
        by smtp.gmail.com with ESMTPSA id y46sm4714478qtc.30.2020.09.30.18.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 18:20:49 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v13 01/14] KVM: Documentation: Update entry for KVM_X86_SET_MSR_FILTER
Date:   Wed, 30 Sep 2020 21:20:31 -0400
Message-Id: <20201001012044.5151-2-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201001012044.5151-1-peterx@redhat.com>
References: <20201001012044.5151-1-peterx@redhat.com>
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

