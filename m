Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0272F7E4C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 15:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732045AbhAOOcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 09:32:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:59790 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbhAOOcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 09:32:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610721115; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=H7N+SEhZ45fsxR0kXGVHPeygiOlR6ozuZnfFEqaXE/o=;
        b=IbFbn6E0VQ1JIr0FGb+1L05H4+AkRIjBZzzCkCLlow8Uk6C/6W9NQTMYW3ZkfSipHw0aa7
        hGh3wt6nwAlyZfA7vljN75khYuoBMxLr1eqm7MHw6A6XxbZajWkeFGBCPcIqG8vLy5QQ8f
        PfSpNFyqca3Mr/Xu97n0Dqu9rnm7ibA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0A70BB168;
        Fri, 15 Jan 2021 14:31:55 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: branch for v5.11-rc4
Date:   Fri, 15 Jan 2021 15:31:54 +0100
Message-Id: <20210115143154.30095-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.11-rc4-tag

xen: branch for v5.11-rc4

It contains:

- A series for fixing a regression when running as a fully virtualized
  guest on an old Xen hypervisor not supporting PV interrupt callbacks
  for HVM guests.

- A patch for adding support to query Xen resource sizes (setting was
  possible already) from user mode.


Thanks.

Juergen

 Documentation/admin-guide/kernel-parameters.txt |  4 ++
 arch/arm/xen/enlighten.c                        |  2 +-
 arch/x86/xen/enlighten_hvm.c                    | 15 ++++-
 arch/x86/xen/smp_hvm.c                          | 27 ++++++---
 drivers/xen/events/events_base.c                | 10 ---
 drivers/xen/platform-pci.c                      |  8 ++-
 drivers/xen/privcmd.c                           | 25 ++++++--
 drivers/xen/xenbus/xenbus.h                     |  1 +
 drivers/xen/xenbus/xenbus_comms.c               |  8 ---
 drivers/xen/xenbus/xenbus_probe.c               | 81 ++++++++++++++++++++-----
 include/xen/xenbus.h                            |  2 +-
 11 files changed, 129 insertions(+), 54 deletions(-)

David Woodhouse (5):
      xen: Fix event channel callback via INTX/GSI
      xen: Set platform PCI device INTX affinity to CPU0
      x86/xen: Add xen_no_vector_callback option to test PCI INTX delivery
      x86/xen: Don't register Xen IPIs when they aren't going to be used
      x86/xen: Fix xen_hvm_smp_init() when vector callback not available

Roger Pau Monne (1):
      xen/privcmd: allow fetching resource sizes
