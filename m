Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7126F2C63CE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 12:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728941AbgK0LVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 06:21:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42161 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725889AbgK0LVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 06:21:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606476078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=TFopWmrISNwds4exxKn1UKy4OMpKOwgTBLOgK+CrW5U=;
        b=VGVqNwiMcuUExXyjqcXU9c30q2JfUfhSWJ68ZHg+SVSq66vviyuADi/A+G9swAnfHQ4Xpl
        PK4KcaOYaEWfXJ0T2EMHy3ROQmlX8nZ9nfiaYs6xRuuhWSG5oVAaeSDcwpzo+KogpDOdx/
        DGYCvyVLToLDZK+Vbl+TGRrvK3q0RVE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-517-c1VOEJhHMfGykp8joBBrvw-1; Fri, 27 Nov 2020 06:21:16 -0500
X-MC-Unique: c1VOEJhHMfGykp8joBBrvw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1408F1006C96;
        Fri, 27 Nov 2020 11:21:15 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8D09C5D6D1;
        Fri, 27 Nov 2020 11:21:14 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     seanjc@google.com, Filippo Sironi <sironi@amazon.de>
Subject: [PATCH 0/2] KVM: x86: cleanup and fix userspace interrupt window
Date:   Fri, 27 Nov 2020 06:21:12 -0500
Message-Id: <20201127112114.3219360-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is my take on the split irqchip bug that David reported.  It's a
much more complicated patch, but I think it really gets to the bottom
of the issue and the code is clearer.

Paolo

Paolo Bonzini (2):
  KVM: x86: handle !lapic_in_kernel case in kvm_cpu_*_extint
  KVM: x86: Fix split-irqchip vs interrupt injection window request

 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/irq.c              | 87 +++++++++++++--------------------
 arch/x86/kvm/lapic.c            |  2 +-
 arch/x86/kvm/x86.c              | 17 +++----
 4 files changed, 44 insertions(+), 63 deletions(-)

-- 
2.28.0

