Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0727B26BA97
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 05:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgIPD0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 23:26:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57647 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726023AbgIPD0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 23:26:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600226780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=e4bgxQP4B7QtaCDMwhSwARF+1WVDn2Gcajs7TrsJlRA=;
        b=iOT2cXXp304s8Odz6AMUO/UOqsgvhSJvl1XAQX5A2Zg71U16ZYViFwjaH1oQ+dLcgUUnbM
        Rqp4mAVuFo9YkVy7oHSB84ZonAXGYF9zUHWmGqOuCYTfirhaCwiseTumENi5rKC7JRuP8W
        fPGxC0RadrAOdmq0RjZNlCjO4NDeBe0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-omx1aBdgP6CNaJOGs-GbfQ-1; Tue, 15 Sep 2020 23:26:18 -0400
X-MC-Unique: omx1aBdgP6CNaJOGs-GbfQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF1481891E80;
        Wed, 16 Sep 2020 03:26:16 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-108.bne.redhat.com [10.64.54.108])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 62F667BE49;
        Wed, 16 Sep 2020 03:26:14 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     mark.rutland@arm.com, anshuman.khandual@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        linux-kernel@vger.kernel.org, shan.gavin@gmail.com
Subject: [PATCH 0/2] arm64/mm: Enable color zero pages
Date:   Wed, 16 Sep 2020 13:25:21 +1000
Message-Id: <20200916032523.13011-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The feature of color zero pages isn't enabled on arm64, meaning all
read-only (anonymous) VM areas are backed up by same zero page. It
leads pressure to L1 (data) cache on reading data from them. This
tries to enable color zero pages.

PATCH[1/2] decouples the zero PGD table from zero page
PATCH[2/2] allocates the needed zero pages according to L1 cache size

Gavin Shan (2):
  arm64/mm: Introduce zero PGD table
  arm64/mm: Enable color zero pages

 arch/arm64/include/asm/cache.h       | 22 +++++++++++++++++
 arch/arm64/include/asm/mmu_context.h |  6 ++---
 arch/arm64/include/asm/pgtable.h     | 11 +++++++--
 arch/arm64/kernel/cacheinfo.c        | 34 +++++++++++++++++++++++++++
 arch/arm64/kernel/setup.c            |  2 +-
 arch/arm64/kernel/vmlinux.lds.S      |  4 ++++
 arch/arm64/mm/init.c                 | 35 ++++++++++++++++++++++++++++
 arch/arm64/mm/mmu.c                  |  7 ------
 arch/arm64/mm/proc.S                 |  2 +-
 9 files changed, 109 insertions(+), 14 deletions(-)

-- 
2.23.0

