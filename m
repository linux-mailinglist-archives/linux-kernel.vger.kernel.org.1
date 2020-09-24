Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE0E27734F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 15:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbgIXN71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 09:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728153AbgIXN7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 09:59:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6419EC0613D7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 06:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=dr6dZs3VFHA+kNUsKD0hzBTElVLKOQakCcBlV/ZNErM=; b=bBQO05VwDwAfaDqhekxajuofQQ
        bb+lb4i3TKVtAyCr2iKg1X8aUn1bdOY06BtcZKEUPCPJtazgELgC/vFbSI7vij62OU7cmoS4Lvp4J
        HeFUAy34D9c2sIi29BVo8WSJNoo9JaIHBXsP95f4sWbTsfn3hoxVg4re0K37rJI6FFIX4dKQNQ4qi
        wfy/IU/xQP3fhkdpdco0xb2XcZ5VH/JIoM+BRD8a3NgAFOiUbXH1CBYUN6/Wme9eQ0VGwp1cdaydU
        G8A1Rfo80MP8zwb3Qv4JgG75vxpJs/kFWWto8tgyBgmVyD0urYVmuY8SbsxiVEvcP/dgcqoII8P4f
        gsCE6STw==;
Received: from p4fdb0c34.dip0.t-ipconnect.de ([79.219.12.52] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kLRlu-0003uT-GF; Thu, 24 Sep 2020 13:58:54 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nitin Gupta <ngupta@vflare.org>, x86@kernel.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-mm@kvack.org
Subject: remove alloc_vm_area v2
Date:   Thu, 24 Sep 2020 15:58:42 +0200
Message-Id: <20200924135853.875294-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

this series removes alloc_vm_area, which was left over from the big
vmalloc interface rework.  It is a rather arkane interface, basicaly
the equivalent of get_vm_area + actually faulting in all PTEs in
the allocated area.  It was originally addeds for Xen (which isn't
modular to start with), and then grew users in zsmalloc and i915
which seems to mostly qualify as abuses of the interface, especially
for i915 as a random driver should not set up PTE bits directly.

Note that the i915 patches apply to the drm-tip branch of the drm-tip
tree, as that tree has recent conflicting commits in the same area.

A git tree is also available here:

    git://git.infradead.org/users/hch/misc.git alloc_vm_area

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/alloc_vm_area

Changes since v1:
 - fix a bug in the zsmalloc changes
 - fix a bug and rebase to include the recent changes in i915
 - add a new vmap flag that allows to free the page array and pages
   using vfree
 - add a vfree documentation updated from Matthew

Diffstat:
 arch/x86/xen/grant-table.c                |   27 ++++--
 drivers/gpu/drm/i915/Kconfig              |    1 
 drivers/gpu/drm/i915/gem/i915_gem_pages.c |  131 +++++++++++++-----------------
 drivers/gpu/drm/i915/gt/shmem_utils.c     |   76 ++++-------------
 drivers/xen/xenbus/xenbus_client.c        |   30 +++---
 include/linux/vmalloc.h                   |    7 -
 mm/Kconfig                                |    3 
 mm/memory.c                               |   16 ++-
 mm/nommu.c                                |    7 -
 mm/vmalloc.c                              |  123 ++++++++++++++--------------
 mm/zsmalloc.c                             |   10 +-
 11 files changed, 200 insertions(+), 231 deletions(-)
