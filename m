Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB971C3F24
	for <lists+linux-kernel@lfdr.de>; Mon,  4 May 2020 17:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729578AbgEDP4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 May 2020 11:56:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53306 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729486AbgEDP4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 11:56:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588607763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=eX+GzNLLoLRdY/7Oo9fQjZpifFeDPG106etXnTI+oh4=;
        b=Fczfe/r+NwIA7oY0COu/wLtPWNQzZEQtvPLIDs9UswDQAfNydgm+wSZBOX1JxbaEIqgVdU
        7Zh10GemvR8bM0eS8agNpkMkO+kTwyAHYiXqSVi5LlyiMCv8xEkeRTfFyZojQ8aGDKqiqD
        2U+XxrEpdAdATeJ6Wl7gkjgpD5gulUE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-Hn7cpswBOnSw0swXlGpKDw-1; Mon, 04 May 2020 11:56:00 -0400
X-MC-Unique: Hn7cpswBOnSw0swXlGpKDw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 06585107AFD4;
        Mon,  4 May 2020 15:55:59 +0000 (UTC)
Received: from virtlab511.virt.lab.eng.bos.redhat.com (virtlab511.virt.lab.eng.bos.redhat.com [10.19.152.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8C1D96FF1A;
        Mon,  4 May 2020 15:55:58 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [PATCH 0/3] KVM: x86: cleanup and fixes for debug register accesses
Date:   Mon,  4 May 2020 11:55:55 -0400
Message-Id: <20200504155558.401468-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of this series is to get rid of the get_dr6 accessor
and, on Intel, of set_dr6 as well.  This is done mostly in patch 2,
since patch 3 is only the resulting cleanup.  Patch 1 is a related
bug fix that I found while inspecting the code.

A guest debugging selftest is sorely needed if anyone wants to take
a look!

Paolo

Paolo Bonzini (3):
  KVM: SVM: fill in kvm_run->debug.arch.dr[67]
  KVM: SVM: keep DR6 synchronized with vcpu->arch.dr6
  KVM: x86: simplify dr6 accessors in kvm_x86_ops

 arch/x86/include/asm/kvm_host.h |  1 -
 arch/x86/kvm/svm/svm.c          | 11 ++++-------
 arch/x86/kvm/vmx/vmx.c          | 11 -----------
 arch/x86/kvm/x86.c              |  8 +++-----
 4 files changed, 7 insertions(+), 24 deletions(-)

-- 
2.18.2

