Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 047AD297F9C
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 02:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1763085AbgJYA1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 20:27:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41180 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1763073AbgJYA1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 20:27:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603585671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=iOSUoowuEp25G04aIP7AbuswglFDkH8pCpq/5LlyW/Y=;
        b=IaB6bybFqpykhC9hTlCmXPoUjgZZPPDwCi0GH0oeakx+KqrMbWs1QK8lKGCpaMRlwPZuv3
        5hMCmymbhyQoHXCwqrPfnudSsBnZY6jAsYteH73Sp/XRArzHXLlUSbs51RXFXcPcCrsQv1
        EC/wOoz7eI6jDF6mDYMsuU6riokN4P4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-NV28RzB-OLCVaqiRnSNZ3g-1; Sat, 24 Oct 2020 20:27:47 -0400
X-MC-Unique: NV28RzB-OLCVaqiRnSNZ3g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 446665F9F3;
        Sun, 25 Oct 2020 00:27:46 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-35.bne.redhat.com [10.64.54.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 045AB5C1DA;
        Sun, 25 Oct 2020 00:27:43 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, will@kernel.org,
        alexandru.elisei@arm.com, maz@kernel.org
Subject: [PATCH 0/3] KVM: arm64: Failback on unsupported huge pages
Date:   Sun, 25 Oct 2020 11:27:36 +1100
Message-Id: <20201025002739.5804-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guest fails to boot when the memory is backed up by hugetlbfs regions,
which correspond to contiguous PMDs or PTEs. For example, the guest
fails to boot when its memory is backed up by 64KB hugetlbfs pages.

The first two patches are sorts of cleanup, not introducing any logical
changes. The last patch resolves the issue by fail the unsupported huge
page sizes back to nearby one. Ideally, we teach the stage-2 page table
to use contiguous mapping in this case, but the page-table walker doesn't
it well and needs some sort of reworks and I will do that in the future.

Gavin Shan (3):
  KVM: arm64: Check if 52-bits PA is enabled
  KVM: arm64: Don't map PUD huge page if it's not available
  KVM: arm64: Failback on unsupported huge page sizes

 arch/arm64/kvm/hyp/pgtable.c | 10 ++++++----
 arch/arm64/kvm/mmu.c         | 12 +++++++++++-
 2 files changed, 17 insertions(+), 5 deletions(-)

-- 
2.23.0

