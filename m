Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B73C270260
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 18:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgIRQj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 12:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbgIRQj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 12:39:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD22C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 09:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=kbkCOaAVGW2W0qtF3ILC2dY2YuGuU78+gf+gMb7gwmg=; b=kW/m5vnUNR9hH31GcXuVcpd9j2
        YA6VaBH1j/TiUI3s10h53oQiEx5bSqjcpwY8JemDJbytieos8zt+gRB1FpEaZE9ZsAKzL4LQC0jza
        iqqFAttfNNTd4/5l8lRTxiHEru6CjyH/WYZRSvfVriw/iqmEjMdx7BgGWHp8bWD5i5kx+iWa6kL8H
        gBcyIRucV67OIH/x5iE4iVZODxkkwqs3zdZ+XmOdUAkQoickM8doXsxt/7EZ+p93DBYP3QdoVQtAN
        2milUFpS2U5fzp8jyoapCmfH59wTxVZclqKH1diAZY87+wVGYpDlWdBfpnNKB0VdioTh1sC8mAgnG
        JPit0e+w==;
Received: from 089144214092.atnat0023.highway.a1.net ([89.144.214.92] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kJJQ7-00071w-B7; Fri, 18 Sep 2020 16:39:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>, x86@kernel.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-mm@kvack.org
Subject: remove alloc_vm_area
Date:   Fri, 18 Sep 2020 18:37:18 +0200
Message-Id: <20200918163724.2511-1-hch@lst.de>
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

Note that my laptop doesn't seem to actually exercise the new vmap_pfn
path, so careful review from the i915 maintainers is very welcome.

Also I wonder why zsmalloc is even doing the manual allocation of kernel
virtual address space plus mapping into it.  IMHO zsmalloc should be
using our normal vm_map_ram / vm_unmap_ram interface instead of being so
special, which would also allow building it as a module again for the
virtual mapping case.

Diffstat:
 arch/x86/xen/grant-table.c                |   27 +++++---
 drivers/gpu/drm/i915/Kconfig              |    1 
 drivers/gpu/drm/i915/gem/i915_gem_pages.c |  101 +++++++++++++-----------------
 drivers/gpu/drm/i915/gt/shmem_utils.c     |   90 +++++++++++---------------
 drivers/xen/xenbus/xenbus_client.c        |   30 ++++----
 include/linux/vmalloc.h                   |    6 -
 mm/Kconfig                                |    3 
 mm/nommu.c                                |    7 --
 mm/vmalloc.c                              |   93 +++++++++++++--------------
 mm/zsmalloc.c                             |    2 
 10 files changed, 172 insertions(+), 188 deletions(-)
