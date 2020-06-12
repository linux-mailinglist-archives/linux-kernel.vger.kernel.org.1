Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE7F1F738F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jun 2020 07:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgFLFhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jun 2020 01:37:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:34928 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbgFLFhu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 01:37:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6BA98AF19;
        Fri, 12 Jun 2020 05:37:52 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: branch for v5.8-rc1
Date:   Fri, 12 Jun 2020 07:37:47 +0200
Message-Id: <20200612053747.13750-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.8b-rc1-tag

xen: branch for v5.8-rc1

It contains the following patches:

- several smaller cleanups

- a fix for a Xen guest regression with CPU offlining

- a small fix in the xen pvcalls backend driver

- an update of MAINTAINERS


Thanks.

Juergen

 MAINTAINERS                                 |  4 +--
 drivers/pci/xen-pcifront.c                  | 27 ++++++--------
 drivers/xen/Kconfig                         |  4 +++
 drivers/xen/cpu_hotplug.c                   |  8 ++---
 drivers/xen/platform-pci.c                  |  2 +-
 drivers/xen/pvcalls-back.c                  |  5 +--
 drivers/xen/xen-pciback/conf_space.c        | 16 ++++-----
 drivers/xen/xen-pciback/conf_space_header.c | 44 ++++++++---------------
 drivers/xen/xen-pciback/conf_space_quirks.c |  6 ++--
 drivers/xen/xen-pciback/pci_stub.c          | 38 +++++++++-----------
 drivers/xen/xen-pciback/pciback.h           |  2 --
 drivers/xen/xen-pciback/pciback_ops.c       | 55 +++++++++--------------------
 drivers/xen/xen-pciback/vpci.c              | 10 +++---
 drivers/xen/xenbus/xenbus_probe.c           | 11 +++---
 14 files changed, 90 insertions(+), 142 deletions(-)

Bjorn Helgaas (2):
      xen-pciback: Use dev_printk() when possible
      xenbus: Use dev_printk() when possible

Boris Ostrovsky (2):
      xen/cpuhotplug: Fix initial CPU offlining for PV(H) guests
      xen/pci: Get rid of verbose_request and use dev_dbg() instead

Deep Shah (1):
      MAINTAINERS: Update PARAVIRT_OPS_INTERFACE and VMWARE_HYPERVISOR_INTERFACE

Juergen Gross (1):
      xen/pvcalls-back: test for errors when calling backend_connect()

Rikard Falkeborn (1):
      xen-platform: Constify dev_pm_ops

Roger Pau Monne (2):
      xen: expand BALLOON_MEMORY_HOTPLUG description
      xen: enable BALLOON_MEMORY_HOTPLUG by default

YueHaibing (1):
      xen/pvcalls: Make pvcalls_back_global static
