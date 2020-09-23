Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E019275057
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 07:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgIWFiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 01:38:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60153 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726557AbgIWFiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 01:38:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600839482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=AWly0ilRyHNMx59EHle9D7GrnEZiki/CeTo/mTEpggU=;
        b=eWs9PAO2Tq+xa9nmz+JhPHmDVoHC9f6VJKWf2IlIgvYG9UYwTE1G9FVJcOVYYDNLj7paCM
        xPwhMoPRorPy83qbNIhf+IM1DgL1MoySZ2cboy5HAOBDVXQq9x7PChZdjnAb7POmSEOoyR
        ZxvCZbKSzyZvvX7Rr+EOv6kI0Yg0l0M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-3ZYCPuFQNVWQzeAXqzyWDw-1; Wed, 23 Sep 2020 01:37:58 -0400
X-MC-Unique: 3ZYCPuFQNVWQzeAXqzyWDw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A881780ED92;
        Wed, 23 Sep 2020 05:37:56 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-30.bne.redhat.com [10.64.54.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7511319C4F;
        Wed, 23 Sep 2020 05:37:54 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        anshuman.khandual@arm.com, robin.murphy@arm.com, will@kernel.org,
        catalin.marinas@arm.com, shan.gavin@gmail.com
Subject: [PATCH v2 0/2] arm64/mm: Enable color zero pages
Date:   Wed, 23 Sep 2020 15:37:19 +1000
Message-Id: <20200923053721.28873-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The feature of color zero pages isn't enabled on arm64, meaning all
read-only (anonymous) VM areas are backed up by same zero page. It
leads pressure to L1 (data) cache on reading data from them. This
tries to enable color zero pages.

PATCH[1/2] decouples the zero PGD table from zero page
PATCH[2/2] allocates the needed zero pages according to L1 cache size

Changelog
=========
v2:
   * Rebased to 5.9.rc6                                      (Gavin)
   * Retrieve cache topology from ACPI/DT                    (Will/Robin)

Gavin Shan (2):
  arm64/mm: Introduce zero PGD table
  arm64/mm: Enable color zero pages

 arch/arm64/include/asm/cache.h       |  3 ++
 arch/arm64/include/asm/mmu_context.h |  6 +--
 arch/arm64/include/asm/pgtable.h     | 11 ++++-
 arch/arm64/kernel/cacheinfo.c        | 67 ++++++++++++++++++++++++++++
 arch/arm64/kernel/setup.c            |  2 +-
 arch/arm64/kernel/vmlinux.lds.S      |  4 ++
 arch/arm64/mm/init.c                 | 37 +++++++++++++++
 arch/arm64/mm/mmu.c                  |  7 ---
 arch/arm64/mm/proc.S                 |  2 +-
 drivers/base/cacheinfo.c             |  3 +-
 include/linux/cacheinfo.h            |  6 +++
 11 files changed, 132 insertions(+), 16 deletions(-)

-- 
2.23.0

