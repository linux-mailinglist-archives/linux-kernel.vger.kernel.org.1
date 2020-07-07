Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06AFA216613
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 07:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgGGF7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 01:59:32 -0400
Received: from foss.arm.com ([217.140.110.172]:49912 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727827AbgGGF7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 01:59:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04F4431B;
        Mon,  6 Jul 2020 22:59:32 -0700 (PDT)
Received: from localhost.localdomain (entos-thunderx2-02.shanghai.arm.com [10.169.212.213])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 486023F68F;
        Mon,  6 Jul 2020 22:59:27 -0700 (PDT)
From:   Jia He <justin.he@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nvdimm@lists.01.org,
        Kaly Xin <Kaly.Xin@arm.com>, Jia He <justin.he@arm.com>
Subject: [PATCH v2 0/3] Fix and enable pmem as RAM device on arm64
Date:   Tue,  7 Jul 2020 13:59:14 +0800
Message-Id: <20200707055917.143653-1-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fix a few issues when I tried to enable pmem as RAM device on arm64.

Tested on ThunderX2 host/qemu "-M virt" guest with a nvdimm device. The 
memblocks from the dax pmem device can be either hot-added or hot-removed
on arm64 guest.

Changes:
v2: - Drop unneccessary patch to harden try_offline_node
    - Use new solution(by David) to fix dev->target_node=-1 during probing
    - Refine the mem_hotplug_begin/done patch

v1: https://lkml.org/lkml/2020/7/5/381

Jia He (3):
  arm64/numa: export memory_add_physaddr_to_nid as EXPORT_SYMBOL_GPL
  device-dax: use fallback nid when numa_node is invalid
  mm/memory_hotplug: fix unpaired mem_hotplug_begin/done

 arch/arm64/mm/numa.c |  5 +++--
 drivers/dax/kmem.c   | 22 ++++++++++++++--------
 mm/memory_hotplug.c  |  5 ++---
 3 files changed, 19 insertions(+), 13 deletions(-)

-- 
2.17.1

